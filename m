Return-Path: <netdev+bounces-282201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHNHHrds8WkIgwEAu9opvQ
	(envelope-from <netdev+bounces-282201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:28:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE42C48E4D0
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFF3F302F43F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331DC3803F0;
	Wed, 29 Apr 2026 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="a0tmy6TJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7637F8A8;
	Wed, 29 Apr 2026 02:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429677; cv=none; b=Q5xhOB9HY9juMR19XPUyyadekL+e03ITOWsoIGdMYircll7E6frH2U8LQbbv80ynUwPlAIR9j9YWosjlMlwopuNQWNEq8Klp6J623dmAElNRXlL91e1idaducNQk/xU37wQ8KdjMxKenIwwVVoavqQzer1wvUwLhNfMicIAUkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429677; c=relaxed/simple;
	bh=HctnWrVwLjC7J3BLKSTn8QuMDYB70EOqlLp7MGlivWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZI6vSlxJ9hl6EM5zRR8aXrTI9GfJPIi/ebElJOLGMMFxrvluoEAK+x5ZQiK1FXCl+r2es5A7hR7MTL2iz7eG1143HrMSI/UcJXG4mVvbVPqAtbuS2vS15CAaNaFhjo43sOH76MCT4SUoLKw9pcXnUuauih+X06SFvICnt0mf08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=a0tmy6TJ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SNbxOi4076522;
	Tue, 28 Apr 2026 19:27:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=7
	tzYpuYBjK7yK9s8tymtRb+7L6/9qxXKp2Ierhq1KOQ=; b=a0tmy6TJkHxcuEPSv
	3ohjBhmb1F0z10U7BKfd5WOi6NBwGbqROyrcBVVBHJX3ltlg0KWZwb1x2j2Q8NiU
	cngOiVnt+Q3hnktR2Dq8+yTL3jzhRV4mg4zlHOUE8duseEN44zkjBqQwOr3wttNb
	XXO0UP7EFA27JH2fOFTLsDcheuP9fqmsCZBDSWaHrzroS/n5krnV+W2eC0Gr8AG0
	yJTeDbRPvm1+Eq8sb1MoEDE7Z17hEME6lu7B4sG5CI8JbLA5vxzbtoDSfTEa2iab
	27KzCVG5ZJsTEob29yWXnXbfik7xY1oUuEJtBRAxDvGtwKq2CLpAbjH8TuhPYWPu
	fm2Vw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4du6r38c11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 19:27:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Apr 2026 19:27:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Apr 2026 19:27:47 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C95093F70E2;
	Tue, 28 Apr 2026 19:27:44 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v5 net 04/10] octeontx2-af: npc: cn20k: Fix target map and rule
Date: Wed, 29 Apr 2026 07:57:16 +0530
Message-ID: <20260429022722.1110289-5-rkannoth@marvell.com>
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
X-Proofpoint-GUID: Gwe9H4KNyuB5NIhV8bFPICdS4SZXU3E2
X-Proofpoint-ORIG-GUID: Gwe9H4KNyuB5NIhV8bFPICdS4SZXU3E2
X-Authority-Analysis: v=2.4 cv=RKWD2Yi+ c=1 sm=1 tr=0 ts=69f16ca4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=3gJHjdpLIrtAeZZwNzUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyMSBTYWx0ZWRfX3XGs87uUd13i
 35ise04pZ2N2Uj08Kakl7hbfwnE0bnyR1duhMY1wUWLtuVSWZFHTCLpoaBmmMV/Yoimg7D5cGzc
 YLoH2JXkyZ/qvplK6ujj49iVUhzBIJCWq4MGR6IWLLwAzWS/9JsOmZDEuKSfsboosjix9JrVJ+I
 7NCWXLGZ3/fCDXz1DcYL8jhCNG9YzvUgd5OF/k6MiCyh9QTp9nNwMmzAtnTuHcBEOaW+QBEBqgx
 SaOVsASbIwavuK2l+87zXGUutfPsh9JGN542S0nN4ID8rosgU2LbRSXPsd7KW2AevmlkDuPXTSy
 lp0njiQB9tfepNKgF2kIjPVZZPOWmHrI3UI37CFhlGR9tKaQX5v6PMU2rezDhX/1cWDybVaMwHV
 UCJeMIYzPC6Lhu2iuoJvyQFwG+QDzxfKdly7EGBvCb4m6J7fOLxIf4n1vBQ8ddLSli19XwIX3wV
 qThiFGL5Vpg4stxNdHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: DE42C48E4D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282201-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid]

npc_defrag_move_vdx_to_free() disables, copies, and enables the MCAM entry
at a new index but previously left entry2target_pffunc[] and the mcam_rules
list still keyed to the old index. Copy the target PF association to the
new slot, clear the old one, and retarget the rule entry so software state
matches the relocated hardware context.

Fixes: 645c6e3c1999 ("octeontx2-af: npc: cn20k: virtual index support")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c    | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 87da43088b67..70ce3f49adc1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3602,9 +3602,10 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
 				struct npc_defrag_node *v,
 				int cnt, u16 *save)
 {
+	u16 new_midx, old_midx, vidx, target_pf;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct rvu_npc_mcam_rule *rule, *tmp;
 	int i, vidx_cnt, rc, sb_off;
-	u16 new_midx, old_midx, vidx;
 	struct npc_subbank *sb;
 	bool deleted;
 	u16 pcifunc;
@@ -3723,8 +3724,21 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
 		mcam->entry2pfvf_map[new_midx] = pcifunc;
 		/* Counter is not preserved */
 		mcam->entry2cntr_map[new_midx] = new_midx;
+		target_pf = mcam->entry2target_pffunc[old_midx];
+		mcam->entry2target_pffunc[new_midx] = target_pf;
+		mcam->entry2target_pffunc[old_midx] = NPC_MCAM_INVALID_MAP;
+
 		npc_mcam_set_bit(mcam, new_midx);
 
+		/* Note: list order is not functionally required for mcam_rules */
+		list_for_each_entry_safe(rule, tmp, &mcam->mcam_rules, list) {
+			if (rule->entry != old_midx)
+				continue;
+
+			rule->entry = new_midx;
+			break;
+		}
+
 		/* Mark as invalid */
 		v->vidx[vidx_cnt - i - 1] = -1;
 		save[cnt - i - 1] = -1;
-- 
2.43.0


