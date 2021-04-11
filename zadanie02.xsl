<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <body>
                <h1>Kniznice</h1>
                <xsl:apply-templates select="/kniznice/kniznica"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/kniznice/kniznica">
        <h2>Kniznica</h2>
        <p>
            <xsl:value-of select="@nazov"/>
            <br/>
            <xsl:value-of select="@adresa"/>
        </p>
        <xsl:apply-templates select="zanre"/>
    </xsl:template>

    <xsl:template match="zanre">
        <h3>Zanre</h3>
        <xsl:for-each select="zaner">
            <table border="1">
                <tr>
                    <th>
                        <xsl:value-of select="meno"/>
                    </th>
                    <th>Pocet stran</th>
                    <th>Informacie</th>
                </tr>
                <xsl:for-each select="knihy">
                    <xsl:apply-templates select="kniha"/>
                </xsl:for-each>
            </table>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="kniha">
        <tr>
            <td>
                <xsl:value-of select="nazov"/>
            </td>
            <td>
                <xsl:value-of select="pocet_stran"/>
            </td>
            <td>
                <xsl:choose>
                    <xsl:when test="informacie/link">
                        <xsl:value-of select="informacie/link/@link_value"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="informacie"/>
                    </xsl:otherwise>
                </xsl:choose>

            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>

