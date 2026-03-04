Return-Path: <netdev+bounces-263588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCQMNGC7p2nfjQAAu9opvQ
	(envelope-from <netdev+bounces-263588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:56:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 338E41FAC55
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B3223066439
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 04:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B1E37F8B2;
	Wed,  4 Mar 2026 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MJHWuLVc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C593090F5;
	Wed,  4 Mar 2026 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772600152; cv=none; b=OHwZNJ8pySA7b+/Tqy+Rm8xZarYGYp7cieOyYuGBJJrKW4cLqEy88icJsx9Qn3DmqnAcPO3Rbo6B1/8tMmns0PqpBMUc/jBdY/FVssbfgOeKH9mTnI3FbG3g3vB2TWXHWU1qs/9xNKXOHQFCSy5cITgfZcLCNruYNf7mRBmDO04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772600152; c=relaxed/simple;
	bh=khxVZXz2UwlPvAxJSk4BhMH4Rt9IB5WG6oEwio4B7tw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLUuVhEhbiQDMcM3PLtBMj+WZQVXZ7LdSVaIiO6yoSjBHZ3fAXt6tDhlafMyB5fw8KlwJb6GsmQ3H8KW3E4G+3gb3jpz5TSnmZNsq+hLfBihoAfWB8zthJhl8vhtNmu++kaJNbsp77iEUSqF3Aazk7KONzhrj2kjCTQXipPFZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MJHWuLVc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623NTNHs1745650;
	Tue, 3 Mar 2026 20:31:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=3
	I+bvhMr8syqPK65ddf3dds/n78HG+GhWdiBRH6ZWeY=; b=MJHWuLVc3rphqrDlo
	COhXtiOupFa3o3UWVViden8nnVTURqhVMq7f/6rmOEJC3qEqhlHYkRvQgM3vypIL
	pe5LNzlb1L+apm/YVZYFEZEco1REB1j6LgzIA+udRCByBH4eZfnU5hDERxJExPlP
	pUuFJWbiGXcPsdI1wSiPYRKQ3cKyajXTaB+j8/bvfcc4v6vorbz8ZybglYIQFnZ/
	WFG25EbVgWkyMkdIcVJpLSfeujXW+a5NQcUHQnEwWIDdgfMxewj1mBTj3u6IEbsK
	ttmO8BKDhbZpMDPqvMemYPgFGd63K3oj9Kd8eMCMKkk07pFcJsyWYM4R2D9vg8W1
	xWtjw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cp9bg0k50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 20:31:51 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Mar 2026 20:31:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 3 Mar 2026 20:31:50 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id BD9CF3F706A;
	Tue,  3 Mar 2026 20:31:45 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v2 net-next 4/5] octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM entries
Date: Wed, 4 Mar 2026 10:00:31 +0530
Message-ID: <20260304043032.3661647-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304043032.3661647-1-rkannoth@marvell.com>
References: <20260304043032.3661647-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=NarrFmD4 c=1 sm=1 tr=0 ts=69a7b5b7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=WDb9-8Tz2aN2ynPxKakA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAzNSBTYWx0ZWRfX/EoHGdmdfjhC
 83Z51b+nwbrf6JlSyIEoGZmx7iFcEHq1K7Z1qVKAaghLLLzkuCSZFDfQFlgv1HPyN0To6Ch2aMV
 xkWM45AveVf0dlmVOtvkZajf8EyHOYN9pVpuWGiQFktFo8J4YZ8Tp9ow7Wy1v6FRGEfsP5e1Mqs
 VG5E5kZzg5e58TBt0IEzH3WsmeGRQjCraDT8lVVKlB5CX6MWytXKpvhmlpz2laFvW0AqLijjq55
 cTz4qa1QhB9h3Bnz1o9kotdC5aMN0NWr5jiBbyMfr7JBN6QJ2mSCroByn4Xmi9ND0SNqotVxx2k
 S/d6b8fLsaOCbj5z63vM4eKvaXE2znzArP+/q3tvk3Uvpa8miEJxQ3RzF86v5FLH5yj/W/59C9q
 tVEGioldaBryrRuIIop6kgL6/+LhFTkWY++07wKjv5vnT/+GCFdNMo7X7ePeu3ukm8MuJthHJgA
 8n7KxB1qP6KpAu7ntqw==
X-Proofpoint-GUID: -q6xwR7ugJGj-mJiNA2GtE2lMnTpJgaI
X-Proofpoint-ORIG-GUID: -q6xwR7ugJGj-mJiNA2GtE2lMnTpJgaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Rspamd-Queue-Id: 338E41FAC55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263588-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Improve MCAM utilization by tying default (broadcast, multicast,
promisc, ucast) entry lifetime to NIX LF usage.

- On NIX LF alloc (e.g. kernel or DPDK), allocate default MCAM entries
  if missing; on NIX LF free, release them so they return to the pool.
- Add NIX_LF_DONT_FREE_DFT_IDXS so the kernel PF driver can free the
  NIX LF without releasing default entries (e.g. across suspend/resume).
- When NIX LF is used by DPDK, default entries are allocated on first
  use and freed when the LF is released if NIX_LF_DONT_FREE_DFT_IDXS is
  not set

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 108 +++++++++++----
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  14 ++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 128 +++++++++++++-----
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   6 +-
 6 files changed, 190 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 348a72c4ee43..8dad272fd069 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -808,6 +808,11 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 	u64 cfg, hw_prio;
 	u8 kw_type;
 
+	if (index < 0 || index >= mcam->total_entries) {
+		WARN(1, "Wrong mcam index %d\n", index);
+		return;
+	}
+
 	enable ? set_bit(index, npc_priv.en_map) :
 		clear_bit(index, npc_priv.en_map);
 
@@ -1053,6 +1058,11 @@ void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	int kw = 0;
 	u8 kw_type;
 
+	if (index < 0 || index >= mcam->total_entries) {
+		WARN(1, "Wrong mcam index %d\n", index);
+		return;
+	}
+
 	/* Disable before mcam entry update */
 	npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, false);
 
@@ -1132,6 +1142,11 @@ void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
 	int bank, i, sb, db;
 	int dbank, sbank;
 
+	if (src >= mcam->total_entries || dest >= mcam->total_entries) {
+		WARN(1, "Wrong mcam index src=%u dest=%u\n", src, dest);
+		return;
+	}
+
 	dbank = npc_get_bank(mcam, dest);
 	sbank = npc_get_bank(mcam, src);
 	npc_mcam_idx_2_key_type(rvu, src, &src_kwtype);
@@ -1190,11 +1205,24 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 	int kw = 0, bank;
 	u8 kw_type;
 
+	if (index >= mcam->total_entries) {
+		WARN(1, "Wrong mcam index %u\n", index);
+		return;
+	}
+
 	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
 
 	bank = npc_get_bank(mcam, index);
 	index &= (mcam->banksize - 1);
 
+	cfg = rvu_read64(rvu, blkaddr,
+			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, bank, 0));
+	entry->action = cfg;
+
+	cfg = rvu_read64(rvu, blkaddr,
+			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, bank, 1));
+	entry->vtag_action = cfg;
+
 	cfg = rvu_read64(rvu, blkaddr,
 			 NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(index,
 								 bank, 1)) & 3;
@@ -1244,7 +1272,7 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 									bank,
 									0));
 		npc_cn20k_fill_entryword(entry, kw + 3, cam0, cam1);
-		goto read_action;
+		return;
 	}
 
 	for (bank = 0; bank < mcam->banks_per_entry; bank++, kw = kw + 4) {
@@ -1289,17 +1317,6 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 		npc_cn20k_fill_entryword(entry, kw + 3, cam0, cam1);
 	}
 
-read_action:
-	/* 'action' is set to same value for both bank '0' and '1'.
-	 * Hence, reading bank '0' should be enough.
-	 */
-	cfg = rvu_read64(rvu, blkaddr,
-			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, 0, 0));
-	entry->action = cfg;
-
-	cfg = rvu_read64(rvu, blkaddr,
-			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, 0, 1));
-	entry->vtag_action = cfg;
 }
 
 int rvu_mbox_handler_npc_cn20k_mcam_write_entry(struct rvu *rvu,
@@ -1671,8 +1688,8 @@ int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type)
 
 	/* mcam_idx should be less than (2 * bank depth) */
 	if (mcam_idx >= npc_priv.bank_depth * 2) {
-		dev_err(rvu->dev, "%s: bad params\n",
-			__func__);
+		dev_err(rvu->dev, "%s: bad params mcam_idx=%u\n",
+			__func__, mcam_idx);
 		return -EINVAL;
 	}
 
@@ -4024,6 +4041,13 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 	void *val;
 	int i, j;
 
+	for (int i = 0; i < ARRAY_SIZE(ptr); i++) {
+		if (!ptr[i])
+			continue;
+
+		*ptr[i] = USHRT_MAX;
+	}
+
 	if (!npc_priv.init_done)
 		return 0;
 
@@ -4039,7 +4063,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
 				 pcifunc);
 
-			*ptr[0] = USHRT_MAX;
 			return -ESRCH;
 		}
 
@@ -4059,7 +4082,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
 				 pcifunc);
 
-			*ptr[3] = USHRT_MAX;
 			return -ESRCH;
 		}
 
@@ -4079,7 +4101,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 __func__,
 				 npc_dft_rule_name[i], pcifunc);
 
-			*ptr[j] = USHRT_MAX;
 			continue;
 		}
 
@@ -4174,7 +4195,7 @@ int rvu_mbox_handler_npc_get_dft_rl_idxs(struct rvu *rvu, struct msg_req *req,
 	return 0;
 }
 
-static bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
+bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
 {
 	return is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)) ||
 		is_lbk_vf(rvu, pcifunc);
@@ -4182,9 +4203,10 @@ static bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
 
 void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 {
-	struct npc_mcam_free_entry_req free_req = { 0 };
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct rvu_npc_mcam_rule *rule, *tmp;
 	unsigned long index;
-	struct msg_rsp rsp;
+	int blkaddr;
 	u16 ptr[4];
 	int rc, i;
 	void *map;
@@ -4209,7 +4231,7 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
 		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
 		if (!map)
-			dev_dbg(rvu->dev,
+			dev_err(rvu->dev,
 				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
 				__func__,
 				npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
@@ -4223,7 +4245,7 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
 		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
 		if (!map)
-			dev_dbg(rvu->dev,
+			dev_err(rvu->dev,
 				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
 				__func__,
 				npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
@@ -4237,21 +4259,47 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 		index = NPC_DFT_RULE_ID_MK(pcifunc, i);
 		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
 		if (!map)
-			dev_dbg(rvu->dev,
+			dev_err(rvu->dev,
 				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
 				__func__, npc_dft_rule_name[i],
 				pcifunc);
 	}
 
 free_rules:
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return;
 
-	free_req.hdr.pcifunc = pcifunc;
-	free_req.all = 1;
-	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
-	if (rc)
-		dev_err(rvu->dev,
-			"%s: Error deleting default entries (pcifunc=%#x\n",
-			__func__, pcifunc);
+	for (int i = 0; i < 4; i++) {
+		if (ptr[i] == USHRT_MAX)
+			continue;
+
+		mutex_lock(&mcam->lock);
+		npc_mcam_clear_bit(mcam, ptr[i]);
+		mcam->entry2pfvf_map[ptr[i]] = NPC_MCAM_INVALID_MAP;
+		npc_cn20k_enable_mcam_entry(rvu, blkaddr, ptr[i], false);
+		mcam->entry2target_pffunc[ptr[i]] = 0x0;
+		mutex_unlock(&mcam->lock);
+
+		rc = npc_cn20k_idx_free(rvu, &ptr[i], 1);
+		if (rc)
+			dev_err(rvu->dev,
+				"%s:%d Error deleting default entries (pcifunc=%#x) mcam_idx=%u\n",
+				__func__, __LINE__, pcifunc, ptr[i]);
+	}
+
+	mutex_lock(&mcam->lock);
+	list_for_each_entry_safe(rule, tmp, &mcam->mcam_rules, list) {
+		for (int i = 0; i < 4; i++) {
+			if (ptr[i] != rule->entry)
+				continue;
+
+			list_del(&rule->list);
+			kfree(rule);
+			break;
+		}
+	}
+	mutex_unlock(&mcam->lock);
 }
 
 int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index b168ecfbc5c8..0fa56f5382b4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -345,5 +345,6 @@ int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
 			       int *sb_off);
 const u32 *npc_cn20k_search_order_get(bool *restricted_order, u32 *sz);
 int npc_cn20k_search_order_set(struct rvu *rvu, u32 arr[32], int cnt);
+bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc);
 
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index dc42c81c0942..e07fbf842b94 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1009,6 +1009,7 @@ struct nix_lf_free_req {
 	struct mbox_msghdr hdr;
 #define NIX_LF_DISABLE_FLOWS		BIT_ULL(0)
 #define NIX_LF_DONT_FREE_TX_VTAG	BIT_ULL(1)
+#define NIX_LF_DONT_FREE_DFT_IDXS	BIT_ULL(2)
 	u64 flags;
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index badfa1d64252..0fb2d71116f4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -16,6 +16,7 @@
 #include "cgx.h"
 #include "lmac_common.h"
 #include "rvu_npc_hash.h"
+#include "cn20k/npc.h"
 
 static void nix_free_tx_vtag_entries(struct rvu *rvu, u16 pcifunc);
 static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
@@ -1684,6 +1685,12 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	if (is_sdp_pfvf(rvu, pcifunc))
 		intf = NIX_INTF_TYPE_SDP;
 
+	if (is_cn20k(rvu->pdev)) {
+		rc = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
+		if (rc)
+			goto free_dft;
+	}
+
 	err = nix_interface_init(rvu, pcifunc, intf, nixlf, rsp,
 				 !!(req->flags & NIX_LF_LBK_BLK_SEL));
 	if (err)
@@ -1699,6 +1706,10 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 
 	goto exit;
 
+free_dft:
+	if (is_cn20k(rvu->pdev))
+		npc_cn20k_dft_rules_free(rvu, pcifunc);
+
 free_mem:
 	nix_ctx_free(rvu, pfvf);
 	rc = -ENOMEM;
@@ -1775,6 +1786,9 @@ int rvu_mbox_handler_nix_lf_free(struct rvu *rvu, struct nix_lf_free_req *req,
 
 	nix_ctx_free(rvu, pfvf);
 
+	if (is_cn20k(rvu->pdev) && !(req->flags & NIX_LF_DONT_FREE_DFT_IDXS))
+		npc_cn20k_dft_rules_free(rvu, pcifunc);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c2ca5ed1d028..352dc5f1d5b9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -165,12 +165,20 @@ int npc_get_nixlf_mcam_index(struct npc_mcam *mcam,
 
 		switch (type) {
 		case NIXLF_BCAST_ENTRY:
+			if (bcast == USHRT_MAX)
+				return -EINVAL;
 			return bcast;
 		case NIXLF_ALLMULTI_ENTRY:
+			if (mcast == USHRT_MAX)
+				return -EINVAL;
 			return mcast;
 		case NIXLF_PROMISC_ENTRY:
+			if (promisc == USHRT_MAX)
+				return -EINVAL;
 			return promisc;
 		case NIXLF_UCAST_ENTRY:
+			if (ucast == USHRT_MAX)
+				return -EINVAL;
 			return ucast;
 		default:
 			return -EINVAL;
@@ -237,12 +245,8 @@ void npc_enable_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	int bank = npc_get_bank(mcam, index);
 	int actbank = bank;
 
-	if (is_cn20k(rvu->pdev)) {
-		if (index < 0 || index >= mcam->banksize * mcam->banks)
-			return;
-
+	if (is_cn20k(rvu->pdev))
 		return npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable);
-	}
 
 	index &= (mcam->banksize - 1);
 	for (; bank < (actbank + mcam->banks_per_entry); bank++) {
@@ -1113,7 +1117,7 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 		index = mcam_index;
 	}
 
-	if (index >= mcam->total_entries)
+	if (index < 0 || index >= mcam->total_entries)
 		return;
 
 	bank = npc_get_bank(mcam, index);
@@ -1158,16 +1162,18 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 		/* If PF's promiscuous  entry is enabled,
 		 * Set RSS action for that entry as well
 		 */
-		npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
-						  blkaddr, alg_idx);
+		if (index >= 0)
+			npc_update_rx_action_with_alg_idx(rvu, action, pfvf,
+							  index, blkaddr, alg_idx);
 
 		index = npc_get_nixlf_mcam_index(mcam, pcifunc,
 						 nixlf, NIXLF_ALLMULTI_ENTRY);
 		/* If PF's allmulti  entry is enabled,
 		 * Set RSS action for that entry as well
 		 */
-		npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
-						  blkaddr, alg_idx);
+		if (index >= 0)
+			npc_update_rx_action_with_alg_idx(rvu, action, pfvf,
+							  index, blkaddr, alg_idx);
 	}
 }
 
@@ -1212,8 +1218,13 @@ static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
 	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int type = NIXLF_UCAST_ENTRY;
 	int index, blkaddr;
 
+	/* only CGX or LBK interfaces have default entries */
+	if (is_cn20k(rvu->pdev) && !npc_is_cgx_or_lbk(rvu, pcifunc))
+		return;
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return;
@@ -1221,8 +1232,11 @@ static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
 	/* Ucast MCAM match entry of this PF/VF */
 	if (npc_is_feature_supported(rvu, BIT_ULL(NPC_DMAC),
 				     pfvf->nix_rx_intf)) {
+		if (is_cn20k(rvu->pdev) && is_lbk_vf(rvu, pcifunc))
+			type = NIXLF_PROMISC_ENTRY;
+
 		index = npc_get_nixlf_mcam_index(mcam, pcifunc,
-						 nixlf, NIXLF_UCAST_ENTRY);
+						 nixlf, type);
 		npc_enable_mcam_entry(rvu, mcam, blkaddr, index, enable);
 	}
 
@@ -1232,9 +1246,13 @@ static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
 	if ((pcifunc & RVU_PFVF_FUNC_MASK) && !rvu->hw->cap.nix_rx_multicast)
 		return;
 
+	type = NIXLF_BCAST_ENTRY;
+	if (is_cn20k(rvu->pdev) && is_lbk_vf(rvu, pcifunc))
+		type = NIXLF_PROMISC_ENTRY;
+
 	/* add/delete pf_func to broadcast MCE list */
 	npc_enadis_default_mce_entry(rvu, pcifunc, nixlf,
-				     NIXLF_BCAST_ENTRY, enable);
+				     type, enable);
 }
 
 void rvu_npc_disable_default_entries(struct rvu *rvu, u16 pcifunc, int nixlf)
@@ -1244,6 +1262,9 @@ void rvu_npc_disable_default_entries(struct rvu *rvu, u16 pcifunc, int nixlf)
 
 	npc_enadis_default_entries(rvu, pcifunc, nixlf, false);
 
+	if (is_cn20k(rvu->pdev) && is_vf(pcifunc))
+		return;
+
 	/* Delete multicast and promisc MCAM entries */
 	npc_enadis_default_mce_entry(rvu, pcifunc, nixlf,
 				     NIXLF_ALLMULTI_ENTRY, false);
@@ -1301,6 +1322,10 @@ void rvu_npc_disable_mcam_entries(struct rvu *rvu, u16 pcifunc, int nixlf)
 	if (blkaddr < 0)
 		return;
 
+	/* only CGX or LBK interfaces have default entries */
+	if (is_cn20k(rvu->pdev) && !npc_is_cgx_or_lbk(rvu, pcifunc))
+		return;
+
 	mutex_lock(&mcam->lock);
 
 	/* Disable MCAM entries directing traffic to this 'pcifunc' */
@@ -1345,6 +1370,8 @@ void rvu_npc_free_mcam_entries(struct rvu *rvu, u16 pcifunc, int nixlf)
 	/* Free all MCAM counters owned by this 'pcifunc' */
 	npc_mcam_free_all_counters(rvu, mcam, pcifunc);
 
+	rvu_npc_disable_default_entries(rvu, pcifunc, nixlf);
+
 	/* Delete MCAM entries owned by this 'pcifunc' */
 	list_for_each_entry_safe(rule, tmp, &mcam->mcam_rules, list) {
 		if (rule->owner == pcifunc && !rule->default_rule) {
@@ -1355,7 +1382,6 @@ void rvu_npc_free_mcam_entries(struct rvu *rvu, u16 pcifunc, int nixlf)
 
 	mutex_unlock(&mcam->lock);
 
-	rvu_npc_disable_default_entries(rvu, pcifunc, nixlf);
 }
 
 static void npc_program_mkex_rx(struct rvu *rvu, int blkaddr,
@@ -2504,33 +2530,58 @@ void npc_mcam_clear_bit(struct npc_mcam *mcam, u16 index)
 static void npc_mcam_free_all_entries(struct rvu *rvu, struct npc_mcam *mcam,
 				      int blkaddr, u16 pcifunc)
 {
+	u16 dft_idxs[NPC_DFT_RULE_MAX_ID] = {[0 ... NPC_DFT_RULE_MAX_ID - 1] = USHRT_MAX};
 	u16 index, cntr;
+	bool dft_rl;
 	int rc;
 
+	npc_cn20k_dft_rules_idx_get(rvu, pcifunc,
+				    &dft_idxs[NPC_DFT_RULE_BCAST_ID],
+				    &dft_idxs[NPC_DFT_RULE_MCAST_ID],
+				    &dft_idxs[NPC_DFT_RULE_PROMISC_ID],
+				    &dft_idxs[NPC_DFT_RULE_UCAST_ID]);
+
 	/* Scan all MCAM entries and free the ones mapped to 'pcifunc' */
 	for (index = 0; index < mcam->bmap_entries; index++) {
-		if (mcam->entry2pfvf_map[index] == pcifunc) {
-			mcam->entry2pfvf_map[index] = NPC_MCAM_INVALID_MAP;
-			/* Free the entry in bitmap */
-			npc_mcam_clear_bit(mcam, index);
-			/* Disable the entry */
-			npc_enable_mcam_entry(rvu, mcam, blkaddr, index, false);
-
-			/* Update entry2counter mapping */
-			cntr = mcam->entry2cntr_map[index];
-			if (cntr != NPC_MCAM_INVALID_MAP)
-				npc_unmap_mcam_entry_and_cntr(rvu, mcam,
-							      blkaddr, index,
-							      cntr);
-			mcam->entry2target_pffunc[index] = 0x0;
-			if (is_cn20k(rvu->pdev)) {
-				rc = npc_cn20k_idx_free(rvu, &index, 1);
-				if (rc)
-					dev_err(rvu->dev,
-						"Failed to free mcam idx=%u pcifunc=%#x\n",
-						index, pcifunc);
+		if (mcam->entry2pfvf_map[index] != pcifunc)
+			continue;
+
+		mcam->entry2pfvf_map[index] = NPC_MCAM_INVALID_MAP;
+
+		dft_rl = false;
+		if (is_cn20k(rvu->pdev)) {
+			if (dft_idxs[NPC_DFT_RULE_BCAST_ID] == index ||
+			    dft_idxs[NPC_DFT_RULE_MCAST_ID] == index ||
+			    dft_idxs[NPC_DFT_RULE_PROMISC_ID] == index ||
+			    dft_idxs[NPC_DFT_RULE_UCAST_ID] == index) {
+				dft_rl = true;
 			}
 		}
+
+		/* Free the entry in bitmap.*/
+		if (!dft_rl)
+			npc_mcam_clear_bit(mcam, index);
+
+		/* Disable the entry */
+		npc_enable_mcam_entry(rvu, mcam, blkaddr, index, false);
+
+		/* Update entry2counter mapping */
+		cntr = mcam->entry2cntr_map[index];
+		if (cntr != NPC_MCAM_INVALID_MAP)
+			npc_unmap_mcam_entry_and_cntr(rvu, mcam,
+						      blkaddr, index,
+						      cntr);
+		mcam->entry2target_pffunc[index] = 0x0;
+		if (is_cn20k(rvu->pdev)) {
+			if (dft_rl)
+				continue;
+
+			rc = npc_cn20k_idx_free(rvu, &index, 1);
+			if (rc)
+				dev_err(rvu->dev,
+					"Failed to free mcam idx=%u pcifunc=%#x\n",
+					index, pcifunc);
+		}
 	}
 }
 
@@ -3917,13 +3968,22 @@ void rvu_npc_clear_ucast_entry(struct rvu *rvu, int pcifunc, int nixlf)
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct rvu_npc_mcam_rule *rule;
 	int ucast_idx, blkaddr;
+	u8 type;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return;
 
+	type = NIXLF_UCAST_ENTRY;
+	if (is_cn20k(rvu->pdev) && is_lbk_vf(rvu, pcifunc))
+		type = NIXLF_PROMISC_ENTRY;
+
 	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
-					     nixlf, NIXLF_UCAST_ENTRY);
+					     nixlf, type);
+
+	/* In cn20k, default rules are freed before detach rsrc */
+	if (ucast_idx < 0)
+		return;
 
 	npc_enable_mcam_entry(rvu, mcam, blkaddr, ucast_idx, false);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ee623476e5ff..81b088f5a016 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1053,7 +1053,6 @@ irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 	/* Clear the IRQ */
 	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
 
-
 	mbox_data = otx2_read64(pf, RVU_PF_PFAF_MBOX0);
 
 	if (mbox_data & MBOX_UP_MSG) {
@@ -1729,7 +1728,7 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
 	mutex_lock(&mbox->lock);
 	free_req = otx2_mbox_alloc_msg_nix_lf_free(mbox);
 	if (free_req) {
-		free_req->flags = NIX_LF_DISABLE_FLOWS;
+		free_req->flags = NIX_LF_DISABLE_FLOWS | NIX_LF_DONT_FREE_DFT_IDXS;
 		if (otx2_sync_mbox_msg(mbox))
 			dev_err(pf->dev, "%s failed to free nixlf\n", __func__);
 	}
@@ -1803,7 +1802,7 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
 	/* Reset NIX LF */
 	free_req = otx2_mbox_alloc_msg_nix_lf_free(mbox);
 	if (free_req) {
-		free_req->flags = NIX_LF_DISABLE_FLOWS;
+		free_req->flags = NIX_LF_DISABLE_FLOWS | NIX_LF_DONT_FREE_DFT_IDXS;
 		if (!(pf->flags & OTX2_FLAG_PF_SHUTDOWN))
 			free_req->flags |= NIX_LF_DONT_FREE_TX_VTAG;
 		if (otx2_sync_mbox_msg(mbox))
@@ -1926,7 +1925,6 @@ int otx2_alloc_queue_mem(struct otx2_nic *pf)
 	struct otx2_qset *qset = &pf->qset;
 	struct otx2_cq_poll *cq_poll;
 
-
 	/* RQ and SQs are mapped to different CQs,
 	 * so find out max CQ IRQs (i.e CINTs) needed.
 	 */
-- 
2.43.0


