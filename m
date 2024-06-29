Return-Path: <netdev+bounces-107902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4684591CDAE
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 17:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81017B212CF
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 15:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154847E572;
	Sat, 29 Jun 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWBHTw0c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E290829CEB;
	Sat, 29 Jun 2024 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719673313; cv=none; b=rZYsBuqi9XBG+wv31QPW+fFwzJk7slmrFXnzjQOsEt+sZxahurPeM+gexhe7kAMMKx/tBY15v0y9RYImHDnvGlF2grwWFvtVPAsukq5UT6FvFBKD5UQUQt/hmxq5ru7tJxBidwZSKP7n6rc+dstvFi10HzzVCKCVOHGj3PpCGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719673313; c=relaxed/simple;
	bh=SwqgEM9gABZ/kq/FR5x5DuJvZdyd1njTF45cNQIedSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuQrLh9oGzI16704RIN7PgdsQ5oSRFSnm1LDvYOh36UBUxQ0zhhG8S87US2w646Klq95v1ZIjVyG571eF91/21jD3adkQj4WoCrRiIfBFkQ1IMfgx6Z6eDPaAecoZ9c8Kom+zXSoSvjejZJCwfk+LyV9/2OBSNlHuSu4V2AI9Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWBHTw0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E138DC2BBFC;
	Sat, 29 Jun 2024 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719673312;
	bh=SwqgEM9gABZ/kq/FR5x5DuJvZdyd1njTF45cNQIedSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWBHTw0c7dZ9+dozVsloCp9Q/jkFQZCNHZxv68CseubmL5aaVDTZ2nNduVSlHaBLM
	 g1ibunQt1erSebtNdhsNhPd9wYneeTfxyOfZ5gEkznx2oUD7gV++l8TrBa6GTMfD1B
	 2pHqmvfJMUd8tIMS7i29bjGMlVOmkP3+Itsx1Fk7pfKo3dkdPGenlzgv0S9gbOQDZk
	 iF1L5tDpPohCstIR+SGl6+quhqXJD5fPjzalCrpC7S9qw39dB4y2ZPzL4u3ykWufwo
	 hg2jCy28hWEKWojj2JXyB0wjGPbtllQcV39KsdUeFwfNvD4qMHd+P1K73HGeMJKDs9
	 nBLTc8/aZ0cTg==
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
Subject: [PATCH v4 1/2] dt-bindings: net: airoha: Add EN7581 ethernet controller
Date: Sat, 29 Jun 2024 17:01:37 +0200
Message-ID: <20d103799a20d9d61a1c378eb27e61748859e978.1719672695.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719672695.git.lorenzo@kernel.org>
References: <cover.1719672695.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce device-tree binding documentation for Airoha EN7581 ethernet
mac controller.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/net/airoha,en7581-eth.yaml       | 171 ++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
new file mode 100644
index 000000000000..e2c0da02ccf2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -0,0 +1,171 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,en7581-eth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 Frame Engine Ethernet controller
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description:
+  The frame engine ethernet controller can be found on Airoha SoCs.
+  These SoCs have dual GMAC ports.
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
+  "^mac@[1-4]$":
+    type: object
+    unevaluatedProperties: false
+    allOf:
+      - $ref: ethernet-controller.yaml#
+    description:
+      Ethernet MAC node
+    properties:
+      compatible:
+        const: airoha,eth-mac
+
+      reg:
+        maxItems: 1
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
+      eth0: ethernet@1fb50000 {
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
+        mac1: mac@1 {
+          compatible = "airoha,eth-mac";
+          reg = <1>;
+          phy-mode = "2500base-x";
+          phy-handle = <&phy0>;
+        };
+
+        mac2: mac@2 {
+          compatible = "airoha,eth-mac";
+          reg = <2>;
+          phy-mode = "2500base-x";
+          phy-handle = <&phy1>;
+        };
+      };
+
+      mdio: mdio-bus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        phy0: ethernet-phy@0 {
+            compatible = "ethernet-phy-id67c9.de0a";
+            reg = <0>;
+            phy-mode = "2500base-x";
+        };
+
+        phy1: ethernet-phy@1 {
+            compatible = "ethernet-phy-id67c9.de0a";
+            reg = <1>;
+            phy-mode = "2500base-x";
+        };
+      };
+    };
-- 
2.45.2


