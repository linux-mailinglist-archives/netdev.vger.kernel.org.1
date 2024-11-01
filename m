Return-Path: <netdev+bounces-141055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279839B944B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD231C21881
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039761C5798;
	Fri,  1 Nov 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WUTyXX9K"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02361CBEB5;
	Fri,  1 Nov 2024 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474462; cv=none; b=CTBfyXow04vTxlXrQarUJrRgbDHmtQPoOYtx0Qqz42Eef2+SkZka/Z1wyeQIkq6HNVA8LUDcY2Zu+9ou1vuV6N2HrO8p+4u+z2yyj87uMTyyhEpH3urgexl8pg6yfXkbEg3ZhXpaenk20Wrpl32BznQfXfP+Z0QhVi6qRBgXGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474462; c=relaxed/simple;
	bh=/+TZMp3OuOQDQDtXHRy7fu88xK0qHPfQkGlXJfyTdTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S260G9B1ToPkXJTCZ28/FcsnTXkV9E02Il5KJfsF8lhZzSPMSddWHSsJg05uLNmZvoK4Hqy0HU2jq7dN0FD5EI0TdFuXL0OMMEnOPuyGrLuLUp1oHtsJs0Gqurj6HdKDlAXePFhKB+Rafy9vFum0acQ7CByAkGNvLbypuPBzaMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WUTyXX9K; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730474457;
	bh=/+TZMp3OuOQDQDtXHRy7fu88xK0qHPfQkGlXJfyTdTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WUTyXX9KAWFb3gX0LpNpPH6GX48WVZPnDO9ivRGy5nGMOGP4ZIBLd7lSW7KDolK+L
	 Bjsp1W/eLD4Fgi2GLyJfQMYOtyPgbKF8cTktz18YKwOaKxQ/+KRidryUZPVwyE1E8a
	 iRRyPWU23/+E2LZi+LAlUp3OuKz8tbqrDnRa8cf29cmCdM+MIpqJuGRSm6qRFyuU+K
	 URN5dZ1roRwUmx+adiOtj5sv9e6/3I6p++hW/5dmseozw/mPNnL+vzyxa6GhMCMsK5
	 WrqxyGzlj1z3MDGgkZPcMC6+hY0f3AYvKDQuklWwO1deJ9ggSvQx4nAWQN/jwDDfHB
	 tvh8D2Bc1mCqQ==
Received: from [192.168.1.214] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3445217E0F85;
	Fri,  1 Nov 2024 16:20:54 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 01 Nov 2024 11:20:26 -0400
Subject: [PATCH 4/4] arm64: dts: mediatek: Add mediatek,mac-wol-noninverted
 to ethernet nodes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241101-mediatek-mac-wol-noninverted-v1-4-75b81808717a@collabora.com>
References: <20241101-mediatek-mac-wol-noninverted-v1-0-75b81808717a@collabora.com>
In-Reply-To: <20241101-mediatek-mac-wol-noninverted-v1-0-75b81808717a@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Add the newly introduced and now required mediatek,mac-wol-noninverted
property to the dwmac ethernet nodes and invert the presence of the
mediatek,mac-wol property to make it align with the description on the
binding and maintain the current behavior.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts                   | 2 ++
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts                  | 2 ++
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts        | 2 +-
 arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts | 2 ++
 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts         | 2 +-
 5 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index c84c47c1352fba49d219fb8ace17a74953927fdc..09760a0784bfb59511ea64fb44b7aeb66326f81b 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -115,6 +115,8 @@ &eth {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&eth_default>;
 	pinctrl-1 = <&eth_sleep>;
+	mediatek,mac-wol-noninverted;
+	mediatek,mac-wol;
 	status = "okay";
 
 	mdio {
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 31d424b8fc7cedef65489392eb279b7fd2194a4a..f48baa0b7dcbb95816517b7e501d87e39ac63a2d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -109,6 +109,8 @@ &eth {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&eth_default_pins>;
 	pinctrl-1 = <&eth_sleep_pins>;
+	mediatek,mac-wol-noninverted;
+	mediatek,mac-wol;
 	status = "okay";
 
 	mdio {
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index 5f16fb82058056cf8cf6318c9fc373601bd6eb60..290fcdce1c9f49c475403fa4aa7a0911605d4abd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -177,7 +177,7 @@ &eth {
 	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
 	snps,reset-delays-us = <0 10000 10000>;
 	mediatek,tx-delay-ps = <2030>;
-	mediatek,mac-wol;
+	mediatek,mac-wol-noninverted;
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&eth_default_pins>;
 	pinctrl-1 = <&eth_sleep_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
index e2e75b8ff91880711c82f783c7ccbef4128b7ab4..ebd0deb4e9ec1d67182c7602203e4fa1a0fb1c0c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
@@ -271,6 +271,8 @@ &eth {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&eth_default_pins>;
 	pinctrl-1 = <&eth_sleep_pins>;
+	mediatek,mac-wol-noninverted;
+	mediatek,mac-wol;
 	status = "okay";
 
 	mdio {
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 14ec970c4e491fbd69bf2800639abf726d47589a..a541d4fb9621c55f789d55a1eb985030827b158b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -179,7 +179,7 @@ &eth {
 	pinctrl-0 = <&eth_default_pins>;
 	pinctrl-1 = <&eth_sleep_pins>;
 	mediatek,tx-delay-ps = <2030>;
-	mediatek,mac-wol;
+	mediatek,mac-wol-noninverted;
 	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
 	snps,reset-delays-us = <0 20000 100000>;
 	status = "okay";

-- 
2.47.0


