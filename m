Return-Path: <netdev+bounces-303250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nq4bGp/YQ2pJkAoAu9opvQ
	(envelope-from <netdev+bounces-303250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:54:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0115A6E59BB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:54:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b="P5an/9Ki";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303250-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303250-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7463C304310C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F8449EB2;
	Tue, 30 Jun 2026 14:53:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D943DA25
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:53:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831238; cv=none; b=YMoz6LonwpMF2aalv9jbPa61thhCFybIvxrxGikat+bMkCjGBIicIFtOmIcb0leSA9FeePAoc+qTfk6pNTjr29hdEUHalj9b4fjn30Z5jnbeayLGAzWR5xHZUeDzL/TiE8oTALK9Dj/Dxd0mTsJe4qmzSTqv7xNaKnWGO6L2Hxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831238; c=relaxed/simple;
	bh=NJE/PfyBVcADkxIjhkQ5SbwpauEvpRZW/Xh6O/AtSr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EnBQ0BlZCbzqB9R7SvqVmNKiWc3A7cuJNfj87vOhgBP8/L+b7ZOq/TFIEVT4kKJuHW7OBpTO35/tkTLJqZjQZ1AK12oyIQNyvYx31mdAIolkHWdFQmVVv6RmkfxkvN31doRQPKi/umW3r7IinZN6AZ2kd5bTkJydlZTn/xvNRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P5an/9Ki; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIXnC2124802;
	Tue, 30 Jun 2026 14:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OJ1vYrEEmWYO3/G9L
	lHoav1dvMYSCFFf1slo6VtBhDg=; b=P5an/9KiU4iHQDYvwsEmyA1SSDp128/60
	Yq7LglvV7FdF54PltwtPcUUxfgGy5ebsXF2hsoX53mWtJrPTCvghAX30lEa16Lcy
	7tdWXkp8mTfLppuPhIoM1eO5UIwI1Z+PiMQnx/YqpM4PieiH8po+eDzcTwXf5cbC
	KatHViIw6DU6vVs8mwCZ7/jQEz55tj1CjUuZj9RHcP/d/P3SnLSzWmA4CTa9AIj7
	8euy/gyxF3ZWvOy0fdFjNBS2Gd2PZzuaQ4n8sBBgf2pP68zvU5+IUZ8C6AIkOuTv
	+q/52ptN+G8Z5PnbvNOXQHyW8O9r+JOcMInHgVI9MgFBI9ZX3E5vQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjq5c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEnd9T030620;
	Tue, 30 Jun 2026 14:53:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w2utc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:40 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UErcff22413934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:53:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D40235805A;
	Tue, 30 Jun 2026 14:53:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C5FD5805F;
	Tue, 30 Jun 2026 14:53:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:53:37 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 03/18] ibmveth: Add MQ-ready RX statistics structures
Date: Tue, 30 Jun 2026 07:53:10 -0700
Message-Id: <4a25fff1759b289e59b43fb33cf84cd2ce2868e9.1782758799.git.mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX+kRModf74+Vb
 ZpIeu9PLl2IGZAX3OT2bDrwrSCWCLE3077J50EACTe61WzHBxcMCqHV9/10o3JDJEOggiaQR3bu
 wvNuK+izyevpuiS6OZS1t+0zI73CIvqH6hjBxCKNiGD9y4uUUdp29/rCozczX1d8wQ+3ByTvPmw
 HfElKu9vHR9uEOe8M0jD4g1m4q6zneuhbtHe8v9sdAeIJ/afBNdiuBLafElul6hFcbutOPOOigo
 xWYTa8ebJQIdL7orac05Vd4T7XkP7SAvxmXbKD4VkQFxap113VEC+64zVsDQkArXseUAGom/OT+
 dBf6B9WJQt/6BhELzDQszS7Plt0gn1rTl67f+z4jZSgHUP+cx/p12kSixmnUdEMs4cBM2VRYRQ6
 DuLcvFb3KECr9+rvnv/MtLyjvhxfmBLaPzi80pn6VJ74mRb4fLcasLBIqdPaw+Wfua1Ab8iWilR
 fhwWp1++NJAuB4D2i6A==
X-Proofpoint-GUID: Rxb7BrG3shIKKRhNZSzFZM2P0NDC6AKX
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a43d875 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=QWtXbQDr_5sbzwRG9doA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfXyUyBJ42imRTa
 vvUjnBcNq5l0DFQfAQ4G1fBOXyhWXfA5LkL9bi7O5kJk9/ccNn8PzWw2LAxRuaEo/L63DjqdZxI
 98USLoGF5VvHA9zK521hbXZtbjRrAYA=
X-Proofpoint-ORIG-GUID: p9-0nmcyFLP40weGA6tTYrBy-MmIEuqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-303250-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0115A6E59BB

We'll want per-queue RX counters once MQ is running, and it's useful to
see whether the driver is hitting legacy or per-queue hcalls. Add the
structs and alloc helpers now, wire them up later:

ibmveth_hcall_stats for register/add/free/send hcall counts,
ibmveth_rx_queue_stats for per-queue packets/bytes/polls/etc.,
ibmveth_alloc_rx_qstats() / ibmveth_free_rx_qstats().

Marked __maybe_unused until open and the RX path start using them. No
behavior change yet.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 27 +++++++++++++++++++++++++++
 drivers/net/ethernet/ibm/ibmveth.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 4f9dbee7477d..8f9f927bff23 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
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
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index b17894695c2e..f0dffe42e8fe 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -290,6 +290,30 @@ static int pool_active[] = { 1, 1, 0, 0, 1};
 
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
@@ -352,6 +376,11 @@ struct ibmveth_adapter {
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


