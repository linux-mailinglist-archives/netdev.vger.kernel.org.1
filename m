Return-Path: <netdev+bounces-237125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A62C45AC6
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7331E4EAF3B
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F942E9EC7;
	Mon, 10 Nov 2025 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="XRGZH1Yn"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5426ED53;
	Mon, 10 Nov 2025 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767406; cv=none; b=sKy/8Tm4JoARLdOqM8pv9eahBS47g9DnT1xYVPp+/PTLpBw/+R7TXdq+HsQrTwsI3UztgtKfOWT6udQPH5grGjR9Rk2htiILvR7JBIH74juw+5ejlERZerptMVnf6NWeDlsm39T1DAMxd4qtGzFvrVrgAgLdrI6pbotPMWXQ9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767406; c=relaxed/simple;
	bh=BaEAqne1oPk1IwVfVD6PLtv16Wry2BGLYGcF46tapWA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=odIK+sFPppw0MouZjTj2SeydT2cnBnmosykUj/5mJ4noL8mNTDfnxz5okptJjP/e6FTxIG99enzPRdUjd0YeYVX6lINOZAXAJjK/7O4mkLVRO+DeXY6kle6GS3u4QgW9DsyPXDUjXoiZI0xrrGKZ3/bJA0l7/o2G2gDulhQ3Ug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=XRGZH1Yn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AA9a8evD1473797, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1762767368;
	bh=aPi8sKA2n3696iIpShQ9fqyAnp/gkcf50cVksh7YaE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=XRGZH1YnVr+ixn1RKOVy9tM8pNpsgfvPUYjvMIhhWI65hq/m1ZVCnpUiZUvzAxdO4
	 XcgratuhhDghGVQmeqURWhagw7SJFj8hY3vpzwjtbLGyWpZWipckbjz/lWpw1Dt+yA
	 zyHND9HwnFGYmUI984ldLwnqZnzwNSAEKyMxYUzrvdTs2K8UhZr0BjZhBsVq9oar6z
	 ttT02LqMFWKpG9K0NEiNBNlZBXD3+cz8XTFMc7ByqYyxXOAZLG4baHT2J0wEGXlDXi
	 1YYXpY6eSyQDN3GJ1yN4uGuDWeZGTMeUdy76tDeZv6wVriPxYRjSM6vhvYktVizhPZ
	 Rb66eZjQzasXA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AA9a8evD1473797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Nov 2025 17:36:08 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 10 Nov 2025 17:36:08 +0800
Received: from 172.29.37.152 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Mon, 10 Nov 2025 17:36:08 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        javen
	<javen_xu@realsil.com.cn>
Subject: [PATCH] r8169: add support for RTL8125K
Date: Mon, 10 Nov 2025 17:35:58 +0800
Message-ID: <20251110093558.3180-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This adds support for chip RTL8125K. Its XID is 0x68a. It is basically
based on the one with XID 0x688, but with different firmware file.

Signed-off-by: javen <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169.h            | 1 +
 drivers/net/ethernet/realtek/r8169_main.c       | 5 +++++
 drivers/net/ethernet/realtek/r8169_phy_config.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 2c1a0c21af8d..050ba3f4f874 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -68,6 +68,7 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_61,
 	RTL_GIGA_MAC_VER_63,
 	RTL_GIGA_MAC_VER_64,
+	RTL_GIGA_MAC_VER_65,
 	RTL_GIGA_MAC_VER_66,
 	RTL_GIGA_MAC_VER_70,
 	RTL_GIGA_MAC_VER_80,
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d18734fe12e4..2adffbc691b3 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -57,6 +57,7 @@
 #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
 #define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
 #define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
+#define FIRMWARE_8125K_1	"rtl_nic/rtl8125k-1.fw"
 #define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
@@ -110,6 +111,7 @@ static const struct rtl_chip_info {
 	{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66, "RTL8125BP", FIRMWARE_8125BP_2 },
 
 	/* 8125D family. */
+	{ 0x7cf, 0x68a, RTL_GIGA_MAC_VER_65, "RTL8125K", FIRMWARE_8125K_1 },
 	{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_2 },
 	{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_1 },
 
@@ -770,6 +772,7 @@ MODULE_FIRMWARE(FIRMWARE_8125A_3);
 MODULE_FIRMWARE(FIRMWARE_8125B_2);
 MODULE_FIRMWARE(FIRMWARE_8125D_1);
 MODULE_FIRMWARE(FIRMWARE_8125D_2);
+MODULE_FIRMWARE(FIRMWARE_8125K_1);
 MODULE_FIRMWARE(FIRMWARE_8125BP_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_3);
@@ -3844,6 +3847,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
 		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
 		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
+		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
 		[RTL_GIGA_MAC_VER_80] = rtl_hw_start_8127a,
@@ -3863,6 +3867,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_61:
 	case RTL_GIGA_MAC_VER_64:
+	case RTL_GIGA_MAC_VER_65:
 	case RTL_GIGA_MAC_VER_66:
 	case RTL_GIGA_MAC_VER_80:
 		for (i = 0xa00; i < 0xb00; i += 4)
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 032d9d2cfa2a..dff1daafc8a7 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1344,6 +1344,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
 		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
+		[RTL_GIGA_MAC_VER_65] = rtl8125d_hw_phy_config,
 		[RTL_GIGA_MAC_VER_66] = rtl8125bp_hw_phy_config,
 		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
 		[RTL_GIGA_MAC_VER_80] = rtl8127a_1_hw_phy_config,
-- 
2.43.0


