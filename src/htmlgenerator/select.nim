import
  base

type
  hoption* = object of RootObj
    value*: string
    label*: string
    content*: string
    selected*: bool
    disabled*: bool

  hoptgroup* = object of hoption
    options*: seq[hoption]

  hselect* = object of hbase
    size*: int
    form*: string
    disabled*, required*: bool
    multiple*: bool
    optGroups*: seq[hoptgroup]
    options*: seq[hoption]

  hdatalist* = object of hbase
    options*: seq[hoption]

func optionOption(node:hoption): string =
  ## Generate `option` or `optgroup` HTML options
  if node.value != "":
    result &= optionStr("value", node.value)
  if node.label != "":
    result &= optionStr("label", node.label)
  if node.selected:
    result &= " selected"
  if node.disabled:
    result &= " disabled"

func toHtml(node: hoption): string =
  ## Generate the HTML `option` element
  result = "<option"
  result &= node.optionOption
  result &= ">" & node.content & "</option>"

proc add*(node: var hoptgroup, opt: hoption) =
  ## Add `option` object to `optgroup` object
  node.options.add(opt)

func toHtmlSeq(node: hoptgroup): seq[string] =
  ## Generate the HTML `optgroup` element seq
  result.add("<optgroup" & node.optionOption & ">")
  for opt in node.options:
    result.add("  " & opt.toHtml)
  result.add("</optgroup>")

func add*(node: var hselect, opt: hoption) =
  ## Add `option` object to `select` object
  node.options.add(opt)

func add*(node: var hselect, opt: hoptgroup) =
  ## Add `optgroup` object to `select` object
  node.optGroups.add(opt)

func toHtml*(node: hselect): string =
  ## Generate the HTML `select` element
  result = "<select"
  result &= node.baseOptions
  if node.size > 0:
    result &= optionStr("size", $node.size)
  if node.form != "":
    result &= optionStr("form", node.form)
  if node.disabled:
    result &= " disabled"
  if node.required:
    result &= " required"
  if node.multiple:
    result &= " multiple"
  result &= ">\n"
  for opt in node.optGroups:
    for line in opt.toHtmlSeq:
      result &= "  " & line & "\n"
  for opt in node.options:
    result &= "  " & opt.toHtml & "\n"
  result &= "</select>"

func add*(node: var hdatalist, opt: hoption) =
  ## Add `option` object to `datalist` object
  node.options.add(opt)

func toHtml*(node: hdatalist): string =
  ## Generate the HTML `datalist` element
  result = "<datalist"
  result &= node.baseOptions
  result &= ">\n"
  for opt in node.options:
    result &= "  " & opt.toHtml & "\n"
  result &= "</datalist>"
