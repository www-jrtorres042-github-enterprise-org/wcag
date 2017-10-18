<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:wcag="https://www.w3.org/WAI/GL/"
	exclude-result-prefixes="xs"
	version="2.0">
	
	<xsl:import href="convert-understanding.xslt"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="//body/div1[@id = 'conformance']/div2"/>
	</xsl:template>
	
	<xsl:template match="div2">
		<xsl:variable name="sc" select="$guidelines.doc//*[@id = current()/@id]"/>
		<xsl:result-document href="{$output.base}conformance.html">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>]]></xsl:text>
			<xsl:text disable-output-escaping="yes"><![CDATA[<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">]]></xsl:text>
			
			<head>
				<title>Understanding Conformance</title>
				<link rel="stylesheet" type="text/css" href="../../css/sources.css" class="remove" />
			</head>
			<body>
				<h1>Understanding Conformance</h1>
				<xsl:apply-templates/>
			</body>
			<xsl:text disable-output-escaping="yes"><![CDATA[</html>]]></xsl:text>
		</xsl:result-document>
	</xsl:template>
	
	<xsl:template match="example">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="div3[@id = 'conformance-terms']"/>
	
	<xsl:template match="div3/head | div4/head | div5/head">
		<xsl:variable name="level"><xsl:value-of select="substring-after(name(parent::node()), 'div')"></xsl:value-of></xsl:variable>
		<xsl:element name="h{$level}"><xsl:apply-templates/></xsl:element>
	</xsl:template>
</xsl:stylesheet>