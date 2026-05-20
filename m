Return-Path: <netdev+bounces-289855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEIcLlmADWosyAUAu9opvQ
	(envelope-from <netdev+bounces-289855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:35:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD8D58ADBB
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95AE6301F15E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647093B585F;
	Wed, 20 May 2026 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PQC2yBc6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D7370AFA;
	Wed, 20 May 2026 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269667; cv=none; b=XEhJco7Rc3ldfDg8T/Rav7AdCBOQaZPhmUPmF7wLVUelZVndFaR7+wlVhE4/lJYcY2+vzTSiyDt8z+MDRE+5dQheoalQKJzKwYbznf7ibzjS0w8dNCUImmIym/ukHt4qFamYqEjC5mWOsz0zYP4DylmcF6twD9R5n8wsaPh7g3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269667; c=relaxed/simple;
	bh=BoblhB4Xpk4LlfwvhT1PyKrbb08G4mcOXJ9gtHhleuU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tavmz/HyXzrPpsBMo+gEQ+4xXjqvEk6IU0lJuCPrpBKx5PtN+4HTZimBugCARMJISyBcJXjWGFUcAh+P8Btr5qRPmtNx6g7YSHOZIhv+sywK1XsRrV97XBiZ+gJIzFyVB9QetPo88Fg16Qa9ANc4be2wN1cXsbuzuOKtJot9uXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PQC2yBc6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K2pmZD3009289;
	Wed, 20 May 2026 02:34:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=tWEoPTrzvEZ7qqivt3k6eDh
	pPFiR0vgOIDIx7kdmhaY=; b=PQC2yBc6zFg/1n9iRNMKqY2E9hcR6/tq7NoKIRi
	xgJx1sWMjC0ZLCRoD6TdhBBYRV89unXYyvFQvgBunltr+e0GO2Y/CKbaa/Uu4qgG
	hCdpsS7v4dbkU+GpuknUNJwPREFWBViv11/CufwONqPR54tPTE7ih+HJzPcpVs2O
	7VFcGHwzjqD3zTXtGmg55Z2hJ4SVn/6o/0/l/4vnQwH9zUPrLUc7X7Ruk4fAQGRN
	ElaMKkenEPRsRs2r656unBcvK6hK/fePcaY9kMc2F03Tnx2uRHtZz9XRNkFJcP3/
	XLckOYgVN9Jwj2cQIP3Y5o+cfmhNyGlHpLSa3qe4hs+XNoQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e8jywcayt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 02:34:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 02:34:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 02:34:12 -0700
Received: from hyd1vellox1.032marvell.com032caveonetworks.com (unknown [10.29.37.43])
	by maili.marvell.com (Postfix) with ESMTP id 6356F5B693E;
	Wed, 20 May 2026 02:34:08 -0700 (PDT)
From: Anshumali Gaur <agaur@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <sgoutham@marvell.com>,
        <bbhushan2@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH net-next v5] octeontx2-pf: Retain ethtool stats across interface down/up.
Date: Wed, 20 May 2026 15:04:04 +0530
Message-ID: <20260520093404.1945835-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: vlheHNz2e9Dk8KHYFtohrHYvrX5uUwRz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA5MCBTYWx0ZWRfX3EEhXbd3U6gq
 sBDET3qP3z63Vz9w18iLwKQiMGIXIhoazv9boofV2BJ/2+LoFlodzAuq2Z0KG7TEOInFfahtpim
 YtiJLmek0KwrzgME54D1iuaR35zcxVwmC39PdNYJDu0ewJuMYihlKDCtNrseWFUjDEcEBgZkWlW
 44M5GpPOIb79tjrPArCJJ5fuR5Eq3cLb2uBQtmF0xn1Ri6Fq7DrulY1W2M5rU8cIZZnV4F3QNBB
 lFRVeRSt3WqWJJiZjSNWCZ2S6JxBKstSw7BNknlwAIHHrdFqTDCefObeoNEw2SBu1Ys6Rt0ZA2h
 rnRc5xR+uKQGXy6exTX6LI305UEs0wgFBcKpxV9JR8uHBCtab00e2Nr9q8MYKyxCwqEsESXxtpd
 9govGTatdNxrJQFNQ+xEgb2B9fEH+/D/Z65l8dDUkkU8GRFWH1wbV0oT+jc6UdwFffjiG6GbTAA
 U+y1nnHTOMPMAPMyVdw==
X-Proofpoint-ORIG-GUID: vlheHNz2e9Dk8KHYFtohrHYvrX5uUwRz
X-Authority-Analysis: v=2.4 cv=QbNWeMbv c=1 sm=1 tr=0 ts=6a0d8015 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=6arj5X4aKY2yYbu-eEwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289855-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agaur@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2FD8D58ADBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the hardware counters reset when the interface is
brought down, causing stats visible to userspace to drop to zero.
Save the accumulated stats before bringing the interface down
so they persist across routine down/up cycles.

Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
v5:
  - Split variable declaration and initialization in otx2_stop (Paolo)
  - Fix reverse christmas tree order in otx2_get_stats64() (Paolo)
  - Move stats collection just before otx2_free_hw_resources() to
    avoid race with NAPI (Paolo/Sashiko)
  - Remove duplicate otx2_rxtx_enable() call
v4:
  - Move stats accumulation after disabling tx/rx (Dragos)
  - Fetch latest HW counters before accumulating in otx2_stop()
v3:
  - Code format according to kernel coding style
  - Reword commit message
v2:
  - Fix subject prefix to target net-next
 .../marvell/octeontx2/nic/otx2_common.c       | 20 ++++++++++--------
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 21 +++++++++++++++++++
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 971fcab1c248..fce46816446f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -138,20 +138,22 @@ void otx2_get_dev_stats(struct otx2_nic *pfvf)
 void otx2_get_stats64(struct net_device *netdev,
 		      struct rtnl_link_stats64 *stats)
 {
+	struct otx2_dev_stats *dev_stats, *old_stats;
 	struct otx2_nic *pfvf = netdev_priv(netdev);
-	struct otx2_dev_stats *dev_stats;
 
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
index ee623476e5ff..3b4e32d899b7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2154,6 +2154,7 @@ EXPORT_SYMBOL(otx2_open);
 int otx2_stop(struct net_device *netdev)
 {
 	struct otx2_nic *pf = netdev_priv(netdev);
+	struct otx2_dev_stats *old_stats, *dev;
 	struct otx2_cq_poll *cq_poll = NULL;
 	struct otx2_qset *qset = &pf->qset;
 	int qidx, vec, wrk;
@@ -2200,6 +2201,26 @@ int otx2_stop(struct net_device *netdev)
 		cancel_delayed_work_sync(&pf->refill_wrk[wrk].pool_refill_work);
 	devm_kfree(pf->dev, pf->refill_wrk);
 
+	/* Read final HW counters and accumulate */
+	dev = &pf->hw.dev_stats;
+	old_stats = &pf->hw.old_stats;
+	otx2_get_dev_stats(pf);
+
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
 	otx2_free_hw_resources(pf);
 	otx2_free_cints(pf, pf->hw.cint_cnt);
 	otx2_disable_napi(pf);
-- 
2.25.1


