Return-Path: <netdev+bounces-279644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHF9N0WS5WmvlgEAu9opvQ
	(envelope-from <netdev+bounces-279644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:41:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 852684265FB
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E78F302768C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745A3377EDB;
	Mon, 20 Apr 2026 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BLGNZSvc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D32377EBA;
	Mon, 20 Apr 2026 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652556; cv=none; b=GkXanfRaKWIvWYSGkMBpTeiBpm7fLUDMNU5Mh3dSJ8GlW11FMZStNMMB9kYajvYmNJxaFzyJiLlT2ARnv+4+APwCwRrLvhwMnLjKTrQG0qDlkCe1z8dz9rT/IVClMpWBVXP6GZaxybjzc9lAoE77UwLf3P4JLdlhIjabSLN0VNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652556; c=relaxed/simple;
	bh=GFhPQk1ixvVE/pSq2hhoA8j3mR3SOYgODPmyTBkgf+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIAPFWeuVVTP/YpA++akB8Cv2TjJIEuTuIkc8QJPIXuPy8so++7GWPPsYOQoDGkaZQPg5few7JUHQRUkz63cX9X4K32gd0072gMv+OLTMhF48E41+MjfrKoK5e4mGE3wRdRClCZpeqXf+7sQoBVZ61+LYkpistETensop/GXejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BLGNZSvc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JNBYms814459;
	Sun, 19 Apr 2026 19:35:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
	wH1bJEdB1D/LvgtUdkC6aS/Fzej6IswWmjI4z75k3g=; b=BLGNZSvcgt8dZFBdg
	dCKjA4cvoNJmiNa9M7+rsPiuQ+CFLZMi7wsGYGDjG2H4nstx71NNKfT5YR9DLm9+
	b2fBeGI/LMlLpIMGszSUC95j23LovXhjbiI31x/vTLfsidNHKbuPqut7LnpdQuf+
	LlDRMbvkU+HiuskH9SKLAAfcTTH63tbWjLTP32qRr0glp5pXpwZ6aUlMh2wV+N1K
	LqPVn3r+jhfRuWV5J+Xr2G4hUXZ8YNz+jJs72ODNtaX0FiG3RMV35pBmQpsrk3fY
	+CuW1qXw82J3f6isiKUV4X8qi2xENVwMUb7nqAsLt7qwqtqFppe/4u+2q9KCkL1x
	NDp+w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dm9fgjj6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Apr 2026 19:35:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:46 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 19 Apr 2026 19:35:45 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B830E3F7041;
	Sun, 19 Apr 2026 19:35:41 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
        "Suman
 Ghosh" <sumang@marvell.com>
Subject: [PATCH v2 net 11/11] octeontx2-af: npc: cn20k: Reject missing default-rule MCAM indices
Date: Mon, 20 Apr 2026 08:04:42 +0530
Message-ID: <20260420023442.3295891-12-rkannoth@marvell.com>
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
X-Proofpoint-GUID: Z3D4XYFHh0Id6lmdIQ262_oX3e-ae3UD
X-Authority-Analysis: v=2.4 cv=TYSmcxQh c=1 sm=1 tr=0 ts=69e59103 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=5PJ-8yRtmk1h066FuvsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyMyBTYWx0ZWRfX6kOs7rJZOIxO
 rcRfrdFnUG4Xsc3u4cxxdSxt/yAO9La39X28tHkZCvWHE5Axd2J0Qp5jPpxQN/NYV93nysmrsPJ
 9yzoTtQ98gq1n3Dx6boMgNSHFNNCwBm+wO7vMOaaW8sF7XqTFUlx41N3QaUOZbsJI3HbOf0pbec
 FShLW7teIbqTfqV83dxTHIVozQP9qAEsor/dubFhAYPE5IJI3VuGBSl5iBa5+1NvT0Z0OcVn/AA
 newXJYOeAyqnf81X2Yq4r3bS5/ipryDWCaTbqtj4cYBSorLNQ2jsm8+ACJfkv4VXe0zm2XejY2I
 ym0L3cguU7ZOBYC0eWeMIW7slIh9YPnWJTJVMJMQqUJSYmdQJEzc69vx1TsILn4D9bV5ZlOM8N7
 tXed+Ojid0pDN5qWI0hqH4w6piKbFCjQGTSRLpdzrmAtDNiCp0tRPCPy9JiZRxbFk2gMEx6DMaE
 sGSOWAtDUAwynn/5ZcQ==
X-Proofpoint-ORIG-GUID: Z3D4XYFHh0Id6lmdIQ262_oX3e-ae3UD
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
	TAGGED_FROM(0.00)[bounces-279644-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 852684265FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

npc_get_nixlf_mcam_index() returned USHRT_MAX from npc_cn20k_dft_rules_idx_get()
for broadcast, multicast, promiscuous, and unicast default-rule slots when no
rule was installed.  Callers could use that sentinel as a real MCAM index.
Return -EINVAL from the cn20k cases when the reserved entry is still USHRT_MAX.
Teach rvu_npc_update_flowkey_alg_idx() to handle negative indices and skip RSS
action updates when the lookup fails.  Add range checks to cn20k NPC MCAM helpers
so bogus indices are rejected before touching hardware.

Cc: Suman Ghosh <sumang@marvell.com>
Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 12 ++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 23 ++++++++++++-------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index cb2fc21e0583..59d22511b742 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -808,6 +808,9 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 	u64 cfg, hw_prio;
 	u8 kw_type;
 
+	if (index < 0 || index >= mcam->total_entries)
+		return -EINVAL;
+
 	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
 		return -EINVAL;
 
@@ -1055,6 +1058,9 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	int kw = 0;
 	u8 kw_type;
 
+	if (index < 0 || index >= mcam->total_entries)
+		return -EINVAL;
+
 	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
 		return -EINVAL;
 
@@ -1147,6 +1153,9 @@ int npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
 	int bank, i, sb, db;
 	int dbank, sbank;
 
+	if (src >= mcam->total_entries || dest >= mcam->total_entries)
+		return -EINVAL;
+
 	dbank = npc_get_bank(mcam, dest);
 	sbank = npc_get_bank(mcam, src);
 
@@ -1212,6 +1221,9 @@ int npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 	int kw = 0, bank;
 	u8 kw_type;
 
+	if (index >= mcam->total_entries)
+		return -EINVAL;
+
 	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index b2a9c8d0075b..be79a51b4b48 100644
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
@@ -238,9 +246,6 @@ void npc_enable_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	int actbank = bank;
 
 	if (is_cn20k(rvu->pdev)) {
-		if (index < 0 || index >= mcam->banksize * mcam->banks)
-			return;
-
 		npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable);
 		return;
 	}
@@ -1128,7 +1133,7 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 		index = mcam_index;
 	}
 
-	if (index >= mcam->total_entries)
+	if (index < 0 || index >= mcam->total_entries)
 		return;
 
 	bank = npc_get_bank(mcam, index);
@@ -1173,16 +1178,18 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 		/* If PF's promiscuous  entry is enabled,
 		 * Set RSS action for that entry as well
 		 */
-		npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
-						  blkaddr, alg_idx);
+		if (index >= 0)
+			npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
+							  blkaddr, alg_idx);
 
 		index = npc_get_nixlf_mcam_index(mcam, pcifunc,
 						 nixlf, NIXLF_ALLMULTI_ENTRY);
 		/* If PF's allmulti  entry is enabled,
 		 * Set RSS action for that entry as well
 		 */
-		npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
-						  blkaddr, alg_idx);
+		if (index >= 0)
+			npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
+							  blkaddr, alg_idx);
 	}
 }
 
-- 
2.43.0


