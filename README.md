
## filter_list Plugin 
[![Codemagic build status](https://api.codemagic.io/apps/5e5f9812018eb900168eef48/5e5f9812018eb900168eef47/status_badge.svg)](https://codemagic.io/apps/5e5f9812018eb900168eef48/5e5f9812018eb900168eef47/latest_build)
![GitHub last commit](https://img.shields.io/github/last-commit/Thealphamerc/flutter_plugin_filter_list) 
[![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/Thealphamerc/flutter_plugin_filter_list)
![GitHub](https://img.shields.io/github/license/TheAlphamerc/flutter_plugin_filter_list) 
[![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/Thealphamerc/flutter_plugin_filter_list.svg)](https://github.com/Thealphamerc/flutter_plugin_filter_list)
[![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_plugin_filter_list?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%flutter_plugin_filter_list) 
![GitHub forks](https://img.shields.io/github/forks/TheAlphamerc/flutter_plugin_filter_list?style=social)

[![pub package](https://img.shields.io/pub/v/filter_list?color=blue)](https://pub.dev/packages/filter_list) 
[![Likes](https://badges.bar/filter_list/likes)](https://pub.dev/packages/flutter_plugin_filter_list/score)
[![Popularity](https://badges.bar/filter_list/popularity)](https://pub.dev/packages/filter_list/score)
[![Pub points](https://badges.bar/flutter_week_view/pub%20points)](https://pub.dev/packages/filter_list/score)

FilterList is a flutter package which provide utility to search/filter on the basis of single/multiple selection from provided dynamic list.

## Download Demo App ![GitHub All Releases](https://img.shields.io/github/downloads/Thealphamerc/flutter_plugin_filter_list/total?color=green)
<a href="https://github.com/TheAlphamerc/flutter_plugin_filter_list/releases/download/v0.0.5/app-release.apk"><img src="https://playerzon.com/asset/download.png" width="200"></img></a>

## Data flow
* Invoke method `FilterListDialog.display()` to display filter dialog.
* Make selection from list.
* Click `All` button to select all text from list.
* Click `Reset` button to make all text unselected.
* Click `Apply` buton to return selected list of strings.
* On `close` icon clicked it close dialog and return null value.
* Without making any selection `Apply` button is pressed it will return empty list of items.

## Getting Started
### 1. Add library to your pubspec.yaml



```yaml

dependencies:
  filter_list: ^0.0.9

```

### 2. Import library in dart file

```dart
import package:filter_list/filter_list.dart';
```


### 3. How to use FilterList


#### Create a list of Strings
```dart
  List<String> countList = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
    "Eleven",
    "Tweleve",
    "Thirteen",
    "Fourteen",
    "Fifteen",
    "Sixteen",
    "Seventeen",
    "Eighteen",
    "Nineteen",
    "Twenty"
  ];
  List<String>? selectedCountList = [];
```
#### Create a function and call `FilterListDialog.display()` on button clicked
```dart
  void _openFilterDialog() async {
    await FilterListDialog.display<String>(
      context,
      listData: countList,
      selectedListData: selectedCountList,
      height: 480,
      headlineText: "Select Count",
      searchFieldHintText: "Search Here",
      choiceChipLabel: (item) {
        return item;
      },
      validateSelectedItem: (list, val) {
          return list!.contains(val);
      },
      onItemSearch: (list, text) {
          if (list!.any((element) =>
              element.toLowerCase().contains(text.toLowerCase()))) {
            return list!
                .where((element) =>
                    element.toLowerCase().contains(text.toLowerCase()))
                .toList();
          }
          else{
            return [];
          }
        },
      onApplyButtonClick: (list) {
        if (list != null) {
          setState(() {
            selectedCountList = List.from(list);
          });
        }
        Navigator.pop(context);
      });
  }
```
#### Call `_openFilterDialog` function on `floatingActionButton` pressed to display filter dialog

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openFilterDialog,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        body: selectedCountList == null || selectedCountList!.length == 0
            ? Center(
                child: Text('No text selected'),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedCountList![index]!),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: selectedCountList!.length));
  }
```
#### How to use `FilterListWidget`.

```dart
class User {
  final String? name;
  final String? avatar;
  User({this.name, this.avatar});
}



class FilterPage extends StatelessWidget {
  FilterPage({Key? key}) : super(key: key);
  List<User> userList = [
    User(name: "Jon", avatar: ""),
    User(name: "Ethel ", avatar: ""),
    User(name: "Elyse ", avatar: ""),
    User(name: "Nail  ", avatar: ""),
    User(name: "Valarie ", avatar: ""),
    User(name: "Lindsey ", avatar: ""),
    User(name: "Emelyan ", avatar: ""),
    User(name: "Carolina ", avatar: ""),
    User(name: "Catherine ", avatar: ""),
    User(name: "Stepanida  ", avatar: ""),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter List Widget Example "),
      ),
      body: SafeArea(
        child: FilterListWidget<User>(
          listData: userList,
          hideHeaderText: true,
          onApplyButtonClick: (list) {
            if (list != null) {
              print("Selected items count: ${list!.length}");
            }
          },
          label: (item) {
            /// Used to print text on chip
            return item!.name;
          },
          validateSelectedItem: (list, val) {
            ///  identify if item is selected or not
            return list!.contains(val);
          },
          onItemSearch: (list, text) {
            /// When text change in search text field then return list containing that text value
            ///
            ///Check if list has value which matchs to text
            if (list!.any((element) =>
                element.name.toLowerCase().contains(text.toLowerCase()))) {
              /// return list which contains matches
              return list!
                  .where((element) =>
                      element.name.toLowerCase().contains(text.toLowerCase()))
                  .toList();
            }
            else{
              return [];
            }
          },
        ),
      ),
    );
  }
}
```
## Screenshots


No selected text from list |  FilterList widget        |  Make selection           |  Selected text from list
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_2.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_3.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_4.jpg?raw=true)|

Hidden close Icon    |  Hidden text field     |  Hidden header text    |  Hidden full header
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_5.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_6.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_7.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_8.jpg?raw=true)|

Customised control button |Customised selected text |Customised unselected text  |Customised text field background color
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_9.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_10.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_12.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_11.jpg?raw=true)|


 Customised Choice chip|Customised Choice chip |FilterListWidget|FilterListWidget 
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_15.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_17.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_14.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_16.jpg?raw=true)|



### Parameters and Value

 `height` Type **&#8594;** **double**
* Set height of filter dialog.

`width` Type **&#8594;** **double**
* Set width of filter dialog.

`borderRadius` Type **&#8594;** **double**
* Set border radius of filter dialog.

`listData` Type **&#8594;** **List\<dynamic>()**
* Populate filter dialog with text list.

`selectedListData` Type **&#8594;** **List\<dynamic>()**
* Marked selected text in filter dialog.

`choiceChipLabel` Type  **&#8594;** **String Function(dynamic)**
* Display text on choice chip.

`validateSelectedItem` Type  **&#8594;** **bool Function(List<T> list, T item)** 
* identifies weather a item is selecte or not

`onItemSearch` Type **&#8594;** **List<T> Function(List<T> list, String text)**
* filter list on the basis of search field text

`headlineText` Type **&#8594;** **String**
* Set header text of filter dialog.
 
`hideHeaderText` TYPE **&#8594;** **bool**
* If `true` then it will hide the header text

`searchFieldHintText` Type **&#8594;** **String**
* Set hint text in search field.

`hideSelectedTextCount` Type **&#8594;** **bool**
* Hide selected text count.

`hideSearchField` Type **&#8594;** **bool**
* Hide search text field.

`hideCloseIcon` Type **&#8594;** **bool**
* Hide close Icon.

`hideheader` Type **&#8594;** **bool**
* Hide complete header section from filter dialog.

`closeIconColor` Type **&#8594;** **Color**
* set color of close Icon.

`headerTextColor` Type **&#8594;** **Color**
* Set color of header text.

`applyButonTextBackgroundColor` Type **&#8594;** **Color**
* Set background color of apply button.

`selectedChipTextStyle` Type  **&#8594;** **TextStyle**
* TextStyle for chip when selected

`unselectedChipTextStyle` Type  **&#8594;** **TextStyle**
* TextStyle for chip when not selected

`controlButtonTextStyle` Type  **&#8594;** **TextStyle**
* TextStyle for `All` and `Reset` button text

`applyButtonTextStyle` Type  **&#8594;** **TextStyle**
* TextStyle for `Apply` button

`headerTextStyle` Type  **&#8594;** **TextStyle**
* TextStyle for header text

`searchFieldTextStyle` Type  **&#8594;** **TextStyle**
* TextStyle for search field text

`choiceChipBuilder` Type  **&#8594;** **TextStyle**
* The `choiceChipBuilder` is a builder to design custom choice chip.

`selectedTextBackgroundColor` Type **&#8594;** **Color**
* Set background color of selected text field.

`unselectedTextbackGroundColor` Type **&#8594;** **Color**
* Set background color of unselected text field.

`searchFieldBackgroundColor` Type **&#8594;** **Color**
* Set background color of Search field.

`backgroundColor` Type **&#8594;** **Color**
* Set background color of filter color.

`onApplyButtonClick` Type  **&#8594;** **Function(List<dynamic>)**
 * Returns list of items when apply button is clicked 

## Flutter plugins
Plugin Name        | Stars        
:-------------------------|-------------------------
|[Empty widget](https://github.com/TheAlphamerc/empty_widget) |[![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/empty_widget?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%empty_widget)
|[Add Thumbnail](https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail) |[![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_plugin_add_thumbnail?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%flutter_plugin_add_thumbnail)


## Pull Requests

I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request.

## Created & Maintained By

[Sonu Sharma](https://github.com/TheAlphamerc) ([Twitter](https://www.twitter.com/TheAlphamerc)) ([Youtube](https://www.youtube.com/user/sonusharma045sonu/))
([Insta](https://www.instagram.com/_sonu_sharma__))  ![Twitter Follow](https://img.shields.io/twitter/follow/thealphamerc?style=social)

> If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of :coffee:
>

> * <a href="https://www.buymeacoffee.com/thealphamerc"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" width="200"></a>
> * [PayPal](https://www.paypal.me/TheAlphamerc/)


## Visitors Count

<img align="left" src = "https://profile-counter.glitch.me/flutter_plugin_filter_list/count.svg" alt ="Loading">


