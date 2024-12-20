Return-Path: <netdev+bounces-153694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791079F939E
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918CB16A35D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43D218ADA;
	Fri, 20 Dec 2024 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="grVb1zSk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646021882E;
	Fri, 20 Dec 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702579; cv=none; b=qxi8FCyIIgdOZl7dtLxWJ9OgatucNYZu6sQxnUfbqCn7R7sHj+75beJ8JR8WNp4blnoC5s7JMmQXb/rBaiwvTeaM9MEZ2OwRzbS6zMMG6iAfpQqHoKln9kA5b2bo0dsath7Vx7U77ihPyngbkHvgo/AeEn//YCSE14SKjfYMFRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702579; c=relaxed/simple;
	bh=iFIKBuaX2mekJngBXlf1TEhW4Nar5nrkSSL+7DB2txI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Kcan0nJ7ixxpsIQcO34pZW2M/kdhH0aNtnd1U6zvWhy+tFk3qjp3wnzCdY5we1mygAac76qBh6/H6Mfdr+ySG02Bl2dqssh4N8ggFEdpClKF5tlDmMGZPwhoYQ5QnqiNLfh4oH+FxgtV/E0jM4yc7ei0kBKc1+AburRuvczWvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=grVb1zSk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734702578; x=1766238578;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iFIKBuaX2mekJngBXlf1TEhW4Nar5nrkSSL+7DB2txI=;
  b=grVb1zSkKZTiQRqrR3Fczz19yb0q9IzwPYnH90MksyJM0PfASbeaNfIs
   sMJbpIfLyd9U6cThq3liEEcSgRk6CqsD7tbzti0gn68fIeM3AeTK6UIii
   zxF9x/vEnBgLk93POE41IOXm+SrZxSrNjXdJ0FA1qx2MkSf7qVcx9oc76
   OCMLU1kwTQ3hLH502O84DOXpD+es5XITv5SkQboi2jJ0NYuo42OHHkBQS
   JyTz7IrHivTt7v3tTRHO33ddcDkVfnBMnyvcY2po/tcedGgJ3LInnmGbG
   OzK2FsyTSDes2+tLC/VRpKlKi64io0oEQ5ss1pDjctXB/nC9LmjPCRPSL
   g==;
X-CSE-ConnectionGUID: VjWhna/kQWqvw5X1MetOhw==
X-CSE-MsgGUID: SjbPQkcKTPagZzGXsMyGRQ==
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="36250028"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 06:49:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 06:49:14 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 06:49:11 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 20 Dec 2024 14:48:46 +0100
Subject: [PATCH net-next v5 7/9] net: lan969x: add RGMII registers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241220-sparx5-lan969x-switch-driver-4-v5-7-fa8ba5dff732@microchip.com>
References: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
In-Reply-To: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<robert.marko@sartura.hr>
X-Mailer: b4 0.14-dev

Configuration of RGMII is done by configuring the GPIO and clock
settings in the HSIOWRAP target, and configuring the RGMII port devices
in the DEVRGMII target. Both targets contain registers replicated for
the number of RGMII port devices, which is two.

Add said targets and register macros required to configure RGMII.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Tested-by: Robert Marko <robert.marko@sartura.hr>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   3 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 145 +++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
index 76f0c8635eb9..be49a99556fe 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
@@ -90,9 +90,12 @@ static const struct sparx5_main_io_resource lan969x_main_iomap[] =  {
 	{ TARGET_DEV2G5 + 27,         0x30d8000, 1 }, /* 0xe30d8000 */
 	{ TARGET_DEV10G +  9,         0x30dc000, 1 }, /* 0xe30dc000 */
 	{ TARGET_PCS10G_BR +  9,      0x30e0000, 1 }, /* 0xe30e0000 */
+	{ TARGET_DEVRGMII,            0x30e4000, 1 }, /* 0xe30e4000 */
+	{ TARGET_DEVRGMII +  1,       0x30e8000, 1 }, /* 0xe30e8000 */
 	{ TARGET_DSM,                 0x30ec000, 1 }, /* 0xe30ec000 */
 	{ TARGET_PORT_CONF,           0x30f0000, 1 }, /* 0xe30f0000 */
 	{ TARGET_ASM,                 0x3200000, 1 }, /* 0xe3200000 */
+	{ TARGET_HSIO_WRAP,           0x3408000, 1 }, /* 0xe3408000 */
 };
 
 static struct sparx5_sdlb_group lan969x_sdlb_groups[LAN969X_SDLB_GRP_CNT] = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index 561344f19062..d9ef4ef137b8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -37,6 +37,7 @@ enum sparx5_target {
 	TARGET_FDMA = 117,
 	TARGET_GCB = 118,
 	TARGET_HSCH = 119,
+	TARGET_HSIO_WRAP = 120,
 	TARGET_LRN = 122,
 	TARGET_PCEP = 129,
 	TARGET_PCS10G_BR = 132,
@@ -54,6 +55,7 @@ enum sparx5_target {
 	TARGET_VCAP_SUPER = 326,
 	TARGET_VOP = 327,
 	TARGET_XQS = 331,
+	TARGET_DEVRGMII = 392,
 	NUM_TARGETS = 517
 };
 
@@ -5367,6 +5369,69 @@ extern const struct sparx5_regs *regs;
 #define HSCH_TAS_STATEMACHINE_CFG_REVISIT_DLY_GET(x)\
 	FIELD_GET(HSCH_TAS_STATEMACHINE_CFG_REVISIT_DLY, x)
 
+/* LAN969X ONLY */
+/* HSIOWRAP:XMII_CFG:XMII_CFG */
+#define HSIO_WRAP_XMII_CFG(g)                                                  \
+	__REG(TARGET_HSIO_WRAP, 0, 1, 116, g, 2, 20, 0, 0, 1, 4)
+
+#define HSIO_WRAP_XMII_CFG_GPIO_XMII_CFG         GENMASK(2, 1)
+#define HSIO_WRAP_XMII_CFG_GPIO_XMII_CFG_SET(x)\
+	FIELD_PREP(HSIO_WRAP_XMII_CFG_GPIO_XMII_CFG, x)
+#define HSIO_WRAP_XMII_CFG_GPIO_XMII_CFG_GET(x)\
+	FIELD_GET(HSIO_WRAP_XMII_CFG_GPIO_XMII_CFG, x)
+
+/* LAN969X ONLY */
+/* HSIOWRAP:XMII_CFG:RGMII_CFG */
+#define HSIO_WRAP_RGMII_CFG(g)                                                 \
+	__REG(TARGET_HSIO_WRAP, 0, 1, 116, g, 2, 20, 4, 0, 1, 4)
+
+#define HSIO_WRAP_RGMII_CFG_TX_CLK_CFG           GENMASK(4, 2)
+#define HSIO_WRAP_RGMII_CFG_TX_CLK_CFG_SET(x)\
+	FIELD_PREP(HSIO_WRAP_RGMII_CFG_TX_CLK_CFG, x)
+#define HSIO_WRAP_RGMII_CFG_TX_CLK_CFG_GET(x)\
+	FIELD_GET(HSIO_WRAP_RGMII_CFG_TX_CLK_CFG, x)
+
+#define HSIO_WRAP_RGMII_CFG_RGMII_TX_RST         BIT(1)
+#define HSIO_WRAP_RGMII_CFG_RGMII_TX_RST_SET(x)\
+	FIELD_PREP(HSIO_WRAP_RGMII_CFG_RGMII_TX_RST, x)
+#define HSIO_WRAP_RGMII_CFG_RGMII_TX_RST_GET(x)\
+	FIELD_GET(HSIO_WRAP_RGMII_CFG_RGMII_TX_RST, x)
+
+#define HSIO_WRAP_RGMII_CFG_RGMII_RX_RST         BIT(0)
+#define HSIO_WRAP_RGMII_CFG_RGMII_RX_RST_SET(x)\
+	FIELD_PREP(HSIO_WRAP_RGMII_CFG_RGMII_RX_RST, x)
+#define HSIO_WRAP_RGMII_CFG_RGMII_RX_RST_GET(x)\
+	FIELD_GET(HSIO_WRAP_RGMII_CFG_RGMII_RX_RST, x)
+
+/* LAN969X ONLY */
+/* HSIOWRAP:XMII_CFG:DLL_CFG */
+#define HSIO_WRAP_DLL_CFG(g, r)                                                \
+	__REG(TARGET_HSIO_WRAP, 0, 1, 116, g, 2, 20, 12, r, 2, 4)
+
+#define HSIO_WRAP_DLL_CFG_DLL_ENA                BIT(19)
+#define HSIO_WRAP_DLL_CFG_DLL_ENA_SET(x)\
+	FIELD_PREP(HSIO_WRAP_DLL_CFG_DLL_ENA, x)
+#define HSIO_WRAP_DLL_CFG_DLL_ENA_GET(x)\
+	FIELD_GET(HSIO_WRAP_DLL_CFG_DLL_ENA, x)
+
+#define HSIO_WRAP_DLL_CFG_DLL_CLK_ENA            BIT(18)
+#define HSIO_WRAP_DLL_CFG_DLL_CLK_ENA_SET(x)\
+	FIELD_PREP(HSIO_WRAP_DLL_CFG_DLL_CLK_ENA, x)
+#define HSIO_WRAP_DLL_CFG_DLL_CLK_ENA_GET(x)\
+	FIELD_GET(HSIO_WRAP_DLL_CFG_DLL_CLK_ENA, x)
+
+#define HSIO_WRAP_DLL_CFG_DLL_CLK_SEL            GENMASK(17, 15)
+#define HSIO_WRAP_DLL_CFG_DLL_CLK_SEL_SET(x)\
+	FIELD_PREP(HSIO_WRAP_DLL_CFG_DLL_CLK_SEL, x)
+#define HSIO_WRAP_DLL_CFG_DLL_CLK_SEL_GET(x)\
+	FIELD_GET(HSIO_WRAP_DLL_CFG_DLL_CLK_SEL, x)
+
+#define HSIO_WRAP_DLL_CFG_DLL_RST                BIT(0)
+#define HSIO_WRAP_DLL_CFG_DLL_RST_SET(x)\
+	FIELD_PREP(HSIO_WRAP_DLL_CFG_DLL_RST, x)
+#define HSIO_WRAP_DLL_CFG_DLL_RST_GET(x)\
+	FIELD_GET(HSIO_WRAP_DLL_CFG_DLL_RST, x)
+
 /* LRN:COMMON:COMMON_ACCESS_CTRL */
 #define LRN_COMMON_ACCESS_CTRL                                                 \
 	__REG(TARGET_LRN, 0, 1, 0, 0, 1, 72, 0, 0, 1, 4)
@@ -8110,4 +8175,84 @@ extern const struct sparx5_regs *regs;
 #define XQS_CNT(g)                                                             \
 	__REG(TARGET_XQS, 0, 1, 0, g, 1024, 4, 0, 0, 1, 4)
 
+/* LAN969X ONLY */
+/* DEV1G:DEV_CFG_STATUS:DEV_RST_CTRL */
+#define DEVRGMII_DEV_RST_CTRL(t)                                               \
+	__REG(TARGET_DEVRGMII, t, 2, 0, 0, 1, 36, 0, 0, 1, 4)
+
+#define DEVRGMII_DEV_RST_CTRL_SPEED_SEL          GENMASK(22, 20)
+#define DEVRGMII_DEV_RST_CTRL_SPEED_SEL_SET(x)\
+	FIELD_PREP(DEVRGMII_DEV_RST_CTRL_SPEED_SEL, x)
+#define DEVRGMII_DEV_RST_CTRL_SPEED_SEL_GET(x)\
+	FIELD_GET(DEVRGMII_DEV_RST_CTRL_SPEED_SEL, x)
+
+/* LAN969X ONLY */
+/* DEV1G:MAC_CFG_STATUS:MAC_ENA_CFG */
+#define DEVRGMII_MAC_ENA_CFG(t)                                                \
+	__REG(TARGET_DEVRGMII, t, 2, 36, 0, 1, 36, 0, 0, 1, 4)
+
+#define DEVRGMII_MAC_ENA_CFG_RX_ENA              BIT(4)
+#define DEVRGMII_MAC_ENA_CFG_RX_ENA_SET(x)\
+	FIELD_PREP(DEVRGMII_MAC_ENA_CFG_RX_ENA, x)
+#define DEVRGMII_MAC_ENA_CFG_RX_ENA_GET(x)\
+	FIELD_GET(DEVRGMII_MAC_ENA_CFG_RX_ENA, x)
+
+#define DEVRGMII_MAC_ENA_CFG_TX_ENA              BIT(0)
+#define DEVRGMII_MAC_ENA_CFG_TX_ENA_SET(x)\
+	FIELD_PREP(DEVRGMII_MAC_ENA_CFG_TX_ENA, x)
+#define DEVRGMII_MAC_ENA_CFG_TX_ENA_GET(x)\
+	FIELD_GET(DEVRGMII_MAC_ENA_CFG_TX_ENA, x)
+
+/* LAN969X ONLY */
+/* DEV1G:MAC_CFG_STATUS:MAC_TAGS_CFG */
+#define DEVRGMII_MAC_TAGS_CFG(t)                                               \
+	__REG(TARGET_DEVRGMII, t, 2, 36, 0, 1, 36, 12, 0, 1, 4)
+
+#define DEVRGMII_MAC_TAGS_CFG_TAG_ID             GENMASK(31, 16)
+#define DEVRGMII_MAC_TAGS_CFG_TAG_ID_SET(x)\
+	FIELD_PREP(DEVRGMII_MAC_TAGS_CFG_TAG_ID, x)
+#define DEVRGMII_MAC_TAGS_CFG_TAG_ID_GET(x)\
+	FIELD_GET(DEVRGMII_MAC_TAGS_CFG_TAG_ID, x)
+
+#define DEVRGMII_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA   BIT(3)
+#define DEVRGMII_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA_SET(x)\
+	FIELD_PREP(DEVRGMII_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA, x)
+#define DEVRGMII_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA_GET(x)\
+	FIELD_GET(DEVRGMII_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA, x)
+
+#define DEVRGMII_MAC_TAGS_CFG_PB_ENA             GENMASK(2, 1)
+#define DEVRGMII_MAC_TAGS_CFG_PB_ENA_SET(x)\
+	FIELD_PREP(DEVRGMII_MAC_TAGS_CFG_PB_ENA, x)
+#define DEVRGMII_MAC_TAGS_CFG_PB_ENA_GET(x)\
+	FIELD_GET(DEVRGMII_MAC_TAGS_CFG_PB_ENA, x)
+
+#define DEVRGMII_MAC_TAGS_CFG_VLAN_AWR_ENA       BIT(0)
+#define DEVRGMII_MAC_TAGS_CFG_VLAN_AWR_ENA_SET(x)\
+	FIELD_PREP(DEVRGMII_MAC_TAGS_CFG_VLAN_AWR_ENA, x)
+#define DEVRGMII_MAC_TAGS_CFG_VLAN_AWR_ENA_GET(x)\
+	FIELD_GET(DEVRGMII_MAC_TAGS_CFG_VLAN_AWR_ENA, x)
+
+/* LAN969X ONLY */
+/* DEV1G:MAC_CFG_STATUS:MAC_IFG_CFG */
+#define DEVRGMII_MAC_IFG_CFG(t)                                                \
+	__REG(TARGET_DEVRGMII, t, 2, 36, 0, 1, 36, 24, 0, 1, 4)
+
+#define DEVRGMII_MAC_IFG_CFG_TX_IFG              GENMASK(12, 8)
+#define DEVRGMII_MAC_IFG_CFG_TX_IFG_SET(x)\
+	FIELD_PREP(DEVRGMII_MAC_IFG_CFG_TX_IFG, x)
+#define DEVRGMII_MAC_IFG_CFG_TX_IFG_GET(x)\
+	FIELD_GET(DEVRGMII_MAC_IFG_CFG_TX_IFG, x)
+
+#define DEVRGMII_MAC_IFG_CFG_RX_IFG2             GENMASK(7, 4)
+#define DEVRGMII_MAC_IFG_CFG_RX_IFG2_SET(x)\
+	FIELD_PREP(DEVRGMII_MAC_IFG_CFG_RX_IFG2, x)
+#define DEVRGMII_MAC_IFG_CFG_RX_IFG2_GET(x)\
+	FIELD_GET(DEVRGMII_MAC_IFG_CFG_RX_IFG2, x)
+
+#define DEVRGMII_MAC_IFG_CFG_RX_IFG1             GENMASK(3, 0)
+#define DEVRGMII_MAC_IFG_CFG_RX_IFG1_SET(x)\
+	FIELD_PREP(DEVRGMII_MAC_IFG_CFG_RX_IFG1, x)
+#define DEVRGMII_MAC_IFG_CFG_RX_IFG1_GET(x)\
+	FIELD_GET(DEVRGMII_MAC_IFG_CFG_RX_IFG1, x)
+
 #endif /* _SPARX5_MAIN_REGS_H_ */

-- 
2.34.1


