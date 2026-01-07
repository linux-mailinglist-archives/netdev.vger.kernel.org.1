Return-Path: <netdev+bounces-247578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0421CFBE1F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 04:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F25030FDB8F
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 03:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043A2701DC;
	Wed,  7 Jan 2026 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="g3wJ/h7M"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B726A1B5;
	Wed,  7 Jan 2026 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767757173; cv=none; b=pgv3mtb8QApomLeFfaGCqeCT130+vBMzWRFixyO5sTTqN8wVSU1NBujzqWswOX4tGPZGFzvexuahN0PfY8Qaksfj0+x3+adCjvMIXnN8NQG2y5LImvGk0niy1/7nq8SRJwPzI4uM0u5bDMy1ekG+u+T0sSpb18AaUaRvh52vOtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767757173; c=relaxed/simple;
	bh=RwPTgHF4sNmgEO/wY9Px7MrXUwtGqMGsM1H/BjPU7kU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXQYl7mVDN9yKB85O2dAASYhux+uQBgm7SVA28HFrZptfBa7alxZ+ipqToULZ9NS3JEIL3SLiwJPrGZDRSoxvuZgtc1qwCccM3dozGgbw2Bbx9ui0BjdvEUuh6q/bxw1IdMMTJQiNhaZ31VPv+jY9S/wuLPMTFRxp63WeF+lYsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=g3wJ/h7M; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606NqTAj3768643;
	Tue, 6 Jan 2026 19:39:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
	78pA0Tch+dNMQGqMQvC+cm6SSMxV6lrOq0WxP2G0bI=; b=g3wJ/h7MkQ86bUG2c
	rOq8QccsepExyB/vxIy64eBx5YNxeJplRvWqvDI5A03X52H1UuM0p/bD/pYVsHBV
	F7GHJ7sB4nXaeXp2ycwlv1GlMKYLsfAStuzZiD+VZ2lNgbvUgzr9GFnYrmmYGQjN
	l7pvo1IfQ1ebwlACscG1PZg2H7BZ3X59HBcJedSg/aEOw/p+kWMGkBU4CzZR7DRL
	L+1yGuz118g6bkdR1vPXInp9Yv432SkT7UAFBh0zPntxnd66EVZRVZHqKMcYkon6
	RdWxI85GyWtReOmT8vAL4hH9jHkd79kHvNAqshQ9scbxad2OisAjotsmI7tSoFFS
	OIOwQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bhces8bqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 19:39:21 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 6 Jan 2026 19:39:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 6 Jan 2026 19:39:34 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 1AE473F7050;
	Tue,  6 Jan 2026 19:39:17 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next v2 07/13] octeontx2-af: npc: cn20k: Prepare for new SoC
Date: Wed, 7 Jan 2026 09:08:38 +0530
Message-ID: <20260107033844.437026-8-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107033844.437026-1-rkannoth@marvell.com>
References: <20260107033844.437026-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FokIPmrq c=1 sm=1 tr=0 ts=695dd569 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=2uKIO9XhH62ytmgeegMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: e7KVuitKMp8hIh-aGLd3Mw7d1HsHMBxN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAyNyBTYWx0ZWRfXx5cGZKBYidAF
 V3Etuo0kW+XeIdUZxbvJvqApmW9Q00hBnlT8+QmSbzyyNRrXqqgZ3oUx3gVMYMs8xvcWoB6pPDm
 XHayRmCgFesk/oR7WZuVdN2mqeljrPJDuF6A603zOlJLpX3ZYJpuLsyJQz3FrCr/IntozD5udGy
 NbHw0dqGN8iXVjzVjLdKgeCXimUiX4RdXWD/fCOOhgSlUyp7VdVJkAOjt1Bd8/ciihj2nJ2dzmX
 HoN1VT/grVHrrlYasgLgoeiWKS5yVzHxFiZDJ16iifVKRu5kg0h1/2bfWNkILOSvisPlYj7wK6q
 DA5cGCyf6gRwX/eyZ3o7zWoVQs55bORIXEN7hBZ5aGGWqQ8+FHqsy7Nnvh0siAwEvesyH00MN+7
 e+vj74GiUgLoGxyEtDt94DtvAM5dVW6GgjHfo3dRDYeWlOh9yiKZnsBz5hjdjPur3+41QWbdVdy
 kBw6OvI4B+kA/f90p+g==
X-Proofpoint-ORIG-GUID: e7KVuitKMp8hIh-aGLd3Mw7d1HsHMBxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01

Current code pass mcam_entry structure to all low
level functions. This is not proper:

1) We need to modify all functions to support a new SoC
2) It does not look good to pass soc specific structure to
all common functions.

This patch adds a mcam meta data structure, which is populated
and passed to low level functions.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   8 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 140 +++++++++++-------
 .../marvell/octeontx2/af/rvu_npc_fs.h         |   2 +-
 .../marvell/octeontx2/af/rvu_npc_hash.c       |   6 +-
 .../marvell/octeontx2/af/rvu_npc_hash.h       |   2 +-
 5 files changed, 98 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 24df1b67bde3..7c58552435d2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1561,6 +1561,14 @@ struct npc_mcam_free_entry_req {
 	u8  all;   /* If all entries allocated to this PFVF to be freed */
 };
 
+struct mcam_entry_mdata {
+	u64 *kw;
+	u64 *kw_mask;
+	u64 *action;
+	u64 *vtag_action;
+	u8 max_kw;
+};
+
 struct mcam_entry {
 #define NPC_MAX_KWS_IN_KEY	8 /* Number of keywords in max keywidth */
 	u64	kw[NPC_MAX_KWS_IN_KEY];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index a0c294203eee..64b13e63b7a5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -899,11 +899,12 @@ static int npc_check_unsupported_flows(struct rvu *rvu, u64 features, u8 intf)
  * dont care.
  */
 void npc_update_entry(struct rvu *rvu, enum key_fields type,
-		      struct mcam_entry *entry, u64 val_lo,
+		      struct mcam_entry_mdata *mdata, u64 val_lo,
 		      u64 val_hi, u64 mask_lo, u64 mask_hi, u8 intf)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct mcam_entry dummy = { {0} };
+	u64 *kw, *kw_mask, *val, *mask;
 	struct npc_key_field *field;
 	u64 kw1, kw2, kw3;
 	int i, max_kw;
@@ -916,10 +917,9 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 	if (!field->nr_kws)
 		return;
 
-	if (is_cn20k(rvu->pdev))
-		max_kw = NPC_MAX_KWS_IN_KEY;
-	else
-		max_kw = NPC_MAX_KWS_IN_KEY - 1;
+	max_kw = NPC_MAX_KWS_IN_KEY;
+	kw = dummy.kw;
+	kw_mask = dummy.kw_mask;
 
 	for (i = 0; i < max_kw; i++) {
 		if (!field->kw_mask[i])
@@ -928,10 +928,10 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 		shift = __ffs64(field->kw_mask[i]);
 		/* update entry value */
 		kw1 = (val_lo << shift) & field->kw_mask[i];
-		dummy.kw[i] = kw1;
+		kw[i] = kw1;
 		/* update entry mask */
 		kw1 = (mask_lo << shift) & field->kw_mask[i];
-		dummy.kw_mask[i] = kw1;
+		kw_mask[i] = kw1;
 
 		if (field->nr_kws == 1)
 			break;
@@ -941,12 +941,12 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 			kw2 = shift ? val_lo >> (64 - shift) : 0;
 			kw2 |= (val_hi << shift);
 			kw2 &= field->kw_mask[i + 1];
-			dummy.kw[i + 1] = kw2;
+			kw[i + 1] = kw2;
 			/* update entry mask */
 			kw2 = shift ? mask_lo >> (64 - shift) : 0;
 			kw2 |= (mask_hi << shift);
 			kw2 &= field->kw_mask[i + 1];
-			dummy.kw_mask[i + 1] = kw2;
+			kw_mask[i + 1] = kw2;
 			break;
 		}
 		/* place remaining bits of key value in kw[x + 1], kw[x + 2] */
@@ -957,34 +957,39 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 			kw2 &= field->kw_mask[i + 1];
 			kw3 = shift ? val_hi >> (64 - shift) : 0;
 			kw3 &= field->kw_mask[i + 2];
-			dummy.kw[i + 1] = kw2;
-			dummy.kw[i + 2] = kw3;
+			kw[i + 1] = kw2;
+			kw[i + 2] = kw3;
 			/* update entry mask */
 			kw2 = shift ? mask_lo >> (64 - shift) : 0;
 			kw2 |= (mask_hi << shift);
 			kw2 &= field->kw_mask[i + 1];
 			kw3 = shift ? mask_hi >> (64 - shift) : 0;
 			kw3 &= field->kw_mask[i + 2];
-			dummy.kw_mask[i + 1] = kw2;
-			dummy.kw_mask[i + 2] = kw3;
+			kw_mask[i + 1] = kw2;
+			kw_mask[i + 2] = kw3;
 			break;
 		}
 	}
 	/* dummy is ready with values and masks for given key
 	 * field now clear and update input entry with those
 	 */
-	for (i = 0; i < max_kw; i++) {
+
+	val = mdata->kw;
+	mask = mdata->kw_mask;
+
+	for (i = 0; i < max_kw; i++, val++, mask++) {
 		if (!field->kw_mask[i])
 			continue;
-		entry->kw[i] &= ~field->kw_mask[i];
-		entry->kw_mask[i] &= ~field->kw_mask[i];
 
-		entry->kw[i] |= dummy.kw[i];
-		entry->kw_mask[i] |= dummy.kw_mask[i];
+		*val &= ~field->kw_mask[i];
+		*mask &= ~field->kw_mask[i];
+
+		*val |= kw[i];
+		*mask |= kw_mask[i];
 	}
 }
 
-static void npc_update_ipv6_flow(struct rvu *rvu, struct mcam_entry *entry,
+static void npc_update_ipv6_flow(struct rvu *rvu, struct mcam_entry_mdata *mdata,
 				 u64 features, struct flow_msg *pkt,
 				 struct flow_msg *mask,
 				 struct rvu_npc_mcam_rule *output, u8 intf)
@@ -1010,7 +1015,7 @@ static void npc_update_ipv6_flow(struct rvu *rvu, struct mcam_entry *entry,
 		val_hi = (u64)src_ip[0] << 32 | src_ip[1];
 		val_lo = (u64)src_ip[2] << 32 | src_ip[3];
 
-		npc_update_entry(rvu, NPC_SIP_IPV6, entry, val_lo, val_hi,
+		npc_update_entry(rvu, NPC_SIP_IPV6, mdata, val_lo, val_hi,
 				 mask_lo, mask_hi, intf);
 		memcpy(opkt->ip6src, pkt->ip6src, sizeof(opkt->ip6src));
 		memcpy(omask->ip6src, mask->ip6src, sizeof(omask->ip6src));
@@ -1024,14 +1029,14 @@ static void npc_update_ipv6_flow(struct rvu *rvu, struct mcam_entry *entry,
 		val_hi = (u64)dst_ip[0] << 32 | dst_ip[1];
 		val_lo = (u64)dst_ip[2] << 32 | dst_ip[3];
 
-		npc_update_entry(rvu, NPC_DIP_IPV6, entry, val_lo, val_hi,
+		npc_update_entry(rvu, NPC_DIP_IPV6, mdata, val_lo, val_hi,
 				 mask_lo, mask_hi, intf);
 		memcpy(opkt->ip6dst, pkt->ip6dst, sizeof(opkt->ip6dst));
 		memcpy(omask->ip6dst, mask->ip6dst, sizeof(omask->ip6dst));
 	}
 }
 
-static void npc_update_vlan_features(struct rvu *rvu, struct mcam_entry *entry,
+static void npc_update_vlan_features(struct rvu *rvu, struct mcam_entry_mdata *mdata,
 				     u64 features, u8 intf)
 {
 	bool ctag = !!(features & BIT_ULL(NPC_VLAN_ETYPE_CTAG));
@@ -1040,20 +1045,20 @@ static void npc_update_vlan_features(struct rvu *rvu, struct mcam_entry *entry,
 
 	/* If only VLAN id is given then always match outer VLAN id */
 	if (vid && !ctag && !stag) {
-		npc_update_entry(rvu, NPC_LB, entry,
+		npc_update_entry(rvu, NPC_LB, mdata,
 				 NPC_LT_LB_STAG_QINQ | NPC_LT_LB_CTAG, 0,
 				 NPC_LT_LB_STAG_QINQ & NPC_LT_LB_CTAG, 0, intf);
 		return;
 	}
 	if (ctag)
-		npc_update_entry(rvu, NPC_LB, entry, NPC_LT_LB_CTAG, 0,
+		npc_update_entry(rvu, NPC_LB, mdata, NPC_LT_LB_CTAG, 0,
 				 ~0ULL, 0, intf);
 	if (stag)
-		npc_update_entry(rvu, NPC_LB, entry, NPC_LT_LB_STAG_QINQ, 0,
+		npc_update_entry(rvu, NPC_LB, mdata, NPC_LT_LB_STAG_QINQ, 0,
 				 ~0ULL, 0, intf);
 }
 
-static void npc_update_flow(struct rvu *rvu, struct mcam_entry *entry,
+static void npc_update_flow(struct rvu *rvu, struct mcam_entry_mdata *mdata,
 			    u64 features, struct flow_msg *pkt,
 			    struct flow_msg *mask,
 			    struct rvu_npc_mcam_rule *output, u8 intf,
@@ -1071,39 +1076,39 @@ static void npc_update_flow(struct rvu *rvu, struct mcam_entry *entry,
 
 	/* For tcp/udp/sctp LTYPE should be present in entry */
 	if (features & BIT_ULL(NPC_IPPROTO_TCP))
-		npc_update_entry(rvu, NPC_LD, entry, NPC_LT_LD_TCP,
+		npc_update_entry(rvu, NPC_LD, mdata, NPC_LT_LD_TCP,
 				 0, ~0ULL, 0, intf);
 	if (features & BIT_ULL(NPC_IPPROTO_UDP))
-		npc_update_entry(rvu, NPC_LD, entry, NPC_LT_LD_UDP,
+		npc_update_entry(rvu, NPC_LD, mdata, NPC_LT_LD_UDP,
 				 0, ~0ULL, 0, intf);
 	if (features & BIT_ULL(NPC_IPPROTO_SCTP))
-		npc_update_entry(rvu, NPC_LD, entry, NPC_LT_LD_SCTP,
+		npc_update_entry(rvu, NPC_LD, mdata, NPC_LT_LD_SCTP,
 				 0, ~0ULL, 0, intf);
 	if (features & BIT_ULL(NPC_IPPROTO_ICMP))
-		npc_update_entry(rvu, NPC_LD, entry, NPC_LT_LD_ICMP,
+		npc_update_entry(rvu, NPC_LD, mdata, NPC_LT_LD_ICMP,
 				 0, ~0ULL, 0, intf);
 	if (features & BIT_ULL(NPC_IPPROTO_ICMP6))
-		npc_update_entry(rvu, NPC_LD, entry, NPC_LT_LD_ICMP6,
+		npc_update_entry(rvu, NPC_LD, mdata, NPC_LT_LD_ICMP6,
 				 0, ~0ULL, 0, intf);
 
 	/* For AH, LTYPE should be present in entry */
 	if (features & BIT_ULL(NPC_IPPROTO_AH))
-		npc_update_entry(rvu, NPC_LD, entry, NPC_LT_LD_AH,
+		npc_update_entry(rvu, NPC_LD, mdata, NPC_LT_LD_AH,
 				 0, ~0ULL, 0, intf);
 	/* For ESP, LTYPE should be present in entry */
 	if (features & BIT_ULL(NPC_IPPROTO_ESP))
-		npc_update_entry(rvu, NPC_LE, entry, NPC_LT_LE_ESP,
+		npc_update_entry(rvu, NPC_LE, mdata, NPC_LT_LE_ESP,
 				 0, ~0ULL, 0, intf);
 
 	if (features & BIT_ULL(NPC_LXMB)) {
 		output->lxmb = is_broadcast_ether_addr(pkt->dmac) ? 2 : 1;
-		npc_update_entry(rvu, NPC_LXMB, entry, output->lxmb, 0,
+		npc_update_entry(rvu, NPC_LXMB, mdata, output->lxmb, 0,
 				 output->lxmb, 0, intf);
 	}
 #define NPC_WRITE_FLOW(field, member, val_lo, val_hi, mask_lo, mask_hi)	      \
 do {									      \
 	if (features & BIT_ULL((field))) {				      \
-		npc_update_entry(rvu, (field), entry, (val_lo), (val_hi),     \
+		npc_update_entry(rvu, (field), mdata, (val_lo), (val_hi),     \
 				 (mask_lo), (mask_hi), intf);		      \
 		memcpy(&opkt->member, &pkt->member, sizeof(pkt->member));     \
 		memcpy(&omask->member, &mask->member, sizeof(mask->member));  \
@@ -1191,10 +1196,10 @@ do {									      \
 
 	NPC_WRITE_FLOW(NPC_IPFRAG_IPV6, next_header, pkt->next_header, 0,
 		       mask->next_header, 0);
-	npc_update_ipv6_flow(rvu, entry, features, pkt, mask, output, intf);
-	npc_update_vlan_features(rvu, entry, features, intf);
+	npc_update_ipv6_flow(rvu, mdata, features, pkt, mask, output, intf);
+	npc_update_vlan_features(rvu, mdata, features, intf);
 
-	npc_update_field_hash(rvu, intf, entry, blkaddr, features,
+	npc_update_field_hash(rvu, intf, mdata, blkaddr, features,
 			      pkt, mask, opkt, omask);
 }
 
@@ -1282,8 +1287,20 @@ static int npc_mcast_update_action_index(struct rvu *rvu, struct npc_install_flo
 	return 0;
 }
 
+static void
+npc_populate_mcam_mdata(struct rvu *rvu,
+			struct mcam_entry_mdata *mdata,
+			struct mcam_entry *entry)
+{
+	mdata->kw = entry->kw;
+	mdata->kw_mask = entry->kw_mask;
+	mdata->action = &entry->action;
+	mdata->vtag_action = &entry->vtag_action;
+	mdata->max_kw = NPC_MAX_KWS_IN_KEY;
+}
+
 static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
-			       struct mcam_entry *entry,
+			       struct mcam_entry_mdata *mdata,
 			       struct npc_install_flow_req *req,
 			       u16 target, bool pf_set_vfs_mac)
 {
@@ -1294,7 +1311,7 @@ static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	if (rswitch->mode == DEVLINK_ESWITCH_MODE_SWITCHDEV && pf_set_vfs_mac)
 		req->chan_mask = 0x0; /* Do not care channel */
 
-	npc_update_entry(rvu, NPC_CHAN, entry, req->channel, 0, req->chan_mask,
+	npc_update_entry(rvu, NPC_CHAN, mdata, req->channel, 0, req->chan_mask,
 			 0, NIX_INTF_RX);
 
 	*(u64 *)&action = 0x00;
@@ -1326,12 +1343,12 @@ static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 			action.match_id = req->match_id;
 	}
 
-	entry->action = *(u64 *)&action;
+	*mdata->action = *(u64 *)&action;
 
 	/* VTAG0 starts at 0th byte of LID_B.
 	 * VTAG1 starts at 4th byte of LID_B.
 	 */
-	entry->vtag_action = FIELD_PREP(RX_VTAG0_VALID_BIT, req->vtag0_valid) |
+	*mdata->vtag_action = FIELD_PREP(RX_VTAG0_VALID_BIT, req->vtag0_valid) |
 			     FIELD_PREP(RX_VTAG0_TYPE_MASK, req->vtag0_type) |
 			     FIELD_PREP(RX_VTAG0_LID_MASK, NPC_LID_LB) |
 			     FIELD_PREP(RX_VTAG0_RELPTR_MASK, 0) |
@@ -1344,7 +1361,7 @@ static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 }
 
 static int npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
-			       struct mcam_entry *entry,
+			       struct mcam_entry_mdata *mdata,
 			       struct npc_install_flow_req *req, u16 target)
 {
 	struct nix_tx_action action;
@@ -1357,7 +1374,7 @@ static int npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	if (is_pffunc_af(req->hdr.pcifunc))
 		mask = 0;
 
-	npc_update_entry(rvu, NPC_PF_FUNC, entry, (__force u16)htons(target),
+	npc_update_entry(rvu, NPC_PF_FUNC, mdata, (__force u16)htons(target),
 			 0, mask, 0, NIX_INTF_TX);
 
 	*(u64 *)&action = 0x00;
@@ -1370,12 +1387,12 @@ static int npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 
 	action.match_id = req->match_id;
 
-	entry->action = *(u64 *)&action;
+	*mdata->action = *(u64 *)&action;
 
 	/* VTAG0 starts at 0th byte of LID_B.
 	 * VTAG1 starts at 4th byte of LID_B.
 	 */
-	entry->vtag_action = FIELD_PREP(TX_VTAG0_DEF_MASK, req->vtag0_def) |
+	*mdata->vtag_action = FIELD_PREP(TX_VTAG0_DEF_MASK, req->vtag0_def) |
 			     FIELD_PREP(TX_VTAG0_OP_MASK, req->vtag0_op) |
 			     FIELD_PREP(TX_VTAG0_LID_MASK, NPC_LID_LA) |
 			     FIELD_PREP(TX_VTAG0_RELPTR_MASK, 20) |
@@ -1397,6 +1414,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	u64 features, installed_features, missing_features = 0;
 	struct npc_mcam_write_entry_req write_req = { 0 };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct mcam_entry_mdata mdata = { };
 	struct rvu_npc_mcam_rule dummy = { 0 };
 	struct rvu_npc_mcam_rule *rule;
 	u16 owner = req->hdr.pcifunc;
@@ -1411,15 +1429,18 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	entry = &write_req.entry_data;
 	entry_index = req->entry;
 
-	npc_update_flow(rvu, entry, features, &req->packet, &req->mask, &dummy,
+	npc_populate_mcam_mdata(rvu, &mdata,
+				&write_req.entry_data);
+
+	npc_update_flow(rvu, &mdata, features, &req->packet, &req->mask, &dummy,
 			req->intf, blkaddr);
 
 	if (is_npc_intf_rx(req->intf)) {
-		err = npc_update_rx_entry(rvu, pfvf, entry, req, target, pf_set_vfs_mac);
+		err = npc_update_rx_entry(rvu, pfvf, &mdata, req, target, pf_set_vfs_mac);
 		if (err)
 			return err;
 	} else {
-		err = npc_update_tx_entry(rvu, pfvf, entry, req, target);
+		err = npc_update_tx_entry(rvu, pfvf, &mdata, req, target);
 		if (err)
 			return err;
 	}
@@ -1439,7 +1460,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 		missing_features = (def_ucast_rule->features ^ features) &
 					def_ucast_rule->features;
 		if (missing_features)
-			npc_update_flow(rvu, entry, missing_features,
+			npc_update_flow(rvu, &mdata, missing_features,
 					&def_ucast_rule->packet,
 					&def_ucast_rule->mask,
 					&dummy, req->intf,
@@ -1755,12 +1776,17 @@ static int npc_update_dmac_value(struct rvu *rvu, int npcblkaddr,
 				 struct rvu_pfvf *pfvf)
 {
 	struct npc_mcam_write_entry_req write_req = { 0 };
-	struct mcam_entry *entry = &write_req.entry_data;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct mcam_entry_mdata mdata = { };
+	struct mcam_entry *entry;
 	u8 intf, enable, hw_prio;
 	struct msg_rsp rsp;
 	int err;
 
+	entry = &write_req.entry_data;
+
+	npc_populate_mcam_mdata(rvu, &mdata, entry);
+
 	ether_addr_copy(rule->packet.dmac, pfvf->mac_addr);
 
 	if (is_cn20k(rvu->pdev))
@@ -1771,7 +1797,7 @@ static int npc_update_dmac_value(struct rvu *rvu, int npcblkaddr,
 		npc_read_mcam_entry(rvu, mcam, npcblkaddr, rule->entry,
 				    entry, &intf, &enable);
 
-	npc_update_entry(rvu, NPC_DMAC, entry,
+	npc_update_entry(rvu, NPC_DMAC, &mdata,
 			 ether_addr_to_u64(pfvf->mac_addr), 0,
 			 0xffffffffffffull, 0, intf);
 
@@ -1872,6 +1898,7 @@ int npc_install_mcam_drop_rule(struct rvu *rvu, int mcam_idx, u16 *counter_idx,
 	struct npc_mcam_alloc_counter_rsp cntr_rsp = { 0 };
 	struct npc_mcam_write_entry_req req = { 0 };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct mcam_entry_mdata mdata = { };
 	struct rvu_npc_mcam_rule *rule;
 	struct msg_rsp rsp;
 	bool enabled;
@@ -1927,12 +1954,15 @@ int npc_install_mcam_drop_rule(struct rvu *rvu, int mcam_idx, u16 *counter_idx,
 	}
 	*counter_idx = cntr_rsp.cntr;
 
+	npc_populate_mcam_mdata(rvu, &mdata,
+				&req.entry_data);
+
 	/* Fill in fields for this mcam entry */
-	npc_update_entry(rvu, NPC_EXACT_RESULT, &req.entry_data, exact_val, 0,
+	npc_update_entry(rvu, NPC_EXACT_RESULT, &mdata, exact_val, 0,
 			 exact_mask, 0, NIX_INTF_RX);
-	npc_update_entry(rvu, NPC_CHAN, &req.entry_data, chan_val, 0,
+	npc_update_entry(rvu, NPC_CHAN, &mdata, chan_val, 0,
 			 chan_mask, 0, NIX_INTF_RX);
-	npc_update_entry(rvu, NPC_LXMB, &req.entry_data, bcast_mcast_val, 0,
+	npc_update_entry(rvu, NPC_LXMB, &mdata, bcast_mcast_val, 0,
 			 bcast_mcast_mask, 0, NIX_INTF_RX);
 
 	req.intf = NIX_INTF_RX;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
index 3f5c9042d10e..442287ee7baa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
@@ -15,7 +15,7 @@
 #define NPC_LDATA_EN	BIT_ULL(7)
 
 void npc_update_entry(struct rvu *rvu, enum key_fields type,
-		      struct mcam_entry *entry, u64 val_lo,
+		      struct mcam_entry_mdata *mdata, u64 val_lo,
 		      u64 val_hi, u64 mask_lo, u64 mask_hi, u8 intf);
 
 #endif /* RVU_NPC_FS_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 5ae046c93a82..0672bf0e6fe8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -282,7 +282,7 @@ void npc_program_mkex_hash(struct rvu *rvu, int blkaddr)
 }
 
 void npc_update_field_hash(struct rvu *rvu, u8 intf,
-			   struct mcam_entry *entry,
+			   struct mcam_entry_mdata *mdata,
 			   int blkaddr,
 			   u64 features,
 			   struct flow_msg *pkt,
@@ -335,7 +335,7 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 										 rsp,
 										 intf,
 										 hash_idx);
-						npc_update_entry(rvu, NPC_SIP_IPV6, entry,
+						npc_update_entry(rvu, NPC_SIP_IPV6, mdata,
 								 field_hash, 0,
 								 GENMASK(31, 0), 0, intf);
 						memcpy(&opkt->ip6src, &pkt->ip6src,
@@ -352,7 +352,7 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 										 rsp,
 										 intf,
 										 hash_idx);
-						npc_update_entry(rvu, NPC_DIP_IPV6, entry,
+						npc_update_entry(rvu, NPC_DIP_IPV6, mdata,
 								 field_hash, 0,
 								 GENMASK(31, 0), 0, intf);
 						memcpy(&opkt->ip6dst, &pkt->ip6dst,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
index cb25cf478f1f..4cbcae69b6d3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
@@ -53,7 +53,7 @@ struct npc_mcam_kex_hash {
 } __packed;
 
 void npc_update_field_hash(struct rvu *rvu, u8 intf,
-			   struct mcam_entry *entry,
+			   struct mcam_entry_mdata *mdata,
 			   int blkaddr,
 			   u64 features,
 			   struct flow_msg *pkt,
-- 
2.43.0


