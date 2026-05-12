Return-Path: <netdev+bounces-286979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DmHMgjXAmpXyAEAu9opvQ
	(envelope-from <netdev+bounces-286979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:30:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F5D51BD96
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9B2303D2D2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D4B47A0C2;
	Tue, 12 May 2026 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lUXMmUla"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95192379C5F;
	Tue, 12 May 2026 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570656; cv=none; b=pEC2G/vhHIAyR5KwTV/VzIqDMjfbAWVPZBfvfqJwBc4VKKA3BoGTfYQjT7eYxl+fwHzSAeMhL8kvn4DL4xoKMBcED+XMKihKjMs0Zql2Iyyyso8JrNSu4AKLdpuJR5LHYFR9dAF+BNlO9zRux2IAAkpYGHCV7KteTSp3xGB4nhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570656; c=relaxed/simple;
	bh=Q8m6yJUAzZ1DjBo1Ixq9BK6Whyd7fptgdjG/9Qab3rA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S8IoeM2S5Htoml46W4vpOQG/cb8rI7bPl9i61JdPUdpJq1+Yh17l1jCvu6QoYcPxHMtUxOhkrJGt4Hl3Xme6Szt3n4E3FIyb3AUYYmooA1/8jBtdrbzXoF9tq3txAuKHJtVMZ5yaSXudRVP+rSAAd+BoXDHJjZanCuo7jMkjv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lUXMmUla; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK5wbG276015;
	Tue, 12 May 2026 00:23:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=T4H+J9WLDC5qHv1EsOkjJz7
	BFbbOeejtKz2mlsp8SaU=; b=lUXMmUlaxYZfu8qnlTMclvdQWrVIvNtxwWXDL6J
	pUaaIK2WW6Rj2J1ISGH8YFlYchC0S1Zt7gB80+jRe5r6IQIvOh993MNqlWfrlkKS
	eiCETVOCz7p/I7ku4AkfUdmtfEyDsuqIu2Dw52Q2UfVT91AHdy+XdZeML972ftFW
	js5LRe1HUURSYHxMmt/GLzjgapcWIYaFmc4kcO0Gx+VWnIFvIOcTXTFsGhJHkuwZ
	KiqRXLjaWPBWhKKFlhOzWmX3rsu21fZ7J1SIP57gWCwmiF1xGBk8NGrfDCR0+Gho
	2PRbwrdMk5fdNeTGNQWMWEQhPBcYBP9YF9Ni9c7BwZ+Lw9w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e3nuqhne3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 00:23:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 12 May 2026 00:23:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 12 May 2026 00:23:47 -0700
Received: from hyd1vellox1.032marvell.com032caveonetworks.com (unknown [10.29.37.43])
	by maili.marvell.com (Postfix) with ESMTP id 58DA13F7062;
	Tue, 12 May 2026 00:23:42 -0700 (PDT)
From: Anshumali Gaur <agaur@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <sgoutham@marvell.com>,
        <bbhushan2@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH net-next v3] octeontx2-pf: Retain ethtool stats across interface down/up.
Date: Tue, 12 May 2026 12:53:38 +0530
Message-ID: <20260512072338.1460580-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: k0a4LadxCJInkmIdDHX5xUX5HU-tEdtY
X-Authority-Analysis: v=2.4 cv=TufWQjXh c=1 sm=1 tr=0 ts=6a02d584 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=xvtfhBl5x4iTznrZZiMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA3MSBTYWx0ZWRfX432UzIhAV24F
 v15w8DQCGeirzi6kCPtEvC5zLx6KpYBcBoxOyVrdgMYlhiprRnreCeKHCKtyQKrudl/kU5CO5BK
 1zcWWVFdZIq6+rGhOsZNlWwO5q/+ZVxGXDm2DUUBLuny266O1dRUPzysy1acVao6L3zkqZu74wn
 5sSlqZVlMy/+2RUpcvJb0tk1zdjRvjZPkIHSjG8KUAE4Ccl2DQCV2WnhT2g0z7ThK9e0cUVt0Gs
 8WFVPuh2BKo4lO4xSJFAj1NlNlSd2ioFdjlpEqewyjrI6LYYwDNx+mdS2Me/wDd/MFqWOZzgvLJ
 WbDqpZp3w6/qpriNMSQL1duvOAQn8ojktK6b3lBt9x130JuEgP8ODCju/91HPoUDDy+ljChfLDQ
 oHcsMNXQ/zmzjko5ZCALLQHU/cZy6vvbQwO+jdAK+cKSoCXYa9lMt3bD/3RVeQ4rpXqugBW2CK9
 fEiQ6Lkk4rv+XLS5USQ==
X-Proofpoint-ORIG-GUID: k0a4LadxCJInkmIdDHX5xUX5HU-tEdtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: 37F5D51BD96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286979-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agaur@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Currently the hardware counters reset when the interface is
brought down, causing stats visible to userspace to drop to zero.
Save the accumulated stats before bringing the interface down
so they persist across routine down/up cycles.

Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
v3:
  - Code format according to kernel coding style
  - Reword commit message
v2:
  - Fix subject prefix to target net-next
 .../marvell/octeontx2/nic/otx2_common.c       | 20 ++++++++++---------
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 17 ++++++++++++++++
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 971fcab1c248..0ffcc613a4b2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -139,19 +139,21 @@ void otx2_get_stats64(struct net_device *netdev,
 		      struct rtnl_link_stats64 *stats)
 {
 	struct otx2_nic *pfvf = netdev_priv(netdev);
-	struct otx2_dev_stats *dev_stats;
+	struct otx2_dev_stats *dev_stats, *old_stats;
 
 	otx2_get_dev_stats(pfvf);
 
 	dev_stats = &pfvf->hw.dev_stats;
-	stats->rx_bytes = dev_stats->rx_bytes;
-	stats->rx_packets = dev_stats->rx_frames;
-	stats->rx_dropped = dev_stats->rx_drops;
-	stats->multicast = dev_stats->rx_mcast_frames;
-
-	stats->tx_bytes = dev_stats->tx_bytes;
-	stats->tx_packets = dev_stats->tx_frames;
-	stats->tx_dropped = dev_stats->tx_drops;
+	old_stats = &pfvf->hw.old_stats;
+
+	stats->rx_bytes = old_stats->rx_bytes + dev_stats->rx_bytes;
+	stats->rx_packets = old_stats->rx_frames + dev_stats->rx_frames;
+	stats->rx_dropped = old_stats->rx_drops + dev_stats->rx_drops;
+	stats->multicast = old_stats->rx_mcast_frames + dev_stats->rx_mcast_frames;
+
+	stats->tx_bytes = old_stats->tx_bytes + dev_stats->tx_bytes;
+	stats->tx_packets = old_stats->tx_frames + dev_stats->tx_frames;
+	stats->tx_dropped = old_stats->tx_drops + dev_stats->tx_drops;
 }
 EXPORT_SYMBOL(otx2_get_stats64);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..ad65aa19b80d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -255,6 +255,7 @@ struct otx2_hw {
 
 	/* Stats */
 	struct otx2_dev_stats	dev_stats;
+	struct otx2_dev_stats	old_stats;
 	struct otx2_drv_stats	drv_stats;
 	u64			cgx_rx_stats[CGX_RX_STATS_COUNT];
 	u64			cgx_tx_stats[CGX_TX_STATS_COUNT];
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ee623476e5ff..a68d1c42d16b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2154,6 +2154,8 @@ EXPORT_SYMBOL(otx2_open);
 int otx2_stop(struct net_device *netdev)
 {
 	struct otx2_nic *pf = netdev_priv(netdev);
+	struct otx2_dev_stats *old_stats = &pf->hw.old_stats;
+	struct otx2_dev_stats *dev = &pf->hw.dev_stats;
 	struct otx2_cq_poll *cq_poll = NULL;
 	struct otx2_qset *qset = &pf->qset;
 	int qidx, vec, wrk;
@@ -2162,6 +2164,21 @@ int otx2_stop(struct net_device *netdev)
 	if (pf->flags & OTX2_FLAG_INTF_DOWN)
 		return 0;
 
+	/* Accumulate old stats */
+	old_stats->rx_bytes     += dev->rx_bytes;
+	old_stats->rx_drops     += dev->rx_drops;
+	old_stats->rx_bcast_frames      += dev->rx_bcast_frames;
+	old_stats->rx_mcast_frames      += dev->rx_mcast_frames;
+	old_stats->rx_ucast_frames      += dev->rx_ucast_frames;
+	old_stats->rx_frames            += dev->rx_frames;
+
+	old_stats->tx_bytes             += dev->tx_bytes;
+	old_stats->tx_drops             += dev->tx_drops;
+	old_stats->tx_bcast_frames      += dev->tx_bcast_frames;
+	old_stats->tx_mcast_frames      += dev->tx_mcast_frames;
+	old_stats->tx_ucast_frames      += dev->tx_ucast_frames;
+	old_stats->tx_frames            += dev->tx_frames;
+
 	netif_carrier_off(netdev);
 	netif_tx_stop_all_queues(netdev);
 
-- 
2.25.1


