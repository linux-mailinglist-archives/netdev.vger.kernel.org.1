Return-Path: <netdev+bounces-302902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ux9NH6IuQ2oSTwoAu9opvQ
	(envelope-from <netdev+bounces-302902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:49:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E916DFE03
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:49:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=E6A8DNdV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302902-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302902-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AA3B3023ADD
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5618E3D7D8E;
	Tue, 30 Jun 2026 02:47:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9E3CAE93;
	Tue, 30 Jun 2026 02:47:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787671; cv=none; b=p+8lTbDNQgW1mFGfD/juAe0lVfE6GFaMJEdaHlBlVLYtkXxXwBjGRNRZ76kBty/4seH7DQm3Zjhkco9KxRzgv45kkIkFDQDJSIK5/pyg5V+y54jxLApsroGPX6veiJqe2SecmUIWCbIHT+CqTcLC2pT3M2XPHCU3nb1/EAGQ8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787671; c=relaxed/simple;
	bh=++10Yg+5LaLxoEWWGEFkbaTJFGR52kVCSKsJ9ca5zRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drWtaQ402b/GQrMOXzd+o1aLtDIYI9fvZMqZNQhyPPY3kiRC04tfDNW7yvub4+DnEdn5OS7Y5JoCIT2qurTWcMnLqHl+dwnPvQ3nyPmy2NTv98RBgYADCEh0ybJ8JtnhcShmeqz3TE+jZsBNbZ3GRcsn0HPw7rLr1eAVdFjlovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=E6A8DNdV; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U1IFF73243929;
	Mon, 29 Jun 2026 19:47:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
	iXT3aeA7032RFxL74wluLconNX2lXGH4Gvr8JYaV8E=; b=E6A8DNdV/+q87jFo1
	2itj2aYP5CeXOj0dhc+SvxWExRE+rHM6f9UmbihqtyKFkY/A/mEgz/++yE9Pjfjh
	8BMA8Y9aGSyytc02EjIpft65t8ctDEGHMl7MiYrPwXlzXlYFgnGCJR+C0bL60w/y
	7KxINnt+mS7YL5eCc0alKpGvJzJTm6Jac9N8xaabETaqbihasczFVZKivBDHLBZR
	YE7z3H8B439QeTF7was7BIELlLggT0Vv4/juoEaLYHIGD+Ce+hAJ/s5GHeCwYDHY
	RGYDAqg3XayRkZXGdyDJRX0FyFb4UvQf+skyhEKPsISDWCTNmKdc+HwUWvfNwmM1
	545JA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f32s6djk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 19:47:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 19:47:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 19:47:41 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D978B3F7041;
	Mon, 29 Jun 2026 19:47:38 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next 5/9] octeontx2-af: PAN switch TL1 scheduling and NPC channel control
Date: Tue, 30 Jun 2026 08:17:11 +0530
Message-ID: <20260630024715.4124281-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630024715.4124281-1-rkannoth@marvell.com>
References: <20260630024715.4124281-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAyNCBTYWx0ZWRfX69yb5evldCx7
 n1mMC/hQN3YWmwkWALqFb+VwfM5HnxglnCUfqNrvBfKVlV+cisvkYJ9Y4FGBJpviuD15HCmgeKl
 xUFmIcekdvfKsbFlGzEHSJz+gfevtboTsE/CRMx05G1RkzLjB2HKt7gvKT+0EhL+ua8nv0tzBJr
 AKhCITGi0Q7TaDR1kQJn3GEX1ZcLRHHvbRc0vn01Tut4rKTHnIdk6f57ocDIhrjsJPce3T9hhRq
 L3niJJwonC6lZZO9XTEUFjfnYiv/YNoDLSOxnwkb5zqAGDVlDxyVKH4rDe/3Z3972f+hxyA8XLZ
 EHOvNfRmKsd28viUAdCUBN2c5vaqGPrAd0dghB+eHzoa4T9azbam4nufyMWrO0HJDvvK7o1zVnA
 ydJGijkGpxPH67EnhGCw/fpqhyQAJjA9js0ZGYqWRfSNNd1Z5wk2czyRLAtY5byMF6l3DG41VeA
 3TDMsIQlDYH1xI1hKOA==
X-Proofpoint-ORIG-GUID: Nlg_jJ9c-RPYofcaELCg_RWddl8XSiv8
X-Authority-Analysis: v=2.4 cv=e6Y2j6p/ c=1 sm=1 tr=0 ts=6a432e4d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=0Cqobd3ug1408HmlttkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAyNCBTYWx0ZWRfX0ikVWg1I+YCW
 khHKarvyGrK41tYWxKHVNnVrOfWiiWWEXHAQhnqaAbb+gLupexWTT9r3i5QWleAxcgvbuUr0Np7
 ZTvgKzp577IiYuIoQUaaSUbNRrYPQAA=
X-Proofpoint-GUID: Nlg_jJ9c-RPYofcaELCg_RWddl8XSiv8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-302902-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26E916DFE03

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
index 1a6dcb6ff135..835fe2528f03 100644
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
@@ -2078,6 +2081,7 @@ struct npc_install_flow_req {
 	u16 entry;
 	u16 channel;
 	u16 chan_mask;
+	u8 set_chanmask;
 	u8 intf;
 	u8 set_cntr; /* If counter is available set counter for this entry ? */
 	u8 default_rule;
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


