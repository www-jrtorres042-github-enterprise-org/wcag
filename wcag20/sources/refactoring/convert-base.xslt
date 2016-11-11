<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs"
	version="2.0">
	
	<xsl:template match="abstract">
		<section id="abstract">
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="status">
		<section id="sotd">
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="p">
		<p><xsl:apply-templates select="node()|@*"/></p>
	</xsl:template>
	
	<xsl:template match="p[termref/@def = 'informativedef' or termref/@def = 'normativedef']"/>
	
	<xsl:template match="emph">
		<xsl:variable name="el">
			<xsl:choose>
				<xsl:when test="@role = 'bold'">strong</xsl:when>
				<xsl:otherwise>em</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:element name="{$el}">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="div1 | div2 | div3 | div4 | div5 | div6 | inform-div1 | inform-div2 | inform-div3 | inform-div4 | inform-div5 | inform-div6">
		<section>
			<xsl:if test="p/termref/@def = 'informativedef'">
				<xsl:attribute name="class">informative</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="head">
		<xsl:variable name="level"><xsl:value-of select="substring-after(name(parent::node()), 'div')"></xsl:value-of></xsl:variable>
		<xsl:element name="h{$level}"><xsl:apply-templates/></xsl:element>
	</xsl:template>
	
	<xsl:template match="ulist">
		<ul>
			<xsl:apply-templates select="node()|@*"/>
		</ul>
	</xsl:template>
	
	<xsl:template match="olist">
		<ol>
			<xsl:apply-templates select="node()|@*"/>
		</ol>
	</xsl:template>
	
	<xsl:template match="item">
		<xsl:choose>
			<xsl:when test="count(element()) &gt; 1"><xsl:apply-templates/></xsl:when>
			<xsl:otherwise><xsl:apply-templates select="element()/node()"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="glist">
		<dl>
			<xsl:apply-templates select="node()|@*"/>
		</dl>
	</xsl:template>
	
	<xsl:template match="gitem">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="gitem/label">
		<dt><dfn><xsl:apply-templates/></dfn></dt>
	</xsl:template>
	
	<xsl:template match="gitem/def">
		<dd><xsl:apply-templates/></dd>
	</xsl:template>
	
	<xsl:template match="termref">
		<a>
			<xsl:apply-templates/>
		</a>
	</xsl:template>
	
	<xsl:template match="specref">
		<a href="#{@ref}"></a>
	</xsl:template>
	
	<xsl:template match="loc">
		<a href="{@href}"><xsl:apply-templates/></a>
	</xsl:template>
	
	<xsl:template match="@*">
		<xsl:copy/>
	</xsl:template>
	
	<xsl:template match="@role"/>
	
</xsl:stylesheet>