Return-Path: <netdev+bounces-222781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B347DB5600C
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 12:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754A43BE7BD
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD092EBDCB;
	Sat, 13 Sep 2025 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWFesRbq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6632EBB9B;
	Sat, 13 Sep 2025 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758436; cv=none; b=bRZhOVB0RUS+4ud1TabQs9wSynaVhGthZLEVqy4xg+TPPare+ZD38FvaLaW4CVJO7TWqw+wXLkHM71u0hbU3xJmGTW+o7jZwXFwp32NCTcioWSHOnA1GEIsCRsKuRf7XIssjLyNo5DE+++GjYgDnT1ZfQSsL/Fmx3+WN9gl9Ppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758436; c=relaxed/simple;
	bh=EUHf/HJMqycKHb+xK0fWFR42cC3Oe682CeoIddIqU/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tSpUIHTLISV9q2CO1wPPRzJVgm0S8ji84AEdYlghfggFDVRT9xsi4xJil0vdokTShBV7vuDnvI8S8NK+w869zzBSEldVy955cnxqH5KLFY0D0xaSIQa9eUAN4w5Zf8ScyOSO7rYcDqGZrgr4XbMSnLhrV4w9fsTKIDz8oyQ2TBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWFesRbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A3CC4CEFA;
	Sat, 13 Sep 2025 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757758435;
	bh=EUHf/HJMqycKHb+xK0fWFR42cC3Oe682CeoIddIqU/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWFesRbqbkz4Jo9G1gp2l+AGKgjwXJqKG/MtzDM/A20Nm6hc1wcrOKUkpyagBa0m8
	 oZXBwmxJoANiT/OF61Ws5eLHUsAacRmciGpBtwLan0zEPE8dOGyY3qfdYMNw/AR63g
	 q3jFCd95BnMQ5ju3ew1chQkKD6Xmq9IE2CjOXrLr/HyCjMC1gbr0DisA8T9XecUn5A
	 BMKOOg6rm0yLPevGTz356dMAi5/HHLHCK+mhm2xAaWM8PUJE1gnbf/S7pq/oCyKdkL
	 omWXT5tQlJsI03gLLldujUBe89PLnEUbhOBXOx9ijAtzSdKZyFxicv9qaucV64moDg
	 1hqqUZZQdrTQg==
Received: by wens.tw (Postfix, from userid 1000)
	id 2E7AB5FBD7; Sat, 13 Sep 2025 18:13:53 +0800 (CST)
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
Subject: [PATCH net-next v6 1/6] dt-bindings: net: sun8i-emac: Add A523 GMAC200 compatible
Date: Sat, 13 Sep 2025 18:13:44 +0800
Message-Id: <20250913101349.3932677-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250913101349.3932677-1-wens@kernel.org>
References: <20250913101349.3932677-1-wens@kernel.org>
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
Changes since v4:
- Move clock-names list to main schema (Rob)
Changes since v2:
- Added "select" to avoid matching against all dwmac entries
Changes since v1:
- Switch to generic (tx|rx)-internal-delay-ps properties
---
 .../net/allwinner,sun8i-a83t-emac.yaml        | 95 ++++++++++++++++++-
 1 file changed, 93 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 2ac709a4c472..fc62fb2a68ac 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -10,6 +10,21 @@ maintainers:
   - Chen-Yu Tsai <wens@csie.org>
   - Maxime Ripard <mripard@kernel.org>
 
+# We need a select here so we don't match all nodes with 'snps,dwmac'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - allwinner,sun8i-a83t-emac
+          - allwinner,sun8i-h3-emac
+          - allwinner,sun8i-r40-gmac
+          - allwinner,sun8i-v3s-emac
+          - allwinner,sun50i-a64-emac
+          - allwinner,sun55i-a523-gmac200
+  required:
+    - compatible
+
 properties:
   compatible:
     oneOf:
@@ -26,6 +41,9 @@ properties:
               - allwinner,sun50i-h616-emac0
               - allwinner,sun55i-a523-gmac0
           - const: allwinner,sun50i-a64-emac
+      - items:
+          - const: allwinner,sun55i-a523-gmac200
+          - const: snps,dwmac-4.20a
 
   reg:
     maxItems: 1
@@ -37,14 +55,21 @@ properties:
     const: macirq
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   clock-names:
-    const: stmmaceth
+    minItems: 1
+    items:
+      - const: stmmaceth
+      - const: mbus
 
   phy-supply:
     description: PHY regulator
 
+  power-domains:
+    maxItems: 1
+
   syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -191,6 +216,42 @@ allOf:
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
+          minItems: 2
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
+          maxItems: 1
+        power-domains: false
+
+
 unevaluatedProperties: false
 
 examples:
@@ -323,4 +384,34 @@ examples:
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


