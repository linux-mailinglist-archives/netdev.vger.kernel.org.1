Return-Path: <netdev+bounces-280712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMbJC4j56WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:50:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B663450E8A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A75DF303AF24
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C353E3170;
	Thu, 23 Apr 2026 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IqkC0GSK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D2B39283C;
	Thu, 23 Apr 2026 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941049; cv=none; b=iuV/P6HtmY6sNgfo7yzoRZbAIZvI2kRp/e1Iy9ulEhFafXkGGdfqF82UQFkYckd7A5Cl0OLtA7qGPk4m5Or8rlI5GolcOUUxXOarOlyYDX+/zgGDcyY9QtTaW8vM8TDLZYmR5y3VlMfbhBex2kDxpPNU0jlf2EW/xX1ueaW40uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941049; c=relaxed/simple;
	bh=WnBw1/hKz8Ke1YbGetzTemUJjPMbQ6uWskpKRYhgTLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNKyDGn8Da5oHiPy5ZdUKWTH4ZqHciyY0PItAdfebZYHQrpR/coKSJS9C+y9F8ZZCL+4QiBOIwflyi45gMoni+VYRvklFTfJnhmkIoUkTlBj1ou9L8IZSuKiOLvniG474nDqFiHpgrLwoV2xGoNXMKUuO5i94aSLq5nEB0JI5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IqkC0GSK; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6GaNT692965;
	Thu, 23 Apr 2026 03:44:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
	XQf2OdseDs+CtxPUjeXmI5Ssuf08FpY304VpG3VbfU=; b=IqkC0GSKxIP5wYOYl
	gN4sEPNqkZtZC6+4zVmoSxGh4hZ6cf0Ma4N5HLXWhsu4xySMkjG117IZES3IzRSE
	1AkRLZMIkH13bVb6hAAMt6AWy08fjbQ/agXdKxIHZNlM5zAbRkkT1fGJ0HC8iXg8
	PV8gyDQLvE6ZQZXb9tu3Cli5XEoPCXUgbzmwgaDmPZB1vw5dpdrywK8Qetre2vmS
	4EtgJ4Ka5nvlifaRqVDTO8+/0QTmaZ0LSM9X7wd1QD0XXaXn9MpoAFlrRu8zWiZy
	O4tpH0tjwmDPEB7wrfFow8PYW3ovYnqF1YTfFVsbIvRUjCHWZjaukPRD1VLgQ16f
	F5z0w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dq1n6jfh9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 03:44:00 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Apr 2026 03:43:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Apr 2026 03:43:46 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 100A23F7044;
	Thu, 23 Apr 2026 03:43:42 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Suman Ghosh <sumang@marvell.com>
Subject: [PATCH v3 net 06/11] octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width
Date: Thu, 23 Apr 2026 16:13:12 +0530
Message-ID: <20260423104317.2707923-7-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: SJD5zbWfNDuz611sbcGAa4aOvojARhvQ
X-Proofpoint-GUID: SJD5zbWfNDuz611sbcGAa4aOvojARhvQ
X-Authority-Analysis: v=2.4 cv=ecoNubEH c=1 sm=1 tr=0 ts=69e9f7f0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=Te6SKzNpAKJ10Xq2tLIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNSBTYWx0ZWRfX7EbLrwHQGU1f
 EGJV3GXK4NaQD5BUtal8SvA5RM9JR9JRROsUJOWT1ZEBRTbxDNTEW+7e1CNmXG8f8M0nsj82/SK
 3Vk0jwhgFmpTHEgYQ4XX+XejFGE1jwmKZVn2at0vL6pJ3jtBCZj2XxY2y8Zh6z/y4v+Yo5fljEb
 jiNdAHjt4GvCHeDAVRQF97AuAro2xH3eg/yC+XZL4F0043vURRaSkAKDFqSnBFGvul11jRmEKQ8
 ukYtpMxsW5Nx7Ib2yCAMLSQJXcdsImAx0PWmbxlYFXf6SjrJXG0Z1L3WNomxp49NKo6qChppoJP
 plSZGCmYNrzTvnmWKlaiyZPVNlsGpQ2g3mKhKlEDPCoj5Me6X8UlBKl/vpMvj7mMLkwUFoUEz5h
 LzO+Vj88xf5u7/P5wCvGi5MNE++mMqxOibCjctvzqFrJ/dzLrHiF44hUV5PilhQCJ1GEpGIR6DV
 zlBYu0khFfennYkr7iw==
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
	TAGGED_FROM(0.00)[bounces-280712-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9B663450E8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the old four-argument CN20K MCAM clear with a per-bank static
helper and npc_cn20k_clear_mcam_entry() that takes a logical MCAM index,
resolves the key width via npc_mcam_idx_2_key_type(), and clears either
one bank (X2) or every bank (X4).
Call it from npc_clear_mcam_entry() on cn20k and log when key-type lookup
fails. Use the per-bank helper from npc_cn20k_config_mcam_entry() for
pre-program clears.
For loopback VFs, use the promisc MCAM index as ucast_idx when copying
RSS action for promisc, matching cn20k default-rule layout.

Cc: Suman Ghosh <sumang@marvell.com>
Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 37 ++++++++++++++++---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  3 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 17 ++++++++-
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 74dad164b6a9..9ded0763ad54 100644
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


