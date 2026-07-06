Return-Path: <netdev+bounces-305207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mcmCFuIDTGo0ewEAu9opvQ
	(envelope-from <netdev+bounces-305207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:37:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ECC7150CB
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:37:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=J9DEkUNA;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305207-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305207-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 433C4302F411
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 19:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEDA330675;
	Mon,  6 Jul 2026 19:36:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD03382F9
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 19:36:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366607; cv=none; b=rr/OaeIalx14Gp7T/N+bGu7mOXw8Q9Icn8gI2U07/WjL5LyJdaHDJg34a7qJPsSfxCOk6dM999yr47pRkDtoFmutr38hsEDS5sZHFmRoxcIQQnSk0iNF0HTQBsCJyS3yf02pQoQta+FH5AeS4xiokKumlTxTygopWbShhGF/Nq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366607; c=relaxed/simple;
	bh=ACwBokijSMvk5OSyVkuRCsMNzb+F153ztamAkI45E1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ork4cHrSgdnK9wzfiPVLMcUkN56BxmMVcdJd6s8BO/lmmXGxTGgtPr0LU8rkLcRaBWKKCnqhTi4KMM9KBI0rUQg2BKYf3Qiwb7qjpO8luiq+7Taan+Xw1b4kgku9x6ZMUjMrf6OTNFghzI+y8EFG4CXF2PReot8nUmwcC7dnI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J9DEkUNA; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIkG04050359;
	Mon, 6 Jul 2026 19:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OnqM6f
	NdRO65uIFoKph49sXombDNctxewWIey7krbuc=; b=J9DEkUNA6pn+erPyWB/SK9
	Klm7OO/CrVH73WKFzhCqICnh0s7Uyrc4D3Wsixpr9WVPqPB0OLZ9BymgZs914nwz
	TlaCAH/TN4Hb6WPJOBHUnwFrda+jOsT97bdX6iTFrSlM8rXc9IsteB0spjBCDoer
	J1YSsrL3mM62whG/V4ynX8vG2VqQy5glBR4y+Q18yyG2cU/kuJMokx7jP1FN09/a
	VFSh1GvWNeaF4+yIXeZRK8WRMni3Bm0anY8IMU7QjbGAIsVePs5rJ6K5q03g+RQx
	ZzMnMI1G0WyvyJwZDToavQuF7BPsdFmtBWGTL+JZghXfJYWiinHmRE8sG0+RVzPg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stskjxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYni7011991;
	Mon, 6 Jul 2026 19:36:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjxyns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666JaSOX16646750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:36:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7870D5805A;
	Mon,  6 Jul 2026 19:36:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7451658051;
	Mon,  6 Jul 2026 19:36:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:27 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 03/15] ibmveth: Refactor RX resource allocation for MQ RX bring-up
Date: Mon,  6 Jul 2026 12:35:51 -0700
Message-Id: <20260706193603.8039-4-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260706193603.8039-1-mmc@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: kbM7FijzEdIoryT-aVSQt3LC158MdjE1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfXyf10n5/8TRb3
 U3P6EtpbyFiiStHI5hiB5dQmPes4vs+UK+/v/5KUWmeiNpEBCWfskaEsuiHhn7ZtinH4Fj46gpZ
 Y5xaAJ6DBuKL75UmrfT1Q0A9dz7jwbY=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4c03bf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VB3T6LR5Bl6OjwfYf1gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AeuFnb8G6ABoF9WE1DuL1Zvpb6jqw1vs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX8LbZtmQd47/m
 2BebOwI8bR1KmHDWGO/ub0HqnNdlZoX0h6eV7oUw9qKDzJPV9wrfPlqxSMiIf8V4v70FQqPEXH0
 iB93weSa74mfywPmYvp+WXaeZCNZx3lvBcXzMX5s/ighiwuIl2XFf+SQ7v4PXafCi41kNczD0n/
 qg38GVqv8g/D1tyTuhQQ6EzscRiMS9SBcEJ/ZrrND4lZVoJEeOCwNkyy8hY0gpYjsuwXvg2QxI+
 mdgtxDBvE53PC42HD9x1W2nMEQNvi8eJ2PW+Ta+jwvJcG2kbMfAWTsLJnRA3OeQnNyq3+HGluDW
 VUHJOaZzszl9Hbi1KD9Cpef3EFqIO/H8m1vtFKaGgX58X501JPqD575cePu+hV+k9l4Pwnqq6xv
 a6XPtw00ze5TP58yTaZpZJ3yMbHZgitRoxV+R7fxPfASdEbyxOnWqTFyzJ2CNA1mEO1vdVUyavh
 0u085xCYgAWezqMVdUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060195
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-305207-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5ECC7150CB

ibmveth_open() allocates the filter list and every RX queue inline.
That's already ~160 lines and would get ugly once we loop over
num_rx_queues, especially on error unwind.

Pull the RX bits into helpers:

  ibmveth_alloc_filter_list() / ibmveth_free_filter_list()
    — shared multicast filter list (one per adapter, not per queue)

  ibmveth_alloc_rx_queues() / ibmveth_cleanup_rx_resources()
    — per-queue buffer lists and RX rings, looping [0, num_rx_queues)

alloc_rx_queues() rolls back on failure so open() does not need nested
goto chains for every queue index.

This is the first of several helper-only patches (pools, IRQ, TX, PHYP
registration, open/close wiring, buffer submit) that reshape bring-up
ahead of MQ datapath commit later in the series.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 168 +++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 8f9f927bff23..b8adc9935471 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -147,6 +147,174 @@ static unsigned int ibmveth_real_max_tx_queues(void)
 	return min(n_cpu, IBMVETH_MAX_QUEUES);
 }
 
+/**
+ * ibmveth_alloc_filter_list - Allocate and map filter list
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int __maybe_unused ibmveth_alloc_filter_list(struct ibmveth_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+	struct net_device *netdev = adapter->netdev;
+
+	adapter->filter_list_addr = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!adapter->filter_list_addr) {
+		netdev_err(netdev, "unable to allocate filter pages\n");
+		return -ENOMEM;
+	}
+
+	adapter->filter_list_dma = dma_map_single(dev,
+						  adapter->filter_list_addr,
+						  4096, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, adapter->filter_list_dma)) {
+		netdev_err(netdev, "unable to map filter list pages\n");
+		free_page((unsigned long)adapter->filter_list_addr);
+		adapter->filter_list_addr = NULL;
+		return -ENOMEM;
+	}
+
+	netdev_dbg(netdev, "filter list @ 0x%p (DMA: 0x%llx)\n",
+		   adapter->filter_list_addr,
+		   (unsigned long long)adapter->filter_list_dma);
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_filter_list - Free filter list resources
+ * @adapter: ibmveth adapter structure
+ */
+static void __maybe_unused ibmveth_free_filter_list(struct ibmveth_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+
+	if (adapter->filter_list_dma) {
+		dma_unmap_single(dev, adapter->filter_list_dma, 4096,
+				 DMA_BIDIRECTIONAL);
+		adapter->filter_list_dma = 0;
+	}
+
+	if (adapter->filter_list_addr) {
+		free_page((unsigned long)adapter->filter_list_addr);
+		adapter->filter_list_addr = NULL;
+	}
+}
+
+/**
+ * ibmveth_alloc_rx_queues - Allocate per-queue RX resources
+ * @adapter: ibmveth adapter structure
+ * @rxq_entries: Number of entries per RX queue
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int __maybe_unused
+ibmveth_alloc_rx_queues(struct ibmveth_adapter *adapter, int rxq_entries)
+{
+	struct device *dev = &adapter->vdev->dev;
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		adapter->buffer_list_addr[i] = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!adapter->buffer_list_addr[i]) {
+			netdev_err(netdev, "unable to allocate buffer list for queue %d\n", i);
+			goto err_cleanup;
+		}
+
+		adapter->rx_queue[i].queue_len =
+			sizeof(struct ibmveth_rx_q_entry) * rxq_entries;
+		adapter->rx_queue[i].queue_addr =
+			dma_alloc_coherent(dev, adapter->rx_queue[i].queue_len,
+					   &adapter->rx_queue[i].queue_dma,
+					   GFP_KERNEL);
+		if (!adapter->rx_queue[i].queue_addr) {
+			netdev_err(netdev, "unable to allocate RX queue for queue %d\n", i);
+			goto err_cleanup;
+		}
+
+		adapter->buffer_list_dma[i] = dma_map_single(dev,
+							     adapter->buffer_list_addr[i],
+							     4096, DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(dev, adapter->buffer_list_dma[i])) {
+			netdev_err(netdev, "unable to map buffer list for queue %d\n", i);
+			adapter->buffer_list_dma[i] = 0;
+			goto err_cleanup;
+		}
+
+		adapter->rx_queue[i].index = 0;
+		adapter->rx_queue[i].num_slots = rxq_entries;
+		adapter->rx_queue[i].toggle = 1;
+
+		netdev_dbg(netdev, "queue %d: buffer_list @ 0x%p (DMA: 0x%llx), rx_queue @ 0x%p (DMA: 0x%llx), %llu entries\n",
+			   i, adapter->buffer_list_addr[i],
+			   (unsigned long long)adapter->buffer_list_dma[i],
+			   adapter->rx_queue[i].queue_addr,
+			   (unsigned long long)adapter->rx_queue[i].queue_dma,
+			   (unsigned long long)rxq_entries);
+	}
+
+	netdev_dbg(netdev, "allocated %d RX queue(s) with %d entries each\n",
+		   adapter->num_rx_queues, rxq_entries);
+
+	return 0;
+
+err_cleanup:
+	/* Clean up previously allocated queues */
+	for (; i >= 0; i--) {
+		if (adapter->buffer_list_dma[i]) {
+			dma_unmap_single(dev, adapter->buffer_list_dma[i],
+					 4096, DMA_BIDIRECTIONAL);
+			adapter->buffer_list_dma[i] = 0;
+		}
+		if (adapter->rx_queue[i].queue_addr) {
+			dma_free_coherent(dev, adapter->rx_queue[i].queue_len,
+					  adapter->rx_queue[i].queue_addr,
+					  adapter->rx_queue[i].queue_dma);
+			adapter->rx_queue[i].queue_addr = NULL;
+		}
+		if (adapter->buffer_list_addr[i]) {
+			free_page((unsigned long)adapter->buffer_list_addr[i]);
+			adapter->buffer_list_addr[i] = NULL;
+		}
+	}
+
+	return -ENOMEM;
+}
+
+/**
+ * ibmveth_cleanup_rx_resources - Free all RX queue resources
+ * @adapter: ibmveth adapter structure
+ */
+static void __maybe_unused ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+	int i;
+
+	netdev_dbg(adapter->netdev, "cleaning up %d RX queue(s)\n",
+		   adapter->num_rx_queues);
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (adapter->buffer_list_dma[i]) {
+			dma_unmap_single(dev, adapter->buffer_list_dma[i],
+					 4096, DMA_BIDIRECTIONAL);
+			adapter->buffer_list_dma[i] = 0;
+		}
+
+		if (adapter->rx_queue[i].queue_addr) {
+			dma_free_coherent(dev, adapter->rx_queue[i].queue_len,
+					  adapter->rx_queue[i].queue_addr,
+					  adapter->rx_queue[i].queue_dma);
+			adapter->rx_queue[i].queue_addr = NULL;
+		}
+
+		if (adapter->buffer_list_addr[i]) {
+			free_page((unsigned long)adapter->buffer_list_addr[i]);
+			adapter->buffer_list_addr[i] = NULL;
+		}
+	}
+}
+
 /* setup the initial settings for a buffer pool */
 static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
 				     u32 pool_index, u32 pool_size,
-- 
2.39.3 (Apple Git-146)


