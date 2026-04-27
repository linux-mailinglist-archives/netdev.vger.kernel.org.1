Return-Path: <netdev+bounces-281226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHq9JysE72kj3wAAu9opvQ
	(envelope-from <netdev+bounces-281226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:37:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C9246DA46
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C66EE3054F72
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E4537D138;
	Mon, 27 Apr 2026 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aBxnNZv+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C75370D54;
	Mon, 27 Apr 2026 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271566; cv=none; b=K9HU0s+FbrlR16ZF/fSIR8o2MmMxblP+nqcCJQ4B+mN31AjWJ66e4nIKLYVNKURk7Ub/e40yfz6JMamZXITEFSOAeE5bTppvVN6WxCKwjHMEvTubfuutIeLOllJqaSAl6JVENUCnVCHDdFMpMtI3wk2oPUO5rlyVproIR9TtehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271566; c=relaxed/simple;
	bh=uxrJZElSqfg0fYbW2nlTmSD3ropI2Zqrt31kC05hpW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kiq59aC+CbE36l5BJU0Ky2yCGMakxOXiLLZrropK7NEQ4BwCq8IQzreNba1FqoICtIOd5I2F0l+KIeNodONJJG9RWwvU6LNqOQho5Ii1ZmHR9EkeJfbS/Vn5HWF7+2vy0Hdrut0PsX0304rbtJ0o31MC4bfi3J57y9zvBCERZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aBxnNZv+; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QNmBc23112869;
	Sun, 26 Apr 2026 23:32:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
	XYKKNSXuSlcFyRLZhnxMm5OlqtUaaY6BF/dLuHkJJQ=; b=aBxnNZv+P37OmlDYh
	U7vl8rD+ingcqsgUR9GkxrNg9p0RkhMzZMgait35ksQ4olbKszm1XayFfHGcyzER
	3EZt29kAQDbYKjqt+qi0FmDwQFIw1OVSDLM2aIkvZCQ3SJh7Wnwx6MJTMsmIKmxn
	NFYTHPIeLHrMGTTUNA2fwWDCCiZxbjB2LWyw9zmk7NRDr9lj78Xyg9QWLsGiEAt5
	mLUPt2hkVZofDHg7xbt49/lLnoNCHHOx476cq2dhEppKijzkzQSfR0fWIwaColxt
	pZYASx+w1QXewA4cPlXza/UzI3vWNuCqiUIS0Ap0citcGRhu+Xk+tZ7CZEILqne0
	zVENg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dsec9sp6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 23:32:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 23:32:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 23:32:31 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id DCEF83F70BB;
	Sun, 26 Apr 2026 23:32:27 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Dan Carpenter <error27@gmail.com>, "Simon
 Horman" <horms@kernel.org>
Subject: [PATCH v4 net 03/10] octeontx2-af: npc: cn20k: Propagate errors in defrag MCAM alloc rollback
Date: Mon, 27 Apr 2026 12:02:06 +0530
Message-ID: <20260427063213.3937451-4-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2NyBTYWx0ZWRfXwNYUPUkKW2JY
 EXvUO0/a2vd/Dm8dn/LPS7JO01WK50MU0QSeD7bar/oo1olwDMogJkBAd2kdX1/Ql0+aXZ+vtEv
 laB7+GpEYW0jIPXMBLQYyXZH+UzrXfdvqTveRzE0nFilc5uIkOmTSMO0dzoVDzSCW6Oluaw+c0f
 nw5EG7c4CwAftt+uD6P0Gb6rYKESOs4QYhmlg96ElJyPz5wCwUCSiK8/XJftjmlDS8bjECUCXLR
 kKxnvZsjEOcgK+zUwtlLZBQXzSXVgYvf7QRFyBpDdByK1RMWfO9ZXKMkzcGYEUbZCjfcNtxnmvk
 MkG2sckJ8DRZ412V+Shhr1qWJFvs00oPTlCV0lW8EzNZ8130KOiZsuTQuYn4lKA+3rSsNn7i0kE
 I1z3XtD4uz0VX3l9i2PR+LRqefVUVp5F/n6s7Y/nxhozqaNX+bDwx0/gcGfqv46ObWjk0+yCT7t
 ehyDb7JJ3DREaK7oy2A==
X-Proofpoint-ORIG-GUID: Li1WPJcM79Pr6yO7Z9zxlBwvEmS_hBI-
X-Authority-Analysis: v=2.4 cv=Cf84Irrl c=1 sm=1 tr=0 ts=69ef0301 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=nhaU4qLH0yjqk7k21MUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Li1WPJcM79Pr6yO7Z9zxlBwvEmS_hBI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 29C9246DA46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281226-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 8d5cee833af7..c831585424df 100644
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
@@ -3533,13 +3535,14 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
 			__func__, cnt, alloc_cnt1, alloc_cnt2);
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


