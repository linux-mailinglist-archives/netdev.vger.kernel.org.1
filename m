Return-Path: <netdev+bounces-217665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D6DB3976F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CFD36835A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CC82F0C4D;
	Thu, 28 Aug 2025 08:48:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F772EA163;
	Thu, 28 Aug 2025 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370902; cv=none; b=oi/E+CRHM3McMo9PmcYuvMwu931Nj2BmJfkpOLFVuiRSI3cuCn0ftN/y4VXZXwyvPnb9Zbb8A19noMfE0dM3eLi+oYebg5fxzMxnfCfXpdriYbyMttUaa9qwF4Eo0qd38EJZEGFN710iVv4UmYVd3KdlZwgo60kv7bfMm8VGDMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370902; c=relaxed/simple;
	bh=EQWXbhs2+NcTFLOJAcUu2US3mXQ51f5l0WdRHPHMMbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qvzuyxpsxlA7xPSWDgP19sgSh/SnqTczzOi9J9Wslb2lRlL0O4uLGmc9qtSNhnhNlnCR7PpPxuVnXmidy7CCm6+cUP5GRcgzYYYRh5aLwhbMIR5nQ/gTBKy5eSsD0UchZoV5IJV2bCULTKGDAUmW4n7jkk3rOe91wOARG61b/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowADHt6u4F7BoPuLFDw--.34750S3;
	Thu, 28 Aug 2025 16:47:53 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Thu, 28 Aug 2025 16:47:49 +0800
Subject: [PATCH net-next v8 1/5] dt-bindings: net: Add support for SpacemiT
 K1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-net-k1-emac-v8-1-e9075dd2ca90@iscas.ac.cn>
References: <20250828-net-k1-emac-v8-0-e9075dd2ca90@iscas.ac.cn>
In-Reply-To: <20250828-net-k1-emac-v8-0-e9075dd2ca90@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowADHt6u4F7BoPuLFDw--.34750S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry3WF45trW5KrW5Zr4rGrg_yoW5Jr1xpF
	4fCrn3GF48KF13Jw4fXFykuF1fGw4kAF1DJrZFvw13tas5KF90qr4akryfXa4UurW8Ja43
	XF1DAryDKr1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0pRWa09UUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

The Ethernet MACs on SpacemiT K1 appears to be a custom design. SpacemiT
refers to them as "EMAC", so let's just call them "spacemit,k1-emac".

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/spacemit,k1-emac.yaml  | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/spacemit,k1-emac.yaml b/Documentation/devicetree/bindings/net/spacemit,k1-emac.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..500a3e1daa230ea3a1fad30d8ea56a7822fccb3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/spacemit,k1-emac.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/spacemit,k1-emac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 Ethernet MAC
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+maintainers:
+  - Vivian Wang <wangruikang@iscas.ac.cn>
+
+properties:
+  compatible:
+    const: spacemit,k1-emac
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  mdio-bus:
+    $ref: mdio.yaml#
+    unevaluatedProperties: false
+
+  resets:
+    maxItems: 1
+
+  spacemit,apmu:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to syscon that controls this MAC
+          - description: offset of control registers
+    description:
+      A phandle to syscon with byte offset to control registers for this MAC
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - resets
+  - spacemit,apmu
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+
+    ethernet@cac80000 {
+        compatible = "spacemit,k1-emac";
+        reg = <0xcac80000 0x00000420>;
+        clocks = <&syscon_apmu CLK_EMAC0_BUS>;
+        interrupts = <131>;
+        mac-address = [ 00 00 00 00 00 00 ];
+        phy-handle = <&rgmii0>;
+        phy-mode = "rgmii-id";
+        pinctrl-names = "default";
+        pinctrl-0 = <&gmac0_cfg>;
+        resets = <&syscon_apmu RESET_EMAC0>;
+        rx-internal-delay-ps = <0>;
+        tx-internal-delay-ps = <0>;
+        spacemit,apmu = <&syscon_apmu 0x3e4>;
+
+        mdio-bus {
+            #address-cells = <0x1>;
+            #size-cells = <0x0>;
+
+            rgmii0: phy@1 {
+                reg = <0x1>;
+            };
+        };
+    };

-- 
2.50.1


