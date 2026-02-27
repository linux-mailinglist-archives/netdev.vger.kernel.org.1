Return-Path: <netdev+bounces-261777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB9UDkxhoWnIsQQAu9opvQ
	(envelope-from <netdev+bounces-261777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:18:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAB81B528F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64D19315E61D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221BD3D1CC5;
	Fri, 27 Feb 2026 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QAVtXR0a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748E1FE45D;
	Fri, 27 Feb 2026 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183672; cv=none; b=qT19xpFKEDI76vPWzUljrzS2O4mfatOsnvwtSJCxsm39jtzPFMhpCe/hInc97BHo5Zh9KB4PU9gGRAj5VUeiwPn7/P+/uBTgrRiAAVOg5DLAV3nEBD4QhULFrqAOulhpydbX+DAMuYYSlayK5KpQprIZURm7zNe66DsmYeeGgzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183672; c=relaxed/simple;
	bh=VT3oFG9DRvFa2kerIMUoN8Bg68KC7AQhmi4O8Zo1DZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POU00FLoTLCT8A4H/7330m4QjOnyv7VbHCXNwFYVXHqrlZpD/Lpnjd6cxXJacQZEcM5SOJRkH/Ko78ouwcxzFLhQ7b0F0Z+AX+/8bEAKNqfw8mQJteXYXnAMK3bgvJ8nqQTO65QC/xjmDsS2p+VV/DUMIee5VyjQtySUIC0vXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QAVtXR0a; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R0MvRt096637;
	Fri, 27 Feb 2026 01:14:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	dUUXFAXd7Gwinbgwn04tUkJyTDpoe6Hn5EyBghqdzY=; b=QAVtXR0axjyY/rlnU
	sdj/YBX7S14Nd/Or4yipOLkrq3+A25qW2DGsYFBg3x44WoGtwyULf5I601ANGN/j
	4pMqXVMQfQJQJBRp1Nty4tqafc/bqunyC1NOV+491nooEBHg4wxsoa6oC+Ji0PaF
	nzEp4MJs1o1QrZsH7LDS3U+ABxpHt2zWJ2vvaip5MmWbv1q16h7umDQ7kBQigz7R
	YUk4qdd+Qmpd45imJNpzHgSpF/aVc/DKyRiZoMjgE03gbC38KJaAaEOz13a9MzNw
	09efP9Az/4uEF7Dpy97xYlfv8ifYVtYMdNUD5xp+fqCfqwH4Jd/wwUjiuPzhrTkT
	gJY2g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cjpuhjswd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 01:14:10 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Feb 2026 01:14:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 27 Feb 2026 01:14:09 -0800
Received: from 101hsapphire1.sclab.marvell.com (unknown [10.111.168.47])
	by maili.marvell.com (Postfix) with ESMTP id 9927A3F705E;
	Fri, 27 Feb 2026 01:14:08 -0800 (PST)
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
        Satananda Burla
	<sburla@marvell.com>,
        "Abhijit Ayarekar" <aayarekar@marvell.com>
Subject: [PATCH net v2 1/4] octeon_ep: Relocate counter updates before NAPI
Date: Fri, 27 Feb 2026 09:13:57 +0000
Message-ID: <20260227091402.1773833-2-vimleshk@marvell.com>
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
X-Proofpoint-ORIG-GUID: queF7QBYG0PE8njXM4uHpRLegMlRBf7S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA3OSBTYWx0ZWRfX4S2ODsWUBI0A
 UPqIeNZLkIVeFAdBHmszA0LpBYsvXaMWXcw8BIHJoJXV9D9JuMKNdniIBXcfzpHTwd9d9fC9vlu
 XBn9GQck56naEb5pBzEfvYsUwxGpfq9RGUUPJ5kQXMBD3+6BjoqnSY1jUpGNzU1aI8fjy6mt14e
 jIwR3joApwOkWwoqLVJz4Tu+58xxzGzQwmdEaXfP5q/WHqpPKPkyzXahVnaSpevpNDbpIAhCi2/
 u6D0LHyMaC+nKvRyZRo4ipZtvjHvrozwUylVRzyD7lPrwHLADhECVyEAvFgOeyMZT85Q4biLN5b
 /QfAY53B9or/kfd46ASFBtg5Epn02VhhyBqjBE/vVqL0qUwcY1SHGbyRGRGITQSzFiuJA7WMeIW
 LWdIelc/l45+WlerjGbcE0Xgwm0yS3brL4FZkPdmBhoVBdcWVMnAMHM5DnzXMllL0FqUimE05/5
 Hs+76/VLd3OtBGStPdw==
X-Proofpoint-GUID: queF7QBYG0PE8njXM4uHpRLegMlRBf7S
X-Authority-Analysis: v=2.4 cv=f7JFxeyM c=1 sm=1 tr=0 ts=69a16062 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=l8fbD5RvBbpoYuFOKEoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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
	TAGGED_FROM(0.00)[bounces-261777-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vimleshk@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:mid,marvell.com:dkim,marvell.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: ACAB81B528F
X-Rspamd-Action: no action

Relocate IQ/OQ IN/OUT_CNTS updates to occur before NAPI completion,
and replace napi_complete with napi_complete_done.

Moving the IQ/OQ counter updates before napi_complete_done ensures
1. Counter registers are updated before re-enabling interrupts.
2. Prevents a race where new packets arrive but counters aren't properly
   synchronized.
napi_complete_done (vs napi_complete) allows for better
interrupt coalescing.

Fixes: 37d79d0596062 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
 .../ethernet/marvell/octeon_ep/octep_main.c   | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index bcea3fc26a8c..a93c3c9994c2 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -555,12 +555,12 @@ static void octep_clean_irqs(struct octep_device *oct)
 }
 
 /**
- * octep_enable_ioq_irq() - Enable MSI-x interrupt of a Tx/Rx queue.
+ * octep_update_pkt() - Update IQ/OQ IN/OUT_CNT registers.
  *
  * @iq: Octeon Tx queue data structure.
  * @oq: Octeon Rx queue data structure.
  */
-static void octep_enable_ioq_irq(struct octep_iq *iq, struct octep_oq *oq)
+static void octep_update_pkt(struct octep_iq *iq, struct octep_oq *oq)
 {
 	u32 pkts_pend = oq->pkts_pending;
 
@@ -576,7 +576,17 @@ static void octep_enable_ioq_irq(struct octep_iq *iq, struct octep_oq *oq)
 	}
 
 	/* Flush the previous wrties before writing to RESEND bit */
-	wmb();
+	smp_wmb();
+}
+
+/**
+ * octep_enable_ioq_irq() - Enable MSI-x interrupt of a Tx/Rx queue.
+ *
+ * @iq: Octeon Tx queue data structure.
+ * @oq: Octeon Rx queue data structure.
+ */
+static void octep_enable_ioq_irq(struct octep_iq *iq, struct octep_oq *oq)
+{
 	writeq(1UL << OCTEP_OQ_INTR_RESEND_BIT, oq->pkts_sent_reg);
 	writeq(1UL << OCTEP_IQ_INTR_RESEND_BIT, iq->inst_cnt_reg);
 }
@@ -602,7 +612,8 @@ static int octep_napi_poll(struct napi_struct *napi, int budget)
 	if (tx_pending || rx_done >= budget)
 		return budget;
 
-	napi_complete(napi);
+	octep_update_pkt(ioq_vector->iq, ioq_vector->oq);
+	napi_complete_done(napi, rx_done);
 	octep_enable_ioq_irq(ioq_vector->iq, ioq_vector->oq);
 	return rx_done;
 }
-- 
2.47.3


