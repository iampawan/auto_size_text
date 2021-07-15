part of auto_size_text;

/// Flutter widget that automatically resizes text to fit perfectly within its bounds.
///
/// All size constraints as well as maxLines are taken into account. If the text
/// overflows anyway, you should check if the parent widget actually constraints
/// the size of this widget.
class AutoSizeText extends StatefulWidget {
  // The default font size if none is specified.
  static const double _defaultFontSize = 14.0;

  final bool _isSelectableText;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// The color to use when painting the cursor.
  ///
  /// Defaults to the theme's `cursorColor` when null.
  final Color cursorColor;

  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double cursorHeight;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius cursorRadius;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final String data;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// Whether to enable user interface affordances for changing the text selection.
  ///
  /// For example, setting this to true will enable features such as long-pressing the TextField to select text and show the cut/copy/paste menu, and tapping to move the text caret.
  ///
  /// When this is false, the text selection cannot be adjusted by the user, text cannot be copied, and the user cannot paste into the text field from the clipboard.
  final bool enableInteractiveSelection;

  /// Defines the focus for this widget.
  ///
  /// Text is only selectable when widget is focused.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  final FocusNode focusNode;

  /// Synchronizes the size of multiple [AutoSizeText]s.
  ///
  /// If you want multiple [AutoSizeText]s to have the same text size, give all
  /// of them the same [AutoSizeGroup] instance. All of them will have the
  /// size of the smallest [AutoSizeText]
  final AutoSizeGroup group;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  final Locale locale;

  /// The maximum text size constraint to be used when auto-sizing text.
  ///
  /// Is being ignored if [presetFontSizes] is set.
  final double maxFontSize;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be resized according
  /// to the specified bounds and if necessary truncated according to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int maxLines;

  /// The minimum text size constraint to be used when auto-sizing text.
  ///
  /// Is being ignored if [presetFontSizes] is set.
  final double minFontSize;

  /// The minimum number of lines to occupy when the content spans fewer lines.
  ///
  /// If this is null (default), text container starts with enough vertical space
  /// for one line and grows to accommodate additional lines as they are entered.
  ///
  /// This can be used in combination with maxLines for a varying set of behaviors.
  ///
  /// If the value is set, it must be greater than zero.
  /// If the value is greater than 1, maxLines should also be set to either null or greater than this value.
  ///
  /// When maxLines is set as well, the height will grow between the indicated range of lines.
  /// When maxLines is null, it will grow as high as needed, starting from minLines.
  ///
  /// A few examples of behaviors possible with minLines and maxLines are as follows:
  /// These apply equally to `TextField`, `TextFormField`, `CupertinoTextField`, and `EditableText`.
  ///
  /// Input that always occupies at least 2 lines and has an infinite max. Expands vertically as needed.
  ///
  /// ```dart
  /// AutoSizeText(minLines: 2)
  /// ```
  /// OR
  /// ```
  /// AutoSizeText.rich(
  ///   TextSpan(children: ...),
  ///   minLines: 2,
  /// )
  /// ```
  ///
  /// Input whose height starts from 2 lines and grows up to 4 lines at which point
  /// the height limit is reached. If additional lines are entered it will scroll vertically.
  /// ```dart
  /// AutoSizeText(minLines: 2, maxLines: 4)
  /// ```
  /// OR
  /// ```
  /// AutoSizeText.rich(
  ///   TextSpan(children: ...),
  ///   minLines: 2,
  ///   maxLines: 4,
  /// )
  /// ```
  ///
  /// Defaults to null.
  final int minLines;

  /// {@macro flutter.widgets.editableText.onSelectionChanged}
  final SelectionChangedCallback onSelectionChanged;

  /// Called when the user taps on this selectable text.
  ///
  /// The selectable text builds a [GestureDetector] to handle input events like tap,
  /// to trigger focus requests, to move the caret, adjust the selection, etc.
  /// Handling some of those events by wrapping the selectable text with a competing
  /// GestureDetector is problematic.
  ///
  /// To unconditionally handle taps, without interfering with the selectable text's
  /// internal gesture detector, provide this callback.
  ///
  /// To be notified when the text field gains or loses the focus, provide a
  /// [focusNode] and add a listener to that.
  ///
  /// To listen to arbitrary pointer events without competing with the
  /// selectable text's internal gesture detector, use a [Listener].
  final GestureTapCallback onTap;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// If the text is overflowing and does not fit its bounds, this widget is
  /// displayed instead.
  final Widget overflowReplacement;

  /// Predefines all the possible font sizes.
  ///
  /// **Important:** PresetFontSizes have to be in descending order.
  final List<double> presetFontSizes;

  /// The ScrollPhysics to use when vertically scrolling the input.
  ///
  /// If not specified, it will behave according to the current platform.
  final ScrollPhysics scrollPhysics;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls selectionControls;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This will overwrite any of the semantics labels applied
  /// directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// Text(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  final String semanticsLabel;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool showCursor;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was
  /// unlimited horizontal space.
  final bool softWrap;

  /// The step size in which the font size is being adapted to constraints.
  ///
  /// The Text scales uniformly in a range between [minFontSize] and
  /// [maxFontSize].
  /// Each increment occurs as per the step size set in stepGranularity.
  ///
  /// Most of the time you don't want a stepGranularity below 1.0.
  ///
  /// Is being ignored if [presetFontSizes] is set.
  final double stepGranularity;

  /// The strut style to use. Strut style defines the strut, which sets minimum
  /// vertical layout metrics.
  ///
  /// Omitting or providing null will disable strut.
  ///
  /// Omitting or providing null for any properties of [StrutStyle] will result in
  /// default values being used. It is highly recommended to at least specify a
  /// font size.
  ///
  /// See [StrutStyle] for details.
  final StrutStyle strutStyle;

  /// If non-null, the style to use for this text.
  ///
  /// If the style's 'inherit' property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle style;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection textDirection;

  /// Sets the key for the resulting [Text] widget.
  ///
  /// This allows you to find the actual `Text` widget built by `AutoSizeText`.
  final Key textKey;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// This property also affects [minFontSize], [maxFontSize] and [presetFontSizes].
  ///
  /// The value given to the constructor as textScaleFactor. If null, will
  /// use the [MediaQueryData.textScaleFactor] obtained from the ambient
  /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
  final double textScaleFactor;

  /// The text to display as a [TextSpan].
  ///
  /// This will be null if [data] is provided instead.
  final TextSpan textSpan;

  /// Configuration of toolbar options.
  ///
  /// Paste and cut will be disabled regardless.
  ///
  /// If not set, select all and copy will be enabled by default.
  final ToolbarOptions toolbarOptions;

  /// Whether words which don't fit in one line should be wrapped.
  ///
  /// If false, the fontSize is lowered as far as possible until all words fit
  /// into a single line.
  final bool wrapWords;

  /// Creates a [AutoSizeText] widget.
  ///
  /// If the [style] argument is null, the text will use the style from the
  /// closest enclosing [DefaultTextStyle].
  const AutoSizeText(
    this.data, {
    Key key,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.group,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.wrapWords = true,
    this.overflow,
    this.overflowReplacement,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  })  : assert(data != null,
            'A non-null String must be provided to a AutoSizeText widget.'),
        textSpan = null,
        minLines = null,
        autofocus = false,
        showCursor = false,
        cursorWidth = 2.0,
        cursorHeight = null,
        cursorRadius = null,
        focusNode = null,
        cursorColor = null,
        enableInteractiveSelection = false,
        selectionControls = null,
        dragStartBehavior = DragStartBehavior.start,
        toolbarOptions = null,
        onTap = null,
        scrollPhysics = null,
        onSelectionChanged = null,
        _isSelectableText = false,
        super(key: key);

  /// Creates a [AutoSizeText] widget with a [TextSpan].
  const AutoSizeText.rich(
    this.textSpan, {
    Key key,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.group,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.wrapWords = true,
    this.overflow,
    this.overflowReplacement,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  })  : assert(textSpan != null,
            'A non-null TextSpan must be provided to a AutoSizeText.rich widget.'),
        data = null,
        minLines = null,
        autofocus = false,
        showCursor = false,
        cursorWidth = 2.0,
        cursorHeight = null,
        cursorRadius = null,
        focusNode = null,
        cursorColor = null,
        enableInteractiveSelection = false,
        selectionControls = null,
        dragStartBehavior = DragStartBehavior.start,
        toolbarOptions = null,
        onTap = null,
        scrollPhysics = null,
        onSelectionChanged = null,
        _isSelectableText = false,
        super(key: key);

  /// Creates a selectable [AutoSizeText] widget with a [TextSpan].
  const AutoSizeText.richSelectable(
    this.textSpan, {
    Key key,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.group,
    this.textAlign,
    this.textDirection,
    this.wrapWords = true,
    this.textScaleFactor,
    this.maxLines,
    this.minLines,
    this.autofocus = false,
    this.showCursor = false,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.focusNode,
    this.cursorColor,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.toolbarOptions,
    this.onTap,
    this.scrollPhysics,
    this.onSelectionChanged,
  })  : assert(textSpan != null,
            'A non-null TextSpan must be provided to a AutoSizeText.rich widget.'),
        data = null,
        locale = null,
        softWrap = null,
        overflow = null,
        overflowReplacement = null,
        semanticsLabel = null,
        _isSelectableText = true,
        super(key: key);

  /// Creates a selectable [AutoSizeText] widget.
  ///
  /// If the [style] argument is null, the text will use the style from the
  /// closest enclosing [DefaultTextStyle].
  const AutoSizeText.selectable(
    this.data, {
    Key key,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.group,
    this.textAlign,
    this.textDirection,
    this.wrapWords = true,
    this.textScaleFactor,
    this.maxLines,
    this.minLines,
    this.autofocus = false,
    this.showCursor = false,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.focusNode,
    this.cursorColor,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.toolbarOptions,
    this.onTap,
    this.scrollPhysics,
    this.onSelectionChanged,
  })  : assert(data != null,
            'A non-null String must be provided to a AutoSizeText widget.'),
        textSpan = null,
        locale = null,
        softWrap = null,
        overflow = null,
        overflowReplacement = null,
        semanticsLabel = null,
        _isSelectableText = true,
        super(key: key);

  @override
  _AutoSizeTextState createState() => _AutoSizeTextState();
}

class _AutoSizeTextState extends State<AutoSizeText> {
  @override
  void didUpdateWidget(AutoSizeText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.group != widget.group) {
      oldWidget.group?._remove(this);
      widget.group?._register(this);
    }
  }

  @override
  void dispose() {
    if (widget.group != null) {
      widget.group._remove(this);
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.group != null) {
      widget.group._register(this);
    }
  }

  void _sanityCheck(TextStyle style, int maxLines) {
    if (!widget._isSelectableText) {
      assert(widget.overflow == null || widget.overflowReplacement == null,
          'Either overflow or overflowReplacement have to be null.');
    }
    assert(maxLines == null || maxLines > 0,
        'MaxLines has to be grater than or equal to 1.');
    assert(widget.key == null || widget.key != widget.textKey,
        'Key and textKey cannot be the same.');

    if (widget.presetFontSizes == null) {
      assert(widget.stepGranularity >= 0.1,
          'StepGranularity has to be greater than or equal to 0.1. It is not a good idea to resize the font with a higher accuracy.');
      assert(widget.minFontSize >= 0,
          'MinFontSize has to be greater than or equal to 0.');
      assert(widget.maxFontSize > 0, 'MaxFontSize has to be greater than 0.');
      assert(widget.minFontSize <= widget.maxFontSize,
          'MinFontSize has to be smaller or equal than maxFontSize.');
      assert(widget.minFontSize / widget.stepGranularity % 1 == 0,
          'MinFontSize has to be multiples of stepGranularity.');
      if (widget.maxFontSize != double.infinity) {
        assert(widget.maxFontSize / widget.stepGranularity % 1 == 0,
            'MaxFontSize has to be multiples of stepGranularity.');
      }
    } else {
      assert(widget.presetFontSizes.isNotEmpty,
          'PresetFontSizes has to be nonempty.');
    }
  }

  List _calculateFontSize(BoxConstraints size, TextStyle style, int maxLines) {
    var span = TextSpan(
      style: widget.textSpan?.style ?? style,
      text: widget.textSpan?.text ?? widget.data,
      children: widget.textSpan?.children,
      recognizer: widget.textSpan?.recognizer,
    );

    var userScale =
        widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);

    int left;
    int right;

    var presetFontSizes = widget.presetFontSizes?.reversed?.toList();
    if (presetFontSizes == null) {
      var defaultFontSize =
          style.fontSize.clamp(widget.minFontSize, widget.maxFontSize);
      var defaultScale = defaultFontSize * userScale / style.fontSize;
      if (_checkTextFits(span, defaultScale, maxLines, size)) {
        return [defaultFontSize * userScale, true];
      }

      left = (widget.minFontSize / widget.stepGranularity).floor();
      right = (defaultFontSize / widget.stepGranularity).ceil();
    } else {
      left = 0;
      right = presetFontSizes.length - 1;
    }

    var lastValueFits = false;
    while (left <= right) {
      var mid = (left + (right - left) / 2).toInt();
      double scale;
      if (presetFontSizes == null) {
        scale = mid * userScale * widget.stepGranularity / style.fontSize;
      } else {
        scale = presetFontSizes[mid] * userScale / style.fontSize;
      }
      if (_checkTextFits(span, scale, maxLines, size)) {
        left = mid + 1;
        lastValueFits = true;
      } else {
        right = mid - 1;
      }
    }

    if (!lastValueFits) {
      right += 1;
    }

    double fontSize;
    if (presetFontSizes == null) {
      fontSize = right * userScale * widget.stepGranularity;
    } else {
      fontSize = presetFontSizes[right] * userScale;
    }

    return [fontSize, lastValueFits];
  }

  bool _checkTextFits(
      TextSpan text, double scale, int maxLines, BoxConstraints constraints) {
    if (!widget.wrapWords) {
      var words = text.toPlainText().split(RegExp('\\s+'));

      var wordWrapTp = TextPainter(
        text: TextSpan(
          style: text.style,
          text: words.join('\n'),
        ),
        textAlign: widget.textAlign ?? TextAlign.left,
        textDirection: widget.textDirection ?? TextDirection.ltr,
        textScaleFactor: scale ?? 1,
        maxLines: words.length,
        locale: widget.locale,
        strutStyle: widget.strutStyle,
      );

      wordWrapTp.layout(maxWidth: constraints.maxWidth);

      if (wordWrapTp.didExceedMaxLines ||
          wordWrapTp.width > constraints.maxWidth) {
        return false;
      }
    }

    var tp = TextPainter(
      text: text,
      textAlign: widget.textAlign ?? TextAlign.left,
      textDirection: widget.textDirection ?? TextDirection.ltr,
      textScaleFactor: scale ?? 1,
      maxLines: maxLines,
      locale: widget.locale,
      strutStyle: widget.strutStyle,
    );

    tp.layout(maxWidth: constraints.maxWidth);

    return !(tp.didExceedMaxLines ||
        tp.height > constraints.maxHeight ||
        tp.width > constraints.maxWidth);
  }

  Widget _buildText(double fontSize, TextStyle style, int maxLines) {
    if (widget.data != null) {
      return Text(
        widget.data,
        key: widget.textKey,
        style: style.copyWith(fontSize: fontSize),
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaleFactor: 1,
        maxLines: maxLines,
        semanticsLabel: widget.semanticsLabel,
      );
    } else {
      return Text.rich(
        widget.textSpan,
        key: widget.textKey,
        style: style,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaleFactor: fontSize / style.fontSize,
        maxLines: maxLines,
        semanticsLabel: widget.semanticsLabel,
      );
    }
  }

  Widget _buildSelectableText(double fontSize, TextStyle style, int maxLines) {
    if (widget.data != null) {
      return SelectableText(
        widget.data,
        key: widget.textKey,
        style: style.copyWith(fontSize: fontSize),
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        textScaleFactor: 1,
        maxLines: maxLines,
        autofocus: widget.autofocus,
        cursorColor: widget.cursorColor,
        cursorHeight: widget.cursorHeight,
        cursorRadius: widget.cursorRadius,
        cursorWidth: widget.cursorWidth,
        dragStartBehavior: widget.dragStartBehavior,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        focusNode: widget.focusNode,
        minLines: widget.minLines,
        onSelectionChanged: widget.onSelectionChanged,
        onTap: widget.onTap,
        scrollPhysics: widget.scrollPhysics,
        selectionControls: widget.selectionControls,
        showCursor: widget.showCursor,
        toolbarOptions: widget.toolbarOptions,
      );
    } else {
      return SelectableText.rich(
        widget.textSpan,
        key: widget.textKey,
        style: style,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        textScaleFactor: fontSize / style.fontSize,
        maxLines: maxLines,
        autofocus: widget.autofocus,
        cursorColor: widget.cursorColor,
        cursorHeight: widget.cursorHeight,
        cursorRadius: widget.cursorRadius,
        cursorWidth: widget.cursorWidth,
        dragStartBehavior: widget.dragStartBehavior,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        focusNode: widget.focusNode,
        minLines: widget.minLines,
        onSelectionChanged: widget.onSelectionChanged,
        onTap: widget.onTap,
        scrollPhysics: widget.scrollPhysics,
        selectionControls: widget.selectionControls,
        showCursor: widget.showCursor,
        toolbarOptions: widget.toolbarOptions,
      );
    }
  }

  void _notifySync() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      var defaultTextStyle = DefaultTextStyle.of(context);

      var style = widget.style;
      if (widget.style == null || widget.style.inherit) {
        style = defaultTextStyle.style.merge(widget.style);
      }
      if (style.fontSize == null) {
        style = style.copyWith(fontSize: AutoSizeText._defaultFontSize);
      }

      var maxLines = widget.maxLines ?? defaultTextStyle.maxLines;

      _sanityCheck(style, maxLines);

      var result = _calculateFontSize(size, style, maxLines);
      var fontSize = result[0] as double;
      var textFits = result[1] as bool;

      Widget text;

      if (widget.group != null && !widget._isSelectableText) {
        widget.group._updateFontSize(this, fontSize);
        text = _buildText(widget.group._fontSize, style, maxLines);
      } else if (widget.group != null && widget._isSelectableText) {
        widget.group._updateFontSize(this, fontSize);
        text = _buildSelectableText(widget.group._fontSize, style, maxLines);
      } else if (widget.group == null && widget._isSelectableText) {
        text = _buildSelectableText(fontSize, style, maxLines);
      } else {
        text = _buildText(fontSize, style, maxLines);
      }

      if (widget.overflowReplacement != null && !textFits) {
        return widget.overflowReplacement;
      } else {
        return text;
      }
    });
  }
}
