Return-Path: <netdev+bounces-258451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI1MF3HFjWnT6gAAu9opvQ
	(envelope-from <netdev+bounces-258451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:20:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C911812D5F5
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0347C304DE96
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFD63451B0;
	Thu, 12 Feb 2026 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="j6AlECDA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D5A2F547F;
	Thu, 12 Feb 2026 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898628; cv=none; b=m+rpso5wSkBlNYeiWsIDC0TfcZ7dm2xkImv9l02oGt9teNphgsRPzWT86mWqZ+5OXywATyDz77mBlGhVMmp0nHaQgNhSz+7jqhqBek9Db2T5tY/5ZvGKts5tPDP6XChGW3BWhvyt3Z8r5epcrYphrTckPW4g1UDyIlgrtT1dqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898628; c=relaxed/simple;
	bh=PXtE5S3MYeSM4NFbKkSYxMIz8BkAcijvzb9fflOb260=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tO+NZtF7415DikgrXZd3x26WthEa03i1a7/An5RFSdfidzsdfNr55g5PRPm45gjdzdKbcpTzC9lfhGyOrAI8cOcKNH93lD6EJnTdvs34wwWTLskEN+Xb25zm5Ws8NuKwBfAxJ6PBv82rhkVqI/LU4AP5Tn3q4GUzRSUTauflXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=j6AlECDA; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BLNosc1274001;
	Thu, 12 Feb 2026 04:16:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
	eqAETiTNj6uSgD0Ysfv8r5zDeIueL0UnHS5qvcdV2o=; b=j6AlECDAP2JpFPmcL
	LqnNzNZLf73oHhTj1PGn1HEOClufciitqMnQYnGXp2nwRmCQJt48RhSKvDy2+HOK
	bpqLINdPs6n8JHluBOfRRHN8Uc4H+ZYvWJAuTiPs1hm/vFvc8/8iklKTFeFMKMmy
	aAVWQlKhuKLynRKZs3HGkF5uPZBwU0mGf6ECJON52Rb9blH5LaiBUJXXGvbpLVrH
	LzFDBXW6bRVze7ybu48XPgj3R1Isdb/Qv/vK3ryXNucpH8wvzKg9XUtvSCfqiwb5
	/SLJ4MCfz7RnKB47UiJHU2v81gVa0dJ/tlnimOF3+Ji7pvAGqVN6cNapYInFJz7a
	dTWoA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c89g1nnu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 04:16:45 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Feb 2026 04:17:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 12 Feb 2026 04:17:02 -0800
Received: from 101hsapphire1.sclab.marvell.com (unknown [10.111.168.47])
	by maili.marvell.com (Postfix) with ESMTP id 872213F70DA;
	Thu, 12 Feb 2026 04:16:44 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH RESEND net v1 2/2] octeon_ep_vf: avoid compiler and IQ/OQ reordering
Date: Thu, 12 Feb 2026 12:16:32 +0000
Message-ID: <20260212121634.360252-3-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212121634.360252-1-vimleshk@marvell.com>
References: <20260212121634.360252-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ELgLElZC c=1 sm=1 tr=0 ts=698dc4ad cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=zFyd0VMmUU5vBRt5t4UA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA5MiBTYWx0ZWRfX17xQLGfyr22o
 r5iPbXDlXc390J5i7erndcfw2Q2gNiERjms4kuOhCVjLc66tOCbH48ypk2LV4g1cfkVNEjPCIX5
 wp11yOco7NHDH2npQefyHSWWeMjI7lTgBXHs75y2U6IiHB7l6ovn+GYwR0sTIUbz1EzYuiUUi1o
 uBlJuwzr336ZOlRcyRID+R+f2SWo1NpwMprtchEMvuYsbxwo8+7arTZnf4copJnuyKWB5B+gnhI
 KwQMkvNjxeKFJiXGnqKF97u0mof0ul8fznOIpdSMzRScIm9l0K7W24jYfe6z5C+pOOgcF3LIuON
 LXRLmcwKq23ehTG7+9tdagazK86B0Z4MPV9X98eFJcAZzIK5NouiZ15PvdvnxVwnM8iywQdz/aW
 KScI2vy3PwnPA38V2oonvVY953lvWAZYLlmQbUWFar2f4EgxDn+zyfCxxA2g3qp5LBp1MaLXqou
 Mp0tHiOSQNavfV0oFBg==
X-Proofpoint-GUID: Se_ZuQ__BQ1ifB8R9xplfaVxgmLl75iP
X-Proofpoint-ORIG-GUID: Se_ZuQ__BQ1ifB8R9xplfaVxgmLl75iP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-12_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258451-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vimleshk@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:mid,marvell.com:dkim,marvell.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C911812D5F5
X-Rspamd-Action: no action

Utilize READ_ONCE and WRITE_ONCE APIs for IO queue Tx/Rx
variable access to prevent compiler optimization and reordering.
Additionally, ensure IO queue OUT/IN_CNT registers are flushed
by performing a read-back after writing.

Relocate IQ/OQ IN/OUT_CNTS updates to occur before NAPI completion,
and replace napi_complete with napi_complete_done.

Fixes: 1cd3b407977c3 ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 38 ++++++++++++++-----
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 28 ++++++++++----
 2 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 420c3f4cf741..27a5fc38bccb 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -286,28 +286,45 @@ static void octep_vf_clean_irqs(struct octep_vf_device *oct)
 }
 
 /**
- * octep_vf_enable_ioq_irq() - Enable MSI-x interrupt of a Tx/Rx queue.
+ * octep_vf_update_pkt() - Update IQ/OQ IN/OUT_CNT registers.
  *
  * @iq: Octeon Tx queue data structure.
  * @oq: Octeon Rx queue data structure.
  */
-static void octep_vf_enable_ioq_irq(struct octep_vf_iq *iq, struct octep_vf_oq *oq)
+
+static void octep_vf_update_pkt(struct octep_vf_iq *iq, struct octep_vf_oq *oq)
 {
-	u32 pkts_pend = oq->pkts_pending;
+	u32 pkts_pend = READ_ONCE(oq->pkts_pending);
+	u32 last_pkt_count = READ_ONCE(oq->last_pkt_count);
+	u32 pkts_processed = READ_ONCE(iq->pkts_processed);
+	u32 pkt_in_done = READ_ONCE(iq->pkt_in_done);
 
 	netdev_dbg(iq->netdev, "enabling intr for Q-%u\n", iq->q_no);
-	if (iq->pkts_processed) {
-		writel(iq->pkts_processed, iq->inst_cnt_reg);
-		iq->pkt_in_done -= iq->pkts_processed;
-		iq->pkts_processed = 0;
+	if (pkts_processed) {
+		writel(pkts_processed, iq->inst_cnt_reg);
+		readl(iq->inst_cnt_reg);
+		WRITE_ONCE(iq->pkt_in_done, (pkt_in_done - pkts_processed));
+		WRITE_ONCE(iq->pkts_processed, 0);
 	}
-	if (oq->last_pkt_count - pkts_pend) {
-		writel(oq->last_pkt_count - pkts_pend, oq->pkts_sent_reg);
-		oq->last_pkt_count = pkts_pend;
+	if (last_pkt_count - pkts_pend) {
+		writel(last_pkt_count - pkts_pend, oq->pkts_sent_reg);
+		readl(oq->pkts_sent_reg);
+		WRITE_ONCE(oq->last_pkt_count, pkts_pend);
 	}
 
 	/* Flush the previous wrties before writing to RESEND bit */
 	smp_wmb();
+}
+
+/**
+ * octep_vf_enable_ioq_irq() - Enable MSI-x interrupt of a Tx/Rx queue.
+ *
+ * @iq: Octeon Tx queue data structure.
+ * @oq: Octeon Rx queue data structure.
+ */
+static void octep_vf_enable_ioq_irq(struct octep_vf_iq *iq,
+				    struct octep_vf_oq *oq)
+{
 	writeq(1UL << OCTEP_VF_OQ_INTR_RESEND_BIT, oq->pkts_sent_reg);
 	writeq(1UL << OCTEP_VF_IQ_INTR_RESEND_BIT, iq->inst_cnt_reg);
 }
@@ -333,6 +350,7 @@ static int octep_vf_napi_poll(struct napi_struct *napi, int budget)
 	if (tx_pending || rx_done >= budget)
 		return budget;
 
+	octep_vf_update_pkt(ioq_vector->iq, ioq_vector->oq);
 	if (likely(napi_complete_done(napi, rx_done)))
 		octep_vf_enable_ioq_irq(ioq_vector->iq, ioq_vector->oq);
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index d70c8be3cfc4..31380962c212 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -319,9 +319,16 @@ static int octep_vf_oq_check_hw_for_pkts(struct octep_vf_device *oct,
 					 struct octep_vf_oq *oq)
 {
 	u32 pkt_count, new_pkts;
+	u32 last_pkt_count, pkts_pending;
 
 	pkt_count = readl(oq->pkts_sent_reg);
-	new_pkts = pkt_count - oq->last_pkt_count;
+	last_pkt_count = READ_ONCE(oq->last_pkt_count);
+	new_pkts = pkt_count - last_pkt_count;
+
+	if (pkt_count < last_pkt_count) {
+		dev_err(oq->dev, "OQ-%u pkt_count(%u) < oq->last_pkt_count(%u)\n",
+			oq->q_no, pkt_count, last_pkt_count);
+	}
 
 	/* Clear the hardware packets counter register if the rx queue is
 	 * being processed continuously with-in a single interrupt and
@@ -333,8 +340,9 @@ static int octep_vf_oq_check_hw_for_pkts(struct octep_vf_device *oct,
 		pkt_count = readl(oq->pkts_sent_reg);
 		new_pkts += pkt_count;
 	}
-	oq->last_pkt_count = pkt_count;
-	oq->pkts_pending += new_pkts;
+	WRITE_ONCE(oq->last_pkt_count, pkt_count);
+	pkts_pending = READ_ONCE(oq->pkts_pending);
+	WRITE_ONCE(oq->pkts_pending, (pkts_pending + new_pkts));
 	return new_pkts;
 }
 
@@ -363,7 +371,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 	struct sk_buff *skb;
 	u32 read_idx;
 
-	read_idx = oq->host_read_idx;
+	read_idx = READ_ONCE(oq->host_read_idx);
 	rx_bytes = 0;
 	desc_used = 0;
 	for (pkt = 0; pkt < pkts_to_process; pkt++) {
@@ -457,7 +465,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 		napi_gro_receive(oq->napi, skb);
 	}
 
-	oq->host_read_idx = read_idx;
+	WRITE_ONCE(oq->host_read_idx, read_idx);
 	oq->refill_count += desc_used;
 	oq->stats->packets += pkt;
 	oq->stats->bytes += rx_bytes;
@@ -480,22 +488,26 @@ int octep_vf_oq_process_rx(struct octep_vf_oq *oq, int budget)
 {
 	u32 pkts_available, pkts_processed, total_pkts_processed;
 	struct octep_vf_device *oct = oq->octep_vf_dev;
+	u32 pkts_pending;
 
 	pkts_available = 0;
 	pkts_processed = 0;
 	total_pkts_processed = 0;
 	while (total_pkts_processed < budget) {
 		 /* update pending count only when current one exhausted */
-		if (oq->pkts_pending == 0)
+		pkts_pending = READ_ONCE(oq->pkts_pending);
+		if (pkts_pending == 0)
 			octep_vf_oq_check_hw_for_pkts(oct, oq);
+		pkts_pending = READ_ONCE(oq->pkts_pending);
 		pkts_available = min(budget - total_pkts_processed,
-				     oq->pkts_pending);
+				     pkts_pending);
 		if (!pkts_available)
 			break;
 
 		pkts_processed = __octep_vf_oq_process_rx(oct, oq,
 							  pkts_available);
-		oq->pkts_pending -= pkts_processed;
+		pkts_pending = READ_ONCE(oq->pkts_pending);
+		WRITE_ONCE(oq->pkts_pending, (pkts_pending - pkts_processed));
 		total_pkts_processed += pkts_processed;
 	}
 
-- 
2.47.3


