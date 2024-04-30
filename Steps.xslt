<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:fmp="http://www.filemaker.com/fmpxmlresult">

	<xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8" />
	
	<xsl:key name="step-lookup" match="StepList/Step" use="@id"/>

	<xsl:key name="eds-lookup" match="FMPReport/File/ExternalDataSourcesCatalog/FileReference" use="@id"/>
	<xsl:key name="tables-lookup" match="FMPReport/File/RelationshipGraph/TableList/Table" use="@name"/>
	<xsl:key name="layout-lookup" match="FMPReport/File/LayoutCatalog/Layout|Group/Layout|Group/Group/Layout|Group/Group/Group/Layout|Group/Group/Group/Group/Layout|Group/Group/Group/Group/Group/Layout" use="@id"/>

	<xsl:variable name="step-file" select="document('BE_Steps.xml',/)" />

	<xsl:template match="/">
		<FMPXMLRESULT xmlns="http://www.filemaker.com/fmpxmlresult">
			<METADATA>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Type" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Script id Parent" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Layout id Parent" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="CustomMenu id Parent" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="code" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="index" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="source" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="name" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="enable" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="StepText" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Position" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="CurrentScript value" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Script id" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Script name" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Script Parameter" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Field id" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Field name" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Field Table" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Field BaseTable id" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Field FileReference id" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Layout Destination" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Layout id" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Layout name" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Table id" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Table name" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Table BaseTable id" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Table FileReference id" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Option State" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="CustomMenu id" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="CustomMenu name" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="PrivilegeSet id" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="PrivilegeSet name" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="FileReference id" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="FileReference name" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="FileReference pathList" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="XMLType" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="XSLType" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Variable Name" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="UniversalPathList" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="UniversalPathList type" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="XML" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Compatibility" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Incompatibility" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="MinimumVersion" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="MaximumVersion" TYPE="TEXT" />
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectName" TYPE="TEXT" />
			</METADATA>
			<RESULTSET>

				<xsl:for-each select="FMPReport/File">
						<xsl:for-each select="CustomMenuCatalog/CustomMenu">
							<xsl:variable name="Menuid" select="@id"/>
							<xsl:variable name="MenuName" select="@name"/>
			
							<xsl:for-each select="MenuItemList/MenuItem">
								<xsl:variable name="MenuItemName" select="Command/@name"/>

								<xsl:for-each select="self::node()[@isSeparatorItem!='True']">
									<xsl:for-each select="Step">
										<xsl:variable name="pos" select="position()"/>

										<xsl:call-template name="Step_RESULTSET">
											<xsl:with-param name="CustomMenuid" select="$Menuid"/>
											<xsl:with-param name="type" select="'MenuItem'"/>
											<xsl:with-param name="pos" select="$pos"/>
										</xsl:call-template>
									</xsl:for-each>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:for-each>

						<xsl:for-each select="LayoutCatalog">
							<xsl:for-each select="Layout|descendant::Group/Layout">
								<xsl:variable name="Layoutid" select="@id"/>
								<xsl:variable name="LayoutName" select="@name"/>
			
								<xsl:for-each select="descendant::Object">
									<xsl:variable name="ObjectType" select="@type"/>

									<xsl:for-each select="(GroupButtonObj|ButtonObj)/Step">
					
										<xsl:call-template name="Step_RESULTSET">
											<xsl:with-param name="Layoutid" select="$Layoutid"/>
											<xsl:with-param name="type" select="'Button'"/>
										</xsl:call-template>
									</xsl:for-each>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:for-each>
		
						<xsl:for-each select="ScriptCatalog">
							<xsl:for-each select="Script|descendant::Group|descendant::Group/Script">
								<xsl:variable name="Scriptid" select="@id"/>
								<xsl:variable name="ScriptName" select="@name"/>
			
								<xsl:for-each select="StepList">
									<xsl:for-each select="Step">
										<xsl:variable name="pos" select="position()"/>
					
										<xsl:call-template name="Step_RESULTSET">
											<xsl:with-param name="Scriptid" select="$Scriptid"/>
											<xsl:with-param name="type" select="'Step'"/>
											<xsl:with-param name="pos" select="$pos"/>
										</xsl:call-template>
									</xsl:for-each>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:for-each>

				</xsl:for-each>
			</RESULTSET>
		</FMPXMLRESULT>
	</xsl:template>

	<!-- End of / template-->


	<!-- Callable templates-->
	
	<xsl:template name="Step_RESULTSET">
		<xsl:param name="Scriptid"/>
		<xsl:param name="Layoutid"/>
		<xsl:param name="CustomMenuid"/>
		<xsl:param name="type"/>
		<xsl:param name="pos"/>
		
		<xsl:variable name="id" select="@id"/>

		<xsl:variable name="TableName" select="Table/@name"/>
		<xsl:variable name="TableFileRefereceid" select="key('tables-lookup',$TableName)/FileReference/@id"/>
		
		<xsl:variable name="Fieldid" select="Field/@id"/>
		<xsl:variable name="FieldTable" select="Field/@table"/>
		<xsl:variable name="BaseTableid" select="key('tables-lookup',$FieldTable)/@baseTableId"/>
		<xsl:variable name="FieldFileRefereceid" select="key('tables-lookup',$FieldTable)/FileReference/@id"/>


		<xsl:variable name="LayoutDestination" select="LayoutDestination/@value"/>
		<xsl:variable name="SelectedLayout"><xsl:if test="$LayoutDestination='SelectedLayout'"><xsl:value-of select="Layout/@id" /></xsl:if></xsl:variable>
							
		<xsl:variable name="varName" select="Name"/>

		<ROW>
			<COL><DATA><xsl:value-of select="$type" /></DATA></COL>
			<COL><DATA><xsl:value-of select="$Scriptid" /></DATA></COL>
			<COL><DATA><xsl:value-of select="$Layoutid" /></DATA></COL>
			<COL><DATA><xsl:value-of select="$CustomMenuid" /></DATA></COL>
			<COL><DATA><xsl:value-of select="$id" /></DATA></COL>
			<COL><DATA><xsl:value-of select="@index" /></DATA></COL>
			<COL><DATA><xsl:value-of select="@source" /></DATA></COL>
			<COL><DATA><xsl:value-of select="@name" /></DATA></COL>
			<COL><DATA><xsl:value-of select="@enable" /></DATA></COL>
			<COL><DATA>			
				<xsl:value-of select="StepText" />
				<xsl:if test="Text"><xsl:text>&#xa;</xsl:text><xsl:value-of select="Text" /></xsl:if>
			</DATA></COL>
			<COL><DATA><xsl:value-of select="$pos" /></DATA></COL>
			<COL><DATA><xsl:value-of select="CurrentScript/@value" /></DATA></COL>
			<COL><DATA><xsl:value-of select="Script/@id" /></DATA></COL>
			<COL><DATA><xsl:value-of select="Script/@name" /></DATA></COL>
			<COL><DATA><xsl:value-of select="self::node()[$id='1' or $id='148' or $id='164']/Calculation" /></DATA></COL>
			<COL><DATA><xsl:value-of select="$Fieldid" /></DATA></COL>
			<COL><DATA><xsl:value-of select="Field/@name" /></DATA></COL>
			<COL><DATA><xsl:value-of select="$FieldTable" /></DATA></COL>
			<COL><DATA><xsl:value-of select="$BaseTableid"/></DATA></COL>
			<COL><DATA><xsl:value-of select="$FieldFileRefereceid"/></DATA></COL>
			<COL><DATA><xsl:value-of select="$LayoutDestination" /></DATA></COL>
			<COL><DATA><xsl:value-of select="$SelectedLayout" /></DATA></COL>
			<COL><DATA><xsl:value-of select="Layout/@name" /></DATA></COL>
			<COL><DATA><xsl:value-of select="Table/@id" /></DATA></COL>
			<COL><DATA><xsl:value-of select="$TableName" /></DATA></COL>
			<COL><DATA><xsl:value-of select="$BaseTableid"/></DATA></COL>
			<COL><DATA><xsl:value-of select="$TableFileRefereceid"/></DATA></COL>
			<COL><DATA><xsl:value-of select="Option/@state" /></DATA></COL>
			<COL><DATA><xsl:value-of select="CustomMenuSet/@id" /></DATA></COL>
			<COL><DATA><xsl:value-of select="CustomMenuSet/@name" /></DATA></COL>
			<COL><DATA><xsl:value-of select="PrivilegeSet/@id" /></DATA></COL>
			<COL><DATA><xsl:value-of select="PrivilegeSet/@name" /></DATA></COL>
			<COL><DATA><xsl:value-of select="FileReference/@id" /></DATA></COL>
			<COL><DATA><xsl:value-of select="FileReference/@name" /></DATA></COL>
			<COL><DATA><xsl:value-of select="FileReference/@pathList" /></DATA></COL>
			<COL><DATA><xsl:value-of select="Profile/@XMLType" /></DATA></COL>
			<COL><DATA><xsl:value-of select="Profile/@XSLType" /></DATA></COL>
			<COL><DATA><xsl:value-of select="$varName" /><xsl:value-of select="Field[substring(.,1,1)='$']" /></DATA></COL>
			<COL><DATA><xsl:value-of select="UniversalPathList" /></DATA><xsl:value-of select="Attachment/UniversalPathList" /></COL>
			<COL><DATA><xsl:value-of select="UniversalPathList/@type" /></DATA></COL>
			<COL><DATA><xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text><xsl:copy-of select="./*" /><xsl:text disable-output-escaping="yes">]]</xsl:text><xsl:text disable-output-escaping="yes">&gt;</xsl:text></DATA></COL>
			<COL><DATA><xsl:for-each select="$step-file"><xsl:value-of select="translate(key('step-lookup', $id)/@Compatibility,',','&#xa;')"/></xsl:for-each></DATA></COL>
			<COL><DATA><xsl:for-each select="$step-file"><xsl:value-of select="translate(key('step-lookup',$id)/@InCompatibility,',','&#xa;')" /></xsl:for-each></DATA></COL>
			<COL><DATA>			
				<xsl:choose>
					<xsl:when test="($id=1 and Calculated) or ($id=164 and Calculated)"><xsl:text>17</xsl:text></xsl:when>
					<xsl:when test="CreateDirectories/@state='True'"><xsl:text>17</xsl:text></xsl:when>
					<xsl:otherwise><xsl:for-each select="$step-file"><xsl:value-of select="key('step-lookup',$id)/@MinVersion" /></xsl:for-each></xsl:otherwise>
				</xsl:choose>
			</DATA></COL>
			<COL><DATA><xsl:for-each select="$step-file"><xsl:value-of select="key('step-lookup',$id)/@MaxVersion" /></xsl:for-each></DATA></COL>				
			<COL><DATA>
				<xsl:if test="ObjectName">
					<xsl:variable name="objectName" select="ObjectName[count(DisplayCalculation)=1]/Calculation[substring(.,1,1)='&quot;' and substring(.,string-length(.),1)='&quot;']"/>
					<xsl:value-of select="substring($objectName,2,string-length($objectName)-2)"/>
				</xsl:if>
			</DATA></COL>
		</ROW>
	</xsl:template>
</xsl:stylesheet>