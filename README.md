# [activsy](https://pub.dev/packages/activsy)

reacts when there are no user activities in your application

## Installation

```yaml
dependencies:
  activsy: ^1.0.3
```

# Usage

```dart
void main() {
  Activsy.initialize(waiTime: 10, onTimeOut: () {
    /// perform operation
    /// call the start to continue monitoring 
  }); 
  runApp(const MyApp());
}
```

```dart
ActivsyWidget(
    detectedMouseAction: false,
    builder: (context) {
        return MaterialApp(
             title: 'Flutter Demo',
             theme: ThemeData(primarySwatch: Colors.blue,),
             home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
    },
)
```

can also intercept interaction events, just implement the  ```onEvent(PointerEvent)``` method

```dart
ActivsyWidget(
    onEvent: (_){},
    builder: (context) {...},
)
```

After the ```onTimeOut``` method call the monitoring is terminated

<img src="/demo.gif" width="240" height="480">

| Functions And Attributes | Description                                                                                                                                                                     |
|--------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| start                    | To monitor user interaction with the application just call `Activsy.start()`. Can be called multiple times but if monitoring is already active nothing happens                  |
| stop                     | Ends monitoring `Activsy.reset()`. Can be called multiple times                                                                                                                 |
| reset                    | Restart monitoring `Activsy.reset()`, he calls `start()` and then `stop()`. This method also to modify the waiting time:  `Activsy.updateTime(waiTime: 60)`                     |
| forceTimeOut             | Triggers the onTimeOut method at any point in the application  `Activsy.forceTimeOut()`. There are several reasons to trigger the noActivity method before the stipulated timer |
| isInitialized            | true returns if the setup was made                                                                                                                                              |
| isActive                 | true returns if monitoring this active                                                                                                                                          |

**Note**: call the functions after the **config** method otherwise you will throw an exception

# Support

You liked this package? then give it a star. If you want to help then:

* Start this repository
* Send a Pull Request with new features
* Share this package
* Create issues if you find a Bug or want to suggest something
