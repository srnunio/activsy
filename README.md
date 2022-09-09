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
  Activsy.config(seconds: 10, noActivity: () async {
    /// perform operation
    /// call the start to continue monitoring 
  });
  runApp(const MyApp());
}
```

```dart
ActivsyWidget(
  detectedMouseAction: false,
  builder: (ctx) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  },
)
```

After the ```onActivity``` method call the monitoring is terminated

To monitor user interaction with the application just call: ```Activsy.startTimer()```


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
