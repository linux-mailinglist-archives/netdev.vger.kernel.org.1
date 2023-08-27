Return-Path: <netdev+bounces-30910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C59C789CA1
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 11:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2B81C20949
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEB7610B;
	Sun, 27 Aug 2023 09:29:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892363A2
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 09:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D31C433C9;
	Sun, 27 Aug 2023 09:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693128549;
	bh=BDjKxssVciyafhRoklrknMsC7Bl61wHlzGID0mz0Kb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDRSB6BuXfTUhb8KjeEad6rpXSHysvgZzbylO+uHW5+1F151eLaNU7gTrEXO4a+jp
	 mQHKUwcJ+rHjjjRgPHdj8ZiIA8/Dgy0cK5fSm28mjJD6DKDGbGEh3E2ZgXY3lDd5Q6
	 ox0HTLT3GS0EaCZkI6RotQuDixVL1Fea1/vC8/dSDlDDWdmgdsXOlTY6r4icWdZCwY
	 c/vWZv2AkqiYeYPQXQmUJZbjYSIxjdDN+FpvMdCtD9CpOpUZkjjKG0arHtLOTgGwci
	 ZKkfocC1yHZUgNLYBhddo4XEjHc1xcQu5VpxyX6DZpauLv8gy2cHX1+2aTCRw0Fpkq
	 UocciAmUSvnNQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>, Maxime@web.codeaurora.org,
	Coquelin@web.codeaurora.org, Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH net-next v2 2/3] dt-bindings: net: add T-HEAD dwmac support
Date: Sun, 27 Aug 2023 17:17:09 +0800
Message-Id: <20230827091710.1483-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827091710.1483-1-jszhang@kernel.org>
References: <20230827091710.1483-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation to describe T-HEAD dwmac.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../devicetree/bindings/net/thead,dwmac.yaml  | 77 +++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/thead,dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index b196c5de2061..73821f86a609 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -96,6 +96,7 @@ properties:
         - snps,dwxgmac
         - snps,dwxgmac-2.10
         - starfive,jh7110-dwmac
+        - thead,th1520-dwmac
 
   reg:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/net/thead,dwmac.yaml b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
new file mode 100644
index 000000000000..bf8ec8ca2753
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/thead,dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD DWMAC Ethernet controller
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - thead,th1520-dwmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - thead,th1520-dwmac
+      - const: snps,dwmac-3.70a
+
+  reg:
+    maxItems: 1
+
+  thead,gmacapb:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle to the syscon node that control ethernet
+      interface and timing delay.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - phy-mode
+  - thead,gmacapb
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gmac0: ethernet@e7070000 {
+        compatible = "thead,th1520-dwmac", "snps,dwmac-3.70a";
+        reg = <0xe7070000 0x2000>;
+        clocks = <&clk 1>, <&clk 2>;
+        clock-names = "stmmaceth", "pclk";
+        interrupts = <66>;
+        interrupt-names = "macirq";
+        phy-mode = "rgmii-id";
+        snps,fixed-burst;
+        snps,axi-config = <&stmmac_axi_setup>;
+        snps,pbl = <32>;
+        thead,gmacapb = <&gmacapb_syscon>;
+        phy-handle = <&phy0>;
+
+        mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "snps,dwmac-mdio";
+
+            phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
-- 
2.40.1


