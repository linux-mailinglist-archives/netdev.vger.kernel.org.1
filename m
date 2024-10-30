Return-Path: <netdev+bounces-140360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D079B62A0
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951E6B22F98
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5481EBA19;
	Wed, 30 Oct 2024 12:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19761E906A
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290228; cv=none; b=EkVIgF2KmpYzOvmpA25woYRptPfYsZpdB6EQSwOvJHNaYqafddyjrxRHo3H0VbYqV+0yF9s0G3PZv3fv1CgR7OkppDrMbYrLLo8c5KZ2MEKScMmFyYKUPPTaImO88lrN+Z74ELxPjI+T8UdQxv1vHNGP4SZ3nS+OuiHQzEBCAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290228; c=relaxed/simple;
	bh=CPjrZ4fKhbLXk0zIZxVMkwmvH7cZECkh0hUkVKEQKCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qv3Cdipw6Wn34f9lcCJPTfRGxoFoM3tTZL+yKq3gHdIjwzZy3tfocoz3jazhfzJMAuywXlt8Mo5727OgvE9rsIAtQyOLDnik9OJ25MNAXtFU0daCBNneztkZ8u6kQk7vwzeMgDCDa4bwCz3MU44o+ch5yiRWlakdbyAQMJ24KbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1t67Wm-0006os-Tb; Wed, 30 Oct 2024 13:10:20 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Wed, 30 Oct 2024 13:10:13 +0100
Subject: [PATCH 2/4] arm64: dts: agilex5: add gmac nodes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-v6-12-topic-socfpga-agilex5-v1-2-b2b67780e60e@pengutronix.de>
References: <20241030-v6-12-topic-socfpga-agilex5-v1-0-b2b67780e60e@pengutronix.de>
In-Reply-To: <20241030-v6-12-topic-socfpga-agilex5-v1-0-b2b67780e60e@pengutronix.de>
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
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 321 +++++++++++++++++++++++++
 1 file changed, 321 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 57c28e284cccdb99ede6cea2bc0e8dd8aaf47fe9..761d970f8de59e08275edf15a9c890ba3bb1404c 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -141,6 +141,327 @@ soc: soc@0 {
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
+			reset-names = "stmmaceth", "stmmaceth-ocp";
+			clocks = <&clkmgr AGILEX5_EMAC0_CLK>,
+				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
+			snps,axi-config = <&stmmac_axi_emac0_setup>;
+			snps,mtl-rx-config = <&mtl_rx_emac0_setup>;
+			snps,mtl-tx-config = <&mtl_tx_emac0_setup>;
+			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
+			status = "disabled";
+
+			stmmac_axi_emac0_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <31>;
+				snps,rd_osr_lmt = <31>;
+				snps,blen = <0 0 0 32 16 8 4>;
+			};
+
+			mtl_rx_emac0_setup: rx-queues-config {
+				snps,rx-queues-to-use = <8>;
+				snps,rx-sched-sp;
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x1>;
+				};
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x2>;
+				};
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x3>;
+				};
+				queue4 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x4>;
+				};
+				queue5 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x5>;
+				};
+				queue6 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x6>;
+				};
+				queue7 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x7>;
+				};
+			};
+
+			mtl_tx_emac0_setup: tx-queues-config {
+				snps,tx-queues-to-use = <8>;
+				snps,tx-sched-wrr;
+				queue0 {
+					snps,weight = <0x9>;
+					snps,dcb-algorithm;
+				};
+				queue1 {
+					snps,weight = <0x0A>;
+					snps,dcb-algorithm;
+				};
+				queue2 {
+					snps,weight = <0x0B>;
+					snps,dcb-algorithm;
+				};
+				queue3 {
+					snps,weight = <0x0C>;
+					snps,dcb-algorithm;
+				};
+				queue4 {
+					snps,weight = <0x0D>;
+					snps,dcb-algorithm;
+				};
+				queue5 {
+					snps,weight = <0x0E>;
+					snps,dcb-algorithm;
+				};
+				queue6 {
+					snps,weight = <0x0F>;
+					snps,dcb-algorithm;
+					snps,tbs-enable;
+				};
+				queue7 {
+					snps,weight = <0x10>;
+					snps,dcb-algorithm;
+					snps,tbs-enable;
+				};
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
+			reset-names = "stmmaceth", "stmmaceth-ocp";
+			clocks = <&clkmgr AGILEX5_EMAC1_CLK>,
+				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
+			snps,axi-config = <&stmmac_axi_emac1_setup>;
+			snps,mtl-rx-config = <&mtl_rx_emac1_setup>;
+			snps,mtl-tx-config = <&mtl_tx_emac1_setup>;
+			altr,sysmgr-syscon = <&sysmgr 0x48 0>;
+			status = "disabled";
+
+			stmmac_axi_emac1_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <31>;
+				snps,rd_osr_lmt = <31>;
+				snps,blen = <0 0 0 32 16 8 4>;
+			};
+
+			mtl_rx_emac1_setup: rx-queues-config {
+				snps,rx-queues-to-use = <8>;
+				snps,rx-sched-sp;
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x1>;
+				};
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x2>;
+				};
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x3>;
+				};
+				queue4 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x4>;
+				};
+				queue5 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x5>;
+				};
+				queue6 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x6>;
+				};
+				queue7 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x7>;
+				};
+			};
+
+			mtl_tx_emac1_setup: tx-queues-config {
+				snps,tx-queues-to-use = <8>;
+				snps,tx-sched-wrr;
+				queue0 {
+					snps,weight = <0x9>;
+					snps,dcb-algorithm;
+				};
+				queue1 {
+					snps,weight = <0x0A>;
+					snps,dcb-algorithm;
+				};
+				queue2 {
+					snps,weight = <0x0B>;
+					snps,dcb-algorithm;
+				};
+				queue3 {
+					snps,weight = <0x0C>;
+					snps,dcb-algorithm;
+				};
+				queue4 {
+					snps,weight = <0x0D>;
+					snps,dcb-algorithm;
+				};
+				queue5 {
+					snps,weight = <0x0E>;
+					snps,dcb-algorithm;
+				};
+				queue6 {
+					snps,weight = <0x0F>;
+					snps,dcb-algorithm;
+					snps,tbs-enable;
+				};
+				queue7 {
+					snps,weight = <0x10>;
+					snps,dcb-algorithm;
+					snps,tbs-enable;
+				};
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
+			reset-names = "stmmaceth", "stmmaceth-ocp";
+			clocks = <&clkmgr AGILEX5_EMAC2_CLK>,
+				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
+			snps,axi-config = <&stmmac_axi_emac2_setup>;
+			snps,mtl-rx-config = <&mtl_rx_emac2_setup>;
+			snps,mtl-tx-config = <&mtl_tx_emac2_setup>;
+			altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
+			status = "disabled";
+
+			stmmac_axi_emac2_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <31>;
+				snps,rd_osr_lmt = <31>;
+				snps,blen = <0 0 0 32 16 8 4>;
+			};
+
+			mtl_rx_emac2_setup: rx-queues-config {
+				snps,rx-queues-to-use = <8>;
+				snps,rx-sched-sp;
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x1>;
+				};
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x2>;
+				};
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x3>;
+				};
+				queue4 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x4>;
+				};
+				queue5 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x5>;
+				};
+				queue6 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x6>;
+				};
+				queue7 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x7>;
+				};
+			};
+
+			mtl_tx_emac2_setup: tx-queues-config {
+				snps,tx-queues-to-use = <8>;
+				snps,tx-sched-wrr;
+				queue0 {
+					snps,weight = <0x9>;
+					snps,dcb-algorithm;
+				};
+				queue1 {
+					snps,weight = <0x0A>;
+					snps,dcb-algorithm;
+				};
+				queue2 {
+					snps,weight = <0x0B>;
+					snps,dcb-algorithm;
+				};
+				queue3 {
+					snps,weight = <0x0C>;
+					snps,dcb-algorithm;
+				};
+				queue4 {
+					snps,weight = <0x0D>;
+					snps,dcb-algorithm;
+				};
+				queue5 {
+					snps,weight = <0x0E>;
+					snps,dcb-algorithm;
+				};
+				queue6 {
+					snps,weight = <0x0F>;
+					snps,dcb-algorithm;
+					snps,tbs-enable;
+				};
+				queue7 {
+					snps,weight = <0x10>;
+					snps,dcb-algorithm;
+					snps,tbs-enable;
+				};
+			};
+		};
+
 		clkmgr: clock-controller@10d10000 {
 			compatible = "intel,agilex5-clkmgr";
 			reg = <0x10d10000 0x1000>;

-- 
2.46.0


