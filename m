Return-Path: <netdev+bounces-279641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH3DOcCR5WlNlgEAu9opvQ
	(envelope-from <netdev+bounces-279641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:38:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E34265BC
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89FBF30658BC
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1242378D71;
	Mon, 20 Apr 2026 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hCEKLunN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1837880E;
	Mon, 20 Apr 2026 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652543; cv=none; b=T3JonVj9sd6i+sjap1ztfAsEWTTbzvLqogYsG9Onv9/HoovOQ3TbSSTFvrNkwh/WQ5rHlsA9bdfUWHRpHzARy7+AR5zaePK1EacPpSSGLi0GMBYxwXzP6xv8DnvY14cozIyGozqvmFmmlGO2pnYC603xomA75mlKqBpi0pp9v00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652543; c=relaxed/simple;
	bh=huiiG6KBGsqerQOD7ZMxlGMUB5OmWx4c9+pyIt9I2SI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfLb19NYf7pyIjxmCQJGLSRzN3yYKRkOZTDZPIehCcycVfrkBb/SPB1jGQrtDCZaEvOhitXOi9RnuRFLqPJStd8/vw5WH9bZewYeab0qvcHLmofHct+laB715Kp3hj75LX5lEH2IszUvNYIuDGITs8JPG4qbcKSpkYyQ/80qSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hCEKLunN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K2IUKj2059144;
	Sun, 19 Apr 2026 19:35:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
	e73ZqMfYyUzG+fAE0V2ZH0QqqOR5rLFh53/YXXBvF8=; b=hCEKLunNPrT4VCj0L
	dNeW27KFidLykDKz8Ko6rwLk4PGYJ/pzfyJt/LYzmzz576tMjlwwBXG1hXzI4N/c
	Jdo5L/FGCpHEsgUfRZKWIXClSuKGZB7T1EgNDLhpcHHMRa3V3j/o9M/IRint+S0R
	ctr6SnoukEcQT3JVCyxQCaiZXtmqmhIv1eXVBp4REaNYp6jFSH2iCaqQ3PHvky8y
	QODhg26Dm+pOu7Tb2g/mw2OvxbxROoTHgsJ8XpOk/eYkqXTBduy8Isa1BRkVo/Ob
	slnlwqYKdv09pTLP8dHJPVWnVTBxLsFJNPVbbtICi8C7bWhieAIwvTMZM+/5iUvV
	ex+5g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dnb8180r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Apr 2026 19:35:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 19 Apr 2026 19:35:28 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 4AED03F7041;
	Sun, 19 Apr 2026 19:35:25 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
        "Suman
 Ghosh" <sumang@marvell.com>
Subject: [PATCH v2 net 07/11] octeontx2-af: npc: cn20k: Fix bank value.
Date: Mon, 20 Apr 2026 08:04:38 +0530
Message-ID: <20260420023442.3295891-8-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420023442.3295891-1-rkannoth@marvell.com>
References: <20260420023442.3295891-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyMyBTYWx0ZWRfXyH/EI/JC99Yj
 u/X/vmKUmIUQ5O0bKPF/BrsMtVGwF82MHz5/Zt36Y8AHGqDQSYWPD5KcG6LqbIxGJr/UrXGiO4r
 0EMClrVlsoWVr6qoJ93QUYogXboMwbyEzpmVoNLAiBWs/vKf2c3cwSO4LRQsQ6+uEwWgf9scmgn
 3I2zVVLYN1nm/xO48ZFRCUExFmicnbtliQd960ZykFK8Ycu7rzW1dNs+bDoKOc03w4vl/sy3Kjc
 vw0GuqfW6ovI+WBye+coT7L9GPQZy4d1vP4OYKMziuhdQXav66iFf3GeYBNU0CzKxDEfvLf9Lgk
 8MaQbKbQOXmu0rRBSEpqh1jwhM9mHqxI6/Ds+LJIi51W6wnyAxxW5+34RYjmvGnz5WsejhM+gjo
 5Pz3LIaBe0vBWQvnyGyPmjMxSXGEH8UOhB1RDAiwTS98aKHdy6e07dHoTC4BqkZqnIF9q8scxCI
 UkrGA3KBLrTZduQoGyA==
X-Proofpoint-GUID: OfNnNOwptTjfi8-vWJvUlWGRzoolp6Lb
X-Authority-Analysis: v=2.4 cv=W6wIkxWk c=1 sm=1 tr=0 ts=69e590f1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=1IUtMPC23dKFR1PEuaoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: OfNnNOwptTjfi8-vWJvUlWGRzoolp6Lb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
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
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279641-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 930E34265BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

or X4 keys its loop reused the bank parameter as the loop counter,
so bank no longer reflected the caller's bank after the loop and
the control flow was hard to follow.
Program NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT directly in
npc_cn20k_config_mcam_entry(): one CFG write for X2 using the computed
bank, and one CFG write per bank inside the X4 action loop. Enable the
entry at the end with npc_cn20k_enable_mcam_entry(..., true) instead of
embedding the enable bit in bank_cfg via the removed helper.

Cc: Suman Ghosh <sumang@marvell.com>
Fixes: 4e527f1e5c15 ("octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 92 ++++++++-----------
 1 file changed, 37 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 7bfd39fe0f5e..4b37d471f118 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -1044,34 +1044,6 @@ static void npc_cn20k_config_kw_x4(struct rvu *rvu, struct npc_mcam *mcam,
 				       kw, req_kw_type);
 }
 
-static void
-npc_cn20k_set_mcam_bank_cfg(struct rvu *rvu, int blkaddr, int mcam_idx,
-			    int bank, u8 kw_type, bool enable, u8 hw_prio)
-{
-	struct npc_mcam *mcam = &rvu->hw->mcam;
-	u64 bank_cfg;
-
-	bank_cfg = (u64)hw_prio << 24;
-	if (enable)
-		bank_cfg |= 0x1;
-
-	if (kw_type == NPC_MCAM_KEY_X2) {
-		rvu_write64(rvu, blkaddr,
-			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
-			    bank_cfg);
-		return;
-	}
-
-	/* For NPC_MCAM_KEY_X4 keys, both the banks
-	 * need to be programmed with the same value.
-	 */
-	for (bank = 0; bank < mcam->banks_per_entry; bank++) {
-		rvu_write64(rvu, blkaddr,
-			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
-			    bank_cfg);
-	}
-}
-
 int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 				u8 intf, struct cn20k_mcam_entry *entry,
 				bool enable, u8 hw_prio, u8 req_kw_type)
@@ -1079,6 +1051,7 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int mcam_idx = index % mcam->banksize;
 	int bank = index / mcam->banksize;
+	u64 bank_cfg = (u64)hw_prio << 24;
 	int kw = 0;
 	u8 kw_type;
 
@@ -1118,41 +1091,50 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
 								  bank, 1),
 			    entry->vtag_action);
-		goto set_cfg;
-	}
 
-	/* Clear mcam entry to avoid writes being suppressed by NPC */
-	npc_clear_x2_entry(rvu, blkaddr, 0, mcam_idx);
-	npc_clear_x2_entry(rvu, blkaddr, 1, mcam_idx);
-
-	npc_cn20k_config_kw_x4(rvu, mcam, blkaddr,
-			       mcam_idx, intf, entry,
-			       kw_type, req_kw_type);
-	for (bank = 0; bank < mcam->banks_per_entry; bank++) {
-		/* Set 'action' */
+		/* Set HW priority */
 		rvu_write64(rvu, blkaddr,
-			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
-								  bank, 0),
-			    entry->action);
+			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
+			    bank_cfg);
 
-		/* Set TAG 'action' */
-		rvu_write64(rvu, blkaddr,
-			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
-								  bank, 1),
-			    entry->vtag_action);
+	} else {
+		/* Clear mcam entry to avoid writes being suppressed by NPC */
+		npc_clear_x2_entry(rvu, blkaddr, 0, mcam_idx);
+		npc_clear_x2_entry(rvu, blkaddr, 1, mcam_idx);
 
-		/* Set 'action2' for inline receive */
-		rvu_write64(rvu, blkaddr,
-			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
-								  bank, 2),
-			    entry->action2);
+		npc_cn20k_config_kw_x4(rvu, mcam, blkaddr,
+				       mcam_idx, intf, entry,
+				       kw_type, req_kw_type);
+		for (bank = 0; bank < mcam->banks_per_entry; bank++) {
+			/* Set 'action' */
+			rvu_write64(rvu, blkaddr,
+				    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
+									  bank, 0),
+				    entry->action);
+
+			/* Set TAG 'action' */
+			rvu_write64(rvu, blkaddr,
+				    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
+									  bank, 1),
+				    entry->vtag_action);
+
+			/* Set 'action2' for inline receive */
+			rvu_write64(rvu, blkaddr,
+				    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
+									  bank, 2),
+				    entry->action2);
+
+			/* Set HW priority */
+			rvu_write64(rvu, blkaddr,
+				    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
+				    bank_cfg);
+		}
 	}
 
-set_cfg:
 	/* TODO: */
 	/* PF installing VF rule */
-	npc_cn20k_set_mcam_bank_cfg(rvu, blkaddr, mcam_idx, bank,
-				    kw_type, enable, hw_prio);
+	if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable))
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.43.0


