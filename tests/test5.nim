import unittest

import htmlgenerator

import strutils
test "select":
  var sel: hselect
  check sel.toHtml == "<select>\n</select>"
  for i in 1..5:
    var opt: hoption
    opt.value = "test" & $i
    opt.content = opt.value
    if i == 3:
      opt.selected = true
    if i == 4:
      opt.disabled = true
    sel.add(opt)
  sel.name = "tname"
  sel.required = true

  let res = """
    <select name="tname" required>
      <option value="test1">test1</option>
      <option value="test2">test2</option>
      <option value="test3" selected>test3</option>
      <option value="test4" disabled>test4</option>
      <option value="test5">test5</option>
    </select>""".unindent(4)
  check sel.toHtml == res

test "datalist":
  var dls: hdatalist
  check dls.toHtml == "<datalist>\n</datalist>"
  for i in 1..5:
    var opt: hoption
    opt.value = "test" & $i
    dls.add(opt)
  dls.id = "datalist"

  let res = """
    <datalist id="datalist">
      <option value="test1"></option>
      <option value="test2"></option>
      <option value="test3"></option>
      <option value="test4"></option>
      <option value="test5"></option>
    </datalist>""".unindent(4)
  check dls.toHtml == res
