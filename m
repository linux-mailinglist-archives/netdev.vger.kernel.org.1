Return-Path: <netdev+bounces-45040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A40E7DAABE
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 05:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E5128163B
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 04:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0568186C;
	Sun, 29 Oct 2023 04:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rvy3Fwnc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64396610D;
	Sun, 29 Oct 2023 04:27:33 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A739DE;
	Sat, 28 Oct 2023 21:27:31 -0700 (PDT)
Received: from localhost (unknown [188.24.143.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 3985F6607358;
	Sun, 29 Oct 2023 04:27:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698553650;
	bh=HYnOv1bZbC6YWnZHMcSXUrZe4V8nd4RINTu6Y/8lH6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rvy3FwncjJ0oYP16fFMcc0rwTE7emu3xfbn+KOMFppAeM12CquO1m2hAJsmpZZ5xo
	 uABCC/QOlfTbZEpLs69GdVlgjDVNAdPr5fsqMEnZ4WEJA1RDgKUmh/2sUn7synHEyI
	 gnI4SJn4KJ68xKJ2HDcvAhKZZ95+E30x+dDwtYb/mzrvG3qmz86ffVqSJD8S8Uemvq
	 hp5zw5EqE4DaR9x3H1wbhAJnhTL1pYSvTbTidjnbh4c2hzaItikrwOhoopWxF4pUit
	 deqSB81GPpBYorgcSmuKaniKxh3V4VTFmsmD+cGkcaNDfvmrGhCu1rCLraD2wW+PSZ
	 tbwTY27t4JIJA==
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 04/12] dt-bindings: net: starfive,jh7110-dwmac: Add JH7100 SoC compatible
Date: Sun, 29 Oct 2023 06:27:04 +0200
Message-ID: <20231029042712.520010-5-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Synopsys DesignWare MAC found on StarFive JH7100 SoC is quite
similar to the newer JH7110, but it requires only two interrupts and a
single reset line.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 74 +++++++++++++------
 2 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index a4d7172ea701..c1380ff1c054 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -95,6 +95,7 @@ properties:
         - snps,dwmac-5.20
         - snps,dwxgmac
         - snps,dwxgmac-2.10
+        - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
 
   reg:
diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 44e58755a5a2..70e35a3401f4 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -13,10 +13,14 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - starfive,jh7110-dwmac
-      - const: snps,dwmac-5.20
+    oneOf:
+      - items:
+          - const: starfive,jh7100-dwmac
+          - const: snps,dwmac
+      - items:
+          - enum:
+              - starfive,jh7110-dwmac
+          - const: snps,dwmac-5.20
 
   reg:
     maxItems: 1
@@ -37,23 +41,6 @@ properties:
       - const: tx
       - const: gtx
 
-  interrupts:
-    minItems: 3
-    maxItems: 3
-
-  interrupt-names:
-    minItems: 3
-    maxItems: 3
-
-  resets:
-    minItems: 2
-    maxItems: 2
-
-  reset-names:
-    items:
-      - const: stmmaceth
-      - const: ahb
-
   starfive,tx-use-rgmii-clk:
     description:
       Tx clock is provided by external rgmii clock.
@@ -84,6 +71,51 @@ required:
 allOf:
   - $ref: snps,dwmac.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7100-dwmac
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+          maxItems: 2
+
+        interrupt-names:
+          minItems: 2
+          maxItems: 2
+
+        resets:
+          maxItems: 1
+
+        reset-names:
+          const: ahb
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-dwmac
+    then:
+      properties:
+        interrupts:
+          minItems: 3
+          maxItems: 3
+
+        interrupt-names:
+          minItems: 3
+          maxItems: 3
+
+        resets:
+          minItems: 2
+          maxItems: 2
+
+        reset-names:
+          items:
+            - const: stmmaceth
+            - const: ahb
+
 unevaluatedProperties: false
 
 examples:
-- 
2.42.0


