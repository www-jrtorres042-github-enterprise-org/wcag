<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:wcag="http://www.w3.org/WAI/GL/WCAG20/sources/"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	xpath-default-namespace="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="#all"
	version="2.0">
	
	<!-- Identify the language in use. -->
	<xsl:param name="lang">en</xsl:param>
	<!-- Determine the strings file to load. -->
	<xsl:param name="strings.file">strings.<xsl:value-of select="$lang"/>.xml</xsl:param>
	<!-- Identify the publication date -->
	<xsl:param name="pubdate" select="current-date()"/>
	<!-- Locate the Understanding file -->
	<xsl:param name="understanding.file">../guide-to-wcag2-src.xml</xsl:param>
	
	<!-- Load the strings doc. -->
	<xsl:variable name="strings.doc" select="document($strings.file)"/>
	<!-- Load the Understanding doc. -->
	<xsl:variable name="understanding.doc" select="document($understanding.file)"/>
	<!-- Set the root element as the default context doc so functions can look in it. -->
	<xsl:variable name="doc" select="/"/>
	
	<!-- Define a key for the strings doc. -->
	<xsl:key name="strings" match="wcag:string" use="@key"/>
	
	<!-- Look up a value from the localized strings file. -->
	<xsl:function name="wcag:string">
		<xsl:param name="string"/>
		<xsl:variable name="result" select="$strings.doc/key('strings', $string)/node()"/>
		<xsl:choose>
			<xsl:when test="$result">
				<xsl:copy-of select="$result"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>String lookup failed: <xsl:value-of select="$string"/></xsl:message>
				<xsl:value-of select="$string"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	
	<!-- Get content of an element, excluding template headers and other cruft. -->
	<xsl:function name="wcag:real-content">
		<xsl:param name="el"/>
		<xsl:for-each select="$el/node()">
			<xsl:if test="not(wcag:is-header(.))">
				<xsl:copy-of select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:function>
	
	<!-- Test if an element is a header, because we often want to ignore template headers -->
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
	
	<!-- Get an element by id. This is needed because HTML 5 doesn't use a DTD so doesn't recognize the id attribute as an XML id. -->
	<xsl:function name="wcag:id">
		<xsl:param name="id"/>
		<xsl:copy-of select="$doc//*[@id = $id]"/>
	</xsl:function>
	
	<!-- Get an element by class name. -->
	<xsl:function name="wcag:class">
		<xsl:param name="class"/>
		<xsl:copy-of select="$doc//*[@class = $class]"/>
	</xsl:function>
	
	<!-- Give the proper heading tag for the nesting level -->
	<xsl:template name="wcag:header">
		<xsl:param name="el" select="."/>
		<xsl:param name="adjustment">0</xsl:param>
		<xsl:text>h</xsl:text>
		<xsl:value-of select="count($el/ancestor-or-self::section) + count($el/ancestor-or-self::body) + $adjustment"/>
	</xsl:template>
	
	<!-- Don't output template instructions. -->
	<xsl:template match="*[@class = 'instructions']"/>
	
	<!-- Basic "copy it if no other actions defined" template. -->
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template name="copyright">
		<p class="copyright"><a href="http://www.w3.org/Consortium/Legal/ipr-notice#Copyright">Copyright</a> © <xsl:value-of select="year-from-date($pubdate)"/> <a href="http://www.w3.org/"><abbr title="World Wide Web Consortium">W3C</abbr></a><sup>®</sup> (<a href="http://www.csail.mit.edu/"><abbr title="Massachusetts Institute of Technology">MIT</abbr></a>, <a href="http://www.ercim.eu/"><abbr title="European Research Consortium for Informatics and Mathematics">ERCIM</abbr></a>, <a href="http://www.keio.ac.jp/">Keio</a>, <a href="http://ev.buaa.edu.cn/">Beihang</a>). W3C <a href="http://www.w3.org/Consortium/Legal/ipr-notice#Legal_Disclaimer">liability</a>, <a href="http://www.w3.org/Consortium/Legal/ipr-notice#W3C_Trademarks">trademark</a> and <a href="http://www.w3.org/Consortium/Legal/copyright-documents">document use</a> rules apply.</p>
	</xsl:template>
</xsl:stylesheet>