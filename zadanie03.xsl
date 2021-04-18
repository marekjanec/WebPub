<?xml version="1.0" encoding="UTF-8"?>


<!-- avg(//zaner[meno = "Kukurica"]/knihy/kniha/pocet_stran) -->


<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- hlavny tenpalte zakladneho html dokumentu -->
    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 800"
             version="1.1" baseProfile="full">


            <xsl:call-template name="title"/>

            <xsl:call-template name="graph"/>


        </svg>
    </xsl:template>

    <xsl:template name="title">
        <title>
            <xsl:attribute name="id">
                <xsl:text>title</xsl:text>
            </xsl:attribute>
            <xsl:text>Nadpis mojho uzassneho grafu</xsl:text>
        </title>
        <desc>
            <xsl:attribute name="id">
                <xsl:text>desc</xsl:text>
            </xsl:attribute>
            <xsl:text>Priemerny pocet stran na knihu za zaner</xsl:text>
        </desc>
    </xsl:template>

    <xsl:template name="graph">
        <!-- axes -->
        <g stroke="#777" stroke-width="1" font-size="18" font-family="Helvetica">
            <!-- Y wrapper -->
            <g transform="translate(100, 100)">
                <!-- Y line -->
                <line x1="0" x2="0" y1="0" y2="600"/>

                <!-- Y ticks -->
                <line x1="-7" x2="0" y1="100" y2="100"/>
                <line x1="-7" x2="0" y1="200" y2="200"/>
                <line x1="-7" x2="0" y1="300" y2="300"/>
                <line x1="-7" x2="0" y1="400" y2="400"/>
                <line x1="-7" x2="0" y1="500" y2="500"/>

                <!-- auxiliary lines -->
                <g stroke="#ccc" stroke-dasharray="10 8">
                    <line x1="0" x2="600" y1="100" y2="100"/>
                    <line x1="0" x2="600" y1="200" y2="200"/>
                    <line x1="0" x2="600" y1="300" y2="300"/>
                    <line x1="0" x2="600" y1="400" y2="400"/>
                    <line x1="0" x2="600" y1="500" y2="500"/>
                </g>

                <!-- Y labels -->
                <g text-anchor="end" dominant-baseline="middle">
                    <text x="-10" y="100">10</text>
                    <text x="-10" y="200">8</text>
                    <text x="-10" y="300">6</text>
                    <text x="-10" y="400">4</text>
                    <text x="-10" y="500">2</text>
                </g>

                <!-- Y name -->
                <text x="-50" y="320" text-anchor="middle" dominant-baseline="middle" font-size="18" font-weight="bold"
                      transform="rotate(-90, -50, 320)">
                    Počet pesničiek
                </text>
            </g>

            <!-- X wrapper -->
            <g transform="translate(100, 700)">
                <!-- X line -->
                <line x1="0" x2="600" y1="0" y2="0"/>

                <!-- X ticks-->
                <line x1="100" x2="100" y1="7" y2="0"/>
                <line x1="200" x2="200" y1="7" y2="0"/>
                <line x1="300" x2="300" y1="7" y2="0"/>
                <line x1="400" x2="400" y1="7" y2="0"/>
                <line x1="500" x2="500" y1="7" y2="0"/>

                <!-- X labels -->
                <g text-anchor="end">
                    <text x="115" y="30" transform="rotate(-30, 115, 30)">R1</text>
                    <text x="215" y="30" transform="rotate(-30, 215, 30)">R2</text>
                    <text x="315" y="30" transform="rotate(-30, 315, 30)">R3</text>
                    <text x="415" y="30" transform="rotate(-30, 415, 30)">R4</text>
                    <text x="515" y="30" transform="rotate(-30, 515, 30)">R5</text>
                </g>

                <!-- X name -->
                <text x="280" y="70" text-anchor="middle" font-size="18" font-weight="bold">Hodnotenie</text>
            </g>

            <!-- bars -->
            <g transform="translate(100, 200)" stroke="#222" stroke-width="1" fill="#00f">
                <rect x="80" y="0" width="40">
                    <xsl:attribute name="height">
                        <xsl:value-of select="sum(//zaner[meno = 'Kukurica']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Kukurica']/knihy/kniha)"/>
                    </xsl:attribute>
                </rect>
                <rect x="180" y="50" width="40">
                    <xsl:attribute name="height">
                        <xsl:value-of select="sum(//zaner[meno = 'Mrkva']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Mrkva']/knihy/kniha)"/>
                    </xsl:attribute>
                </rect>
                <rect x="280" y="250" width="40">
                    <xsl:attribute name="height">
                        <xsl:value-of select="sum(//zaner[meno = 'Jablka']/knihy/kniha/pocet_stran) div count(//zaner[meno = 'Jablka']/knihy/kniha)"/>
                    </xsl:attribute>
                </rect>
            </g>
        </g>
    </xsl:template>

</xsl:stylesheet>