Return-Path: <netdev+bounces-303267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kIuSEfHZQ2rekAoAu9opvQ
	(envelope-from <netdev+bounces-303267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:00:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD36E5AAB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:00:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=d5+YhJhu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303267-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303267-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D16D1305B4A3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A3E44D011;
	Tue, 30 Jun 2026 14:54:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE02944102E
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:54:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831273; cv=none; b=lD9QE0XQe6wSMAb/yNOH0dVEF5OEo0wBrO3m39lMAM1NgOLapKsFD7GPrC9EvkycdzPKh2fiQiKMJ5BByAKtQaF7vYWX4+9LIhL+BxiI0gW3Yvpn+aAfN/CKOpy2Dj2osjQnhbQQYg8PkETNz/80aHCvhjdtdunIeBd5erpiOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831273; c=relaxed/simple;
	bh=lfY1BPxGWhADpJp9Ko6tp8pAnOvHrLtkOS1G/4nji+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZS87XtyIKgZOc7QBbeJ8vjWRfok8GgGVzMcA5elwB0SqddFgPfqwUcFRJVyZ7eVMA4EFa2CANZUL6fCRYF+1zXjfdUe6HYlsdnpZDveSAdvi9xtgd/kRF8sodyVhjmjl1uV2heZRM1X2iJnS8ptvR/Ii8vjkm9217lHUD0YKk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d5+YhJhu; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIWO82289073;
	Tue, 30 Jun 2026 14:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5WFgnhjFb3ujhWuLu
	5dC/j92ByllA3Et568vLAlecps=; b=d5+YhJhuZWHmzxXUvUXEtlZlUsC+yzAW2
	IKknIJXy80xuW28cqCx8kp/Lfwo1tTgHJId+snSioIv7dzUd00Z5QfvVAquQWIHj
	S/D6fVUuqeodxrQ8eFVLPWphguv75RbWUZH9KOth7NmCH18XzZZTBede86eXB80f
	D/FSuTInl/qV3cCm2BEu1HAfLCmVzHjntxEKE/fdZvZ9Y8bN6WnlYTTudePGeljs
	S1J7atrUBgQFRFGjjrt6ux1qxk7qNRIxnH94m5oyjI6CihBauYZX2hN/pd2rK6bA
	ZAWeZDF9cMpGE+9dmVqquLANYJa6alHsC6ky6vjERL5Ccw0jUZ53g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdye9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEndGd024608;
	Tue, 30 Jun 2026 14:54:19 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gakv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UEsIag31261328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:54:18 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 263D65805C;
	Tue, 30 Jun 2026 14:54:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C10C15805D;
	Tue, 30 Jun 2026 14:54:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:54:16 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 18/18] ibmveth: Fix MQ RX poll and shutdown hangs after queue resize
Date: Tue, 30 Jun 2026 07:53:25 -0700
Message-Id: <3cc4bebd422a70e883be8a515bfe6b0b2a9b9788.1782758799.git.mmc@linux.ibm.com>
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
X-Proofpoint-GUID: p7XXJdd_fiVs1EnTYCaQ6maM2NeCxjcn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfXw8ErIUeJtcSD
 ODotwDJ2pjlF/iveKntySHh8/9ncXcR9aYGpo9xVHEhGm3XDv4wr3Ub20YWUGX4lxF9/dDZQVYW
 vHD4RbwOieKJZK+YiQ3a8BKKzexcPLI=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a43d89c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=H2PsU0_gVjd1cLIlZ3YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX2hzoUkVF1A1+
 lqENG/AIIL4z10BaqJdCCqjKi/Zlo3nnyF+3ChLzvleyLYr3hAJwlY8UFpWwLhk2luSkabuVNA9
 DhmOr+pKJvhKJ1QJo3eLgQ4S0WsDLSez7JCsvTQ3oYxbmC9/WoChGs+T844GBetUgKCCDJ75Hev
 5f9h8mLkymln6hShdp3I3FDOf+6KrU5pmY/l0PT6vD0ah9qKeI3FF0oiVimoF6f/7UtEx5O4RGj
 6sWltz95mZfKukboHHrYun2vNw4ZdAIRNyO+h2DoUYBDNm4BS9OkvRptMwZ/IUYRamsw8wZFwus
 di0+923e860qapF1bE1Hc2gz8slJaX+XKO8jIuI2LkgIPLVPp9yDUHwNer1C3DafDpzv5XaE078
 tjnV9i/gN5EoucJw0wSI+iOp/V4OkJysUU/0A23vM+t1IvcpRtuSwxIgATfrTGHfIEC7EHBijiX
 W4u3vFPT0KWGPKQ6Ucg==
X-Proofpoint-ORIG-GUID: fPThb1TAoP7H2095qITOBcKbMo9kPp_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
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
	TAGGED_FROM(0.00)[bounces-303267-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 98BD36E5AAB

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


