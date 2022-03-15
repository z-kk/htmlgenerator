import unittest

import htmlgenerator

test "div":
  var
    dv: hdiv
    ipt: hinput
    chk: hcheckbox
    res: string

  check dv.toHtml == "<div>\n</div>"

  ipt.name = "tname"
  chk.content = "tcheck"
  dv.contents.add(ipt.toHtml)
  dv.contents.add(Br)
  dv.contents.add(chk.toHtml)
  res = "<div>\n"
  res &= "  <input name=\"tname\" />\n"
  res &= "  <br />\n"
  res &= "  <label><input type=\"checkbox\" />tcheck</label>\n"
  res &= "</div>"
  check dv.toHtml == res

test "form":
  var
    frm: hform
    dv: hdiv
    ipt: hinput
    btn: hbutton
    res: string

  check frm.toHtml == "<form>\n</form>"

  frm.action = "/hoge"
  frm.method = fmPost
  ipt.name = "tname"
  btn.name = "tb"
  btn.value = "tvalue"
  btn.content = "tbutton"
  dv.add(ipt.toHtml)
  dv.add(Br)
  dv.add(btn.toHtml)
  frm.add(dv.toHtml)
  res = "<form action=\"/hoge\" method=\"post\">\n"
  res &= "  <div>\n"
  res &= "    <input name=\"tname\" />\n"
  res &= "    <br />\n"
  res &= "    <button name=\"tb\" value=\"tvalue\">tbutton</button>\n"
  res &= "  </div>\n"
  res &= "</form>"
  check frm.toHtml == res
