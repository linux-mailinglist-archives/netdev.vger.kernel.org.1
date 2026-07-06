Return-Path: <netdev+bounces-305217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ubp2KFQETGpkewEAu9opvQ
	(envelope-from <netdev+bounces-305217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:39:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0577A71514B
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:39:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=I3JatWOy;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305217-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305217-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C5CA305E562
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CB83346A5;
	Mon,  6 Jul 2026 19:37:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57485332EBC
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 19:37:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366637; cv=none; b=sPKL+Y4YSubbHNduoijXQ/I6TbxCofURsbSMEPxvnunucyHA6I6GIR6DItdCmodaNZ1xszeqdltJfw+lLSnzpPeXApuloQlib9dMNVT/F0p1Z+2ZuK0y7XYFrVY9TkXhYegMG4ElqdVb8g/PHkIU3Vp46WxdXBi39LR40ONbc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366637; c=relaxed/simple;
	bh=JXk3lISAaCBqDTA3bTAqclduaoCag23J7WWI1jCxIwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AG9foo1Cov5LZWg+YP1cIVcybpx7djUF25PDXFuEqsIGwBYaaPSeMJOh35fHzfCz6zx+Qjoe/cResSY6IAkUs84JYC2HGCATHknHz3BTPJ+9qqSFTcAxl+CE+izv+4Bd8snMsi2IsH4GUrl+VqyIC8BOGsgNVO61VL2uWcVH6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I3JatWOy; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIMtO962144;
	Mon, 6 Jul 2026 19:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O0VZnHkxwYA9d9h0d
	iAgXZwSd/PIE3Dl/G5Xp1i+Z+c=; b=I3JatWOyGYjGS2HXeUdfRi03Z8A/ono1s
	J+Ny5oib6IizKjS6EkwL5cbJ9cCVGn9Nkx1BHhpHl5i6LA1DR0XRd+Tg0MOfxSe/
	OUOa8+7JSW66El6TuY6eEdo6Zmbpdktjt+wEj9azXn1WBVxwdOA5SjbDDC2+cKhx
	k1yVHwvUycQr/V86v3Lvw/U59rYYnyrkLpvrCt0Z/eC23zEKecAyzSp1Ptmj40V2
	uMT1ujoJn4zOF/a44WhVH0YzpxZXT+5/Q9TvZ57G96pzqZzH4kFPq++zH2gCjQIj
	GNdgJXrXCtD+Gm9KgZ7l/i1Mf+ZuyCBjgEIzE9Z7UpF62fIvRItag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqk0c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:37:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYcTH011475;
	Mon, 6 Jul 2026 19:37:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjxyr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:37:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666Jb1Q414811856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:37:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E12C65805C;
	Mon,  6 Jul 2026 19:37:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6B9658051;
	Mon,  6 Jul 2026 19:36:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:59 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 13/15] ibmveth: Implement incremental MQ RX queue resize
Date: Mon,  6 Jul 2026 12:36:01 -0700
Message-Id: <20260706193603.8039-14-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfXyIGtFKmGHl3C
 TcBfYGHCHVzRLWRDD9m+PRge2vVHY9xKo9e5WHBO+rVnEC2RVS06md1WCfVip1gD2Uo7CW7cVIj
 nHZyCoqu7Qe3lIgIRam3J+HFBPlP5MQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX+QnoL/5imNty
 7fTTXoSIgAg/RpuPnuidl/UXhHYiOVc5fploc4I/+wsId4EYAIDXF0Ntt2VeGzgErmXYZTMARxi
 27BbZydgbind31LUrhH7Ed9z23c3SgCq4ohL9xRZqS4FFxVqtYVK4eQTO8sPuoG2ofp5JqrOLCS
 o2IRopThyrXtVuPcR6AlmElezUIABHzOnWSCCBmxR5XQg3MvRyiWDIZlrm9EdcE0u9q0oRMMn3X
 VUXt/YKD1iBEC9gPiCXHJ3MbXqsX8p/NTeuKmdQcK9TXr5nMyf5f4vz0HDenoXbrIi0aU+fKiSE
 iq7DydrG+lx24o0ww2Ldyp5CFO1apHCIU4mGeZ+2YhUzqDcGK9UVOJIH2LrPrzRAE9jnVL8Ic6/
 xIYJ7qrqj8Pk2jK0mX2b/e1Zz1gGORMvhZtr7NsAKKnnda0pGIMqDuZGYUZZdYa4L7KjlYMnTtT
 RCSnnmorcrYaUDqA2wA==
X-Proofpoint-GUID: Yk0DdjBbvvzsI2YwCdzsn4evJkOA6s6Y
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4c03df cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=dq_cLQTfevi_Shm9ptcA:9
X-Proofpoint-ORIG-GUID: 9_as-75s7KDPTwh5yPqPcptF1UVhhNM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060195
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-305217-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0577A71514B

Add helpers to register/deregister individual RX queues and scale
queue count up or down while the netdev stays up. Surviving queues
keep PHYP handles, buffer pools, and IRQ state across resize.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 406 ++++++++++++++++++++++++++++-
 1 file changed, 401 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index ecc472ee8f71..ac4d89a66a8d 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -589,6 +589,54 @@ ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
 	adapter->queue_irq[0] = 0;
 }
 
+/**
+ * ibmveth_setup_single_rx_interrupt - Setup interrupt for a single RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to setup
+ *
+ * Registers the IRQ handler for one queue. Used during incremental
+ * scale-up when adding new RX queues; the caller enables NAPI via
+ * napi_enable() after ibmveth_enable_irq().
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_setup_single_rx_interrupt(struct ibmveth_adapter *adapter,
+				  int queue_idx)
+{
+	struct net_device *netdev = adapter->netdev;
+	int rc;
+
+	rc = request_irq(adapter->queue_irq[queue_idx], ibmveth_interrupt,
+			 0, netdev->name, &adapter->napi[queue_idx]);
+	if (rc) {
+		netdev_err(netdev, "request_irq() failed for queue %d: %d\n",
+			   queue_idx, rc);
+		return rc;
+	}
+
+	netdev_dbg(netdev, "Setup IRQ %d for queue %d\n",
+		   adapter->queue_irq[queue_idx], queue_idx);
+	return 0;
+}
+
+/**
+ * ibmveth_cleanup_single_rx_interrupt - Cleanup interrupt for a single RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to cleanup
+ *
+ * Frees the IRQ handler for one queue. Used during incremental scale-down.
+ */
+static void
+ibmveth_cleanup_single_rx_interrupt(struct ibmveth_adapter *adapter,
+				    int queue_idx)
+{
+	if (adapter->queue_irq[queue_idx]) {
+		free_irq(adapter->queue_irq[queue_idx], &adapter->napi[queue_idx]);
+		netdev_dbg(adapter->netdev, "Freed IRQ for queue %d\n", queue_idx);
+	}
+}
+
 /* setup the initial settings for a buffer pool */
 static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
 				     u32 pool_index, u32 pool_size,
@@ -897,18 +945,22 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 	unsigned long flags;
 	int i;
 
-	if (queue_index >= adapter->num_rx_queues)
-		return;
-
 	adapter->replenish_task_cycles++;
 
+	if (queue_index >= adapter->num_rx_queues) {
+		netdev_dbg(adapter->netdev,
+			   "Skipping replenish for freed queue %d (num_queues=%d)\n",
+			   queue_index, adapter->num_rx_queues);
+		return;
+	}
+
 	spin_lock_irqsave(&rxq->replenish_lock, flags);
 
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
 		struct ibmveth_buff_pool *pool =
 			&adapter->rx_buff_pool[queue_index][i];
 
-		if (pool->active &&
+		if (pool->active && pool->free_map &&
 		    (atomic_read(&pool->available) < pool->threshold))
 			ibmveth_replenish_buffer_pool(adapter, pool,
 						      queue_index);
@@ -1080,6 +1132,138 @@ static void ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
 		   adapter->num_rx_queues);
 }
 
+/**
+ * ibmveth_alloc_single_rx_queue - Allocate resources for a single RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to allocate
+ * @rxq_entries: Number of RX queue entries
+ *
+ * Allocates buffer list, RX queue, and per-queue buffer pools for one queue.
+ * Used during incremental scale-up without affecting existing queues.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_alloc_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx,
+			      int rxq_entries)
+{
+	struct device *dev = &adapter->vdev->dev;
+	struct net_device *netdev = adapter->netdev;
+	int i, rc = -ENOMEM;
+
+	adapter->buffer_list_addr[queue_idx] = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!adapter->buffer_list_addr[queue_idx]) {
+		netdev_err(netdev, "unable to allocate buffer list for queue %d\n",
+			   queue_idx);
+		return -ENOMEM;
+	}
+
+	adapter->rx_queue[queue_idx].queue_len =
+		sizeof(struct ibmveth_rx_q_entry) * rxq_entries;
+	adapter->rx_queue[queue_idx].queue_addr =
+		dma_alloc_coherent(dev, adapter->rx_queue[queue_idx].queue_len,
+				   &adapter->rx_queue[queue_idx].queue_dma,
+				   GFP_KERNEL);
+	if (!adapter->rx_queue[queue_idx].queue_addr) {
+		netdev_err(netdev, "unable to allocate RX queue for queue %d\n",
+			   queue_idx);
+		goto out_free_buflist;
+	}
+
+	adapter->buffer_list_dma[queue_idx] =
+		dma_map_single(dev, adapter->buffer_list_addr[queue_idx],
+			       4096, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, adapter->buffer_list_dma[queue_idx])) {
+		netdev_err(netdev, "unable to map buffer list for queue %d\n",
+			   queue_idx);
+		goto out_free_rxq;
+	}
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		adapter->rx_buff_pool[queue_idx][i].size =
+			adapter->rx_buff_pool[0][i].size;
+		adapter->rx_buff_pool[queue_idx][i].buff_size =
+			adapter->rx_buff_pool[0][i].buff_size;
+		adapter->rx_buff_pool[queue_idx][i].threshold =
+			adapter->rx_buff_pool[0][i].threshold;
+		adapter->rx_buff_pool[queue_idx][i].active =
+			adapter->rx_buff_pool[0][i].active;
+	}
+
+	rc = ibmveth_alloc_queue_buffer_pools(adapter, queue_idx);
+	if (rc) {
+		netdev_err(netdev,
+			   "Failed to allocate buffer pools for queue %d\n",
+			   queue_idx);
+		goto out_unmap_buflist;
+	}
+
+	adapter->rx_queue[queue_idx].index = 0;
+	adapter->rx_queue[queue_idx].num_slots = rxq_entries;
+	adapter->rx_queue[queue_idx].toggle = 1;
+	spin_lock_init(&adapter->rx_queue[queue_idx].replenish_lock);
+
+	netdev_dbg(netdev,
+		   "Allocated queue %d: buffer_list @ %p (DMA: 0x%llx), rx_queue @ %p (DMA: 0x%llx), %d entries\n",
+		   queue_idx, adapter->buffer_list_addr[queue_idx],
+		   (unsigned long long)adapter->buffer_list_dma[queue_idx],
+		   adapter->rx_queue[queue_idx].queue_addr,
+		   (unsigned long long)adapter->rx_queue[queue_idx].queue_dma,
+		   rxq_entries);
+
+	return 0;
+
+out_unmap_buflist:
+	dma_unmap_single(dev, adapter->buffer_list_dma[queue_idx],
+			 4096, DMA_BIDIRECTIONAL);
+	adapter->buffer_list_dma[queue_idx] = 0;
+out_free_rxq:
+	dma_free_coherent(dev, adapter->rx_queue[queue_idx].queue_len,
+			  adapter->rx_queue[queue_idx].queue_addr,
+			  adapter->rx_queue[queue_idx].queue_dma);
+	adapter->rx_queue[queue_idx].queue_addr = NULL;
+out_free_buflist:
+	free_page((unsigned long)adapter->buffer_list_addr[queue_idx]);
+	adapter->buffer_list_addr[queue_idx] = NULL;
+	return rc;
+}
+
+/**
+ * ibmveth_free_single_rx_queue - Free resources for a single RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to free
+ *
+ * Frees buffer list, RX queue, and per-queue buffer pools for one queue.
+ * Used during incremental scale-down without affecting remaining queues.
+ */
+static void
+ibmveth_free_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx)
+{
+	struct device *dev = &adapter->vdev->dev;
+
+	ibmveth_free_queue_buffer_pools(adapter, queue_idx);
+
+	if (adapter->buffer_list_dma[queue_idx]) {
+		dma_unmap_single(dev, adapter->buffer_list_dma[queue_idx],
+				 4096, DMA_BIDIRECTIONAL);
+		adapter->buffer_list_dma[queue_idx] = 0;
+	}
+
+	if (adapter->rx_queue[queue_idx].queue_addr) {
+		dma_free_coherent(dev, adapter->rx_queue[queue_idx].queue_len,
+				  adapter->rx_queue[queue_idx].queue_addr,
+				  adapter->rx_queue[queue_idx].queue_dma);
+		adapter->rx_queue[queue_idx].queue_addr = NULL;
+	}
+
+	if (adapter->buffer_list_addr[queue_idx]) {
+		free_page((unsigned long)adapter->buffer_list_addr[queue_idx]);
+		adapter->buffer_list_addr[queue_idx] = NULL;
+	}
+
+	netdev_dbg(adapter->netdev, "Freed queue %d resources\n", queue_idx);
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
@@ -1192,6 +1376,49 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 	return 0;
 }
 
+/**
+ * ibmveth_drain_rx_queue - Drain pending buffers from an RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_index: Queue index to drain
+ *
+ * Recycles all pending buffers back to the per-queue buffer pools.
+ * Must be called with NAPI disabled for this queue.
+ *
+ * Return: Number of buffers drained
+ */
+static int
+ibmveth_drain_rx_queue(struct ibmveth_adapter *adapter, int queue_index)
+{
+	struct net_device *netdev = adapter->netdev;
+	int drained = 0;
+	int limit = adapter->rx_queue[queue_index].num_slots;
+	int rc;
+
+	netdev_dbg(netdev, "Draining RX queue %d (limit: %d slots)\n",
+		   queue_index, limit);
+
+	while (drained < limit &&
+	       ibmveth_rxq_pending_buffer(adapter, queue_index)) {
+		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
+		if (rc) {
+			netdev_err(netdev,
+				   "Failed to harvest buffer from queue %d during drain: %d\n",
+				   queue_index, rc);
+			break;
+		}
+		drained++;
+	}
+
+	if (drained > 0)
+		netdev_dbg(netdev, "Drained %d buffer(s) from RX queue %d\n",
+			   drained, queue_index);
+	else
+		netdev_dbg(netdev, "No buffers to drain from RX queue %d\n",
+			   queue_index);
+
+	return drained;
+}
+
 static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 {
 	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
@@ -1459,7 +1686,7 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
  * the IRQ mapping for subordinate queues. Queue 0 is freed only through
  * ibmveth_free_all_queues() (H_FREE_LOGICAL_LAN).
  */
-static void __maybe_unused
+static void
 ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
 				   int queue_idx)
 {
@@ -1491,6 +1718,175 @@ ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
 	netdev_dbg(adapter->netdev, "Deregistered queue %d\n", queue_idx);
 }
 
+/**
+ * ibmveth_resize_rx_queues_incremental - Resize RX queue count incrementally
+ * @adapter: ibmveth adapter structure
+ * @new_count: Target number of RX queues
+ * @rxq_entries: Number of entries per RX queue
+ *
+ * Adds or removes RX queues without tearing down the entire adapter.
+ * Active queues continue receiving during scale-up; scale-down drains
+ * excess queues before deregistering them with the hypervisor.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_resize_rx_queues_incremental(struct ibmveth_adapter *adapter,
+				     int new_count, int rxq_entries)
+{
+	struct net_device *netdev = adapter->netdev;
+	u64 mac_address = ether_addr_to_u64(netdev->dev_addr);
+	int old_count = adapter->num_rx_queues;
+	int failed_queue;
+	int rc, i;
+
+	if (old_count == new_count) {
+		netdev_dbg(netdev, "RX queue count unchanged (%d), nothing to do\n",
+			   old_count);
+		return 0;
+	}
+
+	if (new_count < 1 || new_count > IBMVETH_MAX_RX_QUEUES) {
+		netdev_err(netdev, "Invalid RX queue count %d (must be 1-%d)\n",
+			   new_count, IBMVETH_MAX_RX_QUEUES);
+		return -EINVAL;
+	}
+
+	netdev_info(netdev, "Incrementally resizing RX queues: %d to %d\n",
+		    old_count, new_count);
+
+	if (new_count > old_count) {
+		netdev_dbg(netdev, "Scale-up: adding queues %d-%d\n",
+			   old_count, new_count - 1);
+
+		for (i = old_count; i < new_count; i++) {
+			rc = ibmveth_alloc_single_rx_queue(adapter, i, rxq_entries);
+			if (rc) {
+				netdev_err(netdev, "Failed to allocate queue %d: %d\n",
+					   i, rc);
+				goto cleanup_new_queues;
+			}
+
+			rc = ibmveth_register_single_rx_queue(adapter, i,
+							      mac_address);
+			if (rc) {
+				netdev_err(netdev, "Failed to register queue %d: %d\n",
+					   i, rc);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+
+			rc = ibmveth_setup_single_rx_interrupt(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "Failed to setup IRQ for queue %d: %d\n",
+					   i, rc);
+				ibmveth_deregister_single_rx_queue(adapter, i);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+
+			rc = ibmveth_enable_irq(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "Failed to enable IRQ for queue %d: %d\n",
+					   i, rc);
+				ibmveth_cleanup_single_rx_interrupt(adapter, i);
+				ibmveth_deregister_single_rx_queue(adapter, i);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+
+			napi_enable(&adapter->napi[i]);
+		}
+
+		adapter->num_rx_queues = new_count;
+
+		for (i = old_count; i < new_count; i++)
+			ibmveth_replenish_task(adapter, i);
+
+		rc = netif_set_real_num_rx_queues(netdev, new_count);
+		if (rc) {
+			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
+				   new_count, rc);
+			goto cleanup_new_queues;
+		}
+	} else {
+		netdev_dbg(netdev, "Scale-down: removing queues %d-%d\n",
+			   new_count, old_count - 1);
+
+		for (i = new_count; i < old_count; i++)
+			napi_disable(&adapter->napi[i]);
+
+		for (i = new_count; i < old_count; i++)
+			ibmveth_drain_rx_queue(adapter, i);
+
+		synchronize_net();
+
+		rc = netif_set_real_num_rx_queues(netdev, new_count);
+		if (rc) {
+			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
+				   new_count, rc);
+			for (i = new_count; i < old_count; i++)
+				napi_enable(&adapter->napi[i]);
+			return rc;
+		}
+
+		/* Disable hypervisor interrupts and wait for handlers to complete
+		 * before updating num_rx_queues.
+		 */
+		for (i = new_count; i < old_count; i++) {
+			ibmveth_disable_irq(adapter, i);
+			synchronize_irq(adapter->queue_irq[i]);
+		}
+
+		adapter->num_rx_queues = new_count;
+
+		for (i = new_count; i < old_count; i++) {
+			ibmveth_cleanup_single_rx_interrupt(adapter, i);
+			ibmveth_deregister_single_rx_queue(adapter, i);
+			ibmveth_free_single_rx_queue(adapter, i);
+		}
+	}
+
+	netdev_info(netdev, "Successfully resized to %d RX queues (incremental)\n",
+		    adapter->num_rx_queues);
+
+	if (firmware_has_feature(FW_FEATURE_CMO))
+		vio_cmo_set_dev_desired(adapter->vdev,
+					ibmveth_get_desired_dma(adapter->vdev));
+
+	return 0;
+
+cleanup_new_queues:
+	failed_queue = i;
+	netdev_err(netdev,
+		   "Scale-up failed at queue %d, cleaning up queues %d-%d\n",
+		   failed_queue, old_count, failed_queue - 1);
+	for (i = old_count; i < failed_queue; i++)
+		napi_disable(&adapter->napi[i]);
+
+	for (i = old_count; i < failed_queue; i++)
+		ibmveth_drain_rx_queue(adapter, i);
+
+	synchronize_net();
+
+	for (i = old_count; i < failed_queue; i++) {
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = old_count; i < failed_queue; i++) {
+		ibmveth_cleanup_single_rx_interrupt(adapter, i);
+		ibmveth_deregister_single_rx_queue(adapter, i);
+		ibmveth_free_single_rx_queue(adapter, i);
+	}
+	adapter->num_rx_queues = old_count;
+	netdev_warn(netdev, "Keeping %d queues after scale-up failure\n",
+		    old_count);
+	return rc;
+}
+
 /**
  * ibmveth_free_all_queues - Free all RX queues at once
  * @adapter: ibmveth adapter structure
-- 
2.39.3 (Apple Git-146)


