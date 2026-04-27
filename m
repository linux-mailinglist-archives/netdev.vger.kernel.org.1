Return-Path: <netdev+bounces-281227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBwsNGEE72kj3wAAu9opvQ
	(envelope-from <netdev+bounces-281227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:38:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB6146DA7A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3836305F7E0
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEA637CD40;
	Mon, 27 Apr 2026 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iFvBvTsb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844E384256;
	Mon, 27 Apr 2026 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271568; cv=none; b=duRtjbASG3GgfOc+8EBCz/4MqghB/zKNjoUzruHPRCsT2o4sfYxRYwbzA0xzvVReSB8yy2sfitDnTa1K9kC8hmRwebsavsXdAwAKl0nA2G0JiLJxhHWiOI9Pb5pbqs9MgVtvGc/T7gYRehzSw7tOaTt/d6bZcsuLzi3ifShB1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271568; c=relaxed/simple;
	bh=x/83aG/E5wzqFUx4I2wXoaMsKi157deGsLdiRTosAqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbCoMZtOK6ylfGOYXCvA2dYxmT50wIM4I6EAHCR8ncoqupnkyZeVNOhtIoaKlANPsMipzej4UknzCRImRT6phjNlwC5SeOHpAxemIq6P5hz4vOUG2tq8dbxJuR6oW82hKa6ocDdZT3hVhqEoISZmtsJMkRqmfil1tte3kUEmocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iFvBvTsb; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QLglBK2492898;
	Sun, 26 Apr 2026 23:32:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
	XxQnUPlcnUofPin7AAXjdxbqPIOsVkHeRw89AYcoos=; b=iFvBvTsbMKBvRaI84
	FWonPU3cvKI6CX6W3wRRQZnUEJJQ2xtewHo+TV+gSqSMzqD0ok0LmdxijI43nDAj
	XgLaMvpbAIwrOj3XfPq5MYNnJXrElWeMMcrAhlVTYrNpeBrNsLCO4GdulOrjvhBt
	wEsxNMRm9wVmZstzpbuZvXDz24Fy/s+JJ4S+QjuYZEb+M6sm3CiAHJe9gzUjKAhP
	VSg+AmTcHQ651y/Y+UASSoaCpUD/zKUBoJOuv08Hwd5nukKSNGX2KrRde0LV3XGv
	ZLUol1Bsx9yNeh9Z/jHST1cucrYA0kMkai+nrAo3mbnVxnUZ829bSbYWBflyrF/R
	Jr7xw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4drw4fjxre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 23:32:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 23:32:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 23:32:39 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A57213F70BB;
	Sun, 26 Apr 2026 23:32:35 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Suman Ghosh <sumang@marvell.com>
Subject: [PATCH v4 net 05/10] octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width
Date: Mon, 27 Apr 2026 12:02:08 +0530
Message-ID: <20260427063213.3937451-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427063213.3937451-1-rkannoth@marvell.com>
References: <20260427063213.3937451-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eXff_6iaKoKtRcGJq3EH6m2p9vIPlxqb
X-Proofpoint-GUID: eXff_6iaKoKtRcGJq3EH6m2p9vIPlxqb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2NyBTYWx0ZWRfX3jyGuUNZUYDK
 xrrKfagOWoHffMlbU2Wu/jmK+dRtIBgBLttbn+q/KOW0QOvF+VR6JuBC1cADlh3zg6SeTO0X7XR
 SkVsgasc01b4F713765edrL0Gi/snpZjTW2vbJ8kE12pHGPu/DBhbwKF3f6UbokxMJ6vXZKMXjn
 pVrxZCOrxoVaryXBHA3mqwUaYIVuhGVpGXXoWSIe04iXrK3LCMCQSWJqhMVpr7UP1c01GcMvDRy
 /Yo5B9OvpblXILk4xh21hscT7cJL4bK7joYIz30xl7u3hf37KW+tTGUA4+3nG9aleADc+1KGs0J
 Ry7ElSp47M5tHaNpbpCKpu+UIfJ92yy5e9T6XlF/8lSSdj1duoWGRXvteytCf+0Ku3GJJcs2cs0
 nc/Yw9OUnDfdbvhA0q7RXYIH5kLZWPGaREOgkwrgBPifBhrDVSsAOHzsCfCVsjMYH4d4LheqKdX
 8NKhN2Kt/UpzUEPT/Zw==
X-Authority-Analysis: v=2.4 cv=X/Ni7mTe c=1 sm=1 tr=0 ts=69ef0307 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=Te6SKzNpAKJ10Xq2tLIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 2AB6146DA7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-281227-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

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
index 020496c82806..28ea9c508846 100644
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


