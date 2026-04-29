Return-Path: <netdev+bounces-282204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKI6FNNs8WkIgwEAu9opvQ
	(envelope-from <netdev+bounces-282204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:28:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C27C48E4E6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BBB0301B5BD
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F2638236E;
	Wed, 29 Apr 2026 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fMnCZWwc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC18382299;
	Wed, 29 Apr 2026 02:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429681; cv=none; b=TeXBf/2tf4SPrQQrr34xTunMSEYRsF4cUQlUNYy9oTVof9HpwRsy3HSkDdkBC3Ng38Ry5FPnkfhnI0RztLQPCIPulFBYRxIN4LNyqSZEWXhuTvt4nEcdGlQ0C83gd+b/FiDcIEhKaryScxDh7qFY+rtrSy4X43HGsgKM3lRY5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429681; c=relaxed/simple;
	bh=1nNkmephO/88tXtkYMX1W7wTFOvInxHuF1zUrj+d/TA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1y6dnetVx9lWvaPFv5XT2c3npp4Jo1zGoc0HVW4aoehMiiIzR4u3PJ2SxBn4ym7zjjIPfUDORhyxwFJ+opB2R6Rl7dTq18kpM7CFUPIUff+lztKZvOxaVUjHpR49G7LWtuCJDI2kRHGFwR3m9ycCLvDkcUbzQLcR0XH1HiYkMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fMnCZWwc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SKZm782315120;
	Tue, 28 Apr 2026 19:27:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
	YkKYiHleP9TVdKaNUYBp9tdXwqjBOK9Lr7gKYEkyXQ=; b=fMnCZWwcEcM8kAwqb
	MAsQuV9frNH6R0d1/2Z7YBXzJK/z2P6VekumKMpwpIvnUjFmlamkRskYsfT93JEO
	TFK/7CXjlg9UH2rGIW+Un//h7fc5NqcA7eUFzaA7sqIJp7k76glbWaUyb+lNO/1d
	KnRbzbQa1cjSuaNf1CcRht5SQEM7CePaOYFnYOzmGBnCvampsxPy1FUsxed9zPo1
	eNQMF+QgFiVq7sWi5eP0xUmRFhE3iPqsIoRAJApYeOA/p43QkWMxFK2sdNLBxRSX
	LRQA8VmaO94c68x/ZN/txyXuslMM6BzSHtFIIJbLbGwO8HFiiAwrsX+wgK4Yqjpl
	xopwA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4drw4fsfa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 19:27:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Apr 2026 19:27:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Apr 2026 19:27:51 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E61133F70E2;
	Tue, 28 Apr 2026 19:27:47 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Suman Ghosh <sumang@marvell.com>
Subject: [PATCH v5 net 05/10] octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width
Date: Wed, 29 Apr 2026 07:57:17 +0530
Message-ID: <20260429022722.1110289-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429022722.1110289-1-rkannoth@marvell.com>
References: <20260429022722.1110289-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FR3WIL1WtfC9RsZ9Vc1JqQXFkYHLAuyX
X-Proofpoint-GUID: FR3WIL1WtfC9RsZ9Vc1JqQXFkYHLAuyX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyMSBTYWx0ZWRfX710voTQR4yrN
 SPsfFdG+iOE99vtCl3JMu/6wQMLSDby5CiXf7aBcsJ13+XSUN/Bqka0w/+Iiep0gllgx3TTQFn2
 1VDzdIuvqJNXgw8zrP01+jC2+jHldfIXv7OefGpANz84HPlYcybAPCNDJGD+nxXHAN/q7JLbKNk
 zrMuJdHOIjmRAkl5Wt58hw+Lgor1qPipdIkb2ZvOD6HdtD59Q40I/0YLV/IVp0NELg7WPOq3yIu
 3kE7l8lvIbTdUbloB2RYC+5wwoCcyvce+HUqwXQ05C4VMBhuLgEdroS4z/DJu0dYcDMUVyoUMFU
 nr6s4id3l0HBoUuYVbut2am+9uTXl5ZBXEgfe8ohd0f3Hu9EqRMAIm65h8QOKXO0rD5tmg2cEzN
 5djUpfY62O5+C/5A03ShKqfs79jBztDMr365uFdyyuK+NMB4BOnPSi6QEb6m1HXp5PFlshEM5sw
 GZysljmn2TAOWMrGkmA==
X-Authority-Analysis: v=2.4 cv=X/Ni7mTe c=1 sm=1 tr=0 ts=69f16ca7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=Te6SKzNpAKJ10Xq2tLIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: 0C27C48E4E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282204-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

Replace the old four-argument CN20K MCAM clear with a per-bank static
helper and npc_cn20k_clear_mcam_entry() that takes a logical MCAM index,
resolves the key width via npc_mcam_idx_2_key_type(), and clears either one
bank (X2) or every bank (X4).

Call it from npc_clear_mcam_entry() on cn20k and log when key-type lookup
fails. Use the per-bank helper from npc_cn20k_config_mcam_entry() for
pre-program clears.

For loopback VFs, use the promisc MCAM index as ucast_idx when copying RSS
action for promisc, matching cn20k default-rule layout.

Cc: Suman Ghosh <sumang@marvell.com>
Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 37 ++++++++++++++++---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  3 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 17 ++++++++-
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 70ce3f49adc1..112c37c190b1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -842,8 +842,8 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 	return 0;
 }
 
-void
-npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr, int bank, int index)
+static void
+npc_clear_x2_entry(struct rvu *rvu, int blkaddr, int bank, int index)
 {
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(index, bank, 1),
@@ -877,6 +877,33 @@ npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr, int bank, int index)
 		    NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index, bank), 0);
 }
 
+int
+npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr, int mcam_idx)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int bank = npc_get_bank(mcam, mcam_idx);
+	u8 kw_type;
+	int index;
+
+	if (npc_mcam_idx_2_key_type(rvu, mcam_idx, &kw_type))
+		return -EINVAL;
+
+	index = mcam_idx & (mcam->banksize - 1);
+
+	if (kw_type == NPC_MCAM_KEY_X2) {
+		npc_clear_x2_entry(rvu, blkaddr, bank, index);
+		return 0;
+	}
+
+	/* For NPC_MCAM_KEY_X4 keys, both the banks
+	 * need to be programmed with the same value.
+	 */
+	for (bank = 0; bank < mcam->banks_per_entry; bank++)
+		npc_clear_x2_entry(rvu, blkaddr, bank, index);
+
+	return 0;
+}
+
 static void npc_cn20k_get_keyword(struct cn20k_mcam_entry *entry, int idx,
 				  u64 *cam0, u64 *cam1)
 {
@@ -1071,7 +1098,7 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	 */
 	if (kw_type == NPC_MCAM_KEY_X2) {
 		/* Clear mcam entry to avoid writes being suppressed by NPC */
-		npc_cn20k_clear_mcam_entry(rvu, blkaddr, bank, mcam_idx);
+		npc_clear_x2_entry(rvu, blkaddr, bank, mcam_idx);
 		npc_cn20k_config_kw_x2(rvu, mcam, blkaddr,
 				       mcam_idx, intf, entry,
 				       bank, kw_type, kw, req_kw_type);
@@ -1096,8 +1123,8 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	}
 
 	/* Clear mcam entry to avoid writes being suppressed by NPC */
-	npc_cn20k_clear_mcam_entry(rvu, blkaddr, 0, mcam_idx);
-	npc_cn20k_clear_mcam_entry(rvu, blkaddr, 1, mcam_idx);
+	npc_clear_x2_entry(rvu, blkaddr, 0, mcam_idx);
+	npc_clear_x2_entry(rvu, blkaddr, 1, mcam_idx);
 
 	npc_cn20k_config_kw_x4(rvu, mcam, blkaddr,
 			       mcam_idx, intf, entry,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 8f3eea9cfb1d..2f761b97f91b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -330,8 +330,7 @@ int npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr,
 int npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 			      struct cn20k_mcam_entry *entry, u8 *intf,
 			      u8 *ena, u8 *hw_prio);
-void npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr,
-				int bank, int index);
+int npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr, int index);
 int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type);
 u16 npc_cn20k_vidx2idx(u16 index);
 u16 npc_cn20k_idx2vidx(u16 idx);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index ecaf0946b852..44ca65efc80f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -261,6 +261,13 @@ static void npc_clear_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	int bank = npc_get_bank(mcam, index);
 	int actbank = bank;
 
+	if (is_cn20k(rvu->pdev)) {
+		if (npc_cn20k_clear_mcam_entry(rvu, blkaddr, index))
+			dev_err(rvu->dev, "%s Failed to clear mcam %u\n",
+				__func__, index);
+		return;
+	}
+
 	index &= (mcam->banksize - 1);
 	for (; bank < (actbank + mcam->banks_per_entry); bank++) {
 		rvu_write64(rvu, blkaddr,
@@ -755,9 +762,15 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 
 	/* If the corresponding PF's ucast action is RSS,
 	 * use the same action for promisc also
+	 * Please note that for lbk(s) "index" and "ucast_idx"
+	 * will be same.
 	 */
-	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
-					     nixlf, NIXLF_UCAST_ENTRY);
+	if (is_lbk_vf(rvu, pcifunc))
+		ucast_idx = index;
+	else
+		ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
+						     nixlf, NIXLF_UCAST_ENTRY);
+
 	if (is_mcam_entry_enabled(rvu, mcam, blkaddr, ucast_idx))
 		*(u64 *)&action = npc_get_mcam_action(rvu, mcam,
 						      blkaddr, ucast_idx);
-- 
2.43.0


