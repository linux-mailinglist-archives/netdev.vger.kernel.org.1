Return-Path: <netdev+bounces-303885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6zrAGTqVRWosCgsAu9opvQ
	(envelope-from <netdev+bounces-303885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:31:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A2A6F21B1
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:31:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=RzcH37kE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303885-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303885-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EAFB315DAD0
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 22:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72475420E8E;
	Wed,  1 Jul 2026 22:26:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13C6420E7F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 22:26:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944768; cv=none; b=rkoHgE5WrbNZF1O2qF9Nsu4fPXx5Bxcw6ApXosKxCwNHYDd1rwGWFYsuQURdq8LQQgTF4Olr1uP7UH2P7g0m6oD6jhJP0/7G6tS95BSJVhlsK6GDM+nOJMcWaI1CC5ANBXSjtZbYKtdaFSDikrPaluxCRfYpU4P1DaTZeA69uzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944768; c=relaxed/simple;
	bh=lfY1BPxGWhADpJp9Ko6tp8pAnOvHrLtkOS1G/4nji+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/P/4JriUYKCfDL+Mvdo/fM/EEWkAOWvr44s0gY0F0bRVpgGBwO3Qj4LMHu7FxHWzWTYHD3AkQttXGzmlNGAUrUtzJNhAbcOccYpDkI8NPM2H3v2Tld1uhurQmLXtUuhALMslNZ4SH3m1k8+etBZ2/k8zKePjlu99b1JmzNsfpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RzcH37kE; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661LmTEw2030169;
	Wed, 1 Jul 2026 22:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5WFgnhjFb3ujhWuLu
	5dC/j92ByllA3Et568vLAlecps=; b=RzcH37kEjYAPrFffzm4RhNtZmbRuwW9xq
	mD/JeYNOdyVlXaKBwt8h3OGBj/0ABTaClZ01QL44Vrry0dM5qGR5n29MUnZrDEYk
	aYBtWSDh7cNvYKozpuTOXGPfeLPC9Z8JYr/BEw/LgXsJuUg2CUNMq+mOIW/YuCJj
	mb48D0ZOsCFBxBclHVXaMS820maMbBuEorfObChJzYqCa4XWRSUGoWL2QjuirHQM
	Ui4PbPWNhAMXqWdhWT24yENDG6+x6Sqzc2GPl/bSu8EoHZvFLdyAIp4dS5P4WHeT
	+fGR7rusY0VAnuDEZh8dfYopcLKD3hHjqZ38avASKAYfvrd5C39ig==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5xynn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661MJbLe001383;
	Wed, 1 Jul 2026 22:25:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyh4v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661MPrKM29819478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 22:25:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87B4F5804B;
	Wed,  1 Jul 2026 22:25:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2199E58066;
	Wed,  1 Jul 2026 22:25:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.150.53])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 22:25:52 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v2 15/15] ibmveth: Fix MQ RX poll and shutdown hangs after queue resize
Date: Wed,  1 Jul 2026 15:23:27 -0700
Message-Id: <20260701222327.61325-16-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260701222327.61325-1-mmc@linux.ibm.com>
References: <20260701222327.61325-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX9yYGwphyZA0M
 QVB9oQDVA53C69eedTsnuJ0k0qQ3mnKQInpDrGjG+3XGNA5eprv5csSCmYAMDgpDAKNEA25najP
 NeWCki1MJ3WgeR0joDi5hKbX7Q+L3o/LP6ZhgtZtnwUKsCDXI8py8BdFX9TrA9gzI4Nn2YfC6qW
 +2EpHkonNLzeYe3lLIkwVFb60UrOKodItctG6wCRDwpKoCffVQfUO3kI6eNPqUvUplmhzwvvCZx
 LcSmUnkCfXFeL4cfCBq7uhOuGDYWEvzAnCALOxP/vG0ZOipYlz+sOls5I8r2F7SmiCJu//SQAF1
 kvUCoEcr83/odfVXg8Ow0oratud0Mdh0YptJ5u0qe88fCQkNoaoKi5Yw33K2Ivg3VBB0I/cMfy0
 vLbugUiLa37pGevSlyvM4VQ+jc6bQ6utFLrvu4C4PEIaKUM3kl0XYLzo235RI6ujPLxAIkTLqfK
 GJWB3Kz4DDx60tP9B4g==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a4593f4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=H2PsU0_gVjd1cLIlZ3YA:9
X-Proofpoint-ORIG-GUID: KY8kV9KCYWYTDSrFI9h-_1fcIFEWL17U
X-Proofpoint-GUID: Th7arcEAi8i9hshMNlDnsy_vFDZFfp1m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfXzvGm269p7jrx
 PLGRw9rn3HYvDh/UZoXENxMttqKAXSDqNyl7gxYga7k4U9Wlg2KIS4MNPCQY6VdnukL7Q7H6Ttz
 uWHBNo1VovNV9k9oCvGrHzMCWgX4854=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010239
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-303885-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9A2A6F21B1

After aggressive ethtool -L cycling, PHYP can leave a VALID RX descriptor
with a correlator that no longer matches the per-queue buffer pools. Poll
treated this as fatal: ibmveth_rxq_get_buffer() WARNed and returned NULL
without advancing the ring, then restart_poll retried the same slot forever.

Advance past bad correlators instead of spinning: validate correlators
without WARN_ON, skip invalid slots in poll (count as invalid_buffers),
and advance the RX ring when remove_buffer_from_pool cannot map the
correlator. Rate-limit the bad correlator message.

Complete NAPI when the interface is down or napi_disable is pending so
ibmveth_cleanup_rx_interrupts() can finish. Do not restart_poll in that
window. Close keeps hypervisor IRQ disable before napi_disable (via
cleanup_rx_interrupts()).

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 76 ++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 50a332ab83fd..d7bf01271161 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -158,6 +158,25 @@ static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter,
 	return be32_to_cpu(rxq->queue_addr[rxq->index].length);
 }
 
+static inline bool
+ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter, int queue_index,
+			     u64 correlator)
+{
+	unsigned int pool = correlator >> 32;
+	unsigned int index = correlator & 0xffffffffUL;
+
+	return pool < IBMVETH_NUM_BUFF_POOLS &&
+	       index < adapter->rx_buff_pool[queue_index][pool].size;
+}
+
+static inline void ibmveth_rxq_advance(struct ibmveth_rx_q *rxq)
+{
+	if (++rxq->index == rxq->num_slots) {
+		rxq->index = 0;
+		rxq->toggle = !rxq->toggle;
+	}
+}
+
 static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter,
 					int queue_index)
 {
@@ -1284,17 +1303,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	unsigned int free_index;
 	struct sk_buff *skb;
 
-	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[queue_index][pool].size)) {
-		schedule_work(&adapter->work);
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
 		return -EINVAL;
-	}
 
 	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
-	if (WARN_ON(!skb)) {
-		schedule_work(&adapter->work);
+	if (!skb)
 		return -EFAULT;
-	}
 
 	/* if we are going to reuse the buffer then keep the pointers around
 	 * but mark index as available. replenish will see the skb pointer and
@@ -1335,11 +1349,8 @@ static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *ada
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 
-	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[queue_index][pool].size)) {
-		schedule_work(&adapter->work);
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
 		return NULL;
-	}
 
 	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 }
@@ -1365,14 +1376,15 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 
 	cor = rxq->queue_addr[rxq->index].correlator;
 	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
-	if (unlikely(rc))
+	if (unlikely(rc)) {
+		if (rc == -EINVAL || rc == -EFAULT)
+			goto advance;
 		return rc;
-
-	if (++rxq->index == rxq->num_slots) {
-		rxq->index = 0;
-		rxq->toggle = !rxq->toggle;
 	}
 
+advance:
+	ibmveth_rxq_advance(rxq);
+
 	return 0;
 }
 
@@ -2931,11 +2943,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
 		return 0;
 
+	if (!netif_running(netdev) || napi_disable_pending(napi)) {
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
 	if (adapter->rx_qstats)
 		adapter->rx_qstats[queue_index].polls++;
 
 restart_poll:
 	while (frames_processed < budget) {
+		if (!netif_running(netdev) || napi_disable_pending(napi))
+			break;
+
 		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
 			break;
 
@@ -2959,8 +2979,21 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			__sum16 iph_check = 0;
 
 			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
-			if (unlikely(!skb))
-				break;
+			if (unlikely(!skb)) {
+				if (net_ratelimit())
+					netdev_err(netdev,
+						   "bad correlator on queue %d, skipping slot\n",
+						   queue_index);
+				if (adapter->rx_qstats)
+					adapter->rx_qstats[queue_index].invalid_buffers++;
+				else
+					adapter->rx_invalid_buffer++;
+				rc = ibmveth_rxq_harvest_buffer(adapter, queue_index,
+								true);
+				if (unlikely(rc))
+					break;
+				continue;
+			}
 
 			/* if the large packet bit is set in the rx queue
 			 * descriptor, the mss will be written by PHYP eight
@@ -3034,8 +3067,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 	ibmveth_replenish_task(adapter, queue_index);
 
-	if (frames_processed == budget)
+	if (frames_processed == budget) {
+		if (!netif_running(netdev) || napi_disable_pending(napi))
+			napi_complete_done(napi, frames_processed);
 		goto out;
+	}
 
 	if (!napi_complete_done(napi, frames_processed))
 		goto out;
@@ -3053,6 +3089,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
+	    netif_running(netdev) &&
+	    !napi_disable_pending(napi) &&
 	    napi_schedule(napi)) {
 		lpar_rc = ibmveth_disable_irq(adapter, queue_index);
 		WARN_ON(lpar_rc != H_SUCCESS);
-- 
2.39.3 (Apple Git-146)


