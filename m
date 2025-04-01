Return-Path: <netdev+bounces-178643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5337A7801C
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8FD07A2536
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35EA225A2D;
	Tue,  1 Apr 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MrU2hCPx"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5702253A5;
	Tue,  1 Apr 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524014; cv=none; b=BxuFHMUHBNed+Jpqj6EUK7pYzyJVBiktXddonl5Lj+iTOB6caxrevdEm+S9GN2E6qMslOkv2zsqe7iuAHJm5sdosyg7A9q7JESsmTqOvc1dZ8KGP3dOpLBTtHYNYnpHM7BZYMZbyKRDI5F2JVDkNIdmE64EvnOmvUba5FBCrp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524014; c=relaxed/simple;
	bh=u+o05G3JYoXGtiVP+5vJQeNhqzZa/lKtInVusu7G/70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdnFDlXe4o75hjacyuiW1aCgoMtq8gYS+FZQNR3+2MCbKcXPte6MC494VPF41j+UXqofMVziGdTbyZ6V6wHnDRMpmlua4XoBD/mb1D21jq3BmD9TwXkR/HTUfSIpMN2Ao6Oenm7i9wwRsTAHvALGcAamiReun1SsiFo8zbUhFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MrU2hCPx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743524013; x=1775060013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u+o05G3JYoXGtiVP+5vJQeNhqzZa/lKtInVusu7G/70=;
  b=MrU2hCPxB9h2RzwqxsbwjX2deGF4EruMQtwn68LKHCIFNat15n2At05i
   CLKoNBfodphnOXU5H/3dHSdFJLVxEyYzozF6IO5cIMaDQVXnS7bOJfgLK
   ETi206GzKkSnwmWZLClbXKLdrNg3kEpUV02noba29L7q0UWHjXsfjaJEG
   E5w4eAAg7Ds60snxqAOiiGwwZuqxFxPQipP9b06OaL5goar0UMg/NYTGs
   58EJ0TK56RfMYeDfhBNxvDQVE6YStQaFDClGmdhPhj/GtHGAk/E9/z1t+
   QEmdGkMKzkW3PdIeSLviL3v7gyP2/Txl6nY6uGYiIdFcJ1o9AVyRpdNOd
   Q==;
X-CSE-ConnectionGUID: ggLzNIpETriZ0zPViMY9HA==
X-CSE-MsgGUID: 6MZwuanKTDGxweZifBIEXg==
X-IronPort-AV: E=Sophos;i="6.14,293,1736838000"; 
   d="scan'208";a="39512782"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 09:13:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 1 Apr 2025 09:13:02 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 1 Apr 2025 09:13:02 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <onor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <nicolas.ferre@microchip.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [PATCH 6/6] ARM: dts: microchip: sama7d65_curiosity: add EEPROM
Date: Tue, 1 Apr 2025 09:13:22 -0700
Message-ID: <96ee6832d9b55acfae8d3560f625798025dfd89c.1743523114.git.Ryan.Wanner@microchip.com>
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

If the MAC address is not fetched and loaded by U-boot then Linux will
have to load the address. The EEPROM and nvmem-layout to describe
EUI48 MAC address regions.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../dts/microchip/at91-sama7d65_curiosity.dts | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
index 81abc387112d..779412f04a11 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
@@ -234,6 +234,24 @@ regulator-state-mem {
 			};
 		};
 	};
+
+	eeprom0: eeprom@51 {
+		compatible = "microchip,24aa025e48";
+		reg = <0x51>;
+		size = <256>;
+		pagesize = <16>;
+		vcc-supply = <&vdd_3v3>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			eeprom0_eui48: eui48@fa {
+				reg = <0xfa 0x6>;
+			};
+		};
+	};
 };
 
 &main_xtal {
@@ -251,6 +269,9 @@ &pinctrl_gmac0_txck_default
 	phy-mode = "rgmii-id";
 	status = "okay";
 
+	nvmem-cells = <&eeprom0_eui48>;
+	nvmem-cell-names = "mac-address";
+
 	ethernet-phy@7 {
 		reg = <0x7>;
 		interrupt-parent = <&pioa>;
-- 
2.43.0


