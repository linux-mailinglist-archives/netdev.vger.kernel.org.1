Return-Path: <netdev+bounces-291655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLrLAqd6FWp8VgcAu9opvQ
	(envelope-from <netdev+bounces-291655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:49:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 979125D4621
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE649303C036
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416F73DD855;
	Tue, 26 May 2026 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GhieI+XH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CE390616;
	Tue, 26 May 2026 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792478; cv=none; b=bd3bKs3Efq1c8V5bn7HOYiEg1PqjsaF4avLqfvCjn484ncPXhO7aFEBD31as54Y+1kSeAWDnCRhIDsZ0RYqpLJeVdshCEx6xM/7wxkZUNtdZeXn9NQx2xM7d3BD77tLyVsAHeN4VIWMViMFXPbuUDUCOr3PSpIJTy/5obsO12Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792478; c=relaxed/simple;
	bh=fPxkr4Xu0P0u827iVDLRzW0DbN+jisF3bi+QqgoOBzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5SbwMEQQWFhOtOkXSSw4jhyTGIQWORlz0AQVwL24FCSTgYUQPcLYhsouzWQYFaU1qYzUSi/Jov+gBeR4y9QpVky2jNXjvufOnVgSwKOvmnVtOKQmPxuTqagISuOTNjU+TItD0Su3InwP7r1GESV5e7pxOBBZGYXOEZkvQEhrnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GhieI+XH; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QAPSHU1015763;
	Tue, 26 May 2026 03:47:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=HiiL9JpbGfLHBobag5//Z3xV2
	zRrT3+Ix4yOaknWtgI=; b=GhieI+XHpvOOI/VvNC9mc5qs7nUXzhTPHeQUlrPMQ
	za2tnAFTcVclLvE3T8xa8F351LVxoV8xkiQAbJsZqQ9GKVwjUnGqQPiefsqXv4lf
	w3PaTOh+9NJGo5WDTi7HVfQ65TWJ1HGo7KLue9nQOxAyWdk+9OM8Zvjr+ZwmXaJN
	YmXE+AwyI3DGEG9/t1zHcM7wpuGTEoEZrYvxQ2cxXhwBGVK5NQPRO746FFgp5gmG
	xeiauk3eAND+JdfFt2n2p1g2eRSGrwWWi2fCfs6AlaBXtk4UEHnolRaJzWv3Chti
	d1E//VqLOBfVvM7wJ8+UsK5S1E7p+00KczuKxNbd/L0qQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ec0g6dpj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 03:47:42 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 26 May 2026 03:47:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 26 May 2026 03:47:41 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 11B223F7051;
	Tue, 26 May 2026 03:47:37 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linu Cherian
	<lcherian@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v6 2/5] octeontx2-af: npa: cn20k: Add NPA Halo support
Date: Tue, 26 May 2026 16:17:24 +0530
Message-ID: <1779792447-5593-3-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1779792447-5593-1-git-send-email-sbhatta@marvell.com>
References: <1779792447-5593-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BK6DalQG c=1 sm=1 tr=0 ts=6a157a4e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=K_mExLjy7pjPs-0ftoIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: FWSFykoR9ji2HUOTPwEvZ5XE_Xc_n1im
X-Proofpoint-ORIG-GUID: FWSFykoR9ji2HUOTPwEvZ5XE_Xc_n1im
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5MyBTYWx0ZWRfX+GK8Lj9LO4Jc
 4nWik2TIyfnwbRp/m6IuGt+Xs1GqXFN23Ghrr2+i9cWzPw+Xyd+CyCCUvxz2FXogeHy+TrqTTbn
 5YCplzLppaDgv/s/KqS+QSlc8YE0z/my5RyROkoskTl245FFCO69Xemo+5TL5rqpSWlTIF7UiFJ
 f1o4G1q0ttJA7kJUggFQ0vLrZ3f+mq3lhZjXxbCSvLodSFTQgTgj7HDBTHMmgWo7YYbdjea5Dii
 FL5WSchYqJhrEIUuh71/2T03YGeg3eBo9jisn2aKaaOv8gGPsmbilxr/JZtKEfPcrCKytKPuv0T
 7ixH98J6sJpotB1HOyRWqGysc/d71v46JGknJNmalXvB2gREvBzjxIkzM3hbdQbfuwo/N+OG6FK
 ucPN+3lSH80SDkk7PfGnsW5r0XORNXMovD1v/god2HX3dLm/ry4GuAIqZ0BzAvSbB9gtNb45Jax
 gaR10SqwSUTWL/lJpXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291655-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 979125D4621
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Linu Cherian <lcherian@marvell.com>

CN20K silicon implements unified aura and pool context
type called Halo for better resource usage. Add support to
handle Halo context type operations.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../marvell/octeontx2/af/cn20k/struct.h       | 81 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  6 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   | 59 ++++++++++++--
 .../marvell/octeontx2/af/rvu_struct.h         |  1 +
 5 files changed, 141 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
index 763f6cabd7c2..2364bafd329d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
@@ -377,4 +377,85 @@ struct npa_cn20k_pool_s {
 
 static_assert(sizeof(struct npa_cn20k_pool_s) == NIX_MAX_CTX_SIZE);
 
+struct npa_cn20k_halo_s {
+	u64 stack_base                  : 64;
+	u64 ena                         :  1;
+	u64 nat_align                   :  1;
+	u64 reserved_66_67              :  2;
+	u64 stack_caching               :  1;
+	u64 reserved_69_71              :  3;
+	u64 aura_drop_ena               :  1;
+	u64 reserved_73_79              :  7;
+	u64 aura_drop                   :  8;
+	u64 buf_offset                  : 12;
+	u64 reserved_100_103            :  4;
+	u64 buf_size                    : 12;
+	u64 reserved_116_119            :  4;
+	u64 ref_cnt_prof                :  3;
+	u64 reserved_123_127            :  5;
+	u64 stack_max_pages             : 32;
+	u64 stack_pages                 : 32;
+	u64 bp_0                        :  7;
+	u64 bp_1                        :  7;
+	u64 bp_2                        :  7;
+	u64 bp_3                        :  7;
+	u64 bp_4                        :  7;
+	u64 bp_5                        :  7;
+	u64 bp_6                        :  7;
+	u64 bp_7                        :  7;
+	u64 bp_ena_0                    :  1;
+	u64 bp_ena_1                    :  1;
+	u64 bp_ena_2                    :  1;
+	u64 bp_ena_3                    :  1;
+	u64 bp_ena_4                    :  1;
+	u64 bp_ena_5                    :  1;
+	u64 bp_ena_6                    :  1;
+	u64 bp_ena_7                    :  1;
+	u64 stack_offset                :  4;
+	u64 reserved_260_263            :  4;
+	u64 shift                       :  6;
+	u64 reserved_270_271            :  2;
+	u64 avg_level                   :  8;
+	u64 avg_con                     :  9;
+	u64 fc_ena                      :  1;
+	u64 fc_stype                    :  2;
+	u64 fc_hyst_bits                :  4;
+	u64 fc_up_crossing              :  1;
+	u64 reserved_297_299            :  3;
+	u64 update_time                 : 16;
+	u64 reserved_316_319            :  4;
+	u64 fc_addr                     : 64;
+	u64 ptr_start                   : 64;
+	u64 ptr_end                     : 64;
+	u64 bpid_0                      : 12;
+	u64 reserved_524_535            : 12;
+	u64 err_int                     :  8;
+	u64 err_int_ena                 :  8;
+	u64 thresh_int                  :  1;
+	u64 thresh_int_ena              :  1;
+	u64 thresh_up                   :  1;
+	u64 reserved_555                :  1;
+	u64 thresh_qint_idx             :  7;
+	u64 reserved_563                :  1;
+	u64 err_qint_idx                :  7;
+	u64 reserved_571_575            :  5;
+	u64 thresh                      : 36;
+	u64 reserved_612_615            :  4;
+	u64 fc_msh_dst                  : 11;
+	u64 reserved_627_630            :  4;
+	u64 op_dpc_ena                  :  1;
+	u64 op_dpc_set                  :  5;
+	u64 reserved_637_637            :  1;
+	u64 stream_ctx                  :  1;
+	u64 unified_ctx                 :  1;
+	u64 reserved_640_703            : 64;
+	u64 reserved_704_767            : 64;
+	u64 reserved_768_831            : 64;
+	u64 reserved_832_895            : 64;
+	u64 reserved_896_959            : 64;
+	u64 reserved_960_1023           : 64;
+};
+
+static_assert(sizeof(struct npa_cn20k_halo_s) == NIX_MAX_CTX_SIZE);
+
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index dc42c81c0942..4a97bd93d882 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -884,6 +884,8 @@ struct npa_cn20k_aq_enq_req {
 		struct npa_cn20k_aura_s aura;
 		/* Valid when op == WRITE/INIT and ctype == POOL */
 		struct npa_cn20k_pool_s pool;
+		/* Valid when op == WRITE/INIT and ctype == HALO */
+		struct npa_cn20k_halo_s halo;
 	};
 	/* Mask data when op == WRITE (1=write, 0=don't write) */
 	union {
@@ -891,6 +893,8 @@ struct npa_cn20k_aq_enq_req {
 		struct npa_cn20k_aura_s aura_mask;
 		/* Valid when op == WRITE and ctype == POOL */
 		struct npa_cn20k_pool_s pool_mask;
+		/* Valid when op == WRITE/INIT and ctype == HALO */
+		struct npa_cn20k_halo_s halo_mask;
 	};
 };
 
@@ -901,6 +905,8 @@ struct npa_cn20k_aq_enq_rsp {
 		struct npa_cn20k_aura_s aura;
 		/* Valid when op == READ and ctype == POOL */
 		struct npa_cn20k_pool_s pool;
+		/* Valid when op == READ and ctype == HALO */
+		struct npa_cn20k_halo_s halo;
 	};
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a466181cf908..0c4dae6d0967 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -261,6 +261,7 @@ struct rvu_pfvf {
 	struct qmem	*pool_ctx;
 	struct qmem	*npa_qints_ctx;
 	unsigned long	*aura_bmap;
+	unsigned long	*halo_bmap;
 	unsigned long	*pool_bmap;
 
 	/* NIX contexts */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
index df783c4e5d75..d15e6969ee56 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
@@ -12,6 +12,11 @@
 #include "rvu_reg.h"
 #include "rvu.h"
 
+static bool npa_ctype_invalid(struct rvu *rvu, int ctype)
+{
+	return !is_cn20k(rvu->pdev) && ctype == NPA_AQ_CTYPE_HALO;
+}
+
 static int npa_aq_enqueue_wait(struct rvu *rvu, struct rvu_block *block,
 			       struct npa_aq_inst_s *inst)
 {
@@ -72,7 +77,8 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 	bool ena;
 
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
-	if (!pfvf->aura_ctx || req->aura_id >= pfvf->aura_ctx->qsize)
+	if (!pfvf->aura_ctx || req->aura_id >= pfvf->aura_ctx->qsize ||
+	    npa_ctype_invalid(rvu, req->ctype))
 		return NPA_AF_ERR_AQ_ENQUEUE;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, pcifunc);
@@ -118,7 +124,7 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 		if (req->ctype == NPA_AQ_CTYPE_AURA) {
 			memcpy(mask, &req->aura_mask, NIX_MAX_CTX_SIZE);
 			memcpy(ctx, &req->aura, NIX_MAX_CTX_SIZE);
-		} else {
+		} else { /* Applies to pool and halo since size is same */
 			memcpy(mask, &req->pool_mask, NIX_MAX_CTX_SIZE);
 			memcpy(ctx, &req->pool, NIX_MAX_CTX_SIZE);
 		}
@@ -133,7 +139,7 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 			req->aura.pool_addr = pfvf->pool_ctx->iova +
 			(req->aura.pool_addr * pfvf->pool_ctx->entry_sz);
 			memcpy(ctx, &req->aura, NIX_MAX_CTX_SIZE);
-		} else { /* POOL's context */
+		} else { /* Applies to pool and halo since size is same */
 			memcpy(ctx, &req->pool, NIX_MAX_CTX_SIZE);
 		}
 		break;
@@ -174,6 +180,20 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 		}
 	}
 
+	if (req->ctype == NPA_AQ_CTYPE_HALO) {
+		if (req->op == NPA_AQ_INSTOP_INIT && req->aura.ena)
+			__set_bit(req->aura_id, pfvf->halo_bmap);
+		if (req->op == NPA_AQ_INSTOP_WRITE) {
+			ena = (req->aura.ena & req->aura_mask.ena) |
+				(test_bit(req->aura_id, pfvf->halo_bmap) &
+				~req->aura_mask.ena);
+			if (ena)
+				__set_bit(req->aura_id, pfvf->halo_bmap);
+			else
+				__clear_bit(req->aura_id, pfvf->halo_bmap);
+		}
+	}
+
 	/* Set pool bitmap if pool hw context is enabled */
 	if (req->ctype == NPA_AQ_CTYPE_POOL) {
 		if (req->op == NPA_AQ_INSTOP_INIT && req->pool.ena)
@@ -195,7 +215,7 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 		if (req->op == NPA_AQ_INSTOP_READ) {
 			if (req->ctype == NPA_AQ_CTYPE_AURA)
 				memcpy(&rsp->aura, ctx, NIX_MAX_CTX_SIZE);
-			else
+			else /* Applies to pool and halo since size is same */
 				memcpy(&rsp->pool, ctx, NIX_MAX_CTX_SIZE);
 		}
 	}
@@ -206,12 +226,14 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 static int npa_lf_hwctx_disable(struct rvu *rvu, struct hwctx_disable_req *req)
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
+	const char *context = "Unknown";
 	struct npa_aq_enq_req aq_req;
 	unsigned long *bmap;
 	int id, cnt = 0;
 	int err = 0, rc;
 
-	if (!pfvf->pool_ctx || !pfvf->aura_ctx)
+	if (!pfvf->pool_ctx || !pfvf->aura_ctx ||
+	    npa_ctype_invalid(rvu, req->ctype))
 		return NPA_AF_ERR_AQ_ENQUEUE;
 
 	memset(&aq_req, 0, sizeof(struct npa_aq_enq_req));
@@ -222,6 +244,7 @@ static int npa_lf_hwctx_disable(struct rvu *rvu, struct hwctx_disable_req *req)
 		aq_req.pool_mask.ena = 1;
 		cnt = pfvf->pool_ctx->qsize;
 		bmap = pfvf->pool_bmap;
+		context = "Pool";
 	} else if (req->ctype == NPA_AQ_CTYPE_AURA) {
 		aq_req.aura.ena = 0;
 		aq_req.aura_mask.ena = 1;
@@ -229,6 +252,13 @@ static int npa_lf_hwctx_disable(struct rvu *rvu, struct hwctx_disable_req *req)
 		aq_req.aura_mask.bp_ena = 1;
 		cnt = pfvf->aura_ctx->qsize;
 		bmap = pfvf->aura_bmap;
+		context = "Aura";
+	} else if (req->ctype == NPA_AQ_CTYPE_HALO) {
+		aq_req.aura.ena = 0;
+		aq_req.aura_mask.ena = 1;
+		cnt = pfvf->aura_ctx->qsize;
+		bmap = pfvf->halo_bmap;
+		context = "Halo";
 	}
 
 	aq_req.ctype = req->ctype;
@@ -242,8 +272,7 @@ static int npa_lf_hwctx_disable(struct rvu *rvu, struct hwctx_disable_req *req)
 		if (rc) {
 			err = rc;
 			dev_err(rvu->dev, "Failed to disable %s:%d context\n",
-				(req->ctype == NPA_AQ_CTYPE_AURA) ?
-				"Aura" : "Pool", id);
+				context, id);
 		}
 	}
 
@@ -307,6 +336,9 @@ static void npa_ctx_free(struct rvu *rvu, struct rvu_pfvf *pfvf)
 	kfree(pfvf->aura_bmap);
 	pfvf->aura_bmap = NULL;
 
+	kfree(pfvf->halo_bmap);
+	pfvf->halo_bmap = NULL;
+
 	qmem_free(rvu->dev, pfvf->aura_ctx);
 	pfvf->aura_ctx = NULL;
 
@@ -370,6 +402,13 @@ int rvu_mbox_handler_npa_lf_alloc(struct rvu *rvu,
 	if (!pfvf->aura_bmap)
 		goto free_mem;
 
+	if (is_cn20k(rvu->pdev)) {
+		pfvf->halo_bmap = kcalloc(NPA_AURA_COUNT(req->aura_sz),
+					  sizeof(long), GFP_KERNEL);
+		if (!pfvf->halo_bmap)
+			goto free_mem;
+	}
+
 	/* Alloc memory for pool HW contexts */
 	hwctx_size = 1UL << ((ctx_cfg >> 4) & 0xF);
 	err = qmem_alloc(rvu->dev, &pfvf->pool_ctx, req->nr_pools, hwctx_size);
@@ -558,6 +597,12 @@ void rvu_npa_lf_teardown(struct rvu *rvu, u16 pcifunc, int npalf)
 	ctx_req.ctype = NPA_AQ_CTYPE_AURA;
 	npa_lf_hwctx_disable(rvu, &ctx_req);
 
+	/* Disable all Halos */
+	if (is_cn20k(rvu->pdev)) {
+		ctx_req.ctype = NPA_AQ_CTYPE_HALO;
+		npa_lf_hwctx_disable(rvu, &ctx_req);
+	}
+
 	npa_ctx_free(rvu, pfvf);
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index 1e51ed197b29..2a732376a45d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -130,6 +130,7 @@ enum npa_aq_comp {
 enum npa_aq_ctype {
 	NPA_AQ_CTYPE_AURA = 0x0,
 	NPA_AQ_CTYPE_POOL = 0x1,
+	NPA_AQ_CTYPE_HALO = 0x2,
 };
 
 /* NPA admin queue instruction opcodes */
-- 
2.48.1


