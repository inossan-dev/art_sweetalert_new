# Art Sweet Alert New

An enhanced Flutter package for creating beautiful, customizable, and animated alert dialogs. This library is an improved version of the original [ArtSweetAlert](https://pub.dev/packages/art_sweetalert "A beautiful, responsive, customizable, accessible replacement, easy use for flutter popup boxes. Both supported ios and android.") package, offering better customization options, smoother animations, and a more modern design approach.

## Features

- **Five Alert Types**: Success, Error, Warning, Info, and Question alerts with distinctive icons
- **Smooth Animations**: Elegant scale and fade animations with customizable durations
- **Highly Customizable**: Flexible styling options for colors, sizes, and layouts
- **Modern Design**: Clean, professional looking alerts that follow material design principles
- **Responsive**: Adapts seamlessly to different screen sizes
- **Easy to Use**: Simple API for quick implementation
- **Barrier Control**: Optional tap-outside-to-dismiss functionality

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  art_sweetalert_new: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Basic Usage

```dart
import 'package:art_sweetalert_new/art_sweetalert_new.dart';

// Show a simple success alert
ArtSweetAlert.show(
  context: context,
  title: Text('Success!'),
  type: ArtAlertType.success,
);

// Show an alert with custom actions
ArtSweetAlert.show(
  context: context,
  title: Text('Confirm Action'),
  content: Text('Are you sure you want to proceed?'),
  type: ArtAlertType.question,
  actions: [
    ArtAlertButton(
      onPressed: () => Navigator.pop(context, false),
      child: Text('Cancel'),
      backgroundColor: Colors.grey,
    ),
    ArtAlertButton(
      onPressed: () => Navigator.pop(context, true),
      child: Text('Confirm'),
    ),
  ],
);
```

## Customization Options

### Alert Types
- `ArtAlertType.success`: Green checkmark icon
- `ArtAlertType.error`: Red X icon
- `ArtAlertType.warning`: Orange exclamation mark
- `ArtAlertType.info`: Blue information icon
- `ArtAlertType.question`: Blue question mark icon

### Style Customization
```dart
ArtSweetAlert.show(
  context: context,
  title: Text('Custom Style'),
  backgroundColor: Colors.grey[100],
  borderRadius: 12.0,
  iconSize: 100.0,
  animationDuration: Duration(milliseconds: 800),
  padding: EdgeInsets.all(32),
  barrierDismissible: false,
);
```

### Button Customization
```dart
ArtAlertButton(
  onPressed: () {},
  child: Text('Custom Button'),
  backgroundColor: Colors.purple,
  textColor: Colors.white,
  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  elevation: 2,
);
```

## Improvements Over Original Package

- Enhanced animation system with smoother transitions
- More customization options for alert styling
- Improved icon designs with better visual feedback
- Better type safety and null safety support
- Modernized API design
- Improved performance and reduced package size
- Better error handling and debugging support

## Requirements

- Flutter SDK: >=2.17.0
- Dart SDK: >=2.17.0

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## Advanced Customization

### Custom Icons
You can customize the appearance of alert icons by modifying the animation duration and size:

```dart
ArtSweetAlert.show(
  context: context,
  type: ArtAlertType.success,
  iconSize: 120.0,
  animationDuration: Duration(milliseconds: 800),
);
```

### Dialog Customization
Create fully customized dialogs with your own widgets:

```dart
ArtSweetAlert.show(
  context: context,
  title: Column(
    children: [
      Icon(Icons.cloud_done, size: 48),
      SizedBox(height: 8),
      Text('Custom Header'),
    ],
  ),
  content: Container(
    padding: EdgeInsets.all(16),
    child: YourCustomWidget(),
  ),
);
```

### Theme Integration
The alert dialog automatically integrates with your app's theme:

```dart
ArtSweetAlert.show(
  context: context,
  title: Text('Themed Alert'),
  backgroundColor: Theme.of(context).cardColor,
  actions: [
    ArtAlertButton(
      child: Text('OK'),
      backgroundColor: Theme.of(context).primaryColor,
    ),
  ],
);
```

## Handling Responses

### Basic Response Handling
```dart
final response = await ArtSweetAlert.show(
  context: context,
  title: Text('Delete Item'),
  content: Text('Are you sure?'),
  type: ArtAlertType.warning,
  actions: [
    ArtAlertButton(
      onPressed: () => Navigator.pop(context, false),
      child: Text('Cancel'),
    ),
    ArtAlertButton(
      onPressed: () => Navigator.pop(context, true),
      child: Text('Delete'),
      backgroundColor: Colors.red,
    ),
  ],
);

if (response == true) {
  // User confirmed deletion
} else {
  // User canceled or dismissed the dialog
}
```

### Multiple Action Handling
```dart
enum UserChoice { approve, reject, review }

final choice = await ArtSweetAlert.show<UserChoice>(
  context: context,
  title: Text('Review Document'),
  type: ArtAlertType.question,
  actions: [
    ArtAlertButton(
      onPressed: () => Navigator.pop(context, UserChoice.approve),
      child: Text('Approve'),
      backgroundColor: Colors.green,
    ),
    ArtAlertButton(
      onPressed: () => Navigator.pop(context, UserChoice.reject),
      child: Text('Reject'),
      backgroundColor: Colors.red,
    ),
    ArtAlertButton(
      onPressed: () => Navigator.pop(context, UserChoice.review),
      child: Text('Need Review'),
      backgroundColor: Colors.orange,
    ),
  ],
);
```

## Properties

### ArtSweetAlert
| Property | Type | Description |
|----------|------|-------------|
| title | Widget | The title widget of the alert dialog |
| content | Widget? | Optional content widget below the title |
| type | ArtAlertType? | The type of alert (success, error, etc.) |
| actions | List<Widget>? | Optional list of action buttons |
| padding | EdgeInsetsGeometry | Internal padding of the dialog |
| iconSize | double | Size of the alert type icon |
| animationDuration | Duration | Duration of entrance/exit animations |
| barrierDismissible | bool | Whether tapping outside dismisses the dialog |
| backgroundColor | Color | Background color of the dialog |
| borderRadius | double | Border radius of the dialog corners |

### ArtAlertButton
| Property | Type | Description |
|----------|------|-------------|
| child | Widget | The content of the button |
| onPressed | VoidCallback? | Callback when button is pressed |
| backgroundColor | Color | Background color of the button |
| textColor | Color | Text color of the button |
| padding | EdgeInsetsGeometry | Internal padding of the button |
| elevation | double | Elevation/shadow of the button |

## Credits

This package is based on the original [art_sweetalert](https://pub.dev/packages/art_sweetalert "A beautiful, responsive, customizable, accessible replacement, easy use for flutter popup boxes. Both supported ios and android.") package and has been enhanced with modern Flutter features and improved flexibility while maintaining its familiar API. We extend our gratitude to the original authors for their foundational work.

### Maintainers
- [Innocent N'GUESSAN]
- [[github profile](https://github.com/inossan-dev)]

## License

This project is licensed under the MIT License - see the LICENSE file for details.