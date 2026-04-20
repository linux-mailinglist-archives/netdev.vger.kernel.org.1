Return-Path: <netdev+bounces-279635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOqSJAeR5WlNlgEAu9opvQ
	(envelope-from <netdev+bounces-279635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:35:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E85EE426515
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27E6A301FA44
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97B37881F;
	Mon, 20 Apr 2026 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="f1MLquuA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3375637646A;
	Mon, 20 Apr 2026 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652528; cv=none; b=EzrUPox3Pxt30cweupQKxkaoWhCz/3FIk0rijihspjL67XtDJ+3nb6fMuvW3oWoKM65hUNio3aZpjmggcANXEbehH/am62H5MaTGlbm+1Ex1kH22h5ElYijwjvHj5iA+vMu9gG/JgL2W+KI3Q/251jIZ7WBlZyfc3pF8Dche9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652528; c=relaxed/simple;
	bh=pW2HzN4jUDd1SvgdLtt4bsZPsoB7pozh5KTsE4cWUlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lU8MEAkS0GbMadl3CzFLawD8fWVeyvPkEbcKzXL9jQm659hYB7YYu/96eIl2/EtwCoKiKKwi4pT9LY/NdN2G7Dp/QsZoDtxauceRt+FBum5Pj9ppriChchUuU+mR+IVOdTAQuDbs2DBsunXfcFB3vD/FyscpwieROy8JIvmAC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=f1MLquuA; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K2IBL62058384;
	Sun, 19 Apr 2026 19:35:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
	EwavZX32cPfEwF4eXygQxYwSYVGjeJIWQmV073ewF8=; b=f1MLquuAx9C+n+d2o
	VcRicV/G4G4jGEnUitxsSFYw4hfjTmnnuer2Jv+fA9Y3ncWttW5Ya1N9Mciw9Qr+
	A3bg7nsqZY4NYPVL0xADjQUh9jrIhCWUkROXJMmIqeZ7mURjVOx/I80b3c6ehoUb
	wM644zFcpAcaQSu6r/Nx9ZRe83MEqQta50NOWhpvm5wnEKeeA1aRtNSO9vOHNMmr
	gyHeLFiAse1CP07Bc4i1I5pJUvhqHI5lgY6xO0nDIn9ocYCPulv1Uatero+7PCBY
	q/adRQPoqv0juMWHhwq/hXa8rXgkywTucgUIobrVi78G/7+OfxHLDUp/F1kNaGtj
	iR9Ww==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dnb8180qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Apr 2026 19:35:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 19 Apr 2026 19:35:17 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 25EC83F7041;
	Sun, 19 Apr 2026 19:35:13 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net 04/11] octeontx2-af: npc: cn20k: Make default entries as x4.
Date: Mon, 20 Apr 2026 08:04:35 +0530
Message-ID: <20260420023442.3295891-5-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyMyBTYWx0ZWRfX+73s8z8ycKW4
 CJE0UPWNfcleeEGZqjgyUHB/8+PBvR18v3R2WvV8wlHF1cqV3nokSHcE4JmyihqzYokHCNVw/tN
 vrroF3d0rkg/7SzGG76psa2V0FdhKVTatE8Qw8qJZGPteLSOSpBUa3BtRBRV385N2SkSxfccne+
 /k658VqZyQd/IvAUrK3pIsks6BA6it4kTtVI5WWy+DQc7qJM+rUnWs43QDGGOhHLVCnQWDRNu8T
 XaKMtVFskuvJ/0hPHRYkyTXmrmX+p0yVnfKqhm8ODNFfUT1Fie27P26118o1nFcmAZAMps1ABCz
 B5tfNWG2gSXA2K7nh5DozfOpLyP2+niFOzY4HjwTypCzTZBQqqOFsgQ+eLBLDWdwLsJtotYcdJK
 xmFCawvk274wuwWMYvW1w/29At3YaCuv9QCPIHlfq2gu3rwbwpdq6lC5L+SG4sZCGV1/PbCL/i3
 Uek0hmm/rUd3wl2pNXQ==
X-Proofpoint-GUID: cn1dlEDK9aqv5afqxfaaN1WbPFqGKfQ5
X-Authority-Analysis: v=2.4 cv=W6wIkxWk c=1 sm=1 tr=0 ts=69e590e6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=F9p9qQeY_ntdmK6_khkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: cn1dlEDK9aqv5afqxfaaN1WbPFqGKfQ5
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279635-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.991];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E85EE426515
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

X4 profile users won't alloc x2 entries. Allocating x2 entries
would cause under utilized subbanks(X2). Avoid this in X4 kex
profile, all allocations will be from x4 subbank.

Fixes: 09d3b7a1403f ("octeontx2-af: npc: cn20k: Allocate default MCAM indexes")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 26 ++++++++--
 .../marvell/octeontx2/nic/otx2_flows.c        | 48 +++++++++++++------
 2 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 7f897ce0d17d..108998b6d832 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3592,9 +3592,10 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
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
@@ -3713,8 +3714,21 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
 		mcam->entry2pfvf_map[new_midx] = pcifunc;
 		/* Counter is not preserved */
 		mcam->entry2cntr_map[new_midx] = new_midx;
+
+		target_pf = mcam->entry2target_pffunc[old_midx];
+		mcam->entry2target_pffunc[new_midx] = target_pf;
+		mcam->entry2target_pffunc[old_midx] = 0;
+
 		npc_mcam_set_bit(mcam, new_midx);
 
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
@@ -4277,10 +4291,16 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
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


