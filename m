Return-Path: <netdev+bounces-190666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FF3AB8358
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305549E0137
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FBD29617F;
	Thu, 15 May 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q+6Hy/Ht"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D81E5B97;
	Thu, 15 May 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747302814; cv=none; b=N/GssCMgtEY5EXYGURYDv86Lee6Gwt3DgxLgNA3/NZQ4+vjPpW7TwJXp0cQ+n5AxszIC+t6lia0ajTuywLeoJ/0W6JMahYa4YDpYbxgK082B4MjZAP6hBINpruPcUjC4EbKEcl3keCPytJKSSpDEsvI3DgBtC2sX+pakD5oxAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747302814; c=relaxed/simple;
	bh=G2Pp+zEBhwHrzDV/IgEZ8yvXQTJ6BUMUwvI4bbMyqdA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kt64NKcRM5LSewMTRgPmiKKpDpIgV5/M3SqSIOR4+GLLi3zlt/ucxlrtmxPhCFw3r/Yy49UultYUaFk2TjviqVwOSxzpHGXzkp1swX1vIQpMfb2vng7p6yKpcsKJJ3ZuG06He3rUuK/9n06lishaVxqWC52MkBDkUD2lv/pOcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q+6Hy/Ht; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54F9r8sjD3224089, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747302788; bh=G2Pp+zEBhwHrzDV/IgEZ8yvXQTJ6BUMUwvI4bbMyqdA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Q+6Hy/HtGwZMxeF85ZI8GPMs2j9A1zQDmP1RK3VbGON/ztWzQVMddedLKXLEFWf4t
	 rvd6KKclrsRluttCdDlGAtpH5dL0XamjebJzB4y2Djw1+1ioZAl8mVLx1cVx1b1rgg
	 CQkTHVPT92blkdiql1cbUR0ar0c89fiXGhYXwxtqXOrhgFbLpj4KI3xVMw1k0tO0cm
	 M2dLyXQr4r2urwjf9fTN2z6wpQwWMRc/3Ml+br2zWMMcQ0NFbzUxBQplzNHSGWL5M0
	 pXrtFv+ZBMlTtRkawjnmyaZaTh9qVSoXcTo9uifYuzQyBSktZPpFjtn2IEj8/CWg19
	 3X/KgH+l6zO3g==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54F9r8sjD3224089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 May 2025 17:53:08 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 May 2025 17:53:08 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Thu, 15 May 2025 17:53:08 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next v2] r8169: add support for RTL8127A
Date: Thu, 15 May 2025 17:53:03 +0800
Message-ID: <20250515095303.3138-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This adds support for 10Gbs chip RTL8127A.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
v1 -> v2: update phy parameters

 drivers/net/ethernet/realtek/r8169.h          |   1 +
 drivers/net/ethernet/realtek/r8169_main.c     |  29 ++-
 .../net/ethernet/realtek/r8169_phy_config.c   | 166 ++++++++++++++++++
 3 files changed, 193 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index f05231030925..2c1a0c21af8d 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -70,6 +70,7 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_64,
 	RTL_GIGA_MAC_VER_66,
 	RTL_GIGA_MAC_VER_70,
+	RTL_GIGA_MAC_VER_80,
 	RTL_GIGA_MAC_NONE,
 	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1
 };
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 7bf71a675362..43170500d566 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -60,6 +60,7 @@
 #define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
+#define FIRMWARE_8127A_1	"rtl_nic/rtl8127a-1.fw"
 
 #define TX_DMA_BURST	7	/* Maximum PCI burst, '7' is unlimited */
 #define InterFrameGap	0x03	/* 3 means InterFrameGap = the shortest one */
@@ -98,6 +99,9 @@ static const struct rtl_chip_info {
 	const char *name;
 	const char *fw_name;
 } rtl_chip_infos[] = {
+	/* 8127A family. */
+	{ 0x7cf, 0x6c9,	RTL_GIGA_MAC_VER_80, "RTL8127A", FIRMWARE_8127A_1 },
+
 	/* 8126A family. */
 	{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_70, "RTL8126A", FIRMWARE_8126A_3 },
 	{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_70, "RTL8126A", FIRMWARE_8126A_2 },
@@ -222,8 +226,10 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
 	{ 0x0001, 0x8168, PCI_ANY_ID, 0x2410 },
 	{ PCI_VDEVICE(REALTEK,	0x8125) },
 	{ PCI_VDEVICE(REALTEK,	0x8126) },
+	{ PCI_VDEVICE(REALTEK,	0x8127) },
 	{ PCI_VDEVICE(REALTEK,	0x3000) },
 	{ PCI_VDEVICE(REALTEK,	0x5000) },
+	{ PCI_VDEVICE(REALTEK,	0x0e10) },
 	{}
 };
 
@@ -769,6 +775,7 @@ MODULE_FIRMWARE(FIRMWARE_8125D_2);
 MODULE_FIRMWARE(FIRMWARE_8125BP_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_3);
+MODULE_FIRMWARE(FIRMWARE_8127A_1);
 
 static inline struct device *tp_to_dev(struct rtl8169_private *tp)
 {
@@ -2937,6 +2944,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 		rtl_mod_config5(tp, 0, ASPM_en);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_70:
+		case RTL_GIGA_MAC_VER_80:
 			val8 = RTL_R8(tp, INT_CFG0_8125) | INT_CFG0_CLKREQEN;
 			RTL_W8(tp, INT_CFG0_8125, val8);
 			break;
@@ -2968,6 +2976,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_70:
+		case RTL_GIGA_MAC_VER_80:
 			val8 = RTL_R8(tp, INT_CFG0_8125) & ~INT_CFG0_CLKREQEN;
 			RTL_W8(tp, INT_CFG0_8125, val8);
 			break;
@@ -3687,10 +3696,13 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	/* disable new tx descriptor format */
 	r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
 
-	if (tp->mac_version == RTL_GIGA_MAC_VER_70)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_80)
 		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
 
-	if (tp->mac_version == RTL_GIGA_MAC_VER_70)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
+		r8168_mac_ocp_modify(tp, 0xe614, 0x0f00, 0x0f00);
+	else if (tp->mac_version == RTL_GIGA_MAC_VER_70)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
 	else if (tp->mac_version == RTL_GIGA_MAC_VER_63)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0200);
@@ -3708,7 +3720,8 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
 	r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
 	r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
-	if (tp->mac_version == RTL_GIGA_MAC_VER_70)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_80)
 		r8168_mac_ocp_modify(tp, 0xea1c, 0x0300, 0x0000);
 	else
 		r8168_mac_ocp_modify(tp, 0xea1c, 0x0004, 0x0000);
@@ -3786,6 +3799,12 @@ static void rtl_hw_start_8126a(struct rtl8169_private *tp)
 	rtl_hw_start_8125_common(tp);
 }
 
+static void rtl_hw_start_8127a(struct rtl8169_private *tp)
+{
+	rtl_set_def_aspm_entry_latency(tp);
+	rtl_hw_start_8125_common(tp);
+}
+
 static void rtl_hw_config(struct rtl8169_private *tp)
 {
 	static const rtl_generic_fct hw_configs[] = {
@@ -3829,6 +3848,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
+		[RTL_GIGA_MAC_VER_80] = rtl_hw_start_8127a,
 	};
 
 	if (hw_configs[tp->mac_version])
@@ -3846,8 +3866,11 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61:
 	case RTL_GIGA_MAC_VER_64:
 	case RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_80:
 		for (i = 0xa00; i < 0xb00; i += 4)
 			RTL_W32(tp, i, 0);
+		if (tp->mac_version == RTL_GIGA_MAC_VER_80)
+			RTL_W16(tp, INT_CFG1_8125, 0x0000);
 		break;
 	case RTL_GIGA_MAC_VER_63:
 	case RTL_GIGA_MAC_VER_70:
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 5403f8202c79..032d9d2cfa2a 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1130,6 +1130,171 @@ static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
 	rtl8125_common_config_eee_phy(phydev);
 }
 
+static void rtl8127a_1_hw_phy_config(struct rtl8169_private *tp,
+				     struct phy_device *phydev)
+{
+	r8169_apply_firmware(tp);
+	rtl8168g_enable_gphy_10m(phydev);
+
+	r8168g_phy_param(phydev, 0x8415, 0xff00, 0x9300);
+	r8168g_phy_param(phydev, 0x81a3, 0xff00, 0x0f00);
+	r8168g_phy_param(phydev, 0x81ae, 0xff00, 0x0f00);
+	r8168g_phy_param(phydev, 0x81b9, 0xff00, 0xb900);
+	rtl8125_phy_param(phydev, 0x83b0, 0x0e00, 0x0000);
+	rtl8125_phy_param(phydev, 0x83C5, 0x0e00, 0x0000);
+	rtl8125_phy_param(phydev, 0x83da, 0x0e00, 0x0000);
+	rtl8125_phy_param(phydev, 0x83ef, 0x0e00, 0x0000);
+	phy_modify_paged(phydev, 0x0bf3, 0x14, 0x01f0, 0x0160);
+	phy_modify_paged(phydev, 0x0bf3, 0x15, 0x001f, 0x0014);
+	phy_modify_paged(phydev, 0x0bf2, 0x14, 0x6000, 0x0000);
+	phy_modify_paged(phydev, 0x0bf2, 0x16, 0xc000, 0x0000);
+	phy_modify_paged(phydev, 0x0bf2, 0x14, 0x1fff, 0x0187);
+	phy_modify_paged(phydev, 0x0bf2, 0x15, 0x003f, 0x0003);
+
+	r8168g_phy_param(phydev, 0x8173, 0xffff, 0x8620);
+	r8168g_phy_param(phydev, 0x8175, 0xffff, 0x8671);
+	r8168g_phy_param(phydev, 0x817c, 0x0000, 0x2000);
+	r8168g_phy_param(phydev, 0x8187, 0x0000, 0x2000);
+	r8168g_phy_param(phydev, 0x8192, 0x0000, 0x2000);
+	r8168g_phy_param(phydev, 0x819d, 0x0000, 0x2000);
+	r8168g_phy_param(phydev, 0x81a8, 0x2000, 0x0000);
+	r8168g_phy_param(phydev, 0x81b3, 0x2000, 0x0000);
+	r8168g_phy_param(phydev, 0x81be, 0x0000, 0x2000);
+	r8168g_phy_param(phydev, 0x817d, 0xff00, 0xa600);
+	r8168g_phy_param(phydev, 0x8188, 0xff00, 0xa600);
+	r8168g_phy_param(phydev, 0x8193, 0xff00, 0xa600);
+	r8168g_phy_param(phydev, 0x819e, 0xff00, 0xa600);
+	r8168g_phy_param(phydev, 0x81a9, 0xff00, 0x1400);
+	r8168g_phy_param(phydev, 0x81b4, 0xff00, 0x1400);
+	r8168g_phy_param(phydev, 0x81bf, 0xff00, 0xa600);
+
+	phy_modify_paged(phydev, 0x0aea, 0x15, 0x0028, 0x0000);
+
+	rtl8125_phy_param(phydev, 0x84f0, 0xffff, 0x201c);
+	rtl8125_phy_param(phydev, 0x84f2, 0xffff, 0x3117);
+
+	phy_write_paged(phydev, 0x0aec, 0x13, 0x0000);
+	phy_write_paged(phydev, 0x0ae2, 0x10, 0xffff);
+	phy_write_paged(phydev, 0x0aec, 0x17, 0xffff);
+	phy_write_paged(phydev, 0x0aed, 0x11, 0xffff);
+	phy_write_paged(phydev, 0x0aec, 0x14, 0x0000);
+	phy_modify_paged(phydev, 0x0aed, 0x10, 0x0001, 0x0000);
+	phy_write_paged(phydev, 0x0adb, 0x14, 0x0150);
+	rtl8125_phy_param(phydev, 0x8197, 0xff00, 0x5000);
+	rtl8125_phy_param(phydev, 0x8231, 0xff00, 0x5000);
+	rtl8125_phy_param(phydev, 0x82cb, 0xff00, 0x5000);
+	rtl8125_phy_param(phydev, 0x82cd, 0xff00, 0x5700);
+	rtl8125_phy_param(phydev, 0x8233, 0xff00, 0x5700);
+	rtl8125_phy_param(phydev, 0x8199, 0xff00, 0x5700);
+
+	rtl8125_phy_param(phydev, 0x815a, 0xffff, 0x0150);
+	rtl8125_phy_param(phydev, 0x81f4, 0xffff, 0x0150);
+	rtl8125_phy_param(phydev, 0x828e, 0xffff, 0x0150);
+	rtl8125_phy_param(phydev, 0x81b1, 0xffff, 0x0000);
+	rtl8125_phy_param(phydev, 0x824b, 0xffff, 0x0000);
+	rtl8125_phy_param(phydev, 0x82e5, 0xffff, 0x0000);
+
+	rtl8125_phy_param(phydev, 0x84f7, 0xff00, 0x2800);
+	phy_modify_paged(phydev, 0x0aec, 0x11, 0x0000, 0x1000);
+	rtl8125_phy_param(phydev, 0x81b3, 0xff00, 0xad00);
+	rtl8125_phy_param(phydev, 0x824d, 0xff00, 0xad00);
+	rtl8125_phy_param(phydev, 0x82e7, 0xff00, 0xad00);
+	phy_modify_paged(phydev, 0x0ae4, 0x17, 0x000f, 0x0001);
+	rtl8125_phy_param(phydev, 0x82ce, 0xf000, 0x4000);
+
+	rtl8125_phy_param(phydev, 0x84ac, 0xffff, 0x0000);
+	rtl8125_phy_param(phydev, 0x84ae, 0xffff, 0x0000);
+	rtl8125_phy_param(phydev, 0x84b0, 0xffff, 0xf818);
+	rtl8125_phy_param(phydev, 0x84b2, 0xff00, 0x6000);
+
+	rtl8125_phy_param(phydev, 0x8ffc, 0xffff, 0x6008);
+	rtl8125_phy_param(phydev, 0x8ffe, 0xffff, 0xf450);
+
+	rtl8125_phy_param(phydev, 0x8015, 0x0000, 0x0200);
+	rtl8125_phy_param(phydev, 0x8016, 0x0800, 0x0000);
+	rtl8125_phy_param(phydev, 0x8fe6, 0xff00, 0x0800);
+	rtl8125_phy_param(phydev, 0x8fe4, 0xffff, 0x2114);
+
+	rtl8125_phy_param(phydev, 0x8647, 0xffff, 0xa7b1);
+	rtl8125_phy_param(phydev, 0x8649, 0xffff, 0xbbca);
+	rtl8125_phy_param(phydev, 0x864b, 0xff00, 0xdc00);
+
+	rtl8125_phy_param(phydev, 0x8154, 0xc000, 0x4000);
+	rtl8125_phy_param(phydev, 0x8158, 0xc000, 0x0000);
+
+	rtl8125_phy_param(phydev, 0x826c, 0xffff, 0xffff);
+	rtl8125_phy_param(phydev, 0x826e, 0xffff, 0xffff);
+
+	rtl8125_phy_param(phydev, 0x8872, 0xff00, 0x0e00);
+	r8168g_phy_param(phydev, 0x8012, 0x0000, 0x0800);
+	r8168g_phy_param(phydev, 0x8012, 0x0000, 0x4000);
+	phy_modify_paged(phydev, 0x0b57, 0x13, 0x0000, 0x0001);
+	r8168g_phy_param(phydev, 0x834a, 0xff00, 0x0700);
+	rtl8125_phy_param(phydev, 0x8217, 0x3f00, 0x2a00);
+	r8168g_phy_param(phydev, 0x81b1, 0xff00, 0x0b00);
+	rtl8125_phy_param(phydev, 0x8fed, 0xff00, 0x4e00);
+
+	rtl8125_phy_param(phydev, 0x88ac, 0xff00, 0x2300);
+	phy_modify_paged(phydev, 0x0bf0, 0x16, 0x0000, 0x3800);
+	rtl8125_phy_param(phydev, 0x88de, 0xff00, 0x0000);
+	rtl8125_phy_param(phydev, 0x80b4, 0xffff, 0x5195);
+
+	r8168g_phy_param(phydev, 0x8370, 0xffff, 0x8671);
+	r8168g_phy_param(phydev, 0x8372, 0xffff, 0x86c8);
+
+	r8168g_phy_param(phydev, 0x8401, 0xffff, 0x86c8);
+	r8168g_phy_param(phydev, 0x8403, 0xffff, 0x86da);
+	r8168g_phy_param(phydev, 0x8406, 0x1800, 0x1000);
+	r8168g_phy_param(phydev, 0x8408, 0x1800, 0x1000);
+	r8168g_phy_param(phydev, 0x840a, 0x1800, 0x1000);
+	r8168g_phy_param(phydev, 0x840c, 0x1800, 0x1000);
+	r8168g_phy_param(phydev, 0x840e, 0x1800, 0x1000);
+	r8168g_phy_param(phydev, 0x8410, 0x1800, 0x1000);
+	r8168g_phy_param(phydev, 0x8412, 0x1800, 0x1000);
+	r8168g_phy_param(phydev, 0x8414, 0x1800, 0x1000);
+	r8168g_phy_param(phydev, 0x8416, 0x1800, 0x1000);
+
+	r8168g_phy_param(phydev, 0x82bd, 0xffff, 0x1f40);
+
+	phy_modify_paged(phydev, 0x0bfb, 0x12, 0x07ff, 0x0328);
+	phy_write_paged(phydev, 0x0bfb, 0x13, 0x3e14);
+
+	r8168g_phy_param(phydev, 0x81c4, 0xffff, 0x003b);
+	r8168g_phy_param(phydev, 0x81c6, 0xffff, 0x0086);
+	r8168g_phy_param(phydev, 0x81c8, 0xffff, 0x00b7);
+	r8168g_phy_param(phydev, 0x81ca, 0xffff, 0x00db);
+	r8168g_phy_param(phydev, 0x81cc, 0xffff, 0x00fe);
+	r8168g_phy_param(phydev, 0x81ce, 0xffff, 0x00fe);
+	r8168g_phy_param(phydev, 0x81d0, 0xffff, 0x00fe);
+	r8168g_phy_param(phydev, 0x81d2, 0xffff, 0x00fe);
+	r8168g_phy_param(phydev, 0x81d4, 0xffff, 0x00c3);
+	r8168g_phy_param(phydev, 0x81d6, 0xffff, 0x0078);
+	r8168g_phy_param(phydev, 0x81d8, 0xffff, 0x0047);
+	r8168g_phy_param(phydev, 0x81da, 0xffff, 0x0023);
+
+	rtl8125_phy_param(phydev, 0x88d7, 0xffff, 0x01a0);
+	rtl8125_phy_param(phydev, 0x88d9, 0xffff, 0x01a0);
+	rtl8125_phy_param(phydev, 0x8ffa, 0xffff, 0x002a);
+
+	rtl8125_phy_param(phydev, 0x8fee, 0xffff, 0xffdf);
+	rtl8125_phy_param(phydev, 0x8ff0, 0xffff, 0xffff);
+	rtl8125_phy_param(phydev, 0x8ff2, 0xffff, 0x0a4a);
+	rtl8125_phy_param(phydev, 0x8ff4, 0xffff, 0xaa5a);
+	rtl8125_phy_param(phydev, 0x8ff6, 0xffff, 0x0a4a);
+
+	rtl8125_phy_param(phydev, 0x8ff8, 0xffff, 0xaa5a);
+	rtl8125_phy_param(phydev, 0x88d5, 0xff00, 0x0200);
+
+	r8168g_phy_param(phydev, 0x84bb, 0xff00, 0x0a00);
+	r8168g_phy_param(phydev, 0x84c0, 0xff00, 0x1600);
+
+	phy_modify_paged(phydev, 0x0a43, 0x10, 0x0000, 0x0003);
+
+	rtl8125_legacy_force_mode(phydev);
+	rtl8168g_disable_aldps(phydev);
+	rtl8125_common_config_eee_phy(phydev);
+}
+
 void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 			 enum mac_version ver)
 {
@@ -1181,6 +1346,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
 		[RTL_GIGA_MAC_VER_66] = rtl8125bp_hw_phy_config,
 		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
+		[RTL_GIGA_MAC_VER_80] = rtl8127a_1_hw_phy_config,
 	};
 
 	if (phy_configs[ver])
-- 
2.43.0


