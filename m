Return-Path: <netdev+bounces-163073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1081A294F6
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9871881174
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DD41DD88B;
	Wed,  5 Feb 2025 15:32:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B211919259A
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769577; cv=none; b=P0hFPIgHMntT6USAPSjmLXOU8kigF65xASk+WruYFvbBSyZSLdF6Ah9gAaAzeiwMRWmF82625Q+j+MJ6LPlbqBm2UUqgiXWemfkFtM4pwmPH1tzsLPH6jxKgXA5IKlXhcLd+tX+kCsuOW85U1f2p64ExzJlHNd/apDSY8mmoGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769577; c=relaxed/simple;
	bh=dHRUYJ/MnsjiK8Dl07HnCAQq/MHCPjJBp6vjgTdrRCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1MXaxX2t1SkGKhrhD2hOWH1ew3kZezRkVRb7COZy7bAod/JhlLpnucTEVoH2Qx4tUX4WH+81w0wALGVgP4mGaaTfOTJbag8DUDjI08iDI/8POq8P3ULGJKSSyENPTW1TjcBOXasv1WDZIU3RvcthjdXBBE21o5Pb9KIn4l+jMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1tfhOK-0005Jb-6n; Wed, 05 Feb 2025 16:32:40 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Wed, 05 Feb 2025 16:32:23 +0100
Subject: [PATCH v4 2/6] dt-bindings: net: dwmac: Convert socfpga dwmac to
 DT schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-v6-12-topic-socfpga-agilex5-v4-2-ebf070e2075f@pengutronix.de>
References: <20250205-v6-12-topic-socfpga-agilex5-v4-0-ebf070e2075f@pengutronix.de>
In-Reply-To: <20250205-v6-12-topic-socfpga-agilex5-v4-0-ebf070e2075f@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Changes to the binding while converting:
- add "snps,dwmac-3.7{0,2,4}a". They are used, but undocumented.
- altr,f2h_ptp_ref_clk is not a required property but optional.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 .../bindings/net/pcs/altr,gmii-to-sgmii.yaml       |  47 ++++++++++
 .../devicetree/bindings/net/socfpga-dwmac.txt      |  57 ------------
 .../devicetree/bindings/net/socfpga-dwmac.yaml     | 102 +++++++++++++++++++++
 3 files changed, 149 insertions(+), 57 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/pcs/altr,gmii-to-sgmii.yaml b/Documentation/devicetree/bindings/net/pcs/altr,gmii-to-sgmii.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1b7b69b2e396a508dfbb2c56399302b1cd1ce658
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/altr,gmii-to-sgmii.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pcs/altr,gmii-to-sgmii.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA Triple Speed Ethernet GMII-to-SGMII converter
+
+maintainers:
+  - Dinh Nguyen <dinguyen@altera.com>
+
+description:
+  The Altera Triple Speed Ethernet controller provides a SGMII PCS and some clocks
+  to the ethernet subsystem to which it is attached.
+
+properties:
+  compatible:
+    const: altr,gmii-to-sgmii-2.0
+
+  reg:
+    maxItems: 6
+
+  reg-names:
+    const: eth_tse_control_port
+
+  clocks-names:
+    items:
+      - const: tse_pcs_ref_clk_clock_connection
+      - const: tse_rx_cdr_refclk
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    gmii_to_sgmii_converter: phy@100000240 {
+          compatible = "altr,gmii-to-sgmii-2.0";
+          reg = <0x00000001 0x00000240 0x00000008>,
+                <0x00000001 0x00000200 0x00000040>;
+          reg-names = "eth_tse_control_port";
+          clocks = <&sgmii_1_clk_0 &emac1 1 &sgmii_clk_125 &sgmii_clk_125>;
+          clock-names = "tse_pcs_ref_clk_clock_connection", "tse_rx_cdr_refclk";
+    };
diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
deleted file mode 100644
index 67784463f6f5a3ba7d2e10810810ab2d51715842..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-Altera SOCFPGA SoC DWMAC controller
-
-This is a variant of the dwmac/stmmac driver an inherits all descriptions
-present in Documentation/devicetree/bindings/net/stmmac.txt.
-
-The device node has additional properties:
-
-Required properties:
- - compatible	: For Cyclone5/Arria5 SoCs it should contain
-		  "altr,socfpga-stmmac". For Arria10/Agilex/Stratix10 SoCs
-		  "altr,socfpga-stmmac-a10-s10".
-		  Along with "snps,dwmac" and any applicable more detailed
-		  designware version numbers documented in stmmac.txt
- - altr,sysmgr-syscon : Should be the phandle to the system manager node that
-   encompasses the glue register, the register offset, and the register shift.
-   On Cyclone5/Arria5, the register shift represents the PHY mode bits, while
-   on the Arria10/Stratix10/Agilex platforms, the register shift represents
-   bit for each emac to enable/disable signals from the FPGA fabric to the
-   EMAC modules.
- - altr,f2h_ptp_ref_clk use f2h_ptp_ref_clk instead of default eosc1 clock
-   for ptp ref clk. This affects all emacs as the clock is common.
-
-Optional properties:
-altr,emac-splitter: Should be the phandle to the emac splitter soft IP node if
-		DWMAC controller is connected emac splitter.
-phy-mode: The phy mode the ethernet operates in
-altr,gmii-to-sgmii-converter: phandle to the TSE SGMII converter
-
-This device node has additional phandle dependency, the sgmii converter:
-
-Required properties:
- - compatible	: Should be altr,gmii-to-sgmii-2.0
- - reg-names	: Should be "eth_tse_control_port"
-
-Example:
-
-gmii_to_sgmii_converter: phy@100000240 {
-	compatible = "altr,gmii-to-sgmii-2.0";
-	reg = <0x00000001 0x00000240 0x00000008>,
-		<0x00000001 0x00000200 0x00000040>;
-	reg-names = "eth_tse_control_port";
-	clocks = <&sgmii_1_clk_0 &emac1 1 &sgmii_clk_125 &sgmii_clk_125>;
-	clock-names = "tse_pcs_ref_clk_clock_connection", "tse_rx_cdr_refclk";
-};
-
-gmac0: ethernet@ff700000 {
-	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
-	altr,sysmgr-syscon = <&sysmgr 0x60 0>;
-	reg = <0xff700000 0x2000>;
-	interrupts = <0 115 4>;
-	interrupt-names = "macirq";
-	mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-	clocks = <&emac_0_clk>;
-	clock-names = "stmmaceth";
-	phy-mode = "sgmii";
-	altr,gmii-to-sgmii-converter = <&gmii_to_sgmii_converter>;
-};
diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml b/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2568dd90f4555485f18912b5352f191824bb918c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/socfpga-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA SoC DWMAC controller
+
+maintainers:
+  - Dinh Nguyen <dinguyen@altera.com>
+
+description:
+  This is a variant of the dwmac/stmmac driver an inherits all descriptions
+  present in Documentation/devicetree/bindings/net/stmmac.txt.
+
+# We need a select here so we don't match all nodes with 'snps,dwmac'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - altr,socfpga-stmmac # For Cyclone5/Arria5 SoCs
+          - altr,socfpga-stmmac-a10-s10 # For Arria10/Agilex/Stratix10 SoCs
+  required:
+    - compatible
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - altr,socfpga-stmmac
+          - const: snps,dwmac-3.70a
+          - const: snps,dwmac
+      - items:
+          - enum:
+              - altr,socfpga-stmmac-a10-s10
+          - const: snps,dwmac-3.72a
+          - const: snps,dwmac
+      - items:
+          - enum:
+              - altr,socfpga-stmmac-a10-s10
+          - const: snps,dwmac-3.74a
+          - const: snps,dwmac
+
+  altr,sysmgr-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the sysmgr node
+          - description: register offset that controls the PHY mode or FPGA signals
+          - description: register shift for the PHY mode bits or FPGA signals
+    description:
+      Should be the phandle to the system manager node that
+      encompasses the glue register, the register offset, and the register shift.
+      On Cyclone5/Arria5, the register shift represents the PHY mode bits, while
+      on the Arria10/Stratix10/Agilex platforms, the register shift represents
+      bit for each emac to enable/disable signals from the FPGA fabric to the
+      EMAC modules.
+
+  altr,f2h_ptp_ref_clk:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Use f2h_ptp_ref_clk instead of default eosc1 clock
+      for ptp ref clk. This affects all emacs as the clock is common.
+
+  altr,emac-splitter:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Should be the phandle to the emac splitter soft IP node if
+      DWMAC controller is connected emac splitter.
+
+  altr,gmii-to-sgmii-converter:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the TSE SGMII converter.
+
+required:
+  - compatible
+  - reg
+  - altr,sysmgr-syscon
+
+additionalProperties: true
+
+examples:
+  - |
+    //Example 1
+    gmac0: ethernet@ff700000 {
+          compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
+          altr,sysmgr-syscon = <&sysmgr 0x60 0>;
+          reg = <0xff700000 0x2000>;
+          interrupts = <0 115 4>;
+          interrupt-names = "macirq";
+          mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
+          clocks = <&emac_0_clk>;
+          clock-names = "stmmaceth";
+          phy-mode = "sgmii";
+          altr,gmii-to-sgmii-converter = <&gmii_to_sgmii_converter>;
+    };

-- 
2.46.0


