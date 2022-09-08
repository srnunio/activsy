# activsy
reacts when there are no user activities in your application

## Installation
```yaml
dependencies:
  activsy: ^1.0.0
```

# Usage

```dart
void main() {
  Activsy.config(seconds: 10, noActivity: (){});
  runApp(const MyApp());
}
```


```dart
ActivsyWidget(
  detectedMouseAction: true,
  builder: (ctx) {
    return MaterialApp(...);
  }
)
```
start and set the timer
```dart
Activsy.startTimer()
```
stop the timer
```dart
Activsy.stopTimer()
```
Restore timer

**Note**: From the timer reset it can also change the seconds it must wait before triggering the noActivity
```dart
Activsy.reset(seconds: 8);
```
There are several reasons to trigger the noActivity method before the stipulated timer
```dart
 Activsy.trigger()
```

**Note**: call the functions after the **config** method otherwise you will throw an exception
