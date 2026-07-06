Return-Path: <netdev+bounces-305208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d0ZcFsgETGqGewEAu9opvQ
	(envelope-from <netdev+bounces-305208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:40:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72369715184
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:40:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=a+i2dd1L;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305208-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305208-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7FD83025896
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 19:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7D1330675;
	Mon,  6 Jul 2026 19:36:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B26B32ED21
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 19:36:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366608; cv=none; b=rn2SpAJhyvguLOT5pHslMxgHexpOwgdR0Ge6xJ8CVyRYp+RAM73XXU5aRNRfptiUcgm1/BTGUHVZ6U7ebNuUHpPTSgqqRoBkaOjy+WM7rqc2HhSy9oj3JsgeTkDD19hKo9XF5UYhrJVjPyJDK41tbp5nClEbCfWpZrREjRi68a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366608; c=relaxed/simple;
	bh=9Y5ZReRD2Z4yzqJelj9aGvl9kgqf6ZGqsQk70ol/tUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BEBrK44aD7shHePaWu6nBoBR9Wts0pRo7kz+d1Zi+E7GSpF450m5ZeCsb0dyVvJNKzBVHr2OhRee4NwQwDvxrlTsFwOf/xpQFF8qm18cXhUqSIuRsWTQUoD9H1/3K8i/rzVh7T01MD5zPwxlwL87hPmXN8cSiJkv0BYfGgKtwgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a+i2dd1L; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIVAR756336;
	Mon, 6 Jul 2026 19:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+o5Amc5iulVU0PlsD
	iMVjtHS+X7NM4LvfgOvu9S3cmc=; b=a+i2dd1L5SdihYP/67bguvPWfaH+VF1dX
	hutNLEAxhwQhdaiT7bKgmk39oqF35A9DT/npM4iae6iV7z9qR2vLzsScXGH4bSq3
	aCo7IOVQ45A9h+a0RDqu6cMlMKf7mJXYmuFm6S2cFR636zYiGPQP6um5SbuxVGmh
	edqoeeM7T46LPV2sXUgjjjITOQ4wl9C2bLxSiGFcCw7hTTNvVGNncJ6GEZX7Tia2
	2KD7TiizsgQVruhSAj1+z3gfrllpMjMTsCDYTS5U0KU1d6uJCi36zLI6Pbfa9Nqh
	N7Op78udY8PuwWZvhckbM5081ZSErNnVkoIzIynHagb0o2Noj6kXA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknb5cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYZMY018713;
	Mon, 6 Jul 2026 19:36:33 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h6v0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666JaVwG13894264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:36:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B25AA58051;
	Mon,  6 Jul 2026 19:36:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 998D75805E;
	Mon,  6 Jul 2026 19:36:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:30 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 04/15] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Mon,  6 Jul 2026 12:35:52 -0700
Message-Id: <20260706193603.8039-5-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4c03c2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=EwAlCuxjz4Ba8aIfdx8A:9
X-Proofpoint-GUID: Z2SWOOXrUysJhOEGKIy1349xQptraWFj
X-Proofpoint-ORIG-GUID: eZJe4vaP65WcSMNkLG1HnyIcXnb3AE8X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfXz0S/Jd8koCPl
 yIKJtLj+pAbIXaDA4eseZAsCVVYEnWzWY0u0ESFD4ICc/K2GM4eOFC7SUTj/r4Ej/mEZiFHDaNs
 XJZpnHVw1YPOWiJw28lMTvSyKQgUDiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX2N6tV0Lg2q6w
 Qm5OYY2wmKGJ52bNT8Lrx85vyd1bVGpGocCK3Ft6BEEARUgDR35OS+tNYBWHlKuN4HfN97wSx6H
 TumEPKpAQj5Q7Z+8UdqWc/jPkZnZCx+f1MQ+EqWti8p1nE8hYwwl4QUzpHh1x0Rx9jZZxV56nP8
 JjgE5HoWk5rBe9ygF9g6ldF96WHTXSiXkqBbg5sAcJX/xVuogrlTopgN5FB/25N47ZQ029DTCE5
 J4JdbArWS1+CulGWA9Z4VmTzaMqHeC8RgUceMsOf8fNfdy+I266fbPR9E0uXK90JwWUYkCTzPk5
 1CVPxlTyHw5Y+RlIapRRjXsYWcO4Hn68phbMJDph6CJrI3a+0WyVPFjzHhpRlOHCEWGn921WV27
 d8F594+WZXwes98I4sc7zphLE8o2C49BhQc/scsZzMuEklz7R34mbfrRrtPc65scH+0oJdhUDK9
 oFlCIowhePf2I5sq0LQ==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-305208-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72369715184

This is the key memory-model change for MQ RX.

Legacy ibmveth uses five adapter-level RX buffer pools (512 B
through 64 KiB slots). pool_active[] enables the standard-MTU pools by
default; larger pools activate when MTU requires them. With single-queue
RX that set is shared on one completion path.

MQ requires the same pool model per queue: buffers post with
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE against a queue handle and completions
return on that queue. Sharing pools across queues would mix ownership and
break queue-local replenish/drain/teardown.

Refactor around queue-local pools with static geometry (still defined at
probe on queue 0, copied to queues 1..N at alloc time):

  rx_buff_pool[queue][pool]
  ibmveth_alloc_queue_buffer_pools()
  ibmveth_free_queue_buffer_pools()
  ibmveth_alloc_buffer_pools() / ibmveth_free_buffer_pools()

Queue 0 remains the template for pool geometry (size, buff_size,
threshold, active). For queues 1..N we copy metadata from queue 0, then
allocate actual backing arrays/skbs per queue.

At the default 1500-byte MTU, pool 4 (64 KiB buffers) is not needed and
costs guest memory when allocated per queue in MQ mode. Clear
pool_active[4] so open() skips it; ibmveth_change_mtu() still enables
larger pools when MTU warrants jumbo frames.

Error handling is also made queue-safe:

  - if allocation fails in one pool, unwind only what was allocated for
    that queue, then unwind prior queues in the caller
  - free paths release pools based on real allocations
    (free_map/dma_addr/skbuff), not only pool->active

That allocation-based free check is intentional: later resize and failure
paths can leave memory allocated even when active was already cleared.
Freeing by allocation state avoids leaks and double-free corner cases.

This split keeps the per-queue pool design isolated and reviewable ahead
of the MQ datapath enable commit later in the series.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 127 +++++++++++++++++++++++++++++
 drivers/net/ethernet/ibm/ibmveth.h |   2 +-
 2 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index b8adc9935471..95068fb20dba 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -611,6 +611,133 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 	}
 }
 
+/**
+ * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Allocates all active buffer pools for the specified queue.
+ * Pool metadata must be initialized before calling this function.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int ibmveth_alloc_queue_buffer_pools(struct ibmveth_adapter *adapter,
+					    int queue)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		if (!adapter->rx_buff_pool[queue][i].active)
+			continue;
+
+		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[queue][i])) {
+			netdev_err(netdev,
+				   "unable to allocate buffer pool %d for queue %d (size=%u, count=%u)\n",
+				   i, queue,
+				   adapter->rx_buff_pool[queue][i].buff_size,
+				   adapter->rx_buff_pool[queue][i].size);
+			adapter->rx_buff_pool[queue][i].active = 0;
+
+			/* Free pools allocated so far for this queue */
+			while (--i >= 0) {
+				if (adapter->rx_buff_pool[queue][i].active)
+					ibmveth_free_buffer_pool(adapter,
+								 &adapter->rx_buff_pool[queue][i]);
+			}
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Frees all active buffer pools for the specified queue.
+ */
+static void ibmveth_free_queue_buffer_pools(struct ibmveth_adapter *adapter,
+					    int queue)
+{
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[queue][i];
+
+		/* Free pool if it has allocated memory, regardless of active flag.
+		 * Pools may have memory allocated but not marked active during
+		 * queue scale-up, so we must check for actual allocations.
+		 */
+		if (pool->free_map || pool->dma_addr || pool->skbuff)
+			ibmveth_free_buffer_pool(adapter, pool);
+	}
+}
+
+/**
+ * ibmveth_alloc_buffer_pools - Allocate buffer pools for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Initializes pool metadata for queues 1-N from queue 0 settings,
+ * then allocates buffer pools for all queues using the helper function.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int __maybe_unused ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i, q, rc;
+
+	/* Initialize pool metadata for queues 1-15 from queue 0 settings */
+	for (q = 1; q < adapter->num_rx_queues; q++) {
+		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+			struct ibmveth_buff_pool *src = &adapter->rx_buff_pool[0][i];
+			struct ibmveth_buff_pool *dst = &adapter->rx_buff_pool[q][i];
+
+			dst->size = src->size;
+			dst->index = src->index;
+			dst->buff_size = src->buff_size;
+			dst->threshold = src->threshold;
+			dst->active = src->active;
+		}
+	}
+
+	/* Allocate actual buffers for all queues */
+	for (q = 0; q < adapter->num_rx_queues; q++) {
+		rc = ibmveth_alloc_queue_buffer_pools(adapter, q);
+		if (rc) {
+			/* Free pools for all previous queues */
+			while (--q >= 0)
+				ibmveth_free_queue_buffer_pools(adapter, q);
+			return rc;
+		}
+	}
+
+	netdev_dbg(netdev, "allocated buffer pools for %d queue(s)\n",
+		   adapter->num_rx_queues);
+	return 0;
+}
+
+/**
+ * ibmveth_free_buffer_pools - Free buffer pools for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Frees buffer pools for all queues using the helper function.
+ */
+static void __maybe_unused ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
+{
+	int q;
+
+	/* Free buffer pools for all queues */
+	for (q = 0; q < adapter->num_rx_queues; q++)
+		ibmveth_free_queue_buffer_pools(adapter, q);
+
+	netdev_dbg(adapter->netdev, "freed buffer pools for %d queue(s)\n",
+		   adapter->num_rx_queues);
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index f0dffe42e8fe..d2ceeccd5fbd 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -286,7 +286,7 @@ static inline long h_illan_attributes(unsigned long unit_address,
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
 static int pool_count[] = { 256, 512, 256, 256, 256 };
 static int pool_count_cmo[] = { 256, 512, 256, 256, 64 };
-static int pool_active[] = { 1, 1, 0, 0, 1};
+static int pool_active[] = { 1, 1, 0, 0, 0};
 
 #define IBM_VETH_INVALID_MAP ((u16)0xffff)
 
-- 
2.39.3 (Apple Git-146)


