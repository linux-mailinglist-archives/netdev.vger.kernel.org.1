Return-Path: <netdev+bounces-299939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TQNsEm6dMWonoQUAu9opvQ
	(envelope-from <netdev+bounces-299939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:01:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D14694A8B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:01:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="Ut4 GBv4";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299939-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299939-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBE513014523
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28293D668F;
	Tue, 16 Jun 2026 19:00:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FED34751B;
	Tue, 16 Jun 2026 19:00:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636447; cv=none; b=Pc5tw+hV9eSGGnuA96Em/56roLN+uXWDhdc/ABiPYsF+YRV8nfYx9pj3qLDEkZzrYjalsGZ+mxpCNttvgjtBtSCeK0Sfa1PZzVcnlpHCwabM2GdnBXInkVC6KsOWImTGaTLMzqFOMOeuYTprTdG578YTmAf/QhNC7EGhJuuAYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636447; c=relaxed/simple;
	bh=+zioaEgxa5PInV7YqxZ+3jsu7SCekLq1m1g8Rxv5/Sg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pmEN6bUMcT+U1xixtun7tGnZ9a4fZ5iukKmXMATQSp8Ffi1hY2g7zBCQ90JIpMEzE7ctHQD+l2EA6Aqq5d98lZ44zY3FdORv4jRxmYS7GnwN+3456nGEcJnIZq+529Y8WUlq9wjmFIUau1JixzCK8Xk6UHiA9AV9JHY3VzKX8Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ut4GBv4U; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GISG7Y4139081;
	Tue, 16 Jun 2026 12:00:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=oZhwMPc83Fx4MomyFfHotv3p7mmZdC009+CBBO+kY10=; b=Ut4
	GBv4UPVI9RZA5Y4T46OgN6ll4HwTwLSi9jdw3xdVd3COgRIiH9qMIHdPHjAHvje3
	l7aNOUGXMD7sJ3H0VFqohg2DRVuaIpNt0V8++649uE/eSRhDIQABR8cxvBVdakUP
	/FGeZWKWq+sDeA0dgBJGGeDZOqmoqeIn9dX0OdolkxYUuuv2mlaJWMfLu03bseg+
	OMWtp3/CLHX9LVoYG2aGyjE0x0LYOb9hjeG5WwqxhHz2oXjF2Tvf6fljBqkG3kS8
	Q5t3HAjcqMhufMgoe4+eecIcMLe0rv1cOLf2zaaJg3FvDQp9vjG+wBc/YsXnxu0y
	0r0VAdy9PZK/SoQRj6g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4es6qenje5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:00:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 12:00:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 12:00:27 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 71D613F704A;
	Tue, 16 Jun 2026 12:00:23 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>, <rkannoth@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net PATCH v2] octeontx2-af: mcs: Fix unsupported secy stats read
Date: Wed, 17 Jun 2026 00:30:18 +0530
Message-ID: <1781636420-19816-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 6kzQAw3yFZrv7rGNYmd28G0ASX14dAa0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MyBTYWx0ZWRfX571xP25RDsmW
 JtgTK6WWaatOrwekMN4KHJBYSduq3rxg6meQB4K3qltSGh3gU1lEPlRiCqFpb7iD2qobdwAwTaw
 CqYAhSi3UfgBupaTeqY0SLSMYNkbijE=
X-Authority-Analysis: v=2.4 cv=TuXWQjXh c=1 sm=1 tr=0 ts=6a319d4c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=cGofA3kQOmG6IaQPiVUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 6kzQAw3yFZrv7rGNYmd28G0ASX14dAa0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MyBTYWx0ZWRfX3kXMhAdwDmJI
 u538TDNObDrbIin31P99EEIWk83CVKhTYKxaOoR7hsr3lT6ZgNlpr8Ne1aoHcHoOQcTW177xeds
 oKu3N+DY38RtZLS5h3aZEXY/Iex1H6Q48+qtUbOxYlY7/lBwKVbEPwgG7INEAGuhi9flf8YUhHe
 qrdWt+UDqdrwu9Pq006xorLS0npQjWzo5fq0KnPjp3WrYo4OOT5Wccg17JTOt7VLtuKGO1yGZYQ
 mrhOfWN1EO9Rid9VN77qYdbBE15IC+ErFfKyJ3dckNizh8qkto0LmXr7enNCPQ1EEEOkNyuRHf7
 Qg5Kuf26KcW6Ku7xj8eBW3CdexEk7pe8GEd8zkAnmqU5HeFgbrZYs5PNx9K7nou8LADcw1efhyL
 o7tmMmxuFRmql9BVC6+uOtormXEfH2YggnrKfpNd24/xpa6r76GkLWALV5Udgxg0Mjh8s6T6/i4
 ma19tgRuP+w8Cfjo0qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299939-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:rkannoth@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sbhatta@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45D14694A8B

From: Geetha sowjanya <gakula@marvell.com>

Secy control stats counter doesn't exist for CNF10KB platform.
Skip reading this respective register for CNF10KB silicon while
fetching secy stats.

Fixes: 9312150af8da ("octeontx2-af: cn10k: mcs: Support for stats collection")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v2 changes:
 Fixed AI review by modifying debugfs also NOT to access
 Secy control stats counter

 drivers/net/ethernet/marvell/octeontx2/af/mcs.c         | 6 +++---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
index c1775bd01c2b..a07e0b3d8d00 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
@@ -120,13 +120,13 @@ void mcs_get_rx_secy_stats(struct mcs *mcs, struct mcs_secy_stats *stats, int id
 	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(id);
 	stats->pkt_untaged_cnt = mcs_reg_read(mcs, reg);
 
-	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(id);
-	stats->pkt_ctl_cnt = mcs_reg_read(mcs, reg);
-
 	if (mcs->hw->mcs_blks > 1) {
 		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYNOTAGX(id);
 		stats->pkt_notag_cnt = mcs_reg_read(mcs, reg);
+		return;
 	}
+	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(id);
+	stats->pkt_ctl_cnt = mcs_reg_read(mcs, reg);
 }
 
 void mcs_get_flowid_stats(struct mcs *mcs, struct mcs_flowid_stats *stats,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index fa461489acdd..ca2704b188a5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -482,10 +482,11 @@ static int rvu_dbg_mcs_rx_secy_stats_display(struct seq_file *filp, void *unused
 		seq_printf(filp, "secy%d: Tagged ctrl pkts: %lld\n", secy_id,
 			   stats.pkt_tagged_ctl_cnt);
 		seq_printf(filp, "secy%d: Untaged pkts: %lld\n", secy_id, stats.pkt_untaged_cnt);
-		seq_printf(filp, "secy%d: Ctrl pkts: %lld\n", secy_id, stats.pkt_ctl_cnt);
 		if (mcs->hw->mcs_blks > 1)
 			seq_printf(filp, "secy%d: pkts notag: %lld\n", secy_id,
 				   stats.pkt_notag_cnt);
+		else
+			seq_printf(filp, "secy%d: Ctrl pkts: %lld\n", secy_id, stats.pkt_ctl_cnt);
 	}
 	mutex_unlock(&mcs->stats_lock);
 	return 0;
-- 
2.48.1


