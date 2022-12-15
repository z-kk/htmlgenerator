import unittest

import htmlgenerator

import strutils
test "label":
  var lbl: hlabel
  check lbl.toHtml == "<label></label>"
  lbl.content = "tlabel"
  check lbl.toHtml == "<label>tlabel</label>"

test "input":
  var ipt: hinput
  check ipt.toHtml == """<input />"""
  ipt.type = tpHidden
  ipt.id = "tid"
  ipt.class.add("tclass1")
  ipt.class.add("tclass2")
  ipt.name = "tname"
  ipt.value = "tvalue"
  check ipt.toHtml == """<input type="hidden" id="tid" class="tclass1 tclass2" name="tname" value="tvalue" />"""
  ipt.title = "ttitle"
  check ipt.toHtml == """<label>ttitle<input type="hidden" id="tid" class="tclass1 tclass2" name="tname" value="tvalue" /></label>"""

test "button":
  var btn: hbutton
  check btn.toHtml == """<button></button>"""
  btn.type = tpButton
  btn.content = "tbutton"
  check btn.toHtml == """<button type="button">tbutton</button>"""

test "checkbox":
  var chk: hcheckbox
  check chk.toHtml == """<input type="checkbox" />"""
  chk.checked = true
  check chk.toHtml == """<input type="checkbox" checked />"""
  chk.content = "tcheck"
  check chk.toHtml == """<label><input type="checkbox" checked />tcheck</label>"""

test "radio":
  var rdo: hradio
  check rdo.toHtml == """<input type="radio" />"""
  rdo.readonly = true
  rdo.content = "tradio"
  check rdo.toHtml == """<label><input type="radio" readonly />tradio</label>"""

test "textarea":
  var tarea: htextarea
  check tarea.toHtml == "<textarea></textarea>"
  tarea.content = "hoge\nfuga"
  tarea.rows = 3
  tarea.wrap = twSoft
  tarea.placeholder = "ttextarea"
  let res = """
    <textarea rows="3" placeholder="ttextarea">hoge
    fuga</textarea>""".unindent(4)
  check tarea.toHtml == res
  tarea.title = "ttitle"
  check tarea.toHtml == "<label>ttitle$1</label>" % [res]
