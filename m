Return-Path: <netdev+bounces-282207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDSxA2xt8WkIgwEAu9opvQ
	(envelope-from <netdev+bounces-282207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:31:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6F048E557
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 130263087BD4
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134913806CC;
	Wed, 29 Apr 2026 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GxEyldtY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A00385521;
	Wed, 29 Apr 2026 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429688; cv=none; b=AV3Ks9HiK4xxeeeWRYtPnmQ19lA8DBzDnBv4IlNKnkvBAxkszDmRtHz8gju02+TeF6YdpYFBctZ+DusD6YXupU9zh8T/iIohgvlcVhMzTz+Z1MBEsHyV69z1YRmrEno6dcgEsUJOlLSf8flmlNo8fXOTQCEWu5LCJXaH/F08u80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429688; c=relaxed/simple;
	bh=Xv+1Z9IqqUokdWsmp+znw9haH3kFn1piusYMhuqjYe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bg7d7h5+PJ/bCPVeS3A3PkOwmJHCSFQ8dJJEzrFd+NumkXXQxRELSSbshZsSN4tFol8CeXUnea+ftZwxxnXDLd8uBXOfrFMnYGD7tk18q/fh1E+NHEJ9DKd1KQCHA1kz/tQ9eDXONw9ZXP3syuN0uDUY9IoIkEIGc8y2yOmllJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GxEyldtY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SKo2ss2973483;
	Tue, 28 Apr 2026 19:27:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
	r5EviHEnSgQnNHrST2aKwPKrvgDPhk+Y10r3ABf2jk=; b=GxEyldtYT6QBSB5ek
	uL15cJwSlTEum5pyajc9c2UlRV4NBnIxc6u1ruTEpdMPRJBlj8JqE/Cv+3seSB5i
	vOA15uN11qwQydGO3MDb+3KskwYfIr7QcFQMvuNvaYOtKVg9U1wzmPpo0b1l9TZM
	7E/PKOs0x+xs9eHffB+t52OyhuVGLjO0vZmqsVzC7hfZ5Zp3fasTKI69/EKXWJAz
	ypkfzjKD+p0BYYbLGgQwk7Ph/sRwhqaxCJtLI7e3fW3Edw0TkiBmIUS0oBJmWDxg
	Fr3tofb9qOr8dqVhLblDRNcj0wNlQ0SFn821PG7EakpmCDN9sN/BdPUPZe0txo4X
	0mJzA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dth1mby0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 19:27:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Apr 2026 19:27:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Apr 2026 19:27:57 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A5B483F70E2;
	Tue, 28 Apr 2026 19:27:54 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Suman Ghosh <sumang@marvell.com>
Subject: [PATCH v5 net 07/10] octeontx2-af: npc: cn20k: Fix MCAM actions read
Date: Wed, 29 Apr 2026 07:57:19 +0530
Message-ID: <20260429022722.1110289-8-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyMSBTYWx0ZWRfX0UMXmNEU1IMz
 LGK0QklBBdiJxPNoSWVMHbmsRGoPq3u3y2SIolgnkD5qoEaI4EvjjadbzBHl1IkRpVs9Yr3FAVl
 r2Yf140KgriDabM76gbTyam1iQeItUcXgLT6KJln28c+BvnryI/vCq5jHVpQINqNZtIE2rOW1KK
 k9X+MP8a20IscM+porp97R2Mx/chmd57XQnZzZBpyFAqabCA/sr/mk+yYAlwZYV/DaCLWmcCrP2
 Zpnp1v5qCR5Lnkk2PVf8a5Irl97lm18LeJeK9cukxtj/71IrexW2e3rv+aGxb/8Z0BU35jN8kbw
 d4Pmi1y2v8QkkdtKN0OxT48XfCRkOr9tV0QTwc/WTCSk/4Px3MydgYOImahxd7TWKmISj5vjGhd
 2pBmDpm6tv6ll6W/VBKHxBCfdMahZwFk3fXtO4v/Xd/7pgX6B2WRmkp8YN068Cv+HVwJFPm1Bxc
 kbbxHBIn2JmBUrWrRrA==
X-Proofpoint-GUID: fvFvT5RIsCV19UpNjkoV1XGfho5668kU
X-Proofpoint-ORIG-GUID: fvFvT5RIsCV19UpNjkoV1XGfho5668kU
X-Authority-Analysis: v=2.4 cv=bapbluPB c=1 sm=1 tr=0 ts=69f16cae cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=8lec67-3Z8ptwvIrv1gA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: AA6F048E557
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282207-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

npc_cn20k_read_mcam_entry() always reloaded action and vtag_action from
bank 0 after programming the CAM words. Use the bank returned by
npc_get_bank() for the ACTION reads as well, and read those registers once
up front so both X2 and X4 paths share the same metadata.

Return directly from the X2 keyword path now that the action fields are
already populated.

Cc: Suman Ghosh <sumang@marvell.com>
Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 4773277fd409..bb0a9ac7aab3 100644
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


