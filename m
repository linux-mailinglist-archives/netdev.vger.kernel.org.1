Return-Path: <netdev+bounces-303875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5g9cN1SURWr4CQsAu9opvQ
	(envelope-from <netdev+bounces-303875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:27:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312016F217C
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:27:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=c1a9X+XP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303875-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303875-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0430130FE1D6
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 22:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26B93A5E77;
	Wed,  1 Jul 2026 22:25:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD17420E71
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 22:25:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944747; cv=none; b=PDr0+UrHmUXGby7RHDSXlnOeu1t6St+HbtX/qY65A1qhd8Y+W2F+yqxrHKNJD/b8ODy4iNn6u7aryxtcBn20NSkS6aZE5TX8SeFjBKUT9Ncm0IZRsLfM5SjHBQQ0zhpHlZw3T7QcbUjJ+DLNKFYalbXrG9YXrn9Yw3p4efk0vbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944747; c=relaxed/simple;
	bh=MbNnltusv0nBCYhQg15lYoRJ1d5Z12qH8Xhj1D8Ok7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlN577dcu6j/Hsis4Hg+V6tcioqqBHC3lFzaJfLFfYi1V04ldwOAfDSOJH8NoLHUndQTqOhwi/PdwDCVpOyMJbZbgYAbXhAR/0V/BKVMZw74LwG/wjMy+s0nniukTW5mLpHgNNGIrpTApz0XwF27S+MbceadN3/sL1E/l0J2gfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c1a9X+XP; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661LnJxK1970923;
	Wed, 1 Jul 2026 22:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zqw1xV
	i6f/t/VOkXx4/uYoNiNALbzmxBFB30V6L7EFM=; b=c1a9X+XPInXP79+fsLule/
	GIXwa74KXvJ+Wy4NW3RQpCUCAUKnUeCqjewqrRmtqXWGFUiWbvvX91Ct3jgT0Tfg
	b0hftQf13ZV6htwLq+idqoHgGjcevUz6Gjx0oiLwdiIY3BaoksRiJMyFFr20Xmr/
	F67KXoP3/NAB7vdY21HF4TCItg5LKcXhJcQc0BVyLC29lgxgTTZx66IVMydZOOTk
	D1qtHtY4M5LNVmW/YvQq5Vj4XTENGK5iP6ud+jcZJBEhryWEA/N8ZexNC9IhcTkC
	TL/rDucCdckTMxHQPMqVdN5tT1/G1b7lGHR3pN5bgiTuIevUu66DUxg1axQIXKPg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa6knj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661MOKrL026520;
	Wed, 1 Jul 2026 22:25:30 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqhk9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661MPTWF38338878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 22:25:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65AC95804B;
	Wed,  1 Jul 2026 22:25:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E620458055;
	Wed,  1 Jul 2026 22:25:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.150.53])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 22:25:27 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v2 05/15] ibmveth: Add RX queue register/deregister helpers for MQ
Date: Wed,  1 Jul 2026 15:23:17 -0700
Message-Id: <20260701222327.61325-6-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260701222327.61325-1-mmc@linux.ibm.com>
References: <20260701222327.61325-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfXx2EoMu/JkFo+
 15SerLKjqsecAjFqbrZte6+NBFAenx1rtXaIPy7uP+Mrm/GxmWNgHVk5E4Hm6dyjVQm0msczwL/
 coWEpF1u+Ty1WG97JeoeciaZTlBx79AzNvy3tOo8FvPBXVu0RGYPhT+SMX/dOR66r1pmOYQXDCr
 tEZ3DwJt/XZ+Xow/DWQTOmV8j+tU8LZNJYq7bPpXjU1EocqAGCBa129P6phgUjX+YAuXkFevUx7
 Ru0Eq2KAKoy3nzS6F+yiZRIbgyD93TpCp9f4Cs9qI+eZZ7Zv6eNTzXMRxV26lG/Diq57g/oMi1Y
 c9EnIkMf/8FH4LtmB/omMkyFX+jcAKN608nIwHAUCweQBiT3USz1qzxv5/GAUjzrl5MsAGnDy1m
 odCD8Wrx9CIvMKx5da2OXKxlONFvWDXRa3f3DvLI7x/X4Bdp4O0PF7eqlVsdEhiXZ1D1BucG1zB
 rCkrAyahEQ9jJV8kqNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX1MzyQMQA9ywV
 OyHBkFu8m1F/gZOI9nb9KT6BhIFpE+bZPbGTAnj+6bYD62C7WyCACoqBdRpXs188j28JNDaHd3V
 jEjKLAFi1HMb7s0E3XVU1y7ff0FPUuo=
X-Proofpoint-GUID: oiyu0MmjBXnaAcZFnoxNIF2eWp4boKRe
X-Proofpoint-ORIG-GUID: UKueEf6Gb37w1-huId6MdF_anBSQXp8H
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a4593dd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=vJoZBXvL9LZIL3lWWPgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010239
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-303875-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 312016F217C

MQ RX replaces a single adapter-level register/free pair with a mixed
PHYP model: queue 0 via h_register_logical_lan*(), subordinates via
H_REG_LOGICAL_LAN_QUEUE. Subordinate registration returns queue handles
and hardware IRQ numbers that must be mapped to Linux virqs and unwound
on failure.

Add queue lifecycle helpers to isolate that control plane:

  ibmveth_register_logical_lan_queue()
  ibmveth_register_single_rx_queue()
  ibmveth_deregister_single_rx_queue()
  ibmveth_register_rx_queues()
  ibmveth_free_all_queues()
  ibmveth_dispose_subordinate_irq_mappings()

These helpers are called only when multi_queue is enabled (patch 11).
Until then open/close still use the legacy register and buffer hcall
path; legacy firmware is unchanged.

When multi_queue is enabled, queue 0 uses
h_register_logical_lan_with_handle() so all queues share the per-queue
buffer hcall path. register_rx_queues() registers with PHYP only;
interrupt delivery is enabled later from ibmveth_setup_rx_interrupts()
after request_irq(). Partial registration failure disposes subordinate virq
mappings before ibmveth_free_all_queues() clears handles;
free_all_queues() clears queue handles only — IRQ mappings are released
by dispose_subordinate_irq_mappings() or cleanup_rx_interrupts().
This commit also centralizes hcall accounting on the register/free paths.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 337 ++++++++++++++++++++++++++++-
 1 file changed, 332 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 63b0184c622a..7fc11a4e1f61 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -21,6 +21,8 @@
 #include <linux/skbuff.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/mm.h>
 #include <linux/pm.h>
 #include <linux/ethtool.h>
@@ -399,6 +401,28 @@ ibmveth_enable_irq(struct ibmveth_adapter *adapter, int queue_index)
 	return ibmveth_toggle_irq(adapter, queue_index, true);
 }
 
+/**
+ * ibmveth_dispose_subordinate_irq_mappings - Drop virq mappings for queues 1..N
+ * @adapter: ibmveth adapter structure
+ *
+ * Subordinate queues get mappings from irq_create_mapping() during PHYP
+ * registration.  Queue 0 uses netdev->irq from device tree and is left alone.
+ * Call after free_irq() when handlers were installed, or alone when open
+ * fails during register_rx_queues() before request_irq().
+ */
+static void
+ibmveth_dispose_subordinate_irq_mappings(struct ibmveth_adapter *adapter)
+{
+	int i;
+
+	for (i = 1; i < adapter->num_rx_queues; i++) {
+		if (adapter->queue_irq[i]) {
+			irq_dispose_mapping(adapter->queue_irq[i]);
+			adapter->queue_irq[i] = 0;
+		}
+	}
+}
+
 /**
  * ibmveth_setup_rx_interrupts - Register IRQs and enable NAPI
  * @adapter: ibmveth adapter structure
@@ -1082,8 +1106,8 @@ ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
 }
 
 static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
-				   union ibmveth_buf_desc rxq_desc,
-				   u64 mac_address)
+					union ibmveth_buf_desc rxq_desc,
+					u64 mac_address)
 {
 	int rc, try_again = 1;
 
@@ -1093,13 +1117,29 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	 * try again, but only once.
 	 */
 retry:
-	rc = h_register_logical_lan(adapter->vdev->unit_address,
-				    adapter->buffer_list_dma[0], rxq_desc.desc,
-				    adapter->filter_list_dma, mac_address);
+	/* In multi-queue mode, obtain a queue handle for queue 0 so all RX
+	 * queues can use the same per-queue buffer hypercalls.
+	 */
+	if (adapter->multi_queue) {
+		rc = h_register_logical_lan_with_handle(adapter->vdev->unit_address,
+							adapter->buffer_list_dma[0],
+							rxq_desc.desc,
+							adapter->filter_list_dma,
+							mac_address,
+							&adapter->queue_handle[0]);
+	} else {
+		rc = h_register_logical_lan(adapter->vdev->unit_address,
+					    adapter->buffer_list_dma[0],
+					    rxq_desc.desc,
+					    adapter->filter_list_dma,
+					    mac_address);
+	}
+	adapter->hcall_stats.reg_lan++;
 
 	if (rc != H_SUCCESS && try_again) {
 		do {
 			rc = h_free_logical_lan(adapter->vdev->unit_address);
+			adapter->hcall_stats.free_lan++;
 		} while (H_IS_LONG_BUSY(rc) || (rc == H_BUSY));
 
 		try_again = 0;
@@ -1136,6 +1176,293 @@ static void __maybe_unused ibmveth_free_rx_qstats(struct ibmveth_adapter *adapte
 	adapter->rx_qstats = NULL;
 }
 
+/**
+ * ibmveth_register_logical_lan_queue - Register subordinate queue with hypervisor
+ * @adapter: ibmveth adapter structure
+ * @rxq_desc: Receive queue descriptor
+ * @queue_index: RX queue index (1..N for subordinate queues)
+ *
+ * Registers a subordinate receive queue using H_REG_LOGICAL_LAN_QUEUE.
+ * On success, stores the queue handle and virtual IRQ in the adapter.
+ * Retries once if registration fails (handles kexec case).  If IRQ mapping
+ * fails after a successful hypervisor registration, the queue is freed
+ * before returning.
+ *
+ * Return: H_SUCCESS on success, negative errno on IRQ mapping failure,
+ *         hypervisor error code otherwise
+ */
+static int
+ibmveth_register_logical_lan_queue(struct ibmveth_adapter *adapter,
+				   union ibmveth_buf_desc rxq_desc,
+				   int queue_index)
+{
+	unsigned long handle, hwirq;
+	unsigned int virq;
+	long lpar_rc;
+	int try_again = 1;
+
+retry:
+	netdev_dbg(adapter->netdev,
+		   "Attempting to register queue %d: unit_addr=0x%x buffer_list_dma=0x%llx rxq_desc=0x%llx\n",
+		   queue_index, adapter->vdev->unit_address,
+		   (unsigned long long)adapter->buffer_list_dma[queue_index],
+		   (unsigned long long)rxq_desc.desc);
+
+	lpar_rc = h_reg_logical_lan_queue(adapter->vdev->unit_address,
+					  adapter->buffer_list_dma[queue_index],
+					  rxq_desc.desc, &handle, &hwirq);
+	adapter->hcall_stats.reg_lan_queue++;
+
+	if (lpar_rc == H_SUCCESS) {
+		virq = irq_create_mapping(NULL, hwirq);
+		if (!virq) {
+			unsigned long free_rc;
+
+			netdev_err(adapter->netdev,
+				   "Failed to map IRQ for queue %d (hwirq=%lu)\n",
+				   queue_index, hwirq);
+			do {
+				free_rc = h_free_logical_lan_queue(adapter->vdev->unit_address,
+								   handle);
+			} while (H_IS_LONG_BUSY(free_rc) || (free_rc == H_BUSY));
+			adapter->hcall_stats.free_lan_queue++;
+			if (free_rc != H_SUCCESS)
+				netdev_err(adapter->netdev,
+					   "h_free_logical_lan_queue failed for queue %d after IRQ map failure: rc=0x%lx\n",
+					   queue_index, free_rc);
+			return -EINVAL;
+		}
+
+		adapter->queue_handle[queue_index] = handle;
+		adapter->queue_irq[queue_index] = virq;
+
+		netdev_dbg(adapter->netdev,
+			   "queue %d registered: handle=0x%llx irq=%u\n",
+			   queue_index, adapter->queue_handle[queue_index],
+			   adapter->queue_irq[queue_index]);
+		return H_SUCCESS;
+	}
+
+	if (lpar_rc == H_FUNCTION) {
+		if (adapter->multi_queue) {
+			netdev_info(adapter->netdev,
+				    "Multi queue mode not supported by firmware, falling back to single queue\n");
+			adapter->multi_queue = 0;
+		} else {
+			netdev_err(adapter->netdev,
+				   "Unexpected H_FUNCTION for queue %d registration (MQ mode already disabled)\n",
+				   queue_index);
+		}
+		return lpar_rc;
+	}
+
+	if (try_again) {
+		try_again = 0;
+		goto retry;
+	}
+
+	netdev_err(adapter->netdev,
+		   "h_reg_logical_lan_queue failed with %ld after retry\n",
+		   lpar_rc);
+	netdev_err(adapter->netdev,
+		   "queue %d params: unit_addr=0x%x buffer_list_dma=0x%llx rxq_desc=0x%llx\n",
+		   queue_index, adapter->vdev->unit_address,
+		   (unsigned long long)adapter->buffer_list_dma[queue_index],
+		   (unsigned long long)rxq_desc.desc);
+
+	return lpar_rc;
+}
+
+/**
+ * ibmveth_register_single_rx_queue - Register one subordinate RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to register (1..N)
+ * @mac_address: MAC address (unused; reserved for API symmetry)
+ *
+ * Builds the queue descriptor and registers with the hypervisor via
+ * ibmveth_register_logical_lan_queue().
+ *
+ * Return: 0 on success, -EINVAL if @queue_idx is invalid, -EIO on failure
+ */
+static int
+ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
+				 int queue_idx, u64 mac_address)
+{
+	struct net_device *netdev = adapter->netdev;
+	union ibmveth_buf_desc rxq_desc;
+	long lpar_rc;
+
+	(void)mac_address;
+
+	if (WARN_ON(queue_idx < 1 || queue_idx >= IBMVETH_MAX_RX_QUEUES))
+		return -EINVAL;
+
+	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
+				    adapter->rx_queue[queue_idx].queue_len;
+	rxq_desc.fields.address = adapter->rx_queue[queue_idx].queue_dma;
+
+	lpar_rc = ibmveth_register_logical_lan_queue(adapter, rxq_desc,
+						     queue_idx);
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(netdev, "Failed to register queue %d: rc=0x%lx\n",
+			   queue_idx, lpar_rc);
+		return -EIO;
+	}
+
+	netdev_dbg(netdev, "Registered queue %d with handle 0x%llx\n",
+		   queue_idx, adapter->queue_handle[queue_idx]);
+
+	return 0;
+}
+
+/**
+ * ibmveth_deregister_single_rx_queue - Deregister one subordinate RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to deregister (1..N)
+ *
+ * Deregisters a single queue via H_FREE_LOGICAL_LAN_QUEUE and disposes
+ * the IRQ mapping for subordinate queues. Queue 0 is freed only through
+ * ibmveth_free_all_queues() (H_FREE_LOGICAL_LAN).
+ */
+static void __maybe_unused
+ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
+				   int queue_idx)
+{
+	unsigned long lpar_rc;
+
+	if (!adapter->queue_handle[queue_idx])
+		return;
+
+	do {
+		lpar_rc = h_free_logical_lan_queue(adapter->vdev->unit_address,
+						   adapter->queue_handle[queue_idx]);
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+
+	adapter->hcall_stats.free_lan_queue++;
+
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan_queue failed for queue %d: rc=0x%lx\n",
+			   queue_idx, lpar_rc);
+	}
+
+	adapter->queue_handle[queue_idx] = 0;
+
+	if (queue_idx > 0 && adapter->queue_irq[queue_idx]) {
+		irq_dispose_mapping(adapter->queue_irq[queue_idx]);
+		adapter->queue_irq[queue_idx] = 0;
+	}
+
+	netdev_dbg(adapter->netdev, "Deregistered queue %d\n", queue_idx);
+}
+
+/**
+ * ibmveth_free_all_queues - Free all RX queues at once
+ * @adapter: ibmveth adapter structure
+ *
+ * Uses H_FREE_LOGICAL_LAN to free all queues in one hypercall.
+ * Used during interface close and registration error cleanup.
+ *
+ * Clears queue handles only; queue_irq[] is released by
+ * ibmveth_cleanup_rx_interrupts() on close, or by
+ * ibmveth_dispose_subordinate_irq_mappings() on partial register failure.
+ */
+static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
+{
+	unsigned long lpar_rc;
+	int i;
+
+	netdev_dbg(adapter->netdev, "freeing all RX queues at once\n");
+
+	do {
+		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
+		adapter->hcall_stats.free_lan++;
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan failed: %ld\n", lpar_rc);
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		adapter->queue_handle[i] = 0;
+}
+
+/**
+ * ibmveth_register_rx_queues - Register RX queues with hypervisor
+ * @adapter: ibmveth adapter structure
+ * @mac_address: MAC address for device registration
+ *
+ * Registers queue 0 via ibmveth_register_logical_lan(), then subordinate
+ * queues 1..N when multi-queue mode is enabled.
+ *
+ * Return: 0 on success, -ENONET if queue 0 registration fails, -EIO on
+ *         subordinate queue registration failure
+ */
+static int
+ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
+{
+	struct net_device *netdev = adapter->netdev;
+	union ibmveth_buf_desc rxq_desc;
+	unsigned long lpar_rc;
+	int i, rc;
+
+	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
+				    adapter->rx_queue[0].queue_len;
+	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
+	adapter->queue_irq[0] = netdev->irq;
+
+	rc = ibmveth_disable_irq(adapter, 0);
+	if (rc != H_SUCCESS)
+		netdev_dbg(netdev,
+			   "Failed to disable IRQ for queue 0 before registration, rc=%d\n",
+			   rc);
+
+	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(netdev, "h_register_logical_lan failed: %ld\n", lpar_rc);
+		netdev_err(netdev,
+			   "buffer TCE:0x%llx filter TCE:0x%llx rxq desc:0x%llx MAC:0x%llx\n",
+			   adapter->buffer_list_dma[0],
+			   adapter->filter_list_dma,
+			   rxq_desc.desc, mac_address);
+		return -ENONET;
+	}
+
+	if (adapter->num_rx_queues == 1 || !adapter->multi_queue) {
+		netdev_dbg(netdev,
+			   "registered 1 RX queue with hypervisor (single-queue mode)\n");
+		return 0;
+	}
+
+	netdev_dbg(netdev, "Registering %d subordinate queues (1-%d)\n",
+		   adapter->num_rx_queues - 1, adapter->num_rx_queues - 1);
+
+	for (i = 1; i < adapter->num_rx_queues; i++) {
+		rc = ibmveth_register_single_rx_queue(adapter, i, mac_address);
+		if (rc) {
+			if (!adapter->queue_handle[i] || !adapter->queue_irq[i]) {
+				netdev_err(netdev,
+					   "Invalid hypervisor return for queue %d: handle=0x%llx irq=%u\n",
+					   i, adapter->queue_handle[i],
+					   adapter->queue_irq[i]);
+			}
+			goto err_unregister;
+		}
+	}
+
+	netdev_dbg(netdev,
+		   "registered %d RX queues with hypervisor (multi-queue mode)\n",
+		   adapter->num_rx_queues);
+
+	return 0;
+
+err_unregister:
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
+	ibmveth_free_all_queues(adapter);
+	return rc;
+}
+
 static int ibmveth_open(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-- 
2.39.3 (Apple Git-146)


