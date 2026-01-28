Return-Path: <netdev+bounces-254129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ah5N7W3eWlHygEAu9opvQ
	(envelope-from <netdev+bounces-254129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:16:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 574479DA37
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D6F83061624
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D8033ADB2;
	Wed, 28 Jan 2026 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EfO7jUj1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69B33ADA5;
	Wed, 28 Jan 2026 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769584411; cv=none; b=in58h1qe6SXU6h+vZT00gLssKHX3AyVf9kBGesGyFMRmdmsZo4EGk2WOlwSWrqQxiPMv1I9dbn0ewxQp9gG4bOGJsA6bJfbxKm1NGHwqZwQGX2koJb7K7t539rjM2PDPzhykyhSNd8obTA3+bXJYSaY5SsmC0AJv6OTazUJEBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769584411; c=relaxed/simple;
	bh=3LT9O6wvSVmIpabQ2MCVNj3f1KFa1TYp5hUOAzMpdHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmeMiVz4uBAxp/D1b0IETp0hU2t/swEqkcwkilcJTqzruGRumXYR+LICUs+Fmj9oLg+gjnhAaAic/XgiTPE0P49TNHQaGKcw91RtVr2CaW9DQIgvttz3hM8S8//D37Du11yPWBXdcSYr2LOC3FKf8oTxB/eyvwkYZdIO39yTo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EfO7jUj1; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S1Mwr73583353;
	Tue, 27 Jan 2026 23:13:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
	USwl5TGlAUA26MOKeK/t/Yr6G1JtNL4UV1Sm3avW74=; b=EfO7jUj1Pr41Rl8R/
	a7KBzdXxw91+rZeRcMw+zD2d0r173LRVHQMvAk1FGiVAZ495CQkKUv9ghsMLTPW+
	XmAstftq6HlD424ZKnxd7OK96TwfEHu2wLam7f+kdHCmvXVDmlbNATo1w49lMVC7
	9AF0+urr8ltROCszBx0fuhD2VtORF40M8YVVkYelan9bC7jq1uxk2wwOa9yArLCi
	/M7OFe3JfnWLdFC5UMT7jbIa44ZN22RHvJDmKwq8ChC4ecP78FShZpbp+Qpv7jc/
	T1NGpnfCR6UtpwAmgJqYoWj7Dfcbxye/m6TmGyEVqSMcMvMLAJtX44IwHgPYRTHi
	5Kqrw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4by8r68kc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 23:13:20 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 23:13:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 23:13:19 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 9F6533F7106;
	Tue, 27 Jan 2026 23:13:16 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v6 07/13] octeontx2-af: npc: cn20k: Prepare for new SoC
Date: Wed, 28 Jan 2026 12:42:29 +0530
Message-ID: <20260128071235.3577206-8-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128071235.3577206-1-rkannoth@marvell.com>
References: <20260128071235.3577206-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ka/fcAYD c=1 sm=1 tr=0 ts=6979b710 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=TxAswAKAtbBGRXV0VdsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA1NyBTYWx0ZWRfXxegzusQlF9xR
 NIc5YjVIorhMvRFHtbgPyCtuQL96oY8hq0INL2RG1Y3JWFLyql3dR8mC6wdmSlIxFtPJwJnL2qD
 APPc4LyTAhAD5mTgcctxVcfsiPGCD6f94dzGOSMP2DNEsNSiS3BWI1FBMNLAcIxuEevQvctkpN6
 EV6Mn2SsRjVgB+AotwiBy0EgB28/3G1RYF9iJV0vOIzgN9Viqvw5QLwoj0l8O5aLGq6pEp08Ykj
 uCeN87M5HD4lWSImb45VZUDwO224QDoZIpvgfTwxwurszSHNKEmywOXsAkUKPpHffAqJb/w0MMh
 WbnAETQhIsDWq+a30RnSV/Rh6VJzsHvpUQDUSbQ6pTAXAFqo+YjuBG4A5RhLkhCPqNGCyq+LvTm
 zGrSJArZ+FMF4aNg4219u20a3sf+dYyuaTDogSWP9F7h008idxsYIQagVpf4qSff2zC27EwNq1K
 ANMI5I+/Y2EcA34QMnA==
X-Proofpoint-GUID: yXmxAkMa41tMMymv5GqSPwyw5QWRap7G
X-Proofpoint-ORIG-GUID: yXmxAkMa41tMMymv5GqSPwyw5QWRap7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_01,2026-01-27_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254129-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 574479DA37
X-Rspamd-Action: no action

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
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 143 +++++++++++-------
 .../marvell/octeontx2/af/rvu_npc_fs.h         |   2 +-
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 113 +++++++-------
 .../marvell/octeontx2/af/rvu_npc_hash.h       |   2 +-
 5 files changed, 155 insertions(+), 113 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 8aa684bd83f0..a4e79828a84c 100644
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
index 508233876fc1..d73e447bedca 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -903,11 +903,12 @@ static int npc_check_unsupported_flows(struct rvu *rvu, u64 features, u8 intf)
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
@@ -920,10 +921,9 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
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
@@ -932,10 +932,10 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
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
@@ -945,12 +945,12 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
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
@@ -961,34 +961,40 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
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
+static void npc_update_ipv6_flow(struct rvu *rvu,
+				 struct mcam_entry_mdata *mdata,
 				 u64 features, struct flow_msg *pkt,
 				 struct flow_msg *mask,
 				 struct rvu_npc_mcam_rule *output, u8 intf)
@@ -1014,7 +1020,7 @@ static void npc_update_ipv6_flow(struct rvu *rvu, struct mcam_entry *entry,
 		val_hi = (u64)src_ip[0] << 32 | src_ip[1];
 		val_lo = (u64)src_ip[2] << 32 | src_ip[3];
 
-		npc_update_entry(rvu, NPC_SIP_IPV6, entry, val_lo, val_hi,
+		npc_update_entry(rvu, NPC_SIP_IPV6, mdata, val_lo, val_hi,
 				 mask_lo, mask_hi, intf);
 		memcpy(opkt->ip6src, pkt->ip6src, sizeof(opkt->ip6src));
 		memcpy(omask->ip6src, mask->ip6src, sizeof(omask->ip6src));
@@ -1028,14 +1034,15 @@ static void npc_update_ipv6_flow(struct rvu *rvu, struct mcam_entry *entry,
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
+static void npc_update_vlan_features(struct rvu *rvu,
+				     struct mcam_entry_mdata *mdata,
 				     u64 features, u8 intf)
 {
 	bool ctag = !!(features & BIT_ULL(NPC_VLAN_ETYPE_CTAG));
@@ -1044,20 +1051,20 @@ static void npc_update_vlan_features(struct rvu *rvu, struct mcam_entry *entry,
 
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
@@ -1075,39 +1082,39 @@ static void npc_update_flow(struct rvu *rvu, struct mcam_entry *entry,
 
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
@@ -1195,10 +1202,10 @@ do {									      \
 
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
 
@@ -1286,8 +1293,20 @@ static int npc_mcast_update_action_index(struct rvu *rvu, struct npc_install_flo
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
@@ -1298,7 +1317,7 @@ static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	if (rswitch->mode == DEVLINK_ESWITCH_MODE_SWITCHDEV && pf_set_vfs_mac)
 		req->chan_mask = 0x0; /* Do not care channel */
 
-	npc_update_entry(rvu, NPC_CHAN, entry, req->channel, 0, req->chan_mask,
+	npc_update_entry(rvu, NPC_CHAN, mdata, req->channel, 0, req->chan_mask,
 			 0, NIX_INTF_RX);
 
 	*(u64 *)&action = 0x00;
@@ -1330,12 +1349,12 @@ static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
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
@@ -1348,7 +1367,7 @@ static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 }
 
 static int npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
-			       struct mcam_entry *entry,
+			       struct mcam_entry_mdata *mdata,
 			       struct npc_install_flow_req *req, u16 target)
 {
 	struct nix_tx_action action;
@@ -1361,7 +1380,7 @@ static int npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	if (is_pffunc_af(req->hdr.pcifunc))
 		mask = 0;
 
-	npc_update_entry(rvu, NPC_PF_FUNC, entry, (__force u16)htons(target),
+	npc_update_entry(rvu, NPC_PF_FUNC, mdata, (__force u16)htons(target),
 			 0, mask, 0, NIX_INTF_TX);
 
 	*(u64 *)&action = 0x00;
@@ -1374,12 +1393,12 @@ static int npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 
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
@@ -1401,6 +1420,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	u64 features, installed_features, missing_features = 0;
 	struct npc_mcam_write_entry_req write_req = { 0 };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct mcam_entry_mdata mdata = { };
 	struct rvu_npc_mcam_rule dummy = { 0 };
 	struct rvu_npc_mcam_rule *rule;
 	u16 owner = req->hdr.pcifunc;
@@ -1415,15 +1435,19 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
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
+		err = npc_update_rx_entry(rvu, pfvf, &mdata, req, target,
+					  pf_set_vfs_mac);
 		if (err)
 			return err;
 	} else {
-		err = npc_update_tx_entry(rvu, pfvf, entry, req, target);
+		err = npc_update_tx_entry(rvu, pfvf, &mdata, req, target);
 		if (err)
 			return err;
 	}
@@ -1443,7 +1467,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 		missing_features = (def_ucast_rule->features ^ features) &
 					def_ucast_rule->features;
 		if (missing_features)
-			npc_update_flow(rvu, entry, missing_features,
+			npc_update_flow(rvu, &mdata, missing_features,
 					&def_ucast_rule->packet,
 					&def_ucast_rule->mask,
 					&dummy, req->intf,
@@ -1759,12 +1783,17 @@ static int npc_update_dmac_value(struct rvu *rvu, int npcblkaddr,
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
@@ -1775,7 +1804,7 @@ static int npc_update_dmac_value(struct rvu *rvu, int npcblkaddr,
 		npc_read_mcam_entry(rvu, mcam, npcblkaddr, rule->entry,
 				    entry, &intf, &enable);
 
-	npc_update_entry(rvu, NPC_DMAC, entry,
+	npc_update_entry(rvu, NPC_DMAC, &mdata,
 			 ether_addr_to_u64(pfvf->mac_addr), 0,
 			 0xffffffffffffull, 0, intf);
 
@@ -1876,6 +1905,7 @@ int npc_install_mcam_drop_rule(struct rvu *rvu, int mcam_idx, u16 *counter_idx,
 	struct npc_mcam_alloc_counter_rsp cntr_rsp = { 0 };
 	struct npc_mcam_write_entry_req req = { 0 };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct mcam_entry_mdata mdata = { };
 	struct rvu_npc_mcam_rule *rule;
 	struct msg_rsp rsp;
 	bool enabled;
@@ -1931,12 +1961,15 @@ int npc_install_mcam_drop_rule(struct rvu *rvu, int mcam_idx, u16 *counter_idx,
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
index 5ae046c93a82..4fba501f4c2b 100644
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
@@ -293,9 +293,10 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 	struct npc_mcam_kex_hash *mkex_hash = rvu->kpu.mkex_hash;
 	struct npc_get_field_hash_info_req req;
 	struct npc_get_field_hash_info_rsp rsp;
+	u8 hash_idx, lid, ltype, ltype_mask;
 	u64 ldata[2], cfg;
 	u32 field_hash;
-	u8 hash_idx;
+	bool en;
 
 	if (is_cn20k(rvu->pdev))
 		return;
@@ -310,60 +311,60 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 
 	for (hash_idx = 0; hash_idx < NPC_MAX_HASH; hash_idx++) {
 		cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_CFG(intf, hash_idx));
-		if ((cfg & BIT_ULL(11)) && (cfg & BIT_ULL(12))) {
-			u8 lid = (cfg & GENMASK_ULL(10, 8)) >> 8;
-			u8 ltype = (cfg & GENMASK_ULL(7, 4)) >> 4;
-			u8 ltype_mask = cfg & GENMASK_ULL(3, 0);
-
-			if (mkex_hash->lid_lt_ld_hash_en[intf][lid][ltype][hash_idx]) {
-				switch (ltype & ltype_mask) {
-				/* If hash extract enabled is supported for IPv6 then
-				 * 128 bit IPv6 source and destination addressed
-				 * is hashed to 32 bit value.
-				 */
-				case NPC_LT_LC_IP6:
-					/* ld[0] == hash_idx[0] == Source IPv6
-					 * ld[1] == hash_idx[1] == Destination IPv6
-					 */
-					if ((features & BIT_ULL(NPC_SIP_IPV6)) && !hash_idx) {
-						u32 src_ip[IPV6_WORDS];
-
-						be32_to_cpu_array(src_ip, pkt->ip6src, IPV6_WORDS);
-						ldata[1] = (u64)src_ip[0] << 32 | src_ip[1];
-						ldata[0] = (u64)src_ip[2] << 32 | src_ip[3];
-						field_hash = npc_field_hash_calc(ldata,
-										 rsp,
-										 intf,
-										 hash_idx);
-						npc_update_entry(rvu, NPC_SIP_IPV6, entry,
-								 field_hash, 0,
-								 GENMASK(31, 0), 0, intf);
-						memcpy(&opkt->ip6src, &pkt->ip6src,
-						       sizeof(pkt->ip6src));
-						memcpy(&omask->ip6src, &mask->ip6src,
-						       sizeof(mask->ip6src));
-					} else if ((features & BIT_ULL(NPC_DIP_IPV6)) && hash_idx) {
-						u32 dst_ip[IPV6_WORDS];
-
-						be32_to_cpu_array(dst_ip, pkt->ip6dst, IPV6_WORDS);
-						ldata[1] = (u64)dst_ip[0] << 32 | dst_ip[1];
-						ldata[0] = (u64)dst_ip[2] << 32 | dst_ip[3];
-						field_hash = npc_field_hash_calc(ldata,
-										 rsp,
-										 intf,
-										 hash_idx);
-						npc_update_entry(rvu, NPC_DIP_IPV6, entry,
-								 field_hash, 0,
-								 GENMASK(31, 0), 0, intf);
-						memcpy(&opkt->ip6dst, &pkt->ip6dst,
-						       sizeof(pkt->ip6dst));
-						memcpy(&omask->ip6dst, &mask->ip6dst,
-						       sizeof(mask->ip6dst));
-					}
-
-					break;
-				}
-			}
+		en = !!(cfg & BIT_ULL(11)) && (cfg & BIT_ULL(12));
+		if (!en)
+			continue;
+
+		lid = (cfg & GENMASK_ULL(10, 8)) >> 8;
+		ltype = (cfg & GENMASK_ULL(7, 4)) >> 4;
+		ltype_mask = cfg & GENMASK_ULL(3, 0);
+
+		if (!mkex_hash->lid_lt_ld_hash_en[intf][lid][ltype][hash_idx])
+			continue;
+
+		/* If hash extract enabled is supported for IPv6 then
+		 * 128 bit IPv6 source and destination addressed
+		 * is hashed to 32 bit value.
+		 */
+		if ((ltype & ltype_mask) != NPC_LT_LC_IP6)
+			continue;
+
+		/* ld[0] == hash_idx[0] == Source IPv6
+		 * ld[1] == hash_idx[1] == Destination IPv6
+		 */
+		if ((features & BIT_ULL(NPC_SIP_IPV6)) && !hash_idx) {
+			u32 src_ip[IPV6_WORDS];
+
+			be32_to_cpu_array(src_ip, pkt->ip6src, IPV6_WORDS);
+			ldata[1] = (u64)src_ip[0] << 32 | src_ip[1];
+			ldata[0] = (u64)src_ip[2] << 32 | src_ip[3];
+			field_hash = npc_field_hash_calc(ldata, rsp, intf,
+							 hash_idx);
+			npc_update_entry(rvu, NPC_SIP_IPV6, mdata, field_hash,
+					 0, GENMASK(31, 0), 0, intf);
+			memcpy(&opkt->ip6src, &pkt->ip6src,
+			       sizeof(pkt->ip6src));
+			memcpy(&omask->ip6src, &mask->ip6src,
+			       sizeof(mask->ip6src));
+			continue;
+		}
+
+		if ((features & BIT_ULL(NPC_DIP_IPV6)) && hash_idx) {
+			u32 dst_ip[IPV6_WORDS];
+
+			be32_to_cpu_array(dst_ip, pkt->ip6dst, IPV6_WORDS);
+			ldata[1] = (u64)dst_ip[0] << 32 | dst_ip[1];
+			ldata[0] = (u64)dst_ip[2] << 32 | dst_ip[3];
+			field_hash = npc_field_hash_calc(ldata, rsp, intf,
+							 hash_idx);
+			npc_update_entry(rvu, NPC_DIP_IPV6, mdata,
+					 field_hash, 0, GENMASK(31, 0),
+					 0, intf);
+			memcpy(&opkt->ip6dst, &pkt->ip6dst,
+			       sizeof(pkt->ip6dst));
+			memcpy(&omask->ip6dst, &mask->ip6dst,
+			       sizeof(mask->ip6dst));
+			continue;
 		}
 	}
 }
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


