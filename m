Return-Path: <netdev+bounces-299305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mLU6FfRvL2rSAQUAu9opvQ
	(envelope-from <netdev+bounces-299305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:22:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C743268304E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:22:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=V0KVkKK6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299305-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299305-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE82D3005E89
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7337024E4AF;
	Mon, 15 Jun 2026 03:22:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB61A0B0E;
	Mon, 15 Jun 2026 03:22:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781493744; cv=none; b=DWsS8n8X4AkMvwkFSZo0F+5PscjWdHHPp1d83pRN7I3nws3lvSdGzJxtxpfTaCToQF0tGXw6mqcxl6hp1zGzSshkEAd3GS24s0/BW5qsuCXKrkm2ec1lL4iVy2DGw0c/oEFtrhEe6ILBrkVKV/NXVEBFIeMDn3C/yZe6a+YFt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781493744; c=relaxed/simple;
	bh=eMBd+LLgj5mhILuMPvK6NyJ2vmkqvbO2eYfZ3TbeAtM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gsr9wd3GHyIWm/m0BhvdNwbvqp3BJyYEsuB7lLKKcw3kebnwSjEeh3xraNO0Q6N0TwtDLsS4LECWIWauRp+Hro/Mn9f9xQWZriacE2kylRf4915RL7CwfhwtORbGcTD4QJDhGriOqXZXkqChCjMiRC+sUfeT7FS9lEDL6Pb+6r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=V0KVkKK6; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1lQnS3665057;
	Sun, 14 Jun 2026 20:22:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ruaIaA4iqfJ6P5JixHxHTJt
	Vu9gt0bDOtwEoYtQdAkc=; b=V0KVkKK6YSsVm4z2+GUIaqY0aHC5FAQTVviqjLg
	wjq1E/GZZXy3P83e+sk4Ko/TqeYkVOoECAj0c1fIQ1oeQLrNAdREbCFsLxMPQXp9
	sA/eJTpwERvbojlmtYRXRFOP9B6I7H1c8YzQHL4b4wiESyUb0nwtILw8l6idkuW+
	p50yblw3+zwkcXSqv+NALuvdIb5lKZTolnPti76T/jHkTzEfEFwerUSTGNyEDcuI
	Nlu/9m+PueZ1UVlhJ8+V4lKhB1HUO6YKaEyIUuupP6Xbmg7uLqS7/jvhFbahWaX1
	WC2Qy5pkJi6RryPpP6EXLg5gAT7qKwon0dRh1wD1whU6nxw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4es6qed75x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 20:22:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 14 Jun 2026 20:22:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 14 Jun 2026 20:22:01 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 87D413F7063;
	Sun, 14 Jun 2026 20:21:58 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next] octeontx2-pf: add page pool ethtool statistics
Date: Mon, 15 Jun 2026 08:51:41 +0530
Message-ID: <20260615032141.521667-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2phx0tgK1jjfn6X7J7GTPIepsWC6fysn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDAzMiBTYWx0ZWRfX1LoVagDFQyJA
 XJeuXC06UCWUF1uSm/EqFHPGOKPIqYEQu3u8Vf5yVtUzUxRMySJekeo1OHp5scsRRQEVknOHd6g
 KNwnh1uJx5BXGDyFELepbKh2ZcR6l90=
X-Authority-Analysis: v=2.4 cv=TuXWQjXh c=1 sm=1 tr=0 ts=6a2f6fda cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=9h9g3_DWoOcAExhtXrUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 2phx0tgK1jjfn6X7J7GTPIepsWC6fysn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDAzMiBTYWx0ZWRfX86bHLBjneXMs
 c+lnBuU1RyvhaDpN8jYMUMKvCkpwtFt8e2ZGTy+3XttWodE0HlMRe6GsGelfhm5/qstigcsdYUl
 Z8LrQXyb/RYhfd8mhx/Yz6pJhgOf/lvXI+NZtIL0BVtakNilwJOrR4gx9CoumKX/heh0/+mmVHG
 JpxarXBIN/8ActuhpvdK7t+ZQcJHrt4elgiTT29nQ5B1poU0rFe2CPMh9LgpTuxYWy+eimGOMHH
 8YWpqXDQOEhQMdvJU11jMpVZAe88nMOI8juC63bTJBrCpAdj0an4oNEwoHqNNu8f9eMbtZAKH0A
 G2FPdfgQI3YNL0HrnEfrRX28vkEdc0V1Nz7/F4rw6fzQ/Yj3+trWL3kdMgzdiye3bQmQ8awsIeQ
 UKdx8bO2Uvkk16PiymQV12CLKibaEFmure4uii8AVQFQIjYxm5vHXSrqint7dwJgMJzLuNhNxvm
 p3eECBuiceCiFWGQzvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299305-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C743268304E

Expose page pool allocator statistics through ethtool.
When the interface is up, aggregate stats from each
receive queue page pool and append the common page_pool ethtool stat
block to the driver's private statistics set.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index a0340f3422bf..0a082f8d9714 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -133,6 +133,8 @@ static void otx2_get_strings(struct net_device *netdev, u32 sset, u8 *data)
 	ethtool_puts(&data, "reset_count");
 	ethtool_puts(&data, "Fec Corrected Errors: ");
 	ethtool_puts(&data, "Fec Uncorrected Errors: ");
+
+	page_pool_ethtool_stats_get_strings(data);
 }
 
 static void otx2_get_qset_stats(struct otx2_nic *pfvf,
@@ -182,6 +184,28 @@ static int otx2_get_phy_fec_stats(struct otx2_nic *pfvf)
 	return rc;
 }
 
+static void otx2_page_pool_stats(struct otx2_nic *vf, u64 *data)
+{
+#ifdef CONFIG_PAGE_POOL_STATS
+	bool up = !!(vf->netdev->flags & IFF_UP);
+	struct page_pool_stats stats = {};
+	struct otx2_hw *hw = &vf->hw;
+	struct otx2_pool *pool;
+	int pool_id;
+
+	if (up) {
+		for (pool_id = 0; pool_id < hw->rqpool_cnt; pool_id++) {
+			pool = &vf->qset.pool[pool_id];
+			if (!pool->page_pool)
+				continue;
+			page_pool_get_stats(pool->page_pool, &stats);
+		}
+	}
+
+	page_pool_ethtool_stats_get(data, &stats);
+#endif
+}
+
 /* Get device and per queue statistics */
 static void otx2_get_ethtool_stats(struct net_device *netdev,
 				   struct ethtool_stats *stats, u64 *data)
@@ -237,6 +261,8 @@ static void otx2_get_ethtool_stats(struct net_device *netdev,
 
 	*(data++) = fec_corr_blks;
 	*(data++) = fec_uncorr_blks;
+
+	otx2_page_pool_stats(pfvf, data);
 }
 
 static int otx2_get_sset_count(struct net_device *netdev, int sset)
@@ -254,7 +280,8 @@ static int otx2_get_sset_count(struct net_device *netdev, int sset)
 	otx2_update_lmac_fec_stats(pfvf);
 
 	return otx2_n_dev_stats + otx2_n_drv_stats + qstats_count +
-	       mac_stats + OTX2_FEC_STATS_CNT + 1;
+	       mac_stats + OTX2_FEC_STATS_CNT + 1 +
+	       page_pool_ethtool_stats_get_count();
 }
 
 /* Get no of queues device supports and current queue count */
@@ -1402,6 +1429,7 @@ static void otx2vf_get_strings(struct net_device *netdev, u32 sset, u8 *data)
 	otx2_get_qset_strings(vf, &data, 0);
 
 	ethtool_puts(&data, "reset_count");
+	page_pool_ethtool_stats_get_strings(data);
 }
 
 static void otx2vf_get_ethtool_stats(struct net_device *netdev,
@@ -1421,6 +1449,8 @@ static void otx2vf_get_ethtool_stats(struct net_device *netdev,
 
 	otx2_get_qset_stats(vf, stats, &data);
 	*(data++) = vf->reset_count;
+
+	otx2_page_pool_stats(vf, data);
 }
 
 static int otx2vf_get_sset_count(struct net_device *netdev, int sset)
@@ -1434,7 +1464,8 @@ static int otx2vf_get_sset_count(struct net_device *netdev, int sset)
 	qstats_count = otx2_n_queue_stats *
 		       (vf->hw.rx_queues + otx2_get_total_tx_queues(vf));
 
-	return otx2_n_dev_stats + otx2_n_drv_stats + qstats_count + 1;
+	return otx2_n_dev_stats + otx2_n_drv_stats + qstats_count + 1 +
+		page_pool_ethtool_stats_get_count();
 }
 
 static int otx2vf_get_link_ksettings(struct net_device *netdev,
-- 
2.43.0


