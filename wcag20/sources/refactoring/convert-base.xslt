<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:wcag="https://www.w3.org/WAI/GL/"
	exclude-result-prefixes="xs"
	version="2.0">
	
	<xsl:param name="loc.guidelines">https://www.w3.org/TR/WCAG20/</xsl:param>
	<xsl:param name="loc.understanding">https://www.w3.org/TR/UNDERSTANDING-WCAG20/</xsl:param>
	<xsl:param name="loc.techniques">https://www.w3.org/TR/WCAG20-TECHS/</xsl:param>
	<xsl:param name="loc.examples">https://www.w3.org/WAI/WCAG20/Techniques/working-examples/</xsl:param>
	
	<xsl:function name="wcag:sc-id">
		<xsl:param name="sc-title"/>
		<xsl:value-of select="lower-case(replace(replace($sc-title, ' ', '-'), '[,()]', ''))"/>
	</xsl:function>
	
	<xsl:function name="wcag:get-handle-from-element">
		<xsl:param name="sc"/>
		<xsl:choose>
			<xsl:when test="$sc/@role = 'sc'"><xsl:value-of  select="$sc/head/text()"/></xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$sc/@id = 'perceivable'">Perceivable</xsl:when>
					<xsl:when test="$sc/@id = 'text-equiv'">Text Alternative</xsl:when>
					<xsl:when test="$sc/@id = 'media-equiv'">Time-Based Media</xsl:when>
					<xsl:when test="$sc/@id = 'content-structure-separation'">Adaptable</xsl:when>
					<xsl:when test="$sc/@id = 'visual-audio-contrast'">Distinguishable</xsl:when>
					<xsl:when test="$sc/@id = 'operable'">Operable</xsl:when>
					<xsl:when test="$sc/@id = 'keyboard-operation'">Keyboard Accessible</xsl:when>
					<xsl:when test="$sc/@id = 'time-limits'">Enough Time</xsl:when>
					<xsl:when test="$sc/@id = 'seizure'">Seizures</xsl:when>
					<xsl:when test="$sc/@id = 'navigation-mechanisms'">Navigable</xsl:when>
					<xsl:when test="$sc/@id = 'understandable'">Understandable</xsl:when>
					<xsl:when test="$sc/@id = 'meaning'">Readable</xsl:when>
					<xsl:when test="$sc/@id = 'consistent-behavior'">Predictable</xsl:when>
					<xsl:when test="$sc/@id = 'minimize-error'">Input Assistance</xsl:when>
					<xsl:when test="$sc/@id = 'robust'">Robust</xsl:when>
					<xsl:when test="$sc/@id = 'ensure-compat'">Compatible</xsl:when>
					<xsl:when test="$sc/@id = 'conformance'">Conformance</xsl:when>
					<xsl:otherwise>UNKNOWN</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	
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
		<li>
			<xsl:choose>
				<xsl:when test="count(element()) &gt; 1"><xsl:apply-templates/></xsl:when>
				<xsl:otherwise><xsl:apply-templates select="element()/node()"/></xsl:otherwise>
			</xsl:choose>
		</li>
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
		<xsl:variable name="target">
			<xsl:choose>
				<xsl:when test="not(@linktype)"><xsl:value-of select="@href"/></xsl:when>
				<xsl:when test="@linktype = 'understanding'"><xsl:value-of select="$loc.understanding"/><xsl:value-of select="@href"/></xsl:when>
				<xsl:when test="index-of(('techniques', 'aria', 'css', 'html', 'failure', 'flash', 'general', 'pdf', 'silverlight', 'text', 'script', 'server', 'smil'), @linktype)"><xsl:value-of select="$loc.techniques"/><xsl:value-of select="@href"/></xsl:when>
				<xsl:when test="index-of(('glossary', 'guideline'), @linktype)"><xsl:value-of select="$loc.guidelines"/>#<xsl:value-of select="@href"/></xsl:when>
				<xsl:when test="@linktype = 'examples'"><xsl:value-of select="$loc.examples"/><xsl:value-of select="@href"/></xsl:when>
				<xsl:otherwise><xsl:message>linktype: <xsl:value-of select="@linktype"/></xsl:message><xsl:value-of select="@href"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<a href="{$target}"><xsl:apply-templates/></a>
	</xsl:template>
	
	<xsl:template match="bibref">
		<xsl:text>[[</xsl:text>
		<xsl:value-of select="@ref"/>
		<xsl:text>]]</xsl:text>
	</xsl:template>
	
	<xsl:template match="eg-group">
		<section class="example">
			<xsl:apply-templates></xsl:apply-templates>
		</section>
	</xsl:template>
	
	<xsl:template match="eg-group/head">
		<h3>Example <xsl:value-of select="count(parent::eg-group/preceding-sibling::eg-group) + 1"/>: <xsl:apply-templates/></h3>
	</xsl:template>
	
	<xsl:template match="eg-group/description">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="codeblock" xml:space="preserve">
		<pre xml:space="preserve">
			<xsl:apply-templates/>
		</pre>
	</xsl:template>
	
	<xsl:template match="note">
		<div class="note">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	
	<xsl:template match="id('references')"/>
	
	<xsl:template match="@*">
		<xsl:copy/>
	</xsl:template>
	
	<xsl:template match="@role | @diff"/>
	
</xsl:stylesheet>