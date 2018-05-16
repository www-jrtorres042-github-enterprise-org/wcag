<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:wcag="https://www.w3.org/WAI/GL/"
	exclude-result-prefixes="#all"
	version="2.0">
	
	<xsl:import href="convert-base.xslt"/>
	
	<xsl:param name="output.base">../../../../wcag21/understanding/20/</xsl:param>
	
	<xsl:param name="guidelines.file">../wcag2-src.xml</xsl:param>
	<xsl:variable name="guidelines.doc" select="document($guidelines.file)"/>
	
	<xsl:output method="xhtml" encoding="UTF-8" omit-xml-declaration="yes" />
	
	<xsl:template match="/">
		<xsl:apply-templates select="//body/div1"/>
	</xsl:template>
	
	<xsl:template match="div1 | div2[@role='extsrc']">
		<xsl:variable name="sc" select="$guidelines.doc//*[@id = current()/@id]"/>
		<xsl:variable name="sc-title" select="wcag:get-handle-from-element($sc)"/>
		<xsl:variable name="sc-id" select="wcag:sc-id($sc-title)"/>
		<xsl:result-document href="{$output.base}{$sc-id}.html" exclude-result-prefixes="#all">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>
]]></xsl:text>
			<xsl:text disable-output-escaping="yes"><![CDATA[<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
]]></xsl:text>
			<meta charset="UTF-8"/>
			
			<head>
				<title>Understanding <xsl:value-of select="$sc-title"/></title>
				<link rel="stylesheet" type="text/css" href="../../css/sources.css" class="remove" />
			</head>
			<body>
				<h1>Understanding <xsl:value-of select="$sc-title"/></h1>
				<blockquote class="scquote" data-include="../../sc/20/{$sc-id}.html">SC text</blockquote>
				<xsl:apply-templates>
					<xsl:with-param name="sc-title" select="$sc-title" tunnel="yes"/>
					<xsl:with-param name="sc-id" select="$sc-id" tunnel="yes"/>
				</xsl:apply-templates>
			</body>
	
			<xsl:text disable-output-escaping="yes"><![CDATA[
</html>
]]></xsl:text>
		</xsl:result-document>
	</xsl:template>
		
	<xsl:template match="*[@role = 'intent' or @role = 'glintent']">
		<xsl:param name="sc-title" tunnel="yes" />
		<xsl:param name="sc-id" tunnel="yes" />
		<section id="intent">
			<h2>Intent of <xsl:value-of select="$sc-title"/></h2>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="*[@role = 'benefits']">
		<xsl:param name="sc-title" tunnel="yes" />
		<xsl:param name="sc-id" tunnel="yes" />
		<section id="benefits">
			<h3>Benefits of <xsl:value-of select="$sc-title"/></h3>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="*[@role = 'examples']">
		<xsl:param name="sc-title" tunnel="yes" />
		<xsl:param name="sc-id" tunnel="yes" />
		<section id="examples">
			<h2>Examples of <xsl:value-of select="$sc-title"/></h2>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="*[@role = 'resources']">
		<xsl:param name="sc-title" tunnel="yes" />
		<xsl:param name="sc-id" tunnel="yes" />
		<section id="resources">
			<h2>Resources for <xsl:value-of select="$sc-title"/></h2>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="*[@role = 'techniques']">
		<xsl:param name="sc-title" tunnel="yes" />
		<xsl:param name="sc-id" tunnel="yes" />
		<section id="techniques">
			<h2>Techniques for <xsl:value-of select="$sc-title"/></h2>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="*[@role = 'sufficient']">
		<xsl:param name="sc-title" tunnel="yes" />
		<xsl:param name="sc-id" tunnel="yes" />
		<section id="sufficient">
			<h3>Sufficient Techniques for <xsl:value-of select="$sc-title"/></h3>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="*[@role = 'tech-optional' or @role = 'gladvisory']">
		<xsl:param name="sc-title" tunnel="yes" />
		<xsl:param name="sc-id" tunnel="yes" />
		<section id="advisory">
			<h3>Additional Techniques (Advisory) for <xsl:value-of select="$sc-title"/></h3>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="*[@role = 'failures']">
		<xsl:param name="sc-title" tunnel="yes" />
		<xsl:param name="sc-id" tunnel="yes" />
		<section id="failure">
			<h3>Common Failures for <xsl:value-of select="$sc-title"/></h3>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="*[@role = 'situation']">
		<xsl:param name="sc-title" tunnel="yes" />
		<xsl:param name="sc-id" tunnel="yes" />
		<section class="situation" id="{$sc-id}-situation-{count(preceding-sibling::div5)}">
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="*[@role = 'situation']/head">
		<h4><xsl:apply-templates/></h4>
	</xsl:template>
	
	<xsl:template match="div1/head | div2/head | div3/head | div4/head | div5/head" priority="-.5"/>
	
	<xsl:template match="specref">
		<xsl:variable name="sc" select="$guidelines.doc//*[@id = current()/@ref]"/>
		<xsl:variable name="sc-title" select="wcag:get-handle-from-element($sc)"/>
		<xsl:variable name="sc-id" select="wcag:sc-id($sc-title)"/>
		<a href="{$sc-id}"><xsl:number count="div2[@role = 'principle'] | div3[@role = 'group1'] | div5[@role = 'sc']" level="multiple" select="$sc" format="1.1.1"/>: <xsl:value-of select="$sc-title"/></a>
	</xsl:template>
			
	
</xsl:stylesheet>