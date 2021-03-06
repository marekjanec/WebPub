<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- hlavny tenpalte zakladneho html dokumentu -->
    <xsl:template match="/">
        <html>
            <head>
                <xsl:call-template name="head"/>
            </head>
            <body>
                <div class="main_div">
                    <xsl:apply-templates select="/kniznice/kniznica"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- tenplaty pre kniznicu -->
    <xsl:template match="/kniznice/kniznica">
        <xsl:element name="h1">
            <xsl:text>Knižnice</xsl:text>
        </xsl:element>

        <!-- tenplate popis ktory sa vola s pramentrami nazvu a adresy kniznice -->
        <xsl:call-template name="popis">
            <xsl:with-param name="nazov_param" select="@nazov_kniznice"/>
            <xsl:with-param name="adresa_param" select="@adresa"/>
        </xsl:call-template>

        <!-- tenplaty pre ostatne elemnty zo suboru -->
        <xsl:apply-templates select="zanre"/>
        <xsl:apply-templates select="uzivatelia"/>
        <xsl:apply-templates select="knihovnici"/>
        <xsl:apply-templates select="autori"/>

        <!-- tenplaty pre pocty pozicanych knih -->
        <xsl:call-template name="pozicane_knihy"/>
        <xsl:call-template name="pozicane_knihy_pocty"/>
    </xsl:template>

    <!-- hlavicka pre tabulky knih -->
    <xsl:variable name="header">
        <thead>
            <xsl:attribute name="class">
                <xsl:text>table_class_header</xsl:text>
            </xsl:attribute>
            <tr>
                <th>Názov</th>
                <th>

                    <xsl:attribute name="class">
                        <xsl:text>table_row</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Počet strán</xsl:text>
                </th>
                <th>Informácie</th>
            </tr>
        </thead>
    </xsl:variable>

    <!-- tenplate s linkami pre nalinkovanie css suborov a metadata pre responzivitu -->
    <xsl:template name="head">
        <xsl:element name="link">
            <xsl:attribute name="rel">
                <xsl:text>stylesheet</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="type">
                <xsl:text>text/css</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="media">
                <xsl:text>screen</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>screen.css</xsl:text>
            </xsl:attribute>
        </xsl:element>

        <xsl:element name="link">
            <xsl:attribute name="rel">
                <xsl:text>stylesheet</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="type">
                <xsl:text>text/css</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="media">
                <xsl:text>print</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>print.css</xsl:text>
            </xsl:attribute>
        </xsl:element>

        <xsl:element name="meta">
            <xsl:attribute name="name">
                <xsl:text>viewport</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="content">
                <xsl:text>width=device-width, initial-scale=1.0</xsl:text>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>

    <!-- tenplate pre popis kniznice -->
    <xsl:template name="popis">
        <xsl:param name="nazov_param"/>
        <xsl:param name="adresa_param"/>

        <xsl:element name="h2">
            <xsl:text>Knižnica</xsl:text>
        </xsl:element>

        <p>
            <xsl:value-of select="$nazov_param"/>
            <br/>
            <xsl:value-of select="$adresa_param"/>
        </p>
    </xsl:template>

    <!-- tenplate pre zanre -->
    <xsl:template match="zanre">
        <xsl:element name="h2">
            <xsl:text>Žánre</xsl:text>
        </xsl:element>
        <!-- cyklus pre jednotlive zanre -->
        <xsl:for-each select="zaner">
            <xsl:element name="h3">
                <xsl:value-of select="meno"/>
            </xsl:element>
            <table>
                <xsl:attribute name="class">
                    <xsl:text>table_class</xsl:text>
                </xsl:attribute>
                <xsl:copy-of select="$header"/>
                <!-- cyklus pre knihy v zanri -->
                <xsl:for-each select="knihy">
                    <xsl:apply-templates select="kniha"/>
                </xsl:for-each>
            </table>
        </xsl:for-each>
    </xsl:template>

    <!-- tenplate pre knihu v tebulke podla zanru -->
    <xsl:template match="kniha">
        <tbody>
            <tr>
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
                <td>
                    <xsl:copy>
                        <xsl:value-of select="nazov"/>
                    </xsl:copy>
                </td>
                <td>
                    <xsl:attribute name="class">
                        <xsl:text>table_row</xsl:text>
                    </xsl:attribute>
                    <xsl:copy>
                        <xsl:value-of select="pocet_stran"/>
                    </xsl:copy>

                </td>

                <!-- tenplate rozdelujuci rozne data v sekcii informacie -->
                <xsl:call-template name="kniha_info">
                    <xsl:with-param name="informacie_obsah" select="informacie"/>
                </xsl:call-template>
            </tr>
        </tbody>
    </xsl:template>

    <!-- tenplate triediaci bud text infrmacii o knihe alebo link -->
    <xsl:template name="kniha_info">
        <xsl:param name="informacie_obsah"/>
        <td>
            <xsl:choose>
                <xsl:when test="$informacie_obsah/link">
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:value-of select="$informacie_obsah/link/@link_value"/>
                        </xsl:attribute>
                        <xsl:text>stranka knihy</xsl:text>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$informacie_obsah"/>
                </xsl:otherwise>
            </xsl:choose>
        </td>
    </xsl:template>

    <!-- hlavicka tabulky s menom a datumom -->
    <xsl:variable name="header_meno_datum">
        <thead>
            <xsl:attribute name="class">
                <xsl:text>table_class_header</xsl:text>
            </xsl:attribute>
            <tr>
                <th>Meno</th>
                <th>
                    <xsl:attribute name="class">
                        <xsl:text>table_row</xsl:text>
                    </xsl:attribute>
                    <xsl:text>dátum narodenia</xsl:text>
                </th>
            </tr>
        </thead>
    </xsl:variable>

    <!--  hlavicka tabulky s menom a datumom -->
    <xsl:variable name="header_meno_datum_vypozicka">
        <thead>
            <xsl:attribute name="class">
                <xsl:text>table_class_header</xsl:text>
            </xsl:attribute>
            <tr>
                <th>Meno</th>
                <th>
                    <xsl:attribute name="class">
                        <xsl:text>table_row</xsl:text>
                    </xsl:attribute>
                    <xsl:text>datum narodenia</xsl:text>
                </th>
                <th>pôžičky</th>
            </tr>
        </thead>
    </xsl:variable>

    <!-- tenplate pre uzivatelov -->
    <xsl:template match="uzivatelia">
        <h2>Užívatelia</h2>
        <table>
            <xsl:attribute name="class">
                <xsl:text>table_class</xsl:text>
            </xsl:attribute>
            <xsl:copy-of select="$header_meno_datum_vypozicka"/>
            <tbody>
                <xsl:for-each select="uzivatel">
                    <tr>
                        <xsl:attribute name="id">
                            <xsl:value-of select="@id"/>
                        </xsl:attribute>

                        <xsl:element name="td">
                            <xsl:value-of select="meno"/>
                        </xsl:element>

                        <xsl:element name="td">
                            <xsl:attribute name="class">
                                <xsl:text>table_row</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="datum_narodenia"/>
                        </xsl:element>

                        <xsl:element name="td">
                            <xsl:if test="vypozicka/pozicana_kniha">
                                <xsl:text>S VYPOZICKOV</xsl:text>
                            </xsl:if>
                        </xsl:element>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>

    <!-- tenplate pre knihovikov -->
    <xsl:template match="knihovnici">
        <h2>Knihovníci</h2>
        <table>
            <xsl:attribute name="class">
                <xsl:text>table_class</xsl:text>
            </xsl:attribute>
            <xsl:copy-of select="$header_meno_datum"/>
            <tbody>
                <xsl:for-each select="knihovnik">
                    <tr>
                        <xsl:attribute name="id">
                            <xsl:value-of select="@id"/>
                        </xsl:attribute>

                        <xsl:element name="td">
                            <xsl:value-of select="meno"/>
                        </xsl:element>

                        <xsl:element name="td">
                            <xsl:attribute name="class">
                                <xsl:text>table_row</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="datum_narodenia"/>
                        </xsl:element>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>

    <!-- tenpalte pre autorov -->
    <xsl:template match="autori">
        <h2>Autori</h2>
        <table>
            <xsl:attribute name="class">
                <xsl:text>table_class</xsl:text>
            </xsl:attribute>
            <xsl:copy-of select="$header_meno_datum"/>
            <tbody>
                <xsl:for-each select="autor">
                    <tr>
                        <td>
                            <xsl:value-of select="meno"/>
                        </td>
                        <td>
                            <xsl:attribute name="class">
                                <xsl:text>table_row</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="datum_narodenia"/>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>

    <!-- tenplate pre pozicane diela -->
    <xsl:template name="pozicane_knihy">
        <!-- nadpis obsahuje pocet diel ktore su pozicane -->
        <xsl:element name="h2">
            <xsl:text>Požičané knihy podľa diela:</xsl:text>
            <xsl:value-of select="count(//kniha[@id = //pozicana_kniha/@idKnihy])"/>
        </xsl:element>

        <table>
            <xsl:attribute name="class">
                <xsl:text>table_class</xsl:text>
            </xsl:attribute>
            <thead>
                <tr>
                    <th>
                        <xsl:text>ID</xsl:text>
                    </th>
                    <th>
                        <xsl:text>Názov</xsl:text>
                    </th>
                </tr>
            </thead>
            <!-- xpath pre knihy ktroe su v zoznema knih a zarov su pozicane -->
            <tbody>
                <xsl:for-each select="//kniha[@id = //pozicana_kniha/@idKnihy]">
                    <tr>
                        <td>
                            <xsl:value-of select="@id"/>
                        </td>
                        <td>
                            <xsl:value-of select="nazov"/>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>

    <!-- tenplate pre pozicane knihy u jednotlvych uzivatelov -->
    <xsl:template name="pozicane_knihy_pocty">
        <!-- celkovy pocet pozicanych knih -->
        <xsl:element name="h2">
            <xsl:text>Požičané knihy podľa počtu:</xsl:text>
            <xsl:value-of select="count(//pozicana_kniha)"/>
        </xsl:element>
        <table>
            <xsl:attribute name="class">
                <xsl:text>table_class</xsl:text>
            </xsl:attribute>

            <!-- cyklus pre uzivatelov ktroy maju pozicanu aspon jednu knihu -->
            <xsl:for-each select="//uzivatel[vypozicka[count(*) > 0]]">

                <xsl:element name="tr">
                    <xsl:element name="th">
                        <xsl:value-of select="meno"/>
                    </xsl:element>
                    <xsl:element name="th">
                        <xsl:text>vypozicane do</xsl:text>
                    </xsl:element>
                    <xsl:element name="th">
                        <xsl:text>stav</xsl:text>
                    </xsl:element>
                </xsl:element>

                <!-- vypis knih u jednotlivych uzivatelov -->
                <xsl:for-each select="vypozicka/pozicana_kniha">
                    <xsl:element name="tr">
                        <xsl:element name="td">
                            <xsl:text>ID:</xsl:text>
                            <xsl:value-of select="@idKnihy"/>
                        </xsl:element>


                        <xsl:element name="td">
                            <xsl:value-of select="@vypozicane_do"/>
                        </xsl:element>

                        <xsl:element name="td">
                            <xsl:attribute name="class">
                                <xsl:value-of select="@stav"/>
                            </xsl:attribute>
                            <xsl:value-of select="@stav"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:for-each>
            </xsl:for-each>
        </table>
    </xsl:template>
</xsl:stylesheet>

