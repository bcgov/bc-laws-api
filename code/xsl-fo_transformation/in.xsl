<?xml version='1.0'?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:in="http://www.qp.gov.bc.ca/2013/inline"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:template match="in:term"><fo:inline font-weight="bold">&#8220;<xsl:apply-templates/>&#8221;</fo:inline></xsl:template>

<xsl:template match="in:doc"><fo:inline font-style="italic"><xsl:apply-templates/></fo:inline></xsl:template>

</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->