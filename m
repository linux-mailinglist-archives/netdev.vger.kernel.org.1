Return-Path: <netdev+bounces-286495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK5SFOOFAWpOcQEAu9opvQ
	(envelope-from <netdev+bounces-286495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:31:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C50375093FE
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 572DD30160D9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15FE3815FE;
	Mon, 11 May 2026 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DneFyfYc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7BF364952;
	Mon, 11 May 2026 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484440; cv=none; b=s3C8Q1lMlljQwu2qRYcKq4xHJvccysCGb1+DhWNNU0QUlA8SoJkNZEOveJwIutD8g+zAG6ta+oN3IiaGhSfFO5q+IpBgpXsYEj82OL8qtTLW556ZHH4YQGILZHT0GzW1KSZXy5dValiRaIimpgArXrHfkFwdcWC0m+3jwL/aHLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484440; c=relaxed/simple;
	bh=KL6EljMUVbF6l07YwIDnisOtgrfR738f147aBvhk5Dc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xz22XfHT5XzW1MB8MfTHRtb0aCX7DwlGtGbQLFb8q/QiUD1uwda+uI28y8gzthTilL/mrZagDtkup6bLq1nbn6D7Sd/cCNo1aMO1mkWRaIhpxJWcJRQqqw0KGzzIkNhxBx6HDEeZJdCWDM3NUgQ+ZhMHOjh8xkueT8L6/bZ7Ofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DneFyfYc; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AKuQQk1992368;
	Mon, 11 May 2026 00:27:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=K9aNIUkZp9ZYZfqPO+K+9nM
	SBilPQptRFMIUmrC24kA=; b=DneFyfYcN6wauY4G+lSjm0x2DF5N2JjTD+M+VXt
	USxnI3LoABoo5AKf2LsdP8lcK6ULNNcNdq2ncUWbptqxqjbVo7li5HiUFX5O6G/Y
	PvEcShxhXmirukMNn0ayaHIb82kAnDig5F0rr/y8p4E3G7dmEvE+FNhckL22fvsh
	BfzLa4M6KAvN+hbSiF1q4+Iv3wOixvXy0Q6J6gEzCq2LWVZ5r05hEWR5g+EEY0a1
	dF6aAiLjacupm76ZYkcBaBFewQYA6dToIunq4b71ExU7CbFNEm/7pTL1OXZ2pXTZ
	9k4j2thCnAZnZDd18yPQJSieJRG1Yt1rvuRBtHJPCdhfAuw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e2s68sm91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 00:27:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 11 May 2026 00:27:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 11 May 2026 00:27:07 -0700
Received: from hyd1vellox1.032marvell.com032caveonetworks.com (unknown [10.29.37.43])
	by maili.marvell.com (Postfix) with ESMTP id E3B2C3F708C;
	Mon, 11 May 2026 00:27:04 -0700 (PDT)
From: Anshumali Gaur <agaur@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH] octeontx2-pf: persist netdev stats across routine operations
Date: Mon, 11 May 2026 12:56:51 +0530
Message-ID: <20260511072651.1421764-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nV6Y1q8m9Me1bhJDTrJJN3w624VCdCvo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4MSBTYWx0ZWRfX5iJmCyTUrGBR
 o69GQZ9UrrKrr9H7Wzu4iPRumVVzN8V6MaB0Ts9YLsG7GT6yjl0co/UyAs1gp6clvFr2CtVKVvV
 p9ON41XcMOtD6m79cDsmDkGh5Jy1ak60o7W9HALt7Ridvi1W2KNhfVhbiqte+ljvGcmLJeTVgDk
 luxeEFZrxMh6RCaYWqEnsSm3Wb/wKdUH5dkHgamFVvuM93DGPlfOLTEyvB5CMG5cXolEz9VQhTn
 lGvwG1bNbzA+oCTTtp/+xAGGruXEuTMhp7UVr/z+fsHD3LjR2CgChuZGa8AqptaH1+atJBVKu6d
 vC5BskNHuYXJr9AhqsX2hPW76Xllf5Hf2JhQce7WAYm23b8WhTmwq0OCntRVZGEL1rkH9x4IVt6
 utiwCPvg6Cjwz2a2m1mHncSBqOK3voL2jbRpOraA3BGeerPArMSIT2Exy93RhpjkbjAe+BW0x6e
 sEVjB98iWR+rTxa0hDw==
X-Proofpoint-ORIG-GUID: nV6Y1q8m9Me1bhJDTrJJN3w624VCdCvo
X-Authority-Analysis: v=2.4 cv=Y8rIdBeN c=1 sm=1 tr=0 ts=6a0184cd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=LAN69u-R7S9pEGm31n0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: C50375093FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[agaur@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286495-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Currently netdev driver is not retaining ethtool stats during
interface up and down, as per kernel driver standard netdev driver
must keep stats constant to avoid race conditions with user space
trying to read them. Stats must persist across routine
operations like bringing the interface down and up.

Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       | 20 ++++++++++---------
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 18 +++++++++++++++++
 3 files changed, 30 insertions(+), 9 deletions(-)

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
index ee623476e5ff..9606c8cb8c82 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2158,10 +2158,28 @@ int otx2_stop(struct net_device *netdev)
 	struct otx2_qset *qset = &pf->qset;
 	int qidx, vec, wrk;
 
+	struct otx2_dev_stats *dev = &pf->hw.dev_stats;
+	struct otx2_dev_stats *old_stats = &pf->hw.old_stats;
+
 	/* If the DOWN flag is set resources are already freed */
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


