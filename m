Return-Path: <netdev+bounces-280715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKuvMJz56WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:51:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4753450EAE
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A061C3044D0E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1D03E6DD4;
	Thu, 23 Apr 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aOKpx11M"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6373E1D18;
	Thu, 23 Apr 2026 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941051; cv=none; b=KodhJGkifNto+4t5hOg7AWccyldi/EumlRvuEv9Mzd76UCUEokyiYpdiGXf7yI8BTlik1pfsD9xnvF1A41LrBB35hWGGtTKHVBbCEiWO9oH06Qm/VhXgkp7kXLMiCbEj+BFCQX1O25xOz4GsZmlmh3pu2VXJwFfN90ZXOPC7xhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941051; c=relaxed/simple;
	bh=L5DNJvaQvL+XMV8KkXdMtFGBGVgoeflIvjlQJFQdi8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzhtejkyCi5PGmRsTVNt1xDM6nAyrGqoOsmAHmdRkyS8qeEA3K6SRdeFkvNXTcn/QsuT2iPX9uOwmxpt1RA7GGGf0D2nzJZwNupOh+NwYtJot2aC7okjHKhARMLmHyZpPONMEOO25kOaxSa7fPIL/qGq0bZ49of7H8wcMUEhdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aOKpx11M; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6GaNS692965;
	Thu, 23 Apr 2026 03:44:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
	j3UsNMPOx0YUuH5Tnr/krC2Dt89GWu2XKndXdLzBXU=; b=aOKpx11MN9fbmdYu7
	Rx/KBd19ZlfXNoY6w89ivIRKebG+A4AHm1zdG7XonS7LRa64nT+egfP9wGcGErzR
	h5OK6XmbCdFVTxVT3AdBI3bLaUM1ZGWgpoQbKjnHa52wbtWWgqto/H45JdMklLg1
	YDFJ/7aTHd678QXJF2rH23kwQtThYTuRYPLflBrGhz8pSBe7DDvQ0xRGCNH8IpLV
	AbjmwdutMbN2vdUYjfWhmnC7LMysFeETsyqTdRsIHx+q5vKNu2GSv+J26HhiGsVc
	NTl2dCqKsimyGPkpofTMNHlqcKnq73dJiNnvMkWgPzgj55PgKWgspzMHp1bN0rO5
	lBW7g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dq1n6jfh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 03:43:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Apr 2026 03:43:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Apr 2026 03:43:38 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E959D3F7044;
	Thu, 23 Apr 2026 03:43:35 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net 04/11] octeontx2-af: npc: cn20k: Make default entries as x4.
Date: Thu, 23 Apr 2026 16:13:10 +0530
Message-ID: <20260423104317.2707923-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423104317.2707923-1-rkannoth@marvell.com>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gkS_zmLhYx51TeUShsQEe_1-wk9tz8sf
X-Proofpoint-GUID: gkS_zmLhYx51TeUShsQEe_1-wk9tz8sf
X-Authority-Analysis: v=2.4 cv=ecoNubEH c=1 sm=1 tr=0 ts=69e9f7f0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=F9p9qQeY_ntdmK6_khkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNSBTYWx0ZWRfX0edbaF/lY1yK
 +I1z4sWOHx4OGBIXx3jCxQfPgsAnK48ukvkCXV38BaqY6t9aKmnnAnKmW20a+3bZmHqCQxNXBS+
 bvjtKDOAjdO4LbVZQ5LoqbZ4flrhawqbYHOvdY1YadkJUlg3znmuhwqj6kP2/sVIzTL6sxMthpi
 3fiHVc0p9s6EWkCM4V0w9475hmvuqv1oQx92eodvEVCbRwy0HIIUhrgLc4BU7vrT1V8+1UMEBLB
 cuQZrcsLrL6cri/OxvPE8DHcAPn1MF9YainU5z+Y0OMIw3ke4mGQeQXUIz5OQS3jyfp4bIeiVrS
 GQsB4yxbZcaXibL0HT4uVZYGqnQNueQTRoIca/PCm6r/2B9KiPajusJ5rI9VeJlfwitgc2TUL59
 kXCdcB9id2S6/C8yS4AYgU+x+ZF0RG4wi4ov6fTOG4ZHZJZ6R02zoqmvZiNZmYbnaqwS2MUyZh8
 zvq+seNIvC/iR7BUMGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280715-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,npc_priv.kw:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C4753450EAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

X4 profile users won't alloc x2 entries. Allocating x2 entries
would cause under utilized subbanks(X2). Avoid this in X4 kex
profile, all allocations will be from x4 subbank.

Fixes: 09d3b7a1403f ("octeontx2-af: npc: cn20k: Allocate default MCAM indexes")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 27 +++++++++--
 .../marvell/octeontx2/nic/otx2_flows.c        | 48 +++++++++++++------
 2 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 8630a6a73387..97acba77ff88 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3589,9 +3589,10 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
 				struct npc_defrag_node *v,
 				int cnt, u16 *save)
 {
+	u16 new_midx, old_midx, vidx, target_pf;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct rvu_npc_mcam_rule *rule, *tmp;
 	int i, vidx_cnt, rc, sb_off;
-	u16 new_midx, old_midx, vidx;
 	struct npc_subbank *sb;
 	bool deleted;
 	u16 pcifunc;
@@ -3710,8 +3711,22 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
 		mcam->entry2pfvf_map[new_midx] = pcifunc;
 		/* Counter is not preserved */
 		mcam->entry2cntr_map[new_midx] = new_midx;
+
+		target_pf = mcam->entry2target_pffunc[old_midx];
+		mcam->entry2target_pffunc[new_midx] = target_pf;
+		mcam->entry2target_pffunc[old_midx] = 0;
+
 		npc_mcam_set_bit(mcam, new_midx);
 
+		/* Note: list order is not functionally required for mcam_rules */
+		list_for_each_entry_safe(rule, tmp, &mcam->mcam_rules, list) {
+			if (rule->entry != old_midx)
+				continue;
+
+			rule->entry = new_midx;
+			break;
+		}
+
 		/* Mark as invalid */
 		v->vidx[vidx_cnt - i - 1] = -1;
 		save[cnt - i - 1] = -1;
@@ -4274,10 +4289,16 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	pfvf->hw_prio = NPC_DFT_RULE_PRIO;
 
+	if (npc_priv.kw == NPC_MCAM_KEY_X4) {
+		req.kw_type = NPC_MCAM_KEY_X4;
+		req.ref_entry = eidx & (npc_priv.bank_depth - 1);
+	} else {
+		req.kw_type = NPC_MCAM_KEY_X2;
+		req.ref_entry = eidx;
+	}
+
 	req.contig = false;
 	req.ref_prio = NPC_MCAM_HIGHER_PRIO;
-	req.ref_entry = eidx;
-	req.kw_type = NPC_MCAM_KEY_X2;
 	req.count = cnt;
 	req.hdr.pcifunc = pcifunc;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 38cc539d724d..5dd0591fed99 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -37,14 +37,13 @@ static void otx2_clear_ntuple_flow_info(struct otx2_nic *pfvf, struct otx2_flow_
 	flow_cfg->max_flows = 0;
 }
 
-static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
-				  u16 *x4_slots)
+static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, u16 *x4_slots, u8 *kw_type)
 {
 	struct npc_get_pfl_info_rsp *rsp;
 	struct msg_req *req;
 	static struct {
 		bool is_set;
-		bool is_x2;
+		u8 kw_type;
 		u16 x4_slots;
 	} pfl_info;
 
@@ -53,8 +52,8 @@ static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
 	 */
 	mutex_lock(&pfvf->mbox.lock);
 	if (pfl_info.is_set) {
-		*is_x2 = pfl_info.is_x2;
 		*x4_slots = pfl_info.x4_slots;
+		*kw_type = pfl_info.kw_type;
 		mutex_unlock(&pfvf->mbox.lock);
 		return 0;
 	}
@@ -79,16 +78,16 @@ static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
 		return -EFAULT;
 	}
 
-	*is_x2 = (rsp->kw_type == NPC_MCAM_KEY_X2);
-	if (*is_x2)
-		*x4_slots = 0;
+	pfl_info.kw_type = rsp->kw_type;
+	if (rsp->kw_type == NPC_MCAM_KEY_X2)
+		pfl_info.x4_slots = 0;
 	else
-		*x4_slots = rsp->x4_slots;
-
-	pfl_info.is_x2 = *is_x2;
-	pfl_info.x4_slots = *x4_slots;
+		pfl_info.x4_slots = rsp->x4_slots;
 	pfl_info.is_set = true;
 
+	*x4_slots = pfl_info.x4_slots;
+	*kw_type = pfl_info.kw_type;
+
 	mutex_unlock(&pfvf->mbox.lock);
 	return 0;
 }
@@ -164,6 +163,7 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 	u16 dft_idx = 0, x4_slots = 0;
 	int ent, allocated = 0, ref;
 	bool is_x2 = false;
+	u8 kw_type = 0;
 	int rc;
 
 	/* Free current ones and allocate new ones with requested count */
@@ -182,12 +182,14 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 	}
 
 	if (is_cn20k(pfvf->pdev)) {
-		rc = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
+		rc = otx2_mcam_pfl_info_get(pfvf, &x4_slots, &kw_type);
 		if (rc) {
 			netdev_err(pfvf->netdev, "Error to retrieve profile info\n");
 			return rc;
 		}
 
+		is_x2 = kw_type == NPC_MCAM_KEY_X2;
+
 		rc = otx2_get_dft_rl_idx(pfvf, &dft_idx);
 		if (rc) {
 			netdev_err(pfvf->netdev,
@@ -289,6 +291,8 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	struct npc_mcam_alloc_entry_rsp *rsp;
 	int vf_vlan_max_flows, count;
 	int rc, ref, prio, ent;
+	u8 kw_type = 0;
+	u16 x4_slots;
 	u16 dft_idx;
 
 	ref = 0;
@@ -315,6 +319,16 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	if (!flow_cfg->def_ent)
 		return -ENOMEM;
 
+	kw_type = NPC_MCAM_KEY_X2;
+	if (is_cn20k(pfvf->pdev)) {
+		rc = otx2_mcam_pfl_info_get(pfvf, &x4_slots, &kw_type);
+		if (rc) {
+			netdev_err(pfvf->netdev,
+				   "Error to get pfl info\n");
+			return rc;
+		}
+	}
+
 	mutex_lock(&pfvf->mbox.lock);
 
 	req = otx2_mbox_alloc_msg_npc_mcam_alloc_entry(&pfvf->mbox);
@@ -324,6 +338,10 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	}
 
 	req->kw_type = NPC_MCAM_KEY_X2;
+	if (is_cn20k(pfvf->pdev) && kw_type == NPC_MCAM_KEY_X4) {
+		req->kw_type = NPC_MCAM_KEY_X4;
+		ref &= (x4_slots - 1);
+	}
 	req->contig = false;
 	req->count = count;
 	req->ref_prio = prio;
@@ -1174,15 +1192,14 @@ static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
 #ifdef CONFIG_DCB
 	int vlan_prio, qidx, pfc_rule = 0;
 #endif
+	bool modify = false, is_x2;
 	int err, vf = 0, off, sz;
-	bool modify = false;
 	u8 kw_type = 0;
 	u8 *src, *dst;
 	u16 x4_slots;
-	bool is_x2;
 
 	if (is_cn20k(pfvf->pdev)) {
-		err = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
+		err = otx2_mcam_pfl_info_get(pfvf, &x4_slots, &kw_type);
 		if (err) {
 			netdev_err(pfvf->netdev,
 				   "Error to retrieve NPC profile info, pcifunc=%#x\n",
@@ -1190,6 +1207,7 @@ static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
 			return -EFAULT;
 		}
 
+		is_x2 = kw_type == NPC_MCAM_KEY_X2;
 		if (!is_x2) {
 			err = otx2_prepare_flow_request(&flow->flow_spec,
 							&treq);
-- 
2.43.0


