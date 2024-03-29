import unittest

import htmlgenerator

import strutils
test "table":
  var tbl: htable
  var row: htr
  check tbl.toHtml == "<table>\n</table>"
  for i in 0..10:
    for j in 0..10:
      if i == 0:
        var th: hth
        if j == 0:
          row.add(th)
        else:
          th.content = "col" & $j
          row.add(th)
      else:
        if j == 0:
          var th: hth
          th.content = "row" & $i
          row.add(th)
        else:
          var td: htd
          td.content = "cell(" & $i & "_" & $j & ")"
          row.add(td)
    if i == 0:
      tbl.thead.add(row)
    else:
      tbl.tbody.add(row)
  tbl.caption = "test table"

  let res = """
    <table>
      <caption>test table</caption>
      <thead>
        <tr>
          <th>
          </th>
          <th>
            col1
          </th>
          <th>
            col2
          </th>
          <th>
            col3
          </th>
          <th>
            col4
          </th>
          <th>
            col5
          </th>
          <th>
            col6
          </th>
          <th>
            col7
          </th>
          <th>
            col8
          </th>
          <th>
            col9
          </th>
          <th>
            col10
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>
            row1
          </th>
          <td>
            cell(1_1)
          </td>
          <td>
            cell(1_2)
          </td>
          <td>
            cell(1_3)
          </td>
          <td>
            cell(1_4)
          </td>
          <td>
            cell(1_5)
          </td>
          <td>
            cell(1_6)
          </td>
          <td>
            cell(1_7)
          </td>
          <td>
            cell(1_8)
          </td>
          <td>
            cell(1_9)
          </td>
          <td>
            cell(1_10)
          </td>
        </tr>
        <tr>
          <th>
            row2
          </th>
          <td>
            cell(2_1)
          </td>
          <td>
            cell(2_2)
          </td>
          <td>
            cell(2_3)
          </td>
          <td>
            cell(2_4)
          </td>
          <td>
            cell(2_5)
          </td>
          <td>
            cell(2_6)
          </td>
          <td>
            cell(2_7)
          </td>
          <td>
            cell(2_8)
          </td>
          <td>
            cell(2_9)
          </td>
          <td>
            cell(2_10)
          </td>
        </tr>
        <tr>
          <th>
            row3
          </th>
          <td>
            cell(3_1)
          </td>
          <td>
            cell(3_2)
          </td>
          <td>
            cell(3_3)
          </td>
          <td>
            cell(3_4)
          </td>
          <td>
            cell(3_5)
          </td>
          <td>
            cell(3_6)
          </td>
          <td>
            cell(3_7)
          </td>
          <td>
            cell(3_8)
          </td>
          <td>
            cell(3_9)
          </td>
          <td>
            cell(3_10)
          </td>
        </tr>
        <tr>
          <th>
            row4
          </th>
          <td>
            cell(4_1)
          </td>
          <td>
            cell(4_2)
          </td>
          <td>
            cell(4_3)
          </td>
          <td>
            cell(4_4)
          </td>
          <td>
            cell(4_5)
          </td>
          <td>
            cell(4_6)
          </td>
          <td>
            cell(4_7)
          </td>
          <td>
            cell(4_8)
          </td>
          <td>
            cell(4_9)
          </td>
          <td>
            cell(4_10)
          </td>
        </tr>
        <tr>
          <th>
            row5
          </th>
          <td>
            cell(5_1)
          </td>
          <td>
            cell(5_2)
          </td>
          <td>
            cell(5_3)
          </td>
          <td>
            cell(5_4)
          </td>
          <td>
            cell(5_5)
          </td>
          <td>
            cell(5_6)
          </td>
          <td>
            cell(5_7)
          </td>
          <td>
            cell(5_8)
          </td>
          <td>
            cell(5_9)
          </td>
          <td>
            cell(5_10)
          </td>
        </tr>
        <tr>
          <th>
            row6
          </th>
          <td>
            cell(6_1)
          </td>
          <td>
            cell(6_2)
          </td>
          <td>
            cell(6_3)
          </td>
          <td>
            cell(6_4)
          </td>
          <td>
            cell(6_5)
          </td>
          <td>
            cell(6_6)
          </td>
          <td>
            cell(6_7)
          </td>
          <td>
            cell(6_8)
          </td>
          <td>
            cell(6_9)
          </td>
          <td>
            cell(6_10)
          </td>
        </tr>
        <tr>
          <th>
            row7
          </th>
          <td>
            cell(7_1)
          </td>
          <td>
            cell(7_2)
          </td>
          <td>
            cell(7_3)
          </td>
          <td>
            cell(7_4)
          </td>
          <td>
            cell(7_5)
          </td>
          <td>
            cell(7_6)
          </td>
          <td>
            cell(7_7)
          </td>
          <td>
            cell(7_8)
          </td>
          <td>
            cell(7_9)
          </td>
          <td>
            cell(7_10)
          </td>
        </tr>
        <tr>
          <th>
            row8
          </th>
          <td>
            cell(8_1)
          </td>
          <td>
            cell(8_2)
          </td>
          <td>
            cell(8_3)
          </td>
          <td>
            cell(8_4)
          </td>
          <td>
            cell(8_5)
          </td>
          <td>
            cell(8_6)
          </td>
          <td>
            cell(8_7)
          </td>
          <td>
            cell(8_8)
          </td>
          <td>
            cell(8_9)
          </td>
          <td>
            cell(8_10)
          </td>
        </tr>
        <tr>
          <th>
            row9
          </th>
          <td>
            cell(9_1)
          </td>
          <td>
            cell(9_2)
          </td>
          <td>
            cell(9_3)
          </td>
          <td>
            cell(9_4)
          </td>
          <td>
            cell(9_5)
          </td>
          <td>
            cell(9_6)
          </td>
          <td>
            cell(9_7)
          </td>
          <td>
            cell(9_8)
          </td>
          <td>
            cell(9_9)
          </td>
          <td>
            cell(9_10)
          </td>
        </tr>
        <tr>
          <th>
            row10
          </th>
          <td>
            cell(10_1)
          </td>
          <td>
            cell(10_2)
          </td>
          <td>
            cell(10_3)
          </td>
          <td>
            cell(10_4)
          </td>
          <td>
            cell(10_5)
          </td>
          <td>
            cell(10_6)
          </td>
          <td>
            cell(10_7)
          </td>
          <td>
            cell(10_8)
          </td>
          <td>
            cell(10_9)
          </td>
          <td>
            cell(10_10)
          </td>
        </tr>
      </tbody>
    </table>""".unindent(4)
  check tbl.toHtml == res
