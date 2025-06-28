Return-Path: <netdev+bounces-202122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A66AAEC53E
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 07:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28621C22E24
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 05:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF28220F4F;
	Sat, 28 Jun 2025 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX4bCDJD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E54220F32;
	Sat, 28 Jun 2025 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751089487; cv=none; b=WKdSwkr7NH7VqFnE98a0q9kr9ADbRdcGjioh+6ggtyK7xe8cAeE/gOlhNaGHG/SQ7L9pqRHPpcC0uwVRiGphQtQqojm+gJDhF48spwgeQrY7ybEzQnuJZJFpah3Jba19A7DjG7UeCTwgy2WJ7MokB2buObscH3F+1zwSg38VEzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751089487; c=relaxed/simple;
	bh=WKX6UPJG1JKK2C5l7RGoc2IVvdGkeOSZ82VyvukU8Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rbi5Cv+Gf0Exazq1aF4Vk9jde6+Lc6KBlhWdd3RmlMslzVH/El8Didt5FIhh8GnRY6g5uPjKjjpJASIGI/PulyIF57RdluHMHRIu0vt61tuM5cLuqTgHE2Wl4akTLAZgan+i/r3NzDm34wSWiJHj+6+BRY/OADGyDx8hVuTAp0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX4bCDJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16D3C4CEF4;
	Sat, 28 Jun 2025 05:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751089487;
	bh=WKX6UPJG1JKK2C5l7RGoc2IVvdGkeOSZ82VyvukU8Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mX4bCDJDLs0dK9C86qRB66iAJTv77tTOiAaMz6rER9I1XC3Wq4YXoi57TBk0/oCzS
	 o8ajQdLDEx0z7a40jaY4FXFFWhPGJVV+cN5dF5nmHlh8Qtu7h2p01DDthOgiyW8CCU
	 +uCqKyZKwTJoyMKJkvjo/Xkk5LXOruYPrfYOKDDcHOt18eIGQdPkSgqW/iz9DzLBJm
	 EdruJnU1YTHXUWC213Y7PyiuGgKJqCZf4yQYRkf0rkqeb2N6anfhOnI4jV0M+txMVQ
	 KHKHvEaC6Sr4mTJfjISFccfB71xlDNykXwqM+H0qlBb3r1FjqHA8KkFUxfYOVlGAbZ
	 Eyl/9f0sMusMg==
Received: by wens.tw (Postfix, from userid 1000)
	id 583A25FE35; Sat, 28 Jun 2025 13:44:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH net 2/2] arm64: dts: allwinner: a523: Rename emac0 to gmac0
Date: Sat, 28 Jun 2025 13:44:38 +0800
Message-Id: <20250628054438.2864220-3-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628054438.2864220-1-wens@kernel.org>
References: <20250628054438.2864220-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The datasheets refer to the first Ethernet controller as GMAC0, not
EMAC0.

Fix the compatible string, node label and pinmux function name to match
what the datasheets use. A change to the device tree binding is sent
separately.

Fixes: 56766ca6c4f6 ("arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC")
Fixes: acca163f3f51 ("arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E board")
Fixes: c6800f15998b ("arm64: dts: allwinner: t527: add EMAC0 to Avaota-A1 board")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi          | 6 +++---
 arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts | 4 ++--
 arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 8b7cbc2e78f5..51cd148f4227 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -131,7 +131,7 @@ rgmii0_pins: rgmii0-pins {
 				       "PH5", "PH6", "PH7", "PH9", "PH10",
 				       "PH14", "PH15", "PH16", "PH17", "PH18";
 				allwinner,pinmux = <5>;
-				function = "emac0";
+				function = "gmac0";
 				drive-strength = <40>;
 				bias-disable;
 			};
@@ -540,8 +540,8 @@ ohci1: usb@4200400 {
 			status = "disabled";
 		};
 
-		emac0: ethernet@4500000 {
-			compatible = "allwinner,sun55i-a523-emac0",
+		gmac0: ethernet@4500000 {
+			compatible = "allwinner,sun55i-a523-gmac0",
 				     "allwinner,sun50i-a64-emac";
 			reg = <0x04500000 0x10000>;
 			clocks = <&ccu CLK_BUS_EMAC0>;
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
index 0f58d92a6adc..8bc0f2c72a24 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
@@ -12,7 +12,7 @@ / {
 	compatible = "radxa,cubie-a5e", "allwinner,sun55i-a527";
 
 	aliases {
-		ethernet0 = &emac0;
+		ethernet0 = &gmac0;
 		serial0 = &uart0;
 	};
 
@@ -55,7 +55,7 @@ &ehci1 {
 	status = "okay";
 };
 
-&emac0 {
+&gmac0 {
 	phy-mode = "rgmii-id";
 	phy-handle = <&ext_rgmii_phy>;
 	phy-supply = <&reg_cldo3>;
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index 08127f0cdd35..142177c1f737 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -12,7 +12,7 @@ / {
 	compatible = "yuzukihd,avaota-a1", "allwinner,sun55i-t527";
 
 	aliases {
-		ethernet0 = &emac0;
+		ethernet0 = &gmac0;
 		serial0 = &uart0;
 	};
 
@@ -65,7 +65,7 @@ &ehci1 {
 	status = "okay";
 };
 
-&emac0 {
+&gmac0 {
 	phy-mode = "rgmii-id";
 	phy-handle = <&ext_rgmii_phy>;
 	phy-supply = <&reg_dcdc4>;
-- 
2.39.5


