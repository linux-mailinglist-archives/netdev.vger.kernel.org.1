Return-Path: <netdev+bounces-213376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33200B24CAF
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4226D3B4A38
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994302FFDED;
	Wed, 13 Aug 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZ9gTHp8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A66B2FFDCB;
	Wed, 13 Aug 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096950; cv=none; b=DxNoJ2/nClzT36pNQ8wKGVLTlr+ky+jJSCKaJcAgf6Y1u+FuVL0dNK3sR23Yq/etDWDXOfrrcpdwU7pSjsr4s04enaoh7uY10cQfaE3kPWcZzg9GGmg4QHgqiCXCymtKFLxxLobfogHscn61zt81/tz5qVFQtcjJ4jwKnYFGFlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096950; c=relaxed/simple;
	bh=efhUDQe2jwo6mMDNsNwWZlvEPFGFYGTDZhRv4W8Y2gI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mln58W9kXyLwKsuMoRQPHnXxivtxmkEAVTbCokEH4yGF8mRSwIPzE4oPWFMx8XIU9G4tjJFhS/OvAwt45LdF6dX3B4R53L8vYFzjjKliQK/ZweZAs7QQmDN4/a+5/nvKDJnthm2f8mXUhLXNVBHPh/XR3HK0CM5MsWeh/NPfDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZ9gTHp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E748AC4CEF8;
	Wed, 13 Aug 2025 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096950;
	bh=efhUDQe2jwo6mMDNsNwWZlvEPFGFYGTDZhRv4W8Y2gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZ9gTHp8VjxKV0gtmhGBRwHECZQqSCBqWMAw6/AUvhnNoZjT2Dg6zwNsjY80VZ4j3
	 Ys99ZxZJJXj3mRgxEXZuU7A1ChzYtOV96zIqt4enqaN4iS3Wv8dFziiqu1jafO59OG
	 skRZNZTXsZnmPm01UO3NYJ4MhJqxlyN3DOlWxG3cQn22EfHXAUTXxvFbdGo5PMSuXa
	 8uO8Ct2Ap8oGfVw7EbuPn4KK/3A7gLBouRYeFXEIwVYRFqh5DxMvLivhmx1dyV8n8U
	 OVlCQf8Xl+NM3hYe7jLpx9Z/kSZ6iUtKIjg4LqF9wTJot801a4aKcQVqNnFWKwLkHf
	 2HXvv9XHT7a3w==
Received: by wens.tw (Postfix, from userid 1000)
	id 551005FF75; Wed, 13 Aug 2025 22:55:45 +0800 (CST)
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
Subject: [PATCH net-next v2 09/10] arm64: dts: allwinner: t527: avaota-a1: enable second Ethernet port
Date: Wed, 13 Aug 2025 22:55:39 +0800
Message-Id: <20250813145540.2577789-10-wens@kernel.org>
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

On the Avaota A1 board, the second Ethernet controller, aka the GMAC200,
is connected to a second external RTL8211F-CG PHY. The PHY uses an
external 25MHz crystal, and has the SoC's PJ16 pin connected to its
reset pin.

Enable the second Ethernet port. Also fix up the label for the existing
external PHY connected to the first Ethernet port.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v1:
- Switch to generic (tx|rx)-internal-delay-ps properties
---
 .../dts/allwinner/sun55i-t527-avaota-a1.dts   | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index e7713678208d..f540965ffaa4 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -13,6 +13,7 @@ / {
 
 	aliases {
 		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 		serial0 = &uart0;
 	};
 
@@ -67,7 +68,7 @@ &ehci1 {
 
 &gmac0 {
 	phy-mode = "rgmii-id";
-	phy-handle = <&ext_rgmii_phy>;
+	phy-handle = <&ext_rgmii0_phy>;
 	phy-supply = <&reg_dcdc4>;
 
 	allwinner,tx-delay-ps = <100>;
@@ -76,13 +77,24 @@ &gmac0 {
 	status = "okay";
 };
 
+&gmac1 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii1_phy>;
+	phy-supply = <&reg_dcdc4>;
+
+	tx-internal-delay-ps = <100>;
+	rx-internal-delay-ps = <100>;
+
+	status = "okay";
+};
+
 &gpu {
 	mali-supply = <&reg_dcdc2>;
 	status = "okay";
 };
 
 &mdio0 {
-	ext_rgmii_phy: ethernet-phy@1 {
+	ext_rgmii0_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
 		reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
@@ -91,6 +103,16 @@ ext_rgmii_phy: ethernet-phy@1 {
 	};
 };
 
+&mdio1 {
+	ext_rgmii1_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		reset-gpios = <&pio 9 16 GPIO_ACTIVE_LOW>; /* PJ16 */
+		reset-assert-us = <10000>;
+		reset-deassert-us = <150000>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo3>;
 	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
-- 
2.39.5


