<?xml version="1.0" encoding="utf-8"?><!-- Copyright © Goya Pty Ltd 2006-2012, All Rights Reserved --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.filemaker.com/fmpxmlresult" version="1.0">	<xsl:output method="xml" encoding="UTF-8"/>	<xsl:template match="/">		<FMPXMLRESULT xmlns="http://www.filemaker.com/fmpxmlresult">			<METADATA>				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="id" TYPE="TEXT"/>				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="name" TYPE="TEXT"/>				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="comment" TYPE="TEXT"/>			</METADATA>			<RESULTSET>				<xsl:for-each select="/FMPReport/File">					<xsl:for-each select="ExtendedPrivilegeCatalog/ExtendedPrivilege">						<ROW>							<COL>								<DATA>									<xsl:value-of select="@id"/>								</DATA>							</COL>							<COL>								<DATA>									<xsl:value-of select="@name"/>								</DATA>							</COL>							<COL>								<DATA>									<xsl:value-of select="@comment"/>								</DATA>							</COL>						</ROW>					</xsl:for-each>				</xsl:for-each>			</RESULTSET>		</FMPXMLRESULT>	</xsl:template></xsl:stylesheet>