import
  base, others

type
  inputtype* = enum
    tpText = "text"
    tpButton = "button"
    tpCheckbox = "checkbox"
    tpColor = "color"
    tpDate = "date"
    tpDatetimelocal = "datetime-local"
    tpEmail = "email"
    tpFile = "file"
    tpHidden = "hidden"
    tpImage = "image"
    tpMonth = "month"
    tpNumber = "number"
    tpPassword = "password"
    tpRadio = "radio"
    tpRange = "range"
    tpReset = "reset"
    tpSearch = "search"
    tpSubmit = "submit"
    tpTel = "tel"
    tpTime = "time"
    tpUrl = "url"
    tpWeek = "week"

  hinput* = object of hbase
    `type`*: inputtype
    size*: int
    pattern*, placeholder*: string
    maxlen*, minlen*: int
    form*: string
    disabled*, readonly*, required*: bool

  hbutton* = object of hinput

  hcheckbox* = object of hinput
    checked*: bool

  hradio* = object of hcheckbox

func toHtml*(node: hinput): string =
  ## Generate the HTML `input` element
  result = "<input"
  if node.type != tpText:
    result &= optionStr("type", $node.type)
  result &= node.baseOptions
  if node.size > 0:
    result &= optionStr("size", $node.size)
  if node.pattern != "":
    result &= optionStr("pattern", node.pattern)
  if node.placeholder != "":
    result &= optionStr("placeholder", node.placeholder)
  if node.maxlen > 0:
    result &= optionStr("maxlength", $node.maxlen)
  if node.minlen > 0:
    result &= optionStr("minlength", $node.minlen)
  if node.form != "":
    result &= optionStr("form", node.form)
  if node.disabled:
    result &= " disabled"
  if node.readonly:
    result &= " readonly"
  if node.required:
    result &= " required"
  result &= " />"

proc toHtml*(node: hbutton): string =
  ## Generate the HTML `button` element
  result = "<button"
  case node.type
  of tpSubmit, tpText:
    discard
  of tpButton, tpReset:
    result &= optionStr("type", $node.type)
  else:
    echo "[Warning]: button doesn't have type \"" & $node.type & "\""
  result &= node.baseOptions
  if node.form != "":
    result &= optionStr("form", node.form)
  if node.disabled:
    result &= " disabled"
  result &= ">" & node.content & "</button>"

func toHtml*(node: hcheckbox): string =
  ## Generate the HTML `input` element type `checkbox`
  result = "<input" & optionStr("type", $tpCheckbox)
  result &= node.baseOptions
  if node.form != "":
    result &= optionStr("form", node.form)
  if node.checked:
    result &= " checked"
  if node.disabled:
    result &= " disabled"
  if node.readonly:
    result &= " readonly"
  result &= " />"

  if node.content == "":
    return
  else:
    return hlabel(content: result & node.content).toHtml

func toHtml*(node: hradio): string =
  ## Generate the HTML `input` element type `radio`
  result = "<input" & optionStr("type", $tpRadio)
  result &= node.baseOptions
  if node.form != "":
    result &= optionStr("form", node.form)
  if node.checked:
    result &= " checked"
  if node.disabled:
    result &= " disabled"
  if node.readonly:
    result &= " readonly"
  result &= " />"

  if node.content == "":
    return
  else:
    return hlabel(content: result & node.content).toHtml
