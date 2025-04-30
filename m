Return-Path: <netdev+bounces-186947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FC0AA4272
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 07:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2D43BD3DB
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 05:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA3E1E2602;
	Wed, 30 Apr 2025 05:33:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550F282FA;
	Wed, 30 Apr 2025 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745991184; cv=none; b=b6Vw1UKLrt7O5bEePtp2gGapgjfPtPdcxTY+fpoSk8m5Jtg6wGFNUvUwIIO2mOGGqwqOv6lrJjLgX+Zk4esGwHzT41P/fVpaESr/rk0yCKK0x3Yby4EcRR7FQxPZPnA5S/lHLbR+WiGNi5Ul/A+RhtOhmbSCaqiNkpgB3Ul0DG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745991184; c=relaxed/simple;
	bh=jcSk9XlWcTHAuaWk6k7yBAgv5mcN5gJJEZhxrUiXlA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QuYD21Qg+76pH06bwWXDrMEFqcRvGeFyhPJrzt04pKrJrgUNSBtq/IHSh74zw2kuRP83rYxT69JlsAwuxQs73wyPOgc1AUuuGToXk7AQhwGJ1mJUGWOTIeL6ECL4I8BuqpwC2GVRc19Fn/XECGp6e7pUoH0UA9eIQGT7qyLuxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.147.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 47F13342FF2;
	Wed, 30 Apr 2025 05:32:57 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 30 Apr 2025 13:32:05 +0800
Subject: [PATCH v3 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-01-sun55i-emac0-v3-3-6fc000bbccbd@gentoo.org>
References: <20250430-01-sun55i-emac0-v3-0-6fc000bbccbd@gentoo.org>
In-Reply-To: <20250430-01-sun55i-emac0-v3-0-6fc000bbccbd@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Corentin Labbe <clabbe.montjoie@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2563; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=jcSk9XlWcTHAuaWk6k7yBAgv5mcN5gJJEZhxrUiXlA4=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoEbXqfMro5EpesqztKi/IHjQSAG+BRljr4Vx3v
 ZbpW+havXaJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaBG16l8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277fQ5EACY7OotR7YXC8hcJW
 40EvcHd8QAkmRLuiT+aeOAzMzXTj1A4Zo5jGGyFp+D8GQxtws/8ij/iQPR4081svXWOQ+QnrBAo
 M90t/I/C0QmDlcHJCoXXIhTsGzbpf5h7CM3XAKx0lfkW0T3E0PH7uYxR348Xyt3zEbozUnZJB/R
 PF/kNAL2hUNLUf5+ScMZHLcYaAHm04NF24xA/ubFYk00x+n0vty20G8VKBtN5TlGV/XwcfST+Vt
 8qDHmWhhAzcdd70Y9pClLvaq8K0HZ18RUbVhrvXwfVyx77CkIHiyOzK5TW81siobKQ4DCspEXR2
 lmIFSBWSpIQTJppKptvezQbcglpooEd4B37uajUVgEf5ng6Epu5qi5U9SmLnIZyNdl58TPlNImF
 Tse4/rVTMgWT3xAzJuSHUYRl4TFeasZrZ8kZ54RXe7pPF6Kd42OS8SYMahDS+iB4FZMuQdg98OJ
 7UqiBohvA5nsgoe/21LRT49J1LdgaFTwe/PNQgfTGE0f+llpB2bbZduRssnVgC9wX3awETTCQS1
 yxbEAttAhjCAba5lFOlTVwuvuF+V7racc3nMaNPwVDnXn2wpSLmocVVKTnbFSw/MNLXxbD3Llkn
 M9erKjS8AJc3Ro5mmrBlzyHrVxSdXb+iGNxl5UZvDjL9EgbK5zxFq/2FT9HORhaCd9nw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
including the A527/T527 chips. MAC0 is compatible to the A64 chip which
requires an external PHY. This patch only add RGMII pins for now.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Corentin LABBE <clabbe.montjoie@gmail.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index ee485899ba0af69f32727a53de20051a2e31be1d..8b7cbc2e78f500e1dc704e9a6bee87e70285509f 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -126,6 +126,16 @@ pio: pinctrl@2000000 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			rgmii0_pins: rgmii0-pins {
+				pins = "PH0", "PH1", "PH2", "PH3", "PH4",
+				       "PH5", "PH6", "PH7", "PH9", "PH10",
+				       "PH14", "PH15", "PH16", "PH17", "PH18";
+				allwinner,pinmux = <5>;
+				function = "emac0";
+				drive-strength = <40>;
+				bias-disable;
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0" ,"PF1", "PF2", "PF3", "PF4", "PF5";
 				allwinner,pinmux = <2>;
@@ -409,6 +419,15 @@ i2c5: i2c@2503400 {
 			#size-cells = <0>;
 		};
 
+		syscon: syscon@3000000 {
+			compatible = "allwinner,sun55i-a523-system-control",
+				     "allwinner,sun50i-a64-system-control";
+			reg = <0x03000000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+		};
+
 		gic: interrupt-controller@3400000 {
 			compatible = "arm,gic-v3";
 			#address-cells = <1>;
@@ -521,6 +540,28 @@ ohci1: usb@4200400 {
 			status = "disabled";
 		};
 
+		emac0: ethernet@4500000 {
+			compatible = "allwinner,sun55i-a523-emac0",
+				     "allwinner,sun50i-a64-emac";
+			reg = <0x04500000 0x10000>;
+			clocks = <&ccu CLK_BUS_EMAC0>;
+			clock-names = "stmmaceth";
+			resets = <&ccu RST_BUS_EMAC0>;
+			reset-names = "stmmaceth";
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			pinctrl-names = "default";
+			pinctrl-0 = <&rgmii0_pins>;
+			syscon = <&syscon>;
+			status = "disabled";
+
+			mdio0: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		r_ccu: clock-controller@7010000 {
 			compatible = "allwinner,sun55i-a523-r-ccu";
 			reg = <0x7010000 0x250>;

-- 
2.49.0


