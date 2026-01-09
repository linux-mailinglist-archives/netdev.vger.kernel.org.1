Return-Path: <netdev+bounces-248359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94745D07419
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 06:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6A7E3028E58
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 05:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7BC320A20;
	Fri,  9 Jan 2026 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HN671KRQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA1319843;
	Fri,  9 Jan 2026 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767937771; cv=none; b=LPF1CGox5l7YyeC/n+BJGRLncRO+ekaebeX8C0l/vSwQtM1mygKjxkEjAgGq2XvOAMkIhEM3kWQbDJcdlv605Xwd5BAl+TwG4fRybZPVv9Wf+E+yM03gg/Lb2o1LmCyDsY32lC88PcsuFgCKZ6/NHd+zfu7hbSLYJcwJJ3BxIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767937771; c=relaxed/simple;
	bh=R4tS0l6EDa/3VhuCwlMYjDWWtUR+a9pRJinD1j3lUoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erddLrEJebtZxXafGkpof00rrL5zUPJx2kco1MB59eDYJVr9/tY6R4a8gd8fvUWIKvtfo4xnqRMXXi1CjfOfvUBBV/O3rphPuCyk16m7CHH6yO+NfGsWHjkktWxaYGT2sFeN5ymw687O7K0gKhYJ7EaXeiBBowzbpCx2TWJygtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HN671KRQ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608NTbCa833409;
	Thu, 8 Jan 2026 21:49:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
	Xj31Q0XZ1HX8kzZO3IzdV9nfYLzm7JcZ1wc/OQwPKs=; b=HN671KRQEwOQRHjA0
	oyxDc84bK+9odv3N2UHJ56K55RYE38qDhSdoBJy8HMj/IhLByqDy7pBji9ZlUSbo
	J4+gAkUjK39GWfY6Y0xt7pqF7Iq1/HcDU5hh16kxmYjMTHor1WHVTHRliXVH7EDt
	yxwZkDRHfMVIll0lSDEs/l9hj5PDKg2iKvZKGSHwLooacHrND3cUf3gSsseKaWcv
	zi2GmOjLslOh4vMKoPDPO7hVh8kSz6oslDIzY+Pj/GyaB1BG/I5fMnI0XrkcjAXF
	2VyZRdtDElNAIYJK7riHAs7I3GTc3Z7wVM3El9lK6caSNQBvrGvAaf3adWi2DMva
	FuBXA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bjp9r8jy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 21:49:20 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 21:49:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 21:49:35 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id AE4E93F7060;
	Thu,  8 Jan 2026 21:49:17 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v3 13/13] octeontx2-af: npc: Use common structures
Date: Fri, 9 Jan 2026 11:18:28 +0530
Message-ID: <20260109054828.1822307-14-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109054828.1822307-1-rkannoth@marvell.com>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=e58LiKp/ c=1 sm=1 tr=0 ts=696096e1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=bNx57pydN-Y4TXDtlhsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: hnv2ZRFbQFXFfLd5dgKfL2_amZN0iySB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAzNyBTYWx0ZWRfXyHhS/S2gExqX
 muv0fObdjwchPZ4+ZGXRu3XqzDEXnqIKVfA18MOVYAZw9IpqCMdhtP3o//dGyGCG0ZDUjoXNJnz
 KrCQAQOgu+qDX2aECzivsi21eXeTn8Y+fMeYq0n9qjgZ7BFjvyQJHnf4CTzgSnRdSYILPBjstGQ
 VUymfE8q6ojAgIHH3jLBt8mYT9plrXMrV/j3DIf9ULzq8YrvWLLXTkhPsdWX+Ohkliih5C96G44
 K0NSjRpMK31ANx1BZ2BPIou/y4o6OVdKUMp3LqzgboSbdseWZSaEYNr0hFt12l3X339YLGQ58M8
 nY1BO72k4NZaeh9OG8ubE660krhlAMwB6kkA/vS23MtkWjAEISsCkxyhIjKQ7jC/A+PBarTLD93
 exw1Raav9io+fHlyAfYM6LKyWK6gPc1j4qYbhdOuW9y7ZzdbnvMZhJntYJrc9uKonYd41+TDgKo
 eQJh0HW3mIzZaXz1cPw==
X-Proofpoint-GUID: hnv2ZRFbQFXFfLd5dgKfL2_amZN0iySB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01

CN20K and legacy silicon differ in the size of key words used
in NPC MCAM. However, SoC-specific structures are not required
for low-level functions. Remove the SoC-specific structures
and rename the macros to improve readability.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 11 ++++---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 18 +++++++----
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 31 ++++++++-----------
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index ece561353f91..fecb666ed19a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3920,10 +3920,10 @@ int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
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
 
@@ -3940,7 +3940,8 @@ int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
 		return NPC_MCAM_INVALID_REQ;
 	}
 
-	npc_populate_mcam_mdata(rvu, &mdata, &cn20k_entry, &entry);
+	mdata.kw = kw;
+	mdata.kw_mask = kw_mask;
 
 	npc_update_flow(rvu, &mdata, fl->features, &fl->packet,
 			&fl->mask, &dummy, fl->intf, blkaddr);
@@ -3948,8 +3949,8 @@ int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
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
index 6f26f7393709..d65aaf4fae8b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1592,18 +1592,24 @@ struct mcam_entry_mdata {
 	u8 max_kw;
 };
 
+enum npc_kws_in_key_sz {
+	NPC_KWS_IN_KEY_SZ_7 = 7,
+	NPC_KWS_IN_KEY_SZ_8 = 8,
+	NPC_KWS_IN_KEY_SZ_9 = 9,
+	NPC_KWS_IN_KEY_SZ_10 = 10,
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
-#define NPC_CN20K_MAX_KWS_IN_KEY	8 /* Number of keywords in max keywidth */
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
index 5300b7faefbf..23231222b5fe 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -254,7 +254,7 @@ static bool npc_check_overlap(struct rvu *rvu, int blkaddr,
 				 * other field bits.
 				 */
 				if (npc_check_overlap_fields(dummy, input,
-							     NPC_MAX_KWS_IN_KEY))
+							     NPC_KWS_IN_KEY_SZ_7))
 					return true;
 			}
 		}
@@ -285,7 +285,7 @@ static bool npc_check_overlap(struct rvu *rvu, int blkaddr,
 					 start_kwi, offset, intf);
 			/* check any input field bits falls in any other field bits */
 			if (npc_check_overlap_fields(dummy, input,
-						     NPC_CN20K_MAX_KWS_IN_KEY))
+						     NPC_KWS_IN_KEY_SZ_8))
 				return true;
 		}
 	}
@@ -456,9 +456,9 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	u8 start_lid;
 
 	if (is_cn20k(rvu->pdev))
-		max_kw = NPC_CN20K_MAX_KWS_IN_KEY;
+		max_kw = NPC_KWS_IN_KEY_SZ_8;
 	else
-		max_kw = NPC_MAX_KWS_IN_KEY;
+		max_kw = NPC_KWS_IN_KEY_SZ_7;
 
 	key_fields = mcam->rx_key_fields;
 	features = &mcam->rx_features;
@@ -902,12 +902,12 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
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
 
@@ -918,15 +918,10 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
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
@@ -1309,14 +1304,14 @@ npc_populate_mcam_mdata(struct rvu *rvu,
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


