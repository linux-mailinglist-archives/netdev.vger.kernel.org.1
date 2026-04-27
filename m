Return-Path: <netdev+bounces-281228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJcsHzkD72lz3QAAu9opvQ
	(envelope-from <netdev+bounces-281228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:33:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D0846D94F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1365630054E2
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1AF373BE6;
	Mon, 27 Apr 2026 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jBFaUnyP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA2371888;
	Mon, 27 Apr 2026 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271578; cv=none; b=IJmmScImIHjWGCSD5XBcT2omHNgbFxTD6Wj3sTrVI9d4UJD7V061vG7fWnsw42TGs4H5ayhSRVdbPluMr7hyBkzoeyhqdgK9yB+daOAbQJ3/+QZ2FGSoIhO1uqrpc/IY3A+CP2FhWCb4+We1eQNjwSXUtklkGWeHr6/Ln1Nrlg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271578; c=relaxed/simple;
	bh=RTYxh0cmK5IR0EnNVOHCNF8S0hCyHvcNZ/fnxZ8HMJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyczLPUti/JpPREt4+EGuXE5Oi1iM0ufAlQ3mPTs0/dEy38b9W0HqlmB6cgn2UgYtGqxdWNjekRr9CjoXSA+bVuRaVU7GCeLXLUow00QzPCyjCh669yWPWBfwMJhq/m62qRHKht0xot9am0qCvAdOnIF/tcbBTAwd+r5c6dDtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jBFaUnyP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QKjEp12802982;
	Sun, 26 Apr 2026 23:32:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
	tlG1kKEfpKGj430I7JuKiHmG6W4OTkuCM82S+sdt0s=; b=jBFaUnyPJgVSwd9gY
	NDxYh//krCHUqJTep5An96GpnBylc7uqLwKn+zG23D353ZaZTtTkZ+IXhs3flKuv
	+4nsw3nnvU3+rIvEi3wUJ49snFzvKkLKO63wJUyLm2jJQsMB1C6wGFJ0mY7VGQBW
	k0DCNBG4ZIw3mtC/7c3YltGsq0t7Psd7xwXjj4JhNigs935gobHDzplB5TZNzaPm
	Rfx+hckTT1rV2w8OgKBhu4xS1/XT8rQ2pL9ARVqW6E061ViigKi6AcW276okNn/o
	DiHVwKkOtJQ97/ISc7kRkFkrDYC4Yjly9cTk+KAyLe8HWSINAomMjjyWrKF5isDG
	O+rUw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dsec9sp7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 23:32:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 23:32:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 23:32:47 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A13B33F70BB;
	Sun, 26 Apr 2026 23:32:43 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Suman Ghosh <sumang@marvell.com>
Subject: [PATCH v4 net 07/10] octeontx2-af: npc: cn20k: Fix MCAM actions read
Date: Mon, 27 Apr 2026 12:02:10 +0530
Message-ID: <20260427063213.3937451-8-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2NyBTYWx0ZWRfX/bZAHHy+I0ub
 VAqsZfdq2UW/S8Olz3azTJ26s6J3Tkyb7UiJtRiYeRW2AUF0fUoz1q1O5u2pbANOCVLzAb+45ra
 ey0ECyx/zk1Cjd/PAQ00dPrhx1CnTnkQTLqAJ5zroQLd+7c/O2A+G/g7RWVgS8Xa7wGUy53i1Eo
 j7dtJWQK9kPwb2jcE2uT+4y7UybbdmPebnWZLNkFPJjGxxM63S/XDOky/pWlqhBa95Qe2JQyBzF
 dpH7Ym8HRdubr6/SpkG6RFvfrYckXHrHb48AYdjFAsZbp4xcMoBACQ53hcm2caYYXG9jc+6uSoX
 HW7aslEN+usG/+onzt+e62C5sxDWjYzXRRgSt6wWTRg1Hj4ZzzCx2na+0xWt/8ULK87kwIA278H
 8w+8GCX/Uor9DoHdDP2UKfufb+CMjDJfaRjqwSye/tGxaG/e4OzF6XoI4uN/KGSuclKVOzeH6fA
 7590I3c/0UJkkWOAa+A==
X-Proofpoint-ORIG-GUID: DrcJ5WTrihQqxuS7vLoi9CRFM-lsU1_O
X-Authority-Analysis: v=2.4 cv=Cf84Irrl c=1 sm=1 tr=0 ts=69ef030f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=IbDIvz35LZQodz_KiiMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: DrcJ5WTrihQqxuS7vLoi9CRFM-lsU1_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 37D0846D94F
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
	TAGGED_FROM(0.00)[bounces-281228-lists,netdev=lfdr.de];
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

npc_cn20k_read_mcam_entry() always reloaded action and vtag_action from
bank 0 after programming the CAM words. Use the bank returned by
npc_get_bank() for the ACTION reads as well, and read those registers
once up front so both X2 and X4 paths share the same metadata.

Return directly from the X2 keyword path now that the action fields are
already populated.

Cc: Suman Ghosh <sumang@marvell.com>
Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index ba43f71b92d1..369771c90256 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -1219,6 +1219,18 @@ int npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 	bank = npc_get_bank(mcam, index);
 	index &= (mcam->banksize - 1);
 
+	cfg = rvu_read64(rvu, blkaddr,
+			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, bank, 0));
+	entry->action = cfg;
+
+	cfg = rvu_read64(rvu, blkaddr,
+			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, bank, 1));
+	entry->vtag_action = cfg;
+
+	cfg = rvu_read64(rvu, blkaddr,
+			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, bank, 2));
+	entry->action2 = cfg;
+
 	cfg = rvu_read64(rvu, blkaddr,
 			 NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(index,
 								 bank, 1)) & 3;
@@ -1268,7 +1280,7 @@ int npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 									bank,
 									0));
 		npc_cn20k_fill_entryword(entry, kw + 3, cam0, cam1);
-		goto read_action;
+		return 0;
 	}
 
 	for (bank = 0; bank < mcam->banks_per_entry; bank++, kw = kw + 4) {
@@ -1313,18 +1325,6 @@ int npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 		npc_cn20k_fill_entryword(entry, kw + 3, cam0, cam1);
 	}
 
-read_action:
-	/* 'action' is set to same value for both bank '0' and '1'.
-	 * Hence, reading bank '0' should be enough.
-	 */
-	cfg = rvu_read64(rvu, blkaddr,
-			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, 0, 0));
-	entry->action = cfg;
-
-	cfg = rvu_read64(rvu, blkaddr,
-			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, 0, 1));
-	entry->vtag_action = cfg;
-
 	return 0;
 }
 
-- 
2.43.0


