<?xml version="1.0"?>
<xsl:stylesheet version="2.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:fo="http://www.w3.org/1999/XSL/Format" 
		xmlns:xml="http://www.w3.org/XML/1998/namespace"
		xmlns:xsd="http://www.w3.org/2001/XMLSchema"
		xmlns:act="http://www.gov.bc.ca/2013/legislation/act"
		xmlns:bcl="http://www.gov.bc.ca/2013/bclegislation"
		xmlns:in="http://www.qp.gov.bc.ca/2013/inline">
	
	<xsl:include href="bcl.xsl"/>
	<xsl:include href="includes.xsl"/>
	<xsl:include href="in.xsl"/>

	<xsl:param name="curURL" select="''"/>
	<xsl:param name="orderNum" select="'7631001200'"/>

	
	
	

	<xsl:variable name="cr">&#xA0;</xsl:variable>
	
<!--
	<xsl:output encoding="UTF-8" />
	-->



	<xsl:template match="act:act">
		<fo:root>
		<fo:layout-master-set>
		<xsl:variable name="title-size">
			<!--this is to get the proper size for page formatting-->
			<xsl:call-template name="getCharSize">
				<xsl:with-param name="text" select="act:title"/>
				<xsl:with-param name="font_size">30</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
			
			<fo:simple-page-master master-name="intro" page-width="51pc" page-height="66pc" 
				margin-top="6pc" margin-bottom="6pc" margin-left="7pc" margin-right="7pc">
				<!-- Page Template for first Page -->
				<fo:region-body/>
				<!-- Other regions we won't use (for reference)(as a note all these are part of region-body, ego 3cm Margin Above:-->
				<!-- Header Region 
				<fo:region-before extent="2cm"/>-->
				<!-- Footer Region 
				<fo:region-after extent="2cm"/>-->
				<!-- The Left Hand Margin 
				<fo:region-start extent="2cm"/>-->
				<!-- The Right Hand Margin 
				<fo:region-end extent="2cm"/>-->
			</fo:simple-page-master>

			<fo:simple-page-master master-name="end_page" page-width="51pc" page-height="66pc"
				margin-top="28pc" margin-bottom="2pc" margin-left="3.5pc" margin-right="5.0pc">
				<fo:region-body/>
			</fo:simple-page-master>
			
			<fo:simple-page-master 
				master-name="act_even" 
				page-width="51pc" 
				page-height="66pc" 
				margin-top="4pc" 
				margin-bottom="4pc" 
				margin-left="7pc" 
				margin-right="7pc">
				<fo:region-body margin-bottom="3pc">
					<xsl:attribute name="margin-top">
						<xsl:choose>
							<xsl:when test="$title-size&gt;699">4pc</xsl:when>
							<xsl:otherwise>2pc</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</fo:region-body>
				<fo:region-before 
					extent="2pc" 
					region-name="header_even"/>
				<fo:region-after 
					extent="3pc" 
					region-name="footer_even"/>
			</fo:simple-page-master>

			<fo:simple-page-master 
				master-name="act_odd" 
				page-width="51pc" 
				page-height="66pc" 
				margin-top="4pc" 
				margin-bottom="4pc" 
				margin-left="7pc" 
				margin-right="7pc">
				<fo:region-body margin-bottom="3pc">
					<xsl:attribute name="margin-top">
						<xsl:choose>
							<xsl:when test="$title-size&gt;699">4pc</xsl:when>
							<xsl:otherwise>2pc</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</fo:region-body>
				<fo:region-before 
					extent="2pc" 
					region-name="header_odd"/>
				<fo:region-after 
					extent="3pc" 
					region-name="footer_odd"/>
			</fo:simple-page-master>


			<fo:simple-page-master
				master-name="act_blank_page"
				page-height="66pc"
				page-width="51pc"
				margin-top="2pc"
				margin-bottom="3pc"
				margin-left="7pc"
				margin-right="7pc">
				<fo:region-body
					margin-bottom="3pc"
					margin-top="2pc"/>
				<fo:region-before
					region-name="blank_header"
					extent="2pc"/>
				<fo:region-after
					region-name="blank_footer"
					extent="2pc"/>
			</fo:simple-page-master>		
			
			

			<fo:page-sequence-master master-name="act">
				<fo:repeatable-page-master-alternatives>
					<fo:conditional-page-master-reference
						master-reference="act_blank_page"
						blank-or-not-blank="blank"/>
					<fo:conditional-page-master-reference 
						master-reference="act_even"
						odd-or-even="even"/>
					<fo:conditional-page-master-reference 
						master-reference="act_odd"
						odd-or-even="odd"/>
				</fo:repeatable-page-master-alternatives>
			</fo:page-sequence-master>
		</fo:layout-master-set>

		

		<fo:page-sequence master-reference="intro">
			<!-- Page Content goes here -->
			<xsl:variable name="title-size"><!--this is to get the proper title size for cover page-->
								<xsl:call-template name="getCharSize">
									<xsl:with-param name="text" select="act:title"/>
									<xsl:with-param name="font_size">30</xsl:with-param>
								</xsl:call-template>
							</xsl:variable>
			<fo:flow flow-name="xsl-region-body">
				<fo:block border="2pt solid black" padding="9pt">
					<fo:block border="1pt solid black">
						<fo:block text-align="center" margin-top="2.5pc" margin-bottom="1pc">
							<fo:external-graphic src="file:////comp_fs/User/FO/FO_2.0/BCSIGA_P.jpg" content-width="163" content-height="137"/>
						</fo:block>
						<fo:block text-align="center">
							<fo:leader leader-length="5pc" leader-pattern="rule" rule-thickness="0.5pt" color="black" />
							<!--<xsl:value-of select="$title-size"/>--><!--shows the size of the title used for testing-->
						</fo:block>
						<fo:block text-align="center" font-family="Times Roman" font-size="30pt" margin-top="3pc" line-height="36pt">
							<xsl:value-of select="act:title"/>
						</fo:block>
						<fo:block text-align="center" font-family="Times Roman" font-size="11pt" line-height="12pt" margin-bottom="1.5pc">
							<xsl:choose>
								<xsl:when test="normalize-space(act:yearenacted) = '1996'">R.S.B.C. </xsl:when>
								<xsl:otherwise>S.B.C. </xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="act:yearenacted"/>, CHAPTER <xsl:value-of select="act:chapter"/>
						</fo:block>

						<fo:block text-align="center" font-family="Times Roman" font-size="14pt" line-height="18pt">
							<xsl:attribute name="margin-top">
								<xsl:choose>
									<xsl:when test="$title-size&gt;800.00">4pc</xsl:when>
									<xsl:otherwise>8pc</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							This is a current unofficial<fo:block/>
							consolidation produced by the<fo:block/>
							Queen&#8217;s Printer for convenience<fo:block/>
							purposes using QP LegalEze data.
						</fo:block>

						<fo:block text-align="center">
							<xsl:attribute name="margin-top">
								<xsl:choose>
									<xsl:when test="$title-size&gt;800.00">5.5pc</xsl:when>
									<xsl:otherwise>7.2pc</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<fo:leader leader-length="7pc" leader-pattern="rule" rule-thickness="0.5pt" color="black"/>
						</fo:block>

						<fo:block text-align="center" padding-after="12mm" font-size="7pt" line-height="8pt">
							Queen's Printer for British Columbia &#169;<fo:block/>
							Victoria, 2007
						</fo:block>
					</fo:block>
				</fo:block>
			</fo:flow>
		</fo:page-sequence>
		<fo:page-sequence master-reference="intro">
			<fo:flow flow-name="xsl-region-body">
				<fo:block/>
			</fo:flow>
		</fo:page-sequence>


			<!--actual layout-->
		<fo:page-sequence master-reference="act" 
			initial-page-number="1"
			force-page-count="end-on-even">

			<!-- Header -->
			
			<fo:static-content flow-name="blank_header">
				<fo:block><!--<fo:page-number/>-->
				</fo:block>
			</fo:static-content>

			<fo:static-content flow-name="blank_footer">
				<fo:block>
				</fo:block>
			</fo:static-content>

			<fo:static-content flow-name="header_odd">
				<fo:table margin-bottom="0" padding-after="0" border-collapse="collapse" table-layout="fixed" width="100%">
					<fo:table-column column-width="33.3%"  />
					<fo:table-column column-width="33.3%" />
					<fo:table-column column-width="33.3%" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block text-align="left" font-size="11pt" font-family="Times Roman">
									<xsl:value-of select="act:yearenacted"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block text-align="center" font-size="11pt" font-family="Times Roman">
									<xsl:call-template name="smallCaps">
										<xsl:with-param name="text" select="substring-before(act:title, 'Act')"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block text-align="right" font-size="11pt" font-family="Times Roman">
									<xsl:variable name="year_chap"><xsl:if test="act:yearenacted = '1996'">R</xsl:if>S Chap.<xsl:value-of select="act:chapter"/></xsl:variable>
									<xsl:call-template name="smallCaps">
										<xsl:with-param name="text" select="normalize-space($year_chap)"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="3" display-align="before">
								<fo:block padding-before="0" margin-top="0" font-size="5pt" text-align="center">
									<fo:leader alignment-baseline="middle" leader-length="100%" leader-pattern="rule" rule-thickness="0.5pt" color="black"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>		
				</fo:table>
			</fo:static-content>

			<fo:static-content flow-name="header_even">
				<fo:table margin-bottom="0" padding-after="0" border-collapse="collapse" table-layout="fixed" width="100%">
					<fo:table-column column-width="33.3%"  />
					<fo:table-column column-width="33.3%" />
					<fo:table-column column-width="33.3%" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block text-align="left" font-size="11pt" font-family="Times Roman">
									<xsl:call-template name="smallCaps">
										<xsl:with-param name="text">
											<xsl:choose>
												<xsl:when test="normalize-space(act:yearenacted) = '1996'">RS</xsl:when>
												<xsl:otherwise>SBC</xsl:otherwise>
											</xsl:choose> Chap. <xsl:value-of select="act:chapter"/>
										</xsl:with-param>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block text-align="center" font-size="11pt" font-family="Times Roman">
									<xsl:call-template name="smallCaps">
										<xsl:with-param name="text" select="substring-before(act:title, 'Act')"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block text-align="right" font-size="11pt" font-family="Times Roman">
									<xsl:call-template name="smallCaps">
										<xsl:with-param name="text">
											<xsl:value-of select="concat(number(act:yearenacted) - 1951, ' Eliz. 2')"/>
										</xsl:with-param>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="3" display-align="before">
								<fo:block padding-before="0" margin-top="0" font-size="5pt" text-align="center">
									<fo:leader alignment-baseline="middle" leader-length="100%" leader-pattern="rule" rule-thickness="0.5pt" color="black"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>		
				</fo:table>
			</fo:static-content>
			<!-- Footer -->
			<fo:static-content flow-name="footer_odd">
				<fo:table margin-top="1pc" padding-after="0" border-collapse="collapse" table-layout="fixed" width="100%">
					<fo:table-column column-width="33.3%"  />
					<fo:table-column column-width="33.3%" />
					<fo:table-column column-width="33.3%" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="3" display-align="before">
								<fo:block padding-before="0" margin-top="0" font-size="5pt" text-align="center">
									<fo:leader alignment-baseline="middle" leader-length="100%" leader-pattern="rule" rule-thickness="0.5pt" color="black"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block/>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block text-align="center" font-size="10pt" font-family="Times Roman">
									CONVENIENCE COPY
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block text-align="right" font-size="10pt" font-family="Times Roman">
									<fo:page-number/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>		
				</fo:table>
			</fo:static-content>

			<fo:static-content flow-name="footer_even">
				<fo:table margin-top="1pc" padding-after="0" border-collapse="collapse" table-layout="fixed" width="100%">
					<fo:table-column column-width="33.3%"  />
					<fo:table-column column-width="33.3%" />
					<fo:table-column column-width="33.3%" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="3" display-align="before">
								<fo:block padding-before="0" margin-top="0" font-size="5pt" text-align="center">
									<fo:leader alignment-baseline="middle" leader-length="100%" leader-pattern="rule" rule-thickness="0.5pt" color="black"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block text-align="left" font-size="10pt" font-family="Times Roman">
									<fo:page-number/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block text-align="center" font-size="10pt" font-family="Times Roman">
									CONVENIENCE COPY
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block/>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>		
				</fo:table>
			</fo:static-content>

	

			<fo:flow flow-name="xsl-region-body">
				<fo:block text-align="center" font-family="Times Roman" font-size="14pt" line-height="18pt" font-weight="bold">
					<xsl:value-of select="upper-case(act:title)"/>
				</fo:block>
				<fo:block text-align="center" font-family="Times Roman" font-size="12pt" line-height="14pt"  margin-top="1pc" font-weight="bold">
							<xsl:choose>
								<xsl:when test="act:yearenacted/@prefix">[<xsl:value-of select="act:yearenacted/@prefix"/>&#xA0;</xsl:when>
								<xsl:when test="act:yearenacted='1996'">[RSBC&#xA0;</xsl:when>
								<xsl:when test="act:yearenacted='1960'">[RSBC&#xA0;</xsl:when>
								<xsl:otherwise>[SBC&#xA0;</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="act:yearenacted"/>] CHAPTER
							<xsl:value-of select="act:chapter"/>
				</fo:block>
				<xsl:if test="act:assentedto">
					<fo:block text-align="right" font-family="Times Roman" font-size="11pt" line-height="14pt">
						<xsl:value-of select="act:assentedto"/>
					</fo:block>
				</xsl:if>
				<fo:block text-align="center" font-family="Times Roman" font-size="11pt" line-height="14pt" 
					font-weight="bold" font-style="italic" margin-top="1.5pc">
					Contents
				</fo:block>
				<fo:block font-family="Times Roman" font-size="10pt" line-height="12pt" font-style="italic" 
					margin-left="2pc">
					Section
				</fo:block>
				 
				<xsl:apply-templates mode="toc"/>
				<xsl:apply-templates select="act:content"/>
			</fo:flow>
		</fo:page-sequence> 

		<fo:page-sequence master-reference="intro">
			<fo:flow flow-name="xsl-region-body">
				<fo:block/>
			</fo:flow>
		</fo:page-sequence>

		<fo:page-sequence master-reference="end_page">
			<fo:flow flow-name="xsl-region-body">
				<fo:block text-align="center" font-family="Helvetica" font-size="11pt" margin-left="12.5pc" margin-right="10.5pc">
					Queen's Printer for Birtish Columbia &#169;<fo:block/>
					Victoria<fo:block/>
					<fo:block margin-top="1.5pc"><xsl:value-of select="$orderNum"/></fo:block></fo:block>

				<fo:block text-align="left" font-family="Helvetica" font-size="11pt" margin-top="18pc">
									To order additional copies of this publication online, go to www.qpbooks.ca.  Publications can also be ordered by contactiong QP books
									by phone, fax, email.</fo:block>
				
			<fo:table margin-bottom="0pc" padding-left="3.5" padding-right="4pc" width="100%" margin-top="3pc">
				<fo:table-column column-width="38%"/>
				<fo:table-column column-width="28%"/>
				<fo:table-column column-width="33.3%"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block text-align="left" font-family="Helvetica" font-size="11pt">
									<fo:inline font-weight="bold">QP Books</fo:inline><fo:block/>
									<fo:inline font-weight="bold">Phone:</fo:inline> 250 387-6409<fo:block/>
									<fo:inline font-weight="bold">Toll Free:</fo:inline> 1 800 663-6105<fo:block/>
									<fo:inline font-weight="bold">Fax:</fo:inline> 250 387-1120<fo:block/>
									<fo:inline font-weight="bold">Email:</fo:inline> qppublications@gov.bc.ca
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block></fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<fo:external-graphic content-width="12.5pc" content-height="4.9pc" src="file:////Comp_fs/WEB_Test/NXT/QPLE/live/media/qp_books3.jpg"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>


		</fo:flow>
		</fo:page-sequence>

		</fo:root>
	</xsl:template>


	<xsl:template match="act:title" mode="#default toc"/>
	<xsl:template match="ccollect" mode="#default toc"/>
	<xsl:template match="currency" mode="#default toc"/>
	<xsl:template match="assentedto" mode="#default toc"/>


	<!-- ************************* TOC ************************** -->

	<xsl:template match="*" mode="toc"/>

	<xsl:template match="act:content" mode="#default toc">
		<xsl:apply-templates mode="#current"/>
	</xsl:template>

	<xsl:template match="*">
		<fo:block>UnMatched [<xsl:value-of select="name()"/>] <xsl:apply-templates/></fo:block>
	</xsl:template>



	<!-- ************************* CONTENT ************************ -->


	

	<xsl:template match="part">
		<fo:block font-family="Times Roman" font-size="13pt" line-height="16pt" text-align="center" font-weight="bold" 
			margin-top="1.5pc" margin-bottom="10pt">
			<xsl:call-template name="smallCaps">
				<xsl:with-param name="text">
					Part <xsl:value-of select="partnumber"/> &#8212; <xsl:value-of select="parttext"/>
				</xsl:with-param>
			</xsl:call-template>
		</fo:block>
	</xsl:template>

	<xsl:template match="division">
		<fo:block text-align="center" margin-top="10pt" font-family="Times Roman" font-size="11pt" line-height="14pt"
			font-weight="bold">Division <xsl:apply-templates select="divisionnumber"/> &#8212; <xsl:apply-templates select="divisiontext"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="divisionnumber"><xsl:apply-templates/></xsl:template>
	<xsl:template match="divisiontext"><xsl:apply-templates/></xsl:template>


	<xsl:template match="secsandwich">
		<fo:block start-indent="45pt" font-family="Times Roman" font-size="11pt" line-height="13pt" margin-top="4pt"><xsl:apply-templates/></fo:block>
	</xsl:template>

	<xsl:template match="marginalnote" mode="toc"><xsl:apply-templates/></xsl:template>

	<xsl:template match="marginalnote">
		<fo:block font-family="Helvetica" font-size="9pt" line-height="10pt" font-weight="bold" margin-top="1pc" keep-with-next="always">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	<xsl:template match="sectionnumber"><xsl:apply-templates/></xsl:template>
	<xsl:template match="sectiontext"><xsl:apply-templates/></xsl:template>
	
	<xsl:template match="subsection">
		<xsl:if test="parent::section/sectiontext or not(count(preceding-sibling::*[name()=name(current())])+1 = 1)">
			<xsl:variable name="offset_left">
				<xsl:call-template name="getCharSize">
					<xsl:with-param name="font_size">11</xsl:with-param>
					<xsl:with-param name="text">(<xsl:value-of select="subsectionnumber"/>)</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" start-indent="66pt" 
					text-indent="-{6 + $offset_left}pt" margin-bottom="6pt">
				(<xsl:apply-templates select="subsectionnumber"/>)<fo:leader leader-length="6pt"/>
				<xsl:apply-templates select="subsectiontext"/>
			</fo:block>
		</xsl:if>
	</xsl:template>
	<xsl:template match="subsandwich">
		<fo:block start-indent="66pt" font-family="Times Roman" font-size="11pt" line-height="13pt"><xsl:apply-templates/></fo:block>
	</xsl:template>

	<xsl:template match="subsectionnumber"><xsl:apply-templates/></xsl:template>
	<xsl:template match="subsectiontext"><xsl:apply-templates/></xsl:template>


	<xsl:template match="parasandwich">
		<fo:block start-indent="90pt" font-family="Times Roman" font-size="11pt" line-height="13pt"><xsl:apply-templates/></fo:block>
	</xsl:template>
	<xsl:template match="paragraphnumber">(<xsl:apply-templates/>)</xsl:template>
	<xsl:template match="paragraphtext"><xsl:apply-templates/></xsl:template>

	<xsl:template match="definition">
		<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" margin-top="4pt"
			start-indent="5.75pc" text-indent="-1.5pc"><xsl:apply-templates/></fo:block>
	</xsl:template>

	<xsl:template match="term"><fo:inline font-weight="bold">&#8220;<xsl:apply-templates/>&#8221;</fo:inline></xsl:template>
	<xsl:template match="def"><xsl:apply-templates/></xsl:template>

	<xsl:template match="subparagraph">
		<xsl:variable name="offset_marg">
			<xsl:call-template name="getCharSize">
				<xsl:with-param name="font_size">11</xsl:with-param>
				<xsl:with-param name="font_type">Times</xsl:with-param>
				<xsl:with-param name="text">(<xsl:value-of select="subparagraphnumber"/>)</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" start-indent="118pt"
			text-indent="-{6 + ($offset_marg)}pt">(<xsl:apply-templates select="subparagraphnumber"/>)<fo:leader leader-length="6pt"/><xsl:apply-templates select="subparagraphtext"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="subparasandwich">
		<fo:block start-indent="118pt" font-family="Times Roman" font-size="11pt" line-height="13pt"><xsl:apply-templates/></fo:block>
	</xsl:template>
	<xsl:template match="subparagraphnumber"><xsl:apply-templates/></xsl:template>
	<xsl:template match="subparagraphtext"><xsl:apply-templates/></xsl:template>

	<xsl:template match="clause">
		<xsl:variable name="offset_marg">
			<xsl:call-template name="getCharSize">
				<xsl:with-param name="font_size">11</xsl:with-param>
				<xsl:with-param name="font_type">Times</xsl:with-param>
				<xsl:with-param name="text">(<xsl:value-of select="clausenumber"/>)</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" start-indent="142pt"
			text-indent="-{6 + ($offset_marg)}pt">(<xsl:apply-templates select="clausenumber"/>)<fo:leader leader-length="6pt"/><xsl:apply-templates select="clausetext"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="clausenumber"><xsl:apply-templates/></xsl:template>
	<xsl:template match="clausetext"><xsl:apply-templates/></xsl:template>
	<xsl:template match="clausesandwich">
		<fo:block start-indent="142pt" font-family="Times Roman" font-size="11pt" line-height="13pt"><xsl:apply-templates/></fo:block>
	</xsl:template>

	<xsl:template match="subclause">
		<xsl:variable name="offset_marg">
			<xsl:call-template name="getCharSize">
				<xsl:with-param name="font_size">11</xsl:with-param>
				<xsl:with-param name="font_type">Times</xsl:with-param>
				<xsl:with-param name="text">(<xsl:value-of select="subclausenumber"/>)</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" start-indent="164pt"
			text-indent="-{6 + ($offset_marg)}pt">(<xsl:apply-templates select="subclausenumber"/>)<fo:leader leader-length="6pt"/><xsl:apply-templates select="subclausetext"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="subclausesandwich">
		<fo:block start-indent="164pt" font-family="Times Roman" font-size="11pt" line-height="13pt"><xsl:apply-templates/></fo:block>
	</xsl:template>
	<xsl:template match="subclausenumber"><xsl:apply-templates/></xsl:template>
	<xsl:template match="subclausetext"><xsl:apply-templates/></xsl:template>

	<xsl:template match="schedule"><xsl:apply-templates/></xsl:template>

	<xsl:template match="scheduletitle">
		<fo:block font-family="Times Roman" font-size="13pt" line-height="18pt" 
			text-align="center" margin-top="6pt">
			<fo:inline font-weight="bold">
				<xsl:call-template name="smallCaps">
					<xsl:with-param name="text" select="."/>
				</xsl:call-template>
			</fo:inline>
		</fo:block>
	</xsl:template>

	<xsl:template match="centertext">
		<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt"
			text-align="center">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

<!-- ****************** TOM's Additions *********************** -->


	<xsl:template match="preamble"><xsl:apply-templates/></xsl:template>

	<xsl:template match="preamblehead">
		<fo:block font-family="Helvetica" font-size="9pt" line-height="10pt" font-weight="bold" margin-top="1.5pc" keep-with-next="always">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="preambletext">
		<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" margin-top="16pt" margin-bottom="18">
			<xsl:apply-templates/></fo:block>
	</xsl:template>

	<xsl:template match="defsandwich">
		<fo:block margin-left="5.75pc" font-family="Times Roman" font-size="11pt" line-height="13pt" margin-top="6pt">
			<xsl:apply-templates/></fo:block>
	</xsl:template>

	
	<xsl:template match="tablecolhead" priority="1">
		<fo:table-cell>
			<xsl:if test="@width">
				<xsl:attribute name="width">
					<xsl:value-of select="number(@width) * 1.5"/>
				</xsl:attribute>		
			</xsl:if>
			<fo:block text-align="fixed" font-family="Times Roman" font-size="10pt" ><xsl:apply-templates/>
			</fo:block>
		</fo:table-cell>		
	</xsl:template>

	<xsl:template match="conseqhead">
		<fo:block><xsl:apply-templates/></fo:block>
	</xsl:template>

	<xsl:template match="conseqtext">
		<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" font-weight="bold"
			text-align="center" margin-top="1.5pc">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="conseqsectionnumber"/>
	
	<xsl:template match="conseqnote">
		<fo:block font-family="Times Roman" text-align="center" font-size="10pt"><xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="lefttext">
		<fo:block font-family="Times Roman" font-size="10pt" line-height="13pt">
				<xsl:apply-templates/>
			</fo:block>
	</xsl:template>


	<xsl:template match="lefthang">
	    <fo:block font-family="Times Roman" font-size="10pt" line-height="13pt">
				<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="ammendingline">
		<fo:block font-family="Times Roman" text-align="center" font-size="10pt"><xsl:apply-templates/>
		</fo:block>
	</xsl:template>


	<xsl:template match="indent1">
		<fo:block font-family="Times Roman" font-size="11pt" line-height="15pt" start-indent="66pt" text-indent="-42pt" margin-top="4pt">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="ndash">&#8211;</xsl:template>

	<xsl:template match="mdash">&#8212;</xsl:template>

	<xsl:template match="subheading">
		<fo:block font-family="Helvetica" font-size="9pt" line-height="10pt" font-weight="italic" margin-top="1pc">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="graphic">
		<fo:block text-align="center">
			<fo:external-graphic>
				<xsl:if test="@height">
					<xsl:attribute name="content-height"><xsl:value-of select="0.063 * number(@height)"/>em</xsl:attribute>
				</xsl:if>
				<xsl:if test="@width">
					<xsl:attribute name="content-width"><xsl:value-of select="0.063 * number(@width)"/>em</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="src">
					<xsl:call-template name="getRealPath">
						<xsl:with-param name="relativePath" select="@href"/>
					</xsl:call-template>
				</xsl:attribute>
			</fo:external-graphic>
		</fo:block>
	</xsl:template>

	<xsl:template match="hr">
	</xsl:template>

	<xsl:template name="getRealPath">
		<xsl:param name="relativePath"/> <!-- this looks like ../media/test/xml -->
		
		<xsl:variable name="countBackStr">
			<xsl:analyze-string select="$relativePath" regex="\.\./">
				<xsl:matching-substring>
					<r/>
				</xsl:matching-substring>
			</xsl:analyze-string>
		</xsl:variable>

		<xsl:variable name="forwardPath" select="replace($relativePath, '\.\./', '')"/>

		<xsl:variable name="countBack" select="count($countBackStr/r)"/>
		<xsl:variable name="countCurrent" select="count(tokenize($curURL, '\\'))"/>

		<xsl:variable name="fullURL">
			<xsl:for-each select="tokenize($curURL, '\\')">
				<xsl:if test="number(position() + $countBack) &lt; number($countCurrent)"><xsl:value-of select="."/>\</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		file:///<xsl:value-of select="replace($fullURL, '\\', '/')"/><xsl:value-of select="$forwardPath"/>
	</xsl:template>

	
	
	<!-- *************** End of TOM's Additions ******************* -->

	<!-- ************************ TABLE TAGS ********************** -->
	
	<!--**********************current Toms table changes*****************-->
	<xsl:template match="table[@id = '1']">
		<fo:block>
			<fo:table border-collapse="collapse" table-layout="fixed" width="70%" margin-top="1pc" margin-bottom="1pc" margin-left="5pc">
				<xsl:call-template name="getColumnWidth2">
					<xsl:with-param name="origTable" select="."/>
				</xsl:call-template>
				<fo:table-body start-indent="0pt" end-indent="0pt">
					<xsl:apply-templates/>
				</fo:table-body>
			</fo:table>
		</fo:block>

	</xsl:template>

	<xsl:template match="table[@id = '1']/tablerow/tablecol" priority="10">
		<fo:table-cell padding="3px">
			<xsl:if test="@width">
				<xsl:attribute name="width"><xsl:value-of select="number(@width) * 0.33"/>px</xsl:attribute>
			</xsl:if>
			<xsl:if test="@align">
				<xsl:attribute name="text-align"><xsl:value-of select="@align"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@colspan">
				<xsl:attribute name="number-columns-spanned"><xsl:value-of select="@colspan"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@rowspan">
				<xsl:attribute name="number-rows-spanned"><xsl:value-of select="@rowspan"/></xsl:attribute>
			</xsl:if>
			<fo:block font-family="Times Roman" font-size="10pt" line-height="13pt">
				<xsl:apply-templates/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>

	<xsl:template match="table[@id = '1']/tablerow/tablecolhead" priority="10">
		<fo:table-cell  padding="3px">
			<xsl:if test="@width">
				<xsl:attribute name="width"><xsl:value-of select="number(@width) * 0.33"/>px</xsl:attribute>
			</xsl:if>
			<xsl:if test="@align">
				<xsl:attribute name="text-align"><xsl:value-of select="@align"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@colspan">
				<xsl:attribute name="number-columns-spanned"><xsl:value-of select="@colspan"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@rowspan">
				<xsl:attribute name="number-rows-spanned"><xsl:value-of select="@rowspan"/></xsl:attribute>
			</xsl:if>
			<fo:block display-align="fixed" font-family="Times Roman"  font-size="12pt">
				<xsl:apply-templates/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>

 	<xsl:template match="table[@id = '2']">
		<fo:block>
			<fo:table border-collapse="collapse" table-layout="fixed" border="1pt solid black" margin-left="3pc" margin-top="1pc" margin-bottom="1pc">
				<xsl:call-template name="getColumnWidth2">
					<xsl:with-param name="origTable" select="."/>
				</xsl:call-template>
				<fo:table-body start-indent="0pt" end-indent="0pt"><xsl:apply-templates/>	
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<xsl:template match="table[@id = '2']/tablerow/tablecolhead" priority="10">
		<fo:table-cell padding="3px" border="1pt solid black">
			<xsl:if test="@valign">
				<xsl:attribute name="vertical-align"><xsl:value-of select="@valign"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@rowspan">
				<xsl:attribute name="number-rows-spanned"><xsl:value-of select="@rowspan"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@align">
				<xsl:attribute name="text-align"><xsl:value-of select="@align"/></xsl:attribute>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="@width">
					<xsl:attribute name="width"><xsl:value-of select="number(@width) * 0.7"/>px</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="width">auto</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="@colspan">
				<xsl:attribute name="number-columns-spanned"><xsl:value-of select="@colspan"/></xsl:attribute>
			</xsl:if>
			<fo:block font-family="Times Roman" font-size="10pt" ><xsl:apply-templates/>
			</fo:block>	
		</fo:table-cell>
	</xsl:template>

	<xsl:template match="table[@id = '2']/tablerow/tablecol" priority="10">
		<fo:table-cell padding="3px" border="1pt solid black">
			<xsl:if test="@valign">
				<xsl:attribute name="vertical-align"><xsl:value-of select="@valign"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@rowspan">
				<xsl:attribute name="number-rows-spanned"><xsl:value-of select="@rowspan"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@align">
				<xsl:attribute name="text-align"><xsl:value-of select="@align"/></xsl:attribute>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="@width">
					<xsl:attribute name="width"><xsl:value-of select="number(@width) * 0.7"/>px</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="width">auto</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="@colspan">
				<xsl:attribute name="number-columns-spanned"><xsl:value-of select="@colspan"/></xsl:attribute>
			</xsl:if>
			<fo:block font-family="Times Roman" font-size="10pt" line-height="13pt"><xsl:apply-templates/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>
			

	<xsl:template match="table[@id = '4']" priority="10">	
        <fo:table border-collapse="collapse" table-layout="fixed" width="85%" margin-top="1pc" margin-bottom="1pc" margin-left="5.1pc">
			<xsl:call-template name="getColumnWidth2">
				<xsl:with-param name="origTable" select="."/>
			</xsl:call-template>
            <fo:table-body start-indent="0pt" end-indent="0pt">
                <xsl:apply-templates/>
            </fo:table-body>
        </fo:table>
	<!--
		<fo:block>
			<fo:table border-collapse="collapse" table-layout="fixed" width="85%" margin-top="1pc" margin-bottom="1pc" margin-left="3pc">
				<fo:table-body start-indent="0pt" end-indent="0pt">
					<xsl:apply-templates/>
				</fo:table-body>
			</fo:table>
		</fo:block>
	-->
	</xsl:template>

		<xsl:template match="table[@id = '9']" priority="10">	
        <fo:table border-collapse="collapse" table-layout="fixed" width="85%" margin-top="1pc" margin-bottom="1pc" margin-left="5.1pc">
			<xsl:call-template name="getColumnWidth2">
				<xsl:with-param name="origTable" select="."/>
			</xsl:call-template>
            <fo:table-body start-indent="0pt" end-indent="0pt">
                <xsl:apply-templates/>
            </fo:table-body>
        </fo:table>
	<!--
		<fo:block>
			<fo:table border-collapse="collapse" table-layout="fixed" width="85%" margin-top="1pc" margin-bottom="1pc" margin-left="3pc">
				<fo:table-body start-indent="0pt" end-indent="0pt">
					<xsl:apply-templates/>
				</fo:table-body>
			</fo:table>
		</fo:block>
	-->
	</xsl:template>


	<xsl:template match="table[@id = '4']/tablerow/tablecol" priority="10">
		<fo:table-cell padding="3">
			<xsl:if test="@valign">
				<xsl:attribute name="vertical-align"><xsl:value-of select="@valign"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@rowspan">
				<xsl:attribute name="number-rows-spanned"><xsl:value-of select="@rowspan"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@align">
				<xsl:attribute name="text-align"><xsl:value-of select="@align"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@width">
				<xsl:attribute name="width"><xsl:value-of select="number(@width) * 0.33"/>px</xsl:attribute>
			</xsl:if>
	
			<xsl:if test="@colspan">
				<xsl:attribute name="number-columns-spanned"><xsl:value-of select="@colspan"/></xsl:attribute>
			</xsl:if>
			<fo:block font-family="Times Roman" font-size="11pt" line-height="13pt" padding="3px"><xsl:apply-templates/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>


<!--**********************current Toms table changes fin*****************-->

	<xsl:template match="table">

		<xsl:variable name="left_marg">
			<xsl:choose>
				<xsl:when test="@id = 1">0</xsl:when>
				<xsl:when test="@id = 2">0</xsl:when>
				<xsl:when test="@id = 4">28</xsl:when>
				<xsl:when test="@id = 5">52</xsl:when>
				<xsl:when test="@id = 6">74</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<fo:block>
			<xsl:if test="not($left_marg = '0')">
				<xsl:attribute name="margin-left" select="concat($left_marg, 'pt')"/>
			</xsl:if>
			<fo:table border-collapse="collapse" table-layout="fixed"  width="55%">
				<xsl:if test="@width">
					<xsl:attribute name="width"><xsl:value-of select="@width"/>px</xsl:attribute>
				</xsl:if>
				<xsl:if test="@id = '2'">
					<xsl:attribute name="border">1pt solid black</xsl:attribute>
				</xsl:if>

				<xsl:attribute name="margin-top">1pc</xsl:attribute>
				<xsl:attribute name="margin-bottom">1pc</xsl:attribute>

				<fo:table-body start-indent="0pt" end-indent="0pt">
					<xsl:apply-templates/>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>


  <xsl:template match="tablerow">
		<fo:table-row >
				<xsl:apply-templates/>
		</fo:table-row>
	</xsl:template>

		
	<xsl:template match="tablecol">
		<xsl:choose>
			<xsl:when test="not(normalize-space(.) = '')">
				<fo:table-cell padding="3px">
					<xsl:if test="@colspan">
						<xsl:attribute name="number-columns-spanned" select="@colspan"/>
					</xsl:if>
					<xsl:if test="@width">
						<xsl:attribute name="width"><xsl:value-of select="@width"/>px</xsl:attribute>
					</xsl:if>
					<xsl:if test="@align">
						<xsl:attribute name="text-align"><xsl:value-of select="@align"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="ancestor::table/@id = '2'">
						<xsl:attribute name="border">1pt solid black</xsl:attribute>
					</xsl:if>
					<fo:block font-family="Times Roman" font-size="10pt" line-height="13pt"><xsl:apply-templates/></fo:block>
				</fo:table-cell>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- ************************ INLINE TAGS ********************* -->
	
	<xsl:template match="br">
		<fo:block/>
	</xsl:template>

	
	<xsl:template match="desc">
		<fo:inline font-style="italic"><xsl:apply-templates/></fo:inline>
	</xsl:template>

	<xsl:template match="insert"><xsl:apply-templates/></xsl:template>

	<xsl:template match="strong"><fo:inline font-weight="bold"><xsl:apply-templates/></fo:inline></xsl:template>

	<xsl:template match="sup"><fo:inline baseline-shift="super" font-size="66%"><xsl:apply-templates/></fo:inline></xsl:template>

	<xsl:template match="sub"><fo:inline baseline-shift="sub" font-size="66%"><xsl:apply-templates/></fo:inline></xsl:template>

	<xsl:template match="em"><fo:inline font-style="italic"><xsl:apply-templates/></fo:inline></xsl:template>
	 

	<!-- ******************* MY FUNCTIONS OF FUN!! **************** -->

	<xsl:template name="smallCaps">
		<xsl:param name="text"/>
		<fo:inline font-size="75%">
			<xsl:if test="string-length($text) &gt; 0">
				<xsl:call-template name="recursive_smallCaps">
					<xsl:with-param name="text" select="$text"/>
				</xsl:call-template>
			</xsl:if>
		</fo:inline>
	</xsl:template>

	<xsl:template name="recursive_smallCaps">
		<xsl:param name="text"/>
		<xsl:variable name="char" select="substring($text, 1, 1)"/>
		<xsl:variable name="upperCase" select="upper-case($char)"/>
		<xsl:choose>
			<xsl:when test="$char = $upperCase">
				<fo:inline font-size="133%"><xsl:value-of select="$upperCase"/></fo:inline>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$upperCase"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="string-length($text) &gt; 1">
			<xsl:call-template name="recursive_smallCaps">
				<xsl:with-param name="text" select="substring($text, 2)"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="getCharSize">
		<xsl:param name="text" select="''"/>
		<xsl:param name="font_size" select="0"/>
		<xsl:param name="font_type">Times</xsl:param>
		<xsl:value-of select="
			sum(
				for $i in string-to-codepoints($text) return 
					(
						$font_size * 
							(
								number($font_table/root/charSet[@type = $font_type]/char[name[text() = codepoints-to-string($i)]]/wx)
							)*0.001
					)
				)"/>
	</xsl:template>



	<xsl:template name="substring-after-last">
		<xsl:param name="string"/>
		<xsl:param name="delimiter"/>
		<xsl:choose>
			<xsl:when test="contains($string, '-')">
				<xsl:variable name="before"><xsl:value-of select="substring-before($string, '-')"/></xsl:variable>
				<xsl:variable name="after"><xsl:value-of select="substring-after($string, '-')"/></xsl:variable>
				<xsl:value-of select="substring-after($after, $delimiter)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring-after($string, $delimiter)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="substring-before-last">
		<xsl:param name="string"/>
		<xsl:param name="delimiter"/>
		<xsl:choose>
			<xsl:when test="contains($string, '-')">
				<xsl:variable name="before"><xsl:value-of select="substring-before($string, '-')"/></xsl:variable>
				<xsl:variable name="after"><xsl:value-of select="substring-after($string, '-')"/></xsl:variable>
				<xsl:variable name="before_delim">
					<xsl:choose>
						<xsl:when test="contains($after, $delimiter)"><xsl:value-of select="substring-before($after, $delimiter)"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="$after"/></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:value-of select="concat($before, '-', $before_delim)"/>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="substring-before($string, $delimiter)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	 <!-- reusable replace-string function -->
	 <xsl:template name="replace-string">
	    <xsl:param name="text"/>
	    <xsl:param name="from"/>
	    <xsl:param name="to"/>

	    <xsl:choose>
	      <xsl:when test="contains($text, $from)">

		<xsl:variable name="before" select="substring-before($text, $from)"/>
		<xsl:variable name="after" select="substring-after($text, $from)"/>
		<xsl:variable name="prefix" select="concat($before, $to)"/>

		<xsl:value-of select="$before"/>
		<xsl:value-of select="$to"/>
	        <xsl:call-template name="replace-string">
		  <xsl:with-param name="text" select="$after"/>
		  <xsl:with-param name="from" select="$from"/>
		  <xsl:with-param name="to" select="$to"/>
		</xsl:call-template>
	      </xsl:when> 
	      <xsl:otherwise>
	        <xsl:value-of select="$text"/>  
	      </xsl:otherwise>
	    </xsl:choose>            
	 </xsl:template>

<xsl:template name="getColumnWidth2">
	<xsl:param name="origTable"/>
	<xsl:param name="docMax" select="75"/>
	<xsl:variable name="spanOffset" as="xsd:integer">
		<xsl:call-template name="getOffsetSpan">
			<xsl:with-param name="origTable" select="$origTable"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="cells">
		<xsl:call-template name="MinMaxCellWidth">
			<xsl:with-param name="origTable" select="$origTable"/>
			<xsl:with-param name="spanOffset" select="$spanOffset"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="cols_noSpan">
		<xsl:call-template name="MinMaxColWidth_noSpan">
			<xsl:with-param name="cells" select="$cells"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="cols_Span">
		<xsl:call-template name="MinMaxColWidth_Spans">
			<xsl:with-param name="cells" select="$cells"/>
			<xsl:with-param name="cols_noSpan" select="$cols_noSpan"/>
		</xsl:call-template>
	</xsl:variable>
	<!--
	<xsl:for-each select="$cols_Span/col">
		<col>
			<xsl:copy-of select="./@*"/>
		</col>
	</xsl:for-each>
	-->
	<xsl:variable name="sumMax" select="sum($cols_Span/col/@max)" as="xsd:double"/>
	<xsl:variable name="sumMin" select="sum($cols_Span/col/@min)" as="xsd:double"/>
	<xsl:choose>
		<xsl:when test="number($sumMax) &lt; number($docMax)">
			<xsl:for-each select="$cols_Span/col">
				<fo:table-column column-width="{number(./@max) div number($docMax) * 100}%"/>
			</xsl:for-each>
		</xsl:when>
		<xsl:when test="number($sumMin) &gt; number($docMax)">
			<xsl:for-each select="$cols_Span/col">
				<fo:table-column column-width="{number(./@min) div number($docMax) * 100}%"/>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="W" select="number($docMax) - number($sumMin)"/>
			<xsl:variable name="D" select="number($sumMax) - number($sumMin)"/>

			<xsl:variable name="nonAvgCols">
				<xsl:for-each select="$cols_Span/col">
					<xsl:variable name="d" select="number(./@max) - number(./@min)"/>
					<xsl:variable name="calWidth" select="number(./@min) + (number($d) * number($W) div number($D))"/>
					<col>
						<xsl:attribute name="width">
						<xsl:choose>
							<xsl:when test="number(./@min) &gt; number($calWidth)">
								<xsl:value-of select="./@min"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$calWidth"/>
							</xsl:otherwise>
						</xsl:choose>
						</xsl:attribute>
					</col>
				</xsl:for-each>
			</xsl:variable>
			<!--
			<xsl:for-each select="$nonAvgCols/col">
				<col>
					<xsl:copy-of select="./@*"/>
				</col>
			</xsl:for-each>
			-->
			<xsl:variable name="sumColWidth" select="sum($nonAvgCols/col/@width)" />
			<xsl:for-each select="$nonAvgCols/col">
				<fo:table-column column-width="{number(./@width) div number($sumColWidth) * 100}%"/>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="MinMaxColWidth_Spans">
	<xsl:param name="cells"/>
	<xsl:param name="cols_noSpan"/>
	<xsl:variable name="cellspan">
	<xsl:for-each select="$cells/cell[not(@span = '0')]">
		<cellspan num="{@col}" end="{number(@col) + number(@span) - 1}" min="{@min}" max="{@max}" 
			relMin="{number(@min) div number(@span)}" relMax="{number(@max) div number(@span)}"/>
	</xsl:for-each>
	</xsl:variable>
	<xsl:call-template name="getFinal">
		<xsl:with-param name="newCols" select="node()"/>
		<xsl:with-param name="oldCols" select="$cols_noSpan"/>
		<xsl:with-param name="cellspan" select="$cellspan"/>
		<xsl:with-param name="cells" select="$cells"/>
		<xsl:with-param name="posCol" select="1"/>
		<xsl:with-param name="lastCol" select="count($cols_noSpan/col)"/>
	</xsl:call-template>
</xsl:template>

<xsl:template name="getFinal">
	<xsl:param name="newCols"/>
	<xsl:param name="oldCols"/>
	<xsl:param name="cellspan"/>
	<xsl:param name="cells"/>
	<xsl:param name="posCol"/>
	<xsl:param name="lastCol"/>
	
	<xsl:variable name="curMax" select="$oldCols/col[$posCol]/@max"/>
	<xsl:variable name="curMin" select="$oldCols/col[$posCol]/@min"/>

	<xsl:variable name="elem">
		<xsl:for-each select="$cellspan/cellspan[number(@num) &lt;= number($posCol) and number(@end) &gt;= number($posCol)]">
			<cellspan>
				<xsl:copy-of select="./@*"/>
			</cellspan>
		</xsl:for-each>
	</xsl:variable>

	<xsl:variable name="elemMax" select="$elem/cellspan[not(preceding-sibling::cellspan/@relMax > @relMax or 
									following-sibling::cellspan/@relMax > @relMax)][1]"/>
	<xsl:variable name="elemMin" select="$elem/cellspan[not(preceding-sibling::cellspan/@relMin > @relMin or 
									following-sibling::cellspan/@relMin > @relMin)][1]"/>

	<xsl:variable name="sumNewMax" as="xsd:double">
		<xsl:value-of select="sum($newCols/col[@num &gt;= $elemMax/@num][@num &lt;= $elemMax/@end]/@max)"/>
	</xsl:variable>
	
	<xsl:variable name="sumOldMax" as="xsd:double">
		<xsl:value-of select="sum($oldCols/col[@num &gt;= $elemMax/@num][@num &lt;= $elemMax/@end]/@max)"/>
	</xsl:variable>

	<xsl:variable name="sumNewMin" as="xsd:double">
		<xsl:value-of select="sum($newCols/col[@num &gt;= $elemMin/@num][@num &lt;= $elemMin/@end]/@min)"/>
	</xsl:variable>
	
	<xsl:variable name="sumOldMin" as="xsd:double">
		<xsl:value-of select="sum($oldCols/col[@num &gt;= $elemMin/@num][@num &lt;= $elemMin/@end]/@min)"/>
	</xsl:variable>

	<!-- We'll take care of the minimums first -->
	<xsl:variable name="finalMin">
	<xsl:choose>
		<xsl:when test="number($sumOldMin) &gt;= number($elemMin/@min) or number($sumNewMin) &gt;= number($elemMin/@min)">
			<xsl:value-of select="$curMin"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="
				(number($elemMin/@min) - number($sumOldMin)) div (number($elemMin/@end) - number($elemMin/@num) + 1) 
					+ number($curMin)"/>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>

	<xsl:variable name="finalMax">
		<xsl:choose>
			<xsl:when test="number($sumOldMax) &gt;= number($elemMax/@max) or number($sumNewMax) &gt;= number($elemMax/@max)">
				<xsl:value-of select="$curMax"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="
					(number($elemMax/@max) - number($sumOldMax)) div (number($elemMax/@end) - number($elemMax/@num) + 1) 
						+ number($curMax)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="addCols">
	<xsl:for-each select="$newCols/col">
		<col><xsl:copy-of select="./@*"/></col>
	</xsl:for-each>
		<col num="{$posCol}" min="{$finalMin}" max="{$finalMax}"/>
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="number($posCol) = number($lastCol)">
			<!-- We're done, write the cols out -->
			<xsl:for-each select="$addCols/col">
				<col><xsl:copy-of select="./@*"/></col>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<!-- Recursive call to continue calculations -->
			<xsl:call-template name="getFinal">
				<xsl:with-param name="newCols" select="$addCols"/>
				<xsl:with-param name="oldCols" select="$oldCols"/>
				<xsl:with-param name="cellspan" select="$cellspan"/>
				<xsl:with-param name="cells" select="$cells"/>
				<xsl:with-param name="posCol" select="number($posCol) + 1"/>
				<xsl:with-param name="lastCol" select="$lastCol"/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>


<xsl:template name="MinMaxColWidth_noSpan">
	<xsl:param name="cells"/>
	<xsl:for-each-group select="$cells/cell" group-by="@col">
		<col num="{@col}" 
			min="{max(for $i in current-group()[@span = '0']/@min return number($i))}"
			max="{max(for $i in current-group()[@span = '0']/@max return number($i))}"/>
	</xsl:for-each-group>
</xsl:template>

<xsl:template name="MinMaxCellWidth">
	<xsl:param name="origTable"/>
	<xsl:param name="spanOffset"/>
	<xsl:for-each select="$origTable/tablerow">
		<xsl:variable name="nRow" select="position()"/>
		<xsl:for-each select="./tablecol">
			<xsl:variable name="min" as="xsd:double">
				<xsl:variable name="modString" select="translate(., $cr, '-')"/>
				<xsl:choose>
					<xsl:when test="normalize-space($modString) = ''">0</xsl:when>
					<xsl:when test="contains($modString, ' ')">
						<!--
						<xsl:variable name="tokenString" select="tokenize($modString, ' ')"/>
						<xsl:variable name="lenTokenString">
							<xsl:for-each select="tokenString">
								<token>
									<xsl:attribute name="len">
										<xsl:call-template name="getCharSize">
											<xsl:with-param name="text">.</xsl:with-param>
										</xsl:call-template>
									</xsl:attribute>
								</token>
							</xsl:for-each>
						</xsl:variable> -->
						<!--<xsl:value-of select="max(for $i in $tokenString/token/@len return number($i))"/>-->
						<!--<xsl:value-of select="$lenTokenString/token[not(preceding-sibling::token/@len > @len or following-sibling::token/@len > @len)]/@len"/>-->
						<xsl:value-of select="max(for $i in tokenize(string($modString), ' ') return string-length($i))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="string-length($modString)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<!--<xsl:variable name="max" select="string-length(.)" as="xsd:double"/>-->
			<xsl:variable name="max" as="xsd:double" select="string-length(.)"/>
			<cell row="{$nRow}" min="{$min}" max="{$max}">
				<xsl:attribute name="col">
					<xsl:choose>
						<xsl:when test="sum(./preceding-sibling::tablecol/@colspan) &gt; 0">
							<xsl:value-of select="position() + sum(./preceding-sibling::tablecol/@colspan) - 1"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="position()"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="span"><xsl:choose><xsl:when test="@colspan"><xsl:value-of select="number(@colspan) - $spanOffset"/></xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:attribute>
			</cell>
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>

<xsl:template name="getOffsetSpan">
	<xsl:param name="origTable"/>
	<xsl:variable name="minSpan" as="xsd:integer">
		<xsl:choose>
			<xsl:when test="count($origTable/tablerow/tablecol[not(@colspan)]) &gt; 0">
				<!-- normal situation, at least 1 cell does not have a colspan -->
				0
			</xsl:when>
			<xsl:otherwise>
				<!-- Bad cell layout. All cells have colspans we'll take the minimum one and use that as our offset -->
				<xsl:value-of select="min($origTable/tablerow/tablecol/@colspan) - 1"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:value-of select="$minSpan"/>
</xsl:template>


</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="file:///l:/EPL/BCLaws/live/&#x2D;- S &#x2D;-/Strata Property Act [SBC 1998] c. 43/00_Act/00_98043_multi.xml" htmlbaseurl="" outputurl="outputs\AccessToAbortion.fo"
		          processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
		          postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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