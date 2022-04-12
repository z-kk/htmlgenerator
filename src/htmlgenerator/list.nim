import
  base

type
  hul* = object of hbase
    children*: seq[hul]
    isol: bool

  hol* = object of hul

proc add*(node: var hul, child: hul) =
  ## Add `ul` object to `ul` object
  node.children.add(child)

proc add*(node: var hul, child: hol) =
  ## Add `ol` object to `ul` object
  let item = hul(children: child.children, isol: true)
  node.add(item)

proc add*(node: var hul, child: string) =
  ## Add item to `ul` object
  let item = hul(content: child)
  node.add(item)

proc add*(node: var hol, child: hol) =
  ## Add `ol` object to `ol` object
  let item = hul(children: child.children, isol: true)
  node.add(item)

proc add*(node: var hol, child: string) =
  ## Add item to `ol` object
  let item = hul(content: child)
  node.add(item)

func toHtml*(node: hul): string =
  ## Generate the HTML `ul` or `ol` element
  if node.isol:
    result = "<ol"
  else:
    result = "<ul"
  result &= node.baseOptions
  result &= ">\n"
  for child in node.children:
    if child.children.len == 0:
      if child.content != "":
        result &= "  <li>" & child.content & "</li>\n"
    else:
      if result.len > 6 and result[^6..^1] == "</li>\n":
        result = result[0 ..< ^6] & "\n"
        result &= child.toHtml.toContentsStr[0..^2].toContentsStr
        result &= "  </li>\n"
      else:
        result &= child.toHtml.toContentsStr
  if node.isol:
    result &= "</ol>"
  else:
    result &= "</ul>"

func toHtml*(node: hol): string =
  ## Generate the HTML `ol` element
  result = "<ol"
  result &= node.baseOptions
  result &= ">\n"
  for child in node.children:
    if child.children.len == 0:
      if child.content != "":
        result &= "  <li>" & child.content & "</li>\n"
    else:
      if result.len > 6 and result[^6..^1] == "</li>\n":
        result = result[0 ..< ^6] & "\n"
        result &= child.toHtml.toContentsStr[0..^2].toContentsStr
        result &= "  </li>\n"
      else:
        result &= child.toHtml.toContentsStr
  result &= "</ol>"
