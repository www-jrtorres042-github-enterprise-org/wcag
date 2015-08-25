<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:wcag="http://www.w3.org/WAI/GL/WCAG20/sources/"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	xpath-default-namespace="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="#all"
	version="2.0">
	
	<xsl:import href="base.xslt"/>
	
	<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
	
	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;&#10;</xsl:text>
		<html>
			<head>
				<title><xsl:call-template name="title"/> - WCAG 2.0 Techniques</title>
			</head>
			<body>
				<div>Header cruft</div>
				<h1><xsl:call-template name="title"/></h1>
				<div>
					<h2>On this page</h2>
					<ul>
						<xsl:apply-templates select="wcag:id('applicability', /), wcag:id('description', /), wcag:id('examples', /), wcag:id('related', /), wcag:id('tests', /)" mode="toc"/>
					</ul>
				</div>
				<section>
					<h2><xsl:value-of select="wcag:string('technique.header.applicability')"/></h2>
					<xsl:apply-templates select="wcag:real-content(wcag:id('applicability', /))"/>
				</section>
				<section>
					<h2><xsl:value-of select="wcag:string('technique.header.description')"/></h2>
					<xsl:apply-templates select="wcag:real-content(wcag:id('description', /))"/>
				</section>
				<xsl:if test="exists(wcag:id('examples', /))">
					<section>
						<h2><xsl:value-of select="wcag:string('technique.header.examples')"/></h2>
						<xsl:apply-templates select="wcag:real-content(wcag:id('examples', /))"/>
					</section>
				</xsl:if>
				<xsl:if test="exists(wcag:id('related', /))">
					<section>
						<h2><xsl:value-of select="wcag:string('technique.header.related')"/></h2>
						<xsl:apply-templates select="wcag:real-content(wcag:id('related', /))"/>
					</section>
				</xsl:if>
				<section>
					<h2><xsl:value-of select="wcag:string('technique.header.tests')"/></h2>
					<xsl:apply-templates select="wcag:real-content(wcag:id('tests', /))"/>
				</section>
				<div>Footer cruft</div>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="section" mode="toc">
		<li><a href="#{@id}"><xsl:value-of select="wcag:string(concat('technique.header.', @id))"/></a></li>
	</xsl:template>
	
	<xsl:template name="title">
		<xsl:value-of select="//h1[1]"/>
	</xsl:template>
</xsl:stylesheet>