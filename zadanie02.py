import lxml.etree as ET

dom = ET.parse("zadanie01.xml")
xslt = ET.parse("zadanie03.xsl")
#dom = ET.parse("test.xml")
#xslt = ET.parse("test.xsl")
transform = ET.XSLT(xslt)
newdom = transform(dom)

with open("test.svg", 'wb') as file:
    file.write(ET.tostring(newdom, pretty_print=True))

