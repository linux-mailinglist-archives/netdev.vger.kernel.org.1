Return-Path: <netdev+bounces-135831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C0A99F518
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2E31C23365
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B37422739D;
	Tue, 15 Oct 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jH4OoGPD"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E62122739B;
	Tue, 15 Oct 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016430; cv=none; b=efqtJclsLD80BniJNt+seEwj9m6FLAZB1TgK6V5j2UDhR/wBQgVMCbmiqyjBqH3OjONCFRbXAfxID/hbwAxLcErvZrLmUueWpFtvyGRhUNGMVmzWqOKyw4WzFlUyslwQAKb242W015chlBGpohfL4AmO3/3MQaRQNokwgdA2l4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016430; c=relaxed/simple;
	bh=E2gOs3UqePmkVJladD+DLQjs/f55bJHoGr84z8564Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j075ShwcO+u+JuWKhxZLRFIRg5TAzx1w7PSHNxhodITR+XnY835FoFRkduooqOgyCmhSIKH+xmtO/31C5e+LwKMPM9G8FuF5/jgFRU2dMjiUbEHltKx0N38Ik+38Nvln0mkHg2sQD2xTnKsPBHsIeAOgz2HjF87eC9RrSdo2/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jH4OoGPD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729016426;
	bh=E2gOs3UqePmkVJladD+DLQjs/f55bJHoGr84z8564Nc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jH4OoGPDk0aVyfiS/cLKMzw17XYyB94r8zru2XB5x1vumpgmLUYp43Uu08VsDvo+D
	 LvwnBCKHcXC3kWjR9iMaTMPFbllHPgOACPH8YrgLgvuNDr1XOSPEdGgcY2Xa43LCyz
	 KK+F37ETvJW4LX/Q3JKL4eKGntWxjo3fNxfel2FFT4r5HsWLUtUBw7hxsP8lnwXql+
	 OYdzdjJEtT1dSinjiYq6WhpdkEJbDEZu5Zhs1X+tddRLNE42yPx/euBRk6HXnuEQBU
	 wgJYTFAe9r3kVt7PqBbK/p1EZjTVVTumFHYih8mDCXdHU5BKPIPEiU1uZkyXH8txl0
	 6itdU6TIKv6kg==
Received: from [192.168.1.206] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AC39B17E369C;
	Tue, 15 Oct 2024 20:20:24 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 15 Oct 2024 14:15:02 -0400
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8390-genio-700-evk: Enable
 ethernet
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241015-genio700-eth-v1-2-16a1c9738cf4@collabora.com>
References: <20241015-genio700-eth-v1-0-16a1c9738cf4@collabora.com>
In-Reply-To: <20241015-genio700-eth-v1-0-16a1c9738cf4@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Jianguo Zhang <jianguo.zhang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Hsuan-Yu Lin <shane.lin@canonical.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>
X-Mailer: b4 0.14.2

Enable ethernet on the Genio 700 EVK board. It has been tested to work
with speeds up to 1000Gbps.

Signed-off-by: Jianguo Zhang <jianguo.zhang@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Hsuan-Yu Lin <shane.lin@canonical.com>
Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
Signed-off-by: fanyi zhang <fanyi.zhang@mediatek.com>
[Cleaned up to pass dtbs_check, follow DTS style guidelines, and split
between mt8188 and genio700 commits]
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
index 0a6c9871b41e5f913740e68853aea78bc33d02aa..73e34e98726d36785e8b2cef73f532b6bb07c97f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
@@ -24,6 +24,7 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &eth;
 	};
 
 	chosen {
@@ -845,6 +846,30 @@ pins-wifi-enable {
 	};
 };
 
+&eth {
+	phy-mode ="rgmii-rxid";
+	phy-handle = <&ethernet_phy0>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default_pins>;
+	pinctrl-1 = <&eth_sleep_pins>;
+	snps,reset-gpio = <&pio 147 GPIO_ACTIVE_HIGH>;
+	snps,reset-delays-us = <0 10000 10000>;
+	mediatek,tx-delay-ps = <2030>;
+	mediatek,mac-wol;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet_phy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-id001c.c916";
+			reg = <0x1>;
+		};
+	};
+};
+
 &pmic {
 	interrupt-parent = <&pio>;
 	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.47.0


