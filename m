Return-Path: <netdev+bounces-141053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E61149B9445
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA2C1F23E8E
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88891C9EBA;
	Fri,  1 Nov 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DiBWY3Br"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747B71C7610;
	Fri,  1 Nov 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474457; cv=none; b=J0HRsmbUSv+FkWR5sRPkUhTbsXvXnNkVbF7fjEXDYtLI4FUqfa1Ji3S+mjODSj1YTJhAdROSexS7R1/R98tLW2EOaz47zSIdVleJfQS59HRIT9p7q8RkM8ib/9AsZ6oXPozMLYXqlADNd01a+erZ2xkIA8bictkJP1bsevtgH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474457; c=relaxed/simple;
	bh=imjx57/ZNDvazS8dVSDsfcbujxW4jgOS5y+0Xj27b1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+Kp0K3RxJYno1mwdngjteVdTC+jVHN6Tgcpwk91mE4+8nhZQ/9lsSuYJ+U5TttemRxrrF2yXjVDsoaKVIHblwYoY6T2BFs2OyWL3/H9+ENwHhjBQVnCM5+2t7dKlNGEXFHUsjLe0hglKO/rkLWwxA3H3QOaUCeLG/FbW8hShZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DiBWY3Br; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730474453;
	bh=imjx57/ZNDvazS8dVSDsfcbujxW4jgOS5y+0Xj27b1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DiBWY3Br+WMtuY8iHqw8X2uxfL+66oWWU8GtKeAy2gbK9E7WgzgFDyCdlVPqXRahh
	 wsLR1PzWqIEJCnRNsOLYWBKjy+/Nzvl6rIfEsqnhQO0wJ0lq1lgE6Z0HCouukObrzx
	 RsqEADhTxwBQSiCVgtm7XOT3ylgGKepVoPj3r+kfbRoUJEGzAFtUIU/JtveSJly0NE
	 BVL6+a3pClOQ5YD1593UGMxHnNlBj4cGaG56cOFf09Fi97SRJo8MQpJ7g1e3RpDGbB
	 z1DMWorJ3JFuv0X0oPbsoAGMne1/kKUoijmm6nHL8s5XG7S1H7QrbqXZ5kncWFz6eU
	 JkjolR5twN8mA==
Received: from [192.168.1.214] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 06B0D17E0F83;
	Fri,  1 Nov 2024 16:20:50 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 01 Nov 2024 11:20:25 -0400
Subject: [PATCH 3/4] arm64: dts: mediatek: mt8390-genio-700-evk: Enable
 ethernet MAC WOL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241101-mediatek-mac-wol-noninverted-v1-3-75b81808717a@collabora.com>
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

Add the mediatek,mac-wol-noninverted property to the ethernet node to
make the driver parse the mediatek,mac-wol property as originally
intended: enabling the MAC WOL. This gets WOL working on the Genio 700
EVK board.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
index 13f2e0e3fa8ab6679f843693230b9661d323a705..83c10517458d1df2f14e41baeff628f46ded1618 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
@@ -898,6 +898,7 @@ &eth {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&eth_default_pins>;
 	pinctrl-1 = <&eth_sleep_pins>;
+	mediatek,mac-wol-noninverted;
 	mediatek,mac-wol;
 	snps,reset-gpio = <&pio 147 GPIO_ACTIVE_HIGH>;
 	snps,reset-delays-us = <0 10000 10000>;

-- 
2.47.0


