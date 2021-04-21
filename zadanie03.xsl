<?xml version="1.0" encoding="UTF-8"?>


<!-- avg(//zaner[meno = "Kukurica"]/knihy/kniha/pocet_stran) -->


<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- hlavny tenpalte zakladneho html dokumentu -->
    <xsl:template match="/">
        <xsl:call-template name="graph"/>
    </xsl:template>


    <xsl:template name="graph">
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 800 800"
             role="img"
             version="1.1" baseProfile="full">
            <title id="title">Stĺpcový graf - hodnotenie pesničiek za r. 2019</title>
            <desc id="desc">
                Hodnotenia pesničiek a ich početnosť naprieč všetkými albumami v roku 2019.
            </desc>

            <!-- osi -->
            <g stroke="#777" stroke-width="1" font-size="18" font-family="Helvetica">
                <!-- Y os -->
                <g transform="translate(100, 100)">
                    <!-- Y line -->
                    <line x1="0" x2="0" y1="0" y2="600"/>

                    <!-- Y ciakra mimo grafu pre stovky -->
                    <line x1="-10" x2="0" y1="100" y2="100"/>
                    <line x1="-10" x2="0" y1="200" y2="200"/>
                    <line x1="-10" x2="0" y1="300" y2="300"/>
                    <line x1="-10" x2="0" y1="400" y2="400"/>
                    <line x1="-10" x2="0" y1="500" y2="500"/>

                    <!-- Y ciakra mimo grafu pre polovice stoviek -->
                    <line x1="-5" x2="0" y1="150" y2="150"/>
                    <line x1="-5" x2="0" y1="250" y2="250"/>
                    <line x1="-5" x2="0" y1="350" y2="350"/>
                    <line x1="-5" x2="0" y1="450" y2="450"/>
                    <line x1="-5" x2="0" y1="550" y2="550"/>

                    <!-- ciarkovane ciary pre cele stovky -->
                    <g stroke="#ccc" stroke-dasharray="10 10">
                        <line x1="0" x2="600" y1="100" y2="100"/>
                        <line x1="0" x2="600" y1="200" y2="200"/>
                        <line x1="0" x2="600" y1="300" y2="300"/>
                        <line x1="0" x2="600" y1="400" y2="400"/>
                        <line x1="0" x2="600" y1="500" y2="500"/>
                    </g>

                    <!-- hustejsie ciarky pre polovice stoviek -->
                    <g stroke="#ccc" stroke-dasharray="10 4">
                        <line x1="0" x2="600" y1="150" y2="150"/>
                        <line x1="0" x2="600" y1="250" y2="250"/>
                        <line x1="0" x2="600" y1="350" y2="350"/>
                        <line x1="0" x2="600" y1="450" y2="450"/>
                        <line x1="0" x2="600" y1="550" y2="550"/>
                    </g>

                    <!-- Y popisy -->
                    <g text-anchor="end" dominant-baseline="middle">
                        <text x="-15" y="100">1000</text>
                        <text x="-15" y="200">800</text>
                        <text x="-15" y="300">600</text>
                        <text x="-15" y="400">400</text>
                        <text x="-15" y="500">200</text>
                    </g>

                    <!-- Y meno -->
                    <text x="-50" y="300" text-anchor="middle" dominant-baseline="middle" font-size="18"
                          font-weight="bold" transform="rotate(-90, -50, 320)">
                        Priemerný počet strán na knihu
                    </text>
                </g>

                <!-- X os -->
                <g transform="translate(100, 700)">
                    <!-- X ciara -->
                    <line x1="0" x2="600" y1="0" y2="0"/>

                    <!-- tie male ciraky na X osi-->
                    <!-- poziciu pocitam pomocou predchodcov zanru v xml subore -->
                    <xsl:for-each select="//zaner">
                        <line y1="7" y2="0">
                            <xsl:attribute name="x1">
                                <xsl:value-of select="100 + 200 * count(preceding-sibling::*)"/>
                            </xsl:attribute>
                            <xsl:attribute name="x2">
                                <xsl:value-of select="100 + 200 * count(preceding-sibling::*)"/>
                            </xsl:attribute>
                        </line>
                    </xsl:for-each>

                    <!-- popisy na X osi -->
                    <!-- poziciu pocitam pomocou predchodcov zanru v xml subore -->
                    <g text-anchor="end">
                        <xsl:for-each select="//zaner">
                            <text y="30">
                                <xsl:attribute name="x">
                                    <xsl:value-of select="100 + 200 * count(preceding-sibling::*)"/>
                                </xsl:attribute>
                                <xsl:attribute name="transform">
                                    <xsl:text>rotate(-30,</xsl:text>
                                    <xsl:value-of select="100 + 200 * count(preceding-sibling::*)"/>
                                    <xsl:text>, 30)</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of select="meno"/>
                            </text>
                        </xsl:for-each>
                    </g>

                    <!-- X name -->
                    <text x="280" y="85" text-anchor="middle" font-size="18" font-weight="bold">Žáner</text>
                </g>
            </g>


            <!-- stlpce -->
            <!-- stlpce obsahuju priemerny pocet stran na knizu pre zaner -->
            <!-- stlpce aj s priemerom vypisujem v cykle ktory funguje na zaklade poradia zanru v xml subore -->
            <!-- ak je priemerny pocet stran na knihu viac ako 1000 tak je vykresleny na maximalny
                 rozsah grafu a jeho prriemer je zapisany ako 1000+ -->
            <xsl:element name="g">
                <xsl:attribute name="transform">
                    <xsl:text>translate(100, 200)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="stroke">
                    <xsl:text>#222</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="stroke-width">
                    <xsl:text>.5</xsl:text>
                </xsl:attribute>
                <xsl:for-each select="//zaner">

                    <!-- stlpce -->
                    <xsl:element name="rect">
                        <xsl:attribute name="width">
                            <xsl:text>100</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="fill">
                            <xsl:text>#d3ecac</xsl:text>
                        </xsl:attribute>

                        <!-- nastavenie pozicie a vysky stlpcov -->
                        <xsl:choose>
                            <xsl:when
                                    test="(sum(knihy/kniha/pocet_stran) div count(knihy/kniha)) div 2 >= 1000">
                                <xsl:attribute name="y">
                                    <xsl:text>0</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="height">
                                    <xsl:text>500</xsl:text>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="y">
                                    <xsl:value-of
                                            select="500 - (sum(knihy/kniha/pocet_stran) div count(knihy/kniha)) div 2"/>
                                </xsl:attribute>
                                <xsl:attribute name="height">
                                    <xsl:value-of
                                            select="(sum(knihy/kniha/pocet_stran) div count(knihy/kniha)) div 2"/>
                                </xsl:attribute>

                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:attribute name="x">
                            <xsl:value-of
                                    select="50 + 200 * count(preceding-sibling::*)"/>
                        </xsl:attribute>
                    </xsl:element>

                    <!-- text na stlpcoch -->
                    <xsl:element name="text">
                        <xsl:attribute name="text-anchor">
                            <xsl:text>middle</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="dominant-baseline">
                            <xsl:text>middle</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="font-size">
                            <xsl:text>20</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="x">
                            <xsl:value-of
                                    select="100 + 200 * count(preceding-sibling::*)"/>
                        </xsl:attribute>

                        <!-- nastavenie pozicie a obsah textu -->
                        <xsl:choose>
                            <xsl:when
                                    test="sum(knihy/kniha/pocet_stran) div count(knihy/kniha) >= 1000">
                                <xsl:attribute name="y">
                                    <xsl:text>-6</xsl:text>
                                </xsl:attribute>
                                <xsl:text>1000+</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="y">
                                    <xsl:value-of
                                            select="494 - (sum(knihy/kniha/pocet_stran) div count(knihy/kniha)) div 2"/>
                                </xsl:attribute>
                                <xsl:value-of select="sum(knihy/kniha/pocet_stran) div count(knihy/kniha)"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </svg>
    </xsl:template>
</xsl:stylesheet>