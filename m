Return-Path: <netdev+bounces-284103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBg1MKcz+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:02:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4524C5136
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02656304E0CD
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52293FE656;
	Mon,  4 May 2026 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J7wRYavy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1AD38B150
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939165; cv=none; b=VN0cGqFjUyMVj8+2r8pNoucXumSWxN1oOAtFG1Y2D1SJXyqzQ6Q8xBMi6IkqpMkZiOpRFs46wNk0GgqU4dnJUWxFiGjkI16IXwSOU4yy6qI60cgGF1/qIZt7kCtAmLUDvlUSQ5yRrkqwnuYry8ne1RUIZ4BbzYM7jWIJ0rmhON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939165; c=relaxed/simple;
	bh=UE0JNExN7FONgmW3ZVdNm7hFq/SrU3fPcaR5SA0WP7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJwnmOMxpXwFbV3jKvA+6nV5pNTHYfBfPN/yfVH5Fj8TyxeDlNvEiKGwaI/yK2AK2R0+Fzg3trZJbfW4B7pdNJndNFteFvT3L1LvTn46V3PRH7/3oCs1Q4SHkOSoh9wrGsiab4biCNSCy7UrxJPNkz7bvQhYvRtRrIQUkdlGqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J7wRYavy; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-6530287803cso4651123d50.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939163; x=1778543963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4on1KLqcMr91DvwY5q+5DRIVg2YQX+ugvM8w0Po94c=;
        b=mHdhcX/Er+dxnUQDn8POAm0L55k84UtPdDG9Xpi95tSuULyOp/2dwDeXIP5uFx+yOl
         80kErjCEptLX40l9hERO5DdiFzqw2k2QftHLFdGFXioesypy6+PR+eeXNCCxLDrlHeAD
         shovyOHga9ksODuojTdiB4hz27hrWbThYPVrjlnQeT9Orzou94yrHiByMPOoxhfJC81h
         UQvgJo4rOQd3id9C3c+eR9RloIElHtKGYI2LQGRGErlGvWeQ6RTWSqRraytUqVvPbiIg
         kaRBOeZa66XVyDli98wKh57AcjplI1A9GcMFUAyJu3MNjaEcKuhlUHTS7b4CLLXKOmVV
         Y73g==
X-Gm-Message-State: AOJu0Yw3thw8IoKk83uenrZ+bDI31wgDxKtvJ3Ry8av12bUvJ069f7WH
	H5pxv5tIakGhb00Z0p+TB670FDCx0lLOROS/TACcve0BhfjjnOb/Xl4gZHvQq1d2kwYeeNW8efa
	OF6B7lFGO98O70mxNAGLH/H0XVE/GlpMSoPrOmLIk81hp9t6Y2BWb5SYpOqbBqMG55TtqZ4azDF
	vEmg1I8sXFXUx3k7iLWGOP+V5sAwO/eO30ukWx8ml6fhc/CKzybM2otMRGbuS2M8EJhHmjsy/T0
	6avAaiifIc=
X-Gm-Gg: AeBDieuU1IxV5prZ4bSJ1QpWqvk7Rs7N0OJ1/IeOoYsun1vQxod+N8bwocixaY2FtM1
	nMTTbOtczU6J6LGxQA724l0YE7mt0qaBoFlu71NzThu/ZNE0HuMAtZi4NDv/+AfYPx13jF+STp3
	RHEnDEHY9/q/VmUeP4Yrs3epR1p4K/Vi0eJhl8Af99jnw5jxptpH1Z5Prw3rgi+cIOOr6zhd37Q
	jeCn0Rbgwmodp6am3XmQAbqtPhuVjaojzLIaiyWg7wbF5SsTZw4ji7mZRRce7jDw8ncOZ65NG1I
	P7uspCeEMl4mQc3SI/sQ0cnIMzZ+iCgf2ZKHCd8VXYPBFWWYMFZ7LECmYXisCBYrgOO5xN2TPr2
	KsP62ZeUhv/MUKIbTwi7x6fr2wDnxVf436qK7MuYEYedm7FG5ao8TrPbos69+JMGBOwLzI1617U
	+XO+Z2nfFU5Nt6h38=
X-Received: by 2002:a05:690e:1a13:b0:650:18fc:f557 with SMTP id 956f58d0204a3-65c3dbb5888mr9334420d50.56.1777939162835;
        Mon, 04 May 2026 16:59:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65c2dc7a2ffsm963334d50.0.2026.05.04.16.59.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:59:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d9a6a853bso113199801cf.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777939162; x=1778543962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4on1KLqcMr91DvwY5q+5DRIVg2YQX+ugvM8w0Po94c=;
        b=J7wRYavy8AzEEkhffBGfqXEwkM8NeuCyE+5bEwbE70+BKGlUPi9FbrYKabm4KtWXYo
         IzX8o6lBfB/Zp0Ngv6353kKUcl6Zp5hongOB32pgJzor5GaoxJOwFexVK6HXpR92vKaA
         ymaig4qHYowHtSoshuwKHIrpiEhuEcN8jLwus=
X-Received: by 2002:a05:622a:30a:b0:50e:5c31:5d56 with SMTP id d75a77b69052e-5104bde5513mr175418131cf.6.1777939161850;
        Mon, 04 May 2026 16:59:21 -0700 (PDT)
X-Received: by 2002:a05:622a:30a:b0:50e:5c31:5d56 with SMTP id d75a77b69052e-5104bde5513mr175417701cf.6.1777939161247;
        Mon, 04 May 2026 16:59:21 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm132298246d6.18.2026.05.04.16.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:59:20 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 05/15] bnxt_en: Allocate and free MPC software structures
Date: Mon,  4 May 2026 16:58:26 -0700
Message-ID: <20260504235836.3019499-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260504235836.3019499-1-michael.chan@broadcom.com>
References: <20260504235836.3019499-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 3F4524C5136
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-284103-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

Each MPC consists of a special TX ring and a completion ring.  Use
existing structs bnxt_tx_ring_info and bnxt_cp_ring_info as control
structures.  The 2 MPC channels to TCE and RCE that share the MSIX
will use a shared completion ring.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  35 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  12 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 204 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h |  46 ++++
 4 files changed, 290 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bcc0c94c8e48..54f7672eeba0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3679,7 +3679,7 @@ static size_t __bnxt_copy_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem,
 	return total_len;
 }
 
-static void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
+void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 {
 	struct pci_dev *pdev = bp->pdev;
 	int i;
@@ -3712,7 +3712,7 @@ static void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 	}
 }
 
-static int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
+int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 {
 	struct pci_dev *pdev = bp->pdev;
 	u64 valid_bit = 0;
@@ -4316,6 +4316,8 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 			 (!sh && i >= bp->rx_nr_rings)) {
 			cp_count += tcs;
 			tx = 1;
+			if (bnxt_napi_has_mpc(bp, i))
+				cp_count++;
 		}
 
 		cpr->cp_ring_arr = kzalloc_objs(*cpr, cp_count);
@@ -4337,6 +4339,11 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 			} else {
 				int n, tc = k - rx;
 
+				/* MPC rings are at the highest k indices */
+				if (tc >= tcs) {
+					bnxt_set_mpc_cp_ring(bp, i, cpr2);
+					continue;
+				}
 				n = BNXT_TC_TO_RING_BASE(bp, tc) + j;
 				bp->tx_ring[n].tx_cpr = cpr2;
 				cpr2->cp_ring_type = BNXT_NQ_HDL_TYPE_TX;
@@ -4469,6 +4476,7 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 			rmem->vmem = (void **)&txr->tx_buf_ring;
 		}
 	}
+	bnxt_init_mpc_ring_struct(bp);
 }
 
 static void bnxt_init_rxbd_pages(struct bnxt_ring_struct *ring, u32 type)
@@ -5545,6 +5553,7 @@ static void bnxt_init_l2_fltr_tbl(struct bnxt *bp)
 static void bnxt_free_mem(struct bnxt *bp, bool irq_re_init)
 {
 	bnxt_free_vnic_attributes(bp);
+	bnxt_free_mpc_rings(bp);
 	bnxt_free_tx_rings(bp);
 	bnxt_free_rx_rings(bp);
 	bnxt_free_cp_rings(bp);
@@ -5558,6 +5567,7 @@ static void bnxt_free_mem(struct bnxt *bp, bool irq_re_init)
 			bnxt_free_port_stats(bp);
 		bnxt_free_ring_grps(bp);
 		bnxt_free_vnics(bp);
+		bnxt_free_mpcs(bp);
 		kfree(bp->tx_ring_map);
 		bp->tx_ring_map = NULL;
 		kfree(bp->tx_ring);
@@ -5667,6 +5677,10 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 				txr->tx_cpr = &bnapi2->cp_ring;
 		}
 
+		rc = bnxt_alloc_mpcs(bp);
+		if (rc)
+			goto alloc_mem_err;
+
 		rc = bnxt_alloc_stats(bp);
 		if (rc)
 			goto alloc_mem_err;
@@ -5695,6 +5709,10 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 	if (rc)
 		goto alloc_mem_err;
 
+	rc = bnxt_alloc_mpc_rings(bp);
+	if (rc)
+		goto alloc_mem_err;
+
 	rc = bnxt_alloc_cp_rings(bp);
 	if (rc)
 		goto alloc_mem_err;
@@ -7249,10 +7267,15 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 		req->cmpl_ring_id = cpu_to_le16(bnxt_cp_ring_for_tx(bp, txr));
 		req->length = cpu_to_le32(bp->tx_ring_mask + 1);
 		req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
-		req->queue_id = cpu_to_le16(ring->queue_id);
-		if (bp->flags & BNXT_FLAG_TX_COAL_CMPL)
-			req->cmpl_coal_cnt =
-				RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_64;
+		if (ring->queue_id == BNXT_MPC_QUEUE_ID) {
+			req->mpc_chnls_type = ring->mpc_chnl_type;
+			req->enables |= cpu_to_le32(RING_ALLOC_REQ_ENABLES_MPC_CHNLS_TYPE);
+		} else {
+			req->queue_id = cpu_to_le16(ring->queue_id);
+			if (bp->flags & BNXT_FLAG_TX_COAL_CMPL)
+				req->cmpl_coal_cnt =
+					RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_64;
+		}
 		if ((bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP) && bp->ptp_cfg)
 			flags |= RING_ALLOC_REQ_FLAGS_TX_PKT_TS_CMPL_ENABLE;
 		req->flags = cpu_to_le16(flags);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6c8ed3cb7dfd..253c0739f680 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -686,6 +686,7 @@ struct nqe_cn {
 #define BNXT_NQ_HDL_TYPE_SHIFT	24
 #define BNXT_NQ_HDL_TYPE_RX	0x00
 #define BNXT_NQ_HDL_TYPE_TX	0x01
+#define BNXT_NQ_HDL_TYPE_MP	0x02
 
 #define BNXT_NQ_HDL_IDX(hdl)	((hdl) & BNXT_NQ_HDL_IDX_MASK)
 #define BNXT_NQ_HDL_TYPE(hdl)	(((hdl) & BNXT_NQ_HDL_TYPE_MASK) >>	\
@@ -950,6 +951,8 @@ struct bnxt_ring_struct {
 	};
 	u32			handle;
 	u8			queue_id;
+#define BNXT_MPC_QUEUE_ID	0xff
+	u8			mpc_chnl_type;
 };
 
 struct tx_push_bd {
@@ -990,12 +993,16 @@ struct bnxt_tx_ring_info {
 	u16			tx_cons;
 	u16			tx_hw_cons;
 	u16			txq_index;
+	/* index for tx_ring[] or tx_mpc_ring[] in struct bnxt_napi */
 	u8			tx_napi_idx;
 	u8			kick_pending;
 	struct bnxt_db_info	tx_db;
 
 	struct tx_bd		*tx_desc_ring[MAX_TX_PAGES];
-	struct bnxt_sw_tx_bd	*tx_buf_ring;
+	union {
+		struct bnxt_sw_tx_bd	*tx_buf_ring;
+		struct bnxt_sw_mpc_tx_bd	*tx_mpc_buf_ring;
+	};
 
 	dma_addr_t		tx_desc_mapping[MAX_TX_PAGES];
 
@@ -1241,6 +1248,7 @@ struct bnxt_napi {
 	struct bnxt_cp_ring_info	cp_ring;
 	struct bnxt_rx_ring_info	*rx_ring;
 	struct bnxt_tx_ring_info	*tx_ring[BNXT_MAX_TXR_PER_NAPI];
+	struct bnxt_tx_ring_info	**tx_mpc_ring;
 
 	void			(*tx_int)(struct bnxt *, struct bnxt_napi *,
 					  int budget);
@@ -2961,6 +2969,8 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data);
 u32 bnxt_fw_health_readl(struct bnxt *bp, int reg_idx);
 bool bnxt_bs_trace_avail(struct bnxt *bp, u16 type);
+void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem);
+int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem);
 void bnxt_set_tpa_flags(struct bnxt *bp);
 void bnxt_set_ring_params(struct bnxt *);
 void bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index cce73d56e46e..9ffc62bf771f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -47,6 +47,55 @@ int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 	return mpc->mpc_cp_rings;
 }
 
+bool bnxt_napi_has_mpc(struct bnxt *bp, int i)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	struct bnxt_napi *bnapi = bp->bnapi[i];
+	struct bnxt_tx_ring_info *txr;
+
+	if (!mpc)
+		return false;
+
+	txr = bnapi->tx_ring[0];
+	if (txr && !(bnapi->flags & BNXT_NAPI_FLAG_XDP))
+		return txr->txq_index < mpc->mpc_cp_rings;
+	return false;
+}
+
+void bnxt_set_mpc_cp_ring(struct bnxt *bp, int bnapi_idx,
+			  struct bnxt_cp_ring_info *cpr)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	struct bnxt_napi *bnapi;
+	bool found = false;
+	int i, j;
+
+	if (!mpc)
+		return;
+	bnapi = bp->bnapi[bnapi_idx];
+	/* Check both TCE and RCE MPCs for the matching NAPI */
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+
+		for (j = 0; j < num; j++) {
+			struct bnxt_tx_ring_info *txr = &mpc->mpc_rings[i][j];
+
+			/* Only 1 ring with index j will use this NAPI */
+			if (txr->bnapi == bnapi) {
+				txr->tx_cpr = cpr;
+				txr->tx_napi_idx = i;
+				bnapi->tx_mpc_ring[i] = txr;
+				found = true;
+				break;
+			}
+		}
+	}
+	if (!found)
+		netdev_warn_once(bp->dev, "No MPC match for napi index %d\n",
+				 bnapi_idx);
+	cpr->cp_ring_type = BNXT_NQ_HDL_TYPE_MP;
+}
+
 void bnxt_trim_mpc_rings(struct bnxt *bp)
 {
 	struct bnxt_mpc_info *mpc = bp->mpc_info;
@@ -107,3 +156,158 @@ void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
 	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++)
 		mpc->mpc_ring_count[i] = 0;
 }
+
+void bnxt_init_mpc_ring_struct(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, j;
+
+	if (!BNXT_MPC_CRYPTO_CAPABLE(bp))
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+		struct bnxt_tx_ring_info *txr;
+
+		txr = mpc->mpc_rings[i];
+		if (!txr)
+			continue;
+		for (j = 0; j < num; j++) {
+			struct bnxt_ring_mem_info *rmem;
+			struct bnxt_ring_struct *ring;
+
+			txr = &mpc->mpc_rings[i][j];
+
+			txr->tx_ring_struct.ring_mem.flags =
+				BNXT_RMEM_RING_PTE_FLAG;
+			txr->bnapi = bp->tx_ring[bp->tx_ring_map[j]].bnapi;
+			txr->txq_index = j;
+
+			ring = &txr->tx_ring_struct;
+			rmem = &ring->ring_mem;
+			rmem->nr_pages = bp->tx_nr_pages;
+			rmem->page_size = HW_TXBD_RING_SIZE;
+			rmem->pg_arr = (void **)txr->tx_desc_ring;
+			rmem->dma_arr = txr->tx_desc_mapping;
+			rmem->vmem_size = SW_MPC_TXBD_RING_SIZE *
+					  bp->tx_nr_pages;
+			rmem->vmem = (void **)&txr->tx_mpc_buf_ring;
+		}
+	}
+}
+
+int bnxt_alloc_mpcs(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, rc = 0;
+
+	if (!BNXT_MPC_CRYPTO_CAPABLE(bp))
+		return 0;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+		struct bnxt_tx_ring_info *txr;
+
+		if (!num)
+			continue;
+		txr = kzalloc_objs(*txr, num);
+		if (!txr) {
+			rc = -ENOMEM;
+			goto alloc_mpcs_exit;
+		}
+		mpc->mpc_rings[i] = txr;
+	}
+
+	for (i = 0; i < bp->cp_nr_rings; i++) {
+		struct bnxt_napi *bnapi = bp->bnapi[i];
+
+		if (!bnxt_napi_has_mpc(bp, i))
+			continue;
+		bnapi->tx_mpc_ring = kzalloc_objs(*bnapi->tx_mpc_ring,
+						  BNXT_MPC_TYPE_MAX);
+		if (!bnapi->tx_mpc_ring) {
+			rc = -ENOMEM;
+			goto alloc_mpcs_exit;
+		}
+	}
+alloc_mpcs_exit:
+	if (rc)
+		bnxt_free_mpcs(bp);
+	return rc;
+}
+
+void bnxt_free_mpcs(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		kfree(mpc->mpc_rings[i]);
+		mpc->mpc_rings[i] = NULL;
+	}
+	if (!bp->bnapi)
+		return;
+	for (i = 0; i < bp->cp_nr_rings; i++) {
+		struct bnxt_napi *bnapi = bp->bnapi[i];
+
+		kfree(bnapi->tx_mpc_ring);
+		bnapi->tx_mpc_ring = NULL;
+	}
+}
+
+int bnxt_alloc_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, j, rc = 0;
+
+	if (!mpc)
+		return 0;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+
+		for (j = 0; j < num; j++) {
+			struct bnxt_tx_ring_info *txr = &mpc->mpc_rings[i][j];
+			struct bnxt_ring_struct *ring;
+
+			ring = &txr->tx_ring_struct;
+			rc = bnxt_alloc_ring(bp, &ring->ring_mem);
+			if (rc)
+				goto alloc_mpc_rings_exit;
+			ring->queue_id = BNXT_MPC_QUEUE_ID;
+			ring->mpc_chnl_type = i;
+			/* for stats context */
+			ring->grp_idx = txr->bnapi->index;
+			spin_lock_init(&txr->tx_lock);
+		}
+	}
+alloc_mpc_rings_exit:
+	if (rc)
+		bnxt_free_mpc_rings(bp);
+	return rc;
+}
+
+void bnxt_free_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, j;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+
+		if (!mpc->mpc_rings[i])
+			continue;
+		for (j = 0; j < num; j++) {
+			struct bnxt_tx_ring_info *txr = &mpc->mpc_rings[i][j];
+			struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
+
+			bnxt_free_ring(bp, &ring->ring_mem);
+		}
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index 4ff8cad75a23..b54daf4ddd2f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -29,6 +29,12 @@ struct bnxt_mpc_info {
 	struct bnxt_tx_ring_info *mpc_rings[BNXT_MPC_TYPE_MAX];
 };
 
+struct bnxt_sw_mpc_tx_bd {
+	unsigned long handle;
+};
+
+#define SW_MPC_TXBD_RING_SIZE (sizeof(struct bnxt_sw_mpc_tx_bd) * TX_DESC_CNT)
+
 #define BNXT_MPC_CRYPTO_CAP    \
 	(FUNC_QCAPS_RESP_MPC_CHNLS_CAP_TCE | FUNC_QCAPS_RESP_MPC_CHNLS_CAP_RCE)
 
@@ -42,8 +48,16 @@ void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
 void bnxt_free_mpc_info(struct bnxt *bp);
 int bnxt_mpc_tx_rings_in_use(struct bnxt *bp);
 int bnxt_mpc_cp_rings_in_use(struct bnxt *bp);
+bool bnxt_napi_has_mpc(struct bnxt *bp, int i);
+void bnxt_set_mpc_cp_ring(struct bnxt *bp, int bnapi_idx,
+			  struct bnxt_cp_ring_info *cpr);
 void bnxt_trim_mpc_rings(struct bnxt *bp);
 void bnxt_set_dflt_mpc_rings(struct bnxt *bp);
+void bnxt_init_mpc_ring_struct(struct bnxt *bp);
+int bnxt_alloc_mpcs(struct bnxt *bp);
+void bnxt_free_mpcs(struct bnxt *bp);
+int bnxt_alloc_mpc_rings(struct bnxt *bp);
+void bnxt_free_mpc_rings(struct bnxt *bp);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -63,6 +77,16 @@ static inline int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 	return 0;
 }
 
+static inline bool bnxt_napi_has_mpc(struct bnxt *bp, int i)
+{
+	return false;
+}
+
+static inline void bnxt_set_mpc_cp_ring(struct bnxt *bp, int bnapi_idx,
+					struct bnxt_cp_ring_info *cpr)
+{
+}
+
 static inline void bnxt_trim_mpc_rings(struct bnxt *bp)
 {
 }
@@ -70,5 +94,27 @@ static inline void bnxt_trim_mpc_rings(struct bnxt *bp)
 static inline void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
 {
 }
+
+static inline void bnxt_init_mpc_ring_struct(struct bnxt *bp)
+{
+}
+
+static inline int bnxt_alloc_mpcs(struct bnxt *bp)
+{
+	return 0;
+}
+
+static inline void bnxt_free_mpcs(struct bnxt *bp)
+{
+}
+
+static inline int bnxt_alloc_mpc_rings(struct bnxt *bp)
+{
+	return 0;
+}
+
+static inline void bnxt_free_mpc_rings(struct bnxt *bp)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0


