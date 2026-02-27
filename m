Return-Path: <netdev+bounces-261775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO6PNA1hoWmksQQAu9opvQ
	(envelope-from <netdev+bounces-261775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:17:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D01B5008
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F8A30F9E53
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE028CF6F;
	Fri, 27 Feb 2026 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="P5MaWaFd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE32DD60F;
	Fri, 27 Feb 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183665; cv=none; b=dGMKEzyc3IvUXIvh61Z6Z9oA2jj7kifPL8o/l0JbJrhKhSi+AOR+YwQZTwez1TBYs1RZNB3td5nEMOlxV9dpvKIwOeYIQW7iMmkUTC19GatQi6Upqy4eRXA8n95i8rQpgGwnaKU69zZr+3mRGqXMf7OGSnKRcvqqD51eZAZjpro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183665; c=relaxed/simple;
	bh=MIMkx/Y/ASdUx8iiWbmztrfHiR/YcXbJNPe1CoSwNWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1buIWM6uiL4+qu3Y7mG5roAPougfpuiEFu1jEbnb7kHixpdQDMBKskHY4BKQCIxFGbHj00Q4Ak6Rxr74Nf7vNDvkeYtf+DlDprDCscw1Vk4U9ns8wzlA2ENTE/9EzUNtwvTvpXJ2LqKqcmOlnB03JhDRXbc57b6pzPW6XCgOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=P5MaWaFd; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QNKV5u2260183;
	Fri, 27 Feb 2026 01:14:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	Lb0Uk6R2IaCViloOJoBAGHOQQ6/HnT/IRDoSIyYi48=; b=P5MaWaFd9bqh+hwpX
	+VXLP6Nh9gYuOTg/7LNohwygPeYNqHSitP+6L+7GhrUs0unVsg7fOnPCGK94O0T+
	JPNKH1RZcthhqZspABwX53IQQTmJwUoZopWB2pEMImKjb95oZtQ1fe4Uen56RnCD
	yJVo+wH/q/jW4VWLIExdHd5TEv+9RM8GA4Gt6Irc0XoCu8VEALBjjdtjEnMDG6nV
	n8Vyjzr3/ZMfog54ULUddCnx3bhvWWLZJpbeWYPbEQIA9j7HIQopZZlpg5dHlPin
	W/1+j55JU2RE+qczh/Ev5kqXfheLcPg89zy/Le1ykGtN2g9tpCSAwFlfFosmMjMT
	bUHfg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cjyrx116q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 01:14:14 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Feb 2026 01:14:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 27 Feb 2026 01:14:12 -0800
Received: from 101hsapphire1.sclab.marvell.com (unknown [10.111.168.47])
	by maili.marvell.com (Postfix) with ESMTP id 3609E3F705E;
	Fri, 27 Feb 2026 01:14:12 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        Abhijit Ayarekar
	<aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: [PATCH net v2 2/4] octeon_ep: avoid compiler and IQ/OQ reordering
Date: Fri, 27 Feb 2026 09:13:58 +0000
Message-ID: <20260227091402.1773833-3-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227091402.1773833-1-vimleshk@marvell.com>
References: <20260227091402.1773833-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Y6H1cxeN c=1 sm=1 tr=0 ts=69a16066 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=OZLdTvkJ1xrx5OaBTMEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: qUZVOHdPHjkZcCaYEbeO464eb0svZdba
X-Proofpoint-GUID: qUZVOHdPHjkZcCaYEbeO464eb0svZdba
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA3OSBTYWx0ZWRfX2r/A8O7azJrG
 8hCVrO4ofWDHIJZyM6el0ehgY1joH/pjeg3v6pOmYQYKYVBK7inwxKFC79JhStISrteOFZwDFo7
 hL4QEgl1gcoA1Z16UsTUdnoyv2mr9GBTCUljd7rHrwWu7efCzv+tUk5ZLkjl4TFR7ko7GsSqjgy
 t4E38e8zWkM0h7u0xllJYFlABGd9N0/4WeeGFQmF1CmZ81nyKLk97aGPR4XFy1xR7qtRDcI4V4P
 miNgKShVPo0BJR4e8f3dUmpujtkzfAfp4AgJDWtSc4YGQZWQl/M0y1a4ucy/IuEBtBjqXYon5Ab
 HGTyby2MBSdcuOw+Ls5+mqjRF/lZ1JesdjTbpbznkytniaQdk9yEIDBN8hzAGXZcymiRDj5yqvT
 rs4eL3WYjIvL6EcRfw8MqNxih0d4j52uT/7wg2PulOMCokRnmtoIw4K3m4GcPFBpdyKZQn1lqmx
 wUjhI8mj4whHbqh1kEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261775-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vimleshk@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:mid,marvell.com:dkim,marvell.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CD5D01B5008
X-Rspamd-Action: no action

Utilize READ_ONCE and WRITE_ONCE APIs for IO queue Tx/Rx
variable access to prevent compiler optimization and reordering.
Additionally, ensure IO queue OUT/IN_CNT registers are flushed
by performing a read-back after writing.

The compiler could reorder reads/writes to pkts_pending, last_pkt_count,
etc., causing stale values to be used when calculating packets to process
or register updates to send to hardware. The Octeon hardware requires a
read-back after writing to OUT_CNT/IN_CNT registers to ensure the write
has been flushed through any posted write buffers before the interrupt
resend bit is set. Without this, we have observed cases where the hardware
didn't properly update its internal state.

wmb/rmb only provides ordering guarantees but doesn't prevent the compiler
from performing optimizations like caching in registers, load tearing etc.

Fixes: 37d79d0596062 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
V1: https://lore.kernel.org/all/20260212121634.360252-2-vimleshk@marvell.com/

 .../ethernet/marvell/octeon_ep/octep_main.c   | 21 +++++++++------
 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 27 +++++++++++++------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index a93c3c9994c2..ccfb248d0914 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -562,17 +562,22 @@ static void octep_clean_irqs(struct octep_device *oct)
  */
 static void octep_update_pkt(struct octep_iq *iq, struct octep_oq *oq)
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
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 82b6b19e76b4..11f1b45d0f92 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -318,10 +318,16 @@ static int octep_oq_check_hw_for_pkts(struct octep_device *oct,
 				      struct octep_oq *oq)
 {
 	u32 pkt_count, new_pkts;
+	u32 last_pkt_count, pkts_pending;
 
 	pkt_count = readl(oq->pkts_sent_reg);
-	new_pkts = pkt_count - oq->last_pkt_count;
+	last_pkt_count = READ_ONCE(oq->last_pkt_count);
+	new_pkts = pkt_count - last_pkt_count;
 
+	if (pkt_count < last_pkt_count) {
+		dev_err(oq->dev, "OQ-%u pkt_count(%u) < oq->last_pkt_count(%u)\n",
+			oq->q_no, pkt_count, last_pkt_count);
+	}
 	/* Clear the hardware packets counter register if the rx queue is
 	 * being processed continuously with-in a single interrupt and
 	 * reached half its max value.
@@ -332,8 +338,9 @@ static int octep_oq_check_hw_for_pkts(struct octep_device *oct,
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
 
@@ -408,7 +415,7 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 	u16 rx_ol_flags;
 	u32 read_idx;
 
-	read_idx = oq->host_read_idx;
+	read_idx = READ_ONCE(oq->host_read_idx);
 	rx_bytes = 0;
 	desc_used = 0;
 	for (pkt = 0; pkt < pkts_to_process; pkt++) {
@@ -493,7 +500,7 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 		napi_gro_receive(oq->napi, skb);
 	}
 
-	oq->host_read_idx = read_idx;
+	WRITE_ONCE(oq->host_read_idx, read_idx);
 	oq->refill_count += desc_used;
 	oq->stats->packets += pkt;
 	oq->stats->bytes += rx_bytes;
@@ -516,22 +523,26 @@ int octep_oq_process_rx(struct octep_oq *oq, int budget)
 {
 	u32 pkts_available, pkts_processed, total_pkts_processed;
 	struct octep_device *oct = oq->octep_dev;
+	u32 pkts_pending;
 
 	pkts_available = 0;
 	pkts_processed = 0;
 	total_pkts_processed = 0;
 	while (total_pkts_processed < budget) {
 		 /* update pending count only when current one exhausted */
-		if (oq->pkts_pending == 0)
+		pkts_pending = READ_ONCE(oq->pkts_pending);
+		if (pkts_pending == 0)
 			octep_oq_check_hw_for_pkts(oct, oq);
+		pkts_pending = READ_ONCE(oq->pkts_pending);
 		pkts_available = min(budget - total_pkts_processed,
-				     oq->pkts_pending);
+				     pkts_pending);
 		if (!pkts_available)
 			break;
 
 		pkts_processed = __octep_oq_process_rx(oct, oq,
 						       pkts_available);
-		oq->pkts_pending -= pkts_processed;
+		pkts_pending = READ_ONCE(oq->pkts_pending);
+		WRITE_ONCE(oq->pkts_pending, (pkts_pending - pkts_processed));
 		total_pkts_processed += pkts_processed;
 	}
 
-- 
2.47.3


