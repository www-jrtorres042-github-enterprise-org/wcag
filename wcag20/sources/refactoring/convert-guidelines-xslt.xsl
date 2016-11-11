<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs"
	version="2.0">
	
	<xsl:import href="convert-base.xslt"/>
	
	<xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes" />
	
	<xsl:template match="spec">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>]]></xsl:text>
		<xsl:text disable-output-escaping="yes"><![CDATA[<html lang="en_US" xml:lang="en_US" xmlns="http://www.w3.org/1999/xhtml">]]></xsl:text>
		<head>
			<title>
				<xsl:value-of select="header/title"/>
				<xsl:value-of select="header/version"/>
			</title>
			<script src="https://www.w3.org/Tools/respec/respec-w3c-common" class="remove"></script>
			<link rel="stylesheet" type="text/css" href="../css/sources.css"/>
			<link rel="stylesheet" type="text/css" href="../css/additional.css"/>
			<script class="remove">
				var respecConfig = {
				// embed RDFa data in the output
				trace:  true,
				useExperimentalStyles: true,
				doRDFa: '1.1',
				includePermalinks: true,
				permalinkEdge:     true,
				permalinkHide:     false,
				// specification status (e.g., WD, LC, NOTE, etc.). If in doubt use ED.
				specStatus:           "ED",
				//crEnd:                "2012-04-30",
				//perEnd:               "2013-07-23",
				//publishDate:          "2013-08-22",
				diffTool:             "http://www.aptest.com/standards/htmldiff/htmldiff.pl",
				
				// the specifications short name, as in https://www.w3.org/TR/short-name/
				shortName:            "WCAG21",
				
				
				// if you wish the publication date to be other than today, set this
				//publishDate:  "2014-12-11",
				copyrightStart:  "2017",
				
				// if there is a previously published draft, uncomment this and set its YYYY-MM-DD date
				// and its maturity status
				//previousPublishDate:  "2014-06-12",
				//previousMaturity:  "WD",
				prevRecURI: "http://www.w3.org/TR/2008/REC-WCAG20-20081211/",
				//previousDiffURI: "https://www.w3.org/TR/2014/REC-wai-aria-20140320/",
				
				// if there a publicly available Editors Draft, this is the link
				edDraftURI: "https://w3c.github.io/wcag21/",
				
				// if this is a LCWD, uncomment and set the end of its review period
				// lcEnd: "2012-02-21",
				
				// editors, add as many as you like
				// only "name" is required
				editors: [
				{
				name: "Andrew Kirkpatrick",
				url: "http://www.adobe.com/",
				mailto: "akirkpat@adobe.com",
				company: "Adobe Systems Inc.",
				companyURI: "http://www.adobe.com/",
				w3cid: 39770
				},
				{
				name: "Joshue O Connor",
				url: "http://interaccess.ie/",
				mailto: "josh@interaccess.ie",
				company: "Invited Expert, InterAccess",
				companyURI: "http://interaccess.ie/",
				w3cid: 41218
				},
				{
				name: "Michael Cooper",
				url: 'http://www.w3.org',
				mailto: "cooper@w3.org",
				company: "W3C",
				companyURI: "http://www.w3.org",
				w3cid: 34017
				}
				],
				
				// authors, add as many as you like.
				// This is optional, uncomment if you have authors as well as editors.
				// only "name" is required. Same format as editors.
				
				//authors:  [
				//    { name: "Your Name", url: "http://example.org/",
				//      company: "Your Company", companyURI: "http://example.com/" },
				//],
				
				/*
				alternateFormats: [
				{ uri: 'wcag21-diff.html', label: "Diff from Previous Recommendation" } ,
				{ uri: 'wcag21.ps', label: "PostScript version" },
				{ uri: 'wcag21.pdf', label: "PDF version" }
				],
				*/
				
				// errata: 'http://www.w3.org/2010/02/rdfa/errata.html',
				
				// name of the WG
				wg:           "Accessibility Guidelines Working Group",
				
				// URI of the public WG page
				wgURI:        "http://www.w3.org/WAI/GL/",
				
				// name (with the @w3c.org) of the public mailing to which comments are due
				wgPublicList: "public-comments-wcag20",
				
				// URI of the patent status for this WG, for Rec-track documents
				// !!!! IMPORTANT !!!!
				// This is important for Rec-track documents, do not copy a patent URI from a random
				// document unless you know what you're doing. If in doubt ask your friendly neighbourhood
				// Team Contact.
				wgPatentURI:  "https://www.w3.org/2004/01/pp-impl/35422/status",
				maxTocLevel: 4,
				
				};
			</script>
			<style type="text/css">
				.principle h2::before {
				content: "Principle ";
				}
				.guideline h3::before {
				content: "Guideline ";
				}
				.sc h4::before {
				content: "Success Criterion ";
				}
				.conformance-level {
				display: inline;
				}
				.conformance-level::before {
				content: "(Level ";
				}
				.conformance-level::after {
				content: ")";
				}
				.change {
				display: inline;
				}
				.change::before {
				content: "[";
				}
				.change::after {
				content: "]";
				}
			</style>
		</head>
		<body>
			<xsl:apply-templates select="header/abstract"/>
			<xsl:apply-templates select="header/status"/>
			<!-- <main> -->
				<xsl:apply-templates select="front"/>
				<xsl:apply-templates select="body"/>
				<xsl:apply-templates select="back"/>
			<!-- </main> -->
		</body>
		<xsl:text disable-output-escaping="yes"><![CDATA[</html>]]></xsl:text>
	</xsl:template>
	
	<xsl:template match="div1[@id = 'guidelines']">
		<xsl:apply-templates select="div2"/>
	</xsl:template>
	
	<xsl:template match="div2[@role = 'principle']">
		<section class="principle">
			<xsl:apply-templates select="node()|@*"/>
		</section>
	</xsl:template>
	
	<xsl:template match="div2[@role = 'principle']/head">
		<h2><xsl:value-of select="substring-after(substring-before(., '-'), ':')"/></h2>
		<p><xsl:value-of select="substring-after(., '-')"/></p>
	</xsl:template>
	
	<xsl:template match="div3[@role = 'group1']">
		<section class="guideline">
			<xsl:apply-templates/>
		</section>
	</xsl:template>
	
	<xsl:template match="div3[@role = 'group1']/head">
		<h3>@@</h3>
		<p><xsl:value-of select="."/></p>
	</xsl:template>
	
	<xsl:template match="div4[@role = 'req' or @role = 'bp' or @role = 'additional']">
		<xsl:apply-templates select="div5"/>
	</xsl:template>
	
	<xsl:template match="div5[@role = 'sc']">
		<section class="sc">
			<h4><xsl:value-of select="head"/></h4>
			<p class="conformance-level">
				<xsl:choose>
					<xsl:when test="../@role = 'req'">A</xsl:when>
					<xsl:when test="../@role = 'bp'">AA</xsl:when>
					<xsl:when test="../@role = 'additional'">AAA</xsl:when>
				</xsl:choose>
			</p>
			<p class="change">Unchanged</p>
			<xsl:apply-templates select="p | ulist"/>
		</section>
	</xsl:template>
	
	<xsl:template match="div5[@role = 'sc']/ulist">
		<dl>
			<xsl:apply-templates/>
		</dl>
	</xsl:template>
	
	<xsl:template match="div5[@role = 'sc']/ulist/item">
		<dt><xsl:value-of select="substring-before(p/emph[@role = 'sc-handle'], ':')"/></dt>
		<dd><xsl:apply-templates/></dd>
	</xsl:template>
	
	<xsl:template match="emph[@role = 'sc-handle']"/>
	
</xsl:stylesheet>