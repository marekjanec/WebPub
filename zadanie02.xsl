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

        <xsl:call-template name="popis">
            <xsl:with-param name="nazov_param" select="@nazov"/>
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
        <p>
            <xsl:value-of select="$nazov_param"/>
            <br/>
            <xsl:value-of select="$adresa_param"/>
        </p>
    </xsl:template>

    <xsl:template match="zanre">
        <h3>Zanre</h3>
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
                    <td>
                        <xsl:value-of select="meno"/>
                    </td>
                    <td>
                        <xsl:value-of select="datum_narodenia"/>
                    </td>
                    <td>
                        <xsl:if test="vypozicka/pozicana_kniha">
                            <xsl:text>S VYPOZICKOV</xsl:text>
                        </xsl:if>
                    </td>
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

