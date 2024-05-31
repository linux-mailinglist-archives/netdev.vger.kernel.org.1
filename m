Return-Path: <netdev+bounces-99703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364EE8D5F88
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 12:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6343F1C221B1
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61624152177;
	Fri, 31 May 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeKtajEa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57236134;
	Fri, 31 May 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150956; cv=none; b=rXP99y7sV0ASJzCxBnRMAt/1IJ9gtq4ePNwxjONXQWG88mLyU6TwRZcMB8i62WCUKUwgamI1gOr8HMguPAIAH5HCwXQdL9r8k5Lpntgap/Fr7/Y7VINxgw0I8foRMPHWwykyP5bHBltpUZ3ozQpbkZac5JcrOYOhmx76T29RyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150956; c=relaxed/simple;
	bh=mSJQ0LdrBXwX6M+BZArH2nyrdlB2g1cJCOTeGMlH5p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lbog9vDW3dIK4SUhs1jYKXY9Np6AglYErRFmMU/RVvyOaL1UzRcvwwMtZwhtaORz5uIq9SQo4ZpLeUvqdjZeZwjU4tb90RSVgm5m78Rq/X9L51LuM3hd839X/GGeeqm+nFfck+whQ2UU5UpdM3Gse9LYsXW2Ld35BkOKEDilmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeKtajEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C5DC116B1;
	Fri, 31 May 2024 10:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717150955;
	bh=mSJQ0LdrBXwX6M+BZArH2nyrdlB2g1cJCOTeGMlH5p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NeKtajEaapKrmKaUilFm+wij4kW3zYH4QYE66U6J+9uNLgjxOI27v6upEWztZ0wGy
	 BZ2ss8ZDgeonmApoNMGW2B97smaa7v+tE2tTsslgNvlZmDrl5XzBxJRC6/ImyCAplf
	 +0im1j6ULQyiGrLYLHCe1jAOOp9DJMZSq7NuCsqsFaGg9qFmv/4EpGJc35kGEPUYKl
	 jchHYs6eUy5grgpPpJ6psQ8indji7ORXhDm3kwz7DGD9PbraUdS/fvh9cMW+ct5PAg
	 VCs/tUibo+5ivcYB+XhPPol6LVPqm9DaEf7aWihn1TKwHOmzKaN3nESPgO/RBJp3j+
	 xo/l9wYpxFUOw==
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
	benjamin.larsson@genexis.eu
Subject: [PATCH net-next 1/3] dt-bindings: net: airoha: Add EN7581 ethernet controller
Date: Fri, 31 May 2024 12:22:18 +0200
Message-ID: <97946e955b05d21fe96ef8f98f794831cbd7c3b5.1717150593.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717150593.git.lorenzo@kernel.org>
References: <cover.1717150593.git.lorenzo@kernel.org>
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
 .../bindings/net/airoha,en7581.yaml           | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581.yaml b/Documentation/devicetree/bindings/net/airoha,en7581.yaml
new file mode 100644
index 000000000000..09e7b5eed3ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en7581.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,en7581.yaml#
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
+    maxItems: 10
+
+  resets:
+    maxItems: 7
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
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
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
+    #include <dt-bindings/reset/airoha,en7581-reset.h>
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
+        resets = <&scuclk EN7581_FE_RST>,
+                 <&scuclk EN7581_FE_PDMA_RST>,
+                 <&scuclk EN7581_FE_QDMA_RST>,
+                 <&scuclk EN7581_XSI_MAC_RST>,
+                 <&scuclk EN7581_DUAL_HSI0_MAC_RST>,
+                 <&scuclk EN7581_DUAL_HSI1_MAC_RST>,
+                 <&scuclk EN7581_HSI_MAC_RST>;
+        reset-names = "fe", "pdma", "qdma", "xsi-mac",
+                      "hsi0-mac", "hsi1-mac", "hsi-mac";
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
+      };
+    };
-- 
2.45.1


