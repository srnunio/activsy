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

or

void main() {
  Activsy.config(seconds: 10, noActivity: () async {
    /// perform operation
    /// call the start to continue monitoring 
  }).init();
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

can also intercept interaction events, just implement the  ```onEvent(PointerEvent)``` method

```dart
ActivsyWidget( 
  onEvent: (_){},
  builder: (ctx) {...},
)
```

After the ```onActivity``` method call the monitoring is terminated

To monitor user interaction with the application just call: ```Activsy.start()```


start and set the timer
```dart
Activsy.start()
```
cancel the timer
```dart
Activsy.cancel()
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

# Support
You liked this package? then give it a star. If you want to help then:

* Start this repository
* Send a Pull Request with new features
* Share this package
* Create issues if you find a Bug or want to suggest something
