Return-Path: <netdev+bounces-16612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CE974E011
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2511C20B88
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDD4156D0;
	Mon, 10 Jul 2023 21:13:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34FD154B2
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0084AC433C8;
	Mon, 10 Jul 2023 21:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689023612;
	bh=SNGuXVhNbivoJOCwUC7uHYjtrHDLc0B9i+ZJR9cwZpU=;
	h=From:To:Cc:Subject:Date:From;
	b=EwUyesZZeyufHpoNx9N/EUT74OlHUjWDIOWBlNSte/ul2Z3Vdl2i5Z7SNCsnJq3C4
	 Ic5EyQRcXdwt9qaGZVuLrvvnftBcLPSBdB/fF4e5pjKzhfbGOrV25IK8sKXOL0i9AG
	 t3+SkSZJCdrhqDYUHrkamzr1e7vS9XW2IIRISAIRAJxiloSH3D+Q8t4J/MenejQiuT
	 3J8mRF+qXL8BfiFUBO0/R/DweffdeLsC963zB52/IqjWr3pTZHsboRLmR/h0PeZ4pZ
	 LWdoNcu/YliyDoiwVY3ahtzCgMtmMaNwRt8W+VhGBMTYtxQfylq+5kK4psArZ7NXQQ
	 ZIDqjd5ObSdnA==
From: Dinh Nguyen <dinguyen@kernel.org>
To: netdev@vger.kernel.org
Cc: dinguyen@kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	joabreu@synopsys.com,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowskii+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: socfpga: change the reset-name of "stmmaceth-ocp" to "ahb"
Date: Mon, 10 Jul 2023 16:13:12 -0500
Message-Id: <20230710211313.567761-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "stmmaceth-ocp" reset line on the SoCFPGA stmmac ethernet driver is
the same as the "abh" reset on a standard stmmac ethernet.

commit ("843f603762a5 dt-bindings: net: snps,dwmac: Add 'ahb'
reset/reset-name") documented the second reset signal as 'ahb' instead
of 'stmmaceth-ocp'. Change the reset-names of the SoCFPGA DWMAC driver to
'ahb'.

This also fixes the dtbs_check warning:
ethernet@ff802000: reset-names:1: 'ahb' was expected

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 6 +++---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi    | 6 +++---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi        | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 72c55e5187ca..f36063c57c7f 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -440,7 +440,7 @@ gmac0: ethernet@ff800000 {
 			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
 			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
+			reset-names = "stmmaceth", "ahb";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
@@ -460,7 +460,7 @@ gmac1: ethernet@ff802000 {
 			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
 			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
+			reset-names = "stmmaceth", "ahb";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
@@ -480,7 +480,7 @@ gmac2: ethernet@ff804000 {
 			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
 			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
+			reset-names = "stmmaceth", "ahb";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 1c846f13539c..439497ab967d 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -153,7 +153,7 @@ gmac0: ethernet@ff800000 {
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];
 			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
+			reset-names = "stmmaceth", "ahb";
 			clocks = <&clkmgr STRATIX10_EMAC0_CLK>, <&clkmgr STRATIX10_EMAC_PTP_CLK>;
 			clock-names = "stmmaceth", "ptp_ref";
 			tx-fifo-depth = <16384>;
@@ -171,7 +171,7 @@ gmac1: ethernet@ff802000 {
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];
 			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
+			reset-names = "stmmaceth", "ahb";
 			clocks = <&clkmgr STRATIX10_EMAC1_CLK>, <&clkmgr STRATIX10_EMAC_PTP_CLK>;
 			clock-names = "stmmaceth", "ptp_ref";
 			tx-fifo-depth = <16384>;
@@ -189,7 +189,7 @@ gmac2: ethernet@ff804000 {
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];
 			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
+			reset-names = "stmmaceth", "ahb";
 			clocks = <&clkmgr STRATIX10_EMAC2_CLK>, <&clkmgr STRATIX10_EMAC_PTP_CLK>;
 			clock-names = "stmmaceth", "ptp_ref";
 			tx-fifo-depth = <16384>;
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index fc047aef4911..d3adb6a130ae 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -158,7 +158,7 @@ gmac0: ethernet@ff800000 {
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];
 			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
+			reset-names = "stmmaceth", "ahb";
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
 			snps,multicast-filter-bins = <256>;
@@ -176,7 +176,7 @@ gmac1: ethernet@ff802000 {
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];
 			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
+			reset-names = "stmmaceth", "ahb";
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
 			snps,multicast-filter-bins = <256>;
@@ -194,7 +194,7 @@ gmac2: ethernet@ff804000 {
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];
 			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
+			reset-names = "stmmaceth", "ahb";
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
 			snps,multicast-filter-bins = <256>;
-- 
2.25.1


