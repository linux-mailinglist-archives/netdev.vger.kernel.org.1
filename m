Return-Path: <netdev+bounces-149291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2AA9E50C2
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45CE16A038
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6784B1F03E6;
	Thu,  5 Dec 2024 09:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2821DB92C
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389587; cv=none; b=jxYG1ZrGsZW+AWWp20aM9N84fJWl1t9tWFzRMGHEfD46EzseEsbrgUAfYNKwRSdNyeZXL7CU+/fdjbFiF4g22M8vXBMedwGFHD3bHqhHcoFyTfBv20y0WRL7NPo+GjN7TPkmhf++uVSS3rXWRkovelJ2wVQKw6kluluLIhDshrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389587; c=relaxed/simple;
	bh=03WGIBVqEJZPaK9SgPYfCuwS7r2M6ou3hBrVG6tNq4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeXCNNKKJeUfmZ7eyvbvHCR0vRVSQOAE+bQFC4+vvHgmr5mF2HnhfLjqmfUuBxjRagEcLbeSn9va3N+R5RP/Cs+iYpJxUzKGJ1wYP4v13WBsNn953Kn2AJnWgjS7e0OhkVJAFAi6+VxhPo5PuIktR6MR4gPCJXTktg0Tbbhtg38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1tJ7oR-0004Ks-Jk; Thu, 05 Dec 2024 10:06:19 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 05 Dec 2024 10:06:01 +0100
Subject: [PATCH v3 1/6] dt-bindings: net: dwmac: Convert socfpga dwmac to
 DT schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-v6-12-topic-socfpga-agilex5-v3-1-2a8cdf73f50a@pengutronix.de>
References: <20241205-v6-12-topic-socfpga-agilex5-v3-0-2a8cdf73f50a@pengutronix.de>
In-Reply-To: <20241205-v6-12-topic-socfpga-agilex5-v3-0-2a8cdf73f50a@pengutronix.de>
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-clk@vger.kernel.org, kernel@pengutronix.de, 
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
 .../devicetree/bindings/net/socfpga-dwmac.txt      |  57 ----------
 .../devicetree/bindings/net/socfpga-dwmac.yaml     | 119 +++++++++++++++++++++
 2 files changed, 119 insertions(+), 57 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
deleted file mode 100644
index 612a8e8abc88774619f4fd4e9205a3dd32226a9b..0000000000000000000000000000000000000000
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
-altr,sgmii-to-sgmii-converter: phandle to the TSE SGMII converter
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
index 0000000000000000000000000000000000000000..022d9eb7011d47666b140aaecf54541ca3dec0ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml
@@ -0,0 +1,119 @@
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
+  phy-mode:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phy mode the ethernet operates in.
+
+  altr,sgmii-to-sgmii-converter:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the TSE SGMII converter.
+
+      This device node has additional phandle dependency, the sgmii converter
+        - compatible that should be altr,gmii-to-sgmii-2.0
+        - reg-names that should be "eth_tse_control_port"
+
+required:
+  - compatible
+  - reg
+  - altr,sysmgr-syscon
+
+examples:
+  - |
+    //Example 1
+    gmii_to_sgmii_converter: phy@100000240 {
+          compatible = "altr,gmii-to-sgmii-2.0";
+          reg = <0x00000001 0x00000240 0x00000008>,
+                <0x00000001 0x00000200 0x00000040>;
+          reg-names = "eth_tse_control_port";
+          clocks = <&sgmii_1_clk_0 &emac1 1 &sgmii_clk_125 &sgmii_clk_125>;
+          clock-names = "tse_pcs_ref_clk_clock_connection", "tse_rx_cdr_refclk";
+    };
+
+  - |
+    //Example 2
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


