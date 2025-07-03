Return-Path: <netdev+bounces-203741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DACBAF6F0A
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6AB3AA2AC
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133742D7805;
	Thu,  3 Jul 2025 09:44:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5928ECD1;
	Thu,  3 Jul 2025 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535867; cv=none; b=nQ2o0bkLpUQiNhuii5u3pHu3/92x9j5GX908hhFM5FHrzKtbpg9mlDnztLW/3ulbRlFXiIKkcTHVwlI35AnX3IgVBW3a4EDreUj/6JgJZM2Kq6bzibu/nVjUxNDTDHIqI0lf8sBkt6XPqDpybaBs7IYYQXqbXnNjK0Ajc8zFP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535867; c=relaxed/simple;
	bh=jh5EvUFWkXb95Vb+1mgggdXNgxLNFWJZEz/iNgD5W7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YiImnk4pj++R1iOw+dsniucueWkSvVezbN7BFwsJPEvskK5/RtAGuO3KTW1Oc3WCPFWxZSnGIOqyAkZANidysWbUhhJu+PpV67VP3t6O1KfFPWxzY28fbDjXQtPSIJrut6I4GhopvYEcbHScY767fZUlz1uooPcpvSLAgNW2D1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHX4DWUGZouhe1AA--.40630S3;
	Thu, 03 Jul 2025 17:43:51 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Thu, 03 Jul 2025 17:42:02 +0800
Subject: [PATCH net-next v4 1/2] dt-bindings: net: Add support for SpacemiT
 K1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-net-k1-emac-v4-1-686d09c4cfa8@iscas.ac.cn>
References: <20250703-net-k1-emac-v4-0-686d09c4cfa8@iscas.ac.cn>
In-Reply-To: <20250703-net-k1-emac-v4-0-686d09c4cfa8@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vivian Wang <uwu@dram.page>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-CM-TRANSID:rQCowAAHX4DWUGZouhe1AA--.40630S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry3WF45trW5KrW5Zr4rGrg_yoW5Jr1xpF
	4fCrs3Gr48KF13Jw4fXFykuF1fGw4kAF1DJrZFvw13tas5KF90qr4akryfXa4UurW8Ja43
	XF1DAryDKr1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRJxhLUUUUU
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
2.49.0


