Return-Path: <netdev+bounces-186948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E5EAA4275
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 07:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCAD1C01186
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 05:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31261E32C3;
	Wed, 30 Apr 2025 05:33:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C71E2853;
	Wed, 30 Apr 2025 05:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745991191; cv=none; b=HxfaVGzsZbumtEwQehAYTjChVHHWt7nUT5x3fVVLd4juQ1N7J1D1YpRbyamwjI2C+4b+tuZQBZRmbZXvVJUzEp98jRQf4PjspGIehSz2Labtl+wlQB+3XfzrjPMamOsrYNWV1VJT4cRPzZc7ornEjWr75a2xDYaddwWqeXHyyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745991191; c=relaxed/simple;
	bh=+xnhPAiqUtLKUq/HZ9jywkOy5GBJ0Z23GSWcCzDUBKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kd7JhxJZDnmEcQP/ApqKhTFplT/ogxjtsB+4mB3g0/pnSJEsMIvJEjo/gUQG4BpEUcpMkG1NNFTweT3U841ifm9da8ZsiYKOtSby9N/dyLkg+05qFYhjsSrTmoj+0AkX1QuMd+OxGiXiW09iW4mkoFSvgQxlxWJobOHJzLhscqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.147.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 5BB0C342FEF;
	Wed, 30 Apr 2025 05:33:03 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 30 Apr 2025 13:32:06 +0800
Subject: [PATCH v3 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-01-sun55i-emac0-v3-4-6fc000bbccbd@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1419; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=+xnhPAiqUtLKUq/HZ9jywkOy5GBJ0Z23GSWcCzDUBKg=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoEbXuUxfH+H4Pdw6T4crbCWAQ7c2I9Em8iiyCV
 ht13AZULYGJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaBG17l8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277V32D/4mG88MeMRBinBzvh
 15g2QUaZ71AZ2IKdE2xgRx/dvRrKhNwiw33uvozsePf5V+YBKFzvTpa413EbZL1Ey2kF1CQjkLA
 vRKJusKl9g3mC1KYGDWoTyGz3UUL20DIvfCNeutNfy348BU3yvqL7XrEww86RR9/aJKXFnJwOHx
 7zrzVJxGQ5b0/EwQ6nXEfBT878mPhvh1+VX8utCIvHZ7oLrn1oxQ4kxs7R+Qckb0TaXxguSjIIK
 NBaD26rLsECB2FNMuCdCKaczIisapmQGmV8Qb6Ozi03zQE98qq64FF0ZfwtAdpW4cdGLq8otkC0
 nHY00IPa7jswXdqNPyC4JztVzf6FBRGzE69d02+AuelQyMeiELuRzrXpwAmsOossm0yOAvlc49d
 mW7kqTdR3rYobn7hSmXr9MCHH47cbUsGot9LIft5FMTyxTU4XIF1cqDnOtdEgxDb0wFV/nfCC2S
 ywryVl02zgCY+fYjmmdOXFQMavFpRAVSrVtVkQQpE3c85SzHfFvabMUjgcnQAiaJ5hAhdlcUiof
 bju0CpULaSrTIrH80bMwLxl46fozfm58Xl/iY3fKJQZekVUikBurpQwGQexVIvTzD3RyoiP1R8r
 IJcEr0FPfJ4BaqDae9CE9I6SEhzrVHFk/4GDw5r2zvetJZz8kjyP3mDbfnIxew5g9Wew==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

On Radxa A5E board, the EMAC0 connect to external Maxio MAE0621A PHY,
which features a 25MHz crystal, and using PH8 pin as PHY reset.

Tested on A5E board with schematic V1.20.

Tested-by: Corentin LABBE <clabbe.montjoie@gmail.com>
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


