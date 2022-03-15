import unittest

import htmlgenerator

test "head":
  var hd: hhead
  check hd.toHtml == "<head>\n</head>"

  var meta: hmeta
  meta.charset = "utf-8"
  hd.add(meta)
  hd.title = "ttitle"
  hd.add(newLink("/hoge.css"))
  hd.add(newScript("/hoge.js"))
  var res = "<head>\n"
  res &= "  <meta charset=\"utf-8\">\n"
  res &= "  <title>ttitle</title>\n"
  res &= "  <link rel=\"stylesheet\" href=\"/hoge.css\">\n"
  res &= "  <script src=\"/hoge.js\"></script>\n"
  res &= "</head>"
  check hd.toHtml == res
