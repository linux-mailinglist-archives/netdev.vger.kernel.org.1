Return-Path: <netdev+bounces-234743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B140C26BA5
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 20:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67D646378D
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7215930E0C3;
	Fri, 31 Oct 2025 19:22:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680730B512;
	Fri, 31 Oct 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938568; cv=none; b=o27/Tt3PrGgTxTUIvhPmSjNfEpGdp6NkE3PaLBiONqsZhqLGlD18udMELcVL4Pk6MdqDSzhDeMRH6Bz8+5zFS6mr+qBlGFi6aD3NxVgTGy80GJ+cWK+N3zO6PNfu/GW2FnEl8hni5U+KLE2Lk5JorALqRrQ2GmlSWPlIs1FJiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938568; c=relaxed/simple;
	bh=wWfiTXHq6awDhQQTxdaBlcnDPrb9Bq/yoDJNHTYXHqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQnYTbtJDPnLWSbYElA1+tg/zIwZZkvhbo52fyME41GAq8CJRKT5P5YHrShYoWX0CrJoXsexUBFejsfx27/FzzP3Ea+NuEwyVuD5fBH3tFgV0b8C1vaCC922XBB2Gpd3e1PI+b8l65bDqoH5ky5UG/eKgbfuvQGHJ8BV2mYi10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vEuhu-000000005v8-2Iad;
	Fri, 31 Oct 2025 19:22:42 +0000
Date: Fri, 31 Oct 2025 19:22:39 +0000
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
Subject: [PATCH net-next v6 10/12] dt-bindings: net: dsa: lantiq,gswip: add
 support for MaxLinear GSW1xx switches
Message-ID: <b32a49c03c75be0a1b4666e99c25a3fc0f95d63b.1761938079.git.daniel@makrotopia.org>
References: <cover.1761938079.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761938079.git.daniel@makrotopia.org>

Extend the Lantiq GSWIP device tree binding to also cover MaxLinear
GSW1xx switches which are based on the same hardware IP but connected
via MDIO instead of being memory-mapped.

Add compatible strings for MaxLinear GSW120, GSW125, GSW140, GSW141,
and GSW145 switches and adjust the schema to handle the different
connection methods with conditional properties.

Add MaxLinear GSW125 example showing MDIO-connected configuration.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v6:
 * keep properties on top level and use allOf for conditional constraints

v5:
 * drop maxlinear,rx-inverted from example

v4:
 * drop maxlinear,rx-inverted and maxlinear,tx-inverted properties for
   now in favor of upcoming generic properties

v3:
 * add maxlinear,rx-inverted and maxlinear,tx-inverted properties

v2:
 * remove git conflict left-overs which somehow creeped in
 * indent example with 4 spaces instead of tabs

 .../bindings/net/dsa/lantiq,gswip.yaml        | 131 +++++++++++++++++-
 1 file changed, 126 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index cf01b07f7f44..8904d0b6cec5 100644
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
 
@@ -46,9 +51,14 @@ properties:
       - lantiq,xrx200-gswip
       - lantiq,xrx300-gswip
       - lantiq,xrx330-gswip
+      - maxlinear,gsw120
+      - maxlinear,gsw125
+      - maxlinear,gsw140
+      - maxlinear,gsw141
+      - maxlinear,gsw145
 
   reg:
-    minItems: 3
+    minItems: 1
     maxItems: 3
 
   reg-names:
@@ -65,9 +75,6 @@ properties:
       compatible:
         const: lantiq,xrx200-mdio
 
-    required:
-      - compatible
-
   gphy-fw:
     type: object
     properties:
@@ -123,6 +130,32 @@ required:
   - compatible
   - reg
 
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
+        mdio:
+          required:
+            - compatible
+      required:
+        - reg-names
+    else:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names: false
+        gphy-fw: false
+
 unevaluatedProperties: false
 
 examples:
@@ -132,6 +165,7 @@ examples:
             reg = <0xe108000 0x3100>,  /* switch */
                   <0xe10b100 0xd8>,    /* mdio */
                   <0xe10b1d8 0x130>;   /* mii */
+            reg-names = "switch", "mdio", "mii";
             dsa,member = <0 0>;
 
             ports {
@@ -230,3 +264,90 @@ examples:
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
2.51.2

