Return-Path: <netdev+bounces-169998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9542A46D16
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2483ACEF9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B6A25A32B;
	Wed, 26 Feb 2025 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ0TTGpm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327325A321
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604220; cv=none; b=bMc/ahI0tBepRbA3pGwkA8qcs4eqH0A6FYyf0wIn8+kp7LOnLQVWSi/DWpIF42UlLwART40GcxR9SwIrTfHURv+RdNyk3rqQzvOQoEblJbGNd2BfxAzr3Y8/1SlucqG3d8GfF+hOotoajB+X7Aa3rlte5770yrXrc2qLTEVV3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604220; c=relaxed/simple;
	bh=G4luJRCzXNfx/9fY/vly1vKyrwbSCswByVM2PkliHiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9nuDZ2IDu+kdoBPZTNZlb01B+C8ftCJY8jHi7aqeMsHDDuNETIvdzdFGKKAogiK3dZx4oX8JJF46cZkkCnPGXR/rSz4yyjIbLnrI+CDqfMmP9E9512bxawE/eJeInmsoJQshk9F8kwWN0BcnN/P5B5LiSQ0+rUXI+X8puAUoOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ0TTGpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C682C4CEEA;
	Wed, 26 Feb 2025 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740604219;
	bh=G4luJRCzXNfx/9fY/vly1vKyrwbSCswByVM2PkliHiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJ0TTGpmoJjxzwP5Qnm5PU/7mhW2lsyifK/nTJ+Z00jAx/txTctw3ti8S/+Fu4NW7
	 VwyYHuPZEr2RSM8Ps68rgtTQ/6OZKZUSoe4HzfpzP8nWhUfiKu+BfsgNI0NH/dWmCX
	 Jx46Q3X8xd0HXxmDVM9oXAPjghEX3SmMUUxW5jgfyyUsojKlYI5P2aI46sZt28FCar
	 CQMKecC8J/q9BX1oU6imkYjQro39TWiXAv2nmwcPMQJNmCNSHAnfdwefCkpz5cJvAU
	 ccY1hebM75GwuV92uNvRbgkXW2rJXdeMjdUijl0XE3uC9ckrWUf1X1JjnYyZxmQaoA
	 9H1xF2FeV/q5A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/9] eth: bnxt: rename ring_err_stats -> ring_drv_stats
Date: Wed, 26 Feb 2025 13:09:57 -0800
Message-ID: <20250226211003.2790916-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226211003.2790916-1-kuba@kernel.org>
References: <20250226211003.2790916-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will soon store non-error stats to the ring struct.
Rename them to "drv" stats, as these are all maintained
by the driver (even if partially based on info from descriptors).

Pure rename using sed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  8 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 14 +++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 14 +++++++-------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e85b5ce94f58..34f23ddd4d71 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1136,7 +1136,7 @@ struct bnxt_sw_stats {
 	struct bnxt_cmn_sw_stats cmn;
 };
 
-struct bnxt_total_ring_err_stats {
+struct bnxt_total_ring_drv_stats {
 	u64			rx_total_l4_csum_errors;
 	u64			rx_total_resets;
 	u64			rx_total_buf_errors;
@@ -2538,7 +2538,7 @@ struct bnxt {
 	u8			pri2cos_idx[8];
 	u8			pri2cos_valid;
 
-	struct bnxt_total_ring_err_stats ring_err_stats_prev;
+	struct bnxt_total_ring_drv_stats ring_drv_stats_prev;
 
 	u16			hwrm_max_req_len;
 	u16			hwrm_max_ext_req_len;
@@ -2936,8 +2936,8 @@ int bnxt_half_open_nic(struct bnxt *bp);
 void bnxt_half_close_nic(struct bnxt *bp);
 void bnxt_reenable_sriov(struct bnxt *bp);
 void bnxt_close_nic(struct bnxt *, bool, bool);
-void bnxt_get_ring_err_stats(struct bnxt *bp,
-			     struct bnxt_total_ring_err_stats *stats);
+void bnxt_get_ring_drv_stats(struct bnxt *bp,
+			     struct bnxt_total_ring_drv_stats *stats);
 bool bnxt_rfs_capable(struct bnxt *bp, bool new_rss_ctx);
 int bnxt_dbg_hwrm_rd_reg(struct bnxt *bp, u32 reg_off, u16 num_words,
 			 u32 *reg_buf);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 53b689800e1c..29515d6c6cdd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12940,7 +12940,7 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 	/* Save ring stats before shutdown */
 	if (bp->bnapi && irq_re_init) {
 		bnxt_get_ring_stats(bp, &bp->net_stats_prev);
-		bnxt_get_ring_err_stats(bp, &bp->ring_err_stats_prev);
+		bnxt_get_ring_drv_stats(bp, &bp->ring_drv_stats_prev);
 	}
 	if (irq_re_init) {
 		bnxt_free_irq(bp);
@@ -13190,8 +13190,8 @@ bnxt_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	clear_bit(BNXT_STATE_READ_STATS, &bp->state);
 }
 
-static void bnxt_get_one_ring_err_stats(struct bnxt *bp,
-					struct bnxt_total_ring_err_stats *stats,
+static void bnxt_get_one_ring_drv_stats(struct bnxt *bp,
+					struct bnxt_total_ring_drv_stats *stats,
 					struct bnxt_cp_ring_info *cpr)
 {
 	struct bnxt_sw_stats *sw_stats = cpr->sw_stats;
@@ -13210,13 +13210,13 @@ static void bnxt_get_one_ring_err_stats(struct bnxt *bp,
 	stats->total_missed_irqs += sw_stats->cmn.missed_irqs;
 }
 
-void bnxt_get_ring_err_stats(struct bnxt *bp,
-			     struct bnxt_total_ring_err_stats *stats)
+void bnxt_get_ring_drv_stats(struct bnxt *bp,
+			     struct bnxt_total_ring_drv_stats *stats)
 {
 	int i;
 
 	for (i = 0; i < bp->cp_nr_rings; i++)
-		bnxt_get_one_ring_err_stats(bp, stats, &bp->bnapi[i]->cp_ring);
+		bnxt_get_one_ring_drv_stats(bp, stats, &bp->bnapi[i]->cp_ring);
 }
 
 static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
@@ -15642,7 +15642,7 @@ static void bnxt_get_base_stats(struct net_device *dev,
 
 	rx->packets = bp->net_stats_prev.rx_packets;
 	rx->bytes = bp->net_stats_prev.rx_bytes;
-	rx->alloc_fail = bp->ring_err_stats_prev.rx_total_oom_discards;
+	rx->alloc_fail = bp->ring_drv_stats_prev.rx_total_oom_discards;
 
 	tx->packets = bp->net_stats_prev.tx_packets;
 	tx->bytes = bp->net_stats_prev.tx_bytes;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9c5820839514..df726a31192b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -340,7 +340,7 @@ enum {
 	RX_NETPOLL_DISCARDS,
 };
 
-static const char *const bnxt_ring_err_stats_arr[] = {
+static const char *const bnxt_ring_drv_stats_arr[] = {
 	"rx_total_l4_csum_errors",
 	"rx_total_resets",
 	"rx_total_buf_errors",
@@ -500,7 +500,7 @@ static const struct {
 	BNXT_TX_STATS_PRI_ENTRIES(tx_packets),
 };
 
-#define BNXT_NUM_RING_ERR_STATS	ARRAY_SIZE(bnxt_ring_err_stats_arr)
+#define BNXT_NUM_RING_ERR_STATS	ARRAY_SIZE(bnxt_ring_drv_stats_arr)
 #define BNXT_NUM_PORT_STATS ARRAY_SIZE(bnxt_port_stats_arr)
 #define BNXT_NUM_STATS_PRI			\
 	(ARRAY_SIZE(bnxt_rx_bytes_pri_arr) +	\
@@ -594,7 +594,7 @@ static bool is_tx_ring(struct bnxt *bp, int ring_num)
 static void bnxt_get_ethtool_stats(struct net_device *dev,
 				   struct ethtool_stats *stats, u64 *buf)
 {
-	struct bnxt_total_ring_err_stats ring_err_stats = {0};
+	struct bnxt_total_ring_drv_stats ring_drv_stats = {0};
 	struct bnxt *bp = netdev_priv(dev);
 	u64 *curr, *prev;
 	u32 tpa_stats;
@@ -643,11 +643,11 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
 			buf[j] = sw[k];
 	}
 
-	bnxt_get_ring_err_stats(bp, &ring_err_stats);
+	bnxt_get_ring_drv_stats(bp, &ring_drv_stats);
 
 skip_ring_stats:
-	curr = &ring_err_stats.rx_total_l4_csum_errors;
-	prev = &bp->ring_err_stats_prev.rx_total_l4_csum_errors;
+	curr = &ring_drv_stats.rx_total_l4_csum_errors;
+	prev = &bp->ring_drv_stats_prev.rx_total_l4_csum_errors;
 	for (i = 0; i < BNXT_NUM_RING_ERR_STATS; i++, j++, curr++, prev++)
 		buf[j] = *curr + *prev;
 
@@ -753,7 +753,7 @@ static void bnxt_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 			}
 		}
 		for (i = 0; i < BNXT_NUM_RING_ERR_STATS; i++)
-			ethtool_puts(&buf, bnxt_ring_err_stats_arr[i]);
+			ethtool_puts(&buf, bnxt_ring_drv_stats_arr[i]);
 
 		if (bp->flags & BNXT_FLAG_PORT_STATS)
 			for (i = 0; i < BNXT_NUM_PORT_STATS; i++) {
-- 
2.48.1


