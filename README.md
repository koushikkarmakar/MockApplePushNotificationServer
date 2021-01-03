# MockApplePushNotificationServer
REST API USAGE GUIDE:

JSON STRUCTURE:

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{ "simulatorId": siumlatorID, "appBundleId": appBundleID, "pushPayload": {"aps": { "alert": { "title": "Push Notification", "subtitle": "Test Push Notifications", "body" : "Any Message"}}}}' \
  http://localhost:8081/simulatorPush
```

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
