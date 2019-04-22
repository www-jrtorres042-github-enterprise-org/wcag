<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:wcag="https://www.w3.org/WAI/GL/"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="#all"
	version="2.0">
	
	<xsl:variable name="techniques-doc" select="document('../techniques/techniques.xml')"/>
	<xsl:variable name="techniques-associations-doc" select="document('../techniques/technique-associations.xml')"/>
	
	<xsl:template match="/">
		<html>
			<head>
				<title>WCAG Editors Sanity Check</title>
			</head>
			<body>
				<h1>WCAG Editors Sanity Check</h1>
				<xsl:call-template name="techniques-no-association"/>
				<xsl:call-template name="techniques-no-id"/>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="techniques-no-association">
		<section>
			<h2>Techniques not referenced from any Understanding document</h2>
			<ul>
				<xsl:for-each select="$techniques-doc//technique">
					<xsl:if test="not($techniques-associations-doc//technique[@id = current()/@id])">
						<li><xsl:value-of select="@id"/></li>
					</xsl:if>
				</xsl:for-each>
			</ul>
		</section>
	</xsl:template>
	
	<xsl:template name="techniques-no-id">
		<section>
			<h2>Techniques not named according to ID pattern</h2>
			<ul>
				<xsl:for-each select="$techniques-doc//technique">
					<xsl:if test="not(matches(@id, '[A-Z]+\d+(.html)?$'))">
						<li><xsl:value-of select="@id"/></li>
					</xsl:if>
				</xsl:for-each>
			</ul>
		</section>
	</xsl:template>
	
</xsl:stylesheet>