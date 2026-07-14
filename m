Return-Path: <netdev+bounces-307311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oadMK8iWVWoWqgAAu9opvQ
	(envelope-from <netdev+bounces-307311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:54:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DB2750314
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:54:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=kS45+BUC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307311-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307311-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 963EF3007221
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E1F37107E;
	Tue, 14 Jul 2026 01:54:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D54C371046;
	Tue, 14 Jul 2026 01:54:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994050; cv=none; b=cqZXvLO0Pr5Az3qW6VWonXlCzYIByPpwgHsznaAeYTeSnScelybQDmCSG33agGgjzHA/JMSvuSaH2L4AOzrGuqxdQ9Vjj0H+DImsVyXKaeqcaCKRgqHLaS3Z18Qy6/vAbE9rRhhbPD01xRYN+ORk27CbNC/esmuesXWbUVYUl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994050; c=relaxed/simple;
	bh=Kf9eG/Vn9i87gM7zjGpAd7I+Iru4T8/9pKGL+uNQZq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5ZYqwNwHn9k9G/8g8587OypP8+4hJcZWredlPOqdUnTjBPcH1YQi5wmcuWEQLOFcvpEJEGCyAcTlVvwVwxKJeZknqIoMAmzvijJHEqgNEccFHmj3Y4KBYiaDC0Gk4gznXSy2QHl6LfX8CGfn4zBCqB1USey0diqLN9L2PdfO+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kS45+BUC; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNrBnG2954880;
	Mon, 13 Jul 2026 18:54:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
	t0CDkGxMdxqnBgq+D7tpV+hLSeoCjVcfEG3sn/Sggk=; b=kS45+BUCam9gNcAmC
	H6QaoNkc92hHXMEeMiMRcKlTZ4PsaGml97tSvfDs0gk7aYT8f23NVaSPZ5LNgNM4
	Yz1geemkYp/ynF312s1yclyErLdVp8UMFUTQ27SB5nfBs4alBcSGXIpxJ7Mp+qWs
	igVmnrA+3O+HdqG8VVZD6UkB/PuR6QKubrGgMlN+t9lRDL9nLw2zUyflpyoJJuRw
	PpDVDFmY/bOLd+g1fzDRKs7Wkb9qx0fTcOXVpoWHjTCZoxzv6rFaYpEYp/nzxubf
	7TOs0sq6t5RikwuXGkvDvTkPb6IhIGv4oqlg/+e4580i+BvbKl9bu/5r7ihpDKV3
	3/BFQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fbnbex55b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:54:00 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Jul 2026 18:53:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Jul 2026 18:53:59 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B7BF15E6866;
	Mon, 13 Jul 2026 18:53:56 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net-next 5/9] octeontx2-af: switch: TL1 scheduling and NPC channel control
Date: Tue, 14 Jul 2026 07:23:27 +0530
Message-ID: <20260714015331.1801922-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714015331.1801922-1-rkannoth@marvell.com>
References: <20260714015331.1801922-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jLMCS1WdeBiPQvbBUC0bJxxuHxtkUwcu
X-Authority-Analysis: v=2.4 cv=WOdPmHsR c=1 sm=1 tr=0 ts=6a5596b8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=5G8DWUFWGqKwcvO_TfUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: jLMCS1WdeBiPQvbBUC0bJxxuHxtkUwcu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxNiBTYWx0ZWRfX5cz7t77Xvo83
 f9NQr4jGFo29a9XTWV9nj0dW4PkMw28LSSUII9E7w0mTbxib+4Of/kthY1zcVBPYMZ5MJvruf8C
 t8WF36tGw6zoj5rulHDuFhawJ861vmU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxNiBTYWx0ZWRfX2s2pMDkrCUzN
 omRLkwxaM7zX8m8VPykTONYfnaWLGmUvybJxRUmV9u5AlKIIpVTicom2k8FSM9c6+tz++77+xS4
 CXY1jezJXFdLpHGkKs+kIiuzePWdJRrj7gWAXGq3vEWf3u0aMwercJlqehFXOUiIiS58XgoS43u
 eO8MMWH9Y6BBxEjCcz1YT6U0JyFHK+P4g5q/evAYmlPKC+irarEfhKMTfScEpCyaamepRVtnSL4
 ITk2PwHZiOdnQBnsrppiPh8J1zVorKJiIymY1NiDrizQvuyx3N0cRLe2p9crUVIWrzmNMlbYbvB
 mTe53KVQwHSnC/QPVp//FIrzBfCLHExZU25FHsYpU5x7wlui3Db8L/7z9uLwtwYYlemZ3tPQ8t5
 1YsHev65HVenzdrCRgROAnwWkZI41ssngXq2HaA8Z5xuEAMFCpmXnxVc0bqjbRa4WUX4F/AZ6z/
 q0RQSqWPND3q4GKreHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307311-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:from_mime,marvell.com:mid,marvell.com:email,marvell.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2DB2750314

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
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  15 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  16 ++-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 133 +++++++++++++++---
 .../marvell/octeontx2/af/rvu_npc_fs.c         |   7 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   2 +
 6 files changed, 155 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index cdfb5a8bafb9..bf8edab569b1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1158,6 +1158,13 @@ struct nix_txsch_alloc_req {
 	/* Scheduler queue count request at each level */
 	u16 schq_contig[NIX_TXSCH_LVL_CNT]; /* No of contiguous queues */
 	u16 schq[NIX_TXSCH_LVL_CNT]; /* No of non-contiguous queues */
+	/* Set only by the single switchdev PF (rvu->rswitch.pcifunc). This is
+	 * not the eswitch representor (rvu->rep_pcifunc). That PF requests two
+	 * aggregate-level TL2 queues on the PAN link, one for CGX and one for
+	 * SDP steering. No other PF or VF sets this flag.
+	 */
+#define NIX_TXSCH_ALLOC_FLAG_PAN BIT_ULL(0)
+	u64 flags;
 };
 
 struct nix_txsch_alloc_rsp {
@@ -1176,6 +1183,10 @@ struct nix_txsch_alloc_rsp {
 struct nix_txsch_free_req {
 	struct mbox_msghdr hdr;
 #define TXSCHQ_FREE_ALL BIT_ULL(0)
+	/* Frees PAN TL2 queues allocated with NIX_TXSCH_ALLOC_FLAG_PAN. Used
+	 * only by the switchdev PF (rvu->rswitch.pcifunc), not by other PFs/VFs.
+	 */
+#define TXSCHQ_FREE_PAN_TL1 BIT_ULL(1)
 	u16 flags;
 	/* Scheduler queue level to be freed */
 	u16 schq_lvl;
@@ -2115,6 +2126,10 @@ struct npc_install_flow_req {
 	u8 hw_prio;
 	u8  req_kw_type; /* Key type to be written */
 	u8 alloc_entry;	/* only for cn20k */
+	/* When set, rvu_mbox_handler_npc_install_flow() keeps caller chan_mask
+	 * for switchdev-installed flows instead of the default CPT override.
+	 */
+	u8 set_chanmask;
 /* For now use any priority, once AF driver is changed to
  * allocate least priority entry instead of mid zone then make
  * NPC_MCAM_LEAST_PRIO as 3
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index df4f1c05a2a0..532c2b69fb85 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2054,8 +2054,12 @@ int rvu_mbox_handler_iface_get_info(struct rvu *rvu, struct msg_req *req,
 		info->rq_cnt = 0;
 
 		mutex_lock(&rvu->rsrc_lock);
-		if (pfvf->sq_bmap)
-			info->sq_cnt = bitmap_weight(pfvf->sq_bmap, BITS_PER_LONG * 16);
+		if (pfvf->sq_bmap) {
+			int sq_bmap_bits = rvu_is_switch_pcifunc(rvu, pcifunc) ?
+					   NIX_SQ_BMAP_BITS : pfvf->sq_ctx->qsize;
+
+			info->sq_cnt = bitmap_weight(pfvf->sq_bmap, sq_bmap_bits);
+		}
 
 		if (pfvf->cq_bmap)
 			info->cq_cnt = bitmap_weight(pfvf->cq_bmap, BITS_PER_LONG);
@@ -2101,8 +2105,12 @@ int rvu_mbox_handler_iface_get_info(struct rvu *rvu, struct msg_req *req,
 			info->rq_cnt = 0;
 
 			mutex_lock(&rvu->rsrc_lock);
-			if (pfvf->sq_bmap)
-				info->sq_cnt = bitmap_weight(pfvf->sq_bmap, BITS_PER_LONG * 16);
+			if (pfvf->sq_bmap) {
+				int sq_bmap_bits = rvu_is_switch_pcifunc(rvu, pcifunc) ?
+						   NIX_SQ_BMAP_BITS : pfvf->sq_ctx->qsize;
+
+				info->sq_cnt = bitmap_weight(pfvf->sq_bmap, sq_bmap_bits);
+			}
 
 			if (pfvf->cq_bmap)
 				info->cq_cnt = bitmap_weight(pfvf->cq_bmap, BITS_PER_LONG);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 8cf1ad9ec749..0662cc6134b0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -335,6 +335,7 @@ struct nix_txsch {
 	u8   lvl;
 #define NIX_TXSCHQ_FREE		      BIT_ULL(1)
 #define NIX_TXSCHQ_CFG_DONE	      BIT_ULL(0)
+#define NIX_SQ_BMAP_BITS	      (BITS_PER_LONG * 16)
 #define TXSCH_MAP_FUNC(__pfvf_map)    ((__pfvf_map) & 0xFFFF)
 #define TXSCH_MAP_FLAGS(__pfvf_map)   ((__pfvf_map) >> 16)
 #define TXSCH_MAP(__func, __flags)    (((__func) & 0xFFFF) | ((__flags) << 16))
@@ -904,6 +905,11 @@ static inline bool is_pffunc_af(u16 pcifunc)
 	return !pcifunc;
 }
 
+static inline bool rvu_is_switch_pcifunc(struct rvu *rvu, u16 pcifunc)
+{
+	return rvu->rswitch.pcifunc && pcifunc == rvu->rswitch.pcifunc;
+}
+
 static inline bool is_rvu_fwdata_valid(struct rvu *rvu)
 {
 	return (rvu->fwdata->header_magic == RVU_FWDATA_HEADER_MAGIC) &&
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 67c9621dbc1d..1a0ba148478e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1600,7 +1600,11 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	if (rc)
 		goto free_mem;
 
-	pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
+	if (rvu_is_switch_pcifunc(rvu, pcifunc))
+		pfvf->sq_bmap = kcalloc(BITS_TO_LONGS(NIX_SQ_BMAP_BITS),
+					sizeof(long), GFP_KERNEL);
+	else
+		pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
 	if (!pfvf->sq_bmap) {
 		rc = -ENOMEM;
 		goto free_mem;
@@ -2127,6 +2131,25 @@ static void nix_get_txschq_range(struct rvu *rvu, u16 pcifunc,
 	}
 }
 
+static int nix_get_pan_tx_link(struct rvu *rvu)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+
+	return hw->cgx_links + hw->lbk_links + 1;
+}
+
+static bool nix_txsch_is_pan_schq(struct rvu *rvu, int schq)
+{
+	int pan_link = nix_get_pan_tx_link(rvu);
+
+	return schq >= pan_link && schq <= pan_link + 1;
+}
+
+static bool nix_txsch_pan_allowed(struct rvu *rvu, u16 pcifunc)
+{
+	return rvu_is_switch_pcifunc(rvu, pcifunc);
+}
+
 static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
 				      struct nix_hw *nix_hw,
 				      struct nix_txsch_alloc_req *req)
@@ -2142,12 +2165,27 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
 	if (!req_schq)
 		return 0;
 
-	link = nix_get_tx_link(rvu, pcifunc);
+	if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN) {
+		if (!nix_txsch_pan_allowed(rvu, pcifunc))
+			return NIX_AF_ERR_TLX_ALLOC_FAIL;
+		link = nix_get_pan_tx_link(rvu);
+	} else {
+		link = nix_get_tx_link(rvu, pcifunc);
+	}
 
 	/* For traffic aggregating scheduler level, one queue is enough */
 	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
-		if (req_schq != 1)
+		if (req_schq != 1 && !(req->flags & NIX_TXSCH_ALLOC_FLAG_PAN))
+			return NIX_AF_ERR_TLX_ALLOC_FAIL;
+		if (req->schq[lvl] > MAX_TXSCHQ_PER_FUNC ||
+		    req->schq_contig[lvl] > MAX_TXSCHQ_PER_FUNC)
 			return NIX_AF_ERR_TLX_ALLOC_FAIL;
+		if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN) {
+			if (link >= txsch->schq.max || link + 1 >= txsch->schq.max)
+				return NIX_AF_ERR_TLX_ALLOC_FAIL;
+			if (req_schq > 2)
+				return NIX_AF_ERR_TLX_ALLOC_FAIL;
+		}
 		return 0;
 	}
 
@@ -2176,9 +2214,9 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
 	return 0;
 }
 
-static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
-			    struct nix_txsch_alloc_rsp *rsp,
-			    int lvl, int start, int end)
+static int nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
+			   struct nix_txsch_alloc_rsp *rsp,
+			   int lvl, int start, int end)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = rsp->hdr.pcifunc;
@@ -2188,6 +2226,46 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 	 * on transmit link to which PF_FUNC is mapped to.
 	 */
 	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
+		if (start != end) {
+			int want_contig = rsp->schq_contig[lvl];
+			int got_contig = 0, got = 0;
+			int want = rsp->schq[lvl];
+
+			for (schq = start; schq <= end; schq++) {
+				if (test_bit(schq, txsch->schq.bmap))
+					continue;
+
+				if (got_contig < want_contig) {
+					set_bit(schq, txsch->schq.bmap);
+					rsp->schq_contig_list[lvl][got_contig++] = schq;
+					continue;
+				}
+
+				if (got < want) {
+					set_bit(schq, txsch->schq.bmap);
+					rsp->schq_list[lvl][got++] = schq;
+				}
+			}
+
+			rsp->schq_contig[lvl] = got_contig;
+			rsp->schq[lvl] = got;
+
+			if (got_contig < want_contig || got < want) {
+				for (idx = 0; idx < got_contig; idx++)
+					clear_bit(rsp->schq_contig_list[lvl][idx],
+						  txsch->schq.bmap);
+				for (idx = 0; idx < got; idx++)
+					clear_bit(rsp->schq_list[lvl][idx],
+						  txsch->schq.bmap);
+				rsp->schq_contig[lvl] = 0;
+				rsp->schq[lvl] = 0;
+				dev_err(rvu->dev,
+					"Could not allocate schq at lvl=%u start=%u end=%u\n",
+					lvl, start, end);
+				return -ENOMEM;
+			}
+			return 0;
+		}
 		/* A single TL queue is allocated */
 		if (rsp->schq_contig[lvl]) {
 			rsp->schq_contig[lvl] = 1;
@@ -2202,7 +2280,7 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 			rsp->schq[lvl] = 1;
 			rsp->schq_list[lvl][0] = start;
 		}
-		return;
+		return 0;
 	}
 
 	/* Adjust the queue request count if HW supports
@@ -2214,7 +2292,7 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 		if (idx >= (end - start) || test_bit(schq, txsch->schq.bmap)) {
 			rsp->schq_contig[lvl] = 0;
 			rsp->schq[lvl] = 0;
-			return;
+			return 0;
 		}
 
 		if (rsp->schq_contig[lvl]) {
@@ -2227,7 +2305,7 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 			set_bit(schq, txsch->schq.bmap);
 			rsp->schq_list[lvl][0] = schq;
 		}
-		return;
+		return 0;
 	}
 
 	/* Allocate contiguous queue indices requesty first */
@@ -2258,6 +2336,8 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 		/* Update how many were allocated */
 		rsp->schq[lvl] = idx;
 	}
+
+	return 0;
 }
 
 int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
@@ -2282,6 +2362,10 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 	if (!nix_hw)
 		return NIX_AF_ERR_INVALID_NIXBLK;
 
+	if ((req->flags & NIX_TXSCH_ALLOC_FLAG_PAN) &&
+	    !nix_txsch_pan_allowed(rvu, pcifunc))
+		return NIX_AF_ERR_TLX_ALLOC_FAIL;
+
 	mutex_lock(&rvu->rsrc_lock);
 
 	/* Check if request is valid as per HW capabilities
@@ -2304,11 +2388,14 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 		rsp->schq[lvl] = req->schq[lvl];
 		rsp->schq_contig[lvl] = req->schq_contig[lvl];
 
-		link = nix_get_tx_link(rvu, pcifunc);
+		if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN)
+			link = nix_get_pan_tx_link(rvu);
+		else
+			link = nix_get_tx_link(rvu, pcifunc);
 
 		if (lvl >= hw->cap.nix_tx_aggr_lvl) {
 			start = link;
-			end = link;
+			end = link + !!(req->flags & NIX_TXSCH_ALLOC_FLAG_PAN);
 		} else if (hw->cap.nix_fixed_txschq_mapping) {
 			nix_get_txschq_range(rvu, pcifunc, link, &start, &end);
 		} else {
@@ -2316,10 +2403,11 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 			end = txsch->schq.max;
 		}
 
-		nix_txsch_alloc(rvu, txsch, rsp, lvl, start, end);
+		if (nix_txsch_alloc(rvu, txsch, rsp, lvl, start, end))
+			goto err;
 
 		/* Reset queue config */
-		for (idx = 0; idx < req->schq_contig[lvl]; idx++) {
+		for (idx = 0; idx < rsp->schq_contig[lvl]; idx++) {
 			schq = rsp->schq_contig_list[lvl][idx];
 			if (!(TXSCH_MAP_FLAGS(pfvf_map[schq]) &
 			    NIX_TXSCHQ_CFG_DONE))
@@ -2329,7 +2417,7 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 			nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
 		}
 
-		for (idx = 0; idx < req->schq[lvl]; idx++) {
+		for (idx = 0; idx < rsp->schq[lvl]; idx++) {
 			schq = rsp->schq_list[lvl][idx];
 			if (!(TXSCH_MAP_FLAGS(pfvf_map[schq]) &
 			    NIX_TXSCHQ_CFG_DONE))
@@ -2625,11 +2713,11 @@ static int nix_txschq_free(struct rvu *rvu, u16 pcifunc)
 		 /* TLs above aggregation level are shared across all PF
 		  * and it's VFs, hence skip freeing them.
 		  */
-		if (lvl >= hw->cap.nix_tx_aggr_lvl)
-			continue;
-
 		txsch = &nix_hw->txsch[lvl];
 		for (schq = 0; schq < txsch->schq.max; schq++) {
+			if (lvl >= hw->cap.nix_tx_aggr_lvl &&
+			    !nix_txsch_is_pan_schq(rvu, schq))
+				continue;
 			if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) != pcifunc)
 				continue;
 			nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
@@ -2673,7 +2761,16 @@ static int nix_txschq_free_one(struct rvu *rvu,
 	schq = req->schq;
 	txsch = &nix_hw->txsch[lvl];
 
-	if (lvl >= hw->cap.nix_tx_aggr_lvl || schq >= txsch->schq.max)
+	if (req->flags & TXSCHQ_FREE_PAN_TL1) {
+		if (!nix_txsch_pan_allowed(rvu, pcifunc))
+			return NIX_AF_ERR_TLX_INVALID;
+		if (!nix_txsch_is_pan_schq(rvu, schq))
+			return NIX_AF_ERR_TLX_INVALID;
+	} else if (lvl >= hw->cap.nix_tx_aggr_lvl) {
+		return 0;
+	}
+
+	if (schq >= txsch->schq.max)
 		return 0;
 
 	pfvf_map = txsch->pfvf_map;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 09c7ee8571df..03bc3e321522 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1828,8 +1828,11 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 		target = req->hdr.pcifunc;
 	}
 
-	/* ignore chan_mask in case pf func is not AF, revisit later */
-	if (!is_pffunc_af(req->hdr.pcifunc))
+	/* Non-AF requesters normally get the CPT default chan_mask. set_chanmask
+	 * preserves caller-supplied chan_mask for switchdev-installed flows; see
+	 * npc_install_flow_req.set_chanmask.
+	 */
+	if (!is_pffunc_af(req->hdr.pcifunc) && !req->set_chanmask)
 		req->chan_mask = rvu_get_cpt_chan_mask(rvu);
 
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


