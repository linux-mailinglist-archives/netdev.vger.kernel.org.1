Return-Path: <netdev+bounces-185481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50388A9A995
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B15616FADE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81AF225414;
	Thu, 24 Apr 2025 10:09:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E90221DB2;
	Thu, 24 Apr 2025 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489387; cv=none; b=qi/ouIXiHV1B+CFc5PUabSLyp7yJknE+YhVosfx98SfWvfnv5ZEZlGPc0yobPhZeLHUZaTA/EymLRCTDxpab7laebOat+BXHmZ6dkukydFymwgikxzEsnmxPd/G3oeIfOk/ztBLyyQhEcYcBfF3qaKlzjFvE/To91740Sbo/xEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489387; c=relaxed/simple;
	bh=+NlsYWBT81OiKiPSY+YWQO3B5u/NpVPaPxCCQFXhMuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkfD/8eWZ0KQjbNJZB2NlALHW4oqw0POQH+23EBUo9Tj0zthlQ0CK9ehKlebjt+Cf5bEJ6JrrUBYU/QYqSECHkXGUyu8azuXiJf/3eGNAEL4DJTACV+Xrmr4RXG1NplhoOFmqT9gKG7kVafCOagYrohg6DWMcRVXx8eu225s0Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 77E40343016;
	Thu, 24 Apr 2025 10:09:40 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 24 Apr 2025 18:08:42 +0800
Subject: [PATCH v2 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-01-sun55i-emac0-v2-4-833f04d23e1d@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=+NlsYWBT81OiKiPSY+YWQO3B5u/NpVPaPxCCQFXhMuU=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCg3DeFF+Lod5Sp4RF40iamQgTlUVUaHaoQ8RN
 NdermzD1/CJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAoNw18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277eLND/9ysWatZ1XvVsDrzi
 lC4N7NPUNozYOG7M2jBPgSJ6LmyzMG/VbCrpp/tI5sAAeZntM910Kdi4Jh2e4Ywml5ocAihIPRH
 dnyn166K75K8W/X9ouYXBxnLIm8xNLC5SinPbwisXjgglAre9u9KKpIJAveifvU2k6/0l4Wjdxg
 4JCVNRf55Wc5E/eNR3FEQSnMwvP3nSgKRBhaTqdeqpV1FNvTeF+u9pKFkxsa/4KF12LxcAer/SL
 cHM1ji9JXFnKXzJEC8e4K0b33ymwKMLnNVgHyVnGTjhmRBJDAJtI3VZ42bDmwLGHLmZRdMlOYoQ
 eM5mZNoGvILg+/HO1vV+5byj48sr6JJzbjGN8SVq9IA2bJ3vjHfhWqWNLgasPb8EVXpj+YGTvhF
 6/MIqFG9JYhewYyklri4rqEo3Fx9anPVR7WujXH/fLT8ffXH+A/u1NQpP6RcHaL6Uvb3DBL2vdK
 TqVXRMeHXnRwJyHtylpk8pvTNXYoOGJxlE4uoVAbdXem1727d5jYXFRlYDjylQrSrRDfJ6oX5Qr
 OSRdQ0o3kCxDenoj1iOoKcfFDeVfec3Q4tqRKApeYRargtxXN1spG5GSX8eh4APmlK80Wg39+nb
 P/oS3PF9heMj5bYB95cOQnxo9eztBD2MoIoq7JhJIn4nWod1pIiG9KaDmP280GSe52Wg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

On Radxa A5E board, the EMAC0 connect to an external YT8531C PHY,
which features a 25MHz crystal, and using PH8 pin as PHY reset.

Tested on A5E board with schematic V1.20.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 .../boot/dts/allwinner/sun55i-a527-radxa-a5e.dts      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts
index 912e1bda974ce5f64c425e371357b1a78b7c13dd..4ba01ea6f0db793b08fb0645226126535d91c43b 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts
@@ -12,6 +12,7 @@ / {
 	compatible = "radxa,cubie-a5e", "allwinner,sun55i-a527";
 
 	aliases {
+		ethernet0 = &emac0;
 		serial0 = &uart0;
 	};
 
@@ -54,6 +55,24 @@ &ehci1 {
 	status = "okay";
 };
 
+&emac0 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_cldo3>;
+
+	allwinner,tx-delay-ps = <300>;
+	allwinner,rx-delay-ps = <400>;
+
+	status = "okay";
+};
+
+&mdio0 {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo3>;
 	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_DOWN)>; /* PF6 */

-- 
2.49.0


