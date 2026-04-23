Return-Path: <netdev+bounces-280707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF7ZGun36WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:43:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16250450D73
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A8EE30197FA
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046BE3C198A;
	Thu, 23 Apr 2026 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HzBBrnMU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8BF3C73D0;
	Thu, 23 Apr 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941026; cv=none; b=b39+jmdldLzhtQyX8jeTmGDEVG5QOMeRZQ36k8VG8Ok8jjKC3uzGSblCGQA9sEiIybIbPdN20vwGFFa4rBvaQVOVhCuOhPpzdX6phsVes4zHc1PgxItyysBJxROyiW6lNPpqtKHa4n4ZQQ6AH4V1FeTvYz4t1lk7eXHfW+dREyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941026; c=relaxed/simple;
	bh=0MAtzYbuNonI8WkInr95vohUtUk0WOhwCbknKAO+0tM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZ2uoCvBIguLKgmOIOQGSYAr6efcMbunEPfgwq//3a0Uk9oNjk3kdRPwaTSR1bJRVSG5aFcBV9OAOWQUH3tRpFdZkyo+N8nckgpC17fv79bXLIgbBR6Zw9SD/bTX/QObBwKTOcxnRi4QTMEu7Yitk2jYeh5TUfg603w1Talnqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HzBBrnMU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NAOjf21593909;
	Thu, 23 Apr 2026 03:43:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
	9qqrWjQYZITKorLUFDE8N6VOaDsoa7xvud8ClBGLuY=; b=HzBBrnMU8vqxRtdLg
	oGgBKhb3PIC/YpK76uL/uVMrIc24KtuLkS+rlwfpXmVUaXGNNxKPmTb0cNl632qC
	ulnFH9PgN3MDb1vnkDtLrnq3yAVXUQqj9JHoac6BSXaWKrRSInZgz5szlUESqqo7
	vLoOTgAJn7uN5wgY+cbiXtrzYHcjcm83uNnRtj14/fkaInV9yHqRefTK6bqF01lt
	CUd3J2l+frUMoPkhOXPEbLMD+BsveEpB/l+UR1ecGF1CYOX0ZBe5snTfQgeJg1+c
	RFROSDLlXDlyR6VGstvvhyTVrRuPYpmPRiXsMrwvKE+biewxwgIghusbRnjbQsR8
	6j8jw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dq5gs1t6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 03:43:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Apr 2026 03:43:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Apr 2026 03:43:35 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 1ED5D3F7044;
	Thu, 23 Apr 2026 03:43:31 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v3 net 03/11] octeontx2-af: npc: cn20k: Propagate errors in defrag MCAM alloc rollback
Date: Thu, 23 Apr 2026 16:13:09 +0530
Message-ID: <20260423104317.2707923-4-rkannoth@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=F5dnsKhN c=1 sm=1 tr=0 ts=69e9f7d8 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=nhaU4qLH0yjqk7k21MUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNSBTYWx0ZWRfX2CPQAU1q74+y
 UL3yPn/G0WwdmV55JAphbj7wI752ooqrnHHus1/GkFP4ASSgkE++J2TAHVb3Q+SHy9kveAAi15s
 2aOpH1Tyh15+7sQdL43r/4Qauuww4U4xSWQbUwPuz89w7NnZw/+rgOaxld+WFS0lyxHBP3UVPkg
 fgtr6FTX51Bc69jVvJKpGkjhGHXivXRglgXnsHBGR93scVzPlz9xDFkvZ9R3qYy+IFhnrYhI5Ay
 eHIZV6p69X6NInrXNojja3yCNC4tBhb0ftTBNBo6AsEBtR/yBRKkGYp6mD5wC0giiC9nwjv1Gi6
 w13chbtd00P/f3wTXTCsEcFJRQ75Q3SmfmPdGOawd49HmB1wcgyVXw/HOPKqMhk95lv50BNrQC4
 6pkEFDgI7C4wPYj7HtL3rLC3KCEMn8eVH9kkXwOWhYsPGlZMrpjPaUG/qgAgH9qnlfmvhZAXAVB
 dbSPGqKgxGYbrOA1thw==
X-Proofpoint-ORIG-GUID: reP6Y7raDjGYzJh9OkzT8N-99Ql8-Wpe
X-Proofpoint-GUID: reP6Y7raDjGYzJh9OkzT8N-99Ql8-Wpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280707-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 16250450D73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

npc_defrag_alloc_free_slots() allocates MCAM indexes in up to two passes
on bank0 then bank1.  On failure it rolls back by freeing entries already
placed in save[].

__npc_subbank_alloc() can return a negative errno while only part of the
indexes are valid.  The rollback loop used rc for
npc_mcam_idx_2_subbank_idx() as well, so a successful lookup stored zero
in rc and a later __npc_subbank_free() failure could still end with
return 0 when the allocation path had also left rc at zero
(for example shortfall after zero return values from the alloc helpers).

Jump to the rollback path immediately when either __npc_subbank_alloc()
call fails, preserving its errno.  If both calls succeed but the total
allocated count is still less than cnt, set rc to -ENOSPC before rollback.
Use a separate err variable for npc_mcam_idx_2_subbank_idx() so a
successful lookup no longer clears a non-zero rc from the allocation
phase.

Cc: Dan Carpenter <error27@gmail.com>
Fixes: 645c6e3c1999 ("octeontx2-af: npc: cn20k: virtual index support")
Link: https://lore.kernel.org/netdev/adjNJEpILRZATB2N@stanley.mountain/
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c    | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 49b5cd2838b5..8630a6a73387 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -2325,6 +2325,7 @@ static int __npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
 		__npc_subbank_mark_free(rvu, sb);
 err1:
 	kfree(save);
+	*alloc_cnt = 0;
 	return rc;
 }
 
@@ -3502,7 +3503,7 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
 {
 	int alloc_cnt1, alloc_cnt2;
 	struct npc_subbank *sb;
-	int rc, sb_off, i;
+	int rc, sb_off, i, err;
 	bool deleted;
 
 	sb = &npc_priv.sb[f->idx];
@@ -3516,6 +3517,7 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
 				 NPC_MCAM_LOWER_PRIO,
 				 false, cnt, save, cnt, true,
 				 &alloc_cnt1);
+
 	if (alloc_cnt1 < cnt) {
 		rc = __npc_subbank_alloc(rvu, sb,
 					 NPC_MCAM_KEY_X2, sb->b1b,
@@ -3531,15 +3533,17 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
 		dev_err(rvu->dev,
 			"%s: Failed to alloc cnt=%u alloc_cnt1=%u alloc_cnt2=%u\n",
 			__func__, cnt, alloc_cnt1, alloc_cnt2);
+		rc = -ENOSPC;
 		goto fail_free_alloc;
 	}
+
 	return 0;
 
 fail_free_alloc:
 	for (i = 0; i < alloc_cnt1 + alloc_cnt2; i++) {
-		rc =  npc_mcam_idx_2_subbank_idx(rvu, save[i],
-						 &sb, &sb_off);
-		if (rc) {
+		err =  npc_mcam_idx_2_subbank_idx(rvu, save[i],
+						  &sb, &sb_off);
+		if (err) {
 			dev_err(rvu->dev,
 				"%s: Error to find subbank for mcam idx=%u\n",
 				__func__, save[i]);
-- 
2.43.0


