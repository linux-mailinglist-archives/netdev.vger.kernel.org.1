Return-Path: <netdev+bounces-305218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LiP/B2EETGpqewEAu9opvQ
	(envelope-from <netdev+bounces-305218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:39:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A1F71514E
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:39:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=OVyrfjT8;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305218-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305218-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E723303D54F
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 19:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04343346A5;
	Mon,  6 Jul 2026 19:37:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960C33D4E2
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 19:37:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366639; cv=none; b=KIcm48HtrQkpJ+j3rxIG4UJzATrXnPJi7U2FT024s0II+oRFBBd+//2OvUyT7j4Tm0+pYByQM3RZYfPLbR/r6QUFGS5hkSzDGrAmSFGXV+QFjoqz9BBNfs4ZLW7YioMv8jJBcImtmQyl4mGpAyb6zV2Bcuuj3on2hCWdIaT1+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366639; c=relaxed/simple;
	bh=SQbyuXPZrKx2Xwi3u2Eh63Xixy9JmN/zsvsC4XrG0zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jZov5fYUmtH41/0Ri8ndcK7BUfdUEv3xoiW0GHU9X2wjnx5uE2pckrUNh/aIFVmwZh0ofm8sW1uMuocFbAv7RR85dF+V8MBwEExFhinxuJ+aT+8LevTxw2SSPOUUbx4ib9JdZF1Uq6SOyXsHCZoJ35ZdlRv8y2OfvOzi3JfUPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OVyrfjT8; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIIhC4049887;
	Mon, 6 Jul 2026 19:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zxTeHAu7CJl9EE90C
	V1wDO0BEY6issVH4xMbCABDzvA=; b=OVyrfjT89X7xhqcLl8cz/7aFE02r9Y4kl
	0ilggy0A6U48Qy4Fc+lzyty0+NgV1FzjMcbzHA7LLs/VS4jLs6zuMb48Oj2rfLmu
	DoHV3Xa7weJLKqBGP0Lyj2cGOnpUnqMnqZ5YMRGyCgTLmUcuPd2zYXU2pvjhoCwj
	ZiAur+hVUZpsJablev1dND+N8EEcpNjDNUtWetSQzZKzragaPSqqz9Jv0i73mQc4
	ChFAmkS2tXqRxeR+L0RZ0rWWjmRbd4LIqNmaCLps0psAXNRlZzlNJ+lnaSY6JH1b
	zH3kVOxYADH6mvMBS9UkNTKMXC6+4K0T8VZw2A/uTDgrvRw4eFIXw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stskk0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:37:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYZqS004294;
	Mon, 6 Jul 2026 19:37:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfxr80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:37:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666Jb3mf66453870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:37:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC8545805C;
	Mon,  6 Jul 2026 19:37:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0D158051;
	Mon,  6 Jul 2026 19:37:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:37:02 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 14/15] ibmveth: Wire ethtool set_channels to MQ RX queue resize
Date: Mon,  6 Jul 2026 12:36:02 -0700
Message-Id: <20260706193603.8039-15-mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: PuoPs8r5rKUaAX0XdoL74Lch6N2uV9IB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfXywqts3mkU43E
 HYEf/r5ZHinGv3Kc9DGFWa4bgk6cHOKGJKHmUZ5lTLgI/IXx5FEV1RJsgk2iQ807Zbcol5xebrM
 GAdhn0+RYpdLk/pFtQkKrCA30b2ix3E=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4c03e1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=2fKdve7Y1yaNzeJZRasA:9
X-Proofpoint-GUID: d1t-F07jPnYuuvagBrDh1mn2ncPwZjJo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX/XXSjHjFF60u
 VQk8nnqHqo8LRSeqCL5IINe9dQ/K4z72lXb1jWKm3t2ril06K0rNeDRGh4e6kCOHKClqUbB+MVT
 RHJNXGogVxd7J440AGeCQ+jynKUxQKFuxncNgO/Oi8dAWjTWfjcWXR/yl0ED2xck2T/LXqmDp89
 in3In/RAUlhHrJPKIlhCQOE254d9+zrucr+xrHFNu49dXOaLnqKpbRP3HIhQdqBhEBeEjNe5Lqs
 q9t+xfGWhxby6tHT/W9kdsxFmEmV+/v2brG72bMK2qJR0M1cqmGFoVYea1X/cUwQXDBBeoDwRyt
 fWVIzzTZmqmXDWl+Ezf9u2EPwM2Rk+CFOTcBMx74EGmRGpwtYIDPb07o/3UcD8XmfH4NhHfOPk7
 oCTJ0fCW8G1XoHpyLWsiWU5XB7XElIx+gvb7cO/AIbnrE+PN+VPRPBgOVWDBkwtsNpTr+3wZWCB
 qzaAdEC+3E9Aurz8a0w==
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
	TAGGED_FROM(0.00)[bounces-305218-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 74A1F71514E

Expose incremental RX resize through ethtool channel control.

get_channels() reports rx_count from adapter->num_rx_queues and max_rx
as IBMVETH_MAX_RX_QUEUES when MQ firmware is enabled, else 1.

set_channels() validates rx_count is within 1..IBMVETH_MAX_RX_QUEUES.
When rx_count changes and the interface is up, call
ibmveth_resize_rx_queues_incremental(). When the interface is down,
store the requested rx_count in adapter->num_rx_queues so the next open
registers that many queues. Non-MQ firmware returns -EOPNOTSUPP for
rx > 1.

TX queue changes keep existing stop/wake behavior when tx_count changes.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 58 +++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index ac4d89a66a8d..50a332ab83fd 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -2534,19 +2534,69 @@ static int ibmveth_set_channels(struct net_device *netdev,
 				struct ethtool_channels *channels)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	unsigned int old = netdev->real_num_tx_queues,
-		     goal = channels->tx_count;
+	unsigned int old_rx = adapter->num_rx_queues;
+	unsigned int goal_rx = channels->rx_count;
+	unsigned int old = netdev->real_num_tx_queues;
+	unsigned int goal = channels->tx_count;
+	int rxq_entries = adapter->rx_queue[0].num_slots;
 	int rc, i;
 
 	/* If ndo_open has not been called yet then don't allocate, just set
 	 * desired netdev_queue's and return
 	 */
-	if (!(netdev->flags & IFF_UP))
+	if (!(netdev->flags & IFF_UP)) {
+		if (goal_rx > 1 && !adapter->multi_queue) {
+			netdev_err(netdev,
+				   "Cannot resize to %u RX queues: multi-queue mode not supported by firmware\n",
+				   goal_rx);
+			return -EOPNOTSUPP;
+		}
+
+		if (goal_rx < 1 || goal_rx > IBMVETH_MAX_RX_QUEUES) {
+			netdev_err(netdev,
+				   "Invalid RX queue count %u (must be 1-%d)\n",
+				   goal_rx, IBMVETH_MAX_RX_QUEUES);
+			return -EINVAL;
+		}
+
+		/* Stash desired RX count; open() publishes it via
+		 * netif_set_real_num_rx_queues() after queue registration.
+		 */
+		if (goal_rx != adapter->num_rx_queues)
+			adapter->num_rx_queues = goal_rx;
+
 		return netif_set_real_num_tx_queues(netdev, goal);
+	}
+
+	if (goal_rx > 1 && !adapter->multi_queue) {
+		netdev_err(netdev,
+			   "Cannot resize to %u RX queues: multi-queue mode not supported by firmware\n",
+			   goal_rx);
+		return -EOPNOTSUPP;
+	}
+
+	if (goal_rx < 1 || goal_rx > IBMVETH_MAX_RX_QUEUES) {
+		netdev_err(netdev,
+			   "Invalid RX queue count %u (must be 1-%d)\n",
+			   goal_rx, IBMVETH_MAX_RX_QUEUES);
+		return -EINVAL;
+	}
+
+	if (goal_rx != old_rx) {
+		rc = ibmveth_resize_rx_queues_incremental(adapter, goal_rx,
+							  rxq_entries);
+		if (rc) {
+			netdev_err(netdev, "Failed to resize RX queues: %d\n", rc);
+			return rc;
+		}
+	}
 
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
 	 * but we may need to alloc/free the ltb's.
 	 */
+	if (goal == old)
+		return 0;
+
 	netif_tx_stop_all_queues(netdev);
 
 	/* Allocate any queue that we need */
@@ -2580,7 +2630,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 
 	netif_tx_wake_all_queues(netdev);
 
-	return rc;
+	return 0;
 }
 
 static const struct ethtool_ops netdev_ethtool_ops = {
-- 
2.39.3 (Apple Git-146)


