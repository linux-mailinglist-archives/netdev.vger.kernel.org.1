Return-Path: <netdev+bounces-137050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281129A4225
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4F2284D85
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1912022C1;
	Fri, 18 Oct 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DMHIKa+x"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D531FF7C2;
	Fri, 18 Oct 2024 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264759; cv=none; b=Gwnjze8X8jLmoXgEqByVWiwljrvhoZcFTgSL8LdxjjGT/3IN1jIX32c+q4mgbU/QmDlkwEUlbxod6UnQDan6zaqVB/qnEyhw+E2/7S+FS/aARAGqmne0Quc91LayvZv1NoE56dbwc50hTJEXpniLyKK3fsbtJ8wV+/X+4VHI5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264759; c=relaxed/simple;
	bh=HQTSQIkZHY/yw7VXJNQxASS7XXYveuwmozW5Ea+i4wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqLfSD/W2e5747N3JjFgRt2XXb0gEABdgXSfvSJoIGIG26fL6VX49e96QhuPUSng6Y1Mz6cMkb+GShcPQdyRjgsVv7sf9Xl2JTD2rEncYI60/t6H/UvD6bfwaRikucYeFnN1UmbzCnnxVfpizDPMSlTiQLanVVDwPMYyct7xolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DMHIKa+x; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729264749;
	bh=HQTSQIkZHY/yw7VXJNQxASS7XXYveuwmozW5Ea+i4wo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DMHIKa+xQGALVx1MEA2UV324Y7IFUfsQw/P1lTXPp4bjxlfwp4u9OZ7xN0TRCuPyy
	 Q2g1L+VQRgaY8JgDRtxrLhA0GvbjbWGOgZV/yDFft1fkPPZN4qYDzVU/WHoo0l91L6
	 ysHDoMnTJIphyWPtw7ygVVqLSYEO0l78xa6pr6ND/9Q+ocpFuKR2o5H/xGF16TzBmX
	 ds6GhMN+Ba2rdqB1hcZmY+qN7Phdwc9tBN/fI+KTHbRDK/VlX2NIh6K1+0tpolM0Xa
	 vrq3xwU4L0ABEf2kLgRQZfPHwv6tChgD9D93UccHweBCXKWWjuzHbqCGU+k3vmc+NN
	 nzyF6TDMo9aww==
Received: from [192.168.1.218] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3705817E362C;
	Fri, 18 Oct 2024 17:19:07 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 18 Oct 2024 11:19:02 -0400
Subject: [PATCH v2 1/2] arm64: dts: mediatek: mt8188: Add ethernet node
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241018-genio700-eth-v2-1-f3c73b85507b@collabora.com>
References: <20241018-genio700-eth-v2-0-f3c73b85507b@collabora.com>
In-Reply-To: <20241018-genio700-eth-v2-0-f3c73b85507b@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Jianguo Zhang <jianguo.zhang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Hsuan-Yu Lin <shane.lin@canonical.com>
X-Mailer: b4 0.14.2

Describe the ethernet present on the MT8188.

Signed-off-by: Jianguo Zhang <jianguo.zhang@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Hsuan-Yu Lin <shane.lin@canonical.com>
[Cleaned up to pass dtbs_check, follow DTS style guidelines, removed
hardcoded mac address and split between mt8188 and genio700 commits,
and addressed further feedback from the mailing list]
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 97 ++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index b493207a1b688dba51bf5e0e469349263f54ca94..d2795bba15ecd4e9359721b1c61cd4ae4a2a0a71 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1647,6 +1647,103 @@ spi5: spi@11019000 {
 			status = "disabled";
 		};
 
+		eth: ethernet@11021000 {
+			compatible = "mediatek,mt8188-gmac", "mediatek,mt8195-gmac",
+				     "snps,dwmac-5.10a";
+			reg = <0 0x11021000 0 0x4000>;
+			interrupts = <GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "macirq";
+			clocks = <&pericfg_ao CLK_PERI_AO_ETHERNET>,
+				 <&pericfg_ao CLK_PERI_AO_ETHERNET_BUS>,
+				 <&topckgen CLK_TOP_SNPS_ETH_250M>,
+				 <&topckgen CLK_TOP_SNPS_ETH_62P4M_PTP>,
+				 <&topckgen CLK_TOP_SNPS_ETH_50M_RMII>,
+				 <&pericfg_ao CLK_PERI_AO_ETHERNET_MAC>;
+			clock-names = "axi", "apb", "mac_main", "ptp_ref",
+				      "rmii_internal", "mac_cg";
+			assigned-clocks = <&topckgen CLK_TOP_SNPS_ETH_250M>,
+					  <&topckgen CLK_TOP_SNPS_ETH_62P4M_PTP>,
+					  <&topckgen CLK_TOP_SNPS_ETH_50M_RMII>;
+			assigned-clock-parents = <&topckgen CLK_TOP_ETHPLL_D2>,
+						 <&topckgen CLK_TOP_ETHPLL_D8>,
+						 <&topckgen CLK_TOP_ETHPLL_D10>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_ETHER>;
+			mediatek,pericfg = <&infracfg_ao>;
+			snps,axi-config = <&stmmac_axi_setup>;
+			snps,mtl-rx-config = <&mtl_rx_setup>;
+			snps,mtl-tx-config = <&mtl_tx_setup>;
+			snps,txpbl = <16>;
+			snps,rxpbl = <16>;
+			snps,clk-csr = <0>;
+			status = "disabled";
+
+			eth_mdio: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			stmmac_axi_setup: stmmac-axi-config {
+				snps,blen = <0 0 0 0 16 8 4>;
+				snps,rd_osr_lmt = <0x7>;
+				snps,wr_osr_lmt = <0x7>;
+			};
+
+			mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <4>;
+				snps,rx-sched-sp;
+
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+			};
+
+			mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <4>;
+				snps,tx-sched-wrr;
+
+				queue0 {
+					snps,dcb-algorithm;
+					snps,priority = <0x0>;
+					snps,weight = <0x10>;
+				};
+
+				queue1 {
+					snps,dcb-algorithm;
+					snps,priority = <0x1>;
+					snps,weight = <0x11>;
+				};
+
+				queue2 {
+					snps,dcb-algorithm;
+					snps,priority = <0x2>;
+					snps,weight = <0x12>;
+				};
+
+				queue3 {
+					snps,dcb-algorithm;
+					snps,priority = <0x3>;
+					snps,weight = <0x13>;
+				};
+			};
+		};
+
 		xhci1: usb@11200000 {
 			compatible = "mediatek,mt8188-xhci", "mediatek,mtk-xhci";
 			reg = <0 0x11200000 0 0x1000>,

-- 
2.47.0


