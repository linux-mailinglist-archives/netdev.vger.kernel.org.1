Return-Path: <netdev+bounces-233038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B608C0B7E6
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 00:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB7D3BB3F2
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 23:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723C63019C6;
	Sun, 26 Oct 2025 23:48:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB4266565;
	Sun, 26 Oct 2025 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522497; cv=none; b=jKuaeJJzTMESie/2SOyPITj4WX/25yaD8Ut9kCJTKud33PH/eIOB9vGuIy4Y7NAUXjaboiDOObhYjPbRzaVgO9u/o157Ji49NrdBnlMO2w+cz5at6TgLULYFFQyUnNACXyRGLZX1wwhE5CBdSar3v7fe556l/NBUOFIArmgW9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522497; c=relaxed/simple;
	bh=5vJ7EY2mhyYHZnh8K9E/ULcmcCJSOnW6jbY2eY+8tGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIIevcWbo0/KXZqKo5wwDN/9n+oUCJ6juLIATCP16p7Ifii2PMcVleIrTouL6NFC1tLKKfZY5U5vUgqpFP0meq32vCi+eo3cOgavTKRz7rEwtNlrTvMT4J1/diYQirUVYtdyuw1DHEUAFuQCSHADRNo1werilewQGuO4vzJZ9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDAT4-000000007ga-0DgB;
	Sun, 26 Oct 2025 23:48:10 +0000
Date: Sun, 26 Oct 2025 23:48:06 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v3 10/12] dt-bindings: net: dsa: lantiq,gswip: add
 support for MaxLinear GSW1xx switches
Message-ID: <f07c15befb17573ca50e507156892b067a25ee2c.1761521845.git.daniel@makrotopia.org>
References: <cover.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761521845.git.daniel@makrotopia.org>

Extend the Lantiq GSWIP device tree binding to also cover MaxLinear
GSW1xx switches which are based on the same hardware IP but connected
via MDIO instead of being memory-mapped.

Add compatible strings for MaxLinear GSW120, GSW125, GSW140, GSW141,
and GSW145 switches and adjust the schema to handle the different
connection methods with conditional properties.

Add MaxLinear GSW125 example showing MDIO-connected configuration.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3:
 * add maxlinear,rx-inverted and maxlinear,tx-inverted properties

v2:
 * remove git conflict left-overs which somehow creeped in
 * indent example with 4 spaces instead of tabs

 .../bindings/net/dsa/lantiq,gswip.yaml        | 275 +++++++++++++-----
 1 file changed, 202 insertions(+), 73 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index dd3858bad8ca..1148fdd0b6bc 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -4,7 +4,12 @@
 $id: http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Lantiq GSWIP Ethernet switches
+title: Lantiq GSWIP and MaxLinear GSW1xx Ethernet switches
+
+description:
+  Lantiq GSWIP and MaxLinear GSW1xx switches share the same hardware IP.
+  Lantiq switches are embedded in SoCs and accessed via memory-mapped I/O,
+  while MaxLinear switches are standalone ICs connected via MDIO.
 
 $ref: dsa.yaml#
 
@@ -34,6 +39,108 @@ patternProperties:
             description:
               Configure the RMII reference clock to be a clock output
               rather than an input. Only applicable for RMII mode.
+          maxlinear,rx-inverted:
+            type: boolean
+            description:
+              Enable RX polarity inversion for SerDes port.
+          maxlinear,tx-inverted:
+            type: boolean
+            description:
+              Enable TX polarity inversion for SerDes port.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - lantiq,xrx200-gswip
+              - lantiq,xrx300-gswip
+              - lantiq,xrx330-gswip
+    then:
+      properties:
+        reg:
+          minItems: 3
+          maxItems: 3
+          description: Memory-mapped register regions (switch, mdio, mii)
+        reg-names:
+          items:
+            - const: switch
+            - const: mdio
+            - const: mii
+        mdio:
+          $ref: /schemas/net/mdio.yaml#
+          unevaluatedProperties: false
+
+          properties:
+            compatible:
+              const: lantiq,xrx200-mdio
+
+          required:
+            - compatible
+        gphy-fw:
+          type: object
+          properties:
+            '#address-cells':
+              const: 1
+
+            '#size-cells':
+              const: 0
+
+            compatible:
+              items:
+                - enum:
+                    - lantiq,xrx200-gphy-fw
+                    - lantiq,xrx300-gphy-fw
+                    - lantiq,xrx330-gphy-fw
+                - const: lantiq,gphy-fw
+
+            lantiq,rcu:
+              $ref: /schemas/types.yaml#/definitions/phandle
+              description: phandle to the RCU syscon
+
+          patternProperties:
+            "^gphy@[0-9a-f]{1,2}$":
+              type: object
+
+              additionalProperties: false
+
+              properties:
+                reg:
+                  minimum: 0
+                  maximum: 255
+                  description:
+                    Offset of the GPHY firmware register in the RCU register
+                    range
+
+                resets:
+                  items:
+                    - description: GPHY reset line
+
+                reset-names:
+                  items:
+                    - const: gphy
+
+              required:
+                - reg
+
+          required:
+            - compatible
+            - lantiq,rcu
+
+          additionalProperties: false
+      required:
+        - reg-names
+    else:
+      properties:
+        reg:
+          maxItems: 1
+          description: MDIO bus address
+        reg-names: false
+        gphy-fw: false
+        mdio:
+          $ref: /schemas/net/mdio.yaml#
+          unevaluatedProperties: false
 
 maintainers:
   - Hauke Mehrtens <hauke@hauke-m.de>
@@ -44,78 +151,11 @@ properties:
       - lantiq,xrx200-gswip
       - lantiq,xrx300-gswip
       - lantiq,xrx330-gswip
-
-  reg:
-    minItems: 3
-    maxItems: 3
-
-  reg-names:
-    items:
-      - const: switch
-      - const: mdio
-      - const: mii
-
-  mdio:
-    $ref: /schemas/net/mdio.yaml#
-    unevaluatedProperties: false
-
-    properties:
-      compatible:
-        const: lantiq,xrx200-mdio
-
-    required:
-      - compatible
-
-  gphy-fw:
-    type: object
-    properties:
-      '#address-cells':
-        const: 1
-
-      '#size-cells':
-        const: 0
-
-      compatible:
-        items:
-          - enum:
-              - lantiq,xrx200-gphy-fw
-              - lantiq,xrx300-gphy-fw
-              - lantiq,xrx330-gphy-fw
-          - const: lantiq,gphy-fw
-
-      lantiq,rcu:
-        $ref: /schemas/types.yaml#/definitions/phandle
-        description: phandle to the RCU syscon
-
-    patternProperties:
-      "^gphy@[0-9a-f]{1,2}$":
-        type: object
-
-        additionalProperties: false
-
-        properties:
-          reg:
-            minimum: 0
-            maximum: 255
-            description:
-              Offset of the GPHY firmware register in the RCU register range
-
-          resets:
-            items:
-              - description: GPHY reset line
-
-          reset-names:
-            items:
-              - const: gphy
-
-        required:
-          - reg
-
-    required:
-      - compatible
-      - lantiq,rcu
-
-    additionalProperties: false
+      - maxlinear,gsw120
+      - maxlinear,gsw125
+      - maxlinear,gsw140
+      - maxlinear,gsw141
+      - maxlinear,gsw145
 
 required:
   - compatible
@@ -130,6 +170,7 @@ examples:
             reg = <0xe108000 0x3100>,  /* switch */
                   <0xe10b100 0xd8>,    /* mdio */
                   <0xe10b1d8 0x130>;   /* mii */
+            reg-names = "switch", "mdio", "mii";
             dsa,member = <0 0>;
 
             ports {
@@ -228,3 +269,91 @@ examples:
                     };
             };
     };
+
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@1f {
+            compatible = "maxlinear,gsw125";
+            reg = <0x1f>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "lan0";
+                    phy-handle = <&switchphy0>;
+                    phy-mode = "internal";
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan1";
+                    phy-handle = <&switchphy1>;
+                    phy-mode = "internal";
+                };
+
+                port@4 {
+                    reg = <4>;
+                    label = "wan";
+                    phy-mode = "1000base-x";
+                    maxlinear,rx-inverted;
+                    managed = "in-band-status";
+                };
+
+                port@5 {
+                    reg = <5>;
+                    phy-mode = "rgmii-id";
+                    tx-internal-delay-ps = <2000>;
+                    rx-internal-delay-ps = <2000>;
+                    ethernet = <&eth0>;
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                    };
+                };
+            };
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                switchphy0: switchphy@0 {
+                    reg = <0>;
+
+                    leds {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+
+                        led@0 {
+                            reg = <0>;
+                            color = <LED_COLOR_ID_GREEN>;
+                            function = LED_FUNCTION_LAN;
+                        };
+                    };
+                };
+
+                switchphy1: switchphy@1 {
+                    reg = <1>;
+
+                    leds {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+
+                        led@0 {
+                            reg = <0>;
+                            color = <LED_COLOR_ID_GREEN>;
+                            function = LED_FUNCTION_LAN;
+                        };
+                    };
+                };
+            };
+        };
+    };
-- 
2.51.1

