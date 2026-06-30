Return-Path: <netdev+bounces-302881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MGusDDUeQ2p5RAoAu9opvQ
	(envelope-from <netdev+bounces-302881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:39:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 837206DF9FA
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:39:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=cY3SvAen;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302881-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302881-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0E34302BB96
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847A2368D5B;
	Tue, 30 Jun 2026 01:38:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455A2222D9;
	Tue, 30 Jun 2026 01:38:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783537; cv=none; b=e+k4/nqFVCC6J8O08kEHGZzf+4Q2zs43eur/YCiuz7mcJzVdzMqXVQNfgRj+oM/R++TP3JdMHB5cw52PViNScKekPpdRVpKBGRB2XfqLEXZFm1dF0fA6HZAOPp/cl2Hdi94q6pd7POarEFnO50vUNm5AYgwp07WI/3kXSe03XbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783537; c=relaxed/simple;
	bh=EgATvf4yTGpAT2aWKF6GF3PCFd/y9UVn+B9SCN39w60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FkmXBkiB4TXLYR5tgBFd+Szq+jFWGNtW8bklQ4Y8/iCbGnyKV1ZcS6/ooPfH/xbZ9W9Xyl9EkGBpRb80B4zhI+sZfkKTUk5K7AozUmXnf1PMNlfVVKWzW/WBEkkkLzMqTZBoSL4/Pi2D9xNYb8IkuMmhew1gkQcWxhSCVOWZmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cY3SvAen; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U1IF9c3243929;
	Mon, 29 Jun 2026 18:38:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=7Z/6/m/+hyLIA9V5t3Nq5Z8
	Y0iax5iTP5RA87rkB2tI=; b=cY3SvAen5/eutH8qdvL6heUYrgUxqRCq8t1IyWU
	JQ7QpDfzFMQR3b9WPJKY0sUfkB71LH7kmcEj4rn4Gjc1IENy77FD3VRKaqs9+qzp
	my3hULu+MXppzCBSVsvHtYmrSwG2jzQREkF+qYdMl5YIDbrUY9hB8bxIvRO5uL+u
	TpgNDKvTDW+libtbcXAzKQeClvb3Me+OiXAGSLgTMGk3CWHFSciB/k3jP6jZRwtN
	CVPOnJ+VSelRY6vQzYU1IxBoc/CBXxu/Q0ZC7vS2OCoKmxugcQZXXYIaV4VOYHLx
	Kl0uRlI/Qt+tCY8PwSN25nVanzZxaqXeJIQFnD80V6F5MoQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f32s6ddvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 18:38:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 18:38:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 18:38:30 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 7B7913F7068;
	Mon, 29 Jun 2026 18:38:27 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next] octeontx2-pf: link RQ page pools to netdev for Netlink stats
Date: Tue, 30 Jun 2026 07:08:14 +0530
Message-ID: <20260630013814.3657831-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAxMiBTYWx0ZWRfX3JOPw0o76UnJ
 P2vfX1HItr5RhCnMP/4rp+iGwQKkH6hh5fPdFWli3vtBcyFqDigIGfFJY2W3DKI0wCt7z7B14vz
 uigV5dKg9s8YBLHFqACznlBJkFK1hGDs4b3UDjCeE0VHCkLAk3pbODOT6h1yvR3DDfGM5qYEBQR
 FtdhwFh5U/FkhrcX9l9gx/MDk0ysI5iA1AqELJ8nOEfqwJAPJ3nOKiUXBRFmc7eLGf0Dhff1pqw
 3bD6N3M0mjiUnKRk1Vzlv8LO2OEfqMYg74fLUigAdM5rOctMcd2TL8Y7bTXXmG0+ZfNqpnFqPiZ
 CZKA++ehsq8CpqY5r+AEQKC1JRCc0fxutGlzLQTjDfNHf0SKG7TEJ/sLH0NzHQz3D0r6PW8c9nr
 o20WXTNfqCH9EFlih4xXBkkWHgZu39suWr6FAQZPp5eaUlsNT91bImi4qAA4yX0tAeGKir4Jqpx
 NRTfQAiyIRoPLOFimQg==
X-Proofpoint-ORIG-GUID: JwMUfVwxqvBJNkReSBmLnsWQlHrLbDY8
X-Authority-Analysis: v=2.4 cv=e6Y2j6p/ c=1 sm=1 tr=0 ts=6a431e18 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=tDJzMk1uZYfymYglDUAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAxMiBTYWx0ZWRfXx9lURlDjUQp3
 kCMk4Nz1fOqEtWzy4PoGEAWrV/NFHLzsghxj0LfcHoLHz4q++aLv3MQ4DgoHptGI0CiN/94GN54
 D2B1IGAG4SBjhn9i+CDjPBIidkgjgpo=
X-Proofpoint-GUID: JwMUfVwxqvBJNkReSBmLnsWQlHrLbDY8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302881-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 837206DF9FA

page_pool_create() only registers pools with the netdev Netlink
interface when pp_params.netdev is set. Set netdev in page pool
params.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c       | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index a5a8f4558717..c0a9efc649c5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -654,6 +654,7 @@ static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 	pp_params.nid = NUMA_NO_NODE;
 	pp_params.dev = pfvf->dev;
 	pp_params.dma_dir = DMA_FROM_DEVICE;
+	pp_params.netdev = pfvf->netdev;
 	pool->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(pool->page_pool)) {
 		netdev_err(pfvf->netdev, "Creation of page pool failed\n");
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 971fcab1c248..2cb3eb86e1e2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1035,7 +1035,6 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 	if (qidx > pfvf->hw.xdp_queues)
 		otx2_attach_xsk_buff(pfvf, sq, (qidx - pfvf->hw.xdp_queues));
 
-
 	chan_offset = qidx % pfvf->hw.tx_chan_cnt;
 	err = pfvf->hw_ops->sq_aq_init(pfvf, qidx, chan_offset, sqb_aura);
 	if (err) {
@@ -1515,6 +1514,7 @@ int otx2_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 		pp_params.nid = NUMA_NO_NODE;
 		pp_params.dev = pfvf->dev;
 		pp_params.dma_dir = DMA_FROM_DEVICE;
+		pp_params.netdev = pfvf->netdev;
 		pool->page_pool = page_pool_create(&pp_params);
 		if (IS_ERR(pool->page_pool)) {
 			netdev_err(pfvf->netdev, "Creation of page pool failed\n");
-- 
2.43.0


