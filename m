Return-Path: <netdev+bounces-247746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE189CFDF93
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47469307FAA1
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13DE3385AB;
	Wed,  7 Jan 2026 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KFL9++Sa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828D337BAA;
	Wed,  7 Jan 2026 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792283; cv=none; b=tyWbFWSZ1elVo4nmVjHXI8wrSjKPGyj1JEEnNdVwqEZjbGZ99ESmRcSzmjR0y7vKG0/BRjSG+s7UeFQBFabmHmofDgHdDPXztDKP1potpxIe+C2ndV/Tli9Hq4p1Mnw8dRcI4IBwp+j4QCs+g9ImIyuwN3JME+LGftA/Crf0bGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792283; c=relaxed/simple;
	bh=MeOsaiOgaJ7llG6zhyBycOt5bALIZxtpbATHjBGU8aA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjhg9NVJ/G8ST3yaW16iunHenYEyiKCdXv8O1opHPUmcjjb30CJVniYK1Zw0dvizRF65pzmh5MpBz/FjJYHSUTQJjgryC6BJDQmjPj+MvoUut+xRKt10pWLeYDtvSMOdctLQ7yvXZfHsaOMFLlX/9u1TnMY22aOTU9XiWjYAYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KFL9++Sa; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606NUVSn778006;
	Wed, 7 Jan 2026 05:24:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
	L1KxUgzGDP8y4RXjiXMM8xOtX1TIqHpiot3Mpa55Gk=; b=KFL9++SaQ+JjnYmzy
	M92gV/6gYdttWlFBGsNyfi07zFHlCiBYsMg6xVOhYTPRlm+2duxIX5umFhx46m8S
	u5ieRTWYBsyrHZzmVDMKxDQKjqUQWl5l/Adt/hs5vhG62g6ArmjL3C0NyTxSa2E7
	UyMcXz+ctLB8FjNQltBcOMQmQ2+XObf/U+NAJF5F5ZB+WrmtKJ+oJA9jtJ62hCW6
	TU1HJuLAn88ViggnuCbP+X6MSQZxpls4+U968fMtYF7BSwYjyzCYUMy2rTkgIJto
	A8yBjRaQ5nQR8pILTmeli4ealuOxqO3YaH5D3asaeUk0ieovTHvNLwnkOVkG6gAm
	vupaw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhc3n1bte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:24:32 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:24:47 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:24:47 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 91DCD3F704A;
	Wed,  7 Jan 2026 05:24:29 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next v2 05/10] octeontx2-af: switch: Enable Switch hw port for all channels
Date: Wed, 7 Jan 2026 18:54:03 +0530
Message-ID: <20260107132408.3904352-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107132408.3904352-1-rkannoth@marvell.com>
References: <20260107132408.3904352-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Jbw7cBq48uXSRN-jS8OpnWXo3dBdbXso
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfX+OOU9b+UKkLU
 kW33su29JCtPC7Gna9rOQUOFQVaDjo2y0cEvGC1Qrn5Xe3YKJnIdWkRrjXQ9Mfq68LViL30lY0J
 6kbeQaNTEJkBabyMNPiQ3KkauQ2KyXLcKG4bCyVKsjGBvnvkLftwGBawxU+MusxLqQHy9QJU+3i
 g4uosYiPKcrNSaASSP+ZOIw5Bt5RjkDK0+UXGHnVrJYNYIqbsR0MKk5s6frk/NWG5FQsXxa6VHj
 xiuwEIz8z6jetJL9ZGmvHKjIzRgg0Rl/fb+n1+mEwMN1Ktb0TRwTV4Y4dq6utyBtncQdvn2/7DU
 AtZftdWMPy9WCCuqNsG5VdX6+Hvvmw49lf2APEBTOjftX35LAMlE64yu1JjIrSHjGJQQJ8AZOY5
 JVhnaIv6WFY+bSJ0dQvoyljHJAjTZVELtw1cT+VF4tJRHEUaGm+zM0XVuTPHD/Gfg4gxroOz2V9
 TN8yEEDzZOuYoYLQrWA==
X-Authority-Analysis: v=2.4 cv=EOILElZC c=1 sm=1 tr=0 ts=695e5e90 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=0Cqobd3ug1408HmlttkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Jbw7cBq48uXSRN-jS8OpnWXo3dBdbXso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01

Switch HW should be able to fwd packets to any link based
on flow rules. Set txlink enable for all channels.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  4 ++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 50 ++++++++++++++++---
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  2 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |  2 +
 4 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 24703c27a352..00bacbc22052 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1122,6 +1122,8 @@ struct nix_txsch_alloc_req {
 	/* Scheduler queue count request at each level */
 	u16 schq_contig[NIX_TXSCH_LVL_CNT]; /* No of contiguous queues */
 	u16 schq[NIX_TXSCH_LVL_CNT]; /* No of non-contiguous queues */
+#define NIX_TXSCH_ALLOC_FLAG_PAN BIT_ULL(0)
+	u64 flags;
 };
 
 struct nix_txsch_alloc_rsp {
@@ -1140,6 +1142,7 @@ struct nix_txsch_alloc_rsp {
 struct nix_txsch_free_req {
 	struct mbox_msghdr hdr;
 #define TXSCHQ_FREE_ALL BIT_ULL(0)
+#define TXSCHQ_FREE_PAN_TL1 BIT_ULL(1)
 	u16 flags;
 	/* Scheduler queue level to be freed */
 	u16 schq_lvl;
@@ -1958,6 +1961,7 @@ struct npc_install_flow_req {
 	u16 entry;
 	u16 channel;
 	u16 chan_mask;
+	u8 set_chanmask;
 	u8 intf;
 	u8 set_cntr; /* If counter is available set counter for this entry ? */
 	u8 default_rule;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index e2cc33ad2b2c..9d9d59affd68 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1586,7 +1586,7 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	if (err)
 		goto free_mem;
 
-	pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
+	pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long) * 16, GFP_KERNEL);
 	if (!pfvf->sq_bmap)
 		goto free_mem;
 
@@ -2106,11 +2106,14 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
 	if (!req_schq)
 		return 0;
 
-	link = nix_get_tx_link(rvu, pcifunc);
+	if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN)
+		link = hw->cgx_links + hw->lbk_links + 1;
+	else
+		link = nix_get_tx_link(rvu, pcifunc);
 
 	/* For traffic aggregating scheduler level, one queue is enough */
 	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
-		if (req_schq != 1)
+		if (req_schq != 1 && !(req->flags & NIX_TXSCH_ALLOC_FLAG_PAN))
 			return NIX_AF_ERR_TLX_ALLOC_FAIL;
 		return 0;
 	}
@@ -2147,11 +2150,41 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = rsp->hdr.pcifunc;
 	int idx, schq;
+	bool alloc;
 
 	/* For traffic aggregating levels, queue alloc is based
 	 * on transmit link to which PF_FUNC is mapped to.
 	 */
 	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
+		if (start != end) {
+			idx = 0;
+			alloc = false;
+			for (schq = start; schq <= end; schq++, idx++) {
+				if (test_bit(schq, txsch->schq.bmap))
+					continue;
+
+				set_bit(schq, txsch->schq.bmap);
+
+				/* A single TL queue is allocated each time */
+				if (rsp->schq_contig[lvl]) {
+					alloc = true;
+					rsp->schq_contig_list[lvl][idx] = schq;
+					continue;
+				}
+
+				if (rsp->schq[lvl]) {
+					alloc = true;
+					rsp->schq_list[lvl][idx] = schq;
+					continue;
+				}
+			}
+
+			if (!alloc)
+				dev_err(rvu->dev,
+					"Could not allocate schq at lvl=%u start=%u end=%u\n",
+					lvl, start, end);
+			return;
+		}
 		/* A single TL queue is allocated */
 		if (rsp->schq_contig[lvl]) {
 			rsp->schq_contig[lvl] = 1;
@@ -2268,11 +2301,14 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 		rsp->schq[lvl] = req->schq[lvl];
 		rsp->schq_contig[lvl] = req->schq_contig[lvl];
 
-		link = nix_get_tx_link(rvu, pcifunc);
+		if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN)
+			link = hw->cgx_links + hw->lbk_links + 1;
+		else
+			link = nix_get_tx_link(rvu, pcifunc);
 
 		if (lvl >= hw->cap.nix_tx_aggr_lvl) {
 			start = link;
-			end = link;
+			end = link + !!(req->flags & NIX_TXSCH_ALLOC_FLAG_PAN);
 		} else if (hw->cap.nix_fixed_txschq_mapping) {
 			nix_get_txschq_range(rvu, pcifunc, link, &start, &end);
 		} else {
@@ -2637,7 +2673,9 @@ static int nix_txschq_free_one(struct rvu *rvu,
 	schq = req->schq;
 	txsch = &nix_hw->txsch[lvl];
 
-	if (lvl >= hw->cap.nix_tx_aggr_lvl || schq >= txsch->schq.max)
+	if ((lvl >= hw->cap.nix_tx_aggr_lvl &&
+	     !(req->flags & TXSCHQ_FREE_PAN_TL1)) ||
+	    schq >= txsch->schq.max)
 		return 0;
 
 	pfvf_map = txsch->pfvf_map;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 3d6f780635a5..925b0b02279e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1469,7 +1469,7 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	}
 
 	/* ignore chan_mask in case pf func is not AF, revisit later */
-	if (!is_pffunc_af(req->hdr.pcifunc))
+	if (!req->set_chanmask && !is_pffunc_af(req->hdr.pcifunc))
 		req->chan_mask = 0xFFF;
 
 	err = npc_check_unsupported_flows(rvu, req->features, req->intf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index acf259d72008..73a98b94426b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -78,6 +78,8 @@ struct otx2_rcv_queue {
 struct sg_list {
 	u16	num_segs;
 	u16	flags;
+	u16	cq_idx;
+	u16	len;
 	u64	skb;
 	u64	size[OTX2_MAX_FRAGS_IN_SQE];
 	u64	dma_addr[OTX2_MAX_FRAGS_IN_SQE];
-- 
2.43.0


