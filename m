Return-Path: <netdev+bounces-303974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OKhfEl3uRWpEGwsAu9opvQ
	(envelope-from <netdev+bounces-303974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:51:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B4B6F375B
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:51:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="e+XL/oRQ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303974-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303974-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED877301B82B
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 04:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A069836A369;
	Thu,  2 Jul 2026 04:50:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0636A358;
	Thu,  2 Jul 2026 04:50:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782967855; cv=none; b=HiSai5ae2HVbDbVkCrYVOtxS4q8quSwROxPEghivF3EC00+VuirCG3P/10kUS8ajdLy6dn4kPnp8cE4XJC87EBsRrMMaJTj9z/Hn9a9AN6gw1Rz0KUpiNmuotAt8lfT0sq4qrxwNynxx4RvRqknU3g6l9ZOwOJkZbs6dxfKzZTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782967855; c=relaxed/simple;
	bh=fN0s0XQCO74mThrUuBWN28h1zmTpRMubhbue3hYuO00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns5DdEUlxPwyOih8mgpXj05aM5X8ML8QL5H4AkLMV2iq4mgHqQdiNEnymRVr3FJodKoQwIceXdooAFR3lLHq50C20yrpx8oJQ4nwqN3xBimebV1oUiLkPY7X6c12XczwUXwnxrOFDudfKoMkBYwncL5Y9yDKIlPAu0QftUE1cZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=e+XL/oRQ; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621MMJI214231;
	Wed, 1 Jul 2026 21:50:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=7
	t4BVJiv+l3mnrm5P5JwvYw++ixbao+gtOeSviDSXvc=; b=e+XL/oRQmRwNgAROV
	XTOoVzs4vbh8aumQkyUhAEhpBvle8ZRNrZkFb+KkuNz0ttnTO7L0h/DYKXDnCmtw
	U3xc5n95FsAwOWM2rhsGYI3z6QGtlluWz9JUbRGJnXvKATBneq8n6ri32ljtsxwv
	zTVtPwZCQBgiIODaeu7l7MGyzi6eagtPzKhSEol429Mi7hKBjKCoPJc5sp7Y3pag
	9NEtvbL0++Ef/CepSUXjb+ARjPFOdauS5HqIqMUBso3IWqqC7/8YnNJ+fcZ/L5PR
	dvt57PbG91X0K8R7g4I4b/M8i8BGZcu37TBQmIL7RYHpDYK6Sah/tjporuPAi5Xo
	yZozg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f52krbdsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 21:50:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 21:50:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 21:50:45 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 374333F708F;
	Wed,  1 Jul 2026 21:50:43 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v2 net-next 5/9] octeontx2-af: PAN switch TL1 scheduling and NPC channel control
Date: Thu, 2 Jul 2026 10:20:22 +0530
Message-ID: <20260702045026.2914748-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702045026.2914748-1-rkannoth@marvell.com>
References: <20260702045026.2914748-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA0NSBTYWx0ZWRfX0EcO3BZDT1Zy
 8TvfF8Se+ui1vcbNRK4XZmewFEkG+iSht2q3uJFmEDZUQvwpprn6KfLz1CJhhG6kP+umNJMoFGs
 PUQzwgG5G9X3UEAKSZcxQrLV2nOX1Qw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA0NSBTYWx0ZWRfX/oQ1V3Em0P84
 haYsu/4g973tqEXKnlMei/BwR7jIX/9b6vsn2dfq+uiymLd+2+VlN63Qh8ORJNQ+2QPTJLDJyXi
 jkOz94L0hacN1ukW2gJWkTpqFGPDQBGK/EzhxUeBPNC/seUSWc3rUGQ10uGCkhBA5eD+C1VBmyp
 TGqN/o3cWrLJLpoUwOGHOPvqidmB0f8OFVQWHN1b5Itvva9vOB7z1gUOuvKqKlAbMBJK/PrXKXa
 7+U453VlVrbJ+69LY3kpW96GoQav70mq1g+QMfOsInppsQVTqW3HMllYHcVIUEE1fk3Fd9dRq7i
 arXhGv433wiHL4TU1Ci2EFyfg0q+mnAJPO7pMCp6W4gNWU7I8oXI6drfmlqauSSxkcweVEB+Rxx
 nMF1Bzhph/FGlPecsoY6E4RNxH2i+B/onuukqKtWvkA8nuV5KidE3gKB/PIFW9rhrOXKKnUwNgQ
 TF1P1UHsbbaHjWVC4DQ==
X-Proofpoint-GUID: Qeg8hfRgeS6mn1wFUzzJXy4nK1bEcXwi
X-Authority-Analysis: v=2.4 cv=Ae6B2XXG c=1 sm=1 tr=0 ts=6a45ee26 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=8lBII9xb5TVS4YUU40oA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Qeg8hfRgeS6mn1wFUzzJXy4nK1bEcXwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303974-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0B4B6F375B

Switch (PAN) mode needs more than one TL1 scheduler queue index so the
hardware can steer traffic to different links according to NPC flow
rules, not only the PF/VF default Tx link.
Add NIX_TXSCH_ALLOC_FLAG_PAN to nix_txsch_alloc requests: use the PAN
link index for scheduler range calculation, allow multiple TL1 queues
when the aggregate level spans start..end, and allocate indices in
that range. Add TXSCHQ_FREE_PAN_TL1 so TL1 entries in that path can be
freed via nix_txsch_free where they were previously skipped.
For NPC install flow, add set_chanmask so callers can keep a non-default
chan_mask when the requester is not the AF; without it, chan_mask was
always forced to 0xFFF for non-AF functions.
Allocate the NIX LF SQ bitmap with the same span used by
bitmap_weight(..., BITS_PER_LONG * 16) in rvu_get_hwinfo().
Extend struct sg_list with cq_idx and len for transmit-side metadata.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  4 ++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 50 ++++++++++++++++---
 .../marvell/octeontx2/nic/otx2_txrx.h         |  2 +
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 7ac26629d9af..28ebf0a8d3d6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1157,6 +1157,8 @@ struct nix_txsch_alloc_req {
 	/* Scheduler queue count request at each level */
 	u16 schq_contig[NIX_TXSCH_LVL_CNT]; /* No of contiguous queues */
 	u16 schq[NIX_TXSCH_LVL_CNT]; /* No of non-contiguous queues */
+#define NIX_TXSCH_ALLOC_FLAG_PAN BIT_ULL(0)
+	u64 flags;
 };
 
 struct nix_txsch_alloc_rsp {
@@ -1175,6 +1177,7 @@ struct nix_txsch_alloc_rsp {
 struct nix_txsch_free_req {
 	struct mbox_msghdr hdr;
 #define TXSCHQ_FREE_ALL BIT_ULL(0)
+#define TXSCHQ_FREE_PAN_TL1 BIT_ULL(1)
 	u16 flags;
 	/* Scheduler queue level to be freed */
 	u16 schq_lvl;
@@ -2105,6 +2108,7 @@ struct npc_install_flow_req {
 	u8 hw_prio;
 	u8  req_kw_type; /* Key type to be written */
 	u8 alloc_entry;	/* only for cn20k */
+	u8 set_chanmask;
 /* For now use any priority, once AF driver is changed to
  * allocate least priority entry instead of mid zone then make
  * NPC_MCAM_LEAST_PRIO as 3
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index d2734f6d6d92..35c91cdc50b9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1596,7 +1596,7 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	if (rc)
 		goto free_mem;
 
-	pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
+	pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long) * 16, GFP_KERNEL);
 	if (!pfvf->sq_bmap) {
 		rc = -ENOMEM;
 		goto free_mem;
@@ -2138,11 +2138,14 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
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
@@ -2179,11 +2182,41 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
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
@@ -2300,11 +2333,14 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
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
@@ -2669,7 +2705,9 @@ static int nix_txschq_free_one(struct rvu *rvu,
 	schq = req->schq;
 	txsch = &nix_hw->txsch[lvl];
 
-	if (lvl >= hw->cap.nix_tx_aggr_lvl || schq >= txsch->schq.max)
+	if ((lvl >= hw->cap.nix_tx_aggr_lvl &&
+	     !(req->flags & TXSCHQ_FREE_PAN_TL1)) ||
+	    schq >= txsch->schq.max)
 		return 0;
 
 	pfvf_map = txsch->pfvf_map;
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


