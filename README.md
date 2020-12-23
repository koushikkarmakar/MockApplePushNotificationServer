# MockApplePushNotificationServer
REST API USAGE GUIDE:

JSON STRUCTURE:

```
{
    "simulatorId": "E2A81905-F6C2-480D-91EA-A92C331F725F",
    "appBundleId": "de.westwing.shop",
    "pushPayload": {"aps": {
        "alert": {
            "title": "Push Notification",
            "subtitle": "Test Push Notifications",
            "body" : "Westwing PN Test"
        }
    }}
}
```
