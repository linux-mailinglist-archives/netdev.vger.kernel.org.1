Return-Path: <netdev+bounces-123568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D518096552E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416502842BD
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E14381D5;
	Fri, 30 Aug 2024 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Xp4afzbN"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E973FF1;
	Fri, 30 Aug 2024 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724984324; cv=none; b=AF0aO+m+M+qE5Qm7eA/BowWwIhAvRBZjFLOe5kZUxEJMyglOR7g/m5+SNIgzMco4jqQmDcebK+N5TvL57BmKF2Pvv4PqFgyyOsILv0kd6OExiu2/t+K19eKmnQKUI+9M+ZJ8CNdMn7IU7HT0J+o754A2XiNyw5rreM3aDZga4KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724984324; c=relaxed/simple;
	bh=/13mPTlM4SsntBCSoQBRZV05rHIZHZFOAlCiUHU0XE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fu4Px6j8d7P4gbX+9seLafftMQNesUDHGSmOgEGf96vRmzG0YCqWNFf249VEM+w8aV6OWLOQsfiPV4Lhh2rnPVojnrVe2ii3sK/flu5EEPCi5FfrzzdL6pw84Jqvgpelg4Y8mnaUGwj9dhO58AmIcU/5A1+tY9RYXSNewIFBiSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Xp4afzbN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47U2IC2C0174774, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724984293; bh=/13mPTlM4SsntBCSoQBRZV05rHIZHZFOAlCiUHU0XE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Xp4afzbNxaj3zYWmCm/C30VzMEEm5oZ2lJ+xP4AlxLhR2wtr+/LBZ2q51bGC5Roc6
	 bvGJugsxEVbdkDVYeELAIyqkKTiAReXPVqu3r7bn9Du3BqzBVgqeTi1uLILx3jTfjS
	 aGRJ2uLAixEs+mPoBbPXr9+p65mmnbajf3HFJRWctYQGfV6YBoiF98Qgs52+ra4QDr
	 FPzOGCeC2ileAJXFvQ8B+WvH9YNMrid7y1FC9v2i5mI/RzvXoUu9NvHXP+j3O0a9nQ
	 K8FCyueZOBLjYFOCTgyM/haXOKGMKS1k5HsTl9v3/x6hTWXW0mDZxaAYq2E3mSWV9I
	 DKi8iZ9td0dzQ==
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47U2IC2C0174774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Fri, 30 Aug 2024 10:18:13 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RSEXMBS01.realsil.com.cn (172.29.17.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 30 Aug 2024 10:18:12 +0800
Received: from RSEXH36501.realsil.com.cn (172.29.17.2) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 30 Aug 2024 10:18:12 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36501.realsil.com.cn
 (172.29.17.2) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 30 Aug 2024 10:18:12 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next] r8169: add support for RTL8126A rev.b
Date: Fri, 30 Aug 2024 10:18:10 +0800
Message-ID: <20240830021810.11993-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for RTL8126A rev.b. Its XID is 0x64a. It is basically
based on the one with XID 0x649, but with different firmware file.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169.h          |  1 +
 drivers/net/ethernet/realtek/r8169_main.c     | 42 ++++++++++++-------
 .../net/ethernet/realtek/r8169_phy_config.c   |  1 +
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 00882ffc7a02..e2db944e6fa8 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -69,6 +69,7 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_61,
 	RTL_GIGA_MAC_VER_63,
 	RTL_GIGA_MAC_VER_65,
+	RTL_GIGA_MAC_VER_66,
 	RTL_GIGA_MAC_NONE
 };
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3507c2e28110..3cb1c4f5c91a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -56,6 +56,7 @@
 #define FIRMWARE_8125A_3	"rtl_nic/rtl8125a-3.fw"
 #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
+#define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
 
 #define TX_DMA_BURST	7	/* Maximum PCI burst, '7' is unlimited */
 #define InterFrameGap	0x03	/* 3 means InterFrameGap = the shortest one */
@@ -138,6 +139,7 @@ static const struct {
 	/* reserve 62 for CFG_METHOD_4 in the vendor driver */
 	[RTL_GIGA_MAC_VER_63] = {"RTL8125B",		FIRMWARE_8125B_2},
 	[RTL_GIGA_MAC_VER_65] = {"RTL8126A",		FIRMWARE_8126A_2},
+	[RTL_GIGA_MAC_VER_66] = {"RTL8126A",		FIRMWARE_8126A_3},
 };
 
 static const struct pci_device_id rtl8169_pci_tbl[] = {
@@ -1201,7 +1203,7 @@ static void rtl_writephy(struct rtl8169_private *tp, int location, int val)
 	case RTL_GIGA_MAC_VER_31:
 		r8168dp_2_mdio_write(tp, location, val);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
 		r8168g_mdio_write(tp, location, val);
 		break;
 	default:
@@ -1216,7 +1218,7 @@ static int rtl_readphy(struct rtl8169_private *tp, int location)
 	case RTL_GIGA_MAC_VER_28:
 	case RTL_GIGA_MAC_VER_31:
 		return r8168dp_2_mdio_read(tp, location);
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
 		return r8168g_mdio_read(tp, location);
 	default:
 		return r8169_mdio_read(tp, location);
@@ -1425,7 +1427,7 @@ static void rtl_set_d3_pll_down(struct rtl8169_private *tp, bool enable)
 	case RTL_GIGA_MAC_VER_25 ... RTL_GIGA_MAC_VER_26:
 	case RTL_GIGA_MAC_VER_29 ... RTL_GIGA_MAC_VER_30:
 	case RTL_GIGA_MAC_VER_32 ... RTL_GIGA_MAC_VER_37:
-	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_66:
 		if (enable)
 			RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) & ~D3_NO_PLL_DOWN);
 		else
@@ -1592,7 +1594,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 		break;
 	case RTL_GIGA_MAC_VER_34:
 	case RTL_GIGA_MAC_VER_37:
-	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_66:
 		if (wolopts)
 			rtl_mod_config2(tp, 0, PME_SIGNAL);
 		else
@@ -2071,6 +2073,7 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61:
 	case RTL_GIGA_MAC_VER_63:
 	case RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_66:
 		tp->tx_lpi_timer = timer_val;
 		RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
 		break;
@@ -2199,6 +2202,7 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 		enum mac_version ver;
 	} mac_info[] = {
 		/* 8126A family. */
+		{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_66 },
 		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_65 },
 
 		/* 8125B family. */
@@ -2470,6 +2474,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 		break;
 	case RTL_GIGA_MAC_VER_63:
 	case RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_66:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
 			RX_PAUSE_SLOT_ON);
 		break;
@@ -2656,7 +2661,7 @@ static void rtl_wait_txrx_fifo_empty(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_61:
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond, 100, 42);
 		break;
-	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
 		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond, 100, 42);
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond_2, 100, 42);
@@ -2899,7 +2904,7 @@ static void rtl_enable_exit_l1(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_37 ... RTL_GIGA_MAC_VER_38:
 		rtl_eri_set_bits(tp, 0xd4, 0x0c00);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
 		r8168_mac_ocp_modify(tp, 0xc0ac, 0, 0x1f80);
 		break;
 	default:
@@ -2913,7 +2918,7 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_38:
 		rtl_eri_clear_bits(tp, 0xd4, 0x1f00);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
 		r8168_mac_ocp_modify(tp, 0xc0ac, 0x1f80, 0);
 		break;
 	default:
@@ -2940,6 +2945,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 		rtl_mod_config5(tp, 0, ASPM_en);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_65:
+		case RTL_GIGA_MAC_VER_66:
 			val8 = RTL_R8(tp, INT_CFG0_8125) | INT_CFG0_CLKREQEN;
 			RTL_W8(tp, INT_CFG0_8125, val8);
 			break;
@@ -2950,7 +2956,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
-		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_65:
+		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
 			/* reset ephy tx/rx disable timer */
 			r8168_mac_ocp_modify(tp, 0xe094, 0xff00, 0);
 			/* chip can trigger L1.2 */
@@ -2962,7 +2968,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 	} else {
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
-		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_65:
+		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
 			r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, 0);
 			break;
 		default:
@@ -2971,6 +2977,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_65:
+		case RTL_GIGA_MAC_VER_66:
 			val8 = RTL_R8(tp, INT_CFG0_8125) & ~INT_CFG0_CLKREQEN;
 			RTL_W8(tp, INT_CFG0_8125, val8);
 			break;
@@ -3690,10 +3697,12 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	/* disable new tx descriptor format */
 	r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
 
-	if (tp->mac_version == RTL_GIGA_MAC_VER_65)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_65 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_66)
 		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
 
-	if (tp->mac_version == RTL_GIGA_MAC_VER_65)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_65 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_66)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
 	else if (tp->mac_version == RTL_GIGA_MAC_VER_63)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0200);
@@ -3711,7 +3720,8 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
 	r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
 	r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
-	if (tp->mac_version == RTL_GIGA_MAC_VER_65)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_65 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_66)
 		r8168_mac_ocp_modify(tp, 0xea1c, 0x0300, 0x0000);
 	else
 		r8168_mac_ocp_modify(tp, 0xea1c, 0x0004, 0x0000);
@@ -3825,6 +3835,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
 		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
 		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8126a,
+		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8126a,
 	};
 
 	if (hw_configs[tp->mac_version])
@@ -3845,6 +3856,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 		break;
 	case RTL_GIGA_MAC_VER_63:
 	case RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_66:
 		for (i = 0xa00; i < 0xa80; i += 4)
 			RTL_W32(tp, i, 0);
 		RTL_W16(tp, INT_CFG1_8125, 0x0000);
@@ -4073,7 +4085,7 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
 		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
 		rtl_loop_wait_high(tp, &rtl_txcfg_empty_cond, 100, 666);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
 		rtl_enable_rxdvgate(tp);
 		fsleep(2000);
 		break;
@@ -4224,7 +4236,7 @@ static unsigned int rtl_quirk_packet_padto(struct rtl8169_private *tp,
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_34:
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
 		padto = max_t(unsigned int, padto, ETH_ZLEN);
 		break;
 	default:
@@ -5257,7 +5269,7 @@ static void rtl_hw_initialize(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_48:
 		rtl_hw_init_8168g(tp);
 		break;
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
 		rtl_hw_init_8125(tp);
 		break;
 	default:
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 1f74317beb88..2c8845e08f86 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1159,6 +1159,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
 		[RTL_GIGA_MAC_VER_65] = rtl8126a_hw_phy_config,
+		[RTL_GIGA_MAC_VER_66] = rtl8126a_hw_phy_config,
 	};
 
 	if (phy_configs[ver])
-- 
2.43.0


