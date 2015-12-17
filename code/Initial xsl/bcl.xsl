<?xml version='1.0'?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:bcl="http://www.gov.bc.ca/2013/bclegislation"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">



	<!-- TOC Mode -->

	<xsl:template match="bcl:part" mode="toc">
		<fo:block display-align="after" font-family="Times Roman" font-size="11pt" line-height="13pt" 
			font-weight="bold" text-indent="-3.5pc" start-indent="5.5pc" margin-top="6pt">
			<xsl:call-template name="smallCaps"><xsl:with-param name="text">Part</xsl:with-param></xsl:call-template> 
				<xsl:text> </xsl:text><xsl:value-of select="partnumber"/> &#8211; 
			<xsl:call-template name="smallCaps"><xsl:with-param name="text" select="parttext"/></xsl:call-template>
		</fo:block>
	</xsl:template>

	<xsl:template match="bcl:division" mode="toc">
		<fo:block font-family="Times Roman" font-size="10pt" line-height="12pt" font-weight="bold"
			text-indent="-3pc" start-indent="6pc">
			Division <xsl:value-of select="divisionnumber"/> &#8212; <xsl:value-of select="divisiontext"/>
		</fo:block>
	</xsl:template>

	<xsl:template match="bcl:section" mode="toc">

		<xsl:variable name="offset_left">
			<xsl:call-template name="getOffsetLeftPeriod">
				<xsl:with-param name="font_size">10</xsl:with-param>
				<xsl:with-param name="number" select="bcl:num"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="offset_right">
			<xsl:call-template name="getOffsetRightPeriod">
				<xsl:with-param name="font_size">10</xsl:with-param>
				<xsl:with-param name="number" select="bcl:num"/>
			</xsl:call-template>
		</xsl:variable>
			
		<fo:block font-family="Times Roman" font-size="10pt" line-height="13pt" margin-right="2pc"
			text-indent="-{18 + number($offset_left)}pt" start-indent="70pt">
			<xsl:apply-templates select="bcl:num" mode="toc"/><fo:leader leader-length="{18 - $offset_right}pt"/><xsl:apply-templates select="bcl:marginalnote" mode="toc"/>
		</fo:block>
	</xsl:template>

	<xsl:template match="bcl:num" mode="toc"><xsl:apply-templates/></xsl:template>
	<xsl:template match="bcl:marginalnote" mode="toc"><xsl:apply-templates/></xsl:template>

	<xsl:template match="bcl:schedule" mode="toc">
		<fo:block font-family="Times Roman" font-size="10pt" line-height="13pt"
			margin-left="4pt"><xsl:value-of select="scheduletitle"/></fo:block>
	</xsl:template>


	<!-- Contents -->

	<xsl:template match="bcl:preamble"><xsl:apply-templates/></xsl:template>

	<xsl:template match="bcl:preamble/bcl:marginalnote">
		<fo:block font-family="Helvetica" font-size="9pt" line-height="10pt" font-weight="bold" margin-top="1.5pc" keep-with-next="always">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="bcl:preamble/bcl:text">
		<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" margin-top="16pt" margin-bottom="18">
			<xsl:apply-templates/></fo:block>
	</xsl:template>

	<xsl:template match="bcl:section">
		<xsl:variable name="offset_left">
			<xsl:call-template name="getOffsetLeftPeriod">
				<xsl:with-param name="font_size">11</xsl:with-param>
				<xsl:with-param name="number" select="normalize-space(bcl:num)"/>
				<xsl:with-param name="font_type">TimesBold</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="offset_right">
			<xsl:call-template name="getOffsetRightPeriod">
				<xsl:with-param name="font_size">11</xsl:with-param>
				<xsl:with-param name="number" select="bcl:num"/>
				<xsl:with-param name="font_type">TimesBold</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="bcl:marginalnote"/>
			<xsl:choose>
				<xsl:when test="bcl:text">
					<fo:block font-family="Times Roman" font-size="11pt" line-height="15pt" start-indent="38pt" 
						text-indent="-{19 + $offset_left}pt" margin-top="4pt">
							<fo:inline font-weight="bold"><xsl:apply-templates select="bcl:num"/></fo:inline>
							<xsl:choose>
								<xsl:when test="$offset_right &gt; 19"><fo:leader leader-length="4pt"/></xsl:when>
								<xsl:otherwise><fo:leader leader-length="{19 - $offset_right}pt"/></xsl:otherwise>
							</xsl:choose><xsl:apply-templates select="bcl:text[1]"/>
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="sub_offset">
						<xsl:call-template name="getCharSize">
							<xsl:with-param name="font_size">11</xsl:with-param>
							<xsl:with-param name="text">(<xsl:value-of select="normalize-space(bcl:subsection[1]/bcl:num)"/>)</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<fo:block font-family="Times Roman" font-size="11pt" line-height="15pt" start-indent="66pt" 
						text-indent="-{6 + 36 + $offset_left}pt" margin-top="4pt">
						<fo:inline font-weight="bold"><xsl:apply-templates select="bcl:num"/></fo:inline><fo:leader leader-length="{36 - ($offset_right + $sub_offset)}pt"/>(<xsl:apply-templates select="bcl:subsection[1]/bcl:num"/>)<fo:leader leader-length="6pt"/><xsl:apply-templates select="bcl:subsection[1]/bcl:text[1]"/>
					</fo:block>
				</xsl:otherwise>
			</xsl:choose>
		<xsl:apply-templates select="*[not(self::bcl:num[not(preceding-sibling::bcl:num)]) and not(self::bcl:text[not(preceding-sibling::bcl:text)]) and not(self::bcl:marginalnote) and not(self::bcl:transitionalhead)]"/>
	</xsl:template>

	<xsl:template match="bcl:num|bcl:text|bcl:transitionalhead"><xsl:apply-templates/></xsl:template>

	<xsl:template match="bcl:marginalnote">
		<fo:block font-family="Helvetica" font-size="9pt" line-height="10pt" font-weight="bold" margin-top="1pc" keep-with-next="always">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="bcl:subsection[1]">
		<xsl:if test="parent::bcl:section/bcl:text or not(count(preceding-sibling::*[name()=name(current())])+1 = 1)">
			<xsl:variable name="offset_left">
				<xsl:call-template name="getCharSize">
					<xsl:with-param name="font_size">11</xsl:with-param>
					<xsl:with-param name="text">(<xsl:value-of select="bcl:num"/>)</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" start-indent="66pt" 
					text-indent="-{6 + $offset_left}pt" margin-bottom="6pt">
				(<xsl:apply-templates select="bcl:num"/>)<fo:leader leader-length="6pt"/>
				<xsl:apply-templates select="bcl:text[1]"/>
			</fo:block>
		</xsl:if>
		<xsl:apply-templates select="*[not(self::bcl:num) and not(self::bcl:text[not(preceding-sibling::bcl:text)])]"/>
	</xsl:template>

	<xsl:template match="bcl:definition">
		<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" margin-top="4pt"
			start-indent="5.75pc" text-indent="-1.5pc"><xsl:apply-templates/></fo:block>
	</xsl:template>

	<xsl:template match="bcl:definition/bcl:text"><xsl:apply-templates/></xsl:template>

	

	<xsl:template match="bcl:subsection">
		<xsl:variable name="offset_left">
			<xsl:call-template name="getCharSize">
				<xsl:with-param name="font_size">11</xsl:with-param>
				<xsl:with-param name="text">(<xsl:value-of select="bcl:num"/>)</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" start-indent="66pt" 
				text-indent="-{6 + $offset_left}pt" margin-bottom="6pt">
			(<xsl:apply-templates select="bcl:num"/>)<fo:leader leader-length="6pt"/>
			<xsl:apply-templates select="bcl:text[1]"/>
		</fo:block>
		<xsl:apply-templates select="*[not(self::bcl:num) and not(self::bcl:text[not(preceding-sibling::bcl:text)])]"/>
	</xsl:template>

	<xsl:template match="bcl:paragraph">
		<xsl:variable name="offset_left">
			<xsl:call-template name="getCharSize">
				<xsl:with-param name="font_size">11</xsl:with-param>
				<xsl:with-param name="text">(<xsl:value-of select="bcl:num"/>)</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt"
			start-indent="90pt" text-indent="-{6 + $offset_left}pt">
			(<xsl:apply-templates select="bcl:num"/>)<fo:leader leader-length="6pt"/><xsl:apply-templates select="bcl:text[1]"/>
		</fo:block>
		<xsl:apply-templates select="*[not(self::bcl:num) and not(self::bcl:text[not(preceding-sibling::bcl:text)])]"/>
	</xsl:template>


	<xsl:template match="bcl:subparagraph">
		<xsl:variable name="offset_marg">
			<xsl:call-template name="getCharSize">
				<xsl:with-param name="font_size">11</xsl:with-param>
				<xsl:with-param name="font_type">Times</xsl:with-param>
				<xsl:with-param name="text">(<xsl:value-of select="bcl:num"/>)</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" start-indent="118pt"
			text-indent="-{6 + ($offset_marg)}pt">(<xsl:apply-templates select="bcl:num"/>)<fo:leader leader-length="6pt"/><xsl:apply-templates select="bcl:text[1]"/>
		</fo:block>
		<xsl:apply-templates select="*[not(self::bcl:num) and not(self::bcl:text[not(preceding-sibling::bcl:text)])]"/>
	</xsl:template>

	<xsl:template match="bcl:link"><xsl:apply-templates/></xsl:template>

</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="http://www.bclaws.ca/civix/document/id/complete/statreg/96001_01/xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->