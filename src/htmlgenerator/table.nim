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

func toHtml(node: htd): string =
  ## Generate the HTML `td` element
  result = "<td"
  result &= node.tdOption
  result &= ">" & node.content & "</td>"

func toHtml(node: hth): string =
  ## Generate the HTML `th` element
  result = "<th"
  result &= node.tdOption
  if node.scope != hsAuto:
    result &= optionStr("scope", $node.scope)
  if node.abbr != "":
    result &= optionStr("abbr", node.abbr)
  result &= ">" & node.content & "</th>"

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
      result.add("  " & col.th.toHtml)
    else:
      result.add("  " & col.td.toHtml)
  result.add("</tr>")

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
  for row in node.thead.toHtmlSeq:
    result &= "  " & row & "\n"
  if node.thead.rows.len + node.tbody.rows.len + node.tfoot.rows.len > 0:
    var body = node.tbody
    body.rows &= node.rows
    for row in body.toHtmlSeq:
      result &= "  " & row & "\n"
  else:
    for row in node.rows:
      for cell in row.toHtmlSeq:
        result &= "  " & cell & "\n"
  for row in node.tfoot.toHtmlSeq:
    result &= "  " & row & "\n"
  result &= "</table>"
