Return-Path: <netdev+bounces-300118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hQgHHBV2MmpP0QUAu9opvQ
	(envelope-from <netdev+bounces-300118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:25:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D983069872A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:25:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=Zvrw3zl3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300118-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300118-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD69D308D181
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA5E3BED7F;
	Wed, 17 Jun 2026 10:22:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0C3BB670;
	Wed, 17 Jun 2026 10:22:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691745; cv=none; b=O/DAFd3qAmfby29+AmeasLqs+AQanCxhXFGeAyIO2OYO/qLIDasG9+LogAs6nU0v4Q/ri5P/nClwxWikelVfn+dWXxuPsLWmRiYgeqnN6WbY+Af/WCMcAD0n8yrF6Yh2DWC4zCpFlBRKwCSSMDc3Z0fwm1CgL5UzwsOBSBsn2yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691745; c=relaxed/simple;
	bh=jhRecrBZ5yukG78MU1kyaZDquYxt8uhdl1UL0SG/fOI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xo908q1AfTiuhqeQ7xCcODNIvzgMdSlV306HUNQC1H/ltConKw53xRb9ktGlpE+Aw9ZhcZGBHITRWY1XuDM/6OsOveBcSMpq0r/xeES4JJQO6mWTEuxf9I64lUR6SC2srXb1a8AXmv0DKntfPeSw+RrJaxM3sumOAsWuzd1nWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Zvrw3zl3; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8WqdI1599422;
	Wed, 17 Jun 2026 03:21:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=gI9qCiERIP+K/w39TKDZweK
	uahXf9tcwFmCWk1n5M1g=; b=Zvrw3zl3RaS/sRNR6ETbI0aQUXH2cArfKdkODgo
	3lni+lja5gm+RACGh7C+JoCn7hSxXQl57jk/CNtOoOqBKGUQgW6ZBNgldHn2b31d
	vbyEoqQ8Y/fEP/0SHOfVNt84jF0YW+U4z81GtQ6r0ttRMYBOh+Cmtru3wtgGNG1g
	ymxud7qlxm3Oe2pFQPJTBTqnZIR/OyPkOEeuxilZCn2DImOwSq3eUvKGhiaht0Ge
	oC0nQx0mR22uqKI+wB9iaXJ37PJ4WUV1lqiSAIZ2jOQ2MvG2xhxj7XqZTNQl33HU
	qBfnzjnJWHlQryT+KWVj4Jy1GGxBvmw6/QGa/6eKZv+y3bg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eueg4j5an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 03:21:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 17 Jun 2026 03:21:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 17 Jun 2026 03:21:54 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A14573F7083;
	Wed, 17 Jun 2026 03:21:51 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <rkannoth@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: [PATCH net] octeontx2-af: npc: cn20k: fix NPC defrag
Date: Wed, 17 Jun 2026 15:51:49 +0530
Message-ID: <20260617102149.1309913-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfXxm3IQOgNWv9G
 lIznfEconVSQyxJH6e8J9GAsAjnKkmUN/b2P7Vwk3j61ALArGRpveDctU5ZB8M7vfQRfvjQHBBP
 BOU7c6ZXQFRRCZxDWwQZYFsjljYo+yGd2ZIuew+4R/YlmbJw1wdYDle3RVU2UJBCEqS6bjbmmkU
 llGeM5gwuERyeBM565Lv/QWoqqdG0B1lXBzxg+oMH05oeHpErZxhioFmTUalCvkueTr2KqLDXAi
 QxrAzw5fl5ZQ9SGS0CoAqQc0QF+0vjCoMEDK1kUxiFlwwc5K5WkHD+c2VB9uBWgZxZb9w96Eivs
 1F9YYzPRbbkKrTdrgwBYLv1W++8ouEOHl4wYM8DOYLc8MYJE72PtGufJqTSZ0mbQ/qzUUMXOEji
 P84LXw/NhezTt9HXwN7ZwmhH3tnEAgzScWfU6QkA4P9HT2mYFENP9goYvGNeJo+gDSLseMFkxTp
 D7TxsneQQ4iEiB/C94w==
X-Proofpoint-ORIG-GUID: BlqQtgE_Kc1JbmXt-3Pg1I2t0Wkikp6F
X-Authority-Analysis: v=2.4 cv=JZqMa0KV c=1 sm=1 tr=0 ts=6a327543 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=UF5P2-iA8WO71qN6q7UA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX2dl03SDZBIAd
 9HH67KJRJXeUvK5PjXQTfqd6kuESdwhHk/2wXXeDY5RRukVChSwEfOxMnABK/EtHEPYS3y9eAmf
 bhJ74serQY6g5FqfJd8cFYZnhnF0ODM=
X-Proofpoint-GUID: BlqQtgE_Kc1JbmXt-3Pg1I2t0Wkikp6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300118-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:rkannoth@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D983069872A

npc_defrag_alloc_free_slots() always passed NPC_MCAM_KEY_X2 into
__npc_subbank_alloc(), which must match sb->key_type, so defrag never
allocated replacement slots on X4 banks. Pass the subbank key type for
bank 0, and only extend the search into bank 1 for X2 (X4 MCAM indices
are confined to b0b..b0t).

Fixes: 645c6e3c1999 ("octeontx2-af: npc: cn20k: virtual index support")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index fe8c4ffcd8f7..5dfdfbabfadd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3542,15 +3542,18 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
 	alloc_cnt2 = 0;
 
 	rc = __npc_subbank_alloc(rvu, sb,
-				 NPC_MCAM_KEY_X2, sb->b0b,
+				 f->key_type, sb->b0b,
 				 sb->b0t,
 				 NPC_MCAM_LOWER_PRIO,
 				 false, cnt, save, cnt, true,
 				 &alloc_cnt1);
 
-	if (alloc_cnt1 < cnt) {
+	/* X4 entries only occupy bank 0 (b0b..b0t); see npc_subbank_idx_2_mcam_idx().
+	 * X2 uses both halves of the subbank, so spill into bank 1 if needed.
+	 */
+	if (alloc_cnt1 < cnt && f->key_type == NPC_MCAM_KEY_X2) {
 		rc = __npc_subbank_alloc(rvu, sb,
-					 NPC_MCAM_KEY_X2, sb->b1b,
+					 f->key_type, sb->b1b,
 					 sb->b1t,
 					 NPC_MCAM_LOWER_PRIO,
 					 false, cnt - alloc_cnt1,
-- 
2.43.0


