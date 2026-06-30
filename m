Return-Path: <netdev+bounces-303248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2i5rGpjZQ2q4kAoAu9opvQ
	(envelope-from <netdev+bounces-303248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:58:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 027B56E5A7C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:58:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=HBP0FPgi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303248-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303248-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8169D3102048
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F323B43D516;
	Tue, 30 Jun 2026 14:53:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6843E4BE
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:53:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831234; cv=none; b=mpdI9Cxj+xEEuGNN/nn62EVglIa7y56p2RLlJpstrog+46zeN3fImmqd/lagzkkzBsg2ckbAfNQsJhoJcA5b9fG8uiB2TZXE4MYRH3eu0QOShxrTh/mvw2YfK2t+MYPjrGUnRFY9elos4Sd6Tpa5vFLiU3H3fUwn0ln+Git/4R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831234; c=relaxed/simple;
	bh=qkYYx/CCb+IWiPwjSa3tz1/tM0E1KBPOEc0cPKx/5wU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FlSS9xpTSLU+I8hBOVizUdg3Pv25YBXW3Jw41alfCL7OS4ZV1Y2YVfyQctQHE0bdZgBXgSyg4Yv8lIVdR+8OuFJPxtJpPwZ7z5KQIyt2KHykle2PeQ/k0vVkcSsrtDE72QfuS3VPUSaO54JSpY+nqaRr5lZiUEs8FKlKwKiEVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HBP0FPgi; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIJJ32233391;
	Tue, 30 Jun 2026 14:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xyVghz0BdLLck4MWc
	Y4YY/JnDc/q9kOQqZCD96Q900o=; b=HBP0FPgid+SlsbCykmWKOQri0AWIFq9hl
	TI5cNbYGl7OOhNFoJHsf6n4KZH8/w6fXu7me5h0xlNJ64p6e4f8w0sjCcpjjv8jc
	pIm6g7q/evR+6cZxNzVctrjUn1+scu19ha+uVUVyadpHZN2yiVqM1z/BLf/B+D7x
	U8nINtecR0zhTVpjLo46lBqqILDvZ2eoSPIinpgrl9z1GsTwaNd0C84wPTSwvI/V
	BLbQjs/kBMfpxBaLogTKO0X5Ch+qqzYXcUFvwHrLd5rQsbPF75jly2PgS8ZX/mix
	quS/B9koYsanWv+veVUk0aetAEMFgnwouUsxMHGdkNYHTwLd4jKhA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5qdj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEnflO000654;
	Tue, 30 Jun 2026 14:53:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhapf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UErYWs17302132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:53:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C2D05805C;
	Tue, 30 Jun 2026 14:53:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8D0A5805D;
	Tue, 30 Jun 2026 14:53:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:53:32 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 01/18] ibmveth: Add MQ RX hypercall wrappers and call definitions
Date: Tue, 30 Jun 2026 07:53:08 -0700
Message-Id: <9395d1ff1f5cbc64843c184828850352ff9af909.1782758799.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1782758799.git.mmc@linux.ibm.com>
References: <cover.1782758799.git.mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX8R2mW7oO3d+g
 +VSInXLrhbNGwoTyR7ssSGYv5eaUMV3MgVP0gRlpzKdaVuxK3FnodUQ6lEnkCo46jBI9zQif/fX
 i619J7RQQcEEXrT1MzUoM//QgRCntzW10S65iTzJUtn1xgdlTHXOL3OxJ0YQ/qVdFLedbXrJJlD
 SYpuKUH/aXMaCiu4Kjc6VEiFVBQETnIQVW8s95ptXSAhzeEQhQ7b7VExFRsmDMVA9fhgOEmjCYO
 tUKxyzGiEJmTp2HAY88JkZ1TRGtbH0HUzKJV8ZsuxKkE5Jsc5TuBL2gwEdPzlwvkf/Unc9KurrR
 ATAjG/miL5AT3v9jcFp38qFlKOO02XqXS3w2F8bu5GqHMwkYeEK5URU7nO0fFKI38hMOALOfS57
 h1QRA52EwgFBuQfSZmpbjuwV1a2m5zsV6cNgxmJwa0FpriMXbywy40ffYJpL0mXOG5pSIX1l1YW
 ZJsM1MjmoQXeQUTzSpA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a43d870 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=MvuV-DllYkNUqFi9bgAA:9
X-Proofpoint-ORIG-GUID: 0BOzDIWOqChANJJOYi8MeNJu44_sQLlV
X-Proofpoint-GUID: V9LBy-6dj6ALN0TNzV68_AHiOwvT5KML
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX73JeXLQUxmiw
 NxVdS6E+0+gZY1qrphD9T5WC+6V9bJvS63y3FMBFX75v1xoy+xECTcfDIWrM0aBPJCr8jNpP6FH
 mpWiDMziH1lz7YZ84JTzItVU1bk5aHg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-303248-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 027B56E5A7C

Single-queue ibmveth only needs h_register_logical_lan() plus legacy
buffer add/free calls. MQ RX uses per-queue handles, so the driver must
also be able to register/deregister subordinate queues and post/free
buffers against a specific queue handle.

Add the PHYP call IDs for:

  H_REG_LOGICAL_LAN_QUEUE
  H_ADD_LOGICAL_LAN_BUFFERS_QUEUE
  H_FREE_LOGICAL_LAN_BUFFER_QUEUE
  H_FREE_LOGICAL_LAN_QUEUE

and add ibmveth.h wrapper helpers (h_reg_logical_lan_queue(),
h_add_logical_lan_buffers_queue(), h_free_logical_lan_buffer_queue(),
h_free_logical_lan_queue()) with argument ordering and return semantics
matching the existing ibmveth hcall wrappers.

This patch is intentionally plumbing only: no runtime behavior change
yet. Legacy firmware keeps H_REGISTER_LOGICAL_LAN and the existing
buffer hcalls. The new wrappers are used only when a later commit sets
multi_queue from H_ILLAN_ATTRIBUTES.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h  |   6 +-
 drivers/net/ethernet/ibm/ibmveth.c |   3 +-
 drivers/net/ethernet/ibm/ibmveth.h | 158 +++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index dff90a7d7f70..bf2f1b0356c4 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -362,7 +362,11 @@
 #define H_GUEST_DELETE		0x488
 #define H_PKS_WRAP_OBJECT	0x490
 #define H_PKS_UNWRAP_OBJECT	0x494
-#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
+#define H_REG_LOGICAL_LAN_QUEUE 0x49C
+#define H_ADD_LOGICAL_LAN_BUFFERS_QUEUE 0x4A0
+#define H_FREE_LOGICAL_LAN_BUFFER_QUEUE 0x4A4
+#define H_FREE_LOGICAL_LAN_QUEUE 0x4A8
+#define MAX_HCALL_OPCODE	H_FREE_LOGICAL_LAN_QUEUE
 
 /* Scope args for H_SCM_UNBIND_ALL */
 #define H_UNBIND_SCOPE_ALL (0x1)
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 73e051d26b9d..af287eeafc0c 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -584,7 +584,8 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 }
 
 static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
-        union ibmveth_buf_desc rxq_desc, u64 mac_address)
+				   union ibmveth_buf_desc rxq_desc,
+				   u64 mac_address)
 {
 	int rc, try_again = 1;
 
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index d87713668ed3..45cfb0d054e3 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -66,6 +66,164 @@ static inline long h_add_logical_lan_buffers(unsigned long unit_address,
 			    desc5, desc6, desc7, desc8);
 }
 
+/**
+ * h_reg_logical_lan_queue - Register a subordinate receive queue
+ * @unit_address: Device unit address
+ * @buffer_list: DMA address of 4KB page for tracking registered buffers
+ * @rec_queue: Buffer descriptor of receive queue
+ *
+ * Registers a subordinate receive queue with the hypervisor.
+ *
+ * Return:
+ *   H_SUCCESS (0) on success
+ *   H_PARAMETER if parameters are invalid
+ *
+ * On success, hypervisor returns:
+ *   R3: H_SUCCESS
+ *   R4: Queue handle
+ *   R5: IRQ number for this queue
+ */
+static inline long h_reg_logical_lan_queue(unsigned long unit_address,
+					   unsigned long buffer_list,
+					   unsigned long rec_queue,
+					   unsigned long *queue_handle,
+					   unsigned long *irq)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	long rc;
+
+	rc = plpar_hcall9(H_REG_LOGICAL_LAN_QUEUE,
+			  retbuf, unit_address,
+			  buffer_list, rec_queue);
+
+	if (rc == H_SUCCESS) {
+		if (queue_handle)
+			*queue_handle = retbuf[0];
+		if (irq)
+			*irq = retbuf[1];
+	}
+
+	return rc;
+}
+
+/**
+ * h_add_logical_lan_buffers_queue - Add buffers to subordinate queue
+ * @unit_address: Device unit address
+ * @queue_handle: Queue handle from h_reg_logical_lan_queue()
+ * @buffersznum: Buffer size (upper 32 bits) | count (lower 32 bits)
+ * @ioba12: Buffer addresses 1 and 2 packed (addr1 | addr2 << 32)
+ * @ioba34: Buffer addresses 3 and 4 packed
+ * @ioba56: Buffer addresses 5 and 6 packed
+ * @ioba78: Buffer addresses 7 and 8 packed
+ * @ioba910: Buffer addresses 9 and 10 packed
+ * @ioba1112: Buffer addresses 11 and 12 packed
+ *
+ * Return:
+ *   H_SUCCESS - All buffers added successfully
+ *   H_PARAMETER - Invalid parameters
+ *   H_HARDWARE - Hardware error
+ */
+static inline long h_add_logical_lan_buffers_queue(unsigned long unit_address,
+						   unsigned long queue_handle,
+						   unsigned long buffersznum,
+						   unsigned long ioba12,
+						   unsigned long ioba34,
+						   unsigned long ioba56,
+						   unsigned long ioba78,
+						   unsigned long ioba910,
+						   unsigned long ioba1112)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+
+	return plpar_hcall9(H_ADD_LOGICAL_LAN_BUFFERS_QUEUE,
+			    retbuf, unit_address,
+			    queue_handle, buffersznum,
+			    ioba12, ioba34, ioba56,
+			    ioba78, ioba910, ioba1112);
+}
+
+/**
+ * h_free_logical_lan_buffer_queue - Free buffer from subordinate queue
+ * @unit_address: Device unit address
+ * @buf_size: Size of buffer to remove from pool
+ * @queue_handle: Queue handle from h_reg_logical_lan_queue()
+ *
+ * Removes a buffer of specified size from the subordinate queue's buffer pool.
+ *
+ * Return:
+ *   H_SUCCESS - Buffer removed successfully
+ *   H_PARAMETER - Invalid parameters
+ *   H_HARDWARE - Hardware error
+ *   H_NOT_FOUND - Buffer pool does not exist
+ */
+static inline long h_free_logical_lan_buffer_queue(unsigned long unit_address,
+						   unsigned long buf_size,
+						   unsigned long queue_handle)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+
+	return plpar_hcall9(H_FREE_LOGICAL_LAN_BUFFER_QUEUE,
+			    retbuf, unit_address, buf_size, queue_handle);
+}
+
+/**
+ * h_free_logical_lan_queue - Deregister subordinate receive queue
+ * @unit_address: Device unit address
+ * @queue_handle: Queue handle from h_reg_logical_lan_queue()
+ *
+ * Deregisters and frees all structures associated with the subordinate queue.
+ *
+ * Return:
+ *   H_SUCCESS - Queue freed successfully
+ *   H_PARAMETER - Invalid parameters
+ *   H_HARDWARE - Hardware error
+ *   H_STATE - VIOA not in valid state
+ *   H_BUSY / H_LONG_BUSY_* - Resource busy, retry
+ */
+static inline long h_free_logical_lan_queue(unsigned long unit_address,
+					    unsigned long queue_handle)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+
+	return plpar_hcall9(H_FREE_LOGICAL_LAN_QUEUE,
+			    retbuf, unit_address, queue_handle);
+}
+
+/**
+ * h_register_logical_lan_with_handle - Register primary queue and get handle
+ * @unit_address: Device unit address
+ * @buffer_list: DMA address of buffer list
+ * @rec_queue: Buffer descriptor of receive queue
+ * @filter_list: DMA address of filter list
+ * @mac_address: MAC address
+ * @queue_handle: Output parameter for queue handle
+ *
+ * Registers the primary receive queue (queue 0) with the hypervisor and
+ * returns the queue handle. This is needed in multi-queue mode to use
+ * h_add_logical_lan_buffers_queue() for all queues including queue 0.
+ *
+ * Return: H_SUCCESS (0) on success, error code otherwise
+ */
+static inline long h_register_logical_lan_with_handle(unsigned long unit_address,
+						      unsigned long buffer_list,
+						      unsigned long rec_queue,
+						      unsigned long filter_list,
+						      unsigned long mac_address,
+						      u64 *queue_handle)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	long rc;
+
+	rc = plpar_hcall9(H_REGISTER_LOGICAL_LAN, retbuf,
+			  unit_address, buffer_list, rec_queue,
+			  filter_list, mac_address);
+
+	if (rc == H_SUCCESS && queue_handle)
+		*queue_handle = retbuf[0];
+
+	return rc;
+}
+
 /* FW allows us to send 6 descriptors but we only use one so mark
  * the other 5 as unused (0)
  */
-- 
2.39.3 (Apple Git-146)


