Return-Path: <netdev+bounces-213370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C38B24C98
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C833B8FEE
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C96B2F6586;
	Wed, 13 Aug 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j54Zd/IR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B2F2F2909;
	Wed, 13 Aug 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096948; cv=none; b=QzQ2/n0Y2VwG3oZTdCQ/PnPCjcTnOmgevrUGA0OkAgIdNAGoPF+ZqE8KNwi8zDSemGTlaPnkIeKedKwFcguLz3alDiuA87Zc6AiB2f4Pw1PO8PxndSJW4iVqvmXtfM5EhpwLVoyfb8IXvTA4oCfudoQheWF3AFzrT239oHKDXBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096948; c=relaxed/simple;
	bh=VH0N7W47+kOQX4MCst8bkGtFUp56xeT53SSsWcTl1lA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bmbYkJBA1tBPY5dOpL085jmFqhSd/TJAQmMw6Jrz5u+DCsYZ2p3dfE9YGFzRwlHhfQRuqCqOo7QPR5nnjqZ00I0KbW3FrQJM/G870EFdSnAAEyJu6grjO2k4Er997PfVq0khhTMYevnfNvwoLvHpkD//IfNnCJ0N5b5Mvbw9wgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j54Zd/IR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AEAC4AF0B;
	Wed, 13 Aug 2025 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096947;
	bh=VH0N7W47+kOQX4MCst8bkGtFUp56xeT53SSsWcTl1lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j54Zd/IRCdHbdteiJ/3WB5SmJxLTENox/6+0h8gnY3oDL7I+CnDTpEYMQO9ntpzLD
	 Uw0ZjCwC78QtmvVGClqZA+XJ4q4aKlHQa7njPt7OQq6ZTPuqTB6hGRaj+my1wbwra1
	 WQ94vtqT4OBZX8Vx0/L6oxUfFswvc1Gho/kuS33P+qmC2I/vH8copLv5r9Ru9zgE1A
	 cld74mX1dawuaMGvM7zIwzMhy1ubTBoWmJ2IJA1w75nVBoVL1s2en+JWfueSo8n5UW
	 F6P+LHb4OJd1FUlPPln05QtnYCH1gpobIIloWGMeIq39Q6ah1dPqW1F9t7h+1aq0FW
	 S6g4oj44JN5hg==
Received: by wens.tw (Postfix, from userid 1000)
	id 1658D5FE8C; Wed, 13 Aug 2025 22:55:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH net-next v2 01/10] dt-bindings: net: sun8i-emac: Add A523 GMAC200 compatible
Date: Wed, 13 Aug 2025 22:55:31 +0800
Message-Id: <20250813145540.2577789-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813145540.2577789-1-wens@kernel.org>
References: <20250813145540.2577789-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The Allwinner A523 SoC family has a second Ethernet controller, called
the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
numbering. This controller, according to BSP sources, is fully
compatible with a slightly newer version of the Synopsys DWMAC core.
The glue layer around the controller is the same as found around older
DWMAC cores on Allwinner SoCs. The only slight difference is that since
this is the second controller on the SoC, the register for the clock
delay controls is at a different offset. Last, the integration includes
a dedicated clock gate for the memory bus and the whole thing is put in
a separately controllable power domain.

Add a compatible string entry for it, and work in the requirements for
a second clock and a power domain.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1:
- Switch to generic (tx|rx)-internal-delay-ps properties
---
 .../net/allwinner,sun8i-a83t-emac.yaml        | 81 ++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 2ac709a4c472..b4358e6456fa 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -26,6 +26,9 @@ properties:
               - allwinner,sun50i-h616-emac0
               - allwinner,sun55i-a523-gmac0
           - const: allwinner,sun50i-a64-emac
+      - items:
+          - const: allwinner,sun55i-a523-gmac200
+          - const: snps,dwmac-4.20a
 
   reg:
     maxItems: 1
@@ -37,14 +40,19 @@ properties:
     const: macirq
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   clock-names:
-    const: stmmaceth
+    minItems: 1
+    maxItems: 2
 
   phy-supply:
     description: PHY regulator
 
+  power-domains:
+    maxItems: 1
+
   syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -191,6 +199,45 @@ allOf:
             - mdio-parent-bus
             - mdio@1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun55i-a523-gmac200
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          items:
+            - const: stmmaceth
+            - const: mbus
+        tx-internal-delay-ps:
+          default: 0
+          minimum: 0
+          maximum: 700
+          multipleOf: 100
+          description:
+            External RGMII PHY TX clock delay chain value in ps.
+        rx-internal-delay-ps:
+          default: 0
+          minimum: 0
+          maximum: 3100
+          multipleOf: 100
+          description:
+            External RGMII PHY TX clock delay chain value in ps.
+      required:
+        - power-domains
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: stmmaceth
+        power-domains: false
+
+
 unevaluatedProperties: false
 
 examples:
@@ -323,4 +370,34 @@ examples:
         };
     };
 
+  - |
+    ethernet@4510000 {
+        compatible = "allwinner,sun55i-a523-gmac200",
+                     "snps,dwmac-4.20a";
+        reg = <0x04510000 0x10000>;
+        clocks = <&ccu 117>, <&ccu 79>;
+        clock-names = "stmmaceth", "mbus";
+        resets = <&ccu 43>;
+        reset-names = "stmmaceth";
+        interrupts = <0 47 4>;
+        interrupt-names = "macirq";
+        pinctrl-names = "default";
+        pinctrl-0 = <&rgmii1_pins>;
+        power-domains = <&pck600 4>;
+        syscon = <&syscon>;
+        phy-handle = <&ext_rgmii_phy_1>;
+        phy-mode = "rgmii-id";
+        snps,fixed-burst;
+        snps,axi-config = <&gmac1_stmmac_axi_setup>;
+
+        mdio {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ext_rgmii_phy_1: ethernet-phy@1 {
+                reg = <1>;
+            };
+        };
+    };
 ...
-- 
2.39.5


