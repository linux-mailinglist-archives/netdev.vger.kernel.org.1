Return-Path: <netdev+bounces-49459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFC07F219B
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDC3281493
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA1A3B79C;
	Mon, 20 Nov 2023 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ewwFf6o1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C697AA
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:56 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41cbd2cf3bbso51393561cf.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700523895; x=1701128695; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3mzhNqod3yErA5m58WFR0zvvtciUsw1iyXqWUCiTp0=;
        b=ewwFf6o12YkXJWrqwGcPejnxbCn++2nqPgOApJHrVDvDF3WVVZs+EK+ZiZRoSjaHOM
         khHje28yL9PsY9tEXeIITKh3bjZclVd55XoXF0e4PSS7Cz0ZCG9kLjNx0vHhxObGWPxT
         cbdobAe05tKuBtXqYQcrKF7jmS0SwfZknweek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523895; x=1701128695;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3mzhNqod3yErA5m58WFR0zvvtciUsw1iyXqWUCiTp0=;
        b=u3ct4o3tl7m0CW4QZ3yHegZeMio6bpke/k2lYRLmr/7GUUhDeBSnFmIy7cFpdgXkJg
         f+p7WFFLHAs4lmn9TwYhxf06G2GBF7tHx1CAmDR37lT/wMezT+igyYWy7ee/Lajikqwt
         cPk0N32KQfxYFDCf/wDjcATZw9XXJAEAm7AY9sywATRx8ldx5kajhGaomjSGo7cuSf1H
         vPiohIKG4PrV+U6417aDUWg3Omm5C4l+CUTXsri6EaN1lv9vBU8NlR0hDMD5vHenYnDO
         q+QTqgpmFfafWTpcOuC1HiS+AFcSB+CYYOJiQ1UoZb5pVpnMZrhcV0GlLhhwmyg+e+iw
         uQbA==
X-Gm-Message-State: AOJu0Yz4X80b8inSRqH3rmEEJosURsoK1tWSZ61dhNTbAHjT4ZY1bOg1
	2wmRKYHxHT4yM7nmKOJeLV33rg==
X-Google-Smtp-Source: AGHT+IF1CevDmmYVf17u1OW9w9ql3RZwEMP0KFF1p8mWIHMpFnPYM06/klN2bz2oO8b7DSy/WVlvQA==
X-Received: by 2002:a05:622a:5d84:b0:416:4cc5:2f51 with SMTP id fu4-20020a05622a5d8400b004164cc52f51mr1406544qtb.1.1700523895145;
        Mon, 20 Nov 2023 15:44:55 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i9-20020ac871c9000000b0041803dfb240sm3053384qtp.45.2023.11.20.15.44.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:44:54 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Randy Schacher <stuart.schacher@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 13/13] bnxt_en: Rename some macros for the P5 chips
Date: Mon, 20 Nov 2023 15:44:05 -0800
Message-Id: <20231120234405.194542-14-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231120234405.194542-1-michael.chan@broadcom.com>
References: <20231120234405.194542-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bc6637060a9e1203"

--000000000000bc6637060a9e1203
Content-Transfer-Encoding: 8bit

From: Randy Schacher <stuart.schacher@broadcom.com>

In preparation to support a new P7 chip which has a lot of similarities
with the P5 chip, rename the BNXT_FLAG_CHIP_P5 flag to
BNXT_FLAG_CHIP_P5_PLUS.  This will make it clear that the flag is for
P5 and newer chips.

Also, since there are no additional P5 variants in production, rename
BNXT_FLAG_CHIP_P5_THOR() to BNXT_FLAG_CHIP_P5() to keep the naming
more simple.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Randy Schacher <stuart.schacher@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 184 +++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  18 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   8 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |   4 +-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |   2 +-
 7 files changed, 116 insertions(+), 114 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f968bf12989b..d8cf7b30bd03 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -269,7 +269,7 @@ static bool bnxt_vf_pciid(enum board_idx idx)
 
 static void bnxt_db_nq(struct bnxt *bp, struct bnxt_db_info *db, u32 idx)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		BNXT_DB_NQ_P5(db, idx);
 	else
 		BNXT_DB_CQ(db, idx);
@@ -277,7 +277,7 @@ static void bnxt_db_nq(struct bnxt *bp, struct bnxt_db_info *db, u32 idx)
 
 static void bnxt_db_nq_arm(struct bnxt *bp, struct bnxt_db_info *db, u32 idx)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		BNXT_DB_NQ_ARM_P5(db, idx);
 	else
 		BNXT_DB_CQ_ARM(db, idx);
@@ -285,7 +285,7 @@ static void bnxt_db_nq_arm(struct bnxt *bp, struct bnxt_db_info *db, u32 idx)
 
 static void bnxt_db_cq(struct bnxt *bp, struct bnxt_db_info *db, u32 idx)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		bnxt_writeq(bp, db->db_key64 | DBR_TYPE_CQ_ARMALL |
 			    DB_RING_IDX(db, idx), db->doorbell);
 	else
@@ -321,7 +321,7 @@ static void bnxt_sched_reset_rxr(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 {
 	if (!rxr->bnapi->in_reset) {
 		rxr->bnapi->in_reset = true;
-		if (bp->flags & BNXT_FLAG_CHIP_P5)
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 			set_bit(BNXT_RESET_TASK_SP_EVENT, &bp->sp_event);
 		else
 			set_bit(BNXT_RST_RING_SP_EVENT, &bp->sp_event);
@@ -739,7 +739,7 @@ static void __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 				DMA_TO_DEVICE);
 		}
 		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)) {
-			if (bp->flags & BNXT_FLAG_CHIP_P5) {
+			if (BNXT_CHIP_P5(bp)) {
 				/* PTP worker takes ownership of the skb */
 				if (!bnxt_get_tx_ts_p5(bp, skb))
 					skb = NULL;
@@ -946,7 +946,7 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
 	bool p5_tpa = false;
 	u32 i;
 
-	if ((bp->flags & BNXT_FLAG_CHIP_P5) && tpa)
+	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && tpa)
 		p5_tpa = true;
 
 	for (i = 0; i < agg_bufs; i++) {
@@ -1113,7 +1113,7 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 	u32 i, total_frag_len = 0;
 	bool p5_tpa = false;
 
-	if ((bp->flags & BNXT_FLAG_CHIP_P5) && tpa)
+	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && tpa)
 		p5_tpa = true;
 
 	for (i = 0; i < agg_bufs; i++) {
@@ -1268,7 +1268,7 @@ static int bnxt_discard_rx(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	} else if (cmp_type == CMP_TYPE_RX_L2_TPA_END_CMP) {
 		struct rx_tpa_end_cmp *tpa_end = cmp;
 
-		if (bp->flags & BNXT_FLAG_CHIP_P5)
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 			return 0;
 
 		agg_bufs = TPA_END_AGG_BUFS(tpa_end);
@@ -1319,7 +1319,7 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	struct rx_bd *prod_bd;
 	dma_addr_t mapping;
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		agg_id = TPA_START_AGG_ID_P5(tpa_start);
 		agg_id = bnxt_alloc_agg_idx(rxr, agg_id);
 	} else {
@@ -1582,7 +1582,7 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 	skb_shinfo(skb)->gso_size =
 		le32_to_cpu(tpa_end1->rx_tpa_end_cmp_seg_len);
 	skb_shinfo(skb)->gso_type = tpa_info->gso_type;
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		payload_off = TPA_END_PAYLOAD_OFF_P5(tpa_end1);
 	else
 		payload_off = TPA_END_PAYLOAD_OFF(tpa_end);
@@ -1630,7 +1630,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		return NULL;
 	}
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		agg_id = TPA_END_AGG_ID_P5(tpa_end);
 		agg_id = bnxt_lookup_agg_idx(rxr, agg_id);
 		agg_bufs = TPA_END_AGG_BUFS_P5(tpa_end1);
@@ -1895,7 +1895,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		rc = -EIO;
 		if (rx_err & RX_CMPL_ERRORS_BUFFER_ERROR_MASK) {
 			bnapi->cp_ring.sw_stats.rx.rx_buf_errors++;
-			if (!(bp->flags & BNXT_FLAG_CHIP_P5) &&
+			if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
 			    !(bp->fw_cap & BNXT_FW_CAP_RING_MONITOR)) {
 				netdev_warn_once(bp->dev, "RX buffer error %x\n",
 						 rx_err);
@@ -2026,7 +2026,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 	if (unlikely((flags & RX_CMP_FLAGS_ITYPES_MASK) ==
 		     RX_CMP_FLAGS_ITYPE_PTP_W_TS) || bp->ptp_all_rx_tstamp) {
-		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			u32 cmpl_ts = le32_to_cpu(rxcmp1->rx_cmp_timestamp);
 			u64 ns, ts;
 
@@ -2434,7 +2434,7 @@ static int bnxt_async_event_process(struct bnxt *bp,
 		struct bnxt_rx_ring_info *rxr;
 		u16 grp_idx;
 
-		if (bp->flags & BNXT_FLAG_CHIP_P5)
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 			goto async_event_process_exit;
 
 		netdev_warn(bp->dev, "Ring monitor event, ring type %lu id 0x%x\n",
@@ -3258,7 +3258,7 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
 	int i, j;
 
 	bp->max_tpa = MAX_TPA;
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		if (!bp->max_tpa_v2)
 			return 0;
 		bp->max_tpa = max_t(u16, bp->max_tpa_v2, MAX_TPA_P5);
@@ -3273,7 +3273,7 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
 		if (!rxr->rx_tpa)
 			return -ENOMEM;
 
-		if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+		if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 			continue;
 		for (j = 0; j < bp->max_tpa; j++) {
 			agg = kcalloc(MAX_SKB_FRAGS, sizeof(*agg), GFP_KERNEL);
@@ -3651,7 +3651,7 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 		else
 			ring->map_idx = i;
 
-		if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+		if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 			continue;
 
 		if (i < bp->rx_nr_rings) {
@@ -3965,7 +3965,7 @@ static int bnxt_alloc_vnics(struct bnxt *bp)
 	int num_vnics = 1;
 
 #ifdef CONFIG_RFS_ACCEL
-	if ((bp->flags & (BNXT_FLAG_RFS | BNXT_FLAG_CHIP_P5)) == BNXT_FLAG_RFS)
+	if ((bp->flags & (BNXT_FLAG_RFS | BNXT_FLAG_CHIP_P5_PLUS)) == BNXT_FLAG_RFS)
 		num_vnics += bp->rx_nr_rings;
 #endif
 
@@ -4238,7 +4238,7 @@ static int bnxt_alloc_vnic_attributes(struct bnxt *bp)
 			}
 		}
 
-		if (bp->flags & BNXT_FLAG_CHIP_P5)
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 			goto vnic_skip_grps;
 
 		if (vnic->flags & BNXT_VNIC_RSS_FLAG)
@@ -4258,7 +4258,7 @@ static int bnxt_alloc_vnic_attributes(struct bnxt *bp)
 
 		/* Allocate rss table and hash key */
 		size = L1_CACHE_ALIGN(HW_HASH_INDEX_SIZE * sizeof(u16));
-		if (bp->flags & BNXT_FLAG_CHIP_P5)
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 			size = L1_CACHE_ALIGN(BNXT_MAX_RSS_TABLE_SIZE_P5);
 
 		vnic->rss_table_size = size + HW_HASH_KEY_SIZE;
@@ -4368,7 +4368,7 @@ static int bnxt_hwrm_func_qstat_ext(struct bnxt *bp,
 	int rc;
 
 	if (!(bp->fw_cap & BNXT_FW_CAP_EXT_HW_STATS_SUPPORTED) ||
-	    !(bp->flags & BNXT_FLAG_CHIP_P5))
+	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		return -EOPNOTSUPP;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_QSTATS_EXT);
@@ -4406,7 +4406,7 @@ static void bnxt_init_stats(struct bnxt *bp)
 	stats = &cpr->stats;
 	rc = bnxt_hwrm_func_qstat_ext(bp, stats);
 	if (rc) {
-		if (bp->flags & BNXT_FLAG_CHIP_P5)
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 			mask = (1ULL << 48) - 1;
 		else
 			mask = -1ULL;
@@ -4686,7 +4686,7 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 			bp->bnapi[i] = bnapi;
 			bp->bnapi[i]->index = i;
 			bp->bnapi[i]->bp = bp;
-			if (bp->flags & BNXT_FLAG_CHIP_P5) {
+			if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 				struct bnxt_cp_ring_info *cpr =
 					&bp->bnapi[i]->cp_ring;
 
@@ -4704,7 +4704,7 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 		for (i = 0; i < bp->rx_nr_rings; i++) {
 			struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
 
-			if (bp->flags & BNXT_FLAG_CHIP_P5) {
+			if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 				rxr->rx_ring_struct.ring_mem.flags =
 					BNXT_RMEM_RING_PTE_FLAG;
 				rxr->rx_agg_ring_struct.ring_mem.flags =
@@ -4737,7 +4737,7 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 			struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
 			struct bnxt_napi *bnapi2;
 
-			if (bp->flags & BNXT_FLAG_CHIP_P5)
+			if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 				txr->tx_ring_struct.ring_mem.flags =
 					BNXT_RMEM_RING_PTE_FLAG;
 			bp->tx_ring_map[i] = bp->tx_nr_rings_xdp + i;
@@ -4758,7 +4758,7 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 				j++;
 			}
 			txr->bnapi = bnapi2;
-			if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+			if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 				txr->tx_cpr = &bnapi2->cp_ring;
 		}
 
@@ -5284,7 +5284,7 @@ static int bnxt_hwrm_vnic_set_tpa(struct bnxt *bp, u16 vnic_id, u32 tpa_flags)
 			nsegs = (MAX_SKB_FRAGS - n) / n;
 		}
 
-		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			segs = MAX_TPA_SEGS_P5;
 			max_aggs = bp->max_tpa;
 		} else {
@@ -5310,7 +5310,7 @@ static u16 bnxt_cp_ring_from_grp(struct bnxt *bp, struct bnxt_ring_struct *ring)
 
 static u16 bnxt_cp_ring_for_rx(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return rxr->rx_cpr->cp_ring_struct.fw_ring_id;
 	else
 		return bnxt_cp_ring_from_grp(bp, &rxr->rx_ring_struct);
@@ -5318,7 +5318,7 @@ static u16 bnxt_cp_ring_for_rx(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 
 static u16 bnxt_cp_ring_for_tx(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return txr->tx_cpr->cp_ring_struct.fw_ring_id;
 	else
 		return bnxt_cp_ring_from_grp(bp, &txr->tx_ring_struct);
@@ -5328,7 +5328,7 @@ static int bnxt_alloc_rss_indir_tbl(struct bnxt *bp)
 {
 	int entries;
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		entries = BNXT_MAX_RSS_TABLE_ENTRIES_P5;
 	else
 		entries = HW_HASH_INDEX_SIZE;
@@ -5378,7 +5378,7 @@ static u16 bnxt_get_max_rss_ring(struct bnxt *bp)
 
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return DIV_ROUND_UP(rx_rings, BNXT_RSS_TABLE_ENTRIES_P5);
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp))
 		return 2;
@@ -5424,7 +5424,7 @@ static void
 __bnxt_hwrm_vnic_set_rss(struct bnxt *bp, struct hwrm_vnic_rss_cfg_input *req,
 			 struct bnxt_vnic_info *vnic)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		bnxt_fill_hw_rss_tbl_p5(bp, vnic);
 	else
 		bnxt_fill_hw_rss_tbl(bp, vnic);
@@ -5449,7 +5449,7 @@ static int bnxt_hwrm_vnic_set_rss(struct bnxt *bp, u16 vnic_id, bool set_rss)
 	struct hwrm_vnic_rss_cfg_input *req;
 	int rc;
 
-	if ((bp->flags & BNXT_FLAG_CHIP_P5) ||
+	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) ||
 	    vnic->fw_rss_cos_lb_ctx[0] == INVALID_HW_RING_ID)
 		return 0;
 
@@ -5614,7 +5614,7 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, u16 vnic_id)
 	if (rc)
 		return rc;
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[0];
 
 		req->default_rx_ring_id =
@@ -5714,7 +5714,7 @@ static int bnxt_hwrm_vnic_alloc(struct bnxt *bp, u16 vnic_id,
 	if (rc)
 		return rc;
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		goto vnic_no_ring_grps;
 
 	/* map ring groups to this vnic */
@@ -5762,7 +5762,7 @@ static int bnxt_hwrm_vnic_qcaps(struct bnxt *bp)
 	if (!rc) {
 		u32 flags = le32_to_cpu(resp->flags);
 
-		if (!(bp->flags & BNXT_FLAG_CHIP_P5) &&
+		if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
 		    (flags & VNIC_QCAPS_RESP_FLAGS_RSS_DFLT_CR_CAP))
 			bp->flags |= BNXT_FLAG_NEW_RSS_CAP;
 		if (flags &
@@ -5773,14 +5773,14 @@ static int bnxt_hwrm_vnic_qcaps(struct bnxt *bp)
 		 * VLAN_STRIP_CAP properly.
 		 */
 		if ((flags & VNIC_QCAPS_RESP_FLAGS_VLAN_STRIP_CAP) ||
-		    (BNXT_CHIP_P5_THOR(bp) &&
+		    (BNXT_CHIP_P5(bp) &&
 		     !(bp->fw_cap & BNXT_FW_CAP_EXT_HW_STATS_SUPPORTED)))
 			bp->fw_cap |= BNXT_FW_CAP_VLAN_RX_STRIP;
 		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_HASH_TYPE_DELTA_CAP)
 			bp->fw_cap |= BNXT_FW_CAP_RSS_HASH_TYPE_DELTA;
 		bp->max_tpa_v2 = le16_to_cpu(resp->max_aggs_supported);
 		if (bp->max_tpa_v2) {
-			if (BNXT_CHIP_P5_THOR(bp))
+			if (BNXT_CHIP_P5(bp))
 				bp->hw_ring_stats_size = BNXT_RING_STATS_SIZE_P5;
 			else
 				bp->hw_ring_stats_size = BNXT_RING_STATS_SIZE_P5_SR2;
@@ -5797,7 +5797,7 @@ static int bnxt_hwrm_ring_grp_alloc(struct bnxt *bp)
 	int rc;
 	u16 i;
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return 0;
 
 	rc = hwrm_req_init(bp, req, HWRM_RING_GRP_ALLOC);
@@ -5830,7 +5830,7 @@ static void bnxt_hwrm_ring_grp_free(struct bnxt *bp)
 	struct hwrm_ring_grp_free_input *req;
 	u16 i;
 
-	if (!bp->grp_info || (bp->flags & BNXT_FLAG_CHIP_P5))
+	if (!bp->grp_info || (bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		return;
 
 	if (hwrm_req_init(bp, req, HWRM_RING_GRP_FREE))
@@ -5895,7 +5895,7 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 	case HWRM_RING_ALLOC_RX:
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX;
 		req->length = cpu_to_le32(bp->rx_ring_mask + 1);
-		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			u16 flags = 0;
 
 			/* Association of rx ring with stats context */
@@ -5910,7 +5910,7 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 		}
 		break;
 	case HWRM_RING_ALLOC_AGG:
-		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
 			/* Association of agg ring with rx ring */
 			grp_info = &bp->grp_info[ring->grp_idx];
@@ -5928,7 +5928,7 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 	case HWRM_RING_ALLOC_CMPL:
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_L2_CMPL;
 		req->length = cpu_to_le32(bp->cp_ring_mask + 1);
-		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			/* Association of cp ring with nq */
 			grp_info = &bp->grp_info[map_index];
 			req->nq_ring_id = cpu_to_le16(grp_info->cp_fw_ring_id);
@@ -6019,7 +6019,7 @@ static void bnxt_set_db_mask(struct bnxt *bp, struct bnxt_db_info *db,
 static void bnxt_set_db(struct bnxt *bp, struct bnxt_db_info *db, u32 ring_type,
 			u32 map_idx, u32 xid)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		if (BNXT_PF(bp))
 			db->doorbell = bp->bar1 + DB_PF_OFFSET_P5;
 		else
@@ -6064,7 +6064,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 	int i, rc = 0;
 	u32 type;
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		type = HWRM_RING_ALLOC_NQ;
 	else
 		type = HWRM_RING_ALLOC_CMPL;
@@ -6100,7 +6100,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 		struct bnxt_ring_struct *ring;
 		u32 map_idx;
 
-		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			struct bnxt_cp_ring_info *cpr2 = txr->tx_cpr;
 			struct bnxt_napi *bnapi = txr->bnapi;
 			u32 type2 = HWRM_RING_ALLOC_CMPL;
@@ -6138,7 +6138,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 		if (!agg_rings)
 			bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
 		bp->grp_info[map_idx].rx_fw_ring_id = ring->fw_ring_id;
-		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			struct bnxt_cp_ring_info *cpr2 = rxr->rx_cpr;
 			u32 type2 = HWRM_RING_ALLOC_CMPL;
 
@@ -6251,7 +6251,7 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 		}
 	}
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		type = RING_FREE_REQ_RING_TYPE_RX_AGG;
 	else
 		type = RING_FREE_REQ_RING_TYPE_RX;
@@ -6278,7 +6278,7 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 	 */
 	bnxt_disable_int_sync(bp);
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		type = RING_FREE_REQ_RING_TYPE_NQ;
 	else
 		type = RING_FREE_REQ_RING_TYPE_L2_CMPL;
@@ -6345,7 +6345,7 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
 		cp = le16_to_cpu(resp->alloc_cmpl_rings);
 		stats = le16_to_cpu(resp->alloc_stat_ctx);
 		hw_resc->resv_irqs = cp;
-		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			int rx = hw_resc->resv_rx_rings;
 			int tx = hw_resc->resv_tx_rings;
 
@@ -6410,7 +6410,7 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 	if (BNXT_NEW_RM(bp)) {
 		enables |= rx_rings ? FUNC_CFG_REQ_ENABLES_NUM_RX_RINGS : 0;
 		enables |= stats ? FUNC_CFG_REQ_ENABLES_NUM_STAT_CTXS : 0;
-		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			enables |= cp_rings ? FUNC_CFG_REQ_ENABLES_NUM_MSIX : 0;
 			enables |= tx_rings + ring_grps ?
 				   FUNC_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
@@ -6426,7 +6426,7 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 		enables |= vnics ? FUNC_CFG_REQ_ENABLES_NUM_VNICS : 0;
 
 		req->num_rx_rings = cpu_to_le16(rx_rings);
-		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			req->num_cmpl_rings = cpu_to_le16(tx_rings + ring_grps);
 			req->num_msix = cpu_to_le16(cp_rings);
 			req->num_rsscos_ctxs =
@@ -6461,7 +6461,7 @@ __bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 	enables |= rx_rings ? FUNC_VF_CFG_REQ_ENABLES_NUM_RX_RINGS |
 			      FUNC_VF_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
 	enables |= stats ? FUNC_VF_CFG_REQ_ENABLES_NUM_STAT_CTXS : 0;
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		enables |= tx_rings + ring_grps ?
 			   FUNC_VF_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
 	} else {
@@ -6476,7 +6476,7 @@ __bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 	req->num_l2_ctxs = cpu_to_le16(BNXT_VF_MAX_L2_CTX);
 	req->num_tx_rings = cpu_to_le16(tx_rings);
 	req->num_rx_rings = cpu_to_le16(rx_rings);
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		req->num_cmpl_rings = cpu_to_le16(tx_rings + ring_grps);
 		req->num_rsscos_ctxs = cpu_to_le16(DIV_ROUND_UP(ring_grps, 64));
 	} else {
@@ -6572,7 +6572,7 @@ static int bnxt_cp_rings_in_use(struct bnxt *bp)
 {
 	int cp;
 
-	if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		return bnxt_nq_rings_in_use(bp);
 
 	cp = bp->tx_nr_rings + bp->rx_nr_rings;
@@ -6629,7 +6629,8 @@ static bool bnxt_need_reserve_rings(struct bnxt *bp)
 		bnxt_check_rss_tbl_no_rmgr(bp);
 		return false;
 	}
-	if ((bp->flags & BNXT_FLAG_RFS) && !(bp->flags & BNXT_FLAG_CHIP_P5))
+	if ((bp->flags & BNXT_FLAG_RFS) &&
+	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		vnic = rx + 1;
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		rx <<= 1;
@@ -6637,9 +6638,9 @@ static bool bnxt_need_reserve_rings(struct bnxt *bp)
 	if (hw_resc->resv_rx_rings != rx || hw_resc->resv_cp_rings != cp ||
 	    hw_resc->resv_vnics != vnic || hw_resc->resv_stat_ctxs != stat ||
 	    (hw_resc->resv_hw_ring_grps != grp &&
-	     !(bp->flags & BNXT_FLAG_CHIP_P5)))
+	     !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)))
 		return true;
-	if ((bp->flags & BNXT_FLAG_CHIP_P5) && BNXT_PF(bp) &&
+	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && BNXT_PF(bp) &&
 	    hw_resc->resv_irqs != nq)
 		return true;
 	return false;
@@ -6661,7 +6662,8 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
 		sh = true;
-	if ((bp->flags & BNXT_FLAG_RFS) && !(bp->flags & BNXT_FLAG_CHIP_P5))
+	if ((bp->flags & BNXT_FLAG_RFS) &&
+	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		vnic = rx + 1;
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		rx <<= 1;
@@ -6752,7 +6754,7 @@ static int bnxt_hwrm_check_vf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 		FUNC_VF_CFG_REQ_FLAGS_STAT_CTX_ASSETS_TEST |
 		FUNC_VF_CFG_REQ_FLAGS_VNIC_ASSETS_TEST |
 		FUNC_VF_CFG_REQ_FLAGS_RSSCOS_CTX_ASSETS_TEST;
-	if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		flags |= FUNC_VF_CFG_REQ_FLAGS_RING_GRP_ASSETS_TEST;
 
 	req->flags = cpu_to_le32(flags);
@@ -6774,7 +6776,7 @@ static int bnxt_hwrm_check_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 			 FUNC_CFG_REQ_FLAGS_CMPL_ASSETS_TEST |
 			 FUNC_CFG_REQ_FLAGS_STAT_CTX_ASSETS_TEST |
 			 FUNC_CFG_REQ_FLAGS_VNIC_ASSETS_TEST;
-		if (bp->flags & BNXT_FLAG_CHIP_P5)
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 			flags |= FUNC_CFG_REQ_FLAGS_RSSCOS_CTX_ASSETS_TEST |
 				 FUNC_CFG_REQ_FLAGS_NQ_ASSETS_TEST;
 		else
@@ -6993,7 +6995,7 @@ bnxt_hwrm_set_tx_coal(struct bnxt *bp, struct bnxt_napi *bnapi,
 		rc = hwrm_req_send(bp, req);
 		if (rc)
 			return rc;
-		if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+		if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 			return 0;
 	}
 	return 0;
@@ -7030,7 +7032,7 @@ int bnxt_hwrm_set_coal(struct bnxt *bp)
 		if (rc)
 			break;
 
-		if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+		if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 			continue;
 
 		if (bnapi->rx_ring && bnapi->tx_ring[0]) {
@@ -7188,7 +7190,7 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 	if (bp->db_size)
 		goto func_qcfg_exit;
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		if (BNXT_PF(bp))
 			min_db_offset = DB_PF_OFFSET_P5;
 		else
@@ -7951,7 +7953,7 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	hw_resc->min_stat_ctxs = le16_to_cpu(resp->min_stat_ctx);
 	hw_resc->max_stat_ctxs = le16_to_cpu(resp->max_stat_ctx);
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		u16 max_msix = le16_to_cpu(resp->max_msix);
 
 		hw_resc->max_nqs = max_msix;
@@ -7980,7 +7982,7 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 	u8 flags;
 	int rc;
 
-	if (bp->hwrm_spec_code < 0x10801 || !BNXT_CHIP_P5_THOR(bp)) {
+	if (bp->hwrm_spec_code < 0x10801 || !BNXT_CHIP_P5(bp)) {
 		rc = -ENODEV;
 		goto no_ptp;
 	}
@@ -8012,7 +8014,7 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 	if (flags & PORT_MAC_PTP_QCFG_RESP_FLAGS_PARTIAL_DIRECT_ACCESS_REF_CLOCK) {
 		ptp->refclk_regs[0] = le32_to_cpu(resp->ts_ref_clock_reg_lower);
 		ptp->refclk_regs[1] = le32_to_cpu(resp->ts_ref_clock_reg_upper);
-	} else if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	} else if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		ptp->refclk_regs[0] = BNXT_TS_REG_TIMESYNC_TS0_LOWER;
 		ptp->refclk_regs[1] = BNXT_TS_REG_TIMESYNC_TS0_UPPER;
 	} else {
@@ -8721,7 +8723,7 @@ static void bnxt_accumulate_all_stats(struct bnxt *bp)
 	int i;
 
 	/* Chip bug.  Counter intermittently becomes 0. */
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		ignore_zero = true;
 
 	for (i = 0; i < bp->cp_nr_rings; i++) {
@@ -8915,7 +8917,7 @@ static void bnxt_clear_vnic(struct bnxt *bp)
 		return;
 
 	bnxt_hwrm_clear_vnic_filter(bp);
-	if (!(bp->flags & BNXT_FLAG_CHIP_P5)) {
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
 		/* clear all RSS setting before free vnic ctx */
 		bnxt_hwrm_clear_vnic_rss(bp);
 		bnxt_hwrm_vnic_ctx_free(bp);
@@ -8924,7 +8926,7 @@ static void bnxt_clear_vnic(struct bnxt *bp)
 	if (bp->flags & BNXT_FLAG_TPA)
 		bnxt_set_tpa(bp, false);
 	bnxt_hwrm_vnic_free(bp);
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		bnxt_hwrm_vnic_ctx_free(bp);
 }
 
@@ -9081,7 +9083,7 @@ static int __bnxt_setup_vnic_p5(struct bnxt *bp, u16 vnic_id)
 
 static int bnxt_setup_vnic(struct bnxt *bp, u16 vnic_id)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return __bnxt_setup_vnic_p5(bp, vnic_id);
 	else
 		return __bnxt_setup_vnic(bp, vnic_id);
@@ -9092,7 +9094,7 @@ static int bnxt_alloc_rfs_vnics(struct bnxt *bp)
 #ifdef CONFIG_RFS_ACCEL
 	int i, rc = 0;
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return 0;
 
 	for (i = 0; i < bp->rx_nr_rings; i++) {
@@ -9474,7 +9476,7 @@ static unsigned int bnxt_get_max_func_cp_rings_for_en(struct bnxt *bp)
 {
 	unsigned int cp = bp->hw_resc.max_cp_rings;
 
-	if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		cp -= bnxt_get_ulp_msix_num(bp);
 
 	return cp;
@@ -9484,7 +9486,7 @@ static unsigned int bnxt_get_max_func_irqs(struct bnxt *bp)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return min_t(unsigned int, hw_resc->max_irqs, hw_resc->max_nqs);
 
 	return min_t(unsigned int, hw_resc->max_irqs, hw_resc->max_cp_rings);
@@ -9500,7 +9502,7 @@ unsigned int bnxt_get_avail_cp_rings_for_en(struct bnxt *bp)
 	unsigned int cp;
 
 	cp = bnxt_get_max_func_cp_rings_for_en(bp);
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return cp - bp->rx_nr_rings - bp->tx_nr_rings;
 	else
 		return cp - bp->cp_nr_rings;
@@ -9519,7 +9521,7 @@ int bnxt_get_avail_msix(struct bnxt *bp, int num)
 	int max_idx, avail_msix;
 
 	max_idx = bp->total_irqs;
-	if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		max_idx = min_t(int, bp->total_irqs, max_cp);
 	avail_msix = max_idx - bp->cp_nr_rings;
 	if (!BNXT_NEW_RM(bp) || avail_msix >= num)
@@ -9798,7 +9800,7 @@ static void bnxt_init_napi(struct bnxt *bp)
 	if (bp->flags & BNXT_FLAG_USING_MSIX) {
 		int (*poll_fn)(struct napi_struct *, int) = bnxt_poll;
 
-		if (bp->flags & BNXT_FLAG_CHIP_P5)
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 			poll_fn = bnxt_poll_p5;
 		else if (BNXT_CHIP_TYPE_NITRO_A0(bp))
 			cp_nr_rings--;
@@ -11517,7 +11519,7 @@ static bool bnxt_can_reserve_rings(struct bnxt *bp)
 /* If the chip and firmware supports RFS */
 static bool bnxt_rfs_supported(struct bnxt *bp)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		if (bp->fw_cap & BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V2)
 			return true;
 		return false;
@@ -11538,7 +11540,7 @@ static bool bnxt_rfs_capable(struct bnxt *bp)
 #ifdef CONFIG_RFS_ACCEL
 	int vnics, max_vnics, max_rss_ctxs;
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return bnxt_rfs_supported(bp);
 	if (!(bp->flags & BNXT_FLAG_MSIX_CAP) || !bnxt_can_reserve_rings(bp) || !bp->rx_nr_rings)
 		return false;
@@ -11640,7 +11642,7 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 		update_tpa = true;
 		if ((bp->flags & BNXT_FLAG_TPA) == 0 ||
 		    (flags & BNXT_FLAG_TPA) == 0 ||
-		    (bp->flags & BNXT_FLAG_CHIP_P5))
+		    (bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 			re_init = true;
 	}
 
@@ -12051,8 +12053,7 @@ static void bnxt_timer(struct timer_list *t)
 	if (test_bit(BNXT_STATE_L2_FILTER_RETRY, &bp->state))
 		bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
 
-	if ((bp->flags & BNXT_FLAG_CHIP_P5) && !bp->chip_rev &&
-	    netif_carrier_ok(dev))
+	if ((BNXT_CHIP_P5(bp)) && !bp->chip_rev && netif_carrier_ok(dev))
 		bnxt_queue_sp_work(bp, BNXT_RING_COAL_NOW_SP_EVENT);
 
 bnxt_restart_timer:
@@ -12303,7 +12304,7 @@ static void bnxt_chk_missed_irq(struct bnxt *bp)
 {
 	int i;
 
-	if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		return;
 
 	for (i = 0; i < bp->cp_nr_rings; i++) {
@@ -12507,7 +12508,8 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		return -ENOMEM;
 
 	vnics = 1;
-	if ((bp->flags & (BNXT_FLAG_RFS | BNXT_FLAG_CHIP_P5)) == BNXT_FLAG_RFS)
+	if ((bp->flags & (BNXT_FLAG_RFS | BNXT_FLAG_CHIP_P5_PLUS)) ==
+	    BNXT_FLAG_RFS)
 		vnics += rx;
 
 	tx_cp = __bnxt_num_tx_to_cp(bp, tx_rings_needed, tx_sets, tx_xdp);
@@ -12588,10 +12590,10 @@ static bool bnxt_fw_pre_resv_vnics(struct bnxt *bp)
 {
 	u16 fw_maj = BNXT_FW_MAJ(bp), fw_bld = BNXT_FW_BLD(bp);
 
-	if (!(bp->flags & BNXT_FLAG_CHIP_P5) &&
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
 	    (fw_maj > 218 || (fw_maj == 218 && fw_bld >= 18)))
 		return true;
-	if ((bp->flags & BNXT_FLAG_CHIP_P5) &&
+	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
 	    (fw_maj > 216 || (fw_maj == 216 && fw_bld >= 172)))
 		return true;
 	return false;
@@ -13647,7 +13649,7 @@ static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
 	max_irq = min_t(int, bnxt_get_max_func_irqs(bp) -
 			bnxt_get_ulp_msix_num(bp),
 			hw_resc->max_stat_ctxs - bnxt_get_ulp_stat_ctxs(bp));
-	if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		*max_cp = min_t(int, *max_cp, max_irq);
 	max_ring_grps = hw_resc->max_hw_ring_grps;
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp) && BNXT_PF(bp)) {
@@ -13656,7 +13658,7 @@ static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
 	}
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		*max_rx >>= 1;
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		if (*max_cp < (*max_rx + *max_tx)) {
 			*max_rx = *max_cp / 2;
 			*max_tx = *max_rx;
@@ -14004,8 +14006,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (BNXT_PF(bp))
 		bnxt_vpd_read_info(bp);
 
-	if (BNXT_CHIP_P5(bp)) {
-		bp->flags |= BNXT_FLAG_CHIP_P5;
+	if (BNXT_CHIP_P5_PLUS(bp)) {
+		bp->flags |= BNXT_FLAG_CHIP_P5_PLUS;
 		if (BNXT_CHIP_SR2(bp))
 			bp->flags |= BNXT_FLAG_CHIP_SR2;
 	}
@@ -14070,7 +14072,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		bp->gro_func = bnxt_gro_func_5730x;
 		if (BNXT_CHIP_P4(bp))
 			bp->gro_func = bnxt_gro_func_5731x;
-		else if (BNXT_CHIP_P5(bp))
+		else if (BNXT_CHIP_P5_PLUS(bp))
 			bp->gro_func = bnxt_gro_func_5750x;
 	}
 	if (!BNXT_CHIP_P4_PLUS(bp))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b287e4a9adff..94b3627406c4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1430,7 +1430,7 @@ struct bnxt_test_info {
 };
 
 #define CHIMP_REG_VIEW_ADDR				\
-	((bp->flags & BNXT_FLAG_CHIP_P5) ? 0x80000000 : 0xb1000000)
+	((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) ? 0x80000000 : 0xb1000000)
 
 #define BNXT_GRCPF_REG_CHIMP_COMM		0x0
 #define BNXT_GRCPF_REG_CHIMP_COMM_TRIGGER	0x100
@@ -1859,7 +1859,7 @@ struct bnxt {
 	atomic_t		intr_sem;
 
 	u32			flags;
-	#define BNXT_FLAG_CHIP_P5	0x1
+	#define BNXT_FLAG_CHIP_P5_PLUS	0x1
 	#define BNXT_FLAG_VF		0x2
 	#define BNXT_FLAG_LRO		0x4
 #ifdef CONFIG_INET
@@ -1913,21 +1913,21 @@ struct bnxt {
 #define BNXT_CHIP_TYPE_NITRO_A0(bp) ((bp)->flags & BNXT_FLAG_CHIP_NITRO_A0)
 #define BNXT_RX_PAGE_MODE(bp)	((bp)->flags & BNXT_FLAG_RX_PAGE_MODE)
 #define BNXT_SUPPORTS_TPA(bp)	(!BNXT_CHIP_TYPE_NITRO_A0(bp) &&	\
-				 (!((bp)->flags & BNXT_FLAG_CHIP_P5) ||	\
+				 (!((bp)->flags & BNXT_FLAG_CHIP_P5_PLUS) ||\
 				  (bp)->max_tpa_v2) && !is_kdump_kernel())
 #define BNXT_RX_JUMBO_MODE(bp)	((bp)->flags & BNXT_FLAG_JUMBO)
 
 #define BNXT_CHIP_SR2(bp)			\
 	((bp)->chip_num == CHIP_NUM_58818)
 
-#define BNXT_CHIP_P5_THOR(bp)			\
+#define BNXT_CHIP_P5(bp)			\
 	((bp)->chip_num == CHIP_NUM_57508 ||	\
 	 (bp)->chip_num == CHIP_NUM_57504 ||	\
 	 (bp)->chip_num == CHIP_NUM_57502)
 
 /* Chip class phase 5 */
-#define BNXT_CHIP_P5(bp)			\
-	(BNXT_CHIP_P5_THOR(bp) || BNXT_CHIP_SR2(bp))
+#define BNXT_CHIP_P5_PLUS(bp)			\
+	(BNXT_CHIP_P5(bp) || BNXT_CHIP_SR2(bp))
 
 /* Chip class phase 4.x */
 #define BNXT_CHIP_P4(bp)			\
@@ -1938,7 +1938,7 @@ struct bnxt {
 	  !BNXT_CHIP_TYPE_NITRO_A0(bp)))
 
 #define BNXT_CHIP_P4_PLUS(bp)			\
-	(BNXT_CHIP_P4(bp) || BNXT_CHIP_P5(bp))
+	(BNXT_CHIP_P4(bp) || BNXT_CHIP_P5_PLUS(bp))
 
 	struct bnxt_aux_priv	*aux_priv;
 	struct bnxt_en_dev	*edev;
@@ -2362,7 +2362,7 @@ static inline void bnxt_writeq_relaxed(struct bnxt *bp, u64 val,
 static inline void bnxt_db_write_relaxed(struct bnxt *bp,
 					 struct bnxt_db_info *db, u32 idx)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		bnxt_writeq_relaxed(bp, db->db_key64 | DB_RING_IDX(db, idx),
 				    db->doorbell);
 	} else {
@@ -2378,7 +2378,7 @@ static inline void bnxt_db_write_relaxed(struct bnxt *bp,
 static inline void bnxt_db_write(struct bnxt *bp, struct bnxt_db_info *db,
 				 u32 idx)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		bnxt_writeq(bp, db->db_key64 | DB_RING_IDX(db, idx),
 			    db->doorbell);
 	} else {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 10b842539b08..ae1bdda56d22 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -739,7 +739,7 @@ static int bnxt_hwrm_get_nvm_cfg_ver(struct bnxt *bp, u32 *nvm_cfg_ver)
 	}
 
 	/* earlier devices present as an array of raw bytes */
-	if (!BNXT_CHIP_P5(bp)) {
+	if (!BNXT_CHIP_P5_PLUS(bp)) {
 		dim = 0;
 		i = 0;
 		bits *= 3;  /* array of 3 version components */
@@ -759,7 +759,7 @@ static int bnxt_hwrm_get_nvm_cfg_ver(struct bnxt *bp, u32 *nvm_cfg_ver)
 			goto exit;
 		bnxt_copy_from_nvm_data(&ver, data, bits, bytes);
 
-		if (BNXT_CHIP_P5(bp)) {
+		if (BNXT_CHIP_P5_PLUS(bp)) {
 			*nvm_cfg_ver <<= 8;
 			*nvm_cfg_ver |= ver.vu8;
 		} else {
@@ -779,7 +779,7 @@ static int bnxt_dl_info_put(struct bnxt *bp, struct devlink_info_req *req,
 	if (!strlen(buf))
 		return 0;
 
-	if ((bp->flags & BNXT_FLAG_CHIP_P5) &&
+	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
 	    (!strcmp(key, DEVLINK_INFO_VERSION_GENERIC_FW_NCSI) ||
 	     !strcmp(key, DEVLINK_INFO_VERSION_GENERIC_FW_ROCE)))
 		return 0;
@@ -1005,7 +1005,7 @@ static int bnxt_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 	if (rc)
 		return rc;
 
-	if (BNXT_CHIP_P5(bp)) {
+	if (BNXT_CHIP_P5_PLUS(bp)) {
 		rc = bnxt_dl_livepatch_info_put(bp, req, BNXT_FW_SRT_PATCH);
 		if (rc)
 			return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 585044310141..b0cea5b600cc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -511,7 +511,7 @@ static int bnxt_get_num_tpa_ring_stats(struct bnxt *bp)
 {
 	if (BNXT_SUPPORTS_TPA(bp)) {
 		if (bp->max_tpa_v2) {
-			if (BNXT_CHIP_P5_THOR(bp))
+			if (BNXT_CHIP_P5(bp))
 				return BNXT_NUM_TPA_RING_STATS_P5;
 			return BNXT_NUM_TPA_RING_STATS_P5_SR2;
 		}
@@ -1322,7 +1322,7 @@ u32 bnxt_get_rxfh_indir_size(struct net_device *dev)
 {
 	struct bnxt *bp = netdev_priv(dev);
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return ALIGN(bp->rx_nr_rings, BNXT_RSS_TABLE_ENTRIES_P5);
 	return HW_HASH_INDEX_SIZE;
 }
@@ -3943,7 +3943,7 @@ static int bnxt_run_loopback(struct bnxt *bp)
 	int rc;
 
 	cpr = &rxr->bnapi->cp_ring;
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		cpr = rxr->rx_cpr;
 	pkt_size = min(bp->dev->mtu + ETH_HLEN, bp->rx_copy_thresh);
 	skb = netdev_alloc_skb(bp->dev, pkt_size);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index f3886710e778..a1ec39b46518 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -650,7 +650,7 @@ static int bnxt_map_ptp_regs(struct bnxt *bp)
 	int rc, i;
 
 	reg_arr = ptp->refclk_regs;
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (BNXT_CHIP_P5(bp)) {
 		rc = bnxt_map_regs(bp, reg_arr, 2, BNXT_PTP_GRC_WIN);
 		if (rc)
 			return rc;
@@ -967,7 +967,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 		rc = err;
 		goto out;
 	}
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (BNXT_CHIP_P5(bp)) {
 		spin_lock_bh(&ptp->ptp_lock);
 		bnxt_refclk_read(bp, NULL, &ptp->current_time);
 		WRITE_ONCE(ptp->old_time, ptp->current_time);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index c722b3b41730..175192ebaa77 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -536,7 +536,7 @@ static int bnxt_hwrm_func_vf_resc_cfg(struct bnxt *bp, int num_vfs, bool reset)
 	if (rc)
 		return rc;
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		vf_msix = hw_resc->max_nqs - bnxt_nq_rings_in_use(bp);
 		vf_ring_grps = 0;
 	} else {
@@ -565,7 +565,7 @@ static int bnxt_hwrm_func_vf_resc_cfg(struct bnxt *bp, int num_vfs, bool reset)
 		req->min_l2_ctxs = cpu_to_le16(min);
 		req->min_vnics = cpu_to_le16(min);
 		req->min_stat_ctx = cpu_to_le16(min);
-		if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+		if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 			req->min_hw_ring_grps = cpu_to_le16(min);
 	} else {
 		vf_cp_rings /= num_vfs;
@@ -602,7 +602,7 @@ static int bnxt_hwrm_func_vf_resc_cfg(struct bnxt *bp, int num_vfs, bool reset)
 	req->max_stat_ctx = cpu_to_le16(vf_stat_ctx);
 	req->max_hw_ring_grps = cpu_to_le16(vf_ring_grps);
 	req->max_rsscos_ctx = cpu_to_le16(vf_rss);
-	if (bp->flags & BNXT_FLAG_CHIP_P5)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		req->max_msix = cpu_to_le16(vf_msix / num_vfs);
 
 	hwrm_req_hold(bp, req);
@@ -630,7 +630,7 @@ static int bnxt_hwrm_func_vf_resc_cfg(struct bnxt *bp, int num_vfs, bool reset)
 			le16_to_cpu(req->min_rsscos_ctx) * n;
 		hw_resc->max_stat_ctxs -= le16_to_cpu(req->min_stat_ctx) * n;
 		hw_resc->max_vnics -= le16_to_cpu(req->min_vnics) * n;
-		if (bp->flags & BNXT_FLAG_CHIP_P5)
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 			hw_resc->max_nqs -= vf_msix;
 
 		rc = pf->active_vfs;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 6ba2b9398633..e89731492f5e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -42,7 +42,7 @@ static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
 	for (i = 0; i < num_msix; i++) {
 		ent[i].vector = bp->irq_tbl[idx + i].vector;
 		ent[i].ring_idx = idx + i;
-		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			ent[i].db_offset = DB_PF_OFFSET_P5;
 			if (BNXT_VF(bp))
 				ent[i].db_offset = DB_VF_OFFSET_P5;
-- 
2.30.1


--000000000000bc6637060a9e1203
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIC7iHduQuH2jE9oRRVSMWFcV8tFfNpJ3
FJA+e6Q2OmS3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEy
MDIzNDQ1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA1WeAX9ap7RQXixFn6ez1s5UfWOqgHVZ21vAZ7SPRM/VqVrzc0
URJn1i7nPpK8wYwo3h2t9XDXFyEVoCypLe4czzy5Wo7O5pRMXQG0sEZwzQSAPQof8ai7wk0byu1x
UGyn6eUl5eDxcCzfyAmM4NefovUBBYAH35OJjB/ZUxXuLQiewJGDqTrIMqJydquHQj2DV/ULf2Qw
bKSM9fTy2MV4Qo0f4FNVeLGyGElXsF1mEajhDOD6dgiibBkMWVxCJ41/wjNfGYCt9qht75jtADTk
kZhJ1MYU4EXP9QtOHqXAW8jVbWjfGOV99zMpyc8XwD9auhYqG8wRmMd1o+s1mS+B
--000000000000bc6637060a9e1203--

