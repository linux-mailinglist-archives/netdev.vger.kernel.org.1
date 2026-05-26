Return-Path: <netdev+bounces-291658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLVaMGt7FWp8VgcAu9opvQ
	(envelope-from <netdev+bounces-291658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:52:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2875D4686
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 459A6306BCD0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4063DDDA5;
	Tue, 26 May 2026 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iaJ6pvSO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C93DDDD5;
	Tue, 26 May 2026 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792492; cv=none; b=VU0w6M8HlRfp4vwItUFxKWZZtsyEfsm8161jpz62y2+RPCk4C8cXpO5AzVQq+JtUon3Ca5PHkMepAV3BQ5bNkoIgPVGLS+VqjaCpwBLGysZ31b+mH30QlenJOxl21dyw43kO5WUwTROic58A5o/SiIOiTvSxJWL3g+WTid+Y89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792492; c=relaxed/simple;
	bh=Nf0EnF6iqOkAmosCCrHdvWG/EG2O/ZPOWpfDeCRtY9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9Q0g56aR5/pAx60aq3mw7xPvMJtpEOP4G1sBum1nDI6YS+W5rmRuWZDUdxMJ/Fgc/QqxoPJ3hmIqoFON5NqoU2DnW+BW/4Jsk9PuCf2AcZbvBJZWyrUPFOtOUHOOh0pV7zDZjqWJgs3Fy1wPsahb+Xa0zvfzGUSX75RiSmQkjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iaJ6pvSO; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q9sYsf1201198;
	Tue, 26 May 2026 03:47:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=IBm0+zDbTzFmwnrElL6Gzsdbb
	oyLUGhN+JRNYfLW3Dc=; b=iaJ6pvSOjQ0AgQ1VBE41sQSUGJlL+DZZNckK2tpFv
	U+5+P5zkIbNZwzc2GxvQ2MI5iJlQNdt2NYmOhZT71rOtbDw0pQ6ht1aFy3qxYtxP
	6c4eKNXh3ivq5FoVqZdgCig2kSBJ4oT+cJPJMzx/DZoWGRImZeaLgtqLcJ6FhYlV
	qma/kf4Evl/d/UwQXNQcpSUjsd0IqYHBNmRISFbDclz9uq5pe2IR96c27En0bsJZ
	6iBymdmxNlbxbo9heLAF4xuiMmPYh7XubN0FnMKNFN+66ze9RHP8EbX4Y6F5x1HW
	joBOoHV/aXuIvGMwFfGWg/KwByEbHnYCSk/KntkN8mM0w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ebbrf7unu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 03:47:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 26 May 2026 03:47:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 26 May 2026 03:47:53 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 887703F7045;
	Tue, 26 May 2026 03:47:50 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net-next PATCH v6 5/5] octeontx2-pf: cn20k: Use unified Halo context
Date: Tue, 26 May 2026 16:17:27 +0530
Message-ID: <1779792447-5593-6-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=epTvCIpX c=1 sm=1 tr=0 ts=6a157a5b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=5QXT97Cb7cX96sVZDOwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: mQNedy8tfzuaJ7cTsZwIZRnKibpPLvki
X-Proofpoint-GUID: mQNedy8tfzuaJ7cTsZwIZRnKibpPLvki
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5MyBTYWx0ZWRfX3oRbFvIpNRDP
 yzQVYp70dgHUR9OApwWX5Aci018ILhsd71qJeMZHTYad+XHbPxeJHoxaNqUoklf8AaTA5rhaBoS
 dhM74GVyaxnUbJQnWvGeLaQphMZDjhTyY+6NbUeguZJ3AJLU/gIWOoqoR8tTtfFoF+wYs94sWLe
 o42upV/fQ/quzJcnWCa4edLy+OHAG6cBU/K09CLu/0UwRuzJSpGEEMx2Ic7gBrhFL38zc1xXBFb
 eNyUMuBDowBEz5LUBcW2WbtHUvofdgHH1SeTLuEweIxULD2hukaXdKgczpMhPCi+6pZQxrw+S9z
 TZjrSYxS8Sf4Wq8yDTpfAmRVgYdqEdOgqA6nSo0HZsTLg5y1EtVKRYR6DbYM5FvsOB5dIpatsp4
 nagWCt0gf+VKzv3pPcjQhNgBLhLeo0GSxcIYDfdNgknELveLe0oqQpxSQ7ILm7AzBUvEMPYeL8g
 tR7/89Y0IwMIUakW5xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291658-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1B2875D4686
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use unified Halo context present in CN20K hardware for
octeontx2 netdevs instead of aura and pool contexts.
Note that with this halo context in place RQ backpressure
is not being configured and the same will be supported
later.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 209 +++++++++---------
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   3 +
 .../marvell/octeontx2/nic/otx2_common.h       |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   8 +
 4 files changed, 120 insertions(+), 103 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index dbf173196608..721721dc1564 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -242,15 +242,6 @@ int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
 
 #define RQ_BP_LVL_AURA   (255 - ((85 * 256) / 100)) /* BP when 85% is full */
 
-static u8 cn20k_aura_bpid_idx(struct otx2_nic *pfvf, int aura_id)
-{
-#ifdef CONFIG_DCB
-	return pfvf->queue_to_pfc_map[aura_id];
-#else
-	return 0;
-#endif
-}
-
 static int cn20k_tc_get_entry_index(struct otx2_flow_config *flow_cfg,
 				    struct otx2_tc_flow *node)
 {
@@ -517,15 +508,22 @@ int cn20k_tc_alloc_entry(struct otx2_nic *nic,
 	return 0;
 }
 
-static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
-			      int pool_id, int numptrs)
+static int cn20k_halo_aq_init(struct otx2_nic *pfvf, u16 pool_id,
+			      int stack_pages, int numptrs, int buf_size,
+			      int type)
 {
+	struct page_pool_params pp_params = { 0 };
 	struct npa_cn20k_aq_enq_req *aq;
 	struct otx2_pool *pool;
-	u8 bpid_idx;
-	int err;
+	struct page_pool *pp;
+	int err, sz;
 
 	pool = &pfvf->qset.pool[pool_id];
+	/* Alloc memory for stack which is used to store buffer pointers */
+	err = qmem_alloc(pfvf->dev, &pool->stack,
+			 stack_pages, pfvf->hw.stack_pg_bytes);
+	if (err)
+		return err;
 
 	/* Allocate memory for HW to update Aura count.
 	 * Alloc one cache line, so that it fits all FC_STYPE modes.
@@ -536,6 +534,8 @@ static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
 			return err;
 	}
 
+	pool->rbsize = buf_size;
+
 	/* Initialize this aura's context via AF */
 	aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
 	if (!aq) {
@@ -548,49 +548,60 @@ static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
 			return -ENOMEM;
 	}
 
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
+	aq->aura_id = pool_id;
 
-		/* Set backpressure level for RQ's Aura */
-		aq->aura.bp = RQ_BP_LVL_AURA;
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
+	if (pfvf->npa_dpc_valid) {
+		aq->halo.op_dpc_ena = 1;
+		aq->halo.op_dpc_set = pfvf->npa_dpc;
 	}
+	aq->halo.unified_ctx = 1;
 
 	/* Fill AQ info */
-	aq->ctype = NPA_AQ_CTYPE_AURA;
+	aq->ctype = NPA_AQ_CTYPE_HALO;
 	aq->op = NPA_AQ_INSTOP_INIT;
 
+	if (type != AURA_NIX_RQ) {
+		pool->page_pool = NULL;
+		return 0;
+	}
+
+	sz = ALIGN(ALIGN(SKB_DATA_ALIGN(buf_size), OTX2_ALIGN), PAGE_SIZE);
+	pp_params.order = get_order(sz);
+	pp_params.flags = PP_FLAG_DMA_MAP;
+	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
+	pp_params.nid = NUMA_NO_NODE;
+	pp_params.dev = pfvf->dev;
+	pp_params.dma_dir = DMA_FROM_DEVICE;
+
+	pp = page_pool_create(&pp_params);
+	if (IS_ERR(pp)) {
+		netdev_err(pfvf->netdev, "Creation of page pool failed\n");
+		pool->page_pool = NULL;
+		return PTR_ERR(pp);
+	}
+
+	pool->page_pool = pp;
+
+	return 0;
+}
+
+static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
+			      int pool_id, int numptrs)
+{
 	return 0;
 }
 
@@ -598,71 +609,63 @@ static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 			      int stack_pages, int numptrs, int buf_size,
 			      int type)
 {
-	struct page_pool_params pp_params = { 0 };
-	struct npa_cn20k_aq_enq_req *aq;
-	struct otx2_pool *pool;
-	int err, sz;
+	return cn20k_halo_aq_init(pfvf, pool_id, stack_pages,
+				  numptrs, buf_size, type);
+}
 
-	pool = &pfvf->qset.pool[pool_id];
-	/* Alloc memory for stack which is used to store buffer pointers */
-	err = qmem_alloc(pfvf->dev, &pool->stack,
-			 stack_pages, pfvf->hw.stack_pg_bytes);
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
 	if (err)
 		return err;
 
-	pool->rbsize = buf_size;
+	rsp = (struct npa_cn20k_dpc_alloc_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
+								  0, &req->hdr);
+	if (IS_ERR(rsp))
+		return PTR_ERR(rsp);
 
-	/* Initialize this pool's context via AF */
-	aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
-	if (!aq) {
-		/* Shared mbox memory buffer is full, flush it and retry */
-		err = otx2_sync_mbox_msg(&pfvf->mbox);
-		if (err) {
-			qmem_free(pfvf->dev, pool->stack);
-			pool->stack = NULL;
-			return err;
-		}
-		aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
-		if (!aq) {
-			qmem_free(pfvf->dev, pool->stack);
-			pool->stack = NULL;
-			return -ENOMEM;
-		}
-	}
+	nic->npa_dpc = rsp->cntr_id;
+	nic->npa_dpc_valid = true;
 
-	aq->aura_id = pool_id;
-	aq->pool.stack_base = pool->stack->iova;
-	aq->pool.stack_caching = 1;
-	aq->pool.ena = 1;
-	aq->pool.buf_size = buf_size / 128;
-	aq->pool.stack_max_pages = stack_pages;
-	aq->pool.shift = ilog2(numptrs) - 8;
-	aq->pool.ptr_start = 0;
-	aq->pool.ptr_end = ~0ULL;
+	return 0;
+}
 
-	/* Fill AQ info */
-	aq->ctype = NPA_AQ_CTYPE_POOL;
-	aq->op = NPA_AQ_INSTOP_INIT;
+int cn20k_npa_free_dpc(struct otx2_nic *nic)
+{
+	struct npa_cn20k_dpc_free_req *req;
+	int err;
 
-	if (type != AURA_NIX_RQ) {
-		pool->page_pool = NULL;
+	if (!nic->npa_dpc_valid)
 		return 0;
-	}
 
-	sz = ALIGN(ALIGN(SKB_DATA_ALIGN(buf_size), OTX2_ALIGN), PAGE_SIZE);
-	pp_params.order = get_order(sz);
-	pp_params.flags = PP_FLAG_DMA_MAP;
-	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
-	pp_params.nid = NUMA_NO_NODE;
-	pp_params.dev = pfvf->dev;
-	pp_params.dma_dir = DMA_FROM_DEVICE;
-	pool->page_pool = page_pool_create(&pp_params);
-	if (IS_ERR(pool->page_pool)) {
-		netdev_err(pfvf->netdev, "Creation of page pool failed\n");
-		return PTR_ERR(pool->page_pool);
+	mutex_lock(&nic->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_npa_cn20k_dpc_free(&nic->mbox);
+	if (!req) {
+		mutex_unlock(&nic->mbox.lock);
+		return -ENOMEM;
 	}
 
-	return 0;
+	req->cntr_id = nic->npa_dpc;
+
+	err = otx2_sync_mbox_msg(&nic->mbox);
+	if (!err)
+		nic->npa_dpc_valid = false;
+
+	mutex_unlock(&nic->mbox.lock);
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
index eecee612b7b2..f997dfc0fedd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -592,6 +592,9 @@ struct otx2_nic {
 	struct cn10k_ipsec	ipsec;
 	/* af_xdp zero-copy */
 	unsigned long		*af_xdp_zc_qidx;
+
+	bool			npa_dpc_valid;
+	u8			npa_dpc; /* NPA DPC counter id */
 };
 
 static inline bool is_otx2_lbkvf(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ee623476e5ff..2b5fe67d297c 100644
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
@@ -1726,6 +1729,8 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
 	otx2_ctx_disable(mbox, NPA_AQ_CTYPE_AURA, true);
 	otx2_aura_pool_free(pf);
 err_free_nix_lf:
+	if (pf->npa_dpc_valid)
+		cn20k_npa_free_dpc(pf);
 	mutex_lock(&mbox->lock);
 	free_req = otx2_mbox_alloc_msg_nix_lf_free(mbox);
 	if (free_req) {
@@ -1790,6 +1795,9 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
 
 	otx2_free_sq_res(pf);
 
+	if (is_cn20k(pf->pdev))
+		cn20k_npa_free_dpc(pf);
+
 	/* Free RQ buffer pointers*/
 	otx2_free_aura_ptr(pf, AURA_NIX_RQ);
 
-- 
2.48.1


