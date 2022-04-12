import unittest

import htmlgenerator

import strutils
test "ul":
  var ul: hul
  check ul.toHtml == "<ul>\n</ul>"
  ul.add("first item")
  ul.add("second item")
  var child: hul
  child.add("second item first subitem")
  child.add("second item second subitem")
  var child2: hul
  child2.add("second item second subitem first sub-subitem")
  child2.add("second item second subitem second sub-subitem")
  child2.add("second item second subitem third sub-subitem")
  child.add(child2)
  child.add("second item third subitem")
  ul.add(child)
  ul.add("third item")

  let res = """
    <ul>
      <li>first item</li>
      <li>second item
        <ul>
          <li>second item first subitem</li>
          <li>second item second subitem
            <ul>
              <li>second item second subitem first sub-subitem</li>
              <li>second item second subitem second sub-subitem</li>
              <li>second item second subitem third sub-subitem</li>
            </ul>
          </li>
          <li>second item third subitem</li>
        </ul>
      </li>
      <li>third item</li>
    </ul>""".unindent(4)
  check ul.toHtml == res

test "ol":
  var ol: hol
  check ol.toHtml == "<ol>\n</ol>"
  ol.add("first item")
  ol.add("second item")
  var child: hol
  child.add("second item first subitem")
  child.add("second item second subitem")
  var child2: hol
  child2.add("second item second subitem first sub-subitem")
  child2.add("second item second subitem second sub-subitem")
  child2.add("second item second subitem third sub-subitem")
  child.add(child2)
  child.add("second item third subitem")
  ol.add(child)
  ol.add("third item")

  let res = """
    <ol>
      <li>first item</li>
      <li>second item
        <ol>
          <li>second item first subitem</li>
          <li>second item second subitem
            <ol>
              <li>second item second subitem first sub-subitem</li>
              <li>second item second subitem second sub-subitem</li>
              <li>second item second subitem third sub-subitem</li>
            </ol>
          </li>
          <li>second item third subitem</li>
        </ol>
      </li>
      <li>third item</li>
    </ol>""".unindent(4)
  check ol.toHtml == res

test "list":
  var
    ul: hul
    child: hol
    child2: hul
  ul.add("first item")
  ul.add("second item")
  child.add("second item first subitem")
  child.add("second item second subitem")
  child2.add("second item second subitem first sub-subitem")
  child2.add("second item second subitem second sub-subitem")
  child2.add("second item second subitem third sub-subitem")
  child.add(child2)
  child.add("second item third subitem")
  ul.add(child)
  ul.add("third item")

  let res = """
    <ul>
      <li>first item</li>
      <li>second item
        <ol>
          <li>second item first subitem</li>
          <li>second item second subitem
            <ul>
              <li>second item second subitem first sub-subitem</li>
              <li>second item second subitem second sub-subitem</li>
              <li>second item second subitem third sub-subitem</li>
            </ul>
          </li>
          <li>second item third subitem</li>
        </ol>
      </li>
      <li>third item</li>
    </ul>""".unindent(4)
  check ul.toHtml == res
