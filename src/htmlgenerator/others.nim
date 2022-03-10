import
  base

type
  hlabel* = object of hbase

func toHtml*(node: hlabel): string =
  ## Generate the HTML `label` element
  result = "<label"
  result &= node.baseOptions
  result &= ">" & node.content & "</label>"
