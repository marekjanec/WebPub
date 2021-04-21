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

            <!-- axes -->
            <g stroke="#777" stroke-width="1" font-size="18" font-family="Helvetica">
                <!-- Y wrapper -->
                <g transform="translate(100, 100)">
                    <!-- Y line -->
                    <line x1="0" x2="0" y1="0" y2="600"/>

                    <!-- Y ticks -->
                    <line x1="-10" x2="0" y1="100" y2="100"/>
                    <line x1="-10" x2="0" y1="200" y2="200"/>
                    <line x1="-10" x2="0" y1="300" y2="300"/>
                    <line x1="-10" x2="0" y1="400" y2="400"/>
                    <line x1="-10" x2="0" y1="500" y2="500"/>

                    <line x1="-5" x2="0" y1="150" y2="150"/>
                    <line x1="-5" x2="0" y1="250" y2="250"/>
                    <line x1="-5" x2="0" y1="350" y2="350"/>
                    <line x1="-5" x2="0" y1="450" y2="450"/>
                    <line x1="-5" x2="0" y1="550" y2="550"/>

                    <!-- auxiliary lines -->
                    <g stroke="#ccc" stroke-dasharray="10 10">
                        <line x1="0" x2="600" y1="100" y2="100"/>
                        <line x1="0" x2="600" y1="200" y2="200"/>
                        <line x1="0" x2="600" y1="300" y2="300"/>
                        <line x1="0" x2="600" y1="400" y2="400"/>
                        <line x1="0" x2="600" y1="500" y2="500"/>
                    </g>

                    <!-- auxiliary lines -->
                    <g stroke="#ccc" stroke-dasharray="10 4">
                        <line x1="0" x2="600" y1="150" y2="150"/>
                        <line x1="0" x2="600" y1="250" y2="250"/>
                        <line x1="0" x2="600" y1="350" y2="350"/>
                        <line x1="0" x2="600" y1="450" y2="450"/>
                        <line x1="0" x2="600" y1="550" y2="550"/>
                    </g>

                    <!-- Y labels -->
                    <g text-anchor="end" dominant-baseline="middle">
                        <text x="-15" y="100">1000</text>
                        <text x="-15" y="200">800</text>
                        <text x="-15" y="300">600</text>
                        <text x="-15" y="400">400</text>
                        <text x="-15" y="500">200</text>
                    </g>

                    <!-- Y name -->
                    <text x="-50" y="300" text-anchor="middle" dominant-baseline="middle" font-size="18"
                          font-weight="bold" transform="rotate(-90, -50, 320)">
                        Priemerný počet strán na knihu
                    </text>
                </g>

                <!-- X wrapper -->
                <g transform="translate(100, 700)">
                    <!-- X line -->
                    <line x1="0" x2="600" y1="0" y2="0"/>

                    <!-- X ticks-->
                    <line x1="100" x2="100" y1="7" y2="0"/>
                    <line x1="300" x2="300" y1="7" y2="0"/>
                    <line x1="500" x2="500" y1="7" y2="0"/>

                    <!-- X labels -->
                    <g text-anchor="end">
                        <text x="100" y="30" transform="rotate(-30, 100, 30)">Kukurice</text>
                        <text x="300" y="30" transform="rotate(-30, 300, 30)">Mrkva</text>
                        <text x="500" y="30" transform="rotate(-30, 500, 30)">Jablka</text>
                    </g>

                    <!-- X name -->
                    <text x="280" y="85" text-anchor="middle" font-size="18" font-weight="bold">Žáner</text>
                </g>
            </g>


            <!-- bars -->
            <g transform="translate(100, 200)" stroke="#222" stroke-width=".5">

                <rect x="50" width="100" fill="#d3ecac">
                    <xsl:choose>
                        <xsl:when
                                test="(sum(//zaner[meno = 'Kukurica']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Kukurica']/knihy/kniha)) div 2 >= 1000">
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
                                        select="500 - (sum(//zaner[meno = 'Kukurica']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Kukurica']/knihy/kniha)) div 2"/>
                            </xsl:attribute>
                            <xsl:attribute name="height">
                                <xsl:value-of
                                        select="(sum(//zaner[meno = 'Kukurica']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Kukurica']/knihy/kniha)) div 2"/>
                            </xsl:attribute>

                        </xsl:otherwise>
                    </xsl:choose>
                </rect>

                <rect x="250" width="100" fill="#d3ecac">
                    <xsl:choose>
                        <xsl:when
                                test="(sum(//zaner[meno = 'Mrkva']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Mrkva']/knihy/kniha)) div 2 >= 1000">
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
                                        select="500 - (sum(//zaner[meno = 'Mrkva']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Mrkva']/knihy/kniha)) div 2"/>
                            </xsl:attribute>
                            <xsl:attribute name="height">
                                <xsl:value-of
                                        select="(sum(//zaner[meno = 'Mrkva']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Mrkva']/knihy/kniha)) div 2"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </rect>

                <rect x="450" width="100" fill="#d3ecac">
                    <xsl:choose>
                        <xsl:when
                                test="(sum(//zaner[meno = 'Jablka']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Jablka']/knihy/kniha)) div 2 >= 1000">
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
                                        select="500 - (sum(//zaner[meno = 'Jablka']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Jablka']/knihy/kniha)) div 2"/>
                            </xsl:attribute>
                            <xsl:attribute name="height">
                                <xsl:value-of
                                        select="(sum(//zaner[meno = 'Jablka']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Jablka']/knihy/kniha)) div 2"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </rect>

                <text x="100" text-anchor="middle" dominant-baseline="middle" font-size="20">
                    <xsl:choose>
                        <xsl:when
                                test="(sum(//zaner[meno = 'Jablka']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Jablka']/knihy/kniha)) div 2 >= 1000">
                            <xsl:attribute name="y">
                                <xsl:text>-6</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="y">
                                <xsl:value-of
                                        select="494 - (sum(//zaner[meno = 'Kukurica']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Kukurica']/knihy/kniha)) div 2"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of
                            select="sum(//zaner[meno = 'Kukurica']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Kukurica']/knihy/kniha)"/>
                </text>

                <text x="300" text-anchor="middle" dominant-baseline="middle" font-size="20">
                    <xsl:choose>
                        <xsl:when
                                test="(sum(//zaner[meno = 'Jablka']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Jablka']/knihy/kniha)) div 2 >= 1000">
                            <xsl:attribute name="y">
                                <xsl:text>-6</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="y">
                                <xsl:value-of
                                        select="494 - (sum(//zaner[meno = 'Mrkva']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Mrkva']/knihy/kniha)) div 2"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of
                            select="sum(//zaner[meno = 'Mrkva']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Mrkva']/knihy/kniha)"/>
                </text>

                <text x="500" text-anchor="middle" dominant-baseline="middle" font-size="20">
                    <xsl:choose>
                        <xsl:when
                                test="(sum(//zaner[meno = 'Jablka']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Jablka']/knihy/kniha)) div 2 >= 1000">
                            <xsl:attribute name="y">
                                <xsl:text>-6</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="y">
                                <xsl:value-of
                                        select="494 - (sum(//zaner[meno = 'Jablka']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Jablka']/knihy/kniha)) div 2"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of
                            select="sum(//zaner[meno = 'Jablka']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Jablka']/knihy/kniha)"/>
                </text>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>