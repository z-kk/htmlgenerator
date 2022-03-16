import
  base

const
  Br* = "<br />"

type
  formmethod* = enum
    fmGet = "get"
    fmPost = "post"
    fmDialog = "dialog"

  formtarget* = enum
    ftSelf = "_self"
    ftBlank = "_blank"
    ftParent = "_parent"
    ftTop = "_top"

  hlabel* = object of hbase

  ha* = object of hbase
    href*: string
    download*: string
    `type`*: string
    rel*: string
    target*: formtarget

  hdiv* = object of hbase

  hform* = object of hbase
    action*: string
    enctype*: string
    `method`*: formmethod
    target*: formtarget

func toHtml*(node: hlabel): string =
  ## Generate the HTML `label` element
  result = "<label"
  result &= node.baseOptions
  result &= ">" & node.content & "</label>"

func toHtml*(node: ha): string =
  ## Generate the HTML `a` element
  result = "<a"
  if node.href != "":
    result &= optionStr("href", node.href)
  if node.download != "":
    result &= optionStr("download", node.download)
  if node.type != "":
    result &= optionStr("type", node.type)
  if node.rel != "":
    result &= optionStr("rel", node.rel)
  if node.target != ftSelf:
    result &= optionStr("target", $node.target)
  result &= node.baseOptions
  result &= ">" & node.content & "</a>"

func toHtml*(node: hdiv): string =
  ## Generate the HTML `div` element
  result = "<div"
  result &= node.baseOptions
  result &= ">\n"
  if node.content != "":
    result &= "  " & node.content & "\n"
  for content in node.contents:
    result &= "  " & content & "\n"
  result &= "</div>"

func toHtml*(node: hform): string =
  ## Generate the HTML `form` element
  result = "<form"
  if node.action != "":
    result &= optionStr("action", node.action)
  if node.enctype != "":
    result &= optionStr("enctype", node.enctype)
  if node.method != fmGet:
    result &= optionStr("method", $node.method)
  if node.target != ftSelf:
    result &= optionStr("target", $node.target)
  result &= node.baseOptions
  result &= ">\n"
  if node.content != "":
    result &= "  " & node.content & "\n"
  for content in node.contents:
    result &= "  " & content & "\n"
  result &= "</form>"
