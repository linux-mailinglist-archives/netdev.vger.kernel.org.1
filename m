Return-Path: <netdev+bounces-237149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5004C46278
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD221881995
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579630AAC1;
	Mon, 10 Nov 2025 11:10:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC90309DCB;
	Mon, 10 Nov 2025 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773012; cv=none; b=sZZxtBdERHjRNDXQk7voe6TVwd+lFh+AtZAyudTzRVAl6l/eYmgDTvj/MKSt1VWmWS//cr4aMHpuA0Od/8De8Es4P7aueEUcGIiomygardYV7zYx0ypYkKRu804q4xgzIQqXFRS96dLuHoM3cf2HiXmU818QAc7HDzlh/S17szs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773012; c=relaxed/simple;
	bh=Ucy3rhfxQTjHXt1MgABc4IxBLFYdHjTHFrycXzSTtU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y3ZmJPdGAYsW4QdtXK/rlvuhC3D9fNRRdOkFOTJ2SC7hW3wkl6w44xs85REv6NEbG6Lh/d8MyrefYnV808RfBbGOuzQll9vp5N0K0ZlNh7YuPTryA30bJvO6mL4rT9Y3lKzIDI+oJy7cPcXAyj1ueftUorn/JwB1RdQXNM/X5oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 10 Nov
 2025 19:09:56 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 10 Nov 2025 19:09:56 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 10 Nov 2025 19:09:26 +0800
Subject: [PATCH net-next v4 2/4] ARM: dts: aspeed-g6: Add scu and rgmii
 delay value per step for MAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251110-rgmii_delay_2600-v4-2-5cad32c766f7@aspeedtech.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
In-Reply-To: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762772996; l=1849;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=Ucy3rhfxQTjHXt1MgABc4IxBLFYdHjTHFrycXzSTtU8=;
 b=llLXoEPg+i9Q5ddiJeB8AraApg6XuBFJzIozUdNkWWm6HsLi+kGPbYzew6CQkYJPUPYh/IbIm
 ZHJsiTy/9TRCDR0xy27GU0Eclc97RWjr/9tXuqX/LUNL0eEoDHMf5u8
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The RGMII delay is configured in SCU region in Aspeed AST2600,
therefore, add aspeed,scu property in dtsi for rgmii delay.
And the RGMII delay value in each MAC is different.
List below:
MAC0 and MAC1 -> 45 ps
MAC2 and MAC3 -> 250 ps
Add "aspeed,rgmii-delay-ps" property for each MAC to specify the
corresponding delay value.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index f8662c8ac089..2c71e691c547 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -236,6 +236,8 @@ mac0: ethernet@1e660000 {
 			reg = <0x1e660000 0x180>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
+			aspeed,scu = <&syscon>;
+			aspeed,rgmii-delay-ps = <45>;
 			status = "disabled";
 		};
 
@@ -244,6 +246,8 @@ mac1: ethernet@1e680000 {
 			reg = <0x1e680000 0x180>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
+			aspeed,scu = <&syscon>;
+			aspeed,rgmii-delay-ps = <45>;
 			status = "disabled";
 		};
 
@@ -252,6 +256,8 @@ mac2: ethernet@1e670000 {
 			reg = <0x1e670000 0x180>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>;
+			aspeed,scu = <&syscon>;
+			aspeed,rgmii-delay-ps = <250>;
 			status = "disabled";
 		};
 
@@ -260,6 +266,8 @@ mac3: ethernet@1e690000 {
 			reg = <0x1e690000 0x180>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>;
+			aspeed,scu = <&syscon>;
+			aspeed,rgmii-delay-ps = <250>;
 			status = "disabled";
 		};
 

-- 
2.34.1


