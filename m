Return-Path: <netdev+bounces-300309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j64WHDJtM2pLBAYAu9opvQ
	(envelope-from <netdev+bounces-300309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 05:59:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA6E69D6AE
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 05:59:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=PzbXZrjz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300309-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300309-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F3E3302F0FC
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 03:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC06B360EFF;
	Thu, 18 Jun 2026 03:59:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34730C16E;
	Thu, 18 Jun 2026 03:59:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781755183; cv=none; b=W2+Gzoem79EHdj4Zfnc3lXtVQu/GsjXE1wNFuc+9alEUb7+WkYv6qYtXW/PpULaAMblxUi8w5qIDChnht4IrdB1tTcEIiW4A6NoM5X4cnapHIpVWw9fjrlmfj4SqJ+yfiZRWSQCxqpJK2j8grAPU/pTXjPwmDbDM6EjFV8OCpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781755183; c=relaxed/simple;
	bh=4++jkuo1NXZPwegC10u2jT6pFWVQBFcd/Fof1HTDNkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UL1D5LH9YVy1YpZ2t2uuSv1jEccP9nK7TFP2xV0B2pxeG/19HgG/fbhsLOODh+yzJIt+rsjUSdb0oy9FdNyfSMF/ENqPhQWDDMefpq58syKACC67X2txLMk+CCh+KzYZy2xWQd0cb//hIsDv7i7DaXr3XHahFsVvN7p7q3C7GIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PzbXZrjz; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HNSa552362809;
	Wed, 17 Jun 2026 20:59:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=s5TfuT7eApbuLn55UHfRmdH
	2vMwFGY3gubRJY3cCtts=; b=PzbXZrjzSeSGADUpAd5acH4hvx95UauHIcytmTO
	jPbf/PAu/QOfgsYe/tu2HrPQp+YsbkK6dBmBY119Wc2F4TMNn8IgYjc7Z2NsF7jI
	W/VsNWrJ4V+Sf0eK6UzBnN7DkufUx3cEsTyi7wa9ju0HC8/xvOe217p+NCQx2t56
	0DQEOQT+WeZJ+Zw0k20gC9WVd9brrY9vAP81g9NOezjPARpFzv7kfXtpcV+WgTn6
	7oMtd7h6IWgDhCvniE6WyFcUmWURSDVqi1nRNZ+Zd34wraC3IwCffKdM4NqxhzfT
	D6jON6W9O6t/7JByfAv6NKmQudb9029nx4e1ki1pkRxYHOQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ev59a0nbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 20:59:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 17 Jun 2026 20:59:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 17 Jun 2026 20:59:32 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E26833F704B;
	Wed, 17 Jun 2026 20:59:28 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <rkannoth@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: [PATCH net] octeontx2-af: npc: cn20k: Fix subbank free list indexing for search order
Date: Thu, 18 Jun 2026 09:29:26 +0530
Message-ID: <20260618035926.1490794-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDAzMiBTYWx0ZWRfX3hl0cNhNJrgb
 ukTwgV7Gzg+uPWcdLImtra2fYim98Q8IU/YgWAot4vym4/yIQi3GbI8k55MZxHTVlvTP/X3QS+c
 Fz9fDxJeJUm7Qi88oT2bQjQCXrimcnU=
X-Proofpoint-ORIG-GUID: jCNExIZfhxFXHZ8gWmpqMFxQWVe0Knzs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDAzMiBTYWx0ZWRfX0yrLfx4HDrM0
 vWX+5S6Vn+SvLC2LPSza4yUErTO5sLMkkC6MwhWLmapklWBRQbovAXdhibUD9T63j/lD8AqoH6U
 mJEh3RrcDLn1bpg30bKmp9jU/PfVfg88FDhTQc7iPY8vSjvoveyCKYsYqjUAWyKDOPyWPSOQNWq
 dTpIOtP1xMgK6A6IwxHNxyVQmHp3susXU7X33YW4V3NR1yTTG4V5Dc4qXYr2VckavOf/1vOhyVL
 t4QI071aIL93zTpmin+/r17KA1KyomqioE/5TP8jTMRcr61a81BurWKLyzJqQJeUr0HtpB/ZQmy
 8FOpmqJ2lK0D1DI/EEr8jks6Enf0nb7W9rCAqeyEKWdaH5FOsr3ThQcFn+eR7hr0jCLe0bGqAk5
 TkiY+Nfqj3xMcvUXg9q96daXqXoVvoFc5YqFASmbU303jP0MJjSR5SXSrIYUWsLCHi0LkuFCOPY
 VeuNIyk8AUQJmTZm5sw==
X-Proofpoint-GUID: jCNExIZfhxFXHZ8gWmpqMFxQWVe0Knzs
X-Authority-Analysis: v=2.4 cv=GMQ41ONK c=1 sm=1 tr=0 ts=6a336d24 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=pfPJCpAcTnj6gU7msG4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300309-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDA6E69D6AE

subbank_srch_order[i] is the physical subbank at search-order slot i,
so each subbank's arr_idx must be i (its slot), not
subbank_srch_order[sb->idx].  The old logic mis-keyed xa_sb_free
and broke allocation traversal order.

Populate arr_idx and xa_sb_free in a single pass over the search
order after subbank structs are initialized.

Fixes: 7ac9d4c4075c ("octeontx2-af: npc: cn20k: add subbank search order control")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 47 ++++++++++++++-----
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 354c4e881c6a..d38e848add93 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3423,6 +3423,36 @@ static int npc_create_srch_order(int cnt)
 	return 0;
 }
 
+static int npc_subbanks_srch_oder_init(struct rvu *rvu)
+{
+	struct npc_subbank *sb;
+	int sb_idx;
+	int i, j;
+	int rc;
+
+	for (i = 0; i < npc_priv->num_subbanks; i++) {
+		sb_idx = subbank_srch_order[i];
+		sb = &npc_priv->sb[sb_idx];
+		sb->arr_idx = i;
+
+		dev_dbg(rvu->dev, "%s: sb->idx=%u sb->arr_idx=%u\n",
+			__func__, sb->idx, sb->arr_idx);
+
+		rc = xa_err(xa_store(&npc_priv->xa_sb_free, sb->arr_idx,
+				     xa_mk_value(sb->idx), GFP_KERNEL));
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s: xa_store(xa_sb_free) failed at slot %d (sb=%d): %d\n",
+				__func__, i, sb_idx, rc);
+			for (j = 0; j < i; j++)
+				xa_erase(&npc_priv->xa_sb_free, j);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
 static void npc_subbank_init(struct rvu *rvu, struct npc_subbank *sb, int idx)
 {
 	mutex_init(&sb->lock);
@@ -3435,16 +3465,6 @@ static void npc_subbank_init(struct rvu *rvu, struct npc_subbank *sb, int idx)
 
 	sb->flags = NPC_SUBBANK_FLAG_FREE;
 	sb->idx = idx;
-	sb->arr_idx = subbank_srch_order[idx];
-
-	dev_dbg(rvu->dev, "%s: sb->idx=%u sb->arr_idx=%u\n",
-		__func__, sb->idx, sb->arr_idx);
-
-	/* Keep first and last subbank at end of free array; so that
-	 * it will be used at last
-	 */
-	xa_store(&npc_priv->xa_sb_free, sb->arr_idx,
-		 xa_mk_value(sb->idx), GFP_KERNEL);
 }
 
 static int npc_pcifunc_map_create(struct rvu *rvu)
@@ -4635,6 +4655,7 @@ static int npc_priv_init(struct rvu *rvu)
 	int num_subbanks, subbank_depth;
 	u64 npc_const1, npc_const2 = 0;
 	struct npc_subbank *sb;
+	int ret = -ENOMEM;
 	u64 cfg;
 	int i;
 
@@ -4727,6 +4748,10 @@ static int npc_priv_init(struct rvu *rvu)
 	for (i = 0, sb = npc_priv->sb; i < num_subbanks; i++, sb++)
 		npc_subbank_init(rvu, sb, i);
 
+	ret = npc_subbanks_srch_oder_init(rvu);
+	if (ret)
+		goto fail2;
+
 	/* Get number of pcifuncs in the system */
 	npc_priv->pf_cnt = npc_pcifunc_map_create(rvu);
 	npc_priv->xa_pf2idx_map = kcalloc(npc_priv->pf_cnt,
@@ -4760,7 +4785,7 @@ static int npc_priv_init(struct rvu *rvu)
 fail1:
 	kfree(npc_priv);
 	npc_priv = NULL;
-	return -ENOMEM;
+	return ret;
 }
 
 void npc_cn20k_deinit(struct rvu *rvu)
-- 
2.43.0


