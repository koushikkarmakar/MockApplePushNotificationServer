import Foundation
import Telegraph

typealias JSON = [String: Any]

class ServerManager {

    private let server = Server()
    let pushEndpoint = "/simulatorPush"

    func startServer() {
        do {
            try server.start(port: 8081, interface: "localhost")
            setupPushEndpoint()
        } catch {
            print("Error starting mock server" + error.localizedDescription)
        }
    }

    private func setupPushEndpoint() {
        server.route(.POST, pushEndpoint)  {[weak self] request in
            self?.handlePayload(request: request)
        }
    }

    private func handlePayload(request: HTTPRequest) -> HTTPResponse {
        guard let serializedObject = try? JSONSerialization.jsonObject(with: Data(request.body), options: [.allowFragments]),
            let json = serializedObject as? JSON,
            let simId = json["simulatorId"] as? String,
            let appBundleId = json["appBundleId"] as? String,
            let payload = json["pushPayload"] as? JSON

            else {
                return HTTPResponse.init(.badRequest, headers: .empty, content: "Bad Request")
            }

        if let pushFileUrl = self.createTemporaryPushFile(payload: payload) {
                let command = "xcrun simctl push \(simId) \(appBundleId) \(pushFileUrl.path)"
                self.run(command: command)
                
                do {
                    try FileManager.default.removeItem(at: pushFileUrl)
                } catch {
                    print("Error removing file!")
                }

                return HTTPResponse(.ok, headers: .empty, content: "Ran command: \(command)")
            } else {
                return HTTPResponse(.internalServerError, headers: .empty, content: "Internal Server Error")
            }
    }
    
    private func createTemporaryPushFile(payload: JSON) -> URL? {
        let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tempFilename = ProcessInfo().globallyUniqueString + ".apns"
        let tempFileURL = tempDirectoryURL.appendingPathComponent(tempFilename)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
            try jsonData.write(to: tempFileURL, options: .atomic)
        } catch {
            print("Error writing temporary file!")
            return nil
        }
        return tempFileURL
    }

    func run(command: String) {
        let task = Process()
        let pipe = Pipe()
        task.arguments = ["-c", String(format:"%@", command)]
        task.standardOutput = pipe
        task.launchPath = "/bin/zsh"
        let data = pipe.fileHandleForReading
        task.launch()
        
        guard let readDataToEnd = try? data.readToEnd() else {
            print("Error")
            return
        }

        if let result = NSString(data: readDataToEnd, encoding: String.Encoding.utf8.rawValue) {
            print(result as String)
        }
        else {
            print("Error")
        }
    }
}
