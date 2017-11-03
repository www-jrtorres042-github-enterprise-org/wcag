<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:wcag="https://www.w3.org/WAI/GL/"
	exclude-result-prefixes="xs"
	version="2.0">
	
	<xsl:import href="convert-base.xslt"/>
	
	<xsl:param name="output.base">../../../../wcag21/techniques/</xsl:param>
	
	<xsl:output method="xhtml" encoding="UTF-8" omit-xml-declaration="yes" indent="no" />
	
	<xsl:preserve-space elements="pre code codeblock"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="//body/div1"/>
	</xsl:template>
	
	<xsl:template match="div1">
		<xsl:apply-templates select="technique">
			<xsl:with-param name="tech" select="@id" tunnel="yes"/>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="technique">
		<xsl:param name="tech" tunnel="yes"/>
		<xsl:variable name="filename" select="@id"/>
		<xsl:result-document href="{$output.base}{$tech}/{$filename}.html">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>]]></xsl:text>
			<xsl:text disable-output-escaping="yes"><![CDATA[<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">]]></xsl:text>
			
			<head>
				<title><xsl:value-of select="short-name"/></title>
				<link rel="stylesheet" type="text/css" href="../../css/sources.css" class="remove" />
			</head>
			<body>
				<xsl:apply-templates select="short-name"/>
				<section class="meta">
					<p class="id">ID: <xsl:value-of select="@id"/></p>
					<p class="technology">Technology: <xsl:value-of select="$tech"/></p>
					<p class="type">Type: <xsl:choose>
						<xsl:when test="$tech = 'failures'">Failure</xsl:when>
						<xsl:otherwise>Technique</xsl:otherwise>
					</xsl:choose></p>
				</section>
				<xsl:apply-templates select="applicability"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="examples"/>
				<xsl:apply-templates select="tests"/>
				<xsl:apply-templates select="related-techniques"/>
				<xsl:apply-templates select="resources"/>
			</body>
			
			<xsl:text disable-output-escaping="yes"><![CDATA[</html>]]></xsl:text>
		</xsl:result-document>
	</xsl:template>
	
	<xsl:template match="short-name">
		<h1><xsl:apply-templates/></h1>
	</xsl:template>
	
	<xsl:template match="applicability">
		<section class="applicability">
			<h2>When to Use</h2>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="description" priority="-.5">
		<section class="description">
			<h2>Description</h2>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="examples">
		<section class="examples">
			<h2>Examples</h2>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="resources">
		<section class="resources">
			<h2>Resources</h2>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="related-techniques">
		<section class="related">
			<h2>Related Techniques</h2>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="tests">
		<section class="tests">
			<h2>Tests</h2>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="procedure">
		<section class="procedure">
			<h3>Procedure</h3>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="expected-results">
		<section class="results">
			<h3>Expected Results</h3>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
</xsl:stylesheet>