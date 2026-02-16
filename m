Return-Path: <netdev+bounces-258844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN9eGZjdkmlvzQEAu9opvQ
	(envelope-from <netdev+bounces-258844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:04:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D209141D17
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA01030011A6
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 09:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F352773D4;
	Mon, 16 Feb 2026 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NksJnRYS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD422B5AD;
	Mon, 16 Feb 2026 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771232657; cv=none; b=hpMY4r4WwVUbX5fkpzm/aPLwx0YXRKKqOVIkrAfzWgJjnT0ngrInCKnGl6r3MahGO1orrz5uyeoOt/8ijpJ484XduC6eTT1uv9tHi2430TaDAWqCPIQKBVhzeQ8pbpPTGh0c6wM/qvFO9Rgb4nlG1tC1EkqLmM4JBpldewb8Dlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771232657; c=relaxed/simple;
	bh=d7vZcra13Z4BwqG/YOalNGu6W7cd81jebEfLkAOlyZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AcCybOiA7oBLPqpnMK19MRThQYaUvKGb1zfnaHy/Jyf0nEBl0ARhDNfoStPPxsTxoAd/Juzt1rY+kviI61itzRGjYqYLU84k01+btzTqaAZBxdlmR7isoLm+04A5FxVjeqBAm5zhBqGk8EFI7r9kMjeQ4cfbCihinx4s2J4oDlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NksJnRYS; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FM0lRv1808513;
	Mon, 16 Feb 2026 01:03:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=qboZfK0J/W/eifdTHm2VLdn
	NLyxnnLWS4RBb0vFdRDM=; b=NksJnRYSV17A39yjNgGBKwSRaBwMr4w6c3Jl8k0
	K92x4ehA2plkXg1JyezjlZZI55jKnj1hrw8YaLn+Zb8FUeapkPJewZ4a7ZUn2sLg
	qSCc48rF/4rjSLvDZ5sVxzAru+wsAL2a2XM0lboGw6c+wxFlqT4xpE/niuO7y8JA
	YqEaQODHRhGIMhgCpQEE5ne4esxufH74u9rxE4Mf+VdHGSaNbBtQ+K5FJdymgPfE
	fn9ZkrZe7m0vq7D5BZer7mRlW1x9UrvzDzimD8Wn+8eXBZ9vQQjFDUPrE5jS4slE
	fwW9IS5z2EmAm4HhL0/f+FkoQ99YRUpNQ5hZuHzeJGgdHXA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cbapc9gr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 01:03:53 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 01:04:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 01:04:09 -0800
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id C26883F7060;
	Mon, 16 Feb 2026 01:03:48 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [net Patch] octeontx2-af: Fix default entries mcam entry action
Date: Mon, 16 Feb 2026 14:33:38 +0530
Message-ID: <20260216090338.1318976-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=fMw0HJae c=1 sm=1 tr=0 ts=6992dd79 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=Bh8JR0lMpQ274LkQbpQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ddgujvpABFg0sIBoM7WcmR9t6i6t2UL3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3NSBTYWx0ZWRfX4cciMvhRjgS3
 AeWgYJt3gzb/YyJFxB0MvqgqhckYSjxWal10ooWVJTrqNzMSKyp2qHkIK22md27/scA/8Z3foC0
 KlA4SUOpgrTw/UiQCQTlH2QypNZuzd6KuBdESiMYCclp7ymDqlVPID9p/8N5YKY7s8sAdG7a7UR
 pPXfiX751pNlHz9zyjgoi0CCr0C5qL4gx8KNFHup6TtixDMiqJCOvARZqa2l1y2XQxwKxMAQCau
 x8NpvLKhUmeSJiDWMvkhHGEC/5AzangXIeaSHKABENznFKjyIhGxos3c5RvLzzJocFicfC+hacV
 ggmxnItrN8j0UWkEsojJTpXRWnMlC1bTWANTzeSn1NHI/6dZH7E6w7M7q3psibq9/S/Uzhr6tGz
 x1m/He9DJtducO+bTKYGAAqn4FJu3gmTnImh97xXI/t4Y6Qd97Hkmym/1j1upMFr0gWqe1ne/TW
 mOAGlmu+CER6vDj53Mw==
X-Proofpoint-GUID: ddgujvpABFg0sIBoM7WcmR9t6i6t2UL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258844-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkelam@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:mid,marvell.com:dkim,marvell.com:email];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7D209141D17
X-Rspamd-Action: no action

As per design, AF should update the default MCAM action only when
mcam_index is -1. A bug in the previous patch caused default entries
to be changed even when the request was not for them.

Fixes: 570ba37898ec ("octeontx2-af: Update RSS algorithm index")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 41 ++++++++++---------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c7c70429eb6c..8658cb2143df 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1042,32 +1042,35 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_MCAMEX_BANKX_ACTION(index, bank), *(u64 *)&action);
 
-	/* update the VF flow rule action with the VF default entry action */
-	if (mcam_index < 0)
-		npc_update_vf_flow_entry(rvu, mcam, blkaddr, pcifunc,
-					 *(u64 *)&action);
-
 	/* update the action change in default rule */
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	if (pfvf->def_ucast_rule)
 		pfvf->def_ucast_rule->rx_action = action;
 
-	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
-					 nixlf, NIXLF_PROMISC_ENTRY);
+	if (mcam_index < 0) {
+		/* update the VF flow rule action with the VF default
+		 * entry action
+		 */
+		npc_update_vf_flow_entry(rvu, mcam, blkaddr, pcifunc,
+					 *(u64 *)&action);
 
-	/* If PF's promiscuous entry is enabled,
-	 * Set RSS action for that entry as well
-	 */
-	npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index, blkaddr,
-					  alg_idx);
+		index = npc_get_nixlf_mcam_index(mcam, pcifunc,
+						 nixlf, NIXLF_PROMISC_ENTRY);
 
-	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
-					 nixlf, NIXLF_ALLMULTI_ENTRY);
-	/* If PF's allmulti  entry is enabled,
-	 * Set RSS action for that entry as well
-	 */
-	npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index, blkaddr,
-					  alg_idx);
+		/* If PF's promiscuous  entry is enabled,
+		 * Set RSS action for that entry as well
+		 */
+		npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
+						  blkaddr, alg_idx);
+
+		index = npc_get_nixlf_mcam_index(mcam, pcifunc,
+						 nixlf, NIXLF_ALLMULTI_ENTRY);
+		/* If PF's allmulti  entry is enabled,
+		 * Set RSS action for that entry as well
+		 */
+		npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
+						  blkaddr, alg_idx);
+	}
 }
 
 void npc_enadis_default_mce_entry(struct rvu *rvu, u16 pcifunc,
-- 
2.34.1


