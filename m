Return-Path: <netdev+bounces-305209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P5RGAPYDTGo6ewEAu9opvQ
	(envelope-from <netdev+bounces-305209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:37:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5347150E9
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:37:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=LHlUZapW;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305209-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305209-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75897303E9E8
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 19:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEDB3368B5;
	Mon,  6 Jul 2026 19:36:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046E332EBC
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 19:36:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366613; cv=none; b=i7aDrYc05aIkgUWHNKSpNCK1zXj91P9bZQKBYQ91lN4F5/zAxhyWZkKWhp0Qt8ghzu6QMHZED6HS1t1JlWDfQjPxtEvkrtq65i70p6VJnppvFfFtf8xmBi7SB7QO0/TQwwTAxkKO6jigH7kUQENpcwj8Igk3St77PX8hQQAenYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366613; c=relaxed/simple;
	bh=rj5chXeNTnTtlrLd2J698XZN4adcm6x6olVe/wISy20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAoVkECkyKqM2+b2MKHjf85UPdVYNsvMULHl6g4KRCOOPYYHJ+hJTQPJCeeObZBU6pGY2MX9HY2sGAtG1CvO2yBq9kwc2CvmBa+SgorSiuEsQo2YVV9HkZLIQljWlNndgDQtnA3jH8hEmAmHxHZHxi/KPEdmD5/xt1uc9Kw23Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LHlUZapW; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIcXH756390;
	Mon, 6 Jul 2026 19:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9e2BMwE6DpQShEYRW
	ZYTBqwxewMByDrG89qSxiebla4=; b=LHlUZapWnYElt2Aw/PCbUdj+ytjPiiqxn
	n4avoRaCK9Nk769E4fWrWb3qmlnqyF8ey7/agSnsu8CCJLd0zKBiumjujMa4BN42
	aaX0vgHUn/0A6DNVbFFAn8YxtgAfAp+iJOuHm6R+N13f6cD/gR0OdQQp7dAZmoRV
	3AlpZbesmvuO5Ji7WS+tI2VUMccOCbj3hdVHcyNVdCLEX72n7Oz6r49PlnvW3u+Y
	iKkt+AqVC4pN4ko/Py/TFInTwQxneupACaguRgobspdKQV5cjRSQbGifVzRsmF62
	YODnW7W3nkdnVPRwMD/b3LiDZbcP4FOO3MtPO57CeII6xBM7myHJQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknb5d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYYEL012862;
	Mon, 6 Jul 2026 19:36:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xxmvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666JabGd30999236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:36:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02BDD5805E;
	Mon,  6 Jul 2026 19:36:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18A1F58051;
	Mon,  6 Jul 2026 19:36:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:36 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 05/15] ibmveth: Refactor RX interrupt control for MQ RX queues
Date: Mon,  6 Jul 2026 12:35:53 -0700
Message-Id: <20260706193603.8039-6-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4c03c7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=bI_WLspq9mz1f7g1iukA:9
X-Proofpoint-GUID: ju2_f_r4BR7GnebLaDp3fdE_5nN3aFll
X-Proofpoint-ORIG-GUID: a39MV0_J9dp8KcxdAiBsnFe8Ezwex1hC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX4fyDk1xvJPFC
 pwu7vDDZgTBIUFC5zd7wIOZVxZg96is6NySI4dhq7Ny5Dm6WciOJUobtVrHkt9MK/YoUPNJV69b
 HAYGCYLoHEC+OoDsJwobr/X2JRfH3DY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX35WLjzpYygdn
 Rxz93A3WdipK2VGU6SbJHOE0jF5sJF1uK03XkP5jlVYVbhqBZjsa2GeqQm5jNvCBIPMu2cvdQX1
 t9l+0JlYZ3pDj7OYrZaCWIPGA8i3JyEyCB5WQ8kFGnIsVs9D+svEf457ph0k7JwGRNPnf3rZCly
 wsR8lpRqqrDlofXZFJ8qm3Nrw7Kqh67vb0vRz4jfwYjV+iNnEgGpGq2ybunHPSB9jxtc1nRa+Vx
 RjjxxGZqm3N2TUFYCrWK8ysrgMreqAvoVEfFnqXmcMx60EUPPkxN72XfJNPZq1y2CCwufIU142M
 Z/C9FvRnVN4MBlzUaOSjNPoZZ5cuP3okVZr7quDhnMCqlCMqwjQdzHAk80nkjvSXPUvTJYTehxP
 kcCTl0/iR/i5L0WF86DRLGwodPiEW+NtFh8l3VE8O+dwTjYzgjqqVRP0NlTHtxQh1bYXnaYIZts
 Hc6EAkx5sPp5l04HCzA==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-305209-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B5347150E9

Queue 0 and subordinate RX queues use different interrupt control
interfaces in PHYP:

  - queue 0: h_vio_signal() after h_register_logical_lan()
  - queue N: H_VIOCTL against the queue handle/hwirq mapping

The current code is single-queue oriented and cannot safely scale to
multiple RX queues in poll completion and open/close IRQ setup.

Introduce queue-indexed interrupt helpers:

  ibmveth_enable_irq(adapter, queue_index)
  ibmveth_disable_irq(adapter, queue_index)
  ibmveth_setup_rx_interrupts()
  ibmveth_cleanup_rx_interrupts()

These helpers centralize queue0-vs-subordinate dispatch and make IRQ
lifecycle symmetric across open/close and future resize paths.

request_irq() is wired with &adapter->napi[i] as dev_id per queue, so
interrupt ownership follows the NAPI instance that services that RX
queue.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 160 +++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 95068fb20dba..b5ae979c1f82 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -315,6 +315,166 @@ static void __maybe_unused ibmveth_cleanup_rx_resources(struct ibmveth_adapter *
 	}
 }
 
+/**
+ * ibmveth_toggle_irq - Common helper to enable/disable queue interrupts
+ * @adapter: ibmveth adapter structure
+ * @queue_index: Index of the queue (0 for primary, 1+ for subordinate)
+ * @enable: true to enable, false to disable
+ *
+ * For queue 0 (primary), uses h_vio_signal() as it's registered via
+ * h_register_logical_lan(). For subordinate queues (1+), uses H_VIOCTL
+ * with H_ENABLE/DISABLE_VIO_INTERRUPT for per-queue interrupt control.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int
+ibmveth_toggle_irq(struct ibmveth_adapter *adapter, int queue_index, bool enable)
+{
+	unsigned long rc;
+	unsigned long irq = adapter->queue_irq[queue_index];
+	const char *action = enable ? "enable" : "disable";
+
+	if (queue_index == 0) {
+		/* Primary queue: use h_vio_signal() */
+		rc = h_vio_signal(adapter->vdev->unit_address,
+				  enable ? VIO_IRQ_ENABLE : VIO_IRQ_DISABLE);
+	} else {
+		/* Subordinate queues: use H_VIOCTL with hardware IRQ */
+		struct irq_data *irq_data = irq_get_irq_data(irq);
+		irq_hw_number_t hwirq;
+		u64 vioctl_cmd = enable ? H_ENABLE_VIO_INTERRUPT : H_DISABLE_VIO_INTERRUPT;
+
+		if (!irq_data) {
+			netdev_err(adapter->netdev,
+				   "Failed to get IRQ data for queue %d (virq=%lu)\n",
+				   queue_index, irq);
+			return -EINVAL;
+		}
+
+		hwirq = irqd_to_hwirq(irq_data);
+		rc = plpar_hcall_norets(H_VIOCTL,
+					adapter->vdev->unit_address,
+					vioctl_cmd,
+					hwirq, 0, 0);
+
+		if (rc == H_PARAMETER) {
+			/* H_PARAMETER is non-fatal when IRQ is already in the requested state. */
+			netdev_warn_once(adapter->netdev,
+					 "H_VIOCTL %s IRQ returned H_PARAMETER for queue %d (hwirq=%lu)\n",
+					 action, queue_index, hwirq);
+			return 0;
+		}
+	}
+
+	if (rc)
+		netdev_err(adapter->netdev,
+			   "Failed to %s IRQ for queue %d, rc=%ld\n",
+			   action, queue_index, rc);
+	return rc;
+}
+
+/**
+ * ibmveth_disable_irq - Disable interrupt for a specific queue
+ * @adapter: ibmveth adapter structure
+ * @queue_index: Index of the queue (0 for primary, 1+ for subordinate)
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int
+ibmveth_disable_irq(struct ibmveth_adapter *adapter, int queue_index)
+{
+	return ibmveth_toggle_irq(adapter, queue_index, false);
+}
+
+/**
+ * ibmveth_enable_irq - Enable interrupt for a specific queue
+ * @adapter: ibmveth adapter structure
+ * @queue_index: Index of the queue (0 for primary, 1+ for subordinate)
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int
+ibmveth_enable_irq(struct ibmveth_adapter *adapter, int queue_index)
+{
+	return ibmveth_toggle_irq(adapter, queue_index, true);
+}
+
+/**
+ * ibmveth_setup_rx_interrupts - Register IRQs and enable NAPI
+ * @adapter: ibmveth adapter structure
+ *
+ * Registers interrupt handlers for all RX queues and enables NAPI polling.
+ * On error, cleans up any successfully registered IRQs before returning.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int __maybe_unused
+ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i, rc;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (!adapter->queue_irq[i]) {
+			netdev_err(netdev, "queue %d has invalid IRQ (0)\n", i);
+			rc = -EINVAL;
+			goto err_free_irqs;
+		}
+
+		rc = request_irq(adapter->queue_irq[i], ibmveth_interrupt,
+				 0, netdev->name, &adapter->napi[i]);
+		if (rc) {
+			netdev_err(netdev,
+				   "request_irq() failed for irq 0x%x queue %d: %d\n",
+				   adapter->queue_irq[i], i, rc);
+			goto err_free_irqs;
+		}
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		napi_enable(&adapter->napi[i]);
+
+	return 0;
+
+err_free_irqs:
+	while (--i >= 0)
+		free_irq(adapter->queue_irq[i], &adapter->napi[i]);
+	return rc;
+}
+
+/**
+ * ibmveth_cleanup_rx_interrupts - Disable NAPI and free IRQs
+ * @adapter: ibmveth adapter structure
+ *
+ * Disables NAPI polling and frees interrupt handlers for all RX queues.
+ */
+static void
+ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		napi_disable(&adapter->napi[i]);
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (adapter->queue_irq[i])
+			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
+	}
+
+	/* Dispose IRQ mappings for subordinate queues (1-15).
+	 * Queue 0 uses netdev->irq from device tree, not irq_create_mapping().
+	 */
+	for (i = 1; i < adapter->num_rx_queues; i++) {
+		if (adapter->queue_irq[i]) {
+			irq_dispose_mapping(adapter->queue_irq[i]);
+			adapter->queue_irq[i] = 0;
+		}
+	}
+
+	/* Clear queue 0 IRQ number */
+	adapter->queue_irq[0] = 0;
+}
+
 /* setup the initial settings for a buffer pool */
 static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
 				     u32 pool_index, u32 pool_size,
-- 
2.39.3 (Apple Git-146)


