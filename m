Return-Path: <netdev+bounces-178639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ADDA7803F
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1437D3B3707
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA12214A71;
	Tue,  1 Apr 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t2W+rIeS"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032762139C8;
	Tue,  1 Apr 2025 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524011; cv=none; b=ZB5BSPHbJHPWCawvnHXAGeahTpuLwMYyKZkbrZu00lyGX5+RPh8l3F2cWnRRW+4kHjmH+npAZdIsATLPMv5Bb3GSASg3uZrsDQT+GUjdWEOAKIF1Kh88CG+HBXxYsntTYwhnFdrBlkTUZgyKu7iKuKNnZem9Oa+y9g4b2GZjUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524011; c=relaxed/simple;
	bh=R+dvFcKSVcqqUDpItH268Ej1pZUEkDrwiH4aY6Td5JY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxXUNXIlzMFc/MxV2ePGpvgIPQQA9ar7ij0+ac6vVoxOPRi7kU/7+E6h6to4mGg4NV0y08Woz/0ZH8FrIbZ12roO/15Pq3A1cetzMroPwMCpbwOclqjHLadF66DgGMssRMrp2TUnAssqMj6JdwzgHeGYQw59YAxrjmqszTCAe3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t2W+rIeS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743524009; x=1775060009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R+dvFcKSVcqqUDpItH268Ej1pZUEkDrwiH4aY6Td5JY=;
  b=t2W+rIeSrOB5+JvDtmQbkWYbXiB/XFwIEi2ppJcXsle6AKtpMwHx4gMr
   WP0gJZlp69NTPfaXY/oZMBOiUShoxs8K4FB056nNLhIVpnVPUWyTfdMjn
   jSgfp+mjiwEn7OtuBXVWG/wUQ14tLqLbDvwixaevR0Tt+QgPXJyZZwQuc
   Fwv32uE6vsp/GmuFwyoEyiQx9h83Ga5LKhvazOUvq664G/lw5VjguH6DI
   bHqjyq52KsrG+h5gz7eJUnBfi6XibqaXxVEqIAcV/kSAOKJSJM+ksOmTG
   I/jsT779UgZuclXvnJXIxxFf4R1D07sO1T2ihkmcOiuhESINg26/uVQPO
   g==;
X-CSE-ConnectionGUID: ggLzNIpETriZ0zPViMY9HA==
X-CSE-MsgGUID: pl7XT+nXRGqhxAxzXvgSmQ==
X-IronPort-AV: E=Sophos;i="6.14,293,1736838000"; 
   d="scan'208";a="39512777"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 09:13:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 1 Apr 2025 09:13:01 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 1 Apr 2025 09:13:01 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <onor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <nicolas.ferre@microchip.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [PATCH 2/6] ARM: dts: microchip: sama7d65: Add gmac interfaces for sama7d65 SoC
Date: Tue, 1 Apr 2025 09:13:18 -0700
Message-ID: <05b107796b6f3a173d0dd0a5b2107b675cfd994e.1743523114.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743523114.git.Ryan.Wanner@microchip.com>
References: <cover.1743523114.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add support for GMAC interfaces on SAMA7D65 SoC.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index b6710ccd4c36..cd17b838e179 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -169,6 +169,38 @@ dma1: dma-controller@e1614000 {
 			status = "disabled";
 		};
 
+		gmac0: ethernet@e1618000 {
+			compatible = "microchip,sama7d65-gem", "microchip,sama7g5-gem";
+			reg = <0xe1618000 0x2000>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 46>, <&pmc PMC_TYPE_PERIPHERAL 46>, <&pmc PMC_TYPE_GCK 46>, <&pmc PMC_TYPE_GCK 49>;
+			clock-names = "pclk", "hclk", "tx_clk", "tsu_clk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 46>, <&pmc PMC_TYPE_GCK 49>;
+			assigned-clock-rates = <125000000>, <200000000>;
+			status = "disabled";
+		};
+
+		gmac1: ethernet@e161c000 {
+			compatible = "microchip,sama7d65-gem", "microchip,sama7g5-gem";
+			reg = <0xe161c000 0x2000>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 47>, <&pmc PMC_TYPE_PERIPHERAL 47>,<&pmc PMC_TYPE_GCK 47>, <&pmc PMC_TYPE_GCK 50>;
+			clock-names = "pclk", "hclk", "tx_clk", "tsu_clk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 47>, <&pmc PMC_TYPE_GCK 50>;
+			assigned-clock-rates = <125000000>, <200000000>;
+			status = "disabled";
+		};
+
 		pit64b0: timer@e1800000 {
 			compatible = "microchip,sama7d65-pit64b", "microchip,sam9x60-pit64b";
 			reg = <0xe1800000 0x100>;
-- 
2.43.0


