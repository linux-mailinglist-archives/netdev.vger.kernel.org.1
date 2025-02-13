Return-Path: <netdev+bounces-166091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07504A347FA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2958188D7EA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5608202C53;
	Thu, 13 Feb 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c10AqJOZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFAA15A856;
	Thu, 13 Feb 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460916; cv=none; b=sfNWd2X30kj+bvhUjyR89nVVK1HBFYRRUl41sDGKBcC+PqSPLixtnMm4w9NFsf9g5fzbqCNndSzBZ6RyHWhjOD/w6CoOadjtmWeSUr1dsI68SNezAGo9q4WkP/PpmiSoQg0hdRzXcGe3ClDWrY0ARl9e4gyPNP7cN6Gfls4f7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460916; c=relaxed/simple;
	bh=LwwtkOpdej/qZv1Ihtwk/09yNh2N86nJc5Uj66l1lg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RkEtUpNuBO0b5WZlHxj7aLyH5txmbHtCzaCZ2ZT1sEp7GZ13t4Ygw25JLqMIyhA1Dp8tosJKxTC6550ffpTUUpi9dHTwD8ESp/2dmL+49S5Q0xtjUqiZtvDq5MLg3MgL5v2KJ3w3f5sM34uPcqzaioJy12iuA81Bvm2b+7n00hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c10AqJOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28696C4CEE8;
	Thu, 13 Feb 2025 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739460916;
	bh=LwwtkOpdej/qZv1Ihtwk/09yNh2N86nJc5Uj66l1lg8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c10AqJOZKOyKErUBcYbRfhLxES2xvgnwyMuFyOqzO5Pg1GyyDm7dj1Q65BuPr0ui3
	 NTuYGinpvMb/rn4SK3RfFRAUfM8c6QLhfT7rtj2pimgbAr4zI/ttePwcMeJpaBrm4U
	 Gxvu8X2CwvMk0kPZZfMItAvJxh1ts0fDhUNd/UZNGD0dVwsU8ebD7xz8ZZ9pnjtir8
	 p+Kmj6vNEzREu3ohEJrUgZAuL0K0o5JCzxM/P8j1A4ygeoYX6bEcakZiYK4C1i0LTq
	 X3DCxVj3H1apk3BS8YhRV1Z9KAkxiJZN6HdaAPKvxRk23ockBPaQWgumv7joQNtQs4
	 JbH3lfeifopKQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 13 Feb 2025 16:34:30 +0100
Subject: [PATCH net-next v4 11/16] dt-bindings: net: airoha: Add the NPU
 node for EN7581 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-airoha-en7581-flowtable-offload-v4-11-b69ca16d74db@kernel.org>
References: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
In-Reply-To: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.2

This patch adds the NPU document binding for EN7581 SoC.
The Airoha Network Processor Unit (NPU) provides a configuration interface
to implement wired and wireless hardware flow offloading programming Packet
Processor Engine (PPE) flow table.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/airoha,en7581-npu.yaml | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..414e5c0615b8a8db487c23978a283b0254b2b63c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,en7581-npu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha Network Processor Unit for EN7581 SoC
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description:
+  The Airoha Network Processor Unit (NPU) provides a configuration interface
+  to implement wired and wireless hardware flow offloading programming Packet
+  Processor Engine (PPE) flow table.
+
+properties:
+  compatible:
+    enum:
+      - airoha,en7581-npu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: mbox host irq line
+      - description: watchdog0 irq line
+      - description: watchdog1 irq line
+      - description: watchdog2 irq line
+      - description: watchdog3 irq line
+      - description: watchdog4 irq line
+      - description: watchdog5 irq line
+      - description: watchdog6 irq line
+      - description: watchdog7 irq line
+
+  memory-region:
+    maxItems: 1
+    description:
+      Memory used to store NPU firmware binary.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      npu@1e900000 {
+        compatible = "airoha,en7581-npu";
+        reg = <0 0x1e900000 0 0x313000>;
+        interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+        memory-region = <&npu_binary>;
+      };
+    };

-- 
2.48.1


