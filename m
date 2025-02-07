Return-Path: <netdev+bounces-164084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7928A2C8D1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97BDE7A4372
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E97218BB9C;
	Fri,  7 Feb 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGxGZ6U7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574618C011;
	Fri,  7 Feb 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945633; cv=none; b=G0Wv/UNGwkUWnO7WulaRCj9DL5RyZ6+/eHt7CHr7R+NpluT0S+J49QJcFq4++EHLh++zZ3kSKI0ijtFJvZmlBj0trkErhzp3z5gQIJ6ryi/4Hq3ZiD3gOes8lQjglzsSwxB2L7ovhvbKatvXQTOAecxM1vH4vRJYcY9WZ3/XIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945633; c=relaxed/simple;
	bh=9MLgp6BnjDhauGe+vw7L5oPe/nVs55P5xZ18grfkNcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzolVpjDzxORB9I8iwQsOSutpuPhStRvrnq8Jn69dWaq5HHHL5F2W8GRLqC1At7fXlafHZD3bwkG6zY0nN3e6Xadu/HSjJcMwIlJxGzWc9Tb2kYkS7TExCB/4bhBb3QvPCelJSVSs/qJ1TfNsES51Hx3mGBuCRqw1WWE+J3gDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGxGZ6U7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF57C4CEDF;
	Fri,  7 Feb 2025 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738945633;
	bh=9MLgp6BnjDhauGe+vw7L5oPe/nVs55P5xZ18grfkNcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nGxGZ6U7cmQ8L+ico6eJK3xtFJysdSt0fWemEtoGiBSGGiAI0Dn58+G3m6oUUAFXL
	 HgsRhSq66uhf3W5CZVS2QuAtvywV5enkj8kfJ2UuiKVejF3VM/W3G+mH7ATblU5BMX
	 NdAeepwKZikuclVgCYo7fGhP+oXoR92kK8JDaiESqS8xHxCgWf5k6faprndV61ZuQi
	 w8nMRL+Vb/5/sbdouXq0jiIfyyS0Ipl+2ai2HllhsAzu6+VbHgIN1EaR2rFfC3cdOm
	 8UZUnupJ8Mtqs8RBnX8jL0eLuegdblVuZ+qUyzgBrcCHYdHVssDoGq28y1fjx8Ko/Q
	 nYjRCpQklL5Uw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 07 Feb 2025 17:26:25 +0100
Subject: [PATCH net-next v2 10/15] dt-bindings: arm: airoha: Add the NPU
 node for EN7581 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-airoha-en7581-flowtable-offload-v2-10-3a2239692a67@kernel.org>
References: <20250207-airoha-en7581-flowtable-offload-v2-0-3a2239692a67@kernel.org>
In-Reply-To: <20250207-airoha-en7581-flowtable-offload-v2-0-3a2239692a67@kernel.org>
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
 .../devicetree/bindings/arm/airoha,en7581-npu.yaml | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-npu.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a5bcfa299e7cd54f51e70f7ded113f1efcd3e8b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/airoha,en7581-npu.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/airoha,en7581-npu.yaml#
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
+    items:
+      - enum:
+          - airoha,en7581-npu
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 15
+
+  memory-region:
+    maxItems: 1
+    description:
+      Phandle to the node describing memory used to store NPU firmware binary.
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
+        compatible = "airoha,en7581-npu", "syscon";
+        reg = <0 0x1e900000 0 0x313000>;
+        interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
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


