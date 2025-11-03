Return-Path: <netdev+bounces-235066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 39184C2BA1D
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 13:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B12FC3490BF
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 12:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E3630F7FC;
	Mon,  3 Nov 2025 12:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1430F523;
	Mon,  3 Nov 2025 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172422; cv=none; b=KnyUR6X36ZXfu69hKQToB0gqdg8x6LzdRAuKyBjTjo/s3PjHk4kqygava17n7S11zEmMEDRvT0DWwr04K6ByyEMwMcvedvqsq+MtjUCZlY6nErwS8cQ3fZ0gE7VGs5kLFIZ2glQC+h7ve8xskjn68zgxoAx3K7Ovelxf7stgyqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172422; c=relaxed/simple;
	bh=YUNW5+++ZBrA5vRoYxg0c6f5k4xNmL/y6B5rl6Z4FSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvLVAJH7zoXCiAj3qGsg5DYZeNfIndCJMqL0elO6oVfw+9ZoBsCMhnC4YBji/raExkwQQp56v6NdODcDWgnZ6W9b85A3vzvvzTQUP6KWXh1YSubN74Pm7sM5DrcaQexzIb9pXQvQ9mA+ZakH++GjPGjJ4UsQwtBW9TMcQh8XYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vFtXk-000000000rJ-0JeP;
	Mon, 03 Nov 2025 12:20:16 +0000
Date: Mon, 3 Nov 2025 12:20:12 +0000
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
Subject: [PATCH net-next v7 10/12] dt-bindings: net: dsa: lantiq,gswip: add
 support for MaxLinear GSW1xx switches
Message-ID: <fc96f1dedb2b418a63e69960356dde7f6eb86424.1762170107.git.daniel@makrotopia.org>
References: <cover.1762170107.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762170107.git.daniel@makrotopia.org>

Extend the Lantiq GSWIP device tree binding to also cover MaxLinear
GSW1xx switches which are based on the same hardware IP but connected
via MDIO instead of being memory-mapped.

Add compatible strings for MaxLinear GSW120, GSW125, GSW140, GSW141,
and GSW145 switches and adjust the schema to handle the different
connection methods with conditional properties.

Add MaxLinear GSW125 example showing MDIO-connected configuration.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v7:
 * drop the addition of 'reg-names' to the list of required properties
   and also don't add it to the existing example

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

since RFC: no changes

 .../bindings/net/dsa/lantiq,gswip.yaml        | 128 +++++++++++++++++-
 1 file changed, 123 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 929f6f8e4534..205b683849a5 100644
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
 
@@ -17,9 +22,14 @@ properties:
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
@@ -36,9 +46,6 @@ properties:
       compatible:
         const: lantiq,xrx200-mdio
 
-    required:
-      - compatible
-
   gphy-fw:
     type: object
     properties:
@@ -123,6 +130,30 @@ required:
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
+    else:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names: false
+        gphy-fw: false
+
 unevaluatedProperties: false
 
 examples:
@@ -230,3 +261,90 @@ examples:
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

