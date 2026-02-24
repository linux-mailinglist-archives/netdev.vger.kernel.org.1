Return-Path: <netdev+bounces-260393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL7/OsdbnWmxOgQAu9opvQ
	(envelope-from <netdev+bounces-260393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:05:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F90A183672
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 917F5303801E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36808364EB7;
	Tue, 24 Feb 2026 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I93g3CIM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71636654C;
	Tue, 24 Feb 2026 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920118; cv=none; b=FM44UUb9w/JQeMLtOQnoCIsGwfJlAXeu0NPK10pePTB2h98tAHbhSpUWkrw7UM3zAAEn1C3nApGoRUIMYHtE/TuRkO4OFkThsZAwYw0fiVxDWJdZ/LSI0F5nD3sMGHO2QGR/p01QdkNb6IxjR7knEbARf8elETabiH/KJmKv5Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920118; c=relaxed/simple;
	bh=wluxNOo+ltdqmH+6VI7aD0Ao1a5ck9I9dGPe7IFKx7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiZCsiOHNS6wjh396ZZ+EA7kFtOXorSBdoqlJp12/VWfAvrcL9S9yWgRpOVFcSQ/enId3X6OxGDUn4f8dZAUEx/x4iJ6zceqYY1A8d8nq23M++BSOkLh78Nz2lAhBxdG7AY191ZGifm9bm7Fq8wHGPJZ3RyqfgwlV//xLvcKCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I93g3CIM; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NGroLe1984298;
	Tue, 24 Feb 2026 00:01:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	oz52aAmx1+vamCfF03GQwKupXf9NWAQP0yEpgOuiFs=; b=I93g3CIMJf7CJzePs
	vsVbNo6G/SJyHkG6CrrNCUPfXM+iiedtnOUqflAXKqHa5y6b5irBzZbAPaB5CmIP
	Se+Bccp2CbZGolEfu7emvOlW/vryI/6WC5eTqRo869bVTOxVHUGz0B50xhvWIQXS
	+FPdVNlZBIn9pnweUpCyIuGdqADwybHF7TzW2aKRRDrV+zgVFRAfONOqxkB2sWrg
	iXc1DpdrPL3ca5wB9Ueh/S3NXYU1l7gLXrqa0a0NbhRkp+f4PphN79P8lZadJw/O
	/0UbnLgbbwHfKQ7ssyPnVeMYhSPa0PjCRPFeD5Uq+Zo0mzHhMpmba2BcCqdkFy2Y
	m8BEA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cfd3gwb1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 00:01:46 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Feb 2026 00:01:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Feb 2026 00:01:44 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 8276A3F7077;
	Tue, 24 Feb 2026 00:01:40 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v9 13/13] octeontx2-af: npc: Use common structures
Date: Tue, 24 Feb 2026 13:30:09 +0530
Message-ID: <20260224080009.4147301-14-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224080009.4147301-1-rkannoth@marvell.com>
References: <20260224080009.4147301-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1wV3G30rNM9Hfgyg9uzdMj8lsl__B1iq
X-Proofpoint-GUID: 1wV3G30rNM9Hfgyg9uzdMj8lsl__B1iq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA2OCBTYWx0ZWRfXwQ9GseA8dFfI
 sSWLyxfb9czRq2FWtNzf80zhD/m3EcxA7w+3efVKS/R/JXs01FaXoZaSO61NMtScmODDJwZBoXo
 gQS2bniVL6GJePewiKAzFNLB1omG2loTCGFDn87ZGiKW2AL2mqikMNQm8OAMZB92J2CBUNc+ggE
 WC3Wfmbnk2UDD1/jFH8Bc3qIvLwugyqCRm9zN5US3e0mEJ/xhYibvxoVE3Hv3LhrF3LC8sxtyha
 UPWKBXVet7s66sbSAltjMwq3mYpu+A/OhiKBqsg5oYG1chaHFInAal2JR1j756hfPi5sCGJxgbQ
 ZYB0tSYGib0+ubnuh4Fm0rTXYyoaa3w+zcpxkMTWvKxRIpzM3OuFw+A6hbTAnugRrX0E9k7DBLB
 vLh5BFGeA7CzReHupML4qkgkk8+YdIJIv+P8aLgRtdyreBcup/+a4/nCORV+j8uOU30tWyC9cko
 JIJp9fm9nPqm63KipEg==
X-Authority-Analysis: v=2.4 cv=H5XWAuYi c=1 sm=1 tr=0 ts=699d5aea cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=bNx57pydN-Y4TXDtlhsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260393-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim,marvell.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8F90A183672
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
index 63a287ee8f70..7291fdb89b03 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -4018,10 +4018,10 @@ int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
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
 
@@ -4038,7 +4038,8 @@ int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
 		return NPC_MCAM_INVALID_REQ;
 	}
 
-	npc_populate_mcam_mdata(rvu, &mdata, &cn20k_entry, &entry);
+	mdata.kw = kw;
+	mdata.kw_mask = kw_mask;
 
 	npc_update_flow(rvu, &mdata, fl->features, &fl->packet,
 			&fl->mask, &dummy, fl->intf, blkaddr);
@@ -4046,8 +4047,8 @@ int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
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
index 5cee425f86b1..cb1927d32b67 100644
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


