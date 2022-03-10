import
  std / strutils

type
  hbase* = object of RootObj
    id*: string
    class*: seq[string]
    name*: string
    value*: string
    content*: string
    contents*: seq[string]

func optionStr*(opt, val: string): string =
  ## Generate string  opt="val"
  " " & opt & "=\"" & val & "\""

func baseOptions*(base: hbase): string =
  ## Generate common HTML options
  if base.id != "":
    result &= optionStr("id", base.id)
  if base.class.len > 0:
    result &= optionStr("class", base.class.join(" "))
  if base.name != "":
    result &= optionStr("name", base.name)
  if base.value != "":
    result &= optionStr("value", base.value)
