Return-Path: <netdev+bounces-232634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D818C0775D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700EF1C45A19
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EBC264F9C;
	Fri, 24 Oct 2025 17:04:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A9304BC1;
	Fri, 24 Oct 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325468; cv=none; b=jYH+Wi7qtkFxJbP68X8hRUNBW7zZ30bhL4op3cnd6L0Mm0FMUNBBmFrlIrRoPWv0r7rs7JNONR3LSXE1hyWlqeHU+QDpOk769538sRfxYMgw73yUArO1FlPcQJeCMxkPfEZw/MymNkKI7vz9lPE7S+JVdK2Yo7ZPSjcX6uBukMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325468; c=relaxed/simple;
	bh=hwtuS8EHMMCezU0RqT4tjmCN4AL9AkfR+9fNLQvqXxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PepLrGbf9AHQJVX/6viliEtAulWIre0Sx+nYW/QBDmLSfiqseX5YFr6BAGMLFMHIGUCa3ZxXgwwpHj5NzURuu4zqU1KUjbwkdp97ZVlVw0G1KGSndpqqIi4JNqbNs5BlbtTVjvrs5fL1oeMe9Asly7O9RdP6mG5EpfMTk4EDsBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vCLDA-000000006A0-2p9t;
	Fri, 24 Oct 2025 17:04:20 +0000
Date: Fri, 24 Oct 2025 18:04:09 +0100
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
Subject: [PATCH net-next 10/13] dt-bindings: net: dsa: lantiq,gswip: add
 support for MaxLinear GSW1xx switches
Message-ID: <c8580eb023b99447e33d5b95624440c0af602f89.1761324950.git.daniel@makrotopia.org>
References: <cover.1761324950.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761324950.git.daniel@makrotopia.org>

Extend the Lantiq GSWIP device tree binding to also cover MaxLinear
GSW1xx switches which are based on the same hardware IP but connected
via MDIO instead of being memory-mapped.

Add compatible strings for MaxLinear GSW120, GSW125, GSW140, GSW141,
and GSW145 switches and adjust the schema to handle the different
connection methods with conditional properties.

Add MaxLinear GSW125 example showing MDIO-connected configuration.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../bindings/net/dsa/lantiq,gswip.yaml        | 263 +++++++++++++-----
 1 file changed, 190 insertions(+), 73 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 48641c27da10..eb6a4c30a8be 100644
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
 
 allOf:
   - $ref: dsa.yaml#/$defs/ethernet-ports
@@ -33,6 +38,98 @@ allOf:
                 description:
                   Configure the RMII reference clock to be a clock output
                   rather than an input. Only applicable for RMII mode.
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
+                    Offset of the GPHY firmware register in the RCU register range
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
+>>>>>>> f34c3d144cf3 (dt-bindings: net: dsa: lantiq,gswip: add support for MaxLinear GSW1xx switches)
 
 maintainers:
   - Hauke Mehrtens <hauke@hauke-m.de>
@@ -43,78 +140,11 @@ properties:
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
@@ -129,6 +159,7 @@ examples:
             reg = <0xe108000 0x3100>,  /* switch */
                   <0xe10b100 0xd8>,    /* mdio */
                   <0xe10b1d8 0x130>;   /* mii */
+            reg-names = "switch", "mdio", "mii";
             dsa,member = <0 0>;
 
             ports {
@@ -227,3 +258,89 @@ examples:
                     };
             };
     };
+
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            switch@1f {
+                    compatible = "maxlinear,gsw125";
+                    reg = <0x1f>;
+
+                    ports {
+                            #address-cells = <1>;
+                            #size-cells = <0>;
+
+                            port@0 {
+                                    reg = <0>;
+                                    label = "lan0";
+                                    phy-handle = <&switchphy0>;
+                                    phy-mode = "internal";
+                            };
+
+                            port@1 {
+                                    reg = <1>;
+                                    label = "lan1";
+                                    phy-handle = <&switchphy1>;
+                                    phy-mode = "internal";
+                            };
+
+                            port@4 {
+                                    reg = <4>;
+                                    label = "wan";
+                                    phy-mode = "sgmii";
+                            };
+
+                            port@5 {
+                                    reg = <5>;
+                                    phy-mode = "rgmii-id";
+                                    tx-internal-delay-ps = <2000>;
+                                    rx-internal-delay-ps = <2000>;
+                                    ethernet = <&eth0>;
+
+                                    fixed-link {
+                                            speed = <1000>;
+                                            full-duplex;
+                                    };
+                            };
+                    };
+
+                    mdio {
+                            #address-cells = <1>;
+                            #size-cells = <0>;
+
+                            switchphy0: switchphy@0 {
+                                    reg = <0>;
+
+                                    leds {
+                                            #address-cells = <1>;
+                                            #size-cells = <0>;
+
+                                            led@0 {
+                                                    reg = <0>;
+                                                    color = <LED_COLOR_ID_GREEN>;
+                                                    function = LED_FUNCTION_LAN;
+                                            };
+                                    };
+                            };
+
+                            switchphy1: switchphy@1 {
+                                    reg = <1>;
+
+                                    leds {
+                                            #address-cells = <1>;
+                                            #size-cells = <0>;
+
+                                            led@0 {
+                                                    reg = <0>;
+                                                    color = <LED_COLOR_ID_GREEN>;
+                                                    function = LED_FUNCTION_LAN;
+                                            };
+                                    };
+                            };
+                    };
+            };
+    };
-- 
2.51.0

