Return-Path: <netdev+bounces-51307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C27FA0D5
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196961C203B0
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC812DF7E;
	Mon, 27 Nov 2023 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="Jl9qpnhM"
X-Original-To: netdev@vger.kernel.org
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A92D4D
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 05:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qBhdL/vRTfAcxaKskMBkoUwGK86JCGcXwMFn+lpRuXw=; b=Jl9qpnhMzQ3Uz9ViHYpxDvT25h
	4E7lQ++UjxcLJs1nttv8eyCTnh3Kr2gq8hhQ3i/n5MEOpEjO3gsa4l/iVPpaocuE28C8ick0tNxg/
	lhbkANtZ/3Lpeze8S9xOp+0KgqyybxzSki35sxHpm5WaOLbVvj9ViBY89i9+faaTEAsZJAC2XnU08
	9NIAldzaxbYUNLB9H1Rbf55rsrvPTDjskKyaX18bARnMQCrdzNLjffcKjaSWPHrAOpPlAaQNBiPQz
	zfoJa5WtfbDAjd3cNRsM5K2pwIHlQZsgd3nz1bqKSlOc4w1fxlQMnKFP15VUa6G6JHziFxU91yGik
	DfYsfLrA==;
Received: from [192.168.1.4] (port=38633 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1r7bXn-0008TS-03;
	Mon, 27 Nov 2023 14:20:59 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 27 Nov 2023 14:20:58 +0100
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <marex@denx.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v6 1/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
Date: Mon, 27 Nov 2023 14:20:42 +0100
Message-ID: <7f1f89010743a06c4880fd224149ea495fe32512.1701091042.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1701091042.git.ante.knezic@helmholz.de>
References: <cover.1701091042.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933

Add documentation for selecting reference rmii clock on KSZ88X3 devices

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index b3029c64d0d5..6fd482f2656b 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -11,7 +11,6 @@ maintainers:
   - Woojung Huh <Woojung.Huh@microchip.com>
 
 allOf:
-  - $ref: dsa.yaml#/$defs/ethernet-ports
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
@@ -78,6 +77,43 @@ required:
   - compatible
   - reg
 
+if:
+  not:
+    properties:
+      compatible:
+        enum:
+          - microchip,ksz8863
+          - microchip,ksz8873
+then:
+  $ref: dsa.yaml#/$defs/ethernet-ports
+else:
+  patternProperties:
+    "^(ethernet-)?ports$":
+      patternProperties:
+        "^(ethernet-)?port@[0-2]$":
+          $ref: dsa-port.yaml#
+          properties:
+            microchip,rmii-clk-internal:
+              $ref: /schemas/types.yaml#/definitions/flag
+              description:
+                When ksz88x3 is acting as clock provier (via REFCLKO) it
+                can select between internal and external RMII reference
+                clock. Internal reference clock means that the clock for
+                the RMII of ksz88x3 is provided by the ksz88x3 internally
+                and the REFCLKI pin is unconnected. For the external
+                reference clock, the clock needs to be fed back to ksz88x3
+                via REFCLKI.
+                If microchip,rmii-clk-internal is set, ksz88x3 will provide
+                rmii reference clock internally, otherwise reference clock
+                should be provided externally.
+          if:
+            not:
+              required: [ ethernet ]
+          then:
+            properties:
+              microchip,rmii-clk-internal: false
+          unevaluatedProperties: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.11.0


