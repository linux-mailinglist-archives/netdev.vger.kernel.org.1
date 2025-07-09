Return-Path: <netdev+bounces-205289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA31CAFE0F9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465EE585ACC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 07:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E30E27380D;
	Wed,  9 Jul 2025 07:08:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC162727E4;
	Wed,  9 Jul 2025 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044908; cv=none; b=djh+AnePwxJChDWnhMvZe6Mkrn1xX7ezo2DGcDZ0xJiszeIy2oJuhBPMUg8qKUbgS3EvQgYp3SHow2mY25BCQZWfT0h3nXEolabV+QmjPuhjVfVLpHmrBjqk5psxKYG121gDdrQbDVjPraL+FtUITrApdGPBKJXXu0yK5vppAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044908; c=relaxed/simple;
	bh=niTQfAe3mnitW8DHBUFf0G5gpxM1At2/3CYLdrDk0MA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7i2XKEcRVxu91vKuuB+ycDv2G+7Zd/3fGxJBA56jPoJUWdyVp+/p/Q/ZYtly5YFO8hDejeSy/gGg4RbSTVeSRQTRhhKkRAUzoH/CIqoYvRqatZte5Q96Mcp4pqw1JCFUF2yR/uf2d2vZ5DTf9JY5vnKzBS0QvGWtKYHr5ZVkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 9 Jul
 2025 15:08:09 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 9 Jul 2025 15:08:09 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
	<u.kleine-koenig@baylibre.com>, <hkallweit1@gmail.com>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next v4 3/4] ARM: dts: aspeed-g6: Add resets property for MAC controllers
Date: Wed, 9 Jul 2025 15:08:08 +0800
Message-ID: <20250709070809.2560688-4-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
References: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the "resets" property to the MAC nodes in the AST2600 device tree,
using the appropriate ASPEED_RESET_MACx definitions.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..f9fe89665e49 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -236,6 +236,7 @@ mac0: ethernet@1e660000 {
 			reg = <0x1e660000 0x180>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
+			resets = <&syscon ASPEED_RESET_MAC1>;
 			status = "disabled";
 		};
 
@@ -244,6 +245,7 @@ mac1: ethernet@1e680000 {
 			reg = <0x1e680000 0x180>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
+			resets = <&syscon ASPEED_RESET_MAC2>;
 			status = "disabled";
 		};
 
@@ -252,6 +254,7 @@ mac2: ethernet@1e670000 {
 			reg = <0x1e670000 0x180>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>;
+			resets = <&syscon ASPEED_RESET_MAC3>;
 			status = "disabled";
 		};
 
@@ -260,6 +263,7 @@ mac3: ethernet@1e690000 {
 			reg = <0x1e690000 0x180>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>;
+			resets = <&syscon ASPEED_RESET_MAC4>;
 			status = "disabled";
 		};
 
-- 
2.34.1


