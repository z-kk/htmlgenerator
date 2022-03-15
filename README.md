# htmlgenerator
Generate HTML string by nim object

## Use

```nim
import htmlgenerator

var data: seq[seq[string]]
data.add(@["row1", "value1", "0"])
data.add(@["row2", "value2", "0"])
data.add(@["row3", "value3", "1"])
data.add(@["row4", "value4", "0"])

var ipt: hinput
ipt.name = "iname"
# ipt.toHtml == """<input name="iname" />"""

var btn: hbutton
btn.value = "bvalue"
btn.content = "bcontent"
# btn.toHtml == """<button value="bvalue">bcontent</button>"""

var tbl: htable
for d in data:
  var
    row: htr
    th: hth
    td: htd
  th.content = d[0]
  row.add(th)
  td.content = d[1]
  row.add(td)
  tbl.rows.add(row)
#[
tbl.toHtml == """<table>
  <tr>
    <th>row1</th>
    <td>value1</td>
  </tr>
  <tr>
    <th>row2</th>
    <td>value2</td>
  </tr>
  <tr>
    <th>row3</th>
    <td>value3</td>
  </tr>
  <tr>
    <th>row4</th>
    <td>value4</td>
  </tr>
</table>"""
]#

var sel: hselect
for d in data:
  var opt: hoption
  opt.content = d[1]
  opt.selected = d[2] == "1"
  sel.add(opt)
#[
sel.toHtml == """<select>
  <option>value1</option>
  <option>value2</option>
  <option selected>value3</option>
  <option>value4</option>
</select>"""
]#
```

## Prease Pull Request!
