Return-Path: <netdev+bounces-213196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 991AFB24197
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1803B1888DA7
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C70D2D46C3;
	Wed, 13 Aug 2025 06:33:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29502D3ECC;
	Wed, 13 Aug 2025 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066792; cv=none; b=YUPbDmcq/9P2xT14BOhTTEZGlYfAqLWrdd2nchSYWUn1Y6Oq3WOJwxekvqWYsZvmBCRK6X0C0XFNtVx3EWcXFsZev5PzS8k0y95+AWo4MkmsjYDugRYtOxyov2fmVx5dLyD5VnywH57qcxpdIvID+AjzJ6lcMtlJpGvS9xfistg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066792; c=relaxed/simple;
	bh=44z6JC/dYsisM9QTRjJb5WpZz82pj6uC2AOQl6oYHmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEFyvSKKM7dqMjUIh6pqFTEKMZTh8PYMbok52A2gJ1y4Z2act6MT2byT+xfdA929G+WJWoWWaE1xSS6X2FZecNAiCKoNNdUlEXN77znK7lZRz5O3cnW55UEVE4XBcCrsyg7E1YALTO+Hf7fS6YsRVD1M+WHgN+JizsMPhPfc4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 13 Aug
 2025 14:33:01 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 13 Aug 2025 14:33:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Po-Yu
 Chuang <ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<taoren@meta.com>, <bmc-sw2@aspeedtech.com>
Subject: [net-next v2 2/4] ARM: dts: aspeed-g6: Add ethernet alise and update MAC compatible
Date: Wed, 13 Aug 2025 14:32:59 +0800
Message-ID: <20250813063301.338851-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

For RGMII delay setting, the MAC0 and MAC1 use the SCU0x340 to configure
the RGMII delay. We use the ethernet alise to identify the index of MAC.
And add the new compatible for MAC0/1 and MAC2/3 to calculate the
RGMII delay with different delay unit.
Finally, the RGMII delay of AST2600 is configured in SCU region and add
the scu phandle for configuration.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..6be17b18da46 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -40,6 +40,10 @@ aliases {
 		mdio1 = &mdio1;
 		mdio2 = &mdio2;
 		mdio3 = &mdio3;
+		ethernet0 = &mac0;
+		ethernet1 = &mac1;
+		ethernet2 = &mac2;
+		ethernet3 = &mac3;
 	};
 
 
@@ -232,34 +236,46 @@ mdio3: mdio@1e650018 {
 		};
 
 		mac0: ethernet@1e660000 {
-			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
+			compatible = "aspeed,ast2600-mac01",
+				     "aspeed,ast2600-mac",
+				     "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
+			scu = <&syscon>;
 			status = "disabled";
 		};
 
 		mac1: ethernet@1e680000 {
-			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
+			compatible = "aspeed,ast2600-mac01",
+				     "aspeed,ast2600-mac",
+				     "faraday,ftgmac100";
 			reg = <0x1e680000 0x180>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
+			scu = <&syscon>;
 			status = "disabled";
 		};
 
 		mac2: ethernet@1e670000 {
-			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
+			compatible = "aspeed,ast2600-mac23",
+				     "aspeed,ast2600-mac",
+				     "faraday,ftgmac100";
 			reg = <0x1e670000 0x180>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>;
+			scu = <&syscon>;
 			status = "disabled";
 		};
 
 		mac3: ethernet@1e690000 {
-			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
+			compatible = "aspeed,ast2600-mac23",
+				     "aspeed,ast2600-mac",
+				     "faraday,ftgmac100";
 			reg = <0x1e690000 0x180>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>;
+			scu = <&syscon>;
 			status = "disabled";
 		};
 
-- 
2.43.0


