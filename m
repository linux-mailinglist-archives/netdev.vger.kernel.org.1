Return-Path: <netdev+bounces-255771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEaXKvVYgGns6wIAu9opvQ
	(envelope-from <netdev+bounces-255771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:57:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032FC9699
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B67FE3034DF2
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16098322B77;
	Mon,  2 Feb 2026 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bO6Of88l"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75330C37C;
	Mon,  2 Feb 2026 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018431; cv=none; b=OB/HW4EZUj97qane5+W9xVSs1lCfg/3KnLypB/r48XH8rfuU82HSGktJVVdcGk+qDWV2IHfJ8KvyeRea9EFLW7eBTFKEZxG29V8JVHJ4wLPP7YMKyOKz0obJnx5AB007LdtxVzqPHurCRM77NMk+53ar/yXRYA1L/ceFmw92sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018431; c=relaxed/simple;
	bh=387M639IklX61YE7fdg8NJfnNKGD7nmL/PHCDI9px2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaSgEAoa6xqjsJ7KWqmGfc+qy4ItKNi0vNCL0BdcnhNuaygnv/tFJUgP5yVKa6rzqICngdpzQ7FQ38691oh2gtD3yhQc7c8LEZsV37pKhCEBjtG/dW7IDVhzn4n1yN2ag6/UN6Hw4RHZMNKbgvoVxIeukU0foBEoyAhqMTXSzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bO6Of88l; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6126upce904509;
	Sun, 1 Feb 2026 23:47:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
	D/1pLH2bBhS8I26inJbyhb+DEwehHlL9LxFVCuWNjc=; b=bO6Of88ln2rGqQBKF
	4CKDqUJO87tmQxRmNgLDO1b8tQeRUEmeOOPVG7l7PeThcYBGrO7gvbT/RCMV8dgO
	OaryqmL3Hu0UdvPDGomlEXVETzs27WbBuZX4Y/6144tsk3rLCDIHy3p8fR80KlGC
	luj+bbTlL0T/vte+RunReRq4dKwWOIf8+3ryIoi4ESmcOWJJ+0tU1xHo2nIwysJ7
	AF+hyslr9DNd1pXqYLVTl5Owa43d6SmTlhkIX/lCzsW+2AOM/esM8oIyTEj6xxkw
	D1+6MFhYmyF/3PJKn5f6mL+Y/giWG60ahHwsJQLOfHB7/YnihnBSEnUAgS+umoks
	i0/rw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c2q3q02qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Feb 2026 23:47:00 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 1 Feb 2026 23:47:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 1 Feb 2026 23:47:16 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id DA8255B6946;
	Sun,  1 Feb 2026 23:46:56 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v8 13/13] octeontx2-af: npc: Use common structures
Date: Mon, 2 Feb 2026 13:16:07 +0530
Message-ID: <20260202074607.2535569-14-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202074607.2535569-1-rkannoth@marvell.com>
References: <20260202074607.2535569-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZeoQ98VA c=1 sm=1 tr=0 ts=69805674 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=bNx57pydN-Y4TXDtlhsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: v3aYI7r7eqm1Z1dzlXtETMpAhYPs0Gty
X-Proofpoint-ORIG-GUID: v3aYI7r7eqm1Z1dzlXtETMpAhYPs0Gty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA2NiBTYWx0ZWRfX6HDTLEQ5Su5m
 8ZW+wEmR1rxfmN6tLcUMtwGzuxXA4NKdsvDDgNxKNnfzw79yGwPySI1eYYjwV8RD8HqRjP2TjDB
 fWW8aTLqrjMSUBNu1oQtU+yoGjBIoSj22Ua9B1r9ITgUFLxQhtEwgbbAQxjW5vujCkPAQ5kRXr3
 NW+sZvmq2iW0n91rkXGzsvHtQWGHcnVgIndK7mDjp1tXCQzn+s/xXLO1YwCUSpTTAsiYIRBqVMs
 c0sG26/sDr2QHhNzUtyVtQTfOlSGClsdRarg91okAD7P5IyIaxpaSQoUDKZLa2v2WzNAenxnond
 j2dGRa6dPIw7FXgunCyIAhYi2ildDNrJn5+vCcJnDQEvlGo2u6dk1vVOFlToxig5iNxS12oMrfO
 D2QOz1QQVzJj9biDjS72365qzcGwOHwvFTVD5N7NDv+iodg0gmGMY1MI+dpMIc24T0vpLLm6lOC
 cl4w3fsGXPzMDfHn9Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_02,2026-01-30_04,2025-10-01_01
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-255771-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mdata.kw:url,marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0032FC9699
X-Rspamd-Action: no action

CN20K and legacy silicon differ in the size of key words used
in NPC MCAM. However, SoC-specific structures are not required
for low-level functions. Remove the SoC-specific structures
and rename the macros to improve readability.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 11 ++++---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 16 ++++++----
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 31 ++++++++-----------
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 237e6f606fc1..b9354d35cc44 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3948,10 +3948,10 @@ int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
 				     struct npc_get_num_kws_req *req,
 				     struct npc_get_num_kws_rsp *rsp)
 {
+	u64 kw_mask[NPC_KWS_IN_KEY_SZ_MAX] = { 0 };
+	u64 kw[NPC_KWS_IN_KEY_SZ_MAX] = { 0 };
 	struct rvu_npc_mcam_rule dummy = { 0 };
-	struct cn20k_mcam_entry cn20k_entry = { 0 };
 	struct mcam_entry_mdata mdata = { };
-	struct mcam_entry entry = { 0 };
 	struct npc_install_flow_req *fl;
 	int i, cnt = 0, blkaddr;
 
@@ -3968,7 +3968,8 @@ int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
 		return NPC_MCAM_INVALID_REQ;
 	}
 
-	npc_populate_mcam_mdata(rvu, &mdata, &cn20k_entry, &entry);
+	mdata.kw = kw;
+	mdata.kw_mask = kw_mask;
 
 	npc_update_flow(rvu, &mdata, fl->features, &fl->packet,
 			&fl->mask, &dummy, fl->intf, blkaddr);
@@ -3976,8 +3977,8 @@ int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
 	/* Find the most significant word valid. Traverse from
 	 * MSB to LSB, check if cam0 or cam1 is set
 	 */
-	for (i = NPC_CN20K_MAX_KWS_IN_KEY - 1; i >= 0; i--) {
-		if (cn20k_entry.kw[i] || cn20k_entry.kw_mask[i]) {
+	for (i = NPC_KWS_IN_KEY_SZ_MAX - 1; i >= 0; i--) {
+		if (kw[i] || kw_mask[i]) {
 			cnt = i + 1;
 			break;
 		}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 2d9f6cb4820f..dc42c81c0942 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1593,18 +1593,22 @@ struct mcam_entry_mdata {
 	u8 max_kw;
 };
 
+enum npc_kws_in_key_sz {
+	NPC_KWS_IN_KEY_SZ_7 = 7,
+	NPC_KWS_IN_KEY_SZ_8 = 8,
+	NPC_KWS_IN_KEY_SZ_MAX,
+};
+
 struct mcam_entry {
-#define NPC_MAX_KWS_IN_KEY	7 /* Number of keywords in max keywidth */
-	u64	kw[NPC_MAX_KWS_IN_KEY];
-	u64	kw_mask[NPC_MAX_KWS_IN_KEY];
+	u64	kw[NPC_KWS_IN_KEY_SZ_7];
+	u64	kw_mask[NPC_KWS_IN_KEY_SZ_7];
 	u64	action;
 	u64	vtag_action;
 };
 
 struct cn20k_mcam_entry {
-#define NPC_CN20K_MAX_KWS_IN_KEY	8
-	u64	kw[NPC_CN20K_MAX_KWS_IN_KEY];
-	u64	kw_mask[NPC_CN20K_MAX_KWS_IN_KEY];
+	u64	kw[NPC_KWS_IN_KEY_SZ_8];
+	u64	kw_mask[NPC_KWS_IN_KEY_SZ_8];
 	u64	action;
 	u64	vtag_action;
 	u64	action2;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index f811d6b5c545..a466181cf908 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -197,7 +197,7 @@ struct npc_key_field {
 	/* Masks where all set bits indicate position
 	 * of a field in the key
 	 */
-	u64 kw_mask[NPC_CN20K_MAX_KWS_IN_KEY];
+	u64 kw_mask[NPC_KWS_IN_KEY_SZ_MAX];
 	/* Number of words in the key a field spans. If a field is
 	 * of 16 bytes and key offset is 4 then the field will use
 	 * 4 bytes in KW0, 8 bytes in KW1 and 4 bytes in KW2 and
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index b9572de1d175..ecaf196bdd2c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -227,7 +227,7 @@ static bool npc_check_overlap(struct rvu *rvu, int blkaddr,
 		input = &mcam->tx_key_fields[type];
 	}
 
-	kws = NPC_MAX_KWS_IN_KEY;
+	kws = NPC_KWS_IN_KEY_SZ_7;
 
 	if (is_cn20k(rvu->pdev))
 		goto skip_cn10k_config;
@@ -289,7 +289,7 @@ static bool npc_check_overlap(struct rvu *rvu, int blkaddr,
 			 * field bits
 			 */
 			if (npc_check_overlap_fields(dummy, input,
-						     NPC_CN20K_MAX_KWS_IN_KEY))
+						     NPC_KWS_IN_KEY_SZ_8))
 				return true;
 		}
 	}
@@ -460,9 +460,9 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	u8 start_lid;
 
 	if (is_cn20k(rvu->pdev))
-		max_kw = NPC_CN20K_MAX_KWS_IN_KEY;
+		max_kw = NPC_KWS_IN_KEY_SZ_8;
 	else
-		max_kw = NPC_MAX_KWS_IN_KEY;
+		max_kw = NPC_KWS_IN_KEY_SZ_7;
 
 	key_fields = mcam->rx_key_fields;
 	features = &mcam->rx_features;
@@ -906,12 +906,12 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 		      struct mcam_entry_mdata *mdata, u64 val_lo,
 		      u64 val_hi, u64 mask_lo, u64 mask_hi, u8 intf)
 {
-	struct cn20k_mcam_entry cn20k_dummy = { {0} };
+	u64 kw_mask[NPC_KWS_IN_KEY_SZ_MAX] = { 0 };
+	u64 kw[NPC_KWS_IN_KEY_SZ_MAX] = { 0 };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
-	struct mcam_entry dummy = { {0} };
-	u64 *kw, *kw_mask, *val, *mask;
 	struct npc_key_field *field;
 	u64 kw1, kw2, kw3;
+	u64 *val, *mask;
 	int i, max_kw;
 	u8 shift;
 
@@ -922,15 +922,10 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 	if (!field->nr_kws)
 		return;
 
-	if (is_cn20k(rvu->pdev)) {
-		max_kw = NPC_CN20K_MAX_KWS_IN_KEY;
-		kw = cn20k_dummy.kw;
-		kw_mask = cn20k_dummy.kw_mask;
-	} else {
-		max_kw = NPC_MAX_KWS_IN_KEY;
-		kw = dummy.kw;
-		kw_mask = dummy.kw_mask;
-	}
+	if (is_cn20k(rvu->pdev))
+		max_kw = NPC_KWS_IN_KEY_SZ_8;
+	else
+		max_kw = NPC_KWS_IN_KEY_SZ_7;
 
 	for (i = 0; i < max_kw; i++) {
 		if (!field->kw_mask[i])
@@ -1315,14 +1310,14 @@ npc_populate_mcam_mdata(struct rvu *rvu,
 		mdata->kw_mask = cn20k_entry->kw_mask;
 		mdata->action = &cn20k_entry->action;
 		mdata->vtag_action = &cn20k_entry->vtag_action;
-		mdata->max_kw = NPC_CN20K_MAX_KWS_IN_KEY;
+		mdata->max_kw = NPC_KWS_IN_KEY_SZ_8;
 		return;
 	}
 	mdata->kw = entry->kw;
 	mdata->kw_mask = entry->kw_mask;
 	mdata->action = &entry->action;
 	mdata->vtag_action = &entry->vtag_action;
-	mdata->max_kw = NPC_MAX_KWS_IN_KEY;
+	mdata->max_kw = NPC_KWS_IN_KEY_SZ_7;
 }
 
 static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
-- 
2.43.0


