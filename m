Return-Path: <netdev+bounces-185167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2459A98C62
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370763B72DB
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C500127EC8B;
	Wed, 23 Apr 2025 14:04:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34E27E1BC;
	Wed, 23 Apr 2025 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417081; cv=none; b=oUR6VsP75+gtp2P+ZgQOUQNeAWU+hODmgYbQphSeSQiv+1JMJGpRP3bfLnLqee645FCOwyYgVr2u6C+13sEU5WjYFau+1BwUbK1BPe5iQzWD0vsAhGKQuZ4AKy9oxL/8dIJ2nRmoyCJEf8p8RwAB5XHdWQ/B4YCJdGd8eNhbj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417081; c=relaxed/simple;
	bh=M4BoCqHOzCogtKg+TanyAV3G2PPloVmiBgQFQOsTpKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jIn5jUgv8fzmP3vVeM91PoNSCbWxBnaogXzjQBQLXrNpP51lYG4hW6Vfr/FMg1KzYfNoAgerUMNnf6l8Yg/uRd+eMKImX+MZaDWfS49e8ftbo/mupyq354bjJZ86Vpiwu+BvDg+/sx66cxtM+HUmTNdfVeM7Z4uNSvEW9QwFATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id EF8843430DF;
	Wed, 23 Apr 2025 14:04:32 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 23 Apr 2025 22:03:26 +0800
Subject: [PATCH 5/5] arm64: dts: allwinner: t527: add EMAC0 to Avaoto-A1
 board
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-01-sun55i-emac0-v1-5-46ee4c855e0a@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=M4BoCqHOzCogtKg+TanyAV3G2PPloVmiBgQFQOsTpKc=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCPNJikiDFxOUjRYRat/2gcDcU/vJZBj8PEW6I
 iQ73O1J436JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAjzSV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277SYoD/421Qk44Q1Jus7V78
 qGm7OCd/RJkrPzvCpOHoJDYcTCHzrTRyO7tl8VxeN5a932xDcPVevZ8aha/TCrP/Bzcm/XNEouE
 4wjv6wRl3CTZKzTeWpDHTnQP39PxDk6GVUARB1LPmaKu58WtV2SZXsuj1/0LX3pWrLvPQP7se7e
 aOComIv4VVjwV9Ig/92thsQ9KLGkNKqb/aSheFRnMqxWlG1sW9qo39QtT7bjCv+BKFdZ21lBD6/
 3jJRJTFSlFJnwSDJ+gaA/YZpOosc9jrrYlGgTt8O59te51ZGzosG5phw5NJYgviOVQ8l5VZsoWY
 lHiMEHtxBjJcEuo6SG3u2SbnN93Pe8Kht0euT0g08nXl90vIqjk/WVifcz6LidlbVpJodqKJsZ/
 zYY802jn5jcm8Gp+BTvsIHcbx6jROTtWsJDaPnp1ryBltHHbHqEIlA6qpC3yUb3kkr0aOXbZXz5
 MVN/ONnW4tHBF5xdjoSEY95QcYlU0fqaCZ9+I+ogzj2Lq//3RX5AaYhBukK/Jji7H2Ce/bIPdAE
 qHu5rMkNzcNjSbBesBSuGE/TFttTGQostbY+8G/DLPfE7B63bCSzF5PpEUOR5XA1vIgi1SU+vUY
 xjezmq6zY4QSHVxk73iCHESfvvzSUvL/OZn7fdY9ItnEv1L+VvkgPTSZwwxsECXD49TQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

On Avaoto A1 board, the EMAC0 connect to an external RTL8211F-CG PHY,
which features a 25MHz crystal, and using PH8 pin as PHY reset.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
I don't own this board, only compose this patch according to the
schematics. Let me know if it works.
---
 arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index 85a546aecdbe149d6bad10327fca1fb7dafff6ad..23ab89c742c679fb274babbb0205f119eb2c9baa 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -64,6 +64,23 @@ &ehci1 {
 	status = "okay";
 };
 
+&emac0 {
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
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


