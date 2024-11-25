Return-Path: <netdev+bounces-147205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489E59D8410
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 12:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E334B32920
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219A7193086;
	Mon, 25 Nov 2024 10:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708BA192D75
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530822; cv=none; b=SabIXVvbWwoeW2n0YT6GBRY7lKlodk34TWepD29OaIY84HNG6VfmYYoY+A3xDFFJyuBCrdeVAiKajwqAu60wa5IJcSsd7obhshy0UQX2GTQrkUrGgKgwqBJzBwmCJm8KIfgwkKyJ3LWNFMfOvHxKbVppE0N1gRMSr5/kBq79z28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530822; c=relaxed/simple;
	bh=aqrcmVCIwkm7vpPwCYUzuqcfSmWqiRz5iZ58Ps7dWF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tsMe37ced+5OUrnTNT0sa5xQ2Z6y9pTzpR7sP97mLTHo0Rh0Pey4w9nW3ttCgwTCXGat1siaIhY9zb/gTJQ0FxsImil3fOsfKzFO367OKnXK3QgwsdmnR5DSzToegJAQklnmpg9tCUkcGf1E7940ttowgLvrxWI/LVBnbZFh7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1tFWPQ-0001Fo-1e; Mon, 25 Nov 2024 11:33:36 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 25 Nov 2024 11:33:21 +0100
Subject: [PATCH v2 2/4] arm64: dts: agilex5: add gmac nodes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-v6-12-topic-socfpga-agilex5-v2-2-864256ecc7b2@pengutronix.de>
References: <20241125-v6-12-topic-socfpga-agilex5-v2-0-864256ecc7b2@pengutronix.de>
In-Reply-To: <20241125-v6-12-topic-socfpga-agilex5-v2-0-864256ecc7b2@pengutronix.de>
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

The Agilex5 provides three Synopsys XGMAC ethernet cores, that can be
used to transmit and receive data at 10M/100M/1G/2.5G over ethernet
connections and enables support for Time Sensitive Networking (TSN)
applications.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 87 ++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index b1debf0317d0576f7b00200e9593481671183faa..647ccd0b5a66b68fab745d443b975c12d6ce63df 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -141,6 +141,93 @@ soc: soc@0 {
 		device_type = "soc";
 		interrupt-parent = <&intc>;
 
+		gmac0: ethernet@10810000 {
+			compatible = "altr,socfpga-stmmac-a10-s10",
+				     "snps,dwxgmac-2.10",
+				     "snps,dwxgmac";
+			reg = <0x10810000 0x3500>;
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			max-frame-size = <3800>;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <64>;
+			rx-fifo-depth = <16384>;
+			tx-fifo-depth = <32768>;
+			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
+			reset-names = "stmmaceth", "ahb";
+			clocks = <&clkmgr AGILEX5_EMAC0_CLK>,
+				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
+			snps,axi-config = <&stmmac_axi_emac0_setup>;
+			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
+			status = "disabled";
+
+			stmmac_axi_emac0_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <31>;
+				snps,rd_osr_lmt = <31>;
+				snps,blen = <0 0 0 32 16 8 4>;
+			};
+		};
+
+		gmac1: ethernet@10820000 {
+			compatible = "altr,socfpga-stmmac-a10-s10",
+				     "snps,dwxgmac-2.10",
+				     "snps,dwxgmac";
+			reg = <0x10820000 0x3500>;
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			max-frame-size = <3800>;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <64>;
+			rx-fifo-depth = <16384>;
+			tx-fifo-depth = <32768>;
+			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
+			reset-names = "stmmaceth", "ahb";
+			clocks = <&clkmgr AGILEX5_EMAC1_CLK>,
+				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
+			snps,axi-config = <&stmmac_axi_emac1_setup>;
+			altr,sysmgr-syscon = <&sysmgr 0x48 0>;
+			status = "disabled";
+
+			stmmac_axi_emac1_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <31>;
+				snps,rd_osr_lmt = <31>;
+				snps,blen = <0 0 0 32 16 8 4>;
+			};
+		};
+
+		gmac2: ethernet@10830000 {
+			compatible = "altr,socfpga-stmmac-a10-s10",
+				     "snps,dwxgmac-2.10",
+				     "snps,dwxgmac";
+			reg = <0x10830000 0x3500>;
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			max-frame-size = <3800>;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <64>;
+			rx-fifo-depth = <16384>;
+			tx-fifo-depth = <32768>;
+			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
+			reset-names = "stmmaceth", "ahb";
+			clocks = <&clkmgr AGILEX5_EMAC2_CLK>,
+				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
+			snps,axi-config = <&stmmac_axi_emac2_setup>;
+			altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
+			status = "disabled";
+
+			stmmac_axi_emac2_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <31>;
+				snps,rd_osr_lmt = <31>;
+				snps,blen = <0 0 0 32 16 8 4>;
+			};
+		};
+
 		clkmgr: clock-controller@10d10000 {
 			compatible = "intel,agilex5-clkmgr";
 			reg = <0x10d10000 0x1000>;

-- 
2.47.0


