# MockApplePushNotificationServer
REST API USAGE GUIDE:

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{ "simulatorId": siumlatorID, "appBundleId": appBundleID, "pushPayload": {"aps": { "alert": { "title": "Push Notification", "subtitle": "Test Push Notifications", "body" : "Any Message"}}}}' \
  http://localhost:8081/simulatorPush
```
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
