<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:wcag="http://www.w3.org/WAI/GL/WCAG20/sources/"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="#all"
	version="2.0">
	
	<xsl:import href="base.xslt"/>
	
	<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="html:html/html:body"/>
	</xsl:template>
	
	<xsl:template match="html:body">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;&#10;</xsl:text>
		<html lang="{$lang}">
			<head>
				<title><xsl:call-template name="title"/> - WCAG 2.0 Techniques</title>
				<link rel="canonical" href="@@"/>
				<link rel="stylesheet" type="text/css" href="http://www.w3.org/StyleSheets/TR/W3C-ED.css"/>
				<link rel="stylesheet" type="text/css" href="additional.css"/>
				<link rel="stylesheet" type="text/css" href="slicenav.css"/>
			</head>
			<body>
				<xsl:call-template name="header"/>
				<xsl:variable name="header">
					<xsl:call-template name="wcag:header"/>
				</xsl:variable>
				<xsl:element name="{$header}">
					<xsl:call-template name="title"/>
				</xsl:element>
				<p><xsl:call-template name="tech-id"/>: <xsl:call-template name="tech-type"/> for <xsl:call-template name="tech-technology"/></p>
				<section>
					<xsl:variable name="header">
						<xsl:call-template name="wcag:header">
							<xsl:with-param name="adjustment">1</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:element name="{$header}">
						<xsl:value-of select="wcag:string('technique.header.disclaimer')"/>
					</xsl:element>
					<p><xsl:value-of select="wcag:string('technique.disclaimer')"/></p>
				</section>
				<xsl:apply-templates select="html:section[@class = 'applicability']"/>
				<xsl:apply-templates select="html:section[@class = 'description']"/>
				<xsl:apply-templates select="html:section[@class = 'examples']"/>
				<xsl:apply-templates select="html:section[@class = 'related']"/>
				<xsl:apply-templates select="html:section[@class = 'tests']"/>
				<xsl:call-template name="footer"/>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="html:section">
		<xsl:variable name="string.header">
			<xsl:text>technique.header.</xsl:text>
			<xsl:value-of select="@class"/>
		</xsl:variable>
		<xsl:copy>
			<xsl:if test="not(@id) and @class">
				<xsl:attribute name="id">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*"/>
			<xsl:variable name="header">
				<xsl:call-template name="wcag:header"/>
			</xsl:variable>
			<xsl:element name="{$header}">
				<xsl:value-of select="wcag:string($string.header)"/>
			</xsl:element>
			<xsl:apply-templates/>
			<xsl:if test="@class = 'applicability'">
				<p>This technique relates to:</p>
				<ul>
					<xsl:call-template name="sc-references"/>
				</ul>
			</xsl:if>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6"/>
	
	<xsl:template match="html:section" mode="toc">
		<li><a href="#{@class}"><xsl:value-of select="wcag:string(concat('technique.header.', @class))"/></a></li>
	</xsl:template>
	
	<xsl:template name="title">
		<xsl:value-of select="//html:h1[1]"/>
	</xsl:template>
	
	<xsl:template name="sc-references">
		<xsl:variable name="id">
			<xsl:call-template name="tech-id"/>
		</xsl:variable>
		<xsl:apply-templates select="$understanding.doc//loc[@href = $id][ancestor::div3/@role = 'techniques']" mode="sc-references"/>
	</xsl:template>
	
	<xsl:template match="loc" mode="sc-references">
		<xsl:variable name="sc-link">
			<xsl:call-template name="sc-link"/>
		</xsl:variable>
		<xsl:variable name="sc-num">
			<xsl:call-template name="sc-num"/>
		</xsl:variable>
		<xsl:variable name="sc-handle">
			<xsl:call-template name="sc-handle"/>
		</xsl:variable>
		<xsl:variable name="sc-text">
			<xsl:call-template name="sc-text"/>
		</xsl:variable>
		<xsl:variable name="tech-sufficiency">
			<xsl:call-template name="tech-sufficiency"/>
		</xsl:variable>
		<li>
			<a href="{$sc-link}"><xsl:value-of select="$sc-num"/> <xsl:value-of select="$sc-handle"/>: <xsl:value-of select="$sc-text"/> (<xsl:value-of select="wcag:string(concat('technique.sufficiency.', $tech-sufficiency))"/>)</a>
		</li>
	</xsl:template>
	
	<xsl:template name="sc-link">
		<xsl:param name="el" select="."/>
		<xsl:text>../</xsl:text>
		<xsl:value-of select="$el/ancestor-or-self::div2/@id"/>
	</xsl:template>
	
	<xsl:template name="sc-num">
		<xsl:param name="el" select="."/>
		<xsl:value-of select="$el/ancestor-or-self::div2/head"/>
	</xsl:template>
	
	<xsl:template name="sc-handle">
		<xsl:text>@@</xsl:text>
	</xsl:template>
	
	<xsl:template name="sc-text">
		<xsl:text>@@</xsl:text>
	</xsl:template>
	
	<xsl:template name="tech-sufficiency">
		<xsl:param name="el" select="."/>
		<xsl:choose>
			<xsl:when test="$el/ancestor-or-self::div4/@role = 'sufficient'">sufficient</xsl:when>
			<xsl:when test="$el/ancestor-or-self::div4/@role = 'tech-optional'">advisory</xsl:when>
			<xsl:when test="$el/ancestor-or-self::div4/@role = 'failures'">failure</xsl:when>
			<xsl:otherwise>
				<xsl:message>Looking for technique sufficiency found <xsl:value-of select="$el/ancestor-or-self::div4/@role"/></xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="tech-id">
		<xsl:value-of select="normalize-space(substring-after(ancestor-or-self::html:body/html:section[@class = 'meta']/html:p[@class = 'id'], ':'))"/>
	</xsl:template>
	
	<xsl:template name="tech-technology">
		<xsl:value-of select="normalize-space(substring-after(ancestor-or-self::html:body/html:section[@class = 'meta']/html:p[@class = 'technology'], ':'))"/>
	</xsl:template>
	
	<xsl:template name="tech-type">
		<xsl:value-of select="normalize-space(substring-after(ancestor-or-self::html:body/html:section[@class = 'meta']/html:p[@class = 'type'], ':'))"/>
	</xsl:template>
	
	<xsl:template name="header">
		<div id="masthead">
			<p class="logo"><a href="http://www.w3.org/"><img width="72" height="48" alt="W3C" src="http://www.w3.org/Icons/w3c_home"/></a></p>
			<p class="collectiontitle"><a href="./">Techniques for WCAG 2.0</a></p>
		</div>
		<div id="skipnav"><p class="skipnav"><a href="#maincontent">Skip to Content (Press Enter)</a></p></div>
		<a id="top">&#x200B;</a>
		<ul id="navigation">
			<xsl:call-template name="navigation"/>
		</ul>
		<div class="navtoc">
			<p>On this page</p>
			<ul id="navbar">
				<li><a href="#disclaimer"><xsl:value-of select="wcag:string('technique.header.disclaimer')"/></a></li>
				<xsl:apply-templates select="html:section[@class = 'applicability'], html:section[@class = 'description'], html:section[@class = 'examples'], html:section[@class = 'related'], html:section[@class = 'tests']" mode="toc"/>
			</ul>
		</div>
		<div class="skiptarget">
			<a id="maincontent">-</a>
		</div>
	</xsl:template>
	
	<xsl:template name="footer">
		<ul id="navigationbottom">
			<li><strong><a href="#top">Top</a></strong></li>
			<xsl:call-template name="navigation"/>
		</ul>
		<div class="footer">
			<p>This Web page is part of <a href="Overview.html">Techniques and Failures for Web Content Accessibility Guidelines 2.0</a> (see the <a href="http://www.w3.org/WAI/GL/WCAG20-TECHS/H2.html">latest version of this document</a>). The entire document is also available as a <a href="complete.html">single HTML file</a>. See the <a href="http://www.w3.org/WAI/intro/wcag20">The WCAG 2.0 Documents</a> for an explanation of how this document fits in with other Web Content Accessibility Guidelines (WCAG) 2.0 documents. To send public comments, please follow the <a href="http://www.w3.org/WAI/WCAG20/comments/">Instructions for Commenting on WCAG 2.0 Documents</a>.</p>
			<xsl:call-template name="copyright"/>
		</div>
	</xsl:template>
	
	<xsl:template name="navigation">
		<li><strong><a href="Overview.html#contents" title="Table of Contents">Contents</a></strong></li>
		<li><strong><a href="intro.html" title="Introduction to Techniques for WCAG 2.0"><abbr title="Introduction">Intro</abbr></a></strong></li>
		<li><a title="G206: Providing options within the content to switch to a layout that does not require the user to scroll horizontally to read a line of text" href="G206.html"><strong>Previous: </strong> Technique G206</a></li>
		<li><a title="H4: Creating a logical tab order through links, form controls, and objects" href="H4.html"><strong>Next: </strong> Technique H4</a></li>
	</xsl:template>
</xsl:stylesheet>