Return-Path: <netdev+bounces-192170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A64ABEC5A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B99B3B7025
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A0B23A9A0;
	Wed, 21 May 2025 06:45:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AEC23A563
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809958; cv=none; b=d64pX16+NpEEy11o7zi72NSv69lS3f11S3Mem0NWUbwaBhv8YNBHKGywxyLaYBLJEPgQzZEDXDJsEeOce7pP7D/f2mSI2aMoMd+qeeMa4HEbA+37e/uyoiziL+SqTjsXq6BM+dBtFaRlJESsFEg5S0KlpovIc0Ebsj6fjN7ePjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809958; c=relaxed/simple;
	bh=MZ9XrhJl5gvFRup1aU5S+6jaCvHnXmeuEjEG9R0PeLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sy+6M6HQZXi1zx0F+fte9CnTfhP3gzNgOfnEspTZAHMWcESr5bR41xJMMQ+kkEEaA3HCJM/GOrdyhFLjY+qWmHL2BX56xvo50bCGBwPguOBWBPFTXscc9SsjN6pgHva9WAMfdEevTPCwqXBJCgB9pqtNVQfVX5f7PEhaeHTbTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1747809865t7c6f10a4
X-QQ-Originating-IP: EvrDiIy8BPH9L2hWQzgVvuxdoNYsLE4WSu1KaBWvDpU=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 May 2025 14:44:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15518581242333566290
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 1/9] net: txgbe: Remove specified SP type
Date: Wed, 21 May 2025 14:43:54 +0800
Message-ID: <8EF712EC14B8FF70+20250521064402.22348-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250521064402.22348-1-jiawenwu@trustnetic.com>
References: <20250521064402.22348-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N4KH/PyO63QvOWPZxvhDMbt113Ce9Hhed1/xTw+mgPGrlsEjWn9N8VDg
	5bxGsZTEkXzEIn+QWdHD3/P4roNvzi2dm8mQO8oc6Ten/U4AImkZLdQPrFCnC6WQe50PEyA
	+HQHs/qA+27aC93x4TXKNcmtdCe/NqLwWaM1hlzxuXekDHMXTM1v6d64xeIcPlE5UmdayCH
	ryoGWWAdMJvsGV8OxGCkxNhxMuILUuKPHeRIbdbDdryes/Pwyz2NiYbqEa3uvscPrDTO8hm
	VqowEEcn2YSqOb7gGr005lYIS1BCvREMRTnfDVUCDVGvKMVmDf/cnc41mLyAQwAlcDeLrE4
	jf5foac9SZbQ8+13fvHpMWOeSKu4lowSXaRiHUG69gv/9ZFjMGGZUJv9NUuvDVwKAduzNgz
	vsV0iZ4GoJmNcIcCSRUZQzg7wq3I6kYaHgzSlTmK/hY4tu8pZnDICC/bxOWDXhJHr1g8MfM
	u4q0a4asOg6D8cYim/BkZ+faH8+2O6orGZ1LzgLYejhkPMUuIbH2TpZh84jVtuzoPEHLq7b
	PPVMKHf1pGM0Rvi19CfJZHoYMCoIaf/X8tXgJ0k7lf2+a+ywEOr/V0IMDP8trFE+2oEA4vj
	1a9XEqpwU+44lARlIQ1RJ2AZum9vcBgK2PUsMeJNvVA3CRYX1UYUODEvaLtFb9fkEa5dDHH
	nI/WjCtvhqzheQRHgPrH/CrA/UTeFQZuizpRv8BFnscol41itDMJNo7XEVgBSP6L3Q8Pc//
	UZhz7JUBcFcV+Srt4m1N5BKV6Wc0yzfd4wAs8wnTkm56EoW3+zSBg2PsGtOpGVEsf4Hu7TU
	VdMZMfL+1GG2Xnjn5HkBVWPwQNxbRuXq3W2XtMm97N8ftXRmBUdCeQNACP8Ea6EdZAk3Ozo
	+w2gw5b5wUB2eoHAczmq0lmlIzHw5LdcjhaJusCBonvpHq4v5nWIHVqWmi17359GKrMLVMc
	lGMy4LEi5Ihf2+84M4A7oV/OpT2BMbW98BkLYEMEomb7zoH1PMHIUoMkO0oXTL/HiWJqxK0
	jN8c5d6/IxJwsge1LsgaIJjkB5W0VJ+IFO037/aCVs01/UF0zc
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Since AML devices are going to reuse some definitions, remove the "SP"
qualifier from these definitions.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


