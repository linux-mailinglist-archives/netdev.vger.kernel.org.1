Return-Path: <netdev+bounces-280709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFPOGAT56WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:48:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 614E7450E35
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71F80302F5FA
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2956D3E3DB7;
	Thu, 23 Apr 2026 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TubvTh3m"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33013D6698;
	Thu, 23 Apr 2026 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941032; cv=none; b=emp8lC1vezmmnCWBZUNpzUhi5eEnrpdie4FZkgcCgQWOfpqpGkXjijWKh/ahNNGfqVO2fx5aoMNv3Z56TAYv+lWRcoiLxsDw3yGooOJuK54nxZodaNmWKEDEuXQVUUREA9KoSDLBao5Npj6c8zp+7MVd1Dv2a3yWgwqe+DOxD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941032; c=relaxed/simple;
	bh=ewydlr+408NRN8E3Rieiqr7Ja2HTcxmKu0Jz8ZwURj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZujQ4UpBdwmtxWLQVO9NFr+QE5GH5Ns5YhlHYUqmw3tVElS1HgyWx8U7Qz2YiG/n2QFQ1bLPuZa9ft51I7CB4nx1+DHVUvxb5MyQX1uyd2YFnAsmYoVU8bKhsxQA/KljV+eqQVrCzL84yQ2Kjia7wbfx+82X8PEdTPZVjy02tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TubvTh3m; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MMX62I3063981;
	Thu, 23 Apr 2026 03:43:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
	AOyXfXkCCLm375K7N5WQZZcl0RHDj/IHRzkmZMOuH8=; b=TubvTh3mFwr+kBwRB
	OQt7ISfvEA39z/9i3QZlmwm1upvvQFL2+2dXq8c8CXEH+2hKnev0RFnq6EI5wUDC
	6Oj1yDnDe8GVceFadCuhkA1BuGMNekuh0k9qUnWLlQZa5iYfWvOTplrhVf8XnBay
	Le9+hvWMV01AAI2j4pxt7xx0DcyzJveE4qieDFGxIai3SGXp1emiHfcGppvSam7L
	PtBVWzBPHi04mocXRHKTOhFNZDX0Pk52PHhZ/fGDIxKLHtZ2kzZFzytQ+E6aPLsi
	USzEMoQI6a77iMaLvY4ht3BoPD3G6sPI5cQKL/kmBGR9hIL+z5eXLhZS4PzqgPKI
	UwerQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dpepgwd96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 03:43:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Apr 2026 03:43:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Apr 2026 03:43:42 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 7BECF3F7044;
	Thu, 23 Apr 2026 03:43:39 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net 05/11] octeontx2-af: npc: cn20k: Align MCAM X2/X4 use with KEX profile
Date: Thu, 23 Apr 2026 16:13:11 +0530
Message-ID: <20260423104317.2707923-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423104317.2707923-1-rkannoth@marvell.com>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ooRd18Q-2R6pV-FChTvQm7wQchrrO1er
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNSBTYWx0ZWRfX2UVLmNnJRRoC
 lzIsKkC9/VwlHkX13Fvrb29VU1vag6tKH4+36ZAFhgIm6tdvMqVA8nuHAAX8slzp/n3qLQ8pS0n
 WUk45bzo8cZUa48308DuEFRodUneGvHqNELT+LofmsgkLlTIQepILMZVqBrrrmgBH8kbhbCAAPy
 Qkm09/1cL/Cuwf8edq9Lt5XvLtLiUkoGjcAddZnVlRAf5KMzPW42hR7Kv3QtK75kaehbrTFF7xw
 X5XnfIneC353EjH/nXIO2n1a7CCSOKA74b504Gmg/+40newG/zMfDyp86WYTNsY9gzUNgIlYG+g
 o3RoIBQm8sJ11zeWwNlR1qcphSbzw1AERXLq7Qddr6GYg/xXm+S76CuieZVAE1lXQSyc3pSGY28
 PppZNtMRhdAtwWBv9vgvgL6QJDdjfyYk0x7qo/zp/zI/0ew2kyV/LBVheBTpQWwFxTY+6NkSUv/
 8z+kdbWD2nLjsn3Ielg==
X-Proofpoint-GUID: ooRd18Q-2R6pV-FChTvQm7wQchrrO1er
X-Authority-Analysis: v=2.4 cv=SJBykuvH c=1 sm=1 tr=0 ts=69e9f7df cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=KDiXX-RHRRxjKdtkOfgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280709-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,npc_priv.kw:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 614E7450E35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Flow install derives whether an NPC MCAM line must be X2 or X4 from the
effective key width (>256 bits needs X4).  That is only valid when the
global KEX profile allows X4 keys; if the profile is X2-only, fail the
install with -EOPNOTSUPP instead of allocating a mismatched entry.
Default L2 rules allocation always requested X2 keys.  When npc_priv.kw
is X4, request X4 MCAM entries and wrap the reference index to the MCAM
bank depth so default rules match the active key mode.

Fixes: 9000cada7aa9 ("octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c    | 11 +++++++++--
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c   | 12 +++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 97acba77ff88..74dad164b6a9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -4328,11 +4328,18 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 	 * as NPC_DFT_RULE_PRIO - 1 (higher hw priority)
 	 */
 	req.contig = false;
-	req.kw_type = NPC_MCAM_KEY_X2;
 	req.count = cnt;
 	req.hdr.pcifunc = pcifunc;
 	req.ref_prio = NPC_MCAM_LOWER_PRIO;
-	req.ref_entry = eidx + 1;
+
+	if (npc_priv.kw == NPC_MCAM_KEY_X4) {
+		req.kw_type = NPC_MCAM_KEY_X4;
+		req.ref_entry = eidx & (npc_priv.bank_depth - 1);
+	} else {
+		req.kw_type = NPC_MCAM_KEY_X2;
+		req.ref_entry = eidx;
+	}
+
 	ret = rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &req, &rsp);
 	if (ret) {
 		dev_err(rvu->dev,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index fe10554b1f0e..dd5d50d52964 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1663,9 +1663,11 @@ rvu_npc_alloc_entry_for_flow_install(struct rvu *rvu,
 {
 	struct npc_mcam_alloc_entry_req entry_req;
 	struct npc_mcam_alloc_entry_rsp entry_rsp;
+	struct npc_get_pfl_info_rsp rsp = { 0 };
 	struct npc_get_num_kws_req kws_req;
 	struct npc_get_num_kws_rsp kws_rsp;
 	int off, kw_bits, rc;
+	struct msg_req req;
 	u8 *src, *dst;
 
 	if (!is_cn20k(rvu->pdev)) {
@@ -1689,8 +1691,16 @@ rvu_npc_alloc_entry_for_flow_install(struct rvu *rvu,
 	kw_bits = kws_rsp.kws * 64;
 
 	*kw_type = NPC_MCAM_KEY_X2;
-	if (kw_bits > 256)
+	if (kw_bits > 256) {
+		rvu_mbox_handler_npc_get_pfl_info(rvu, &req, &rsp);
+		if (rsp.kw_type == NPC_MCAM_KEY_X2) {
+			dev_err(rvu->dev,
+				"Only X2 entries are supported in X2 profile\n");
+			return -EOPNOTSUPP;
+		}
+
 		*kw_type = NPC_MCAM_KEY_X4;
+	}
 
 	memset(&entry_req, 0, sizeof(entry_req));
 	memset(&entry_rsp, 0, sizeof(entry_rsp));
-- 
2.43.0


