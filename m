Return-Path: <netdev+bounces-282206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKHrMuFs8WkIgwEAu9opvQ
	(envelope-from <netdev+bounces-282206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:28:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7211C48E4FC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8099C301AABD
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4EC38423A;
	Wed, 29 Apr 2026 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YypyJiuz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D3C382388;
	Wed, 29 Apr 2026 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429684; cv=none; b=SsTSEssMjPJBx5UqOdzra4P+TCQjuOgwy16IpXmMUR0ty339/vcNrYsc0e6EJrn7ElHk5rV0VJES8D/Al/bZd85Q6SSeZhNJaVIrOc9dqFh//R6GcIC8y3ZSjm3q9ItWKN1JCxcd7vtVVyPeeqKwMGPmgf6mc5PFZGEbJsEJol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429684; c=relaxed/simple;
	bh=PAXFBJTy2U7ieyq/09cnCWaz+vM1iXO14AHdZs7nHjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLC/duEFf2OO6quu7CufpYZBzTARuKqVQNrNtHORJQR8qqcZQEIGmOEhU2G2TnBV3TlkL7K09Oj9JFwsu3tJQXLymqS5NLTNHnSmWGu60sPt8sM47iUIo5g7kBrZKKwRXEGVDpOPHw2o1uRs8Mq4zL9OJEqlxsTUCHFkCtMHUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YypyJiuz; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SNd4bH652681;
	Tue, 28 Apr 2026 19:27:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	SRXkcmCALZLkwlLpv/l4/W4xzJW8rllkZ2b4nS4q9Y=; b=YypyJiuzL7M9ZrJBK
	A+w7BiqXmmQnXuurZp6926lW8EwT7uGmWEu5FLZt+5fYCYToUDfsP25bZec6jwut
	X23c+1w5KOv8YqI0T3kiB6G8alihS9wevJrqQaEQVctEe4V96RS3o86sww+/jgOk
	MWI09gPp0Ntzelzy7DGxVHlSf/dcuz7QCoEQaVHIpqoyo8G8boUmXf1Er3fLfr4k
	3FRH61U1dvFFfRnm87884+uMLlQROxXFajES9GH2kQiIwtdxodBRymQhPv8Mh4Q+
	ole9lvDpIYQ8rWN7xgSY0DozJoZXBWWRQ6wlHJX7fkAhVc1b7a4Adq/Mza4xe5Dp
	vRetA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4du6r5rbj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 19:27:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Apr 2026 19:27:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Apr 2026 19:27:54 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 48F9B3F70E2;
	Tue, 28 Apr 2026 19:27:51 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Suman Ghosh <sumang@marvell.com>
Subject: [PATCH v5 net 06/10] octeontx2-af: npc: cn20k: Fix bank value
Date: Wed, 29 Apr 2026 07:57:18 +0530
Message-ID: <20260429022722.1110289-7-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429022722.1110289-1-rkannoth@marvell.com>
References: <20260429022722.1110289-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyMSBTYWx0ZWRfX0jtDz2jYvQ2e
 NWceEBIaz3exubpeB1MqI+hr5I85bU189xSEoVcKkS2Z9szUSDJaYvbaWNFHDtJcERyGDXXcETC
 c7uUVHE0G0j4kVJGhmqFYVgnAA3lb+tYdW0jRYQh+hrKE+/0xSPZrr0mx2Y+2wjJe2dKPf3FJo/
 RSnY2uKriJIvYS9M99mhaOxKdK8HNKp8PME1vKW6RD/x/030yF80Q0wiT9Z6uEmHmI/RU/R6XEt
 NuwJaLiWgxrSaAftOc9gYXyMhx7BeBTO3592NuEWgsPjjuFmdw9emKLRrWrkNjMK4XljaGWlg9u
 XqPrMe2qj21MrErdkV/zzsdLbY+okrZeTWipeZTM4GCJb7DB0Zr3sxD/CconHdTukm17/85PUlS
 ggu2jsQ3RLTjbsIzgSye1POgF0uCO02hkAtwoNAjmQcvmsRa+Qq6u02zBlu2RjlKSBDkwsmwysT
 bl+qdvzVmqCezN5qoEg==
X-Proofpoint-GUID: qIro8ZmCATLRpy_e-WS54jhO1LAABMSH
X-Authority-Analysis: v=2.4 cv=GvJyPE1C c=1 sm=1 tr=0 ts=69f16cab cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=F5f33LUNeobebeIOQyAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: qIro8ZmCATLRpy_e-WS54jhO1LAABMSH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: 7211C48E4FC
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-282206-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

For X4 keys its loop reused the bank parameter as the loop counter, so bank
no longer reflected the caller's bank after the loop and the control flow
was hard to follow.

Program NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT directly in
npc_cn20k_config_mcam_entry(): one CFG write for X2 using the computed
bank, and one CFG write per bank inside the X4 action loop. Enable the
entry at the end with npc_cn20k_enable_mcam_entry(..., true) instead of
embedding the enable bit in bank_cfg via the removed helper.

Cc: Suman Ghosh <sumang@marvell.com>
Fixes: 4e527f1e5c15 ("octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 92 ++++++++-----------
 1 file changed, 37 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 112c37c190b1..4773277fd409 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -1045,34 +1045,6 @@ static void npc_cn20k_config_kw_x4(struct rvu *rvu, struct npc_mcam *mcam,
 				       kw, req_kw_type);
 }
 
-static void
-npc_cn20k_set_mcam_bank_cfg(struct rvu *rvu, int blkaddr, int mcam_idx,
-			    int bank, u8 kw_type, bool enable, u8 hw_prio)
-{
-	struct npc_mcam *mcam = &rvu->hw->mcam;
-	u64 bank_cfg;
-
-	bank_cfg = (u64)hw_prio << 24;
-	if (enable)
-		bank_cfg |= 0x1;
-
-	if (kw_type == NPC_MCAM_KEY_X2) {
-		rvu_write64(rvu, blkaddr,
-			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
-			    bank_cfg);
-		return;
-	}
-
-	/* For NPC_MCAM_KEY_X4 keys, both the banks
-	 * need to be programmed with the same value.
-	 */
-	for (bank = 0; bank < mcam->banks_per_entry; bank++) {
-		rvu_write64(rvu, blkaddr,
-			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
-			    bank_cfg);
-	}
-}
-
 int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 				u8 intf, struct cn20k_mcam_entry *entry,
 				bool enable, u8 hw_prio, u8 req_kw_type)
@@ -1080,6 +1052,7 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int mcam_idx = index % mcam->banksize;
 	int bank = index / mcam->banksize;
+	u64 bank_cfg = (u64)hw_prio << 24;
 	int kw = 0;
 	u8 kw_type;
 
@@ -1119,41 +1092,50 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
 								  bank, 1),
 			    entry->vtag_action);
-		goto set_cfg;
-	}
 
-	/* Clear mcam entry to avoid writes being suppressed by NPC */
-	npc_clear_x2_entry(rvu, blkaddr, 0, mcam_idx);
-	npc_clear_x2_entry(rvu, blkaddr, 1, mcam_idx);
-
-	npc_cn20k_config_kw_x4(rvu, mcam, blkaddr,
-			       mcam_idx, intf, entry,
-			       kw_type, req_kw_type);
-	for (bank = 0; bank < mcam->banks_per_entry; bank++) {
-		/* Set 'action' */
+		/* Set HW priority */
 		rvu_write64(rvu, blkaddr,
-			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
-								  bank, 0),
-			    entry->action);
+			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
+			    bank_cfg);
 
-		/* Set TAG 'action' */
-		rvu_write64(rvu, blkaddr,
-			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
-								  bank, 1),
-			    entry->vtag_action);
+	} else {
+		/* Clear mcam entry to avoid writes being suppressed by NPC */
+		npc_clear_x2_entry(rvu, blkaddr, 0, mcam_idx);
+		npc_clear_x2_entry(rvu, blkaddr, 1, mcam_idx);
 
-		/* Set 'action2' for inline receive */
-		rvu_write64(rvu, blkaddr,
-			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
-								  bank, 2),
-			    entry->action2);
+		npc_cn20k_config_kw_x4(rvu, mcam, blkaddr,
+				       mcam_idx, intf, entry,
+				       kw_type, req_kw_type);
+		for (bank = 0; bank < mcam->banks_per_entry; bank++) {
+			/* Set 'action' */
+			rvu_write64(rvu, blkaddr,
+				    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
+									  bank, 0),
+				    entry->action);
+
+			/* Set TAG 'action' */
+			rvu_write64(rvu, blkaddr,
+				    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
+									  bank, 1),
+				    entry->vtag_action);
+
+			/* Set 'action2' for inline receive */
+			rvu_write64(rvu, blkaddr,
+				    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
+									  bank, 2),
+				    entry->action2);
+
+			/* Set HW priority */
+			rvu_write64(rvu, blkaddr,
+				    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
+				    bank_cfg);
+		}
 	}
 
-set_cfg:
 	/* TODO: */
 	/* PF installing VF rule */
-	npc_cn20k_set_mcam_bank_cfg(rvu, blkaddr, mcam_idx, bank,
-				    kw_type, enable, hw_prio);
+	if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable))
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.43.0


