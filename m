Return-Path: <netdev+bounces-213379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDABB24CBC
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4CA881345
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4331C307ADA;
	Wed, 13 Aug 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRn5niKh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889902FFDDC;
	Wed, 13 Aug 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096950; cv=none; b=UA9SZs0ukGEDIzQxHEm2Ysd4rKrg1c6UHF6feW2jmiT8vDW3bBj/UMaRlUiXzUG1j5dXuXexbuG4NbHOg3u1o4KibWtulJu9WAwp7yW3M1rxwiojnbrvFMxvkHzriYCUdvmjaClO3whvNCrqA4upAsw3KwvirvJWYBM+kYBNfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096950; c=relaxed/simple;
	bh=yKrAHC0riAXESr1YT7TRrWp4LLqyhsj+D6V4VUG4krM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQp0IAIJUR64+7qtXe2I9eLHlvHC+ji3kbx4mhTSh9rMqPiOryF0yjI2YcAZEJQRW5zVySrXRj0H1R0VQrpvzq5cI0qQWcLOKcfW7dT30DpOI5iXp+/d7B7zdws6frHBP9gYUlCLfRX0xZD0aLp50GX9b7qmKQHRQuJkSXQX0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRn5niKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C95EC4CEEF;
	Wed, 13 Aug 2025 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096950;
	bh=yKrAHC0riAXESr1YT7TRrWp4LLqyhsj+D6V4VUG4krM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aRn5niKhjq2Lr784ZyGMYtj4dP5OyKaAccRzguObTv7W4Sc/RbtOv3LjL57ayXrU/
	 78WOYTPUMq8EbhBQuRUTYNQKM+TYCstHvrw/FlUCsyyJ67Ja9OqbUeRPc/NzvwkQs2
	 g3mOu0LRsw60EqW1JPt3SMufrSys39+DP+o4T69EsKuN4NVyjuNiyfNZMBNdkgY2dE
	 GQvZPTne4nMKSAJFO5LclIqSl+xdpLhOjDq6HfP3czTfYrnG0tHNU7BQiG5OhbglBo
	 4fZoQNi6q/h8Gk3qr8xf8sMS49PXUbF3AyIAMvZhT9QolKqNcH7LvXIV56LyXfLNX8
	 26bS6VUl2vJLQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 38A3E5FEEF; Wed, 13 Aug 2025 22:55:45 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH net-next v2 05/10] arm64: dts: allwinner: a523: Add GMAC200 ethernet controller
Date: Wed, 13 Aug 2025 22:55:35 +0800
Message-Id: <20250813145540.2577789-6-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813145540.2577789-1-wens@kernel.org>
References: <20250813145540.2577789-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The A523 SoC family has a second ethernet controller, called the
GMAC200. It is not exposed on all the SoCs in the family.

Add a device node for it. All the hardware specific settings are from
the vendor BSP.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v1:
- Fixed typo in tx-queues-config
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 6b6f2296bdff..449bcafbddcd 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -180,6 +180,16 @@ rgmii0_pins: rgmii0-pins {
 				bias-disable;
 			};
 
+			rgmii1_pins: rgmii1-pins {
+				pins = "PJ0", "PJ1", "PJ2", "PJ3", "PJ4",
+				       "PJ5", "PJ6", "PJ7", "PJ8", "PJ9",
+				       "PJ11", "PJ12", "PJ13", "PJ14", "PJ15";
+				allwinner,pinmux = <5>;
+				function = "gmac1";
+				drive-strength = <40>;
+				bias-disable;
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB9", "PB10";
 				allwinner,pinmux = <2>;
@@ -601,6 +611,51 @@ mdio0: mdio {
 			};
 		};
 
+		gmac1: ethernet@4510000 {
+			compatible = "allwinner,sun55i-a523-gmac200",
+				     "snps,dwmac-4.20a";
+			reg = <0x04510000 0x10000>;
+			clocks = <&ccu CLK_BUS_EMAC1>, <&ccu CLK_MBUS_EMAC1>;
+			clock-names = "stmmaceth", "mbus";
+			resets = <&ccu RST_BUS_EMAC1>;
+			reset-names = "stmmaceth";
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			pinctrl-names = "default";
+			pinctrl-0 = <&rgmii1_pins>;
+			power-domains = <&pck600 PD_VO1>;
+			syscon = <&syscon>;
+			snps,fixed-burst;
+			snps,axi-config = <&gmac1_stmmac_axi_setup>;
+			snps,mtl-rx-config = <&gmac1_mtl_rx_setup>;
+			snps,mtl-tx-config = <&gmac1_mtl_tx_setup>;
+			status = "disabled";
+
+			mdio1: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gmac1_mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <1>;
+
+				queue0 {};
+			};
+
+			gmac1_stmmac_axi_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <0xf>;
+				snps,rd_osr_lmt = <0xf>;
+				snps,blen = <256 128 64 32 16 8 4>;
+			};
+
+			gmac1_mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <1>;
+
+				queue0 {};
+			};
+		};
+
 		ppu: power-controller@7001400 {
 			compatible = "allwinner,sun55i-a523-ppu";
 			reg = <0x07001400 0x400>;
-- 
2.39.5


