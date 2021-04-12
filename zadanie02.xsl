<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <body>
                <xsl:apply-templates select="/kniznice/kniznica"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/kniznice/kniznica">
        <xsl:element name="h1">
            <xsl:text>Kniznice</xsl:text>
        </xsl:element>

        <xsl:call-template name="popis">
            <xsl:with-param name="nazov_param" select="@nazov_kniznice"/>
            <xsl:with-param name="adresa_param" select="@adresa"/>
        </xsl:call-template>

        <xsl:apply-templates select="zanre"/>
        <xsl:apply-templates select="uzivatelia"/>
        <xsl:apply-templates select="knihovnici"/>
        <xsl:apply-templates select="autori"/>
        <xsl:call-template name="pozicane_knihy">

        </xsl:call-template>
        <xsl:call-template name="pozicane_knihy_pocty">

        </xsl:call-template>


    </xsl:template>

    <xsl:variable name="header">
        <tr>
            <th>Nazov</th>
            <th>Pocet stran</th>
            <th>Informacie</th>
        </tr>
    </xsl:variable>

    <xsl:template name="popis">
        <xsl:param name="nazov_param"/>
        <xsl:param name="adresa_param"/>

        <xsl:element name="h2">
            <xsl:text>Kniznica</xsl:text>
        </xsl:element>

        <p>
            <xsl:value-of select="$nazov_param"/>
            <br/>
            <xsl:value-of select="$adresa_param"/>
        </p>
    </xsl:template>

    <xsl:template match="zanre">
        <xsl:element name="h3">
            <xsl:text>Zanre</xsl:text>
        </xsl:element>

        <xsl:for-each select="zaner">
            <table border="1">
                <xsl:copy-of select="$header"/>
                <xsl:for-each select="knihy">
                    <xsl:apply-templates select="kniha"/>
                </xsl:for-each>
            </table>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="kniha">
        <tr>
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <td>
                <xsl:value-of select="nazov"/>
            </td>
            <td>
                <xsl:value-of select="pocet_stran"/>
            </td>

            <xsl:call-template name="kniha_info">
                <xsl:with-param name="informacie_obsah" select="informacie"/>
            </xsl:call-template>

        </tr>
    </xsl:template>

    <xsl:template name="kniha_info">
        <xsl:param name="informacie_obsah"/>
        <td>
            <xsl:choose>
                <xsl:when test="$informacie_obsah/link">
                    <xsl:value-of select="$informacie_obsah/link/@link_value"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$informacie_obsah"/>
                </xsl:otherwise>
            </xsl:choose>
        </td>

    </xsl:template>

    <xsl:variable name="header_meno_datum">
        <tr>
            <th>Meno</th>
            <th>datum narodenia</th>
        </tr>
    </xsl:variable>

    <xsl:template match="uzivatelia">
        <h3>Uzivatelia</h3>
        <table border="1">
            <xsl:copy-of select="$header_meno_datum"/>
            <xsl:for-each select="uzivatel">
                <tr>
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>

                    <xsl:element name="td">
                        <xsl:value-of select="meno"/>
                    </xsl:element>

                    <xsl:element name="td">
                        <xsl:value-of select="datum_narodenia"/>
                    </xsl:element>

                    <xsl:element name="td">
                        <xsl:if test="vypozicka/pozicana_kniha">
                            <xsl:text>S VYPOZICKOV</xsl:text>
                        </xsl:if>
                    </xsl:element>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template match="knihovnici">
        <h3>Knihovnici</h3>
        <table border="1">
            <xsl:copy-of select="$header_meno_datum"/>
            <xsl:for-each select="knihovnik">
                <tr>
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>

                    <xsl:element name="td">
                        <xsl:value-of select="meno"/>
                    </xsl:element>

                    <xsl:element name="td">
                        <xsl:value-of select="datum_narodenia"/>
                    </xsl:element>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template match="autori">
        <h3>Autori</h3>
        <table border="1">
            <xsl:copy-of select="$header_meno_datum"/>
            <xsl:for-each select="autor">
                <tr>
                    <td>
                        <xsl:value-of select="meno"/>
                    </td>
                    <td>
                        <xsl:value-of select="datum_narodenia"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template name="pozicane_knihy">
        <h3>Pozicane knihy</h3>
        <table border="1">

            <xsl:for-each select="//kniha[@id = //pozicana_kniha/@idKnihy]">
                <tr>
                    <td>
                        <xsl:value-of select="@id"/>
                    </td>
                    <td>
                        <xsl:value-of select="nazov"/>
                    </td>
                    <td>
                        <xsl:value-of select="pocet_stran"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>



    <xsl:template name="pozicane_knihy_pocty">
        <h3>Pozicane knihy</h3>
        <table border="1">

            <xsl:for-each select="//uzivatel/vypozicka/pozicana_kniha">
                <tr>
                    <td>
                        <xsl:value-of select="@idKnihy"/>
                    </td>
                    <td>
                        <xsl:value-of select="@vypozicane_do"/>
                    </td>
                    <td>
                        <xsl:value-of select="@stav"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>


</xsl:stylesheet>

