Return-Path: <netdev+bounces-268157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDN5Er3+t2nrXwEAu9opvQ
	(envelope-from <netdev+bounces-268157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:59:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0BD299C0D
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34FDC3018E26
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7F398900;
	Mon, 16 Mar 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hoH5iXn0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8E397E80;
	Mon, 16 Mar 2026 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773665906; cv=none; b=vFkyFRSWD2WHpprFDlgJa0SRUAY88D+hapoY8LZN7k/hCTbcVoYZ2LmSqptBfygVlZDtNYSX3jSejMwQTe9jOzMQJB5fVORPOwQSkz0tvceLt5vKBfcXc0KOH7tT8mH7DJysTv2ySBKYopsjHbyIhspHmMPI7mm6WPlLZh6fzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773665906; c=relaxed/simple;
	bh=A6UYsYStgOxgzuivrCQI2Tqyfu75VchHCMs4uIjrWbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOzvu3XmUsskKY0RM2lKagr5o7ipCK6hy8qaVOSbFmwcvVJoeUh95ki86cvkTpUJdfl7OpaaUNP9z8qbdAUYxRJSWbiqyHcjgg2Ir/cwUCHGxIOR2/zA1efHhVltko8SLfz4FkuNJekY6m65LgbnuXD9FR+w5AOd0shbNVK6qy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hoH5iXn0; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FMV63d3941001;
	Mon, 16 Mar 2026 05:58:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=rz4o47OQevyX70W68kz+3J4+r
	ivRiihxDu8yncCYvDk=; b=hoH5iXn0b8cjPQ3xTFSchVaZhSzr3q9hRDisnrfxY
	Ak8H3ZTmP94JAfNKRCAoI/8urbVPWwlZs9t5XJdXSB3naTz1LbXQwaSyyzjnytxZ
	DrcfbB057vnFCvwj6t1CUCe50udePPMOMNHD6Yw1T5/qNg8PpH6AvCnAO9Po81q5
	NQc9pJmYFCt00XnUxM6FTnLZOxTNyHLtSudY060jsbUHmLfn6t0Waakgf6L9XGwO
	wJ+uQJbczRzfl2g7v7F+SOdjCi6WxiS3ygT6IMoXu1VUrSNbWXADVprHzw19Ab0W
	xEaGQEAUnOH+uH78elaIEHA3w/P94JpTuQohvN65Dk3Ng==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cwux6j7qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 05:58:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Mar 2026 05:58:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Mar 2026 05:58:07 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 149913F7092;
	Mon, 16 Mar 2026 05:58:03 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net-next PATCH 4/4] octeontx2-pf: cn20k: Use unified Halo context
Date: Mon, 16 Mar 2026 18:27:39 +0530
Message-ID: <1773665859-4036-5-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1773665859-4036-1-git-send-email-sbhatta@marvell.com>
References: <1773665859-4036-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NyBTYWx0ZWRfX5Xcuw5lvgya0
 7euk4xt6czyOcOUMS9lJ/IykvmH7fAdYlPuMnh9cNAOjBCTrkPmXlVBnXCyaFz2Sj+s7zig6uV1
 iNBxxVEBQZSIhQpFrBgEi3WctGZWzXOqSALS4WwK+SMc6j1oTTouGmf6uIdch7gINvCFkT33fc3
 pjrGyzeX2fKCAmZ0hWemSCW7zCQ8A4FvbMTRTkYoAWRcr3VsXznewzLZrR4qLtSEhYbk60/UUu0
 vHGI6kgI4rHy1QFoYxnP+qFVA2+PnaqG5D0h7Y2HPyigest8/DCfwuQHtcS2FssqJ7qcgwn0XO5
 ka3BY3nc01aA1lVr40jXriDPpFBjkz0KqInAJSjwshiLAZ4WZIRalo16pVVE5CP3lVMdabaR9BB
 7e4xEKGLUB1WMG971gSPLUoF0jn+op76/yiQysQ6gOyMBc9w2KZj95W27TdGPfiwX6dKHYdCkGC
 P1o3GHxARKMs7OajI4g==
X-Proofpoint-GUID: vOl2fyUSQEC1i20WiSKfxdxqhMwQPE7o
X-Authority-Analysis: v=2.4 cv=KNtXzVFo c=1 sm=1 tr=0 ts=69b7fe60 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=i30aNKtkkqzyxUofeHAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: vOl2fyUSQEC1i20WiSKfxdxqhMwQPE7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268157-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6D0BD299C0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use unified Halo context present in CN20K hardware for
octeontx2 netdevs instead of aura and pool contexts.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 190 +++++++++---------
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   3 +
 .../marvell/octeontx2/nic/otx2_common.h       |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   6 +
 4 files changed, 107 insertions(+), 94 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index a5a8f4558717..db2742588bf6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -517,84 +517,7 @@ int cn20k_tc_alloc_entry(struct otx2_nic *nic,
 	return 0;
 }
 
-static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
-			      int pool_id, int numptrs)
-{
-	struct npa_cn20k_aq_enq_req *aq;
-	struct otx2_pool *pool;
-	u8 bpid_idx;
-	int err;
-
-	pool = &pfvf->qset.pool[pool_id];
-
-	/* Allocate memory for HW to update Aura count.
-	 * Alloc one cache line, so that it fits all FC_STYPE modes.
-	 */
-	if (!pool->fc_addr) {
-		err = qmem_alloc(pfvf->dev, &pool->fc_addr, 1, OTX2_ALIGN);
-		if (err)
-			return err;
-	}
-
-	/* Initialize this aura's context via AF */
-	aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
-	if (!aq) {
-		/* Shared mbox memory buffer is full, flush it and retry */
-		err = otx2_sync_mbox_msg(&pfvf->mbox);
-		if (err)
-			return err;
-		aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
-		if (!aq)
-			return -ENOMEM;
-	}
-
-	aq->aura_id = aura_id;
-
-	/* Will be filled by AF with correct pool context address */
-	aq->aura.pool_addr = pool_id;
-	aq->aura.pool_caching = 1;
-	aq->aura.shift = ilog2(numptrs) - 8;
-	aq->aura.count = numptrs;
-	aq->aura.limit = numptrs;
-	aq->aura.avg_level = 255;
-	aq->aura.ena = 1;
-	aq->aura.fc_ena = 1;
-	aq->aura.fc_addr = pool->fc_addr->iova;
-	aq->aura.fc_hyst_bits = 0; /* Store count on all updates */
-
-	/* Enable backpressure for RQ aura */
-	if (aura_id < pfvf->hw.rqpool_cnt && !is_otx2_lbkvf(pfvf->pdev)) {
-		aq->aura.bp_ena = 0;
-		/* If NIX1 LF is attached then specify NIX1_RX.
-		 *
-		 * Below NPA_AURA_S[BP_ENA] is set according to the
-		 * NPA_BPINTF_E enumeration given as:
-		 * 0x0 + a*0x1 where 'a' is 0 for NIX0_RX and 1 for NIX1_RX so
-		 * NIX0_RX is 0x0 + 0*0x1 = 0
-		 * NIX1_RX is 0x0 + 1*0x1 = 1
-		 * But in HRM it is given that
-		 * "NPA_AURA_S[BP_ENA](w1[33:32]) - Enable aura backpressure to
-		 * NIX-RX based on [BP] level. One bit per NIX-RX; index
-		 * enumerated by NPA_BPINTF_E."
-		 */
-		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
-			aq->aura.bp_ena = 1;
-
-		bpid_idx = cn20k_aura_bpid_idx(pfvf, aura_id);
-		aq->aura.bpid = pfvf->bpid[bpid_idx];
-
-		/* Set backpressure level for RQ's Aura */
-		aq->aura.bp = RQ_BP_LVL_AURA;
-	}
-
-	/* Fill AQ info */
-	aq->ctype = NPA_AQ_CTYPE_AURA;
-	aq->op = NPA_AQ_INSTOP_INIT;
-
-	return 0;
-}
-
-static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
+static int cn20k_halo_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 			      int stack_pages, int numptrs, int buf_size,
 			      int type)
 {
@@ -610,36 +533,55 @@ static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 	if (err)
 		return err;
 
+	/* Allocate memory for HW to update Aura count.
+	 * Alloc one cache line, so that it fits all FC_STYPE modes.
+	 */
+	if (!pool->fc_addr) {
+		err = qmem_alloc(pfvf->dev, &pool->fc_addr, 1, OTX2_ALIGN);
+		if (err) {
+			qmem_free(pfvf->dev, pool->stack);
+			return err;
+		}
+	}
+
 	pool->rbsize = buf_size;
 
-	/* Initialize this pool's context via AF */
+	/* Initialize this aura's context via AF */
 	aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
 	if (!aq) {
 		/* Shared mbox memory buffer is full, flush it and retry */
 		err = otx2_sync_mbox_msg(&pfvf->mbox);
-		if (err) {
-			qmem_free(pfvf->dev, pool->stack);
-			return err;
-		}
+		if (err)
+			goto free_mem;
 		aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
 		if (!aq) {
-			qmem_free(pfvf->dev, pool->stack);
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto free_mem;
 		}
 	}
 
 	aq->aura_id = pool_id;
-	aq->pool.stack_base = pool->stack->iova;
-	aq->pool.stack_caching = 1;
-	aq->pool.ena = 1;
-	aq->pool.buf_size = buf_size / 128;
-	aq->pool.stack_max_pages = stack_pages;
-	aq->pool.shift = ilog2(numptrs) - 8;
-	aq->pool.ptr_start = 0;
-	aq->pool.ptr_end = ~0ULL;
+
+	aq->halo.stack_base = pool->stack->iova;
+	aq->halo.stack_caching = 1;
+	aq->halo.ena = 1;
+	aq->halo.buf_size = buf_size / 128;
+	aq->halo.stack_max_pages = stack_pages;
+	aq->halo.shift = ilog2(numptrs) - 8;
+	aq->halo.ptr_start = 0;
+	aq->halo.ptr_end = ~0ULL;
+
+	aq->halo.avg_level = 255;
+	aq->halo.fc_ena = 1;
+	aq->halo.fc_addr = pool->fc_addr->iova;
+	aq->halo.fc_hyst_bits = 0; /* Store count on all updates */
+
+	aq->halo.op_dpc_ena = 1;
+	aq->halo.op_dpc_set = pfvf->npa_dpc;
+	aq->halo.unified_ctx = 1;
 
 	/* Fill AQ info */
-	aq->ctype = NPA_AQ_CTYPE_POOL;
+	aq->ctype = NPA_AQ_CTYPE_HALO;
 	aq->op = NPA_AQ_INSTOP_INIT;
 
 	if (type != AURA_NIX_RQ) {
@@ -661,6 +603,66 @@ static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 	}
 
 	return 0;
+
+free_mem:
+	qmem_free(pfvf->dev, pool->stack);
+	qmem_free(pfvf->dev, pool->fc_addr);
+	return err;
+}
+
+static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
+			      int pool_id, int numptrs)
+{
+	return 0;
+}
+
+static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
+			      int stack_pages, int numptrs, int buf_size,
+			      int type)
+{
+	return cn20k_halo_aq_init(pfvf, pool_id, stack_pages,
+				  numptrs, buf_size, type);
+}
+
+int cn20k_npa_alloc_dpc(struct otx2_nic *nic)
+{
+	struct npa_cn20k_dpc_alloc_req *req;
+	struct npa_cn20k_dpc_alloc_rsp *rsp;
+	int err;
+
+	req = otx2_mbox_alloc_msg_npa_cn20k_dpc_alloc(&nic->mbox);
+	if (!req)
+		return -ENOMEM;
+
+	/* Count successful ALLOC requests only */
+	req->dpc_conf = 1ULL << 4;
+
+	err = otx2_sync_mbox_msg(&nic->mbox);
+	if (err)
+		return err;
+
+	rsp = (struct npa_cn20k_dpc_alloc_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
+								  0, &req->hdr);
+
+	nic->npa_dpc = rsp->cntr_id;
+
+	return 0;
+}
+
+int cn20k_npa_free_dpc(struct otx2_nic *nic)
+{
+	struct npa_cn20k_dpc_free_req *req;
+	int err;
+
+	req = otx2_mbox_alloc_msg_npa_cn20k_dpc_free(&nic->mbox);
+	if (!req)
+		return -ENOMEM;
+
+	req->cntr_id = nic->npa_dpc;
+
+	err = otx2_sync_mbox_msg(&nic->mbox);
+
+	return err;
 }
 
 static int cn20k_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
index b5e527f6d7eb..16a69d84ea79 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
@@ -28,4 +28,7 @@ int cn20k_tc_alloc_entry(struct otx2_nic *nic,
 			 struct otx2_tc_flow *new_node,
 			 struct npc_install_flow_req *dummy);
 int cn20k_tc_free_mcam_entry(struct otx2_nic *nic, u16 entry);
+int cn20k_npa_alloc_dpc(struct otx2_nic *nic);
+int cn20k_npa_free_dpc(struct otx2_nic *nic);
+
 #endif /* CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..06d96059d026 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -592,6 +592,8 @@ struct otx2_nic {
 	struct cn10k_ipsec	ipsec;
 	/* af_xdp zero-copy */
 	unsigned long		*af_xdp_zc_qidx;
+
+	u8			npa_dpc; /* NPA DPC counter id */
 };
 
 static inline bool is_otx2_lbkvf(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ee623476e5ff..2941549d46c8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1651,6 +1651,9 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
 	if (!is_otx2_lbkvf(pf->pdev))
 		otx2_nix_config_bp(pf, true);
 
+	if (is_cn20k(pf->pdev))
+		cn20k_npa_alloc_dpc(pf);
+
 	/* Init Auras and pools used by NIX RQ, for free buffer ptrs */
 	err = otx2_rq_aura_pool_init(pf);
 	if (err) {
@@ -1790,6 +1793,9 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
 
 	otx2_free_sq_res(pf);
 
+	if (is_cn20k(pf->pdev))
+		cn20k_npa_free_dpc(pf);
+
 	/* Free RQ buffer pointers*/
 	otx2_free_aura_ptr(pf, AURA_NIX_RQ);
 
-- 
2.48.1


