Return-Path: <netdev+bounces-203181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4205AF0B31
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDEC164A52
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A9F21ABBB;
	Wed,  2 Jul 2025 06:02:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8321F5619;
	Wed,  2 Jul 2025 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436173; cv=none; b=F3qxwkbxpEoY0HwVARPmyD4xs65ct3mE+AD8tSHH3QyCdwJNqaciwhXEqXwZkudB18v6iTX1QAjcQZDB2MZNPFs/8UlByzwt2J6cerTvdnsZ13iFZjMu3nhi32X61cRIVYhhHentNmZT4d4DoC16MRfu+wsJgkuDhSSjY4fkI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436173; c=relaxed/simple;
	bh=jh5EvUFWkXb95Vb+1mgggdXNgxLNFWJZEz/iNgD5W7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dH29Z6sCnmBUZgyj0QHDtlZ+4egYkbpZoNjQHySaxXss5zmGJSCh64qsVEuk7qM0WfA8YzIO3OUe5rXPO9uPJV2DRsqIdq2aqNwb3QKXT7z2Jhw76QIahDJ2LC6MaSKM4so6HiVphLpq8oQjwtDnztW+sdtl0W26FVArNxYw3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.2])
	by APP-01 (Coremail) with SMTP id qwCowAC3pqpny2RomPduAA--.1282S3;
	Wed, 02 Jul 2025 14:02:16 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 02 Jul 2025 14:01:40 +0800
Subject: [PATCH net-next v3 1/5] dt-bindings: net: Add support for SpacemiT
 K1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-net-k1-emac-v3-1-882dc55404f3@iscas.ac.cn>
References: <20250702-net-k1-emac-v3-0-882dc55404f3@iscas.ac.cn>
In-Reply-To: <20250702-net-k1-emac-v3-0-882dc55404f3@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Lukas Bulwahn <lukas.bulwahn@redhat.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowAC3pqpny2RomPduAA--.1282S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry3WF45trW5KrW5Zr4rGrg_yoW5Jr1xpF
	4fCrs3Gr48KF13Jw4fXFykuF1fGw4kAF1DJrZFvw13tas5KF90qr4akryfXa4UurW8Ja43
	XF1DAryDKr1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRYFCUUUUUU==
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


