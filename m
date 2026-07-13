Return-Path: <netdev+bounces-307227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8sxVOsT5VGoRiQAAu9opvQ
	(envelope-from <netdev+bounces-307227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:44:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCE274C8AC
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:44:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=Yegq7VlQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307227-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307227-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C023D302FBC7
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4962842B746;
	Mon, 13 Jul 2026 14:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046332AAB5;
	Mon, 13 Jul 2026 14:43:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953789; cv=none; b=WQjT4vqQGwtSBzHanT/nDnEtYRF+rj9Ya3LnNH8AjcjN15jgOJgULjnc3aBpGE9lMpDLLDWmc0CGAgqZnv1Of8tyDgMN8gBJqlDc/6e0WtAdY3avLHl9PxEqf1Zacoe6a8YYeRGcLiTvSbSRb8j3pdE/6arKiEEOsftC3D+/sgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953789; c=relaxed/simple;
	bh=ezVyzJwUCwOlF1Moexni1BsQt2cCvqFMreLUWsOz4KU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DFUDDQJJ5U7CiKbRRgJDCRVMsyR8dAniog9O1kEKmxrEdN5GWVeTPgpOZrkwv4H9mekfZKMDpjTci49iuZIaYfgHjhlTLIh49Teplvta4dbUK8wyNR9uxH4FOfNcTQupJ5EXDAezZ4ohRjfhOIsYyEeQ15RqFtYqaUyVMMNgZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Yegq7VlQ; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCFuxD403014;
	Mon, 13 Jul 2026 07:42:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=LB08cVqHy+2xItakMU5cT+e
	rTaCsaqCahVDMTJD9Z/U=; b=Yegq7VlQSyCGNAs2UYe1Af4aqyM3yAxO9Qmg1ft
	VcS0kJjVhRtQJ08Ynrz3RYjuFuEHDCMc7FoCWiAKsalWpnrLJipzYvIUkFX/wosV
	bg9yOGbbxE3dQ7tppG4c7V8/DbJydA0WX+9OkffBJguaFxOk9DCFGP+p2CZgP32Y
	TWhWgBXIOD3/QeEqMhk//Qzr+6TciilNoCXmK1x1svRkr58gV0sYPqRRMoYnkIWb
	F2yIko706qQXH1/ELaRXncdKxejDgUvoEkDOClgq3B7m5tJdbAZkWXAgiktY0igX
	XFFA2qpTL4k67Lw+70Iic5b89HuQ2glwHQEcuqf4jP7JBbQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fca36jraa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 07:42:59 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Jul 2026 07:42:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Jul 2026 07:42:58 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 0F4C43F7067;
	Mon, 13 Jul 2026 07:42:55 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Hariprasad
 Kelam" <hkelam@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next] octeontx2-af: npc: Warn on NPC_IPSEC_SPI key overlap
Date: Mon, 13 Jul 2026 20:12:47 +0530
Message-ID: <20260713144247.545592-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX3eWjK1ixDf8x
 y9n9fT+/xVWmwLKgd6Cw+RIRvXqb8PwKTUy5ViJN7XQR2MQAlBcx8lSQVkXw3Cbf6bI/i18nGR7
 hEEeL25aYkAlGqGtQ7fAAmzdx9lrSi0TnqQTx18Zl2wM3KqN22XKFDgqGVu4T5GmOWWxZPpN51l
 AGX0KpY1GQA3Nyz452ILL40Qt9WikCs3kCUW7Nt3opvjGUG4DCLHjmzbEfe9meRI9Z0i1W/Jy5g
 ChDKmxJyGQLoC6Wd0saUe5gzvsyfaEmzL78cDAhoXRwXBJXC9YMVPfheWkGluxxmXXnlozgzWOD
 dk1XSKlYiW4gKY1XSn0iulUXF2LBK626O6N6IlzRjuRnRlabAhFzApFdrXItwXgBpxZQVvsF4kz
 eN4qhHBillHfXWWVisdKDXtJo98Hm5tSZZy4HOhAwTyQ0GLZJpktKb06+/rYGEOCvCDmuLJTleB
 C31K30OfWFBe5qBicHw==
X-Authority-Analysis: v=2.4 cv=EeT4hvmC c=1 sm=1 tr=0 ts=6a54f973 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=6BDruIGW9xnf_RptPNEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX84JA/OrIfwEp
 E9obAoYL4weqhLYmnS8xu5vYFAn35mBpAO63J75Cg2QpM98DM3KuDDKtMozMX8Uog1hK90X3/cH
 mqJ3tRCdvj4rGrm93ECEd6OQpsS7Ms4=
X-Proofpoint-ORIG-GUID: 5Nh611um3R6D7Rb6mGFW2t9rwwrvg2L0
X-Proofpoint-GUID: 5Nh611um3R6D7Rb6mGFW2t9rwwrvg2L0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307227-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:hkelam@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:from_mime,marvell.com:mid,marvell.com:email,marvell.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADCE274C8AC

From: Hariprasad Kelam <hkelam@marvell.com>

When scanning the MKEX profile to determine supported NPC features, warn
if the SPI extraction field overlaps with other key fields. AH and ESP
may legitimately use the same key offset for SPI, so continue to
advertise NPC_IPSEC_SPI via npc_is_field_present() instead of treating
the overlap as a hard failure.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 91b5947dae06..b217c1c19810 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -730,6 +730,9 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 			*features &= ~BIT_ULL(NPC_OUTER_VID);
 
 	/* Allow extracting SPI field from AH and ESP headers at same offset */
+	if (npc_check_overlap(rvu, blkaddr, NPC_IPSEC_SPI, 0, intf))
+		dev_warn(rvu->dev, "Overlap detected the field NPC_IPSEC_SPI\n");
+	/* Set SPI flag only if AH/ESP and IPSEC_SPI are in the key */
 	if (npc_is_field_present(rvu, NPC_IPSEC_SPI, intf) &&
 	    (*features & (BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_IPPROTO_AH))))
 		*features |= BIT_ULL(NPC_IPSEC_SPI);
-- 
2.43.0


