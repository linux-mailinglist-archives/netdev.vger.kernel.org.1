Return-Path: <netdev+bounces-303264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id trkqAEXaQ2r3kAoAu9opvQ
	(envelope-from <netdev+bounces-303264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:01:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A12E76E5AD4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:01:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b="GgNap/rj";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303264-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303264-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91B173099C80
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5619843E490;
	Tue, 30 Jun 2026 14:54:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1026F3E44ED
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:54:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831271; cv=none; b=A2S40GWWIuHVmeuYeaCNhImomhbPc7WdLmIxzDcVd0RgT+RyEUD1gyTHgaYelOlNjIA61r9Fr5EUIW1DteOoF0NF5HxNxojzcEha4AFMhNyHrFLG+Dpj7XW4J0gF+33XF3ziS64gmGYHrS6hX6N7oPBvwWOE4HcA6B8FbOCGwTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831271; c=relaxed/simple;
	bh=SQbyuXPZrKx2Xwi3u2Eh63Xixy9JmN/zsvsC4XrG0zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOreeLUVuXZzp3DzlSWsbi+0sFv7h3NESWnqg96rgtYCC+DNNMlppV+LOiGK677EpGLH3V3KhT3dlsjliccRxFaSt1ltv6oD01Sjb6YCEKn76REf6oF3z0V6OTA+yWgjfNRarK4/IYn6gsnZDEvf8Os8AkvitTByO4lFZv9P8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GgNap/rj; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIULb2429237;
	Tue, 30 Jun 2026 14:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zxTeHAu7CJl9EE90C
	V1wDO0BEY6issVH4xMbCABDzvA=; b=GgNap/rjBde8c+//y5u1qj7rpoly9y1fq
	AygkqtIIGm6NEroXlZISkFLCWJWfUc0kxXKvrgVKrzafAmxe4S52/i2/jtHWAeO7
	2RjaBN/cB4mkecuVw6UlA6qmW9CRJuxAz5R9gbEjsgMQ8nGxOUP0AUc4pz6wzt5O
	OkLx+IPINnC/L5JOUuGB1INFelm+qdbbM7akhdTpyVmIf/UgpPyhvWn6Mc9MbrmK
	as4OPqqf/EZUYjJ6o+l4llK5teJiYqKPxs9Tr8aspgCm1n30p3KLQZ8husq0sHeT
	xkNSSzbYP3SPrsyPpeQa8hNwVm3G2/xL7slLz42WlDIr+osXHIaDQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfycfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEnkhc025257;
	Tue, 30 Jun 2026 14:54:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk2s56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UEsGXT27394740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:54:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1D605805D;
	Tue, 30 Jun 2026 14:54:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9047A5805F;
	Tue, 30 Jun 2026 14:54:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:54:14 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 17/18] ibmveth: Wire ethtool set_channels to MQ RX queue resize
Date: Tue, 30 Jun 2026 07:53:24 -0700
Message-Id: <ccbd3b3bbee2004da411bf76fdc8187908524c69.1782758799.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a43d89b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=2fKdve7Y1yaNzeJZRasA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX/Ruxp4vHFMnO
 AzUgJhbPMG5YUuY1xr9AjhLyNAFDBeB4XMMN6H7DUmVxh83DnTZyMCXvoDxVIPwEjE0b5MsWHui
 Rn0z9vQAQLix/lKa0vEjJCM0obAJOPk=
X-Proofpoint-GUID: tUqCDJRKp6_vU9R66CY-H7SCzGop4CEI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX/Mx+VYarjhHz
 7AIJtGk0x16GEkz/NywXxY3nqvf4OkUvhNUxcEZnwhYJbgop9RklEehw+uQzKRUy8zgUFcCKKZv
 2H4tlu3WS9VgwDGdcQkg4wswzJWVBlln5tadGQJTJP8MFZkB5ZJThjyBXERx6Uh8T/dmxko/+gG
 0H7ggNUhuSM+5vDm422hGUEQBUnsEhO5SgGQM0mVa8sf4BttI9r0Ps3I86bl/SQJGq/iknaTDhj
 PasBuQgw5YUaUF3ij0zr38Op5+D3hJiHIwyzYuzvVMTxXmIP7jtJuHp6qB3yxg6msWP/4cChFy9
 sp+W9JlhOJ3dndbPuOFyMjGckOxHHB9XQoCHdImG/WTv0ckBHAVogSl81jeiXzfv0uf8yngkezU
 QbnRVl1EDyTKuxSmPFjGSVCvh+tybL4ydsmtMTFoHLI6D30CdI7gO5mH6OCA1frsc68vNUevH1Z
 EUkjiO1oR+Pm+O95cdg==
X-Proofpoint-ORIG-GUID: _-syxO7KT0csP5xDM0Vkhn5wO8E_LrQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303264-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	RSPAMD_URIBL_FAIL(0.00)[linux.ibm.com:query timed out];
	RSPAMD_EMAILBL_FAIL(0.00)[mmc@linux.ibm.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A12E76E5AD4

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


