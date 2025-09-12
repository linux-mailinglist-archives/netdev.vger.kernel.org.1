Return-Path: <netdev+bounces-222479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17097B546AD
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE3E567895
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194D8277CA5;
	Fri, 12 Sep 2025 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WYNquoqo"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947E2676E6
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668594; cv=none; b=qrgDajY3qVfcxFLemc0qHDmXI7NHORION0vPVF+bDUw79S6mK8foPqA5VJ10XpucB+F4NehGx0E1CYkstGL+5b+IsMRMOb+nqbCb6zwE8u3+Rjg3MdaE2MfsUda+1TDjCSBy0kmSezjJWtF+EpkrlYUjQvel1dH4rmWEatqxsbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668594; c=relaxed/simple;
	bh=Pjqo9rLefJi52wvlDOawMLf6tQJ/V8fM9H1T1oYxCE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqO2lSimy4LU/8YKbZZujmDMRCl1YfcADscTjbONOtnduE2xotAWYJSZKwEWpKUsagcpjfjHDrHkPWJU8J74asUaQYBDfKMEm6LZJx7E8D56L/vgPfA40CTWnrVmemGJ3leaJeYXo7S/BSzfsVviokXKL+7nuEcI/MDfikdcmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WYNquoqo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 12409C8EC45;
	Fri, 12 Sep 2025 09:16:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0BD2760638;
	Fri, 12 Sep 2025 09:16:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 964CD102F29D9;
	Fri, 12 Sep 2025 11:16:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757668588; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gjuk0D0MlQ1y3SzWONMFViMKrN2S9Sz2wj3JG7/59tk=;
	b=WYNquoqo0AOE5Auy+ddJN0oBOO65dLYoDP88C+UCU6b84S8W+PDEmdW1f/wlLbB68gTP0G
	Mv9hf2nenK2hMSHWCtJyw21KwJZjz6PbgHm6BxC+4f9GolpXu7fgXV0UsARrVNubf7HCL7
	Pn/MHHy/ghA78VLzeIqZcpbuWo6EimXvPM6H14OZL7046RHm6AuXrSOPcER1U5s7uhSH1L
	Cn4J5n2omeEViDPKzSbMlkvlmWsuUs4sGqDk3pJGVHmBtBx7SY+2gn/0vIIajTCND8Z/vx
	+FK39bhM81MnEtf+gncxMhJH053BPWaoc+mhs8TYe1+WVU/NALETivkCt4wQ6Q==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 12 Sep 2025 11:09:12 +0200
Subject: [PATCH net-next v2 1/3] dt-bindings: net: dsa: microchip: Group if
 clause under allOf tag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-ksz-strap-pins-v2-1-6d97270c6926@bootlin.com>
References: <20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com>
In-Reply-To: <20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Pascal Eberhard <pascal.eberhard@se.com>, 
 Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Upcoming patch adds a new if/then clause. It requires to be grouped with
the already existing if/then clause under an 'allOf:' tag.

Move the if/then clause under the already existing 'allOf:' tag to
prepare next patch.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 68 +++++++++++-----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index eb4607460db7f32a4dffd416e44b61c2674f731e..db8175b4ced6d136ba97c371b68ba993637e444a 100644
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
@@ -107,38 +104,41 @@ required:
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
+
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
 
 unevaluatedProperties: false
 

-- 
2.51.0


