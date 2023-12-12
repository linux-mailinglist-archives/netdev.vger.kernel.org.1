Return-Path: <netdev+bounces-56220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7006F80E300
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86F1B219C4
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4F4BA5F;
	Tue, 12 Dec 2023 03:51:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A31CE;
	Mon, 11 Dec 2023 19:51:17 -0800 (PST)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rCtnU-0002vJ-0o;
	Tue, 12 Dec 2023 03:51:05 +0000
Date: Tue, 12 Dec 2023 03:51:01 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: [RFC PATCH net-next v3 7/8] dt-bindings: net: mediatek,net: fix and
 complete mt7988-eth binding
Message-ID: <ac6a7277fc534f610386bc51b2ff87beade03be8.1702352117.git.daniel@makrotopia.org>
References: <cover.1702352117.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702352117.git.daniel@makrotopia.org>

Complete support for MT7988 which comes with 3 MACs, SRAM for DMA
descriptors and uses a dedicated PCS for the SerDes units.

Fixes: c94a9aabec36 ("dt-bindings: net: mediatek,net: add mt7988-eth binding")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../devicetree/bindings/net/mediatek,net.yaml | 148 +++++++++++++++++-
 1 file changed, 146 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 030d106bc7d3f..ca0667c51c1c2 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -28,7 +28,10 @@ properties:
       - ralink,rt5350-eth
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Base of registers used to program the ethernet controller
+      - description: SRAM region used for DMA descriptors
 
   clocks: true
   clock-names: true
@@ -115,6 +118,9 @@ allOf:
               - mediatek,mt7623-eth
     then:
       properties:
+        reg:
+          maxItems: 1
+
         interrupts:
           maxItems: 3
 
@@ -149,6 +155,9 @@ allOf:
               - mediatek,mt7621-eth
     then:
       properties:
+        reg:
+          maxItems: 1
+
         interrupts:
           maxItems: 1
 
@@ -174,6 +183,9 @@ allOf:
             const: mediatek,mt7622-eth
     then:
       properties:
+        reg:
+          maxItems: 1
+
         interrupts:
           maxItems: 3
 
@@ -215,6 +227,9 @@ allOf:
             const: mediatek,mt7629-eth
     then:
       properties:
+        reg:
+          maxItems: 1
+
         interrupts:
           maxItems: 3
 
@@ -257,6 +272,9 @@ allOf:
             const: mediatek,mt7981-eth
     then:
       properties:
+        reg:
+          maxItems: 1
+
         interrupts:
           minItems: 4
 
@@ -295,6 +313,9 @@ allOf:
             const: mediatek,mt7986-eth
     then:
       properties:
+        reg:
+          maxItems: 1
+
         interrupts:
           minItems: 4
 
@@ -333,8 +354,12 @@ allOf:
             const: mediatek,mt7988-eth
     then:
       properties:
+        reg:
+          minItems: 2
+
         interrupts:
           minItems: 4
+          maxItems: 4
 
         clocks:
           minItems: 24
@@ -368,7 +393,7 @@ allOf:
             - const: top_netsys_warp_sel
 
 patternProperties:
-  "^mac@[0-1]$":
+  "^mac@[0-2]$":
     type: object
     unevaluatedProperties: false
     allOf:
@@ -382,6 +407,9 @@ patternProperties:
       reg:
         maxItems: 1
 
+      phys:
+        maxItems: 1
+
     required:
       - reg
       - compatible
@@ -559,3 +587,118 @@ examples:
         };
       };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mediatek,mt7988-clk.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      ethernet@15100000 {
+        compatible = "mediatek,mt7988-eth";
+        reg = <0 0x15100000 0 0x80000>, <0 0x15400000 0 0x380000>;
+        interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+
+        clocks = <&ethsys CLK_ETHDMA_XGP1_EN>,
+                 <&ethsys CLK_ETHDMA_XGP2_EN>,
+                 <&ethsys CLK_ETHDMA_XGP3_EN>,
+                 <&ethsys CLK_ETHDMA_FE_EN>,
+                 <&ethsys CLK_ETHDMA_GP2_EN>,
+                 <&ethsys CLK_ETHDMA_GP1_EN>,
+                 <&ethsys CLK_ETHDMA_GP3_EN>,
+                 <&ethsys CLK_ETHDMA_ESW_EN>,
+                 <&ethsys CLK_ETHDMA_CRYPT0_EN>,
+                 <&ethwarp CLK_ETHWARP_WOCPU2_EN>,
+                 <&ethwarp CLK_ETHWARP_WOCPU1_EN>,
+                 <&ethwarp CLK_ETHWARP_WOCPU0_EN>,
+                 <&topckgen CLK_TOP_ETH_GMII_SEL>,
+                 <&topckgen CLK_TOP_ETH_REFCK_50M_SEL>,
+                 <&topckgen CLK_TOP_ETH_SYS_200M_SEL>,
+                 <&topckgen CLK_TOP_ETH_SYS_SEL>,
+                 <&topckgen CLK_TOP_ETH_XGMII_SEL>,
+                 <&topckgen CLK_TOP_ETH_MII_SEL>,
+                 <&topckgen CLK_TOP_NETSYS_SEL>,
+                 <&topckgen CLK_TOP_NETSYS_500M_SEL>,
+                 <&topckgen CLK_TOP_NETSYS_PAO_2X_SEL>,
+                 <&topckgen CLK_TOP_NETSYS_SYNC_250M_SEL>,
+                 <&topckgen CLK_TOP_NETSYS_PPEFB_250M_SEL>,
+                 <&topckgen CLK_TOP_NETSYS_WARP_SEL>;
+
+        clock-names = "xgp1", "xgp2", "xgp3", "fe", "gp2", "gp1",
+                      "gp3", "esw", "crypto",
+                      "ethwarp_wocpu2", "ethwarp_wocpu1",
+                      "ethwarp_wocpu0", "top_eth_gmii_sel",
+                      "top_eth_refck_50m_sel", "top_eth_sys_200m_sel",
+                      "top_eth_sys_sel", "top_eth_xgmii_sel",
+                      "top_eth_mii_sel", "top_netsys_sel",
+                      "top_netsys_500m_sel", "top_netsys_pao_2x_sel",
+                      "top_netsys_sync_250m_sel",
+                      "top_netsys_ppefb_250m_sel",
+                      "top_netsys_warp_sel";
+        assigned-clocks = <&topckgen CLK_TOP_NETSYS_2X_SEL>,
+                          <&topckgen CLK_TOP_NETSYS_GSW_SEL>,
+                          <&topckgen CLK_TOP_USXGMII_SBUS_0_SEL>,
+                          <&topckgen CLK_TOP_USXGMII_SBUS_1_SEL>,
+                          <&topckgen CLK_TOP_SGM_0_SEL>,
+                          <&topckgen CLK_TOP_SGM_1_SEL>;
+        assigned-clock-parents = <&apmixedsys CLK_APMIXED_NET2PLL>,
+                                 <&topckgen CLK_TOP_NET1PLL_D4>,
+                                 <&topckgen CLK_TOP_NET1PLL_D8_D4>,
+                                 <&topckgen CLK_TOP_NET1PLL_D8_D4>,
+                                 <&apmixedsys CLK_APMIXED_SGMPLL>,
+                                 <&apmixedsys CLK_APMIXED_SGMPLL>;
+        mediatek,ethsys = <&ethsys>;
+        mediatek,infracfg = <&topmisc>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mac@0 {
+          compatible = "mediatek,eth-mac";
+          reg = <0>;
+          phy-mode = "internal"; /* CPU port of built-in 1GE switch */
+
+          fixed-link {
+            speed = <10000>;
+            full-duplex;
+            pause;
+          };
+        };
+
+        mac@1 {
+          compatible = "mediatek,eth-mac";
+          reg = <1>;
+          phy-handle = <&int_2p5g_phy>;
+        };
+
+        mac@2 {
+          compatible = "mediatek,eth-mac";
+          reg = <2>;
+          pcs-handle = <&usxgmiisys0>, <&sgmii0>;
+          phys = <&pextp0>;
+        };
+
+        mdio_bus: mdio-bus {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          /* external PHY */
+          phy0: ethernet-phy@0 {
+            reg = <0>;
+            compatible = "ethernet-phy-ieee802.3-c45";
+          };
+
+          /* internal 2.5G PHY */
+          int_2p5g_phy: ethernet-phy@15 {
+            reg = <15>;
+            compatible = "ethernet-phy-ieee802.3-c45";
+            phy-mode = "internal";
+          };
+        };
+      };
+    };
-- 
2.43.0

