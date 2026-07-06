Return-Path: <netdev+bounces-305206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B8G8BtgDTGorewEAu9opvQ
	(envelope-from <netdev+bounces-305206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:36:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 863987150C1
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:36:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=bK5OouJR;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305206-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305206-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44CA7301DDB7
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 19:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD00332604;
	Mon,  6 Jul 2026 19:36:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864F3254A8
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 19:36:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366602; cv=none; b=GV+rBsDdaqDiKvFCsi5z6adF+vVNnYy6J6+4FyzhHPf3mC4L9mprU+1x4SzvlOMCTlIoU3OFgwsfcV9WW59aE0W9SkMV0elBbFj15ygy5MdGBI6wADeMcglKuD8nvhBmTGnYTGys5JNkkEl0gmqtBPly5UmoFn7If7/lksY7U9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366602; c=relaxed/simple;
	bh=cQmwiqZcqC8hTLhqy04lRPbArXuiHcevPIl1Em8gRGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vDJt0GS5DgcnmbNiAbQQszG1L/av+nPTKDr/Wz/FCIhr13otlmnxx+zMy4ppnhIuI4AeGop0Ow6sJSWUpOafu0eUWweKms+C1WziDazc1xflHWVm1ua+vgTXqCWoY/3cQtqgZT4yuh3bhwkNA8ulRFsHUjUxRuDLgdlVl1uG5+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bK5OouJR; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FICsv611138;
	Mon, 6 Jul 2026 19:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n7Tl/fgpr4jkCK2rY
	cRWtLni/ogRtB/n39Wsx1nXij4=; b=bK5OouJRcEOk5wWKL4J0wmXIMrs0RrRHr
	tH3KjDrwWMZx4m/CK3GKilBNHj1nDKm6r92LDtALUejDOq3KyJmP2e90bSPD/Th/
	yoJuPhFCK+ycUlnOyC0Gi4odVe1hWRiEHMLpbTHq5roInnHFD2418bWA4pwztuwI
	gPD1cq0a6DbYeDzhUHmXnt2iN3S1bSvFqKBAJNFhuiacdDa9WMgn4/tdqRllwkID
	vPcjPEdlOkNvrZ+h9znpvQmhFkxFteV+TTuNGsLXd7+bZnQikZRG1l2sPl6HVeA7
	4sTMjYdcMQ1D86RVyi6z9IpdG50oqnG3HO4wfYQVMLOs+ecTz9PTA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3k59n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYYEG012862;
	Mon, 6 Jul 2026 19:36:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xxmuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666JZppb9044494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:35:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C23F58051;
	Mon,  6 Jul 2026 19:36:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 530E45805E;
	Mon,  6 Jul 2026 19:36:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:24 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 02/15] ibmveth: Prepare MQ RX adapter and statistics structures
Date: Mon,  6 Jul 2026 12:35:50 -0700
Message-Id: <20260706193603.8039-3-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4c03bc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=QE-ohLIOIhamx8bXbI0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfXwJg+7dWcQJS0
 i7A1chvrRIONDW943aaaZB3GiP/DEVL5jVFM9X6mYx9dNUow0hO2r+1IvCOlXCPzSxeE5DOuNn7
 ky88VwgF4ENt0AuMOUTi5SDJNJOjUIU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX7dx830taYwFF
 eKvE4/P9ruiIpuXv8nyUUZJmZkSiC1KAzbvOVjGI644QIibkp9Vttak2idF6Op7rP+BQYA0Cd4P
 CkCgEKQx4voH1oLpillQsa/txvaebofugIm2xt0kUjXi+nHCQSbi8GRclZFWg4AOVoaJ7fG3UFd
 GT3QnnVm3uIgX5uGTDPV19+sL/vGQ3HZ8dU879i2k7PJ2rKqsMwgCLFfVBVZH/VcgMg62Mm7oLq
 WApOGdhu7lRsFOdlbyPh7FaG4Nx/gBpxXiBw8YSnL9SkuC9Ap4SCJ7Ae783pOB2759a4R8F8npa
 488Bzimq6SSzPzeXJyTbDPYzp2pkAmMOHoIu3s+lBlX0abCKN1gz58wcf8CkRl5oBP+8c9O+eU2
 nsiNvdlEV2I/e/2XWlNpfChFdSWc0WPW6ZvZRGzUeaDTYQPiGUG/iI9TI5MB8i504VPVQaFFMra
 8ygjHnjguLwAHII+53Q==
X-Proofpoint-ORIG-GUID: 5HfFgOHzuFEXVxVUz6sdG0EQLaxVmATP
X-Proofpoint-GUID: ooerC1jmvbzIPijRNnXWOIH4IHLycyNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060195
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-305206-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 863987150C1

Extend ibmveth_adapter for multi-queue RX: per-queue buffer pools,
queue handles, NAPI/IRQ arrays, and MQ capability flags. Add
rx_qstats[] layout and related constants for per-queue statistics
(reporting wired in a later patch).

No runtime behaviour change; num_rx_queues remains 1 until the MQ
receive path is enabled.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 222 +++++++++++++++++------------
 drivers/net/ethernet/ibm/ibmveth.h |  45 +++++-
 2 files changed, 168 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index af287eeafc0c..8f9f927bff23 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -101,7 +101,7 @@ static struct ibmveth_stat ibmveth_stats[] = {
 /* simple methods of getting data from the current rxq entry */
 static inline u32 ibmveth_rxq_flags(struct ibmveth_adapter *adapter)
 {
-	return be32_to_cpu(adapter->rx_queue.queue_addr[adapter->rx_queue.index].flags_off);
+	return be32_to_cpu(adapter->rx_queue[0].queue_addr[adapter->rx_queue[0].index].flags_off);
 }
 
 static inline int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter)
@@ -112,7 +112,7 @@ static inline int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter)
 
 static inline int ibmveth_rxq_pending_buffer(struct ibmveth_adapter *adapter)
 {
-	return ibmveth_rxq_toggle(adapter) == adapter->rx_queue.toggle;
+	return ibmveth_rxq_toggle(adapter) == adapter->rx_queue[0].toggle;
 }
 
 static inline int ibmveth_rxq_buffer_valid(struct ibmveth_adapter *adapter)
@@ -132,7 +132,7 @@ static inline int ibmveth_rxq_large_packet(struct ibmveth_adapter *adapter)
 
 static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter)
 {
-	return be32_to_cpu(adapter->rx_queue.queue_addr[adapter->rx_queue.index].length);
+	return be32_to_cpu(adapter->rx_queue[0].queue_addr[adapter->rx_queue[0].index].length);
 }
 
 static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter)
@@ -386,7 +386,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
  */
 static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 {
-	__be64 *p = adapter->buffer_list_addr + 4096 - 8;
+	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
 
 	adapter->rx_no_buffer = be64_to_cpup(p);
 }
@@ -399,7 +399,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
 	adapter->replenish_task_cycles++;
 
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
-		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[i];
+		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
 
 		if (pool->active &&
 		    (atomic_read(&pool->available) < pool->threshold))
@@ -463,12 +463,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	struct sk_buff *skb;
 
 	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[pool].size)) {
+	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
 		schedule_work(&adapter->work);
 		return -EINVAL;
 	}
 
-	skb = adapter->rx_buff_pool[pool].skbuff[index];
+	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
 	if (WARN_ON(!skb)) {
 		schedule_work(&adapter->work);
 		return -EFAULT;
@@ -482,24 +482,24 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 		/* remove the skb pointer to mark free. actual freeing is done
 		 * by upper level networking after gro_receive
 		 */
-		adapter->rx_buff_pool[pool].skbuff[index] = NULL;
+		adapter->rx_buff_pool[0][pool].skbuff[index] = NULL;
 
 		dma_unmap_single(&adapter->vdev->dev,
-				 adapter->rx_buff_pool[pool].dma_addr[index],
-				 adapter->rx_buff_pool[pool].buff_size,
+				 adapter->rx_buff_pool[0][pool].dma_addr[index],
+				 adapter->rx_buff_pool[0][pool].buff_size,
 				 DMA_FROM_DEVICE);
 	}
 
-	free_index = adapter->rx_buff_pool[pool].producer_index;
-	adapter->rx_buff_pool[pool].producer_index++;
-	if (adapter->rx_buff_pool[pool].producer_index >=
-	    adapter->rx_buff_pool[pool].size)
-		adapter->rx_buff_pool[pool].producer_index = 0;
-	adapter->rx_buff_pool[pool].free_map[free_index] = index;
+	free_index = adapter->rx_buff_pool[0][pool].producer_index;
+	adapter->rx_buff_pool[0][pool].producer_index++;
+	if (adapter->rx_buff_pool[0][pool].producer_index >=
+	    adapter->rx_buff_pool[0][pool].size)
+		adapter->rx_buff_pool[0][pool].producer_index = 0;
+	adapter->rx_buff_pool[0][pool].free_map[free_index] = index;
 
 	mb();
 
-	atomic_dec(&(adapter->rx_buff_pool[pool].available));
+	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
 
 	return 0;
 }
@@ -507,17 +507,17 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 /* get the current buffer on the rx queue */
 static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
 {
-	u64 correlator = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
+	u64 correlator = adapter->rx_queue[0].queue_addr[adapter->rx_queue[0].index].correlator;
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 
 	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[pool].size)) {
+	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
 		schedule_work(&adapter->work);
 		return NULL;
 	}
 
-	return adapter->rx_buff_pool[pool].skbuff[index];
+	return adapter->rx_buff_pool[0][pool].skbuff[index];
 }
 
 /**
@@ -538,14 +538,14 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 	u64 cor;
 	int rc;
 
-	cor = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
+	cor = adapter->rx_queue[0].queue_addr[adapter->rx_queue[0].index].correlator;
 	rc = ibmveth_remove_buffer_from_pool(adapter, cor, reuse);
 	if (unlikely(rc))
 		return rc;
 
-	if (++adapter->rx_queue.index == adapter->rx_queue.num_slots) {
-		adapter->rx_queue.index = 0;
-		adapter->rx_queue.toggle = !adapter->rx_queue.toggle;
+	if (++adapter->rx_queue[0].index == adapter->rx_queue[0].num_slots) {
+		adapter->rx_queue[0].index = 0;
+		adapter->rx_queue[0].toggle = !adapter->rx_queue[0].toggle;
 	}
 
 	return 0;
@@ -596,7 +596,7 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	 */
 retry:
 	rc = h_register_logical_lan(adapter->vdev->unit_address,
-				    adapter->buffer_list_dma, rxq_desc.desc,
+				    adapter->buffer_list_dma[0], rxq_desc.desc,
 				    adapter->filter_list_dma, mac_address);
 
 	if (rc != H_SUCCESS && try_again) {
@@ -611,6 +611,33 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	return rc;
 }
 
+/**
+ * ibmveth_alloc_rx_qstats - Allocate per-queue RX statistics
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int __maybe_unused ibmveth_alloc_rx_qstats(struct ibmveth_adapter *adapter)
+{
+	adapter->rx_qstats = kcalloc(IBMVETH_MAX_RX_QUEUES,
+				     sizeof(struct ibmveth_rx_queue_stats),
+				     GFP_KERNEL);
+	if (!adapter->rx_qstats)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_rx_qstats - Free per-queue RX statistics
+ * @adapter: ibmveth adapter structure
+ */
+static void __maybe_unused ibmveth_free_rx_qstats(struct ibmveth_adapter *adapter)
+{
+	kfree(adapter->rx_qstats);
+	adapter->rx_qstats = NULL;
+}
+
 static int ibmveth_open(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
@@ -624,14 +651,14 @@ static int ibmveth_open(struct net_device *netdev)
 
 	netdev_dbg(netdev, "open starting\n");
 
-	napi_enable(&adapter->napi);
+	napi_enable(&adapter->napi[0]);
 
 	for(i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		rxq_entries += adapter->rx_buff_pool[i].size;
+		rxq_entries += adapter->rx_buff_pool[0][i].size;
 
 	rc = -ENOMEM;
-	adapter->buffer_list_addr = (void*) get_zeroed_page(GFP_KERNEL);
-	if (!adapter->buffer_list_addr) {
+	adapter->buffer_list_addr[0] = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!adapter->buffer_list_addr[0]) {
 		netdev_err(netdev, "unable to allocate list pages\n");
 		goto out;
 	}
@@ -644,17 +671,18 @@ static int ibmveth_open(struct net_device *netdev)
 
 	dev = &adapter->vdev->dev;
 
-	adapter->rx_queue.queue_len = sizeof(struct ibmveth_rx_q_entry) *
+	adapter->rx_queue[0].queue_len = sizeof(struct ibmveth_rx_q_entry) *
 						rxq_entries;
-	adapter->rx_queue.queue_addr =
-		dma_alloc_coherent(dev, adapter->rx_queue.queue_len,
-				   &adapter->rx_queue.queue_dma, GFP_KERNEL);
-	if (!adapter->rx_queue.queue_addr)
+	adapter->rx_queue[0].queue_addr =
+		dma_alloc_coherent(dev, adapter->rx_queue[0].queue_len,
+				   &adapter->rx_queue[0].queue_dma, GFP_KERNEL);
+	if (!adapter->rx_queue[0].queue_addr)
 		goto out_free_filter_list;
 
-	adapter->buffer_list_dma = dma_map_single(dev,
-			adapter->buffer_list_addr, 4096, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev, adapter->buffer_list_dma)) {
+	adapter->buffer_list_dma[0] = dma_map_single(dev,
+						     adapter->buffer_list_addr[0],
+						     4096, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, adapter->buffer_list_dma[0])) {
 		netdev_err(netdev, "unable to map buffer list pages\n");
 		goto out_free_queue_mem;
 	}
@@ -671,19 +699,19 @@ static int ibmveth_open(struct net_device *netdev)
 			goto out_free_tx_ltb;
 	}
 
-	adapter->rx_queue.index = 0;
-	adapter->rx_queue.num_slots = rxq_entries;
-	adapter->rx_queue.toggle = 1;
+	adapter->rx_queue[0].index = 0;
+	adapter->rx_queue[0].num_slots = rxq_entries;
+	adapter->rx_queue[0].toggle = 1;
 
 	mac_address = ether_addr_to_u64(netdev->dev_addr);
 
 	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
-					adapter->rx_queue.queue_len;
-	rxq_desc.fields.address = adapter->rx_queue.queue_dma;
+					adapter->rx_queue[0].queue_len;
+	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
 
-	netdev_dbg(netdev, "buffer list @ 0x%p\n", adapter->buffer_list_addr);
+	netdev_dbg(netdev, "buffer list @ 0x%p\n", adapter->buffer_list_addr[0]);
 	netdev_dbg(netdev, "filter list @ 0x%p\n", adapter->filter_list_addr);
-	netdev_dbg(netdev, "receive q   @ 0x%p\n", adapter->rx_queue.queue_addr);
+	netdev_dbg(netdev, "receive q   @ 0x%p\n", adapter->rx_queue[0].queue_addr);
 
 	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
 
@@ -694,7 +722,7 @@ static int ibmveth_open(struct net_device *netdev)
 			   lpar_rc);
 		netdev_err(netdev, "buffer TCE:0x%llx filter TCE:0x%llx rxq "
 			   "desc:0x%llx MAC:0x%llx\n",
-				     adapter->buffer_list_dma,
+				     adapter->buffer_list_dma[0],
 				     adapter->filter_list_dma,
 				     rxq_desc.desc,
 				     mac_address);
@@ -703,11 +731,11 @@ static int ibmveth_open(struct net_device *netdev)
 	}
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		if (!adapter->rx_buff_pool[i].active)
+		if (!adapter->rx_buff_pool[0][i].active)
 			continue;
-		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[i])) {
+		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
 			netdev_err(netdev, "unable to alloc pool\n");
-			adapter->rx_buff_pool[i].active = 0;
+			adapter->rx_buff_pool[0][i].active = 0;
 			rc = -ENOMEM;
 			goto out_free_buffer_pools;
 		}
@@ -739,9 +767,9 @@ static int ibmveth_open(struct net_device *netdev)
 
 out_free_buffer_pools:
 	while (--i >= 0) {
-		if (adapter->rx_buff_pool[i].active)
+		if (adapter->rx_buff_pool[0][i].active)
 			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[i]);
+						 &adapter->rx_buff_pool[0][i]);
 	}
 out_unmap_filter_list:
 	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
@@ -753,18 +781,18 @@ static int ibmveth_open(struct net_device *netdev)
 	}
 
 out_unmap_buffer_list:
-	dma_unmap_single(dev, adapter->buffer_list_dma, 4096,
+	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
 			 DMA_BIDIRECTIONAL);
 out_free_queue_mem:
-	dma_free_coherent(dev, adapter->rx_queue.queue_len,
-			  adapter->rx_queue.queue_addr,
-			  adapter->rx_queue.queue_dma);
+	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
+			  adapter->rx_queue[0].queue_addr,
+			  adapter->rx_queue[0].queue_dma);
 out_free_filter_list:
 	free_page((unsigned long)adapter->filter_list_addr);
 out_free_buffer_list:
-	free_page((unsigned long)adapter->buffer_list_addr);
+	free_page((unsigned long)adapter->buffer_list_addr[0]);
 out:
-	napi_disable(&adapter->napi);
+	napi_disable(&adapter->napi[0]);
 	return rc;
 }
 
@@ -777,7 +805,7 @@ static int ibmveth_close(struct net_device *netdev)
 
 	netdev_dbg(netdev, "close starting\n");
 
-	napi_disable(&adapter->napi);
+	napi_disable(&adapter->napi[0]);
 
 	netif_tx_stop_all_queues(netdev);
 
@@ -796,22 +824,22 @@ static int ibmveth_close(struct net_device *netdev)
 
 	ibmveth_update_rx_no_buffer(adapter);
 
-	dma_unmap_single(dev, adapter->buffer_list_dma, 4096,
+	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
 			 DMA_BIDIRECTIONAL);
-	free_page((unsigned long)adapter->buffer_list_addr);
+	free_page((unsigned long)adapter->buffer_list_addr[0]);
 
 	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
 			 DMA_BIDIRECTIONAL);
 	free_page((unsigned long)adapter->filter_list_addr);
 
-	dma_free_coherent(dev, adapter->rx_queue.queue_len,
-			  adapter->rx_queue.queue_addr,
-			  adapter->rx_queue.queue_dma);
+	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
+			  adapter->rx_queue[0].queue_addr,
+			  adapter->rx_queue[0].queue_dma);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		if (adapter->rx_buff_pool[i].active)
+		if (adapter->rx_buff_pool[0][i].active)
 			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[i]);
+						 &adapter->rx_buff_pool[0][i]);
 
 	for (i = 0; i < netdev->real_num_tx_queues; i++)
 		ibmveth_free_tx_ltb(adapter, i);
@@ -1449,7 +1477,7 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 static int ibmveth_poll(struct napi_struct *napi, int budget)
 {
 	struct ibmveth_adapter *adapter =
-			container_of(napi, struct ibmveth_adapter, napi);
+			container_of(napi, struct ibmveth_adapter, napi[0]);
 	struct net_device *netdev = adapter->netdev;
 	int frames_processed = 0;
 	unsigned long lpar_rc;
@@ -1574,11 +1602,11 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	unsigned long lpar_rc;
 
-	if (napi_schedule_prep(&adapter->napi)) {
+	if (napi_schedule_prep(&adapter->napi[0])) {
 		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
 				       VIO_IRQ_DISABLE);
 		WARN_ON(lpar_rc != H_SUCCESS);
-		__napi_schedule(&adapter->napi);
+		__napi_schedule(&adapter->napi[0]);
 	}
 	return IRQ_HANDLED;
 }
@@ -1646,7 +1674,7 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 	int need_restart = 0;
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size)
+		if (new_mtu_oh <= adapter->rx_buff_pool[0][i].buff_size)
 			break;
 
 	if (i == IBMVETH_NUM_BUFF_POOLS)
@@ -1661,9 +1689,9 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 
 	/* Look for an active buffer pool that can hold the new MTU */
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		adapter->rx_buff_pool[i].active = 1;
+		adapter->rx_buff_pool[0][i].active = 1;
 
-		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size) {
+		if (new_mtu_oh <= adapter->rx_buff_pool[0][i].buff_size) {
 			WRITE_ONCE(dev->mtu, new_mtu);
 			vio_cmo_set_dev_desired(viodev,
 						ibmveth_get_desired_dma
@@ -1721,12 +1749,12 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 		/* add the size of the active receive buffers */
-		if (adapter->rx_buff_pool[i].active)
+		if (adapter->rx_buff_pool[0][i].active)
 			ret +=
-			    adapter->rx_buff_pool[i].size *
-			    IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[i].
+			    adapter->rx_buff_pool[0][i].size *
+			    IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[0][i].
 					     buff_size, tbl);
-		rxqentries += adapter->rx_buff_pool[i].size;
+		rxqentries += adapter->rx_buff_pool[0][i].size;
 	}
 	/* add the size of the receive queue entries */
 	ret += IOMMU_PAGE_ALIGN(
@@ -1845,7 +1873,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	ibmveth_init_link_settings(netdev);
 
-	netif_napi_add_weight(netdev, &adapter->napi, ibmveth_poll, 16);
+	netif_napi_add_weight(netdev, &adapter->napi[0], ibmveth_poll, 16);
 
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmveth_netdev_ops;
@@ -1877,6 +1905,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		netdev->features |= NETIF_F_FRAGLIST;
 	}
 
+	/* Initialize queue count - always 1 for now */
+	adapter->multi_queue = 0;
+	adapter->num_rx_queues = 1;
+
 	if (ret == H_SUCCESS &&
 	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
 		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
@@ -1899,10 +1931,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		memcpy(pool_count, pool_count_cmo, sizeof(pool_count));
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		struct kobject *kobj = &adapter->rx_buff_pool[i].kobj;
+		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
 		int error;
 
-		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
+		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
 		error = kobject_init_and_add(kobj, &ktype_veth_pool,
@@ -1950,7 +1982,7 @@ static void ibmveth_remove(struct vio_dev *dev)
 	cancel_work_sync(&adapter->work);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		kobject_put(&adapter->rx_buff_pool[i].kobj);
+		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
 
 	unregister_netdev(netdev);
 
@@ -2036,11 +2068,11 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 			/* Make sure there is a buffer pool with buffers that
 			   can hold a packet of the size of the MTU */
 			for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-				if (pool == &adapter->rx_buff_pool[i])
+				if (pool == &adapter->rx_buff_pool[0][i])
 					continue;
-				if (!adapter->rx_buff_pool[i].active)
+				if (!adapter->rx_buff_pool[0][i].active)
 					continue;
-				if (mtu <= adapter->rx_buff_pool[i].buff_size)
+				if (mtu <= adapter->rx_buff_pool[0][i].buff_size)
 					break;
 			}
 
@@ -2214,11 +2246,11 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 
 	/* Set sane values for buffer pools */
 	for (int i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
+		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
 
-	pool = &adapter->rx_buff_pool[0];
+	pool = &adapter->rx_buff_pool[0][0];
 	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
 
@@ -2226,7 +2258,7 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
 
-	correlator = ((u64)0 << 32) | adapter->rx_buff_pool[0].size;
+	correlator = ((u64)0 << 32) | adapter->rx_buff_pool[0][0].size;
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
 
@@ -2259,30 +2291,32 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 
 	INIT_WORK(&adapter->work, ibmveth_reset_kunit);
 
-	adapter->rx_queue.queue_len = 1;
-	adapter->rx_queue.index = 0;
-	adapter->rx_queue.queue_addr = kunit_kzalloc(test, sizeof(struct ibmveth_rx_q_entry),
-						     GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter->rx_queue.queue_addr);
+	adapter->rx_queue[0].queue_len = 1;
+	adapter->rx_queue[0].index = 0;
+	adapter->rx_queue[0].queue_addr =
+		kunit_kzalloc(test, sizeof(struct ibmveth_rx_q_entry),
+			      GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter->rx_queue[0].queue_addr);
 
 	/* Set sane values for buffer pools */
 	for (int i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
+		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
 
-	pool = &adapter->rx_buff_pool[0];
+	pool = &adapter->rx_buff_pool[0][0];
 	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
 
-	adapter->rx_queue.queue_addr[0].correlator = (u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
+	adapter->rx_queue[0].queue_addr[0].correlator = (u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
 	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
 
-	adapter->rx_queue.queue_addr[0].correlator = (u64)0 << 32 | adapter->rx_buff_pool[0].size;
+	adapter->rx_queue[0].queue_addr[0].correlator =
+		(u64)0 << 32 | adapter->rx_buff_pool[0][0].size;
 	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
 
 	pool->skbuff[0] = skb;
-	adapter->rx_queue.queue_addr[0].correlator = (u64)0 << 32 | 0;
+	adapter->rx_queue[0].queue_addr[0].correlator = (u64)0 << 32 | 0;
 	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter));
 
 	flush_work(&adapter->work);
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 45cfb0d054e3..f0dffe42e8fe 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -279,6 +279,8 @@ static inline long h_illan_attributes(unsigned long unit_address,
 #define IBMVETH_MAX_TX_BUF_SIZE (1024 * 64)
 #define IBMVETH_MAX_QUEUES 16U
 #define IBMVETH_DEFAULT_QUEUES 8U
+#define IBMVETH_MAX_RX_QUEUES 1U
+#define IBMVETH_DEFAULT_RX_QUEUES 1U
 #define IBMVETH_MAX_RX_PER_HCALL 8U
 
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
@@ -288,6 +290,30 @@ static int pool_active[] = { 1, 1, 0, 0, 1};
 
 #define IBM_VETH_INVALID_MAP ((u16)0xffff)
 
+struct ibmveth_hcall_stats {
+	u64 reg_lan_queue;	/* H_REG_LOGICAL_LAN_QUEUE */
+	u64 reg_lan;		/* H_REGISTER_LOGICAL_LAN */
+	u64 add_bufs_queue;	/* H_ADD_LOGICAL_LAN_BUFFERS_QUEUE */
+	u64 add_bufs;		/* H_ADD_LOGICAL_LAN_BUFFERS */
+	u64 add_buf;		/* H_ADD_LOGICAL_LAN_BUFFER */
+	u64 free_lan_queue;	/* H_FREE_LOGICAL_LAN_QUEUE */
+	u64 free_lan;		/* H_FREE_LOGICAL_LAN */
+	u64 send_lan;		/* H_SEND_LOGICAL_LAN */
+};
+
+struct ibmveth_rx_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 interrupts;
+	u64 polls;
+	u64 large_packets;
+	u64 invalid_buffers;
+	u64 no_buffer_drops;
+};
+
+#define IBMVETH_NUM_RX_QSTATS \
+	(sizeof(struct ibmveth_rx_queue_stats) / sizeof(u64))
+
 struct ibmveth_buff_pool {
     u32 size;
     u32 index;
@@ -315,18 +341,22 @@ struct ibmveth_rx_q {
 struct ibmveth_adapter {
 	struct vio_dev *vdev;
 	struct net_device *netdev;
-	struct napi_struct napi;
+	struct napi_struct napi[IBMVETH_MAX_RX_QUEUES];
 	struct work_struct work;
 	unsigned int mcastFilterSize;
-	void *buffer_list_addr;
+	void *buffer_list_addr[IBMVETH_MAX_RX_QUEUES];
 	void *filter_list_addr;
 	void *tx_ltb_ptr[IBMVETH_MAX_QUEUES];
 	unsigned int tx_ltb_size;
 	dma_addr_t tx_ltb_dma[IBMVETH_MAX_QUEUES];
-	dma_addr_t buffer_list_dma;
+	dma_addr_t buffer_list_dma[IBMVETH_MAX_RX_QUEUES];
 	dma_addr_t filter_list_dma;
-	struct ibmveth_buff_pool rx_buff_pool[IBMVETH_NUM_BUFF_POOLS];
-	struct ibmveth_rx_q rx_queue;
+	struct ibmveth_buff_pool rx_buff_pool[IBMVETH_MAX_RX_QUEUES][IBMVETH_NUM_BUFF_POOLS];
+	struct ibmveth_rx_q rx_queue[IBMVETH_MAX_RX_QUEUES];
+	u64 queue_handle[IBMVETH_MAX_RX_QUEUES];
+	unsigned int queue_irq[IBMVETH_MAX_RX_QUEUES];
+	int multi_queue;
+	unsigned int num_rx_queues;
 	int rx_csum;
 	int large_send;
 	bool is_active_trunk;
@@ -346,6 +376,11 @@ struct ibmveth_adapter {
 	u64 tx_send_failed;
 	u64 tx_large_packets;
 	u64 rx_large_packets;
+
+	/* Multi-queue statistics */
+	struct ibmveth_hcall_stats hcall_stats;
+	struct ibmveth_rx_queue_stats *rx_qstats;
+
 	/* Ethtool settings */
 	u8 duplex;
 	u32 speed;
-- 
2.39.3 (Apple Git-146)


