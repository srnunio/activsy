# activsy

reacts when there are no user activities in your application

## Installation

```yaml
dependencies:
  activsy: ^1.0.1
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

After the ```onActivity``` method call the monitoring is terminated

<img src="/demo.gif" width="240" height="480">

| Functions And Attributes  | Description                                                                                                                                              |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| init             | Starts monitoring after setting up. Uses the method `start()`                                                                                            |
| start            | To monitor user interaction with the application just call `Activsy.start()`. Can be called multiple times but if monitoring is already active nothing happens                                    |
| cancel           | Ends monitoring `Activsy.reset()`. Can be called multiple times                                                                                          |
| reset            | Restart monitoring `Activsy.reset()`, he calls `start()` and then `cancel()`. This method also to modify the waiting time:  `Activsy.reset(seconds: 60)` |
| trigger          | Triggers the onActivity method at any point in the application  `Activsy.trigger()`. There are several reasons to trigger the noActivity method before the stipulated timer                                                                    |
| isInitialized    | true returns if the setup was made                                                                                                                       |
| isActive         | true returns if monitoring this active                                                                                                                   |

**Note**: call the functions after the **config** method otherwise you will throw an exception

# Support

You liked this package? then give it a star. If you want to help then:

* Start this repository
* Send a Pull Request with new features
* Share this package
* Create issues if you find a Bug or want to suggest something
