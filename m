Return-Path: <netdev+bounces-261778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO2OIYFhoWnIsQQAu9opvQ
	(envelope-from <netdev+bounces-261778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:18:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D16311B531C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 616773173DF3
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B543D7D66;
	Fri, 27 Feb 2026 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CJSmN2al"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5936A009;
	Fri, 27 Feb 2026 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183673; cv=none; b=cMlFsGE/fF55ezCxlUeBD5FieadS/D7aBUuuMeL+Jxs2iQbp41RJSoY3plFKLxCsb4PjqFvKEs9LWK8r2mbGlfZU68S0Y7pQQZVd294zrKXKnc0stDrku3/+awyIBXKDZK3wdGmzWk/U4QISE0KVvB0Dst+IdEMsbINrgikYAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183673; c=relaxed/simple;
	bh=48ByVAjchdJGbtgbwmuBIyBfBDt0oYIf1gvDZH6zrsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txsjnWq7no+ndTaJFldtQkEjvk7iu7Jegol+NyAmBHwsmpv8oXeXe6NX55M2qNafionrCVSt9wi3rMAXAVmvf9nlwwlqbbPGg42HFsDhj3AePa41xcT0Z+0lh4dRtqs0X/ax7IouKxDB5JHQuVL8vZO0pqoYxqQKKLd8D8oU6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CJSmN2al; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QKAZ2e240757;
	Fri, 27 Feb 2026 01:14:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	g18l2emhDDDBQJLpFA6hc+1FosgnXVga7yX2JaHwHU=; b=CJSmN2alun9lu/ZVe
	J0g7CWNQNULvE/GI0QBtbgaAk9ZBlvxTbYZSm8zzO6CZagkbF16b8AKrmekZmsBK
	T7qyD2tUqvl6xdw8N37jLmVUH0sNP+RctPQ9It+gHT4b7xSuTdyKFHOBeANI0l/G
	RDlUMnCFk2rdSiQmfSps0E9j7mavPPauLT2JC863osWmr2vvBKUUpvR3DgBGVPpE
	4F+zYhZjfcTmrNzZ2zoi9duK/6QKfpfi0L56eS4FIlPrZSTxcX1qZ7wBGzh+9FkB
	iode240q9ZVfmODdyJo+Imcx1oHmbyLcW1O4z9Zr0CKCRE3rWKI2db7L0H4ErP7f
	kJ5/Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4chqcyy84a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 01:14:17 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Feb 2026 01:14:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 27 Feb 2026 01:14:16 -0800
Received: from 101hsapphire1.sclab.marvell.com (unknown [10.111.168.47])
	by maili.marvell.com (Postfix) with ESMTP id 854593F70B4;
	Fri, 27 Feb 2026 01:14:15 -0800 (PST)
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
Subject: [PATCH net v2 3/4] octeon_ep_vf: Relocate counter updates before NAPI
Date: Fri, 27 Feb 2026 09:13:59 +0000
Message-ID: <20260227091402.1773833-4-vimleshk@marvell.com>
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
X-Proofpoint-GUID: 68xEKrNVg6vqEA5VjOGCqnzosQQqHrrl
X-Proofpoint-ORIG-GUID: 68xEKrNVg6vqEA5VjOGCqnzosQQqHrrl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA3OSBTYWx0ZWRfX+srhLAQ/aRRi
 IDB585ZrimtU77h7n/w96mewOttaXsS6W7T3WbSi+WkrLs/GBDE9zgGKT0G+f87Ados+LRqmkub
 3nFRanUrFU9R2kVRqNRNvHiafNzm72fbDAJJ4qsfudfxOv8cx+nADkxOS3/IfpdtkuZrqmM7CZd
 ioGcyJB8U+jPisgmZUicpH3e8o57bBVuoWtWMU9j1VmSuLqQW7wTIokUzD7c4cOQUqeRVISU+9m
 XoIyNsuz1bwCXH5w9Mf6+rgJQ9iykoFsFCBoEziumTXw6NpO1t3cQeuuu22ZJ2hW7pgBRECkw61
 YPaYWGrm/y7Ep3ex/ikwh6b4k1f7tgVIWxJHQ2A6lU4VKT6yHuX9Alu9dSpdx8aEMM2Khnj1PcH
 kfXcS7QQ6MKL2jiE085uCWIiMH3qp76bqIUkd5cyU9H3np7H2Tj7qNuYWP4NbLrKO+e4bJ7BYHs
 pO14LTsF/kQi5Sp3ipg==
X-Authority-Analysis: v=2.4 cv=B/S0EetM c=1 sm=1 tr=0 ts=69a16069 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=2r72hCCS2uxvEu3KRW0A:9
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261778-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: D16311B531C
X-Rspamd-Action: no action

Relocate IQ/OQ IN/OUT_CNTS updates to occur before NAPI completion.
Moving the IQ/OQ counter updates before napi_complete_done ensures
1. Counter registers are updated before re-enabling interrupts.
2. Prevents a race where new packets arrive but counters aren't properly
   synchronized.

Fixes: 1cd3b407977c3 ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
 .../marvell/octeon_ep_vf/octep_vf_main.c        | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 420c3f4cf741..e113c846f9d1 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -286,12 +286,13 @@ static void octep_vf_clean_irqs(struct octep_vf_device *oct)
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
 	u32 pkts_pend = oq->pkts_pending;
 
@@ -308,6 +309,17 @@ static void octep_vf_enable_ioq_irq(struct octep_vf_iq *iq, struct octep_vf_oq *
 
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
@@ -333,6 +345,7 @@ static int octep_vf_napi_poll(struct napi_struct *napi, int budget)
 	if (tx_pending || rx_done >= budget)
 		return budget;
 
+	octep_vf_update_pkt(ioq_vector->iq, ioq_vector->oq);
 	if (likely(napi_complete_done(napi, rx_done)))
 		octep_vf_enable_ioq_irq(ioq_vector->iq, ioq_vector->oq);
 
-- 
2.47.3


