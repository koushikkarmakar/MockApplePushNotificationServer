# MockApplePushNotificationServer
REST API USAGE GUIDE:

JSON STRUCTURE:

```
{
    "simulatorId": siumlatorID,
    "appBundleId": appBundleID,
    "pushPayload": {"aps": {
        "alert": {
            "title": "Push Notification",
            "subtitle": "Test Push Notifications",
            "body" : "Any Message"
        }
    }}
}
```
