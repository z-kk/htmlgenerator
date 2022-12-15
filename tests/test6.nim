import unittest

import htmlgenerator

import strutils
test "combination":
  var
    d: hdiv
    frm: hform
    tbl: htable
    tr: htr
    th: hth
    td: htd
    ipt: hinput
    tar: htextarea
    btn: hbutton

  d.class.add("tclass")
  frm.id = "tid"
  ipt.name = "tname1"
  tar.name = "tname2"
  tar.content = "test\nhoge\nfuga"
  btn.class.add("tbtncls")
  btn.name = "tname3"
  btn.value = "tvalue"
  btn.content = "tbutton"

  th.content = "type"
  tr.add(th)
  th.content = "element"
  tr.add(th)
  tbl.tbody.add(tr)

  th.content = "input"
  tr.add(th)
  td.content = ipt.toHtml
  tr.add(td)
  tbl.tbody.add(tr)

  th.content = "textarea"
  tr.add(th)
  td.content = tar.toHtml
  tr.add(td)
  tbl.tbody.add(tr)

  th.content = "button"
  tr.add(th)
  td.content = btn.toHtml
  tr.add(td)
  tbl.tbody.add(tr)

  for line in tbl.toHtml.splitLines:
    frm.contents.add(line)
  for line in frm.toHtml.splitLines:
    d.contents.add(line)

  btn.form = frm.id
  btn.name = "name4"
  d.contents.add(btn.toHtml)
  "test.html".writeFile(d.toHtml)

  let res = """
    <div class="tclass">
      <form id="tid">
        <table>
          <tbody>
            <tr>
              <th>
                type
              </th>
              <th>
                element
              </th>
            </tr>
            <tr>
              <th>
                input
              </th>
              <td>
                <input name="tname1" />
              </td>
            </tr>
            <tr>
              <th>
                textarea
              </th>
              <td>
                <textarea name="tname2">test
    hoge
    fuga</textarea>
              </td>
            </tr>
            <tr>
              <th>
                button
              </th>
              <td>
                <button class="tbtncls" name="tname3" value="tvalue">tbutton</button>
              </td>
            </tr>
          </tbody>
        </table>
      </form>
      <button class="tbtncls" name="name4" value="tvalue" form="tid">tbutton</button>
    </div>""".unindent(4)
  check d.toHtml == res
