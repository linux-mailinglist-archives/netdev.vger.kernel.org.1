Return-Path: <netdev+bounces-260187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wISuFvG6nGlSKAQAu9opvQ
	(envelope-from <netdev+bounces-260187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:39:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B58F317D049
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36B543025915
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B215334BA59;
	Mon, 23 Feb 2026 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAI0VFpm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9009C19CC0C
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879025; cv=none; b=KpeScuncxd0Cnae5fX/DWPGRcj8cBHjHRtELj+fWrgzNMu/lDzbh/TZ+2dDcZlE6penTglsLus7u5n86xrJ+1l9yJo5qgJx6LuthDmSkfePNCb6lQB6YbmbvM8mUQ/evxiCd1X8ECf5S+SMKGC2gIVWZWk7zLgBUTS+3EVbUJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879025; c=relaxed/simple;
	bh=HNbVfofAtrTChUbxlzWLT6uWaCM3H0W62hiTI29Lano=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWJQPg+Cut09WGzWbKYaC3UlLeoUVTuBahSeV431MojKI7KDrZ81Y2WGvL5uRdQbtBXCg9n+Vc4e9en4AK8S0DhKXSe+LMkzl2r8GtNzzt22Sfeeq1Vkfb2HlP/fJdIbJGylrcsXu4M3xLzqmoahevp9qWpzC0AAatcaV4AqV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAI0VFpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83187C116C6;
	Mon, 23 Feb 2026 20:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771879024;
	bh=HNbVfofAtrTChUbxlzWLT6uWaCM3H0W62hiTI29Lano=;
	h=From:To:Cc:Subject:Date:From;
	b=mAI0VFpmbCpDX2CRs5q6KhAvvtCEM8ElD+tOvDuUghIU891vhHMhO0D4QZimoWoAL
	 FZN1K8WZegevLcYTzwNVS2hKOa/B044u+q1HCFV9a+V6FdD6FGZqgHNxBWxypR1/hh
	 mAlIsT5jLdVzyqWTklQONwW4ciw2piFjhfEqHkIDGn9oiXWkp+l7Ga+aueuQCrx6We
	 fGX/eJxuidmKMriKwTf1nTwSVsJR5O/uuhiye1fFZD/kegQxykp/s1EahnDv+KHDNc
	 T2dLJdg5jBU0kIrZBbtQ1VNXrMCLx7afFvGMFSbOJ0X0eP5IbZ5eDVcQ2R/ZXph+0F
	 PcHtJhyha/GRw==
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
Subject: [PATCH net-next] eth: bnxt: rename ring_err_stats -> ring_drv_stats
Date: Mon, 23 Feb 2026 12:37:01 -0800
Message-ID: <20260223203702.4137801-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260187-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B58F317D049
X-Rspamd-Action: no action

We recently added GRO stats to bnxt, which are maintained
by the driver. Having "err" in the name of the struct for
ring stats no longer makes sense (as pointed out by Michael,
see Link).

Rename them to "drv" stats, as these are all maintained
by the driver (even if partially based on info from descriptors).
Michael suggested calling these misc, happy to go back to
that. IMHO "drv" is a bit more meaningful that "misc".

Pure rename using sed, no functional changes.

Link: https://lore.kernel.org/CACKFLimgibJ0qkM1AacZVh8MKKy-pE_AAc4KPKZ7GUqebmXW9A@mail.gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  8 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 18 ++++++++---------
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 20 +++++++++----------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9a41b9e0423c..90fa3e93c8d6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1147,7 +1147,7 @@ struct bnxt_sw_stats {
 	struct bnxt_cmn_sw_stats cmn;
 };
 
-struct bnxt_total_ring_err_stats {
+struct bnxt_total_ring_drv_stats {
 	u64			rx_total_l4_csum_errors;
 	u64			rx_total_resets;
 	u64			rx_total_buf_errors;
@@ -2572,7 +2572,7 @@ struct bnxt {
 	u8			pri2cos_idx[8];
 	u8			pri2cos_valid;
 
-	struct bnxt_total_ring_err_stats ring_err_stats_prev;
+	struct bnxt_total_ring_drv_stats ring_drv_stats_prev;
 
 	u16			hwrm_max_req_len;
 	u16			hwrm_max_ext_req_len;
@@ -2974,8 +2974,8 @@ int bnxt_half_open_nic(struct bnxt *bp);
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
index fb45e1dd1dd7..ba010bdc1e71 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13252,7 +13252,7 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 	/* Save ring stats before shutdown */
 	if (bp->bnapi && irq_re_init) {
 		bnxt_get_ring_stats(bp, &bp->net_stats_prev);
-		bnxt_get_ring_err_stats(bp, &bp->ring_err_stats_prev);
+		bnxt_get_ring_drv_stats(bp, &bp->ring_drv_stats_prev);
 	}
 	if (irq_re_init) {
 		bnxt_free_irq(bp);
@@ -13497,8 +13497,8 @@ bnxt_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	clear_bit(BNXT_STATE_READ_STATS, &bp->state);
 }
 
-static void bnxt_get_one_ring_err_stats(struct bnxt *bp,
-					struct bnxt_total_ring_err_stats *stats,
+static void bnxt_get_one_ring_drv_stats(struct bnxt *bp,
+					struct bnxt_total_ring_drv_stats *stats,
 					struct bnxt_cp_ring_info *cpr)
 {
 	struct bnxt_sw_stats *sw_stats = cpr->sw_stats;
@@ -13519,13 +13519,13 @@ static void bnxt_get_one_ring_err_stats(struct bnxt *bp,
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
@@ -15970,9 +15970,9 @@ static void bnxt_get_base_stats(struct net_device *dev,
 
 	rx->packets = bp->net_stats_prev.rx_packets;
 	rx->bytes = bp->net_stats_prev.rx_bytes;
-	rx->alloc_fail = bp->ring_err_stats_prev.rx_total_oom_discards;
-	rx->hw_gro_packets = bp->ring_err_stats_prev.rx_total_hw_gro_packets;
-	rx->hw_gro_wire_packets = bp->ring_err_stats_prev.rx_total_hw_gro_wire_packets;
+	rx->alloc_fail = bp->ring_drv_stats_prev.rx_total_oom_discards;
+	rx->hw_gro_packets = bp->ring_drv_stats_prev.rx_total_hw_gro_packets;
+	rx->hw_gro_wire_packets = bp->ring_drv_stats_prev.rx_total_hw_gro_wire_packets;
 
 	tx->packets = bp->net_stats_prev.tx_packets;
 	tx->bytes = bp->net_stats_prev.tx_bytes;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 53a83b6680c4..283be8767a99 100644
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
+#define BNXT_NUM_RING_DRV_STATS	ARRAY_SIZE(bnxt_ring_drv_stats_arr)
 #define BNXT_NUM_PORT_STATS ARRAY_SIZE(bnxt_port_stats_arr)
 #define BNXT_NUM_STATS_PRI			\
 	(ARRAY_SIZE(bnxt_rx_bytes_pri_arr) +	\
@@ -539,7 +539,7 @@ static int bnxt_get_num_stats(struct bnxt *bp)
 	int num_stats = bnxt_get_num_ring_stats(bp);
 	int len;
 
-	num_stats += BNXT_NUM_RING_ERR_STATS;
+	num_stats += BNXT_NUM_RING_DRV_STATS;
 
 	if (bp->flags & BNXT_FLAG_PORT_STATS)
 		num_stats += BNXT_NUM_PORT_STATS;
@@ -594,7 +594,7 @@ static bool is_tx_ring(struct bnxt *bp, int ring_num)
 static void bnxt_get_ethtool_stats(struct net_device *dev,
 				   struct ethtool_stats *stats, u64 *buf)
 {
-	struct bnxt_total_ring_err_stats ring_err_stats = {0};
+	struct bnxt_total_ring_drv_stats ring_drv_stats = {0};
 	struct bnxt *bp = netdev_priv(dev);
 	u64 *curr, *prev;
 	u32 tpa_stats;
@@ -643,12 +643,12 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
 			buf[j] = sw[k];
 	}
 
-	bnxt_get_ring_err_stats(bp, &ring_err_stats);
+	bnxt_get_ring_drv_stats(bp, &ring_drv_stats);
 
 skip_ring_stats:
-	curr = &ring_err_stats.rx_total_l4_csum_errors;
-	prev = &bp->ring_err_stats_prev.rx_total_l4_csum_errors;
-	for (i = 0; i < BNXT_NUM_RING_ERR_STATS; i++, j++, curr++, prev++)
+	curr = &ring_drv_stats.rx_total_l4_csum_errors;
+	prev = &bp->ring_drv_stats_prev.rx_total_l4_csum_errors;
+	for (i = 0; i < BNXT_NUM_RING_DRV_STATS; i++, j++, curr++, prev++)
 		buf[j] = *curr + *prev;
 
 	if (bp->flags & BNXT_FLAG_PORT_STATS) {
@@ -758,8 +758,8 @@ static void bnxt_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 				ethtool_sprintf(&buf, "[%d]: %s", i, str);
 			}
 		}
-		for (i = 0; i < BNXT_NUM_RING_ERR_STATS; i++)
-			ethtool_puts(&buf, bnxt_ring_err_stats_arr[i]);
+		for (i = 0; i < BNXT_NUM_RING_DRV_STATS; i++)
+			ethtool_puts(&buf, bnxt_ring_drv_stats_arr[i]);
 
 		if (bp->flags & BNXT_FLAG_PORT_STATS)
 			for (i = 0; i < BNXT_NUM_PORT_STATS; i++) {
-- 
2.53.0


