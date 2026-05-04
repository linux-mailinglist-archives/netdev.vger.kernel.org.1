Return-Path: <netdev+bounces-283718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA5QJw1M+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:34:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1AD4B965C
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5C0C3015A63
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887F12DCF45;
	Mon,  4 May 2026 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hJDHx9EY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67772253FC;
	Mon,  4 May 2026 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879983; cv=none; b=OseDU7TycvJhypjA+j5k/TrnBt84w2Ksc0hUlNkwL0WYigZX5I0GTNqA7bG2+Y9m3gNG5luwzgPzv0LhyyNEyoIpXIwtbnN+XccAYy2gGbdxlFPveYeXu+jvTiVw3kmvbMJ+nHHZ3sRBZR20ZSMVTGyZUfwn0GI6lefa0K6LEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879983; c=relaxed/simple;
	bh=ydN5RopozIbLunm8csZWi+GOtR+tbERQ+Oko8kN9DLM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LX3F6keLxX2YfgL04zkeNm/owCKly9Czn4SZsJRecOhvNoiOAHp3GBDoS9reQH4sOFK1O4S0grvJiXiEZHUn8PkuFng2lzvExqqKwgaDbqIgETSU/FRuCd3zd3eX9fhbKacKbqx4zmtwmHtU/prCfV5C/8M9DjI7aV5YoxZfCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hJDHx9EY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6440rqJS747456;
	Mon, 4 May 2026 00:32:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=w0JfpBr1k2B/fwq9j1opQTwVg
	VSvzJSdrjDDbDMOzz0=; b=hJDHx9EYxWBmWNrf8l1+aF3MqeN6kBWsY8b/8cjb6
	kYqUTZ+vU6f4jqYQC/tPxseXDkxH6xUcBX0gykvda7GWxxo5PFsuCK3p+C6YScLl
	pIQncHBVGQ6wibIYsvrISPwUZZR/N00gRuKjEMyo0in6mJQ6A+6aN1x66tyvm6Q4
	SGOOzI1MFUJIIv5tv8tqP4mg2qcxTmEIVZuUWUrTqd64UC7aIPKwhlRcq3Et4OCC
	3EMutvSpsejJe1NXGkyoVRtGauQg4UuFshAqkzinHvVLNCUccDX9ejUdXV2y4PGd
	rhiCXsitaXLL72LmK/yA/P/cjkrcivvDnzURbsZedLUNA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dx5h8hnsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 00:32:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 4 May 2026 00:32:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 4 May 2026 00:32:23 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id DC4373F7054;
	Mon,  4 May 2026 00:32:19 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net-next PATCH v5 4/4] octeontx2-pf: cn20k: Use unified Halo context
Date: Mon, 4 May 2026 13:02:01 +0530
Message-ID: <1777879921-15542-5-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1777879921-15542-1-git-send-email-sbhatta@marvell.com>
References: <1777879921-15542-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=69f84b90 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=CaZ6pBYYoU2kl75vHkwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: iYhZtjVef1Z3O0MW4qnmeoTZrL_ULRWJ
X-Proofpoint-GUID: iYhZtjVef1Z3O0MW4qnmeoTZrL_ULRWJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4MCBTYWx0ZWRfX47hCkyX0cljJ
 Ety0EegXbaBWLLx8f7pdM+T+C9moEOawjlEB4/HPikTtWRBN6o8HCGcHH9gFTP0c1qq7ZkNm1dC
 Lh64PjQskpVm7lr7X0ldf94Dul45HbMaEbs0a96RTO4X5SoU8coIkfs2I3Zpnqmnj4tSZkzEY/Y
 UYnYXyj9itguaOKwrq8fnkT8e4asoB8x52KpBKzrFpvpuPmOzBpnNXJZqzJQ3bGuwpGkpBLY7/c
 Mp3BXjowwOk2bCfn2lK3TEPM16IArYeFfX0Z9yFhFJuC6KICDN8zdwYuvAQLJIBjHLcXMnDq1ey
 R5OYGerzC3Ukh6/KJXb0HTvwOfmJZThqUB8GBzD+vj4ahqvvA4XdR39zWcFVbnm8Pm3xDY4mLCA
 ptoofjRkhuAX+3bgKUa2WmGTaSHxqk0yg5NMHXWps+RZRzv2n7kGnJyMGid6r0cxfXoJSO3xyLO
 s4VH5kzvg56Q5616zxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Rspamd-Queue-Id: 2E1AD4B965C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283718-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

Use unified Halo context present in CN20K hardware for
octeontx2 netdevs instead of aura and pool contexts.
Note that with this halo context in place RQ backpressure
is not being configured and the same will be supported
later.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 215 +++++++++---------
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   3 +
 .../marvell/octeontx2/nic/otx2_common.h       |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   8 +
 4 files changed, 126 insertions(+), 103 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index a5a8f4558717..00e3b682dd60 100644
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
@@ -517,84 +508,7 @@ int cn20k_tc_alloc_entry(struct otx2_nic *nic,
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
@@ -610,36 +524,57 @@ static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
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
+	if (pfvf->npa_dpc_valid) {
+		aq->halo.op_dpc_ena = 1;
+		aq->halo.op_dpc_set = pfvf->npa_dpc;
+	}
+	aq->halo.unified_ctx = 1;
 
 	/* Fill AQ info */
-	aq->ctype = NPA_AQ_CTYPE_POOL;
+	aq->ctype = NPA_AQ_CTYPE_HALO;
 	aq->op = NPA_AQ_INSTOP_INIT;
 
 	if (type != AURA_NIX_RQ) {
@@ -661,6 +596,80 @@ static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
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
+	if (IS_ERR(rsp))
+		return PTR_ERR(rsp);
+
+	nic->npa_dpc = rsp->cntr_id;
+	nic->npa_dpc_valid = true;
+
+	return 0;
+}
+
+int cn20k_npa_free_dpc(struct otx2_nic *nic)
+{
+	struct npa_cn20k_dpc_free_req *req;
+	int err;
+
+	if (!nic->npa_dpc_valid)
+		return 0;
+
+	mutex_lock(&nic->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_npa_cn20k_dpc_free(&nic->mbox);
+	if (!req) {
+		mutex_unlock(&nic->mbox.lock);
+		return -ENOMEM;
+	}
+
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


