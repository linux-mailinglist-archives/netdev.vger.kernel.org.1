Return-Path: <netdev+bounces-185165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A2EA98C51
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEF644559E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B152798E3;
	Wed, 23 Apr 2025 14:04:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A127933B;
	Wed, 23 Apr 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417066; cv=none; b=XKdakCiNuXmNtpLa5rSRHVjiH+OOkWcFVL9Hs9eE5+4qSnqnJ0qQrJs7pDF3LgbvHqiPRPyetDTP9dOWMsLsV9fk306kmgAZjDBdQ0jTMmOEdnS9oyQu1BIvtiUFD0sqzUljdVy6ZNsFvqeVwNHLpkZmAM4VJw8E4Jjh7ugQe7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417066; c=relaxed/simple;
	bh=0V5/pbt0VA5Hg3Oc3Eb1tgOeb9g+83cQqd7UmD2KG/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaGUVRigPgzSltzTM+/Xz6iyVz8NhxLxrL1uATR2kWTm8HTUJKmmN2C5J22vHcFDIsZ+h78lLtqtw3DGDtGT/rLyqoYgxuCxFNp0M+I9tGmQ51lhbXvmnHfodGNegbM1W5I54utEDw1bE/8AkJ1iHOdRP1rj0NmFrrpio78eWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id A642C343104;
	Wed, 23 Apr 2025 14:04:17 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 23 Apr 2025 22:03:24 +0800
Subject: [PATCH 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-01-sun55i-emac0-v1-3-46ee4c855e0a@gentoo.org>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
In-Reply-To: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2341; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=0V5/pbt0VA5Hg3Oc3Eb1tgOeb9g+83cQqd7UmD2KG/0=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCPNCu+Ck+tBycFGCLRZGCONhmaFsMetB/xTFc
 zcuVTjTtk+JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAjzQl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277TOWD/9d0BZRe4NDQvirps
 zi/lwslGgvwYMjLQ/3HTIRvNt7QMkf0jwCPqovWlSOyGHEP/yX19MXMUv3qqnE4k6qFZD1G7XZH
 9KYotrmieLbFK63woUMoH88mAWCrG7IcndR4CgAIOOCxn7wFxUCH/oYC+Z7JklA+fIZWVY2gb2D
 VN0kipeHFaPfF3yboNeDC0EhjnF+aqEo1qjGMin9ipcm7SVuCjkuyom8uqyv01zKojpeA6RrLlX
 HIWlbwtXxBI3mFj8k1zOtpArnHFm6P/+pSrI/3e+JMB7+T1PV++ULZSXDDCk0Oslar2zGbSWpMq
 kdBmCiHGekqceFB+2//G3Uwx2WzqjxEyVvN/MgjaMrIerIM2PQY2JUHiKB4jhMtZxDI4+GWlJX8
 ihcmq3pEZouT6juXeuErif6A1C8aT12zeqEg9bCuHYqwLp8mEelrssZuNLIy7RY4+1zRlIM3ezU
 W8FEkhfdfDDrd/C3njsYCh40+9r6xuHrXIPbZfEGMmRUhqH6yONaEcIDwplJtmMGew7m7l6El2B
 kHx3316rXA3p4rcX94AR2pyRcfW1yMyK8sn/5rpSIexzGMHohCRTHRQ/od/S+aYAeWwZGiMnsho
 TvFeuhcFlNZ0Hoo1FKLtbYlbBxdAIgKJdKT/0RRm/R0/6juU+/582hwa16anX0ou/eiA==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
including the A527/T527 chips.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index ee485899ba0af69f32727a53de20051a2e31be1d..c3ba2146c4b45f72c2a5633ec434740d681a21fb 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -126,6 +126,17 @@ pio: pinctrl@2000000 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			emac0_pins: emac0-pins {
+				pins = "PH0", "PH1", "PH2", "PH3",
+					"PH4", "PH5", "PH6", "PH7",
+					"PH9", "PH10","PH13","PH14",
+					"PH15","PH16","PH17","PH18";
+				allwinner,pinmux = <5>;
+				function = "emac0";
+				drive-strength = <40>;
+				bias-pull-up;
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0" ,"PF1", "PF2", "PF3", "PF4", "PF5";
 				allwinner,pinmux = <2>;
@@ -409,6 +420,15 @@ i2c5: i2c@2503400 {
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
@@ -521,6 +541,28 @@ ohci1: usb@4200400 {
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
+			pinctrl-0 = <&emac0_pins>;
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


