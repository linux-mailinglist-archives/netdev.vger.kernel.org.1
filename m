Return-Path: <netdev+bounces-280716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBSsDN356WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:52:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7236450EF0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4B2D304FF90
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A743E6DC1;
	Thu, 23 Apr 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AcggsXBr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC453E3D9F;
	Thu, 23 Apr 2026 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941051; cv=none; b=qumubMZ7x5PAJrkxZjtsHO/C4bFR/4uueKr6n4trlV6uPRjVNoXaZiIvUgzUOHBKJk13GRkpX4gj6K9/3Lqc0zeUZzPhR7e5ckV+ddu9s314YV67QzIKAcwmRngFQW0fByWdGMJgvx1lL0z5IjrRY8HW7NN30JPXbPIBjEDc2Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941051; c=relaxed/simple;
	bh=M1UwfssTOP5km/ySgomsbSJcaJBFiL1z190F8WI5ECI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZRTm5qXBe4o+qkdgjIvTLqBEsmhDJPdTjzM1yyGxWqxyICpjDvWgNKtyOOyF8Ly1gr/qdPcKSWUWLYr0xIgg2aWSY9hkzAC4dpdI0I1auviDnRUFwLZwBL43MPLNvxtne2WEtprEXPTBXNxwGbf8ZMOpHB5FV30xHymkFiBqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AcggsXBr; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6GaNW692965;
	Thu, 23 Apr 2026 03:44:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
	HxdGQ0QEK/0bXSAywlOV1M4B82uvPg106WZkX2w6tw=; b=AcggsXBrjRU6AGShS
	FikoE+kqZB/hp7AR2nf2aFSWMU8i7LoiXC/fFNWch+I52UwgH38ytEyZIgwRtdZJ
	GCBA3mYrZYSpSvnwXgiQ0+ry5XRp5jS2+J/Wuvng5iYoEFaSEbFwnYvP0mk+O3wX
	z2zXd76JKCqQ1XuW9AFBq8kW5fBRnIPbpSWJq/yPWLeE+GOtsgFNuGj1W5z1cJMj
	uRVfwp1VtJhVs4YIaowiUQw1mTzl5zzuAx3iiLhbBwPHH9xOs4xolT37sNRB/Jn8
	Utk2AXWlBhyDCSgVBeY+8EpNtJoPOHexFxAcYX7TG+kPGYb4RCsg8sKdNdtPMFd2
	HVijw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dq1n6jfh9-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 03:44:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Apr 2026 03:44:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Apr 2026 03:44:01 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 1DA823F7044;
	Thu, 23 Apr 2026 03:43:57 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net 10/11] octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on free
Date: Thu, 23 Apr 2026 16:13:16 +0530
Message-ID: <20260423104317.2707923-11-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: f_NqYl2w_RBwoo6ksbxRrHYAcuHipN0w
X-Proofpoint-GUID: f_NqYl2w_RBwoo6ksbxRrHYAcuHipN0w
X-Authority-Analysis: v=2.4 cv=ecoNubEH c=1 sm=1 tr=0 ts=69e9f7f1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=7ZpIx3dYB2NUAZqCXlQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNSBTYWx0ZWRfX7yr2xN954Ev9
 8dwY+sxfjsoKSi/VOugAcKVO8DtWmsN1rNWAcLxTYPE1ut6CXv5HzIvCUKuWR6hYuEEbL5G5AvY
 +rC4QVN9Z6f3U3kY5J+GxkgJVBQuX5pIwpLZWG9gISj/sdoC6kFRtl+OAEFZr2jZZLbgpGV9Dbx
 l3JVv6yIkkAf3ynojkY781W/L0tr0CxcLnXz2Evw6m4toUnyD8yVlPdNu7m8ogM2gLk2dUqz/9d
 k8Je/vw5TOKWscwTJFlTCtpnnitV8+XtREpvZYZ0oHq9xbQURTbPlqqRQ3r7fgVSeEbH9vh/bKK
 UTSC2P8F9TB7RUCfePaLdwf0u1DQIRCBa/NV+Zc7kM1VDmD4MA8YRTdcqURRvmyVssfiFbMkBEz
 QJkIiczISERFqYWKP7+UP3FlsI3gIdf3sZpSosICYs3qwPutUDmu1SHIpg/+oHp5JuuJxclbPpW
 uZWzWLGApCIxkPzEFsw==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280716-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A7236450EF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

npc_cn20k_dft_rules_free() used the NPC MCAM mbox "free all" path, which
does not match how cn20k tracks default-rule MCAM slots indexes.

Resolve the default-rule indices, then for each valid slot clear the
bitmap entry, drop the PF/VF map, disable the MCAM line, clear the
target function, and npc_cn20k_idx_free(). Remove any
matching software mcam_rules nodes. On hard failure from idx_free, WARN
and stop so the box stays up for analysis.

In npc_mcam_free_all_entries(), prefetch the same default-rule indices
and, on cn20k, skip bitmap clear and idx_free when the scanned entry is
one of those reserved defaults (they are released by
npc_cn20k_dft_rules_free). Still disable the entry and tear down counter
mapping for every matching index.

Fixes: 09d3b7a1403f ("octeontx2-af: npc: cn20k: Allocate default MCAM indexes")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 55 +++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 59 +++++++++++++------
 2 files changed, 86 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 6d3166960a3f..54a25d9c5505 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -4166,11 +4166,11 @@ static bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
 
 void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 {
-	struct npc_mcam_free_entry_req free_req = { 0 };
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u16 ptr[4] = {[0 ... 3] = USHRT_MAX};
+	struct rvu_npc_mcam_rule *rule, *tmp;
 	unsigned long index;
-	struct msg_rsp rsp;
-	u16 ptr[4];
-	int rc, i;
+	int blkaddr, rc, i;
 	void *map;
 
 	if (!npc_priv.init_done)
@@ -4228,14 +4228,47 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 	}
 
 free_rules:
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return;
+	for (int i = 0; i < 4; i++) {
+		if (ptr[i] == USHRT_MAX)
+			continue;
 
-	free_req.hdr.pcifunc = pcifunc;
-	free_req.all = 1;
-	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
-	if (rc)
-		dev_err(rvu->dev,
-			"%s: Error deleting default entries (pcifunc=%#x\n",
-			__func__, pcifunc);
+		mutex_lock(&mcam->lock);
+		npc_mcam_clear_bit(mcam, ptr[i]);
+		mcam->entry2pfvf_map[ptr[i]] = NPC_MCAM_INVALID_MAP;
+		npc_cn20k_enable_mcam_entry(rvu, blkaddr, ptr[i], false);
+		mcam->entry2target_pffunc[ptr[i]] = 0x0;
+		mutex_unlock(&mcam->lock);
+
+		rc = npc_cn20k_idx_free(rvu, &ptr[i], 1);
+		if (rc) {
+			/* Non recoverable error. Let us WARN and return. Keep system alive to
+			 * enable debugging
+			 */
+			WARN(1, "%s Error deleting default entries (pcifunc=%#x) mcam_idx=%u\n",
+			     __func__, pcifunc, ptr[i]);
+
+			/* Clear entries from mcam_rules, whose indexes are successfully freed
+			 * by npc_cn20k_idx_free().
+			 */
+			ptr[i] = USHRT_MAX;
+		}
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 44ca65efc80f..5d349d131fdb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2521,33 +2521,58 @@ void npc_mcam_clear_bit(struct npc_mcam *mcam, u16 index)
 static void npc_mcam_free_all_entries(struct rvu *rvu, struct npc_mcam *mcam,
 				      int blkaddr, u16 pcifunc)
 {
+	u16 dft_idxs[NPC_DFT_RULE_MAX_ID] = {[0 ... NPC_DFT_RULE_MAX_ID - 1] = USHRT_MAX};
+	bool cn20k_dft_rl;
 	u16 index, cntr;
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
+		if (mcam->entry2pfvf_map[index] != pcifunc)
+			continue;
+
+		cn20k_dft_rl = false;
+
+		if (is_cn20k(rvu->pdev)) {
+			if (dft_idxs[NPC_DFT_RULE_BCAST_ID] == index ||
+			    dft_idxs[NPC_DFT_RULE_MCAST_ID] == index ||
+			    dft_idxs[NPC_DFT_RULE_PROMISC_ID] == index ||
+			    dft_idxs[NPC_DFT_RULE_UCAST_ID] == index) {
+				cn20k_dft_rl = true;
+			}
+		}
+
+		/* Disable the entry */
+		npc_enable_mcam_entry(rvu, mcam, blkaddr, index, false);
+
+		if (!cn20k_dft_rl) {
 			mcam->entry2pfvf_map[index] = NPC_MCAM_INVALID_MAP;
 			/* Free the entry in bitmap */
 			npc_mcam_clear_bit(mcam, index);
-			/* Disable the entry */
-			npc_enable_mcam_entry(rvu, mcam, blkaddr, index, false);
-
-			/* Update entry2counter mapping */
-			cntr = mcam->entry2cntr_map[index];
-			if (cntr != NPC_MCAM_INVALID_MAP)
-				npc_unmap_mcam_entry_and_cntr(rvu, mcam,
-							      blkaddr, index,
-							      cntr);
 			mcam->entry2target_pffunc[index] = 0x0;
-			if (is_cn20k(rvu->pdev)) {
-				rc = npc_cn20k_idx_free(rvu, &index, 1);
-				if (rc)
-					dev_err(rvu->dev,
-						"Failed to free mcam idx=%u pcifunc=%#x\n",
-						index, pcifunc);
-			}
 		}
+
+		/* Update entry2counter mapping */
+		cntr = mcam->entry2cntr_map[index];
+		if (cntr != NPC_MCAM_INVALID_MAP)
+			npc_unmap_mcam_entry_and_cntr(rvu, mcam,
+						      blkaddr, index,
+						      cntr);
+
+		if (!is_cn20k(rvu->pdev) || cn20k_dft_rl)
+			continue;
+
+		rc = npc_cn20k_idx_free(rvu, &index, 1);
+		if (rc)
+			dev_err(rvu->dev,
+				"Failed to free mcam idx=%u pcifunc=%#x\n",
+				index, pcifunc);
 	}
 }
 
-- 
2.43.0


