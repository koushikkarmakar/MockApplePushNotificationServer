//
//  AppDelegate.swift
//  MockPushNotificationGenerator
//
//  Created by Koushik Karmakar on 14.12.20.
//  Copyright © 2020 Koushik Karmakar. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let serverManager = ServerManager()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        serverManager.startServer()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

