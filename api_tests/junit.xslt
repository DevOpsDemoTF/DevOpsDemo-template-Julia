<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" indent="no"/>

  <xsl:template match="/">
    <xsl:apply-templates select="//testsuite/testcase [failure]" />
    <xsl:apply-templates select="//testsuite/testcase [error]" />
  </xsl:template>

  <xsl:template match="testsuite/testcase [failure]">
    <xsl:text>FAILURE: </xsl:text>
    <xsl:value-of select="@classname" />
    <xsl:text>.</xsl:text>
    <xsl:value-of select="@name" />
    <xsl:text>&#xA;</xsl:text>
    <xsl:apply-templates select="failure" />
  </xsl:template>

  <xsl:template match="testsuite/testcase [error]">
    <xsl:text>ERROR: </xsl:text>
    <xsl:value-of select="@classname" />
    <xsl:text>.</xsl:text>
    <xsl:value-of select="@name" />
    <xsl:text>&#xA;</xsl:text>
    <xsl:apply-templates select="error" />
  </xsl:template>

  <xsl:template match="failure">
    <xsl:value-of select="@message" />
    <xsl:text>: </xsl:text>
    <xsl:value-of select="text()" />
    <xsl:text>&#xA;&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="error">
    <xsl:value-of select="@message" />
    <xsl:text>: </xsl:text>
    <xsl:value-of select="text()" />
    <xsl:text>&#xA;&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>