Return-Path: <netdev+bounces-282209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBMGG6Bt8WkIgwEAu9opvQ
	(envelope-from <netdev+bounces-282209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:32:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D687948E577
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28586304465D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0154B387347;
	Wed, 29 Apr 2026 02:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LdZF2NXO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49083803E7;
	Wed, 29 Apr 2026 02:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429690; cv=none; b=SaQzbq08qOx+Dicbjvk30kG+USiWAO8fkxkhyyTJnRVU4f7ZjVVNm3H6SOdiaPGyLPYMBsBMn4dzkbqM07ofzYpsvlivE1FhpRkmez0SAYGcOcmMdReBZSLrSXlz0nuCPf3Jqsh1Kwfii89HQQww7CzfzP8DTrLYOmn25s5F2GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429690; c=relaxed/simple;
	bh=InDmdjpfI67E3SauOP5D0dkMpECsBRrQKRyfVmo4evM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaoYlQB65Y6BKhTWXEs9huPhPpGu1EK67KVMwv7pAqdhklmRxZkwoxplbsymulPa72qItUN2sf6EjRGRbJ7KVBmuRuLQo3Gotkou9oevNk8vkJ/ilQT8K+dR8PsflVa2+WSOCNmX9iLogLEcfQ+scAWrPpAQrZPsh10w7GRsRWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LdZF2NXO; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SLdjiO2315106;
	Tue, 28 Apr 2026 19:28:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
	ga4c2b3gXVe65vf4lhDu6XBvaJ4+oy8EEhdwhEb6Jg=; b=LdZF2NXOXDNoN3aOs
	unNOcN8dOxjXykzFVE5orOlLtXuNEFH3l5axgLelOd5sCW1l2aFnuHf32dpw3Uv5
	Z5VH1ROqs33W7c8+y+LDWenbB6NtKMWjS3zTx2+SsPpyu43iTHaDCSkqJdtbrCq3
	1wQ30UUeDFwhjOKPPaVJUDn9Fl2b2pXNrY+DfYq9esQHYVZvkiOov4mv3/S5A2Oy
	TDnVeNuzmolkQqguVpdlMWJuq4p5CbVz/d8tLJqLqUo1wVcnYZfw482XCAcI00hs
	IFHDx1wYXlm3INv2WvfMJsyfGMuq7xcFeSSYKizG9/MeESky4r0IaqJIvBeLlwnN
	JYc9Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4drw4fsfa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 19:28:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Apr 2026 19:28:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Apr 2026 19:28:00 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 08B893F70E2;
	Tue, 28 Apr 2026 19:27:57 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v5 net 08/10] octeontx2-af: npc: cn20k: Initialize default-rule index outputs up front
Date: Wed, 29 Apr 2026 07:57:20 +0530
Message-ID: <20260429022722.1110289-9-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: AaE9RN3q00z5ZW76wVigQ2PQV9r5gNH-
X-Proofpoint-GUID: AaE9RN3q00z5ZW76wVigQ2PQV9r5gNH-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyMSBTYWx0ZWRfX8ilyvHRCAigP
 LyWOKowPyQ8g1gxFZK+CuEr/h0BkzhAGUZzbWEuocqgniEC/ODqC0FLzjx6hpYrSjZ5/bYlfxpC
 Bf40y9REgtf3jAgf97Gi2Vr0DY1f19zVGMiN8ut0tbUigiEJugdo2a8b3CTxvRJy8ZmdK9LgQQX
 flek9j5x6d3SyjicDB9WNeOpjPY3/5to/monENCKlD6XV2x+bZADV8msdaF7ay/9KXCijqm5GJk
 QBOdSCi5kcMYsR1u8kj30aNUBxWgBxAlXe1SIbqkdomSC4a1qOl3Gjqqnv0jjFtfVVGel/AMjId
 kJr99+C1BRTXfST5wBLCuaUCmpQ/bEiEjidu2ZB3uYE71j0N705CfOQQfTWXoUe1oT+S1juu61g
 5R/rJtO7agjQSUqelv19/tsXR8HMnO/T2MfjY3DWmqCRtVknNW55sMFx2dLv3nKFEpyPYSyfRVp
 0QvJbBf6lAz4xTXthsg==
X-Authority-Analysis: v=2.4 cv=X/Ni7mTe c=1 sm=1 tr=0 ts=69f16cb2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=S5xAItHIjfA1pY4gmT0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: D687948E577
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-282209-lists,netdev=lfdr.de];
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

npc_cn20k_dft_rules_idx_get() wrote USHRT_MAX into individual outputs only
on some error paths (lbk promisc lookup, VF ucast lookup, and the PF rule
walk), which could leave other caller slots stale across retries.

Set every non-NULL bcast/mcast/promisc/ucast pointer to USHRT_MAX once at
entry, then drop the duplicate assignments on failure. Successful lookups
still overwrite the relevant slot before returning.

Fixes: 09d3b7a1403f ("octeontx2-af: npc: cn20k: Allocate default MCAM indexes")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index bb0a9ac7aab3..b3f34b84c114 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -4016,6 +4016,13 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 	void *val;
 	int i, j;
 
+	for (i = 0; i < ARRAY_SIZE(ptr); i++) {
+		if (!ptr[i])
+			continue;
+
+		*ptr[i] = USHRT_MAX;
+	}
+
 	if (!npc_priv.init_done)
 		return 0;
 
@@ -4031,7 +4038,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
 				 pcifunc);
 
-			*ptr[0] = USHRT_MAX;
 			return -ESRCH;
 		}
 
@@ -4051,7 +4057,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
 				 pcifunc);
 
-			*ptr[3] = USHRT_MAX;
 			return -ESRCH;
 		}
 
@@ -4071,7 +4076,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 __func__,
 				 npc_dft_rule_name[i], pcifunc);
 
-			*ptr[j] = USHRT_MAX;
 			continue;
 		}
 
-- 
2.43.0


