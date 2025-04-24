Return-Path: <netdev+bounces-185482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425A1A9A998
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D914671A1
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E691D221FAD;
	Thu, 24 Apr 2025 10:09:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF68221725;
	Thu, 24 Apr 2025 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489393; cv=none; b=hYPECUl3nYSb9xDpaAOa9eCwDIExHyeyDyaBlMnCWV2YjvNCDzT1lssM5PwY6Cab/H3MVn17nRYfK6b/Lrkj2nCG0DYmTuH4hPXMk5THFmEs1VQKS0b1Qah0QTskL4v0NG14w+08HkeiWEgAHTmzjcwvIJe9AtOsRZsVvPDeUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489393; c=relaxed/simple;
	bh=KQtVVkxqKgq++RrOtQPY3AP4zXz78fWySFRMQ+WV2cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hx90Rt32O555ZT23GtXM0j2koK/jRkmwy9vBSS4tOap6GVLZQaypw4VsaO06vFlQUbFU2S3m9L4UvLNMKczTLJG3wj5CSnOixsKQPD6NC33msdHZ336idGAiTokxtBlC7+fJpxuwo8V+cyD5cOrIZqmx45Kww6mK+qOevVYZztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id AF62B343027;
	Thu, 24 Apr 2025 10:09:46 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 24 Apr 2025 18:08:43 +0800
Subject: [PATCH v2 5/5] arm64: dts: allwinner: t527: add EMAC0 to Avaota-A1
 board
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-01-sun55i-emac0-v2-5-833f04d23e1d@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=KQtVVkxqKgq++RrOtQPY3AP4zXz78fWySFRMQ+WV2cw=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCg3GHd+62qSSkn94thh/HAXXXHgj44BYpE48o
 WutGzlFxRWJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAoNxl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277Ql5EACOHBo/C7Rx5AnIKo
 rr3Dalwn3ZiZLtEdQV1KWZJaG/9ESoBa05BjqyasPxKW7WgBAdDhtbpSr/mGRIA6lniNriFwG/x
 eqgCzGgo7uLlMTW7zkkWqksyGjHP7VrBg+6ive3c79XSPwtRdCkwIkzHP0JYLsA76ulS0OV9scQ
 XGUIBwuXq7KeNwDbxYj9jVbbDANgtQTUwZbRbt4KfFTaD38YxBCJ3K6efrbAauTSVSYo47YXFda
 Poax1LpDBHeYIOaHQk0yapKDKCB1YI3/bKm6TVWdgqOTtAD2L93lLg9lRM5q63qDbJGaG1f7Wat
 xU99G7BLllfXr4yCsnhL+dmESQ9Ejr7Uc8lV0OERG+HH0YW1/syji49ZoVCeM3WBOq4wp7g84mq
 Z+mePEiFTiWD4FLP3gMR5EU9t5i71fpGsYj9GsfGxBrzdaz00sho1gIaerU/3bIoPx2KhwOUMOJ
 Inf3lGdKIoiBPqkfTRTE8rZ6Y0xdQzIgsGlYjApWh3kWs14BcAs/LJtHfqboNpWeaOW8nqZPZ1Y
 QZehZ8wIapGvcipCGCYQLZP18tYQH2Y/7KphyMa69i02B38UudA/3l3MzA+GpcwVWJxz55o9bK+
 1GugbzP1B+yzyv1pxl+P3myxpIUlNHmDJKzkygjMFn8seXhTBrZGWolU6ItWJTIHlPvA==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

On Avaota A1 board, the EMAC0 connect to an external RTL8211F-CG PHY,
which features a 25MHz crystal, and using PH8 pin as PHY reset.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
I don't own this board, only compose this patch according to the
schematics. Let me know if it works.
---
 .../boot/dts/allwinner/sun55i-t527-avaota-a1.dts      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index 85a546aecdbe149d6bad10327fca1fb7dafff6ad..4524a195e86d20089cc35610495424ed2dec7e95 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -12,6 +12,7 @@ / {
 	compatible = "yuzukihd,avaota-a1", "allwinner,sun55i-t527";
 
 	aliases {
+		ethernet0 = &emac0;
 		serial0 = &uart0;
 	};
 
@@ -64,6 +65,24 @@ &ehci1 {
 	status = "okay";
 };
 
+&emac0 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_dcdc4>;
+
+	allwinner,tx-delay-ps = <100>;
+	allwinner,rx-delay-ps = <300>;
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


