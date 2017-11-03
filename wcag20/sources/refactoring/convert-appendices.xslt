<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:wcag="https://www.w3.org/WAI/GL/"
	exclude-result-prefixes="xs"
	version="2.0">
	
	<xsl:import href="convert-understanding.xslt"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="//back/inform-div1[@id='conformance-referencing' or @id='accessibility-support-documenting' or @id='understanding-metadata']"/>
	</xsl:template>
	
	<xsl:template match="inform-div1">
		<xsl:result-document href="{$output.base}{@id}.html">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>]]></xsl:text>
			<xsl:text disable-output-escaping="yes"><![CDATA[<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">]]></xsl:text>
			
			<head>
				<title><xsl:value-of select="head"/></title>
				<link rel="stylesheet" type="text/css" href="../../css/sources.css" class="remove" />
			</head>
			<body>
				<h1><xsl:value-of select="head"/></h1>
				<xsl:apply-templates/>
			</body>
			<xsl:text disable-output-escaping="yes"><![CDATA[</html>]]></xsl:text>
		</xsl:result-document>
	</xsl:template>
	
	<xsl:template match="div2/head | div3/head | div4/head | div5/head">
		<xsl:variable name="level"><xsl:value-of select="substring-after(name(parent::node()), 'div')"></xsl:value-of></xsl:variable>
		<xsl:element name="h{$level}"><xsl:apply-templates/></xsl:element>
	</xsl:template>
	
	<xsl:template match="inform-div1/head"/>
</xsl:stylesheet>