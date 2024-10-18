Return-Path: <netdev+bounces-137051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CBC9A4228
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE321F21FDF
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED6D20262C;
	Fri, 18 Oct 2024 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I/Q1zbdJ"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4441FF60E;
	Fri, 18 Oct 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264761; cv=none; b=db6ogyMNxbIlwlyXuePFTZAAFOqpfjpJOseGflYHDKWnbsckBoq9wGY2er0maEy2qyEV/1IcqDW3N0bQ4NjOpjdB3nUTuAwni+cE+wU+uu8uGeh0MQV6p7McQgYdWZNNMk2Tqgdo9WWHOOfkXNgeT+uv6QOddePaTywSjHLkaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264761; c=relaxed/simple;
	bh=SxTw5Ce/pOnrjKwvBcbYJ7lzE+rssP9CUicVkJ98jZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEtmAMa/PceNxjVZ1e/5GLdb11lIDIhOL91Ht4SCBBTGEhs31iaffXORDKM2i57mSV6epdoHz01Jgo9LOFF5cIzjwXCptvSabeDmJxvspQ8464is65VypvJdt7V0Le5/iMoA3OOsi0L1YiXuvlv1L3NFtfLGussXsB0pxBTrtS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I/Q1zbdJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729264752;
	bh=SxTw5Ce/pOnrjKwvBcbYJ7lzE+rssP9CUicVkJ98jZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I/Q1zbdJ8AWzIFGD0LOOQFgW6ip2mU0szB6ZlEsOCRooFwWD5f2USaSlh6+s4RJYd
	 p8oomaAEBujBAbPDsLqMoPPTLD3QCx2+rb9e7gZX6xoH49E/HyvCq76sA63FO28kwf
	 KKFCyWfFYLtXi+BJw6fqpdemBEIYZ68E/IaqBFeJqwTpilMjypnG7csikHSeQldDzJ
	 VVTEtTx4PMubtB+KRV6bHIml1JPIiQu7a1CtBZGhn7H8LVsFJS81vg+s0LaQb8YFf1
	 z23nrIyaJm5EesCtsZ58Ds86Sd7Z8xjCStq6g6ccneKjyGiDbmzJjPeVTlynMAzBss
	 1G3AT+i2JeOmw==
Received: from [192.168.1.218] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2E0FE17E3630;
	Fri, 18 Oct 2024 17:19:09 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 18 Oct 2024 11:19:03 -0400
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8390-genio-700-evk: Enable
 ethernet
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241018-genio700-eth-v2-2-f3c73b85507b@collabora.com>
References: <20241018-genio700-eth-v2-0-f3c73b85507b@collabora.com>
In-Reply-To: <20241018-genio700-eth-v2-0-f3c73b85507b@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Jianguo Zhang <jianguo.zhang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Hsuan-Yu Lin <shane.lin@canonical.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>
X-Mailer: b4 0.14.2

Enable ethernet on the Genio 700 EVK board. It has been tested to work
with speeds up to 1000Mbps.

Signed-off-by: Jianguo Zhang <jianguo.zhang@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Hsuan-Yu Lin <shane.lin@canonical.com>
Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
Signed-off-by: fanyi zhang <fanyi.zhang@mediatek.com>
[Cleaned up to pass dtbs_check, follow DTS style guidelines, and split
between mt8188 and genio700 commits, and addressed further feedback from
the mailing list]
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
index 0a6c9871b41e5f913740e68853aea78bc33d02aa..a063c7504cce08707a308b72559f2425eee515e1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
@@ -24,6 +24,7 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &eth;
 	};
 
 	chosen {
@@ -845,6 +846,25 @@ pins-wifi-enable {
 	};
 };
 
+&eth {
+	phy-mode ="rgmii-id";
+	phy-handle = <&ethernet_phy0>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default_pins>;
+	pinctrl-1 = <&eth_sleep_pins>;
+	mediatek,mac-wol;
+	snps,reset-gpio = <&pio 147 GPIO_ACTIVE_HIGH>;
+	snps,reset-delays-us = <0 10000 10000>;
+	status = "okay";
+};
+
+&eth_mdio {
+	ethernet_phy0: ethernet-phy@1 {
+		compatible = "ethernet-phy-id001c.c916";
+		reg = <0x1>;
+	};
+};
+
 &pmic {
 	interrupt-parent = <&pio>;
 	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.47.0


