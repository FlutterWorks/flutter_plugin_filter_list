part of 'filter_list_dialog.dart';

/// {@tool snippet}
///
/// This example shows how to use [FilterListWidget]
///
//  ``` dart
/// FilterListWidget(
///   listData: ["One", "Two", "Three", "Four","five","Six","Seven","Eight","Nine","Ten"],
///   selectedListData: ["One", "Three", "Four","Eight","Nine"],
///   hideheaderText: true,
///   height: MediaQuery.of(context).size.height,
///   // hideheaderText: true,
///   onApplyButtonClick: (list) {
///     Navigator.pop(context, list);
///   },
///   label: (item) {
///     /// Used to print text on chip
///     return item;
///   },
///   validateSelectedItem: (list, val) {
///     ///  identify if item is selected or not
///     return list.contains(val);
///   },
///   onItemSearch: (list, text) {
///     /// When text change in search text field then return list containing that text value
///     ///
///     ///Check if list has value which matchs to text
///     if (list.any((element) =>
///         element.toLowerCase().contains(text.toLowerCase()))) {
///       /// return list which contains matches
///       return list
///           .where((element) =>
///               element.toLowerCase().contains(text.toLowerCase()))
///           .toList();
///     }
///   },
/// )
/// ```
/// {@end-tool}
///

typedef ValidateSelectedItem<T> = bool Function(List<T> list, T item);
typedef OnApplyButtonClick<T> = Function(List<T> list);
typedef ChoiceChipBuilder<T> = Widget Function(
    BuildContext context, T item, bool iselected);

class FilterListWidget<T> extends StatefulWidget {
  const FilterListWidget(
      {Key key,
      this.height,
      this.width,
      this.listData,
      @required this.validateSelectedItem,
      @required this.label,
      @required this.onItemSearch,
      this.selectedListData,
      this.borderRadius = 20,
      this.headlineText = "Select",
      this.onApplyButtonClick,
      this.searchFieldHintText = "Search here",
      this.hideSelectedTextCount = false,
      this.hideSearchField = false,
      this.hidecloseIcon = true,
      this.hideHeader = false,
      this.hideheaderText = false,
      this.closeIconColor = Colors.black,
      this.headerTextColor = Colors.black,
      this.applyButonTextColor = Colors.white,
      this.applyButonTextBackgroundColor = Colors.blue,
      this.allResetButonColor = Colors.blue,
      this.selectedTextColor = Colors.white,
      this.backgroundColor = Colors.white,
      this.unselectedTextColor = Colors.black,
      this.searchFieldBackgroundColor = const Color(0xfff5f5f5),
      this.selectedTextBackgroundColor = Colors.blue,
      this.unselectedTextbackGroundColor = const Color(0xfff8f8f8),
      this.enableOnlySingleSelection = false,
      this.choiceChipBuilder})
      : assert(validateSelectedItem != null, ''' 
            validateSelectedItem callback can not be null

            Tried to use below callback to ignore error.

             validateSelectedItem: (list, val) {
                  return list.contains(val);
             }
            '''),
        super(key: key);
  final double height;
  final double width;
  final double borderRadius;

  /// Pass list containing all data which neeeds to filter
  final List<T> listData;

  /// pass selected list of object
  /// every object on selecteListData should be present in list data
  final List<T> selectedListData;
  final Color closeIconColor;
  final Color headerTextColor;
  final Color backgroundColor;
  final Color applyButonTextColor;
  final Color applyButonTextBackgroundColor;
  final Color allResetButonColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Color searchFieldBackgroundColor;
  final Color selectedTextBackgroundColor;
  final Color unselectedTextbackGroundColor;

  final String headlineText;
  final String searchFieldHintText;
  final bool hideSelectedTextCount;
  final bool hideSearchField;
  final bool hidecloseIcon;
  final bool hideHeader;
  final bool hideheaderText;
  final bool enableOnlySingleSelection;

  /// Return list of all selected items
  final OnApplyButtonClick<T> onApplyButtonClick;

  /// identifies weather a item is selecte or not
  final ValidateSelectedItem<T> validateSelectedItem;

  /// filter list on the basis of search field text
  final List<T> Function(List<T> list, String text) onItemSearch;

  /// Print text on chip
  final String Function(T item) label;

  /// Builder for custom choice chip
  final ChoiceChipBuilder choiceChipBuilder;

  @override
  _FilterListWidgetState<T> createState() => _FilterListWidgetState<T>();
}

class _FilterListWidgetState<T> extends State<FilterListWidget<T>> {
  List<T> _listData;
  List<T> _selectedListData = <T>[];

  @override
  void initState() {
    _listData = widget.listData == null ? <T>[] : List.from(widget.listData);
    _selectedListData = widget.selectedListData == null
        ? <T>[]
        : List<T>.from(widget.selectedListData);
    super.initState();
  }

  bool showApplyButton = false;

  Widget _body() {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              widget.hideHeader ? SizedBox() : _header(),
              widget.hideSelectedTextCount
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        '${_selectedListData.length} selected items',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
                child: SingleChildScrollView(
                  child: Wrap(
                    children: _buildChoiceList(),
                  ),
                ),
              )),
            ],
          ),
          _controlButtonSection()
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 15,
            color: Color(0x12000000),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: widget.hideheaderText
                        ? Container()
                        : Text(
                            widget.headlineText,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    fontSize: 18,
                                    color: widget.headerTextColor),
                          ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    onTap: () {
                      Navigator.pop(context, null);
                    },
                    child: widget.hidecloseIcon
                        ? SizedBox()
                        : Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: widget.closeIconColor),
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.close,
                              color: widget.closeIconColor,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            widget.hideSearchField
                ? SizedBox()
                : SizedBox(
                    height: 10,
                  ),
            widget.hideSearchField
                ? SizedBox()
                : SearchFieldWidget(
                    searchFieldBackgroundColor:
                        widget.searchFieldBackgroundColor,
                    searchFieldHintText: widget.searchFieldHintText,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          _listData = widget.listData;
                          return;
                        }
                        _listData =
                            widget.onItemSearch(widget.listData, value) ?? [];
                      });
                    },
                  )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChoiceList() {
    List<Widget> choices = [];
    _listData.forEach(
      (item) {
        var selectedText = widget.validateSelectedItem(_selectedListData, item);
        choices.add(
          ChoiceChipWidget(
            choiceChipBuilder: widget.choiceChipBuilder,
            item: item,
            onSelected: (value) {
              setState(
                () {
                  if (widget.enableOnlySingleSelection) {
                    _selectedListData.clear();
                    _selectedListData.add(item);
                  } else {
                    selectedText
                        ? _selectedListData.remove(item)
                        : _selectedListData.add(item);
                  }
                },
              );
            },
            selected: selectedText,
            selectedTextColor: widget.selectedTextColor,
            selectedTextBackgroundColor: widget.selectedTextBackgroundColor,
            unselectedTextBackgroundColor: widget.unselectedTextbackGroundColor,
            unselectedTextColor: widget.unselectedTextColor,
            text: widget.label(item),
          ),
        );
      },
    );
    choices.add(
      SizedBox(
        height: 70,
        width: MediaQuery.of(context).size.width,
      ),
    );
    return choices;
  }

  Widget _controlButton({
    String label,
    Function onPressed,
    Color backgroundColor = Colors.transparent,
    Color textColor,
    double elevation = 0,
  }) {
    return TextButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          )),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          elevation: MaterialStateProperty.all(elevation),
          foregroundColor: MaterialStateProperty.all(
              textColor ?? Theme.of(context).buttonColor)),
      onPressed: onPressed,
      clipBehavior: Clip.antiAlias,
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontSize: 20, color: textColor ?? Theme.of(context).buttonColor),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _controlButtonSection() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 15,
                color: Color(0x12000000),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _controlButton(
                  label: "All",
                  onPressed: widget.enableOnlySingleSelection
                      ? null
                      : () {
                          setState(() {
                            _selectedListData = List.from(_listData);
                          });
                        },
                  textColor: widget.enableOnlySingleSelection
                      ? Theme.of(context).dividerColor
                      : widget.allResetButonColor),
              _controlButton(
                  label: "Reset",
                  onPressed: () {
                    setState(() {
                      _selectedListData.clear();
                    });
                  },
                  textColor: widget.allResetButonColor),
              _controlButton(
                label: "Apply",
                onPressed: () {
                  if (widget.onApplyButtonClick != null) {
                    widget.onApplyButtonClick(_selectedListData);
                  } else {
                    Navigator.pop(context, _selectedListData);
                  }
                },
                elevation: 5,
                textColor: widget.applyButonTextColor,
                backgroundColor: widget.applyButonTextBackgroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        child: Container(
          height: widget.height,
          width: widget.width,
          color: widget.backgroundColor,
          child: Stack(
            children: <Widget>[
              _body(),
            ],
          ),
        ),
      ),
    );
  }
}
