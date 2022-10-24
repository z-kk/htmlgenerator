import
  base

type
  hmeta* = object
    charset*: string
    property*: string
    content*: string

  hlink* = object
    rel*: string
    `type`*: string
    media*: string
    href*: string

  hscript* = object
    `type`*: string
    src*: string
    content*: string

  hhead* = object
    meta*: seq[hmeta]
    title*: string
    link*: seq[hlink]
    script*: seq[hscript]

func toHtml(meta: hmeta): string =
  ## Generate the HTML `meta` element
  result = "<meta"
  if meta.charset != "":
    result &= optionStr("charset", meta.charset)
  if meta.property != "":
    result &= optionStr("property", meta.property)
  if meta.content != "":
    result &= optionStr("content", meta.content)
  result &= ">"

func newLink*(path = ""): hlink =
  ## Make hlink object
  result.rel = "stylesheet"
  result.href = path

func toHtml*(lnk: hlink): string =
  ## Generate the HTML `link` element
  result = "<link"
  if lnk.rel != "":
    result &= optionStr("rel", lnk.rel)
  if lnk.type != "":
    result &= optionStr("type", lnk.type)
  if lnk.media != "":
    result &= optionStr("media", lnk.media)
  if lnk.href != "":
    result &= optionStr("href", lnk.href)
  result &= ">"

func newScript*(path = ""): hscript =
  ## Make hscript object
  result.src = path

func toHtml*(spt: hscript): string =
  ## Generate the HTML `script` element
  result = "<script"
  if spt.type != "":
    result &= optionStr("type", spt.type)
  if spt.src != "":
    result &= optionStr("src", spt.src)
  result &= ">" & spt.content & "</script>"

func toHtml*(hd: hhead): string =
  ## Generate the HTML `head` element
  result = "<head>\n"
  for m in hd.meta:
    result &= "  " & m.toHtml & "\n"
  if hd.title != "":
    result &= "  <title>" & hd.title & "</title>\n"
  for lnk in hd.link:
    result &= "  " & lnk.toHtml & "\n"
  for spt in hd.script:
    result &= "  " & spt.toHtml & "\n"
  result &= "</head>"

proc add*(hd: var hhead, meta: hmeta) =
  ## Add hmeta object to meta seq
  hd.meta.add(meta)

proc add*(hd: var hhead, lnk: hlink) =
  ## Add hlink object to link seq
  hd.link.add(lnk)

proc add*(hd: var hhead, spt: hscript) =
  ## Add hscript object to script seq
  hd.script.add(spt)
