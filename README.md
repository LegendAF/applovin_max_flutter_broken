# applovin_max_flutter_broken

Banner ads are not acting the same on `3.27` (beta) as it does on `3.24.4` (stable) and before. We have only seen this behavior on iOS so far.

## Setup to replicate

- Find and replace `com.example.broken` across the whole project with a valid bundle id
- Go to lib/main.dart
  - line 50 and replace `VALID_SDK_KEY` with your sdk key
  - line 101 and replace `VALID_AD_UNIT_ID` with your ad unity id (iOS)
- Go to `ios/Runner/Info.plist` and replace `VALID_GAD_ID` with your id
- In Xcode assign a dev team to sign
- Run the app as if it were any other Flutter app

## Results

- On 3.27 you will see the the text inside of the overlay disappears when you tap the (+) button but the ad remains. We are applying an Opacity to them.

## Expected Results

- The banner ad also disappears with the text. This works on 3.24 and before.
