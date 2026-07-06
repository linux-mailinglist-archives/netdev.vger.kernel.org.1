Return-Path: <netdev+bounces-305219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m28sATAETGpWewEAu9opvQ
	(envelope-from <netdev+bounces-305219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:38:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 946AF715125
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:38:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=Q7mt0RyC;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305219-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305219-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C7F1303B9DC
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 19:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D8332604;
	Mon,  6 Jul 2026 19:37:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A42B3382F9
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 19:37:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366643; cv=none; b=Bw2ybuE5jgSaGlrGwIcF4RyrIRf/da0BW15S4MeZG0jud/E07hE5psi0uzy/dX3bvgLhpn1QUTLaU4GVmXX++PMSKA5eRgpNaKtVGqTJqAE4/2wkDW6hILeleTpSsruimHqSt5ULPktRRwRxPNnRji4pdOOCu1qXmIGenJ4UHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366643; c=relaxed/simple;
	bh=y0bk/aU4nsGAjaofbYibxdJOcu3T4PIgKqyY5zRlwNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l/evixmj9GQlOaJNjJOD3fkyAvP6U6CQqjRpvoNSGkp+N+sZfiXtD9CMMnU6c/gM9dRP7w/p3F6MvOzAc7Pz4KwNhqPVR182fv53ONb+Mm1QwIjzAzqrb0cjx5yAtcs9Fpq1Ql6Atub+r3C4gCg2vTVi8GiPrgkIvBOk/wbeclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q7mt0RyC; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FImaN756594;
	Mon, 6 Jul 2026 19:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SedQovSKo0iXXIEGL
	3BVsBeZfUvpUMRZBWUxAwaWICs=; b=Q7mt0RyCRxGUOXQDcSeu7gu5BdWmnXp8p
	znB1QyezuXM0ML0yQNbg6vSXU+w7aR+QHv9mYNQp6ZeQWVYo1d+aZ/yhnPe5zooT
	yZ9j6B9729z90bagEZ891bfEYTh0pg37uvcmHt2h5apn6GeaVPo6Tt2YhPitQJou
	6gQaPsb2lp0tjB0SfRBRSaTUgoDU/TfgU28zru80B5HGIeE4leCXMWoxrzzpFsWS
	GFA3jFn1VHgB4cHHlGvLgB3V17jvYgu0fW7YBWV0IAwZE3Mra35jyQ+kfPkodkKF
	7uBM/lFhIR0TAnKvPi1CVUPCr8npgPmuNdoGD0RFh+CMemqz1+DIw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknb5fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:37:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYZ1j022409;
	Mon, 6 Jul 2026 19:37:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvy4cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:37:08 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666Jb6jt33554900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:37:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A788E5805A;
	Mon,  6 Jul 2026 19:37:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7473058051;
	Mon,  6 Jul 2026 19:37:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:37:05 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 15/15] ibmveth: Fix MQ RX poll and shutdown hangs after queue resize
Date: Mon,  6 Jul 2026 12:36:03 -0700
Message-Id: <20260706193603.8039-16-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260706193603.8039-1-mmc@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4c03e5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=H2PsU0_gVjd1cLIlZ3YA:9
X-Proofpoint-GUID: pVluUtutbhXUwmnsEBFF9t0Jju90rufz
X-Proofpoint-ORIG-GUID: dc0hHG4mDYCju6j0AtPGL5vZEv_dP1wr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX9THXSo46uER0
 wZWjxuQXwL590qZmx0qbQpz/3tx6gyhiSo/BE///kXDJumKOOcDb9quPF89ebtrKFGz7iyBzE6k
 j1pKd9LGvQwGEN6k03EyoI0zAopuhOU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX8+c8rf1QuEsz
 gvNSBEkFbgY5ObYGVo43ZW895xoxLKecqB4clEnf4ZBg0l+crWWpQ12xKeEa0GCOFUxzaFi3AEQ
 bEtguWItaO8FbZEU/OJaKJdiMvIsyAJgeGC9Ce7O8MOjLGbNtQlBdplmER1g7AW7+0eSxWz3tDi
 rIZ8Drgv3AoBwjMPgVhqIipx1nmAZvJaqKR1x8E1mZ3KAZ9wGdxsZB7GazdimXV+FcmPLDhi3/j
 OHIEX98mnpHpeiEIZ9aemCoUpfAqVWYYXbO6fwvWC2b6L5cv7z0wCe8YZpiC23CY39kKlAx7tOd
 1ui/66YxFayVr5/2pCU0QkZ+GmSzkH7uPNMDZ3hNoyN0owrZnbs0+e5obQ9bekRXThULakfxVQI
 dijDiC3Age307MT0CYzYnHAU7X0jAeThB6vd4yguYISVTDQKQmYKlWHRTKjkYhwpZ2b+Gh50TLI
 r0XA6hpbez17nhv0geA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060195
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-305219-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 946AF715125

After aggressive ethtool -L cycling, PHYP can leave a VALID RX descriptor
with a correlator that no longer matches the per-queue buffer pools. Poll
treated this as fatal: ibmveth_rxq_get_buffer() WARNed and returned NULL
without advancing the ring, then restart_poll retried the same slot
forever.

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
 drivers/net/ethernet/ibm/ibmveth.c | 77 ++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 50a332ab83fd..eb84b4e5f69f 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -158,6 +158,24 @@ static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter,
 	return be32_to_cpu(rxq->queue_addr[rxq->index].length);
 }
 
+static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
+					 int queue_index, u64 correlator)
+{
+	unsigned int pool = correlator >> 32;
+	unsigned int index = correlator & 0xffffffffUL;
+
+	return pool < IBMVETH_NUM_BUFF_POOLS &&
+	       index < adapter->rx_buff_pool[queue_index][pool].size;
+}
+
+static void ibmveth_rxq_advance(struct ibmveth_rx_q *rxq)
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
@@ -1284,17 +1302,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
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
@@ -1335,11 +1348,8 @@ static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *ada
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
@@ -1365,14 +1375,15 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 
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
 
@@ -2931,11 +2942,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
 
@@ -2959,8 +2978,23 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
+					adapter->rx_qstats[queue_index]
+						.invalid_buffers++;
+				else
+					adapter->rx_invalid_buffer++;
+				rc = ibmveth_rxq_harvest_buffer(adapter,
+								queue_index,
+								true);
+				if (unlikely(rc))
+					break;
+				continue;
+			}
 
 			/* if the large packet bit is set in the rx queue
 			 * descriptor, the mss will be written by PHYP eight
@@ -3034,8 +3068,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 	ibmveth_replenish_task(adapter, queue_index);
 
-	if (frames_processed == budget)
+	if (frames_processed == budget) {
+		if (!netif_running(netdev) || napi_disable_pending(napi))
+			napi_complete_done(napi, frames_processed);
 		goto out;
+	}
 
 	if (!napi_complete_done(napi, frames_processed))
 		goto out;
@@ -3053,6 +3090,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
+	    netif_running(netdev) &&
+	    !napi_disable_pending(napi) &&
 	    napi_schedule(napi)) {
 		lpar_rc = ibmveth_disable_irq(adapter, queue_index);
 		WARN_ON(lpar_rc != H_SUCCESS);
-- 
2.39.3 (Apple Git-146)


