Return-Path: <netdev+bounces-110525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DD592CD7B
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 10:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3A71C2095B
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 08:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE81176231;
	Wed, 10 Jul 2024 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzN2uwOi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F448172780;
	Wed, 10 Jul 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601305; cv=none; b=qS99hAjfc2hjsT6o1VA2ENdRC+bKn3rkw5gUUzYM2AwEN1sLrwWgcpRQDTknPD43DMmmggCAegqzj0XslFrmjqy57bFGKQnzyHit/P+0owXuJi62l04nDjQVqo1X7ETEzWssd5i9dkhLW1VR9CFKPN8JxoKnwCU1IOmYq8ShLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601305; c=relaxed/simple;
	bh=1ggPJz4aAzdR9GpMAFwSyieIXtINSUNt04Bv9068jjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEZIlIPR1wGx3eOV5F336X5QRJ6n5U0hpRuINJZYA2T+9nzjnU1QC7/1td2rCPjn5foTZyLQciNJ8uVCi8SMb6EiHioC5jC2Y7ka9DrFei8/Y3aCsqyiD6IjKx8Yg4CLq/cmzq0uP2vd65K5H48Diwe023gICQ/5x9Ohl3CBUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzN2uwOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7559C32781;
	Wed, 10 Jul 2024 08:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720601304;
	bh=1ggPJz4aAzdR9GpMAFwSyieIXtINSUNt04Bv9068jjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzN2uwOipCINHony2g3oamIT47C1hqIejPb5pRG8avKRiRK1gjJ4rJbmIsfjfrcAR
	 /33D4wTcqC9cGigANY6SvrkhoS0jB8eQSEb1HoAEapI78zVIDdYiLFEZ+TNYtFDc0F
	 ov173CHFDHqeVbLCZBcBhd1nv3vS+FWHSAMcXCqCdHosYt3vE+8XjiwO8kEk2wMfyW
	 xEV5Xp8xamOfe+SKHSdk8PE9CVw/Ds/PrXJr3yfdqSDE5TFppY7iFNPBPMd4ac2Idh
	 vwX/WLtEJjEoiHNDM3t6dDY2uwyNXV2sWcYznkjzgMFul4jgN+KjwoQsykRfSu8Ait
	 iiMZfv0ww+mfw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu,
	rkannoth@marvell.com,
	sgoutham@marvell.com,
	andrew@lunn.ch,
	arnd@arndb.de,
	horms@kernel.org
Subject: [PATCH v7 net-next 1/2] dt-bindings: net: airoha: Add EN7581 ethernet controller
Date: Wed, 10 Jul 2024 10:47:40 +0200
Message-ID: <2807e6dc1baad458473d49f21e13fd84dee94f0b.1720600905.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720600905.git.lorenzo@kernel.org>
References: <cover.1720600905.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce device-tree binding documentation for Airoha EN7581 ethernet
mac controller.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/net/airoha,en7581-eth.yaml       | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
new file mode 100644
index 000000000000..c578637c5826
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,en7581-eth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 Frame Engine Ethernet controller
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description:
+  The frame engine ethernet controller can be found on Airoha SoCs.
+  These SoCs have multi-GMAC ports.
+
+properties:
+  compatible:
+    enum:
+      - airoha,en7581-eth
+
+  reg:
+    items:
+      - description: Frame engine base address
+      - description: QDMA0 base address
+      - description: QDMA1 base address
+
+  reg-names:
+    items:
+      - const: fe
+      - const: qdma0
+      - const: qdma1
+
+  interrupts:
+    items:
+      - description: QDMA lan irq0
+      - description: QDMA lan irq1
+      - description: QDMA lan irq2
+      - description: QDMA lan irq3
+      - description: QDMA wan irq0
+      - description: QDMA wan irq1
+      - description: QDMA wan irq2
+      - description: QDMA wan irq3
+      - description: FE error irq
+      - description: PDMA irq
+
+  resets:
+    maxItems: 8
+
+  reset-names:
+    items:
+      - const: fe
+      - const: pdma
+      - const: qdma
+      - const: xsi-mac
+      - const: hsi0-mac
+      - const: hsi1-mac
+      - const: hsi-mac
+      - const: xfp-mac
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^ethernet@[1-4]$":
+    type: object
+    unevaluatedProperties: false
+    $ref: ethernet-controller.yaml#
+    description:
+      Ethernet GMAC port associated to the MAC controller
+    properties:
+      compatible:
+        const: airoha,eth-mac
+
+      reg:
+        minimum: 1
+        maximum: 4
+        description: GMAC port identifier
+
+    required:
+      - reg
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/en7523-clk.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      eth: ethernet@1fb50000 {
+        compatible = "airoha,en7581-eth";
+        reg = <0 0x1fb50000 0 0x2600>,
+              <0 0x1fb54000 0 0x2000>,
+              <0 0x1fb56000 0 0x2000>;
+        reg-names = "fe", "qdma0", "qdma1";
+
+        resets = <&scuclk 44>,
+                 <&scuclk 30>,
+                 <&scuclk 31>,
+                 <&scuclk 6>,
+                 <&scuclk 15>,
+                 <&scuclk 16>,
+                 <&scuclk 17>,
+                 <&scuclk 26>;
+        reset-names = "fe", "pdma", "qdma", "xsi-mac",
+                      "hsi0-mac", "hsi1-mac", "hsi-mac",
+                      "xfp-mac";
+
+        interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mac: ethernet@1 {
+          compatible = "airoha,eth-mac";
+          reg = <1>;
+        };
+      };
+    };
-- 
2.45.2


