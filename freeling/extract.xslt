<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:output method="text"/>
 <xsl:strip-space elements="*"/>

 <xsl:template match="//artigo">
  <xsl:value-of select="."/>
---
 </xsl:template>

 <xsl:template match="text()"/>
</xsl:stylesheet>
