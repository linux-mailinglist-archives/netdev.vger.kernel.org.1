Return-Path: <netdev+bounces-190973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 339DDAB98F1
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703891BC3078
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B174922D7B7;
	Fri, 16 May 2025 09:34:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6A822F74D
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388056; cv=none; b=XGqYwhNnpmfDwtJuz6Rxa05TM6/cWYmbyi61z6Vb6NZrn362k4n9SGkDfy/HeSrAEKgHcLgfS9npOIOKuaPzvkx4QTmgLZ5sPJJ6s3hMWfy/OtjiDdBlnNFLRDURZvw79HICNlKZoovWwunmxcVzVmDCb8aU+JZx1qSFOk2XuAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388056; c=relaxed/simple;
	bh=ikhB/j3V0msPCSMW0bx4D0pa3crncG/Sro6HRQ2L8w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgqvChRjXRsiXY7Iz2Z40TJPse/zRWeGZk2IIJVI6p6udg0BIJeJsJkoDKp/C8vBgxQZ0ZNiyqBQxgIwCd9kAOxK/9XXKIqaESCij3DrCwnm2UUqhZ8H2QNA3LRpLj+K919E3tatimPuN7a+/LQ8vmSM9mjpskGBnMy7CH4stuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1747387960t7fa0f17f
X-QQ-Originating-IP: Uh5YL7hXNoC3rmLJ/3qeGjehyxYeS72d3GD1BLTTvqY=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 17:32:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9807337796463670334
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 1/9] net: txgbe: Remove specified SP type
Date: Fri, 16 May 2025 17:32:12 +0800
Message-ID: <4DBB8BAA9740F2E2+20250516093220.6044-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516093220.6044-1-jiawenwu@trustnetic.com>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MXE8fio8DejkmCmNpO2TYJr5CtuURosQLI42XhQe+JUhkRiMELZlxDo5
	+o/qP030CDEBlAPaZpcW3FLRCAWddc+Enw84k8gVdEdom8ehJJoz8pn/zgJYff6G+d6sA6H
	VSZ5lB7stj6O2Zl/mC6KGPl4bFlSc4ECOJyAGFaw+gau+i48ELijKxqwrLEJM5aYcIQk+XQ
	aJReN6oZrqCt4fxmzlEHZ6R97F8dq1UAnpISgUcXtl4Hms1W6ZCABwVPwDe3aIpSOkLy+hJ
	iSsW0UY5wDmKgytWpEmx/JhSVDXKWC2iH/IhNgFb/AVussgDWQWbGjQEgJDjJz40QbvvMCp
	suZD6ktLeZ7eHhY78TWOCh4vm3DfmiccqW1aKVcZmU9F9I5KDZuX65RyTanZUtsDPyccHvj
	ELj3TGRi4svUuWg33s4tV5IsXUJI3oudDkNnJMgGSeQKLREnTpahPP0H/zxLx0ZilOpU2xq
	2xsArrysbLEyGhZqaJSF+wFzdgO1fdV29Cyg2zx3GYBZzCN8VMgpDcye+Yo/jhYe8CCEMdr
	Leb7bDS0fkPk8/UIy41BuK8nFU+bkoFkVcipwoHZ9W5U6RFtiHIcBE+dpV5phkU5bqA4yOm
	ydecrKjc9klAWeDnrML6Qd5L3tvw+gfxP+EdhMw0d8UcUZbg58hF0BZWf48VFVXpMvw7h5A
	HsA0M8+OC+ytHHD1ZWfwhhD7Hb1CUPQ8dayyWKq9R2jQItSdB0qoL0vKljSjyRUDU3engHW
	1YK0iia4p4nmWlXDYNaAQsOGXMvoaHpBhd5cKEMqyjVTiLoMT/iJchB+cL9r9iZscIthFO7
	otIyEXKxK8TUWvezaWB+666C76v3OLKG9Jd4VDjwUjlHl57LkAgteonPJpG7MiRRNBzGRq8
	MPb5avc8Vv1+ufwQDl+h5rEK8Rg61SO8fiyJutLT3l7tkiKoHWuneiSScDvCgUVqaBBWMfu
	ut6P86bjwKfNzgkicHqH+tIUDXicqyfA3wK9NOLaXwia5jDLfvpXb35mZO+GynYLzDWrbNV
	92jfm3xPc0jkpi+PIvsIZ396IAXgc=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Since AML devices are going to reuse some definitions, remove the "SP"
qualifier from these definitions.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 12 ++++-----
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |  4 +--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 26 +++++++++----------
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  8 +++---
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   | 14 +++++-----
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 8cfed5d4ebf7..5f024f5ac3a6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -840,11 +840,11 @@ enum wx_mac_type {
 	wx_mac_aml,
 };
 
-enum sp_media_type {
-	sp_media_unknown = 0,
-	sp_media_fiber,
-	sp_media_copper,
-	sp_media_backplane
+enum wx_media_type {
+	wx_media_unknown = 0,
+	wx_media_fiber,
+	wx_media_copper,
+	wx_media_backplane
 };
 
 enum em_mac_type {
@@ -1211,7 +1211,7 @@ struct wx {
 	struct wx_mbx_info mbx;
 	struct wx_mac_info mac;
 	enum em_mac_type mac_type;
-	enum sp_media_type media_type;
+	enum wx_media_type media_type;
 	struct wx_eeprom_info eeprom;
 	struct wx_addr_filter_info addr_ctrl;
 	struct wx_fc_info fc;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
index a054b259d435..e551ae0e2069 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -188,7 +188,7 @@ int txgbe_reset_hw(struct wx *wx)
 	if (status != 0)
 		return status;
 
-	if (wx->media_type != sp_media_copper) {
+	if (wx->media_type != wx_media_copper) {
 		u32 val;
 
 		val = WX_MIS_RST_LAN_RST(wx->bus.func);
@@ -218,7 +218,7 @@ int txgbe_reset_hw(struct wx *wx)
 	 * clear the multicast table.  Also reset num_rar_entries to 128,
 	 * since we modify this value when programming the SAN MAC address.
 	 */
-	wx->mac.num_rar_entries = TXGBE_SP_RAR_ENTRIES;
+	wx->mac.num_rar_entries = TXGBE_RAR_ENTRIES;
 	wx_init_rx_addrs(wx);
 
 	pci_set_master(wx->pdev);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index f57d84628e07..ea0b1cb721c8 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -251,25 +251,25 @@ static void txgbe_init_type_code(struct wx *wx)
 
 	switch (device_type) {
 	case TXGBE_ID_SFP:
-		wx->media_type = sp_media_fiber;
+		wx->media_type = wx_media_fiber;
 		break;
 	case TXGBE_ID_XAUI:
 	case TXGBE_ID_SGMII:
-		wx->media_type = sp_media_copper;
+		wx->media_type = wx_media_copper;
 		break;
 	case TXGBE_ID_KR_KX_KX4:
 	case TXGBE_ID_MAC_XAUI:
 	case TXGBE_ID_MAC_SGMII:
-		wx->media_type = sp_media_backplane;
+		wx->media_type = wx_media_backplane;
 		break;
 	case TXGBE_ID_SFI_XAUI:
 		if (wx->bus.func == 0)
-			wx->media_type = sp_media_fiber;
+			wx->media_type = wx_media_fiber;
 		else
-			wx->media_type = sp_media_copper;
+			wx->media_type = wx_media_copper;
 		break;
 	default:
-		wx->media_type = sp_media_unknown;
+		wx->media_type = wx_media_unknown;
 		break;
 	}
 }
@@ -283,13 +283,13 @@ static int txgbe_sw_init(struct wx *wx)
 	u16 msix_count = 0;
 	int err;
 
-	wx->mac.num_rar_entries = TXGBE_SP_RAR_ENTRIES;
-	wx->mac.max_tx_queues = TXGBE_SP_MAX_TX_QUEUES;
-	wx->mac.max_rx_queues = TXGBE_SP_MAX_RX_QUEUES;
-	wx->mac.mcft_size = TXGBE_SP_MC_TBL_SIZE;
-	wx->mac.vft_size = TXGBE_SP_VFT_TBL_SIZE;
-	wx->mac.rx_pb_size = TXGBE_SP_RX_PB_SIZE;
-	wx->mac.tx_pb_size = TXGBE_SP_TDB_PB_SZ;
+	wx->mac.num_rar_entries = TXGBE_RAR_ENTRIES;
+	wx->mac.max_tx_queues = TXGBE_MAX_TXQ;
+	wx->mac.max_rx_queues = TXGBE_MAX_RXQ;
+	wx->mac.mcft_size = TXGBE_MC_TBL_SIZE;
+	wx->mac.vft_size = TXGBE_VFT_TBL_SIZE;
+	wx->mac.rx_pb_size = TXGBE_RX_PB_SIZE;
+	wx->mac.tx_pb_size = TXGBE_TDB_PB_SZ;
 
 	/* PCI config space info */
 	err = wx_sw_init(wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 1863cfd27ee7..b5ae7c25ac99 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -165,7 +165,7 @@ static struct phylink_pcs *txgbe_phylink_mac_select(struct phylink_config *confi
 	struct wx *wx = phylink_to_wx(config);
 	struct txgbe *txgbe = wx->priv;
 
-	if (wx->media_type != sp_media_copper)
+	if (wx->media_type != wx_media_copper)
 		return txgbe->pcs;
 
 	return NULL;
@@ -278,7 +278,7 @@ static int txgbe_phylink_init(struct txgbe *txgbe)
 	config->mac_capabilities = MAC_10000FD | MAC_1000FD | MAC_100FD |
 				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
 
-	if (wx->media_type == sp_media_copper) {
+	if (wx->media_type == wx_media_copper) {
 		phy_mode = PHY_INTERFACE_MODE_XAUI;
 		__set_bit(PHY_INTERFACE_MODE_XAUI, config->supported_interfaces);
 	} else {
@@ -576,7 +576,7 @@ int txgbe_init_phy(struct txgbe *txgbe)
 	if (wx->mac.type == wx_mac_aml)
 		return 0;
 
-	if (txgbe->wx->media_type == sp_media_copper)
+	if (txgbe->wx->media_type == wx_media_copper)
 		return txgbe_ext_phy_init(txgbe);
 
 	ret = txgbe_swnodes_register(txgbe);
@@ -643,7 +643,7 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 	if (txgbe->wx->mac.type == wx_mac_aml)
 		return;
 
-	if (txgbe->wx->media_type == sp_media_copper) {
+	if (txgbe->wx->media_type == wx_media_copper) {
 		phylink_disconnect_phy(txgbe->wx->phylink);
 		phylink_destroy(txgbe->wx->phylink);
 		return;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 261a83308568..8376248fecda 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -173,13 +173,13 @@
 #define TXGBE_MAX_RX_QUEUES   (TXGBE_MAX_FDIR_INDICES + 1)
 #define TXGBE_MAX_TX_QUEUES   (TXGBE_MAX_FDIR_INDICES + 1)
 
-#define TXGBE_SP_MAX_TX_QUEUES  128
-#define TXGBE_SP_MAX_RX_QUEUES  128
-#define TXGBE_SP_RAR_ENTRIES    128
-#define TXGBE_SP_MC_TBL_SIZE    128
-#define TXGBE_SP_VFT_TBL_SIZE   128
-#define TXGBE_SP_RX_PB_SIZE     512
-#define TXGBE_SP_TDB_PB_SZ      (160 * 1024) /* 160KB Packet Buffer */
+#define TXGBE_MAX_TXQ        128
+#define TXGBE_MAX_RXQ        128
+#define TXGBE_RAR_ENTRIES    128
+#define TXGBE_MC_TBL_SIZE    128
+#define TXGBE_VFT_TBL_SIZE   128
+#define TXGBE_RX_PB_SIZE     512
+#define TXGBE_TDB_PB_SZ      (160 * 1024) /* 160KB Packet Buffer */
 
 #define TXGBE_MAX_VFS_DRV_LIMIT                 63
 
-- 
2.48.1


