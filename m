Return-Path: <netdev+bounces-185166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B381A98C52
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DE216CCFD
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40227279912;
	Wed, 23 Apr 2025 14:04:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11D27933B;
	Wed, 23 Apr 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417074; cv=none; b=AU/+J0WNuDefKc3iqRnGvGJxYvZto8nI9hAVBp36VHj+hLa+V/wxWXtEX7dl80KmCmK9HX1si74vdQzair663XLMmcFhH4AxoDm67wtq8ZponPIkNDx6Y+PrvpW4PtjNnV4UKzz5QFfWAhMt1uspUyMM1/nhBckiDjDdLJ37p+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417074; c=relaxed/simple;
	bh=qSAuAQgQhfHavQWtk47cpAmLXoZ+J7eZQoz45D4TWXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBBbRzG/sGbwEEVNlivcKCtrAGz2VOCfceyUF9E9lEoSpsKrH2bnazDPcyt5JaO0LfPV2a/0r5WVqHsrjhZ4epwKLM3BiPGGPzVoBAnQbAzIeVBvHOlQ99NIc+J+scyx1tBCbE4nIiX1ssZRJb4e2VpdGiRBLwfb6ggQwmhLYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 18BF5343100;
	Wed, 23 Apr 2025 14:04:23 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 23 Apr 2025 22:03:25 +0800
Subject: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=qSAuAQgQhfHavQWtk47cpAmLXoZ+J7eZQoz45D4TWXA=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCPNG5vFfq6m2pNo7fNiwyZdlqqFu+q01jGGkS
 flwqEtfDcaJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAjzRl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277VUaD/46Kj92p9WGylgP3a
 wJUkJfq60kMBG8QMJYSIK94CyNGEaDTiFjkehLBOiMjK1y4CM1Yr6auiYL8DE5mPSjEjZLOw1gp
 7+V+lKUKhyjCE1xkszaFIKoyiv/BjIzrtmAycRvJuHDaRmx5CIUo/cz/h3UMHG5Sgk+ERyVDwGX
 X7AVJMgl73r19sn0TGYK7BjW4eM7FTwGCVhbS9rNom1ycFd54EzCHITztJiw8kVvUg4EVMF1KT1
 f3NnVWfIw6Qz/os/wFzw3C9gl4Ke6UADdxSvSaOf0fvEJPf56TgXkZyIhjeRadziaDfKG9qDa0F
 lQhb94tPK9N/Rg9vjcb7KGXnTqmmFFZ0c910wYhm517WpuKNGNCktGyx7yNGagcOKcak+u97PRL
 +K6n6Ub5sMGjWJcGFjQDpXXJ0pK4U7fcFS2OJ5xxeATgjXMQus2M73FZ8MZzSNYrDaUpiAq7w1D
 5b6ALD/AloErRtNZLXXaChv+M8vEg8plhq89ITqzeKTerYa1a94JlCf8ER9y+NQCPr2xgQJPGUy
 vMyuIszS/B5NcTkqT6ZugaEL2pM/NJDfXgkozMoXkZe6YGLmpkaMahM0JREwbGTCpKujAnZvM5X
 qoSt/VizNtXwVPBUGNDB/HcVfWICT9NXbDEZBp/PiTgF+IgvvxJ8C8KUn4KICfxrSQ1g==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

On Radxa A5E board, the EMAC0 connect to an external YT8531C PHY,
which features a 25MHz crystal, and using PH8 pin as PHY reset.

Tested on A5E board with schematic V1.20.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts
index 912e1bda974ce5f64c425e371357b1a78b7c13dd..b3399a28badb5172801e47b8a45d5b753fc56ef1 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-radxa-a5e.dts
@@ -54,6 +54,23 @@ &ehci1 {
 	status = "okay";
 };
 
+&emac0 {
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
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


