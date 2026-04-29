Return-Path: <netdev+bounces-282211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOm9LgZu8WkIgwEAu9opvQ
	(envelope-from <netdev+bounces-282211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:33:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD33F48E5A5
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAC7430392F0
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC5E3876DE;
	Wed, 29 Apr 2026 02:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IlL4Phzz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CEF3822BA;
	Wed, 29 Apr 2026 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429698; cv=none; b=Rr9P6hqydvvNOdY3R6sEzpMWrMwMtyGdz/YYOuzgp+z3wtcgoTgjBzG6OUzJR2TaIA0gIPN/aXkL3fC7J590XTf2BjMUECmYYHWKqbWPsZ8dX0uyYpmBf9Au31KMJhK9QkMk1eHA/3gJG74qxIX4nd3XndJQ3XM9E3jgMGtdNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429698; c=relaxed/simple;
	bh=FPl5DTbb1fr5VW/cahSfvzgbvznPAKs7QsX+Uzi399E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjQKSD3J6N96ix6iJaANZx+zy/7IMLp1fAr27CF8y5Z1Xd5dDZOJNHEAtAuIAkZGmyKJuDy8jdWKKo+My0pCKtlUdmDDtJ6F3CucBX8lRMVcqHrvnAxypqbBq10OCOcp/8argC6Yd+nIKdC8KkdjS5XOIIOnXjwVmyxUisCI0Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IlL4Phzz; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SKnmk32315126;
	Tue, 28 Apr 2026 19:28:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	k9U77nlgtj8VosVlibkPUCpfkgbJ4cJuCSITsTAh+Q=; b=IlL4PhzzoGrYWWEPJ
	CP9AxO41+FtUVeQ1sHodbyRk++V9q+oqn0RG0NnzsQLvv+Nq8RLUdEN7HdAK8rPP
	8VcV1c5U7WuXZ4+xFC4W6Bv8wAC/FN5KKHuU4+tPZ01cwNm+uSO16B07qOBDk33/
	tkpTgMdYFityRbplskOLzNqG7FjJ3L5PMMk5rfJIJq7O5V4zIApRDOaroVM4d2+D
	WbADQmFw8j7ydJ1mR+TsK5wev0cLdQvVPvV7TH6f8CfXMNBqUUc2BkLVzZM4hPEi
	jUIdiBmwDc2yFqkvxDDfMRoNNGcsmCVboqeFY+01U8kM6l/nmdOqiatnVqcGgrxY
	ijM3w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4drw4fsfae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 19:28:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Apr 2026 19:28:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Apr 2026 19:28:07 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 4159B3F70E3;
	Tue, 28 Apr 2026 19:28:04 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Suman Ghosh <sumang@marvell.com>
Subject: [PATCH v5 net 10/10] octeontx2-af: npc: cn20k: Reject missing default-rule MCAM indices
Date: Wed, 29 Apr 2026 07:57:22 +0530
Message-ID: <20260429022722.1110289-11-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: 9-8IRFjDxmfysVjJFkz0gamjOneJrerQ
X-Proofpoint-GUID: 9-8IRFjDxmfysVjJFkz0gamjOneJrerQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyMSBTYWx0ZWRfX510Psjiw7xpy
 f9as7pXnIpokKgvDfhaZKnUEq311Cc9AsUnt+GZryaye9AzyQf5tACBigcjOk/ISesX6wkYqnLn
 /aXFdONzmxU7nyeLZvgwIe2VCnVSQAK8lPi0b64R5fzX1toNNWcieaIjeu/yRvwA+2Oj2DCven7
 tk1rFIVcxA0FVEmLwBl+o4bxRGUHjolXpm0zXjaKoKQVVlfVZuHYuQNh5E32+LEiX1FZFhPW7Qn
 E89i9cmzj1AywmnnO99o1AMEwcxskPfCMfQm/rQOq3fC2Grcha/2PTHtCKMSq5LjdHqJ95Nrvhs
 wUWN2Kfvnih/2ZbprGKtyLOjbzLT2xJUKgC2p4gUDhsOXY3PmKbVkEjYGruWzZZcwAMvBydOqHl
 KaDQJ9mXkxniWOxOV9pAY3AXiOs0HOb2s7ROEuEe/lqB+FvF4RBPXBD/BKk0OO+nwcD+cB65SQH
 XqlHnt28N9hKXysZ+1A==
X-Authority-Analysis: v=2.4 cv=X/Ni7mTe c=1 sm=1 tr=0 ts=69f16cb8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=PwRMgbMYhMs0H2_e3OEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: BD33F48E5A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282211-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

When cn20k default L2 rules are not installed,
npc_cn20k_dft_rules_idx_get() leaves broadcast, multicast, promiscuous, and
unicast slots at USHRT_MAX. npc_get_nixlf_mcam_index() previously returned
that sentinel as a valid MCAM index, so callers could program hardware with
an invalid index.

Return -EINVAL from the cn20k branches of npc_get_nixlf_mcam_index() when
the requested slot is still USHRT_MAX. Harden cn20k NPC MCAM entry helpers
to reject out-of-range indices before touching hardware.

Drop the early bounds check in npc_enable_mcam_entry() for cn20k so invalid
indices are validated inside npc_cn20k_enable_mcam_entry() instead of being
silently ignored.

In rvu_npc_update_flowkey_alg_idx(), treat negative MCAM indices like
out-of-range values, and only update RSS actions for promiscuous and
all-multi paths when the resolved index is non-negative.

Cc: Suman Ghosh <sumang@marvell.com>
Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c |  14 +-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   1 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   3 +
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 137 +++++++++++++++++-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  10 +-
 5 files changed, 155 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 1129565a01bd..6b3f453fd500 100644
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
 
@@ -1056,6 +1059,9 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	int kw = 0;
 	u8 kw_type;
 
+	if (index < 0 || index >= mcam->total_entries)
+		return -EINVAL;
+
 	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
 		return -EINVAL;
 
@@ -1148,6 +1154,9 @@ int npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
 	int bank, i, sb, db;
 	int dbank, sbank;
 
+	if (src >= mcam->total_entries || dest >= mcam->total_entries)
+		return -EINVAL;
+
 	dbank = npc_get_bank(mcam, dest);
 	sbank = npc_get_bank(mcam, src);
 
@@ -1213,6 +1222,9 @@ int npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 	int kw = 0, bank;
 	u8 kw_type;
 
+	if (index >= mcam->total_entries)
+		return -EINVAL;
+
 	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
 		return -EINVAL;
 
@@ -4170,7 +4182,7 @@ int rvu_mbox_handler_npc_get_dft_rl_idxs(struct rvu *rvu, struct msg_req *req,
 	return 0;
 }
 
-static bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
+bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
 {
 	return is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)) ||
 		is_lbk_vf(rvu, pcifunc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 2f761b97f91b..3d5eb952cc07 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -335,5 +335,6 @@ int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type);
 u16 npc_cn20k_vidx2idx(u16 index);
 u16 npc_cn20k_idx2vidx(u16 idx);
 int npc_cn20k_defrag(struct rvu *rvu);
+bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc);
 
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index ef5b081162eb..f977734ae712 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3577,6 +3577,9 @@ static int nix_update_mce_rule(struct rvu *rvu, u16 pcifunc,
 	mcam_index = npc_get_nixlf_mcam_index(mcam,
 					      pcifunc & ~RVU_PFVF_FUNC_MASK,
 					      nixlf, type);
+	if (mcam_index < 0)
+		return -EINVAL;
+
 	err = nix_update_mce_list(rvu, pcifunc, mce_list,
 				  mce_idx, mcam_index, add);
 	return err;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 5d349d131fdb..3c814d157ab9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -163,14 +163,35 @@ int npc_get_nixlf_mcam_index(struct npc_mcam *mcam,
 		if (rc)
 			return -EFAULT;
 
+		if (is_lbk_vf(rvu, pcifunc)) {
+			if (promisc == USHRT_MAX)
+				return -EINVAL;
+			return promisc;
+		}
+
+		if (is_cgx_vf(rvu, pcifunc)) {
+			if (ucast == USHRT_MAX)
+				return -EINVAL;
+
+			return ucast;
+		}
+
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
@@ -238,9 +259,6 @@ void npc_enable_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	int actbank = bank;
 
 	if (is_cn20k(rvu->pdev)) {
-		if (index < 0 || index >= mcam->banksize * mcam->banks)
-			return;
-
 		if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable))
 			dev_err(rvu->dev, "Error to %s mcam %u entry\n",
 				enable ? "enable" : "disable", index);
@@ -434,6 +452,15 @@ static u64 npc_get_default_entry_action(struct rvu *rvu, struct npc_mcam *mcam,
 
 	index = npc_get_nixlf_mcam_index(mcam, pf_func, nixlf,
 					 NIXLF_UCAST_ENTRY);
+
+	if (index < 0) {
+		dev_err(rvu->dev,
+			"%s: failed to get ucast entry pcifunc:0x%x\n",
+			__func__, pf_func);
+		/* Action 0 is drop */
+		return 0;
+	}
+
 	bank = npc_get_bank(mcam, index);
 	index &= (mcam->banksize - 1);
 
@@ -700,6 +727,12 @@ void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 
 	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
 					 nixlf, NIXLF_UCAST_ENTRY);
+	if (index < 0) {
+		dev_err(rvu->dev,
+			"%s: Error to get ucast entry for pcifunc=%#x\n",
+			__func__, pcifunc);
+		return;
+	}
 
 	/* Don't change the action if entry is already enabled
 	 * Otherwise RSS action may get overwritten.
@@ -755,11 +788,21 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
 					 nixlf, NIXLF_PROMISC_ENTRY);
 
+	/* In cn20k, default indexes are installed only for CGX mapped
+	 * and lbk interfaces
+	 */
 	if (is_cgx_vf(rvu, pcifunc))
 		index = npc_get_nixlf_mcam_index(mcam,
 						 pcifunc & ~RVU_PFVF_FUNC_MASK,
 						 nixlf, NIXLF_PROMISC_ENTRY);
 
+	if (index < 0) {
+		dev_err(rvu->dev,
+			"%s: Error to get promisc entry for pcifunc=%#x\n",
+			__func__, pcifunc);
+		return;
+	}
+
 	/* If the corresponding PF's ucast action is RSS,
 	 * use the same action for promisc also
 	 * Please note that for lbk(s) "index" and "ucast_idx"
@@ -770,6 +813,12 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 	else
 		ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
 						     nixlf, NIXLF_UCAST_ENTRY);
+	if (ucast_idx < 0) {
+		dev_err(rvu->dev,
+			"%s: Error to get ucast/promisc entry for pcifunc=%#x\n",
+			__func__, pcifunc);
+		return;
+	}
 
 	if (is_mcam_entry_enabled(rvu, mcam, blkaddr, ucast_idx))
 		*(u64 *)&action = npc_get_mcam_action(rvu, mcam,
@@ -844,6 +893,14 @@ void rvu_npc_enable_promisc_entry(struct rvu *rvu, u16 pcifunc,
 
 	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
 					 nixlf, NIXLF_PROMISC_ENTRY);
+
+	if (index < 0) {
+		dev_err(rvu->dev,
+			"%s: Error to get promisc entry for pcifunc=%#x\n",
+			__func__, pcifunc);
+		return;
+	}
+
 	npc_enable_mcam_entry(rvu, mcam, blkaddr, index, enable);
 }
 
@@ -884,6 +941,12 @@ void rvu_npc_install_bcast_match_entry(struct rvu *rvu, u16 pcifunc,
 
 	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
 					 nixlf, NIXLF_BCAST_ENTRY);
+	if (index < 0) {
+		dev_err(rvu->dev,
+			"%s: Error to get bcast entry for pcifunc=%#x\n",
+			__func__, pcifunc);
+		return;
+	}
 
 	if (!hw->cap.nix_rx_multicast) {
 		/* Early silicon doesn't support pkt replication,
@@ -948,12 +1011,25 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 
 	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
 					 nixlf, NIXLF_ALLMULTI_ENTRY);
+	if (index < 0) {
+		dev_err(rvu->dev,
+			"%s: Error to get mcast entry for pcifunc=%#x\n",
+			__func__, pcifunc);
+		return;
+	}
 
 	/* If the corresponding PF's ucast action is RSS,
 	 * use the same action for multicast entry also
 	 */
 	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
 					     nixlf, NIXLF_UCAST_ENTRY);
+	if (ucast_idx < 0) {
+		dev_err(rvu->dev,
+			"%s: Error to get ucast entry for pcifunc=%#x\n",
+			__func__, pcifunc);
+		return;
+	}
+
 	if (is_mcam_entry_enabled(rvu, mcam, blkaddr, ucast_idx))
 		*(u64 *)&action = npc_get_mcam_action(rvu, mcam,
 							blkaddr, ucast_idx);
@@ -1018,6 +1094,13 @@ void rvu_npc_enable_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 
 	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
 					 NIXLF_ALLMULTI_ENTRY);
+	if (index < 0) {
+		dev_err(rvu->dev,
+			"%s: Error to get mcast entry for pcifunc=%#x\n",
+			__func__, pcifunc);
+		return;
+	}
+
 	npc_enable_mcam_entry(rvu, mcam, blkaddr, index, enable);
 }
 
@@ -1130,8 +1213,12 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 		index = mcam_index;
 	}
 
-	if (index >= mcam->total_entries)
+	if (index < 0 || index >= mcam->total_entries) {
+		dev_err(rvu->dev,
+			"%s: Invalid mcam index, pcifunc=%#x\n",
+			__func__, pcifunc);
 		return;
+	}
 
 	bank = npc_get_bank(mcam, index);
 	index &= (mcam->banksize - 1);
@@ -1175,16 +1262,18 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
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
 
@@ -1197,12 +1286,22 @@ void npc_enadis_default_mce_entry(struct rvu *rvu, u16 pcifunc,
 	int index, blkaddr, mce_idx;
 	struct rvu_pfvf *pfvf;
 
+	/* multicast pkt replication is not enabled for AF's VFs & SDP links */
+	if (is_lbk_vf(rvu, pcifunc) || is_sdp_pfvf(rvu, pcifunc))
+		return;
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return;
 
 	index = npc_get_nixlf_mcam_index(mcam, pcifunc & ~RVU_PFVF_FUNC_MASK,
 					 nixlf, type);
+	if (index < 0) {
+		dev_err(rvu->dev,
+			"%s: Error to get entry for pcifunc=%#x, type=%u\n",
+			__func__, pcifunc, type);
+		return;
+	}
 
 	/* disable MCAM entry when packet replication is not supported by hw */
 	if (!hw->cap.nix_rx_multicast && !is_vf(pcifunc)) {
@@ -1231,6 +1330,10 @@ static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int index, blkaddr;
 
+	/* only CGX or LBK interfaces have default entries */
+	if (is_cn20k(rvu->pdev) && !npc_is_cgx_or_lbk(rvu, pcifunc))
+		return;
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return;
@@ -1240,6 +1343,12 @@ static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
 				     pfvf->nix_rx_intf)) {
 		index = npc_get_nixlf_mcam_index(mcam, pcifunc,
 						 nixlf, NIXLF_UCAST_ENTRY);
+		if (index < 0) {
+			dev_err(rvu->dev,
+				"%s: Error to get ucast entry for pcifunc=%#x\n",
+				__func__, pcifunc);
+			return;
+		}
 		npc_enable_mcam_entry(rvu, mcam, blkaddr, index, enable);
 	}
 
@@ -3897,6 +4006,12 @@ int rvu_mbox_handler_npc_read_base_steer_rule(struct rvu *rvu,
 	/* Read the default ucast entry if there is no pkt steering rule */
 	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
 					 NIXLF_UCAST_ENTRY);
+	if (index < 0) {
+		mutex_unlock(&mcam->lock);
+		rc = NIX_AF_ERR_AF_LF_INVALID;
+		goto out;
+	}
+
 read_entry:
 	/* Read the mcam entry */
 	npc_read_mcam_entry(rvu, mcam, blkaddr, index, &rsp->entry, &intf,
@@ -3970,6 +4085,12 @@ void rvu_npc_clear_ucast_entry(struct rvu *rvu, int pcifunc, int nixlf)
 
 	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
 					     nixlf, NIXLF_UCAST_ENTRY);
+	if (ucast_idx < 0) {
+		dev_err(rvu->dev,
+			"%s: Error to get ucast entry for pcifunc=%#x\n",
+			__func__, pcifunc);
+		return;
+	}
 
 	npc_enable_mcam_entry(rvu, mcam, blkaddr, ucast_idx, false);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index fe10554b1f0e..6ae9cdcb608b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1444,7 +1444,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	struct msg_rsp write_rsp;
 	struct mcam_entry *entry;
 	bool new = false;
-	u16 entry_index;
+	int entry_index;
 	int err;
 
 	installed_features = req->features;
@@ -1477,6 +1477,14 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	if (req->default_rule) {
 		entry_index = npc_get_nixlf_mcam_index(mcam, target, nixlf,
 						       NIXLF_UCAST_ENTRY);
+
+		if (entry_index < 0) {
+			dev_err(rvu->dev,
+				"%s: Error to get ucast entry for target=%#x\n",
+				__func__, target);
+			return -EINVAL;
+		}
+
 		enable = is_mcam_entry_enabled(rvu, mcam, blkaddr, entry_index);
 	}
 
-- 
2.43.0


