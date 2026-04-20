Return-Path: <netdev+bounces-279645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OICQJUKS5WmvlgEAu9opvQ
	(envelope-from <netdev+bounces-279645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:41:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B1B4265F4
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E433086439
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8EE378D71;
	Mon, 20 Apr 2026 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VMZWxXWy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D993783DE;
	Mon, 20 Apr 2026 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652557; cv=none; b=mqteaVAeetgP0WbDuTmv6siPMhoy4o/3ln0nCDIJcKxXT81BwLz+kxJedZ2p21TlKGqN9YkmcM+X1nN2tfWgjRQ4oaXs9XfDLNp0DnVSQ2lDzvvATlshk8tcFcaMd8IFwT4zOx06vXc4OJ48BHM+2+ntIu6SxZqdJe1ooaWSTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652557; c=relaxed/simple;
	bh=Jde5f3SamFB5DgAGjLHtkm6wuwuM1wv6iL2d/a82u1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBX45gCZHsYmtkIoISjMoCsWEA0DD86MgFEUTmMCXYDZvEjUOROxma663ScCnghV5SRB47pAMnXvR+5WJJZBD2N++geo4zNj7FZ9fzUFUf/e21GmjpapGovnACKvrmsqa4k76QCPgG/EJ6sN0EmLDWeNABGS59N9hUGXsnQGoP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VMZWxXWy; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JMTxgw2167150;
	Sun, 19 Apr 2026 19:35:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
	BvPOi2+ZpDTv2CZnpcjWNZM0CpDPGcJHFwoy7T1fQc=; b=VMZWxXWyECpaCq+vK
	PW18SY4uny6pJ6Pv5To3NkDiK4dcl6tNgTvergkhf4GwAiKOQ4RG40LI4gzqu3z5
	Zq/1VWech6Z/J11tteY0mj6QkQ9cM+0SA/Hajq17UuPEEZEpgvlBIGiAEZtStcNM
	x+dipktnYdyKrAkqXMqQGbIClfopZP4Bwn2Vk1gZ8pmfuEsoFnhE6bQUOrNr3WyQ
	I7RST1FfKvMjeeZA4er52wzmEnzszqtbAhZhwittTQGlZZvYNpNLAeJyK3B8/5Yj
	0U3CyxFd0VF+Yq7dIOg/sXWKO/KbdSXfxOhv6qaOcy3JmP8yVLXhz075LBubl0gk
	RBxkQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dmx77h2ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Apr 2026 19:35:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:42 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 19 Apr 2026 19:35:41 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id AE8FB3F7041;
	Sun, 19 Apr 2026 19:35:36 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net 10/11] octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on free
Date: Mon, 20 Apr 2026 08:04:41 +0530
Message-ID: <20260420023442.3295891-11-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyMyBTYWx0ZWRfX15NAxoZe+hA7
 IiwoX3WojD1GszLkShfy7EFqbvOm8iR6yRn7v7AvK2Q1ToWs032kUcZI4GbvUOusHzRRbWnBO47
 i9678hFEWhLVezkDK/zsBI+vd+owfJw4nzOtZG6PLqhI3pg2AW68ERFWTZ4S8Am55AszrEEceFD
 6u/anIr42HM9QnIz7HiSW8wNv1o1e7gohw3cQEmnQvlVQ1JmhhbECBBV8EhMmzwU+qDbqTIqUVw
 AOEFTY7D6UpG4tJRLQA8c9Uy9isg5tZuWNY9DXq9q4BspsqOaevZTVIz//9IIinxQTjgAMEsigJ
 iSLqYbki3JSFXHwoh9mbtNRGwfoiGfq9rSq/20FWwn0oxSf41VkTjf5LfMpocY7TOEhHlj2DAZR
 98yNbdyVmAd9uBAHGWHlfuKnI9jFTDlVnaN1xgUGkSv0L38wuSLpNfxEFeIljv1SuqGlcQlGUqQ
 vDPzuwvVO7QtmvjCh4A==
X-Proofpoint-GUID: srTRoqa4YE0J14k2pEmwu43Yo3wSD8F8
X-Authority-Analysis: v=2.4 cv=P4IKQCAu c=1 sm=1 tr=0 ts=69e590fe cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=qvf5-K3L102eB4Sd9qIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: srTRoqa4YE0J14k2pEmwu43Yo3wSD8F8
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
	TAGGED_FROM(0.00)[bounces-279645-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 17B1B4265F4
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
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 51 ++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 59 +++++++++++++------
 2 files changed, 82 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 0714734c6af7..cb2fc21e0583 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -4163,11 +4163,11 @@ static bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
 
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
@@ -4225,14 +4225,43 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
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
+			return;
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
index 0a2191fda614..b2a9c8d0075b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2519,33 +2519,58 @@ void npc_mcam_clear_bit(struct npc_mcam *mcam, u16 index)
 static void npc_mcam_free_all_entries(struct rvu *rvu, struct npc_mcam *mcam,
 				      int blkaddr, u16 pcifunc)
 {
+	u16 dft_idxs[NPC_DFT_RULE_MAX_ID];
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


