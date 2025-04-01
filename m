Return-Path: <netdev+bounces-178642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ECCA78033
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEE118943E5
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898EE2253EF;
	Tue,  1 Apr 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RrewFXau"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59D8214A91;
	Tue,  1 Apr 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524013; cv=none; b=p+d+3Z3fzlDXi28Q1NfBO9A39ob4Oxy6ycMqSxy42/L2fQzgxK6YmtBthoyGs0LR4elJomFJRX0QD3Nh0hQErbTGGl4aVnGo/rWoxnOTb3AMuTCysFL34ubMJk4L24Mvq5QWDIVkzpWGf8nq14G2M4MdjK1ob2n7ZdGAoDXI1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524013; c=relaxed/simple;
	bh=pTaeXJ5bInDg+SC4wghPI6lAHGRDUz3yhZDRfxhw948=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4sTGkupA9mN5SdUxbZSYK73ef0oZ1CT/fdxgjCb43zuZT7mVzcQcRdEz80eCUKLUpB6c7OHOAD/1VYMtaJuFM/kuGOdzhGW1HANQds/TmCZyMkOAEEdbFpZ2S+FvvcuzbNpEiaXLOJPakTzP7Vc6kUSNXKu/jMDoff3wf+QjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RrewFXau; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743524011; x=1775060011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTaeXJ5bInDg+SC4wghPI6lAHGRDUz3yhZDRfxhw948=;
  b=RrewFXauehvBPV5t716gLVSAcEsFoUHURAznznkHBv3TAYCG25ZmAv3b
   FAyXUCyGk/d+grX0Y6KPa8gaictJvDjrnyVFVGzkwSBnsVWhAf2zlQkGu
   t9SPvULbtnQzGRBUNcwAi6Spx45t6jpGi3inpaTCKjKL0qM1EneCoVn+T
   Jc62ZIu2SfMrG95vt02Qi5Bid01tf2X+VeNHXJdgWOC5E2473E1hz2tg/
   LJ7p5Rtqwj6k7am/9Qg48QyqCHgqoxGjkFqsVFju6NJcfCjCEVqNI3+zZ
   qFf4f2Ip6BOfptx51DKR109wyDHkOawNzjqvCIEsB+6omLerdpifoBCu/
   w==;
X-CSE-ConnectionGUID: ggLzNIpETriZ0zPViMY9HA==
X-CSE-MsgGUID: wPZVl3ZNSCaFv+rOE6Hgjg==
X-IronPort-AV: E=Sophos;i="6.14,293,1736838000"; 
   d="scan'208";a="39512781"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 09:13:23 -0700
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
Subject: [PATCH 5/6] ARM: dts: microchip: sama7d65: Add MCP16502 to sama7d65 curiosity
Date: Tue, 1 Apr 2025 09:13:21 -0700
Message-ID: <60f6b7764227bb42c74404e8ca1388477183b7b5.1743523114.git.Ryan.Wanner@microchip.com>
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

Add MCP16502 to the sama7d65_curiosity board to control voltages in the
MPU. The device is connected to twi 10 interface

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../dts/microchip/at91-sama7d65_curiosity.dts | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
index 441370dbb4c2..81abc387112d 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
@@ -30,6 +30,15 @@ memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
 	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "5V_MAIN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
 };
 
 &dma0 {
@@ -99,6 +108,132 @@ channel@4 {
 			label = "VDDCPU";
 		};
 	};
+
+	pmic@5b {
+		compatible = "microchip,mcp16502";
+		reg = <0x5b>;
+		lvin-supply = <&reg_5v>;
+		pvin1-supply = <&reg_5v>;
+		pvin2-supply = <&reg_5v>;
+		pvin3-supply = <&reg_5v>;
+		pvin4-supply = <&reg_5v>;
+		status = "okay";
+
+		regulators {
+			vdd_3v3: VDD_IO {
+				regulator-name = "VDD_IO";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-mode = <4>;
+				};
+			};
+
+			vddioddr: VDD_DDR {
+				regulator-name = "VDD_DDR";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1350000>;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1350000>;
+					regulator-mode = <4>;
+				};
+			};
+
+			vddcore: VDD_CORE {
+				regulator-name = "VDD_CORE";
+				regulator-min-microvolt = <1050000>;
+				regulator-max-microvolt = <1050000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1050000>;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-mode = <4>;
+				};
+			};
+
+			vddcpu: VDD_OTHER {
+				regulator-name = "VDD_OTHER";
+				regulator-min-microvolt = <1050000>;
+				regulator-max-microvolt = <1250000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-ramp-delay = <3125>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1050000>;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-mode = <4>;
+				};
+			};
+
+			vldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-suspend-microvolt = <1800000>;
+					regulator-on-in-suspend;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3700000>;
+
+				regulator-state-standby {
+					regulator-suspend-microvolt = <1800000>;
+					regulator-on-in-suspend;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
 };
 
 &main_xtal {
-- 
2.43.0


