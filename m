Return-Path: <netdev+bounces-150327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAAF9E9E04
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E522188774B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6215853B;
	Mon,  9 Dec 2024 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ifm.com header.i=@ifm.com header.b="tNZlcoTh"
X-Original-To: netdev@vger.kernel.org
Received: from pp2023.ppsmtp.net (pp2023.ppsmtp.net [132.145.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACCA146A63;
	Mon,  9 Dec 2024 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.145.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768724; cv=none; b=l8/H3PjtM2BF//+T67+/G192hjnqO5o1L7htJPVIM55NmkA3RvcI+2PR89FW6KKKtVwgaLRPVQ1qlRqYmCw01zuqpDSF1oNGDRUIRgC4Y2frEqnHtTjc8geLS4OjQINUcthBoPPYC1/nevrJzaaSCeKrYKkpz1pN830KP2Ecq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768724; c=relaxed/simple;
	bh=gLFQw4DMaeJ3d+JdvIzNsbyedDoZCMKcjcOE8enPTXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=e1dt84fQG+8Rnjll+E/42uJmlMmShx+C4HJsMyhxlbNA6GJ09G7Us9VmHCxmde345Zqs3ECK2kZtmPKujtUVxXctJEp4F2BcXkpYgUtaJ480d0H9QzVU+mbQAvvCzXPztPVPhOY+ZMaVLSOoadCMLpJLF2CZFJq5WQPBn8mpBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ifm.com; spf=pass smtp.mailfrom=ifm.com; dkim=pass (2048-bit key) header.d=ifm.com header.i=@ifm.com header.b=tNZlcoTh; arc=none smtp.client-ip=132.145.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ifm.com
Received: from pps.filterd (pp2023.ppsmtp.internal [127.0.0.1])
	by pp2023.ppsmtp.internal (8.18.1.2/8.18.1.2) with ESMTP id 4B9GFPN9001286;
	Mon, 9 Dec 2024 18:59:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps;
 bh=lWK9c+ZIejq2822haSA17t/ZFCNoY1YEg/oiU2So7cQ=;
 b=tNZlcoTh2uzHzDoQHOAKkrfrtQn1ca9SBzdw44QWQZTsuFWz5sBITe7FuJjNnj20BvGP
 c9zavcIhIYRcySyhb1TAVeNohwT5JjpeEoKjhUiT0T5CJYcCDqYl3TXTNMO8ZPoQRs3t
 sBXk3zA99LtdtQO41RYhdwSoc1PMYPqig/XIqD1RqDofaVA60J0YMZ+4lhmTXeQ+/Rol
 IdwxrBNJPLZiCJueTSOj19fJJDVWu8ipm+/AFKapJq2AXIafUKbVUiYzIjQMBPbFZ6Js
 sRiiW1Q7bVWlA0AGbjt960BVj/fOAPFeZL7slr3EDKqnpQvGhv5ug/EPMQYSEHhX2FKx Zg== 
From: Fedor Ross <fedor.ross@ifm.com>
Date: Mon, 9 Dec 2024 18:58:52 +0100
Subject: [PATCH net-next 2/2] dt-bindings: net: dsa: microchip: Add of
 config for LED mode for ksz87xx and ksz88x3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241209-netdev-net-next-ksz8_led-mode-v1-2-c7b52c2ebf1b@ifm.com>
References: <20241209-netdev-net-next-ksz8_led-mode-v1-0-c7b52c2ebf1b@ifm.com>
In-Reply-To: <20241209-netdev-net-next-ksz8_led-mode-v1-0-c7b52c2ebf1b@ifm.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Woojung Huh
	<Woojung.Huh@microchip.com>, <devicetree@vger.kernel.org>,
        Tristram Ha
	<tristram.ha@microchip.com>,
        Fedor Ross <fedor.ross@ifm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733767148; l=4792;
 i=fedor.ross@ifm.com; s=20241209; h=from:subject:message-id;
 bh=gLFQw4DMaeJ3d+JdvIzNsbyedDoZCMKcjcOE8enPTXI=;
 b=SWttvsIg5FKxiPzfoKRqznDuYn13YdrZFq2Dcg/fdpa3VONWyIwXv2ssA8NFPiFuPadQFguT8
 uTAbCDFdCBzDISHBx/lDA4TcfMFVyvJ+vAIlG6ze724oEfKJR/c5qbQ
X-Developer-Key: i=fedor.ross@ifm.com; a=ed25519;
 pk=0Va3CWt8QM1HKXUBlspqksLl0ieto8l/GgQJJyNu/ZM=
X-ClientProxiedBy: DEESEX10.intra.ifm (172.26.140.25) To DEESEX10.intra.ifm
 (172.26.140.25)
X-Proofpoint-ID: SID=43cyfjur6c QID=43cyfjur6c-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_14,2024-12-09_03,2024-11-22_01

Add support for the led-mode property for the following PHYs which have
a single LED mode configuration value.

KSZ8765, KSZ8794 and KSZ8795 use register 0x0b bits 5,4 to control the
LED configuration.

KSZ8863 and KSZ8873 use register 0xc3 bits 5,4 to control the LED
configuration.

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 89 +++++++++++++---------
 1 file changed, 55 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 62ca63e8a26fda0615cc254acca620f14f47cd10..2420e63d80249e533a34f992a0d3d12d926a3aa6 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -10,9 +10,6 @@ maintainers:
   - Marek Vasut <marex@denx.de>
   - Woojung Huh <Woojung.Huh@microchip.com>
 
-allOf:
-  - $ref: /schemas/spi/spi-peripheral-props.yaml#
-
 properties:
   # See Documentation/devicetree/bindings/net/dsa/dsa.yaml for a list of additional
   # required and optional properties.
@@ -106,38 +103,62 @@ required:
   - compatible
   - reg
 
-if:
-  not:
-    properties:
-      compatible:
-        enum:
-          - microchip,ksz8863
-          - microchip,ksz8873
-then:
-  $ref: dsa.yaml#/$defs/ethernet-ports
-else:
-  patternProperties:
-    "^(ethernet-)?ports$":
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            enum:
+              - microchip,ksz8863
+              - microchip,ksz8873
+    then:
+      $ref: dsa.yaml#/$defs/ethernet-ports
+    else:
       patternProperties:
-        "^(ethernet-)?port@[0-2]$":
-          $ref: dsa-port.yaml#
-          unevaluatedProperties: false
-          properties:
-            microchip,rmii-clk-internal:
-              $ref: /schemas/types.yaml#/definitions/flag
-              description:
-                When ksz88x3 is acting as clock provier (via REFCLKO) it
-                can select between internal and external RMII reference
-                clock. Internal reference clock means that the clock for
-                the RMII of ksz88x3 is provided by the ksz88x3 internally
-                and the REFCLKI pin is unconnected. For the external
-                reference clock, the clock needs to be fed back to ksz88x3
-                via REFCLKI.
-                If microchip,rmii-clk-internal is set, ksz88x3 will provide
-                rmii reference clock internally, otherwise reference clock
-                should be provided externally.
-          dependencies:
-            microchip,rmii-clk-internal: [ethernet]
+        "^(ethernet-)?ports$":
+          patternProperties:
+            "^(ethernet-)?port@[0-2]$":
+              $ref: dsa-port.yaml#
+              unevaluatedProperties: false
+              properties:
+                microchip,rmii-clk-internal:
+                  $ref: /schemas/types.yaml#/definitions/flag
+                  description:
+                    When ksz88x3 is acting as clock provier (via REFCLKO) it
+                    can select between internal and external RMII reference
+                    clock. Internal reference clock means that the clock for
+                    the RMII of ksz88x3 is provided by the ksz88x3 internally
+                    and the REFCLKI pin is unconnected. For the external
+                    reference clock, the clock needs to be fed back to ksz88x3
+                    via REFCLKI.
+                    If microchip,rmii-clk-internal is set, ksz88x3 will provide
+                    rmii reference clock internally, otherwise reference clock
+                    should be provided externally.
+              dependencies:
+                microchip,rmii-clk-internal: [ethernet]
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,ksz8765
+              - microchip,ksz8794
+              - microchip,ksz8795
+              - microchip,ksz8863
+              - microchip,ksz8873
+    then:
+      properties:
+        microchip,led-mode:
+          description:
+            Set LED mode for ksz8765, ksz8794 or ksz8795 (Register 0x0B, bits 5..4)
+            and ksz8863 or ksz8873 (Register 0xC3, bits 5..4).
+          items:
+            enum:
+              - 0 # LED0: Link/ACT, LED1: Speed
+              - 1 # LED0: Link, LED1: ACT
+              - 2 # LED0: Link/ACT, LED1: Duplex
+              - 3 # LED0: Link, LED1: Duplex
 
 unevaluatedProperties: false
 

-- 
2.34.1


