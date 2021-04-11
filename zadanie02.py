import lxml.etree as ET

dom = ET.parse("zadanie01.xml")
xslt = ET.parse("zadanie02.xsl")
transform = ET.XSLT(xslt)
newdom = transform(dom)

with open("test.html", 'wb') as file:
    file.write(ET.tostring(newdom, pretty_print=True))

