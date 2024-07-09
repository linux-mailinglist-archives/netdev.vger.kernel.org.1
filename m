Return-Path: <netdev+bounces-110098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDA892AFBB
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4072829AD
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C2013211C;
	Tue,  9 Jul 2024 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVC48sAH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1698376EC;
	Tue,  9 Jul 2024 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720505159; cv=none; b=eJX4VcwDbqnu5Nl0swHI8H/5m6HYWfBWinNhqukV8Gy3PJIdhDIN4ccgSdDM+cGNOk58u/AlbAgOhF0OjZkFuiYzYFTeOUpLZEVV/kvu+mcUPU3Zodpuue84i21gWVCXuGviTKzN5uYW9vrymKesT28/y3B3hsxhgKoKNjHgJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720505159; c=relaxed/simple;
	bh=4XynSWc6QQav2NIMIcGN0h4ThvH7BNVMeaEk1V7vxZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ro1TKAAiPH52o/nUStNnv0UakbCNzF4cTUc9wxP+tF1Nh4JzbMrzg9B67Ckni8ySK0Q410OLwzbDJm/E4zYxDcIPUoqZnbDZ7mGQStSUDE4vMQ2LXvw1Rs5oIdULAcP/fWzSQxFGyHs7THlVzMagrXzY19BaodqnYnaCatkm98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVC48sAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485BCC32782;
	Tue,  9 Jul 2024 06:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720505158;
	bh=4XynSWc6QQav2NIMIcGN0h4ThvH7BNVMeaEk1V7vxZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVC48sAH1SAl4oBbk/hAvn5rTt9vGup/gzK3MnZhELPhCAlHserEX3ioXq5BO9AVM
	 RUj0UHXPq+JRr83N3h4QosXjPTLTd3f8s081ymYX4ZocVFPPBh6539D8ZL1I165mSd
	 pe+VNvFtF2gPsJqjcFGF1TVDxIml4IQQanBe0V5GaMAK4BGyKaXdOo6QAZ89vdwrs0
	 D4YCSKKs5N7pPg3uiuOXqDJm5jKswSXt8eBqd3II4mpHQgktlAHMmy8nzSnQE64iRK
	 WfZf8hXHl1S66i+ybY+94SMJqWXt03N+hcq1vsBPfHB8abvgDs4XMINMV5TtsDKZmf
	 uzCWufQzSlGqQ==
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
Subject: [PATCH v6 net-next 1/2] dt-bindings: net: airoha: Add EN7581 ethernet controller
Date: Tue,  9 Jul 2024 08:05:21 +0200
Message-ID: <da1a2266e457c8e9b2c29605b8aca4ca688e4c60.1720504637.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720504637.git.lorenzo@kernel.org>
References: <cover.1720504637.git.lorenzo@kernel.org>
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


