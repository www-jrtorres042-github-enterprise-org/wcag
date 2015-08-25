<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:wcag="http://www.w3.org/WAI/GL/WCAG20/sources/"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	xpath-default-namespace="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="#all"
	version="2.0">
	
	<xsl:param name="strings.file">strings.en.xml</xsl:param>
	<xsl:variable name="strings.doc" select="document($strings.file)"/>
	
	<xsl:key name="string" match="wcag:string" use="@key"/>
	
	<xsl:function name="wcag:string">
		<xsl:param name="string"/>
		<xsl:value-of select="$strings.doc/key('string', $string)"/>
	</xsl:function>
	
	<xsl:function name="wcag:real-content">
		<xsl:param name="el"/>
		<xsl:for-each select="$el/node()">
			<xsl:if test="not(wcag:is-header(.))">
				<xsl:copy-of select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:function>
	
	<xsl:function name="wcag:is-header" as="xs:boolean">
		<xsl:param name="el"/>
		<xsl:variable name="name" select="local-name($el)"/>
		<xsl:choose>
			<xsl:when test="$name = 'h1' or $name = 'h2' or $name = 'h3' or $name = 'h4' or $name = 'h5' or $name = 'h6'">
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	
	<xsl:function name="wcag:id">
		<xsl:param name="id"/>
		<xsl:param name="doc"/>
		<xsl:copy-of select="$doc//*[@id = $id]"/>
	</xsl:function>
	
	<xsl:template match="*[@class = 'instructions']"/>
	
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>