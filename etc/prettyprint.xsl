<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8"
		omit-xml-declaration="no"
		indent="yes"/>
    <xsl:param name="indent-increment" select="'  '"/>

    <xsl:template match="/">
	<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
	<xsl:apply-templates select="node()|@*|text()"/>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>    

    <xsl:template name="newline">
	<xsl:text disable-output-escaping="yes">
	</xsl:text>
    </xsl:template>

    <xsl:template match="comment() | processing-instruction()">
	<xsl:param name="indent" select="''"/>
	<xsl:call-template name="newline"/>
	<xsl:value-of select="$indent"/>
	<xsl:copy />
    </xsl:template>

    <xsl:template match="text()">
	<xsl:param name="indent" select="''"/>
	<xsl:call-template name="newline"/>
	<xsl:value-of select="$indent"/>
	<xsl:value-of select="normalize-space(.)"/>
    </xsl:template>

    <xsl:template match="text()[normalize-space(.)='']"/>

    <xsl:template match="*">
	<xsl:param name="indent" select="''"/>
	<xsl:call-template name="newline"/>
	<xsl:value-of select="$indent"/>
	<xsl:choose>
	    <xsl:when test="count(child::*) > 0">
		<xsl:copy>
		    <xsl:copy-of select="@*"/>
		    <xsl:apply-templates select="*|text()">
			<xsl:with-param name="indent" select="concat ($indent, $indent-increment)"/>
		    </xsl:apply-templates>
		    <xsl:call-template name="newline"/>
		    <xsl:value-of select="$indent"/>
		</xsl:copy>
	    </xsl:when>
	    <xsl:otherwise>
		<xsl:copy-of select="."/>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:template>
</xsl:stylesheet>
