Return-Path: <netdev+bounces-106681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F36A9173D7
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 23:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326661C21B94
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 21:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA99117E47D;
	Tue, 25 Jun 2024 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUv2iO09"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF8143C49;
	Tue, 25 Jun 2024 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352562; cv=none; b=Z0BE/PQiSAefBN7QcLYT3vSQ9k6uc6MaqwRYiPpvXNpQHlZmPgAtPFZpgLSGvnlXBFwU/vORbnX+1/5u9fbWjdxwxMiHI0YEZVA3xCIBOMH3uuI4ztKWFwv1V9+/QtKhm2t48gQEc5iUlHsztK28Yzx2cnl1gkpPpBrRvxgQe1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352562; c=relaxed/simple;
	bh=PNXaByHvrppO8ckcUwwtuooxwI/YOX/5wCLg20xrE9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKACA6LN4UYGnbYIxE4qLhdqgIHepAoS/87eTDqsTq5/LxuXiDi28JC/LBax5jNs3a6diVuMf+YISLKPfvZDZA4o74KxWfsdEBkesxMexsEuYZfKGtioqk8uARStglsFA5HRNJPrX+PM71JhQyv3Vwhe83R51/PgFxOLasv23aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUv2iO09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7667C32781;
	Tue, 25 Jun 2024 21:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719352562;
	bh=PNXaByHvrppO8ckcUwwtuooxwI/YOX/5wCLg20xrE9E=;
	h=From:To:Cc:Subject:Date:From;
	b=lUv2iO09rnW+chC2vORLZ83rz9i0Migcuip2/dlnPgvLfMgQ0UNG1o/fu5cCN3sFm
	 MPRjwBFDXpEzIS4262A7pkWo5Pt+a4Hi3J4cZH2Ek2uF2O5zJLiAUPXuK8qAwkgzua
	 KIt9S9WUrKRtvxTdKRZEZ3MX6U8y58Ic0R/4zM/AyXnyUXEOSV1Wa5pwieBg5ZhfBV
	 uzQ8vL7CocAXMV2xRMl4Vg3l0H1tpph0c/m+lFAk2E0wCOXsuA4EWzUtv2p9i1hYxe
	 G6Hgy3FTMVaJLyeCe1acBd9Iya5f93aIW8sL8vkKmebc7fk7WAklKLq3/dhbtPKi02
	 0aCI8IVnr5l7w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] dt-bindings: net: Define properties at top-level
Date: Tue, 25 Jun 2024 15:54:41 -0600
Message-ID: <20240625215442.190557-2-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convention is DT schemas should define all properties at the top-level
and not inside of if/then schemas. That minimizes the if/then schemas
and is more future proof.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/net/mediatek,net.yaml |  28 +--
 .../devicetree/bindings/net/snps,dwmac.yaml   | 167 +++++++++---------
 2 files changed, 105 insertions(+), 90 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 3202dc7967c5..686b5c2fae40 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -68,6 +68,17 @@ properties:
       Phandle to the syscon node that handles the path from GMAC to
       PHY variants.
 
+  mediatek,pcie-mirror:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the mediatek pcie-mirror controller.
+
+  mediatek,pctl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon node that handles the ports slew rate and
+      driver current.
+
   mediatek,sgmiisys:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     minItems: 1
@@ -131,15 +142,12 @@ allOf:
 
         mediatek,infracfg: false
 
-        mediatek,pctl:
-          $ref: /schemas/types.yaml#/definitions/phandle
-          description:
-            Phandle to the syscon node that handles the ports slew rate and
-            driver current.
-
         mediatek,wed: false
 
         mediatek,wed-pcie: false
+    else:
+      properties:
+        mediatek,pctl: false
 
   - if:
       properties:
@@ -201,12 +209,10 @@ allOf:
           minItems: 1
           maxItems: 1
 
-        mediatek,pcie-mirror:
-          $ref: /schemas/types.yaml#/definitions/phandle
-          description:
-            Phandle to the mediatek pcie-mirror controller.
-
         mediatek,wed-pcie: false
+    else:
+      properties:
+        mediatek,pcie-mirror: false
 
   - if:
       properties:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 21cc27e75f50..023865b6f497 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -485,6 +485,38 @@ properties:
     description:
       Frequency division factor for MDC clock.
 
+  snps,pbl:
+    description:
+      Programmable Burst Length (tx and rx)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32]
+
+  snps,txpbl:
+    description:
+      Tx Programmable Burst Length. If set, DMA tx will use this value rather
+      than snps,pbl.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32]
+
+  snps,rxpbl:
+    description:
+      Rx Programmable Burst Length. If set, DMA rx will use this value rather
+      than snps,pbl.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32]
+
+  snps,no-pbl-x8:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Don\'t multiply the pbl/txpbl/rxpbl values by 8. For core rev < 3.50,
+      don\'t multiply the values by 4.
+
+  snps,tso:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enables the TSO feature otherwise it will be managed by MAC HW capability
+      register.
+
   mdio:
     $ref: mdio.yaml#
     unevaluatedProperties: false
@@ -568,95 +600,72 @@ allOf:
   - if:
       properties:
         compatible:
-          contains:
-            enum:
-              - allwinner,sun7i-a20-gmac
-              - allwinner,sun8i-a83t-emac
-              - allwinner,sun8i-h3-emac
-              - allwinner,sun8i-r40-gmac
-              - allwinner,sun8i-v3s-emac
-              - allwinner,sun50i-a64-emac
-              - ingenic,jz4775-mac
-              - ingenic,x1000-mac
-              - ingenic,x1600-mac
-              - ingenic,x1830-mac
-              - ingenic,x2000-mac
-              - qcom,sa8775p-ethqos
-              - qcom,sc8280xp-ethqos
-              - snps,dwmac-3.50a
-              - snps,dwmac-4.10a
-              - snps,dwmac-4.20a
-              - snps,dwmac-5.20
-              - snps,dwxgmac
-              - snps,dwxgmac-2.10
-              - st,spear600-gmac
+          not:
+            contains:
+              enum:
+                - allwinner,sun7i-a20-gmac
+                - allwinner,sun8i-a83t-emac
+                - allwinner,sun8i-h3-emac
+                - allwinner,sun8i-r40-gmac
+                - allwinner,sun8i-v3s-emac
+                - allwinner,sun50i-a64-emac
+                - ingenic,jz4775-mac
+                - ingenic,x1000-mac
+                - ingenic,x1600-mac
+                - ingenic,x1830-mac
+                - ingenic,x2000-mac
+                - qcom,sa8775p-ethqos
+                - qcom,sc8280xp-ethqos
+                - snps,dwmac-3.50a
+                - snps,dwmac-4.10a
+                - snps,dwmac-4.20a
+                - snps,dwmac-5.20
+                - snps,dwxgmac
+                - snps,dwxgmac-2.10
+                - st,spear600-gmac
 
     then:
       properties:
-        snps,pbl:
-          description:
-            Programmable Burst Length (tx and rx)
-          $ref: /schemas/types.yaml#/definitions/uint32
-          enum: [1, 2, 4, 8, 16, 32]
-
-        snps,txpbl:
-          description:
-            Tx Programmable Burst Length. If set, DMA tx will use this
-            value rather than snps,pbl.
-          $ref: /schemas/types.yaml#/definitions/uint32
-          enum: [1, 2, 4, 8, 16, 32]
-
-        snps,rxpbl:
-          description:
-            Rx Programmable Burst Length. If set, DMA rx will use this
-            value rather than snps,pbl.
-          $ref: /schemas/types.yaml#/definitions/uint32
-          enum: [1, 2, 4, 8, 16, 32]
-
-        snps,no-pbl-x8:
-          $ref: /schemas/types.yaml#/definitions/flag
-          description:
-            Don\'t multiply the pbl/txpbl/rxpbl values by 8. For core
-            rev < 3.50, don\'t multiply the values by 4.
+        snps,pbl: false
+        snps,txpbl: false
+        snps,rxpbl: false
+        snps,no-pbl-x8: false
 
   - if:
       properties:
         compatible:
-          contains:
-            enum:
-              - allwinner,sun7i-a20-gmac
-              - allwinner,sun8i-a83t-emac
-              - allwinner,sun8i-h3-emac
-              - allwinner,sun8i-r40-gmac
-              - allwinner,sun8i-v3s-emac
-              - allwinner,sun50i-a64-emac
-              - loongson,ls2k-dwmac
-              - loongson,ls7a-dwmac
-              - ingenic,jz4775-mac
-              - ingenic,x1000-mac
-              - ingenic,x1600-mac
-              - ingenic,x1830-mac
-              - ingenic,x2000-mac
-              - qcom,qcs404-ethqos
-              - qcom,sa8775p-ethqos
-              - qcom,sc8280xp-ethqos
-              - qcom,sm8150-ethqos
-              - snps,dwmac-4.00
-              - snps,dwmac-4.10a
-              - snps,dwmac-4.20a
-              - snps,dwmac-5.10a
-              - snps,dwmac-5.20
-              - snps,dwxgmac
-              - snps,dwxgmac-2.10
-              - st,spear600-gmac
+          not:
+            contains:
+              enum:
+                - allwinner,sun7i-a20-gmac
+                - allwinner,sun8i-a83t-emac
+                - allwinner,sun8i-h3-emac
+                - allwinner,sun8i-r40-gmac
+                - allwinner,sun8i-v3s-emac
+                - allwinner,sun50i-a64-emac
+                - loongson,ls2k-dwmac
+                - loongson,ls7a-dwmac
+                - ingenic,jz4775-mac
+                - ingenic,x1000-mac
+                - ingenic,x1600-mac
+                - ingenic,x1830-mac
+                - ingenic,x2000-mac
+                - qcom,qcs404-ethqos
+                - qcom,sa8775p-ethqos
+                - qcom,sc8280xp-ethqos
+                - qcom,sm8150-ethqos
+                - snps,dwmac-4.00
+                - snps,dwmac-4.10a
+                - snps,dwmac-4.20a
+                - snps,dwmac-5.10a
+                - snps,dwmac-5.20
+                - snps,dwxgmac
+                - snps,dwxgmac-2.10
+                - st,spear600-gmac
 
     then:
       properties:
-        snps,tso:
-          $ref: /schemas/types.yaml#/definitions/flag
-          description:
-            Enables the TSO feature otherwise it will be managed by
-            MAC HW capability register.
+        snps,tso: false
 
 additionalProperties: true
 
-- 
2.43.0


