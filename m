Return-Path: <netdev+bounces-185480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A844A9A98F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9935A1533
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC3822156E;
	Thu, 24 Apr 2025 10:09:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6428221269;
	Thu, 24 Apr 2025 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489381; cv=none; b=p7WHVzJv5/AQ6dx5cEJ2kZFmT/s6NoHAsH81AwwRD0oF6CiIvgPUqvZERJmda7+xGNZkXPZmJ0oTEZUGJrMrFd2NjfP8w1nJYt924g9AqDZ1cCAYWOVE8hV1XswT6/UCdIOFUzAEE+rXGZNmP+/txSYKMiukFu3CjhlfOFOPOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489381; c=relaxed/simple;
	bh=RKVWNoW/OPZNLUo6Md5Le2uXVIoZfL3QhFErz0wvRIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxgEl/YEbLnhUJxVhWXaIOXBPrehInQJTmFdLrteecu8LnmIL68q7n5oNpAJwklcuALFdbzENkRK/MG6BBFzS/qaOh7mFhbZkrmB0RYldC5VuJ/sfQJubi9+e8If5vkRqHlIRvyOP5vo4bZ9cSHlnNk/VqqOJQlpP5AiDiQsZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id B9E32343024;
	Thu, 24 Apr 2025 10:09:33 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 24 Apr 2025 18:08:41 +0800
Subject: [PATCH v2 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-01-sun55i-emac0-v2-3-833f04d23e1d@gentoo.org>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
In-Reply-To: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2434; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=RKVWNoW/OPZNLUo6Md5Le2uXVIoZfL3QhFErz0wvRIo=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCg2/xzKeedJDhXhMphZajDEbW6588I6zgqoEF
 mNrLiGEXI+JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAoNv18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277fPaD/4yYF0TTJmsIYPCKe
 XWHdpCF8Q9ufOLO5ubuWAPsLFsGMBoDt74aehXctm8NoOm90sY+ZWUEXgkTWNKfIf5N545XDy+k
 39JWOsXsPUHS4pZxrrJwZjt3ww1V5e3GVCZLGB1O+UO8egWlNyTmo9ULITUz56cTwXKX1Ye+vuQ
 6A52lp4G+s3aRE3S3CPlrJnsnrOW2EoGXe6aGJSkSKD3oiRZavqKODfqZy/nR/c2g+mqLXPTvjs
 aZfiTysKd8O1jlOrCuvXPhqDJDlxJyFKXQmZ2zXKdlhDQieaSdj42EBaHjO4bVIyIncgbvo7pcs
 Iorez5MfBFaZ2tBmlFI7eCwklnmNNqGUE5i/B3ru/mtAbl2OOnRXBS2bpZP20nbF57MYI8xFMQe
 eDXqzC/Tjpw0fPqeXCO78QBd+wwFBjm0Xvd4FLdcf9PShFJsTi63hoNxxoMn9YgUYmvLBd7EmwB
 J9pMCFGyATSEYOTueoe/Q6fQEeagq/aekqgYlr6PJQN5fILmwROtro7O+b7E4RBSqvJXYm4DHvk
 /WQaB5yhjyfWSYXArQpEJdRrxKsJldfZWE0xEW47Hl3/Kp2/ENafPO5TDHIzanA4NqLfcu6mpzH
 eh05CRatNhqpx8CQryVqLK/PzuY9FjpWOza10vcIP5mfndoGwj5E+Z/hX7cnlUXN/Uvg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
including the A527/T527 chips. MAC0 is compatible to the A64 chip which
requires an external PHY. This patch only add RGMII pins for now.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index ee485899ba0af69f32727a53de20051a2e31be1d..c9a9b9dd479af05ba22fe9d783e32f6d61a74ef7 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -126,6 +126,15 @@ pio: pinctrl@2000000 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			rgmii0_pins: rgmii0-pins {
+				pins = "PH0", "PH1", "PH2", "PH3", "PH4",
+				       "PH5", "PH6", "PH7", "PH9", "PH10",
+				       "PH14", "PH15", "PH16", "PH17", "PH18";
+				allwinner,pinmux = <5>;
+				function = "emac0";
+				drive-strength = <40>;
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0" ,"PF1", "PF2", "PF3", "PF4", "PF5";
 				allwinner,pinmux = <2>;
@@ -409,6 +418,15 @@ i2c5: i2c@2503400 {
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
@@ -521,6 +539,28 @@ ohci1: usb@4200400 {
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


