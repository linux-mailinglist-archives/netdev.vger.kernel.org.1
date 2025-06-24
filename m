Return-Path: <netdev+bounces-200695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD14AE68E0
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865DA5A1129
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98412D2391;
	Tue, 24 Jun 2025 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJzccIkV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D022D1907
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775331; cv=none; b=kxIJLdKZjZH5MmdPJShHZ8RXPtXn6ZecIS6HLyGN4A1Sx0VnFd+9eb/xKcdKVxRdrdU5dqO5FX0pthuTA5M0oUCuHn+HAakuWa3XSVn/puNErOpztr6AT1AwMmtDKbRB/dzxhLMNcWedJujXp93DVJVV6nkw1pXJ6H2Yql4sBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775331; c=relaxed/simple;
	bh=0do1DqhXMC7yk9arbJzcOmHYpEoiMeW08ObUX4ztD6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOEPCnAgpJyjX3of2hxXht1LjQCB16yo/ubMezQF5LMfPVPL5tWRVZkMBMqiADiMTm6q5bSk2/HkWZx+qUAkrAlEf5WQppk+CS5H6t7MdjF03so8Pgy5Hub0YvRKvWpEqPEGkEbe9KEcAb/6rirtPcppkEb/eUfPVNis7N67Cdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJzccIkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160A2C4CEEE;
	Tue, 24 Jun 2025 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750775331;
	bh=0do1DqhXMC7yk9arbJzcOmHYpEoiMeW08ObUX4ztD6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJzccIkV7Hx8i7aotmXI9QI1Oq3eElQ7akXJXpR15cvS2Ey8eRVmlb2jkJplLkzkJ
	 4ew6EdCOihsI5J+VPdFnrW5dmVLti6B9v+fDIB8Cw49YyaROB+/txCIypw08IGrdf5
	 C0Z5+dQXe3I3vbPMQLgH+OKRMH7cw6GcAYyuluMke3h+q1p3eJNDa7Ce0Vw59mHuMN
	 xGqAOVY68kGjGA0LaMi3ofBkBMXLIB+BzOaWNk/DcOVPpPLOGg7NcH56Yg3+5zOQQy
	 uM9EYKZG460EZzx+kER03K6OrG8vp9TOUs9+mm1Nc3o/zQT7oyEEfndihjz+e/umZH
	 NJlzJL57L+uAw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	mohsin.bashr@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] eth: fbnic: realign whitespace
Date: Tue, 24 Jun 2025 07:28:32 -0700
Message-ID: <20250624142834.3275164-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624142834.3275164-1-kuba@kernel.org>
References: <20250624142834.3275164-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relign various whitespace things. Some of it is spaces which should
be tabs and some is making sure the values are actually correctly
aligned to "columns" with 8 space tabs. Whitespace changes only.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 22 ++----
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  4 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  1 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 73 +++++++++----------
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 10 +--
 5 files changed, 52 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 1d8ff0cbe607..9c89d5378668 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -493,7 +493,7 @@ enum {
 
 #define FBNIC_PTP_ADD_VAL_NS		0x04806		/* 0x12018 */
 #define FBNIC_PTP_ADD_VAL_NS_MASK		CSR_GENMASK(15, 0)
-#define FBNIC_PTP_ADD_VAL_SUBNS		0x04807	/* 0x1201c */
+#define FBNIC_PTP_ADD_VAL_SUBNS		0x04807		/* 0x1201c */
 
 #define FBNIC_PTP_CTR_VAL_HI		0x04808		/* 0x12020 */
 #define FBNIC_PTP_CTR_VAL_LO		0x04809		/* 0x12024 */
@@ -816,16 +816,12 @@ enum {
 #define FBNIC_CSR_START_MAC_STAT	0x11a00
 #define FBNIC_MAC_STAT_RX_BYTE_COUNT_L	0x11a08		/* 0x46820 */
 #define FBNIC_MAC_STAT_RX_BYTE_COUNT_H	0x11a09		/* 0x46824 */
-#define FBNIC_MAC_STAT_RX_ALIGN_ERROR_L \
-					0x11a0a		/* 0x46828 */
-#define FBNIC_MAC_STAT_RX_ALIGN_ERROR_H \
-					0x11a0b		/* 0x4682c */
+#define FBNIC_MAC_STAT_RX_ALIGN_ERROR_L	0x11a0a		/* 0x46828 */
+#define FBNIC_MAC_STAT_RX_ALIGN_ERROR_H	0x11a0b		/* 0x4682c */
 #define FBNIC_MAC_STAT_RX_TOOLONG_L	0x11a0e		/* 0x46838 */
 #define FBNIC_MAC_STAT_RX_TOOLONG_H	0x11a0f		/* 0x4683c */
-#define FBNIC_MAC_STAT_RX_RECEIVED_OK_L	\
-					0x11a12		/* 0x46848 */
-#define FBNIC_MAC_STAT_RX_RECEIVED_OK_H	\
-					0x11a13		/* 0x4684c */
+#define FBNIC_MAC_STAT_RX_RECEIVED_OK_L	0x11a12		/* 0x46848 */
+#define FBNIC_MAC_STAT_RX_RECEIVED_OK_H	0x11a13		/* 0x4684c */
 #define FBNIC_MAC_STAT_RX_PACKET_BAD_FCS_L \
 					0x11a14		/* 0x46850 */
 #define FBNIC_MAC_STAT_RX_PACKET_BAD_FCS_H \
@@ -882,10 +878,8 @@ enum {
 					0x11a42		/* 0x46908 */
 #define FBNIC_MAC_STAT_TX_TRANSMITTED_OK_H \
 					0x11a43		/* 0x4690c */
-#define FBNIC_MAC_STAT_TX_IFOUTERRORS_L \
-					0x11a46		/* 0x46918 */
-#define FBNIC_MAC_STAT_TX_IFOUTERRORS_H \
-					0x11a47		/* 0x4691c */
+#define FBNIC_MAC_STAT_TX_IFOUTERRORS_L	0x11a46		/* 0x46918 */
+#define FBNIC_MAC_STAT_TX_IFOUTERRORS_H	0x11a47		/* 0x4691c */
 #define FBNIC_MAC_STAT_TX_MULTICAST_L	0x11a4a		/* 0x46928 */
 #define FBNIC_MAC_STAT_TX_MULTICAST_H	0x11a4b		/* 0x4692c */
 #define FBNIC_MAC_STAT_TX_BROADCAST_L	0x11a4c		/* 0x46930 */
@@ -969,7 +963,7 @@ enum {
 					0x3107e		/* 0xc41f8 */
 #define FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_63_32 \
 					0x3107f		/* 0xc41fc */
-#define FBNIC_CSR_END_PUL_USER	0x310ea	/* CSR section delimiter */
+#define FBNIC_CSR_END_PUL_USER		0x310ea	/* CSR section delimiter */
 
 /* Queue Registers
  *
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 08bf87c5ddf6..f3ed65cf976a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -19,10 +19,10 @@ struct fbnic_fw_mbx {
 };
 
 // FW_VER_MAX_SIZE must match ETHTOOL_FWVERS_LEN
-#define FBNIC_FW_VER_MAX_SIZE	                32
+#define FBNIC_FW_VER_MAX_SIZE			32
 // Formatted version is in the format XX.YY.ZZ_RRR_COMMIT
 #define FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE	(FBNIC_FW_VER_MAX_SIZE - 13)
-#define FBNIC_FW_LOG_MAX_SIZE	                256
+#define FBNIC_FW_LOG_MAX_SIZE			256
 
 struct fbnic_fw_ver {
 	u32 version;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 805a31cd94b5..ab8b8b0f9f64 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -81,6 +81,7 @@ int fbnic_netdev_register(struct net_device *netdev);
 void fbnic_netdev_unregister(struct net_device *netdev);
 void fbnic_reset_queues(struct fbnic_net *fbn,
 			unsigned int tx, unsigned int rx);
+
 void fbnic_set_ethtool_ops(struct net_device *dev);
 
 int fbnic_ptp_setup(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 7fe9983d3c0e..588da02d6e22 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1676,43 +1676,42 @@ fbnic_get_rmon_stats(struct net_device *netdev,
 }
 
 static const struct ethtool_ops fbnic_ethtool_ops = {
-	.supported_coalesce_params	=
-				  ETHTOOL_COALESCE_USECS |
-				  ETHTOOL_COALESCE_RX_MAX_FRAMES,
-	.rxfh_max_num_contexts	= FBNIC_RPC_RSS_TBL_COUNT,
-	.get_drvinfo		= fbnic_get_drvinfo,
-	.get_regs_len		= fbnic_get_regs_len,
-	.get_regs		= fbnic_get_regs,
-	.get_link		= ethtool_op_get_link,
-	.get_coalesce		= fbnic_get_coalesce,
-	.set_coalesce		= fbnic_set_coalesce,
-	.get_ringparam		= fbnic_get_ringparam,
-	.set_ringparam		= fbnic_set_ringparam,
-	.get_pauseparam		= fbnic_phylink_get_pauseparam,
-	.set_pauseparam		= fbnic_phylink_set_pauseparam,
-	.get_strings		= fbnic_get_strings,
-	.get_ethtool_stats	= fbnic_get_ethtool_stats,
-	.get_sset_count		= fbnic_get_sset_count,
-	.get_rxnfc		= fbnic_get_rxnfc,
-	.set_rxnfc		= fbnic_set_rxnfc,
-	.get_rxfh_key_size	= fbnic_get_rxfh_key_size,
-	.get_rxfh_indir_size	= fbnic_get_rxfh_indir_size,
-	.get_rxfh		= fbnic_get_rxfh,
-	.set_rxfh		= fbnic_set_rxfh,
-	.get_rxfh_fields	= fbnic_get_rss_hash_opts,
-	.set_rxfh_fields	= fbnic_set_rss_hash_opts,
-	.create_rxfh_context	= fbnic_create_rxfh_context,
-	.modify_rxfh_context	= fbnic_modify_rxfh_context,
-	.remove_rxfh_context	= fbnic_remove_rxfh_context,
-	.get_channels		= fbnic_get_channels,
-	.set_channels		= fbnic_set_channels,
-	.get_ts_info		= fbnic_get_ts_info,
-	.get_ts_stats		= fbnic_get_ts_stats,
-	.get_link_ksettings	= fbnic_phylink_ethtool_ksettings_get,
-	.get_fecparam		= fbnic_phylink_get_fecparam,
-	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
-	.get_eth_ctrl_stats	= fbnic_get_eth_ctrl_stats,
-	.get_rmon_stats		= fbnic_get_rmon_stats,
+	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
+					  ETHTOOL_COALESCE_RX_MAX_FRAMES,
+	.rxfh_max_num_contexts		= FBNIC_RPC_RSS_TBL_COUNT,
+	.get_drvinfo			= fbnic_get_drvinfo,
+	.get_regs_len			= fbnic_get_regs_len,
+	.get_regs			= fbnic_get_regs,
+	.get_link			= ethtool_op_get_link,
+	.get_coalesce			= fbnic_get_coalesce,
+	.set_coalesce			= fbnic_set_coalesce,
+	.get_ringparam			= fbnic_get_ringparam,
+	.set_ringparam			= fbnic_set_ringparam,
+	.get_pauseparam			= fbnic_phylink_get_pauseparam,
+	.set_pauseparam			= fbnic_phylink_set_pauseparam,
+	.get_strings			= fbnic_get_strings,
+	.get_ethtool_stats		= fbnic_get_ethtool_stats,
+	.get_sset_count			= fbnic_get_sset_count,
+	.get_rxnfc			= fbnic_get_rxnfc,
+	.set_rxnfc			= fbnic_set_rxnfc,
+	.get_rxfh_key_size		= fbnic_get_rxfh_key_size,
+	.get_rxfh_indir_size		= fbnic_get_rxfh_indir_size,
+	.get_rxfh			= fbnic_get_rxfh,
+	.set_rxfh			= fbnic_set_rxfh,
+	.get_rxfh_fields		= fbnic_get_rss_hash_opts,
+	.set_rxfh_fields		= fbnic_set_rss_hash_opts,
+	.create_rxfh_context		= fbnic_create_rxfh_context,
+	.modify_rxfh_context		= fbnic_modify_rxfh_context,
+	.remove_rxfh_context		= fbnic_remove_rxfh_context,
+	.get_channels			= fbnic_get_channels,
+	.set_channels			= fbnic_set_channels,
+	.get_ts_info			= fbnic_get_ts_info,
+	.get_ts_stats			= fbnic_get_ts_stats,
+	.get_link_ksettings		= fbnic_phylink_ethtool_ksettings_get,
+	.get_fecparam			= fbnic_phylink_get_fecparam,
+	.get_eth_mac_stats		= fbnic_get_eth_mac_stats,
+	.get_eth_ctrl_stats		= fbnic_get_eth_ctrl_stats,
+	.get_rmon_stats			= fbnic_get_rmon_stats,
 };
 
 void fbnic_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 01756aba29fb..ab58572c27aa 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -376,11 +376,11 @@ fbnic_fw_get_cmpl_by_type(struct fbnic_dev *fbd, u32 msg_type)
  *
  * Return:
  *   One the following values:
- *     -EOPNOTSUPP: Is not ASIC so mailbox is not supported
- *     -ENODEV: Device I/O error
- *     -ENOMEM: Failed to allocate message
- *     -EBUSY: No space in mailbox
- *     -ENOSPC: DMA mapping failed
+ *	-EOPNOTSUPP: Is not ASIC so mailbox is not supported
+ *	-ENODEV: Device I/O error
+ *	-ENOMEM: Failed to allocate message
+ *	-EBUSY: No space in mailbox
+ *	-ENOSPC: DMA mapping failed
  *
  * This function sends a single TLV header indicating the host wants to take
  * some action. However there are no other side effects which means that any
-- 
2.49.0


