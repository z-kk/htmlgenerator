import
  base

type
  thscope* = enum
    hsAuto = "auto"
    hsRow = "row"
    hsCol = "col"
    hsRowGroup = "rowgroup"
    hsColGroup = "colgroup"

  htd* = object of hbase
    colspan*, rowspan*: int

  hth* = object of htd
    abbr*: string
    scope*: thscope

  thortd = object
    th: hth
    td: htd
    isth: bool

  htr* = object of hbase
    cols: seq[thortd]

  htbody* = object of hbase
    rows*: seq[htr]

  hthead* = object of htbody

  htfoot* = object of htbody

  htable* = object of hbase
    caption*: string
    thead*: hthead
    tbody*: htbody
    tfoot*: htfoot
    rows*: seq[htr]

func tdOption(node: htd): string =
  ## Generate `td` or `th` HTML options
  ##
  ## if rowspan == 0 or 1 then result doesn't contain rowspan
  ## if rowspan > 1 then result's rowspan is that value
  ## if rowspan < 0 then result's rowspan == 0
  if node.colspan > 0:
    result &= optionStr("colspan", $node.colspan)
  if node.rowspan > 1:
    result &= optionStr("rowspan", $node.rowspan)
  elif node.rowspan < 0:
    result &= optionStr("rowspan", "0")
  result &= node.baseOptions

func toHtmlSeq(node: htd): seq[string] =
  ## Generate the HTML `td` element
  result.add("<td" & node.tdOption & ">")
  if node.content != "":
    result.add("  " & node.content)
  for content in node.contents:
    result.add("  " & content)
  result.add("</td>")

func toHtmlSeq(node: hth): seq[string] =
  ## Generate the HTML `th` element
  var str: string
  str = "<th"
  str &= node.tdOption
  if node.scope != hsAuto:
    str &= optionStr("scope", $node.scope)
  if node.abbr != "":
    str &= optionStr("abbr", node.abbr)
  str &= ">"
  result.add(str)
  if node.content != "":
    result.add("  " & node.content)
  for content in node.contents:
    result.add("  " & content)
  result.add("</th>")

proc add*(node: var htr, td: htd) =
  ## Add `td` object to `tr` object
  node.cols.add(thortd(td: td))

proc add*(node: var htr, th: hth) =
  ## Add `th` object to `tr` object
  node.cols.add(thortd(th: th, isth: true))

proc clear*(node: var htr) =
  ## Clear `tr` objects seq
  node.cols = @[]

func toHtmlSeq(node: htr): seq[string] =
  ## Generate the HTML `tr` element seq
  result.add("<tr" & node.baseOptions & ">")
  for col in node.cols:
    if col.isth:
      for line in col.th.toHtmlSeq:
        result.add("  " & line)
    else:
      for line in col.td.toHtmlSeq:
        result.add("  " & line)
  result.add("</tr>")

proc add*(node: var htbody, row: var htr) =
  ## Add `tr` object to `tbody` object
  node.rows.add(row)
  row.clear

func toHtmlSeq(node: htbody): seq[string] =
  ## Generate the HTML `tbody` element seq
  if node.rows.len == 0:
    return
  result.add("<tbody" & node.baseOptions & ">")
  for row in node.rows:
    for cell in row.toHtmlSeq:
      result.add("  " & cell)
  result.add("</tbody>")

func toHtmlSeq(node: hthead): seq[string] =
  ## Generate the HTML `thead` element seq
  if node.rows.len == 0:
    return
  result.add("<thead" & node.baseOptions & ">")
  for row in node.rows:
    for cell in row.toHtmlSeq:
      result.add("  " & cell)
  result.add("</thead>")

func toHtmlSeq(node: htfoot): seq[string] =
  ## Generate the HTML `tfoot` element seq
  if node.rows.len == 0:
    return
  result.add("<tfoot" & node.baseOptions & ">")
  for row in node.rows:
    for cell in row.toHtmlSeq:
      result.add("  " & cell)
  result.add("</tfoot>")

func toHtml*(node: htable): string =
  ## Generate the HTML `table` element
  result = "<table"
  result &= node.baseOptions
  result &= ">\n"
  if node.caption != "":
    result &= "  <caption>" & node.caption & "</caption>\n"
  result &= node.thead.toHtmlSeq.toContentsStr
  if node.thead.rows.len + node.tbody.rows.len + node.tfoot.rows.len > 0:
    var body = node.tbody
    body.rows &= node.rows
    result &= body.toHtmlSeq.toContentsStr
  else:
    for row in node.rows:
      result &= row.toHtmlSeq.toContentsStr
  result &= node.tfoot.toHtmlSeq.toContentsStr
  result &= "</table>"
