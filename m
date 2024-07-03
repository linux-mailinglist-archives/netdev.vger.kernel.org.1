Return-Path: <netdev+bounces-109034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3778926935
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F861281C69
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3736F18E74A;
	Wed,  3 Jul 2024 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeeUZ5Hf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23E18F2CC;
	Wed,  3 Jul 2024 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720036731; cv=none; b=O8n5+Fg1sYSPlvX9BrkzQw7/DZGKg+uv7SX0NyDKsRuR194n7yOOegc2qs/9hsxraO3MhokjboHrOd6aj9SeT6nffjgV8yckzIC4/tlUDUzDTWcRCBmlTrKvgALLvRmPevyjRxCKpFY65asVBRDwGnejBUvcznuyHMailn6VURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720036731; c=relaxed/simple;
	bh=jMJnkRb4oAbcEF6UDuF481F0b14sL/CeDqqFPHZQpbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9Et/VJjNJ8CUxYZDmXfX5PPq+UKcbhnf/8P3vt35rBsJx8vbS04xlL5k2Vj838LP5nd7lj70DRwBJURWrfCWMrvLLYIbU8/WD5eCOLDqvX8M6cnehW+MM05aVEJq6jVytXYfRQ7J6CEXL11U0jfm8yQZ6M58hzotWA01k++W38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeeUZ5Hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E276C4AF07;
	Wed,  3 Jul 2024 19:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720036730;
	bh=jMJnkRb4oAbcEF6UDuF481F0b14sL/CeDqqFPHZQpbc=;
	h=From:To:Cc:Subject:Date:From;
	b=DeeUZ5Hf/ZZFOToqGRzWhPdPj/tTYlbd89HA98bdDtjDzCSawRfPqf1WdWIJ4/CFQ
	 3nEMSjFYZFaDmoPZZgY15DNz3MY1fjnPz6095XmlRKXTvrwIg+NOC1ggl6eKEW/yzB
	 gPiUH220sseRUHucISNSrUhSz7OiV4wrDJi6lGAWeD618sGs0jDJU3+7oM0UJN5XK/
	 /jttjlYYB3xbOsMB7QtW42DcgHgHZbM86ecH9Ul/nxGJLIRvFGVckd5XO8E/TMKfUF
	 P3xg4O300+Ks7/M7NeHfMq2Rb9O2+0UkKQa/LU8qXyvyThOenBQXw4zEF/vjP2ZDvi
	 uEzk/iKYlPqAQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH v2] dt-bindings: net: Define properties at top-level
Date: Wed,  3 Jul 2024 13:58:27 -0600
Message-ID: <20240703195827.1670594-2-robh@kernel.org>
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
v2:
 - Drop the parts already applied from Serge
---
 .../devicetree/bindings/net/mediatek,net.yaml | 28 +++++---
 .../devicetree/bindings/net/snps,dwmac.yaml   | 67 ++++++++++---------
 2 files changed, 52 insertions(+), 43 deletions(-)

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
index 0ab124324eec..3eb65e63fdae 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -512,6 +512,12 @@ properties:
     description:
       Frequency division factor for MDC clock.
 
+  snps,tso:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enables the TSO feature otherwise it will be managed by MAC HW capability
+      register.
+
   mdio:
     $ref: mdio.yaml#
     unevaluatedProperties: false
@@ -595,41 +601,38 @@ allOf:
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


