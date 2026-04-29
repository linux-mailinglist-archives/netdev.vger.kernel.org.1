Return-Path: <netdev+bounces-282208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAYDDYht8WkIgwEAu9opvQ
	(envelope-from <netdev+bounces-282208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:31:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C715548E55F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F487308CF76
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA083859FF;
	Wed, 29 Apr 2026 02:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="W0b/8F6b"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130C3859DE;
	Wed, 29 Apr 2026 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429689; cv=none; b=ZU1ipIAoTKxILIIGwK30J5QG7sEk1DW0/Jr4u9VJ2/Thzg9baYgT3XDrnVjGKRQje8mpPbLCQfcMsCGOrl0iG43v2AFt5v7kpKv7IJtJYggnJ1ZQovugBIgaLVNNHc6E4gF7yNR0V+CletNY8OvSwWZQZIhMkMoyDysyiowLWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429689; c=relaxed/simple;
	bh=DcbPyuSg1idCItZCofhTZpFzomy80t5yZYpVthOgxus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBqdqGDYc9biMo3THxTt/W8tbHn+LhmKtvKiSiD2vEZNqv41g++8FyBAG9kLLkEdtjHwFMvl/khlGBvcgwrA8j3pgTmZXQWnroAeHQJxx3YZwVRziCdwp8UoXLwphmjHi98LQL+jxhw/DiL6s6AzS/RCP7e8zfKbXjiqwZJu8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=W0b/8F6b; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SNc4TK651232;
	Tue, 28 Apr 2026 19:27:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
	Kaxnotn8sD1WjXsRjeWfhP7KW5w13auIahvslhoO3o=; b=W0b/8F6bX5Y2b039I
	Z9JFIpG4Vc844VfiWR0iWyZGcFLBJyIG0sKWNDDThSM1Rmg52vIiyZWcK1uGvIRz
	d1F3q979aHi4O+o7J0/tKQOdcLL2FJ2nrLGRHXKyEemw4u4yVpZYnznRA6tv5iB/
	MJo8izsMMhGPCqBNYuMq/6LvgnDgx0Ha3f9HY/CH908rKMV3Jw5DGkG8yvxhv5m1
	oAJBFTSnkwAjwZbqNg2fIseNJVgNfNq4NwnR6BsteDkd6xKWDuaNYpviM2CEQRx4
	gsv1n0NxZx4hsMcrXQKHtijT6BAyxAu+KlJoH8IzQb5gXZ/y8w1/5utJht3xKlHE
	9os9g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4du6r5rbj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 19:27:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Apr 2026 19:27:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Apr 2026 19:27:44 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3826C3F70E2;
	Tue, 28 Apr 2026 19:27:40 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Dan Carpenter <error27@gmail.com>, "Simon
 Horman" <horms@kernel.org>
Subject: [PATCH v5 net 03/10] octeontx2-af: npc: cn20k: Propagate errors in defrag MCAM alloc rollback
Date: Wed, 29 Apr 2026 07:57:15 +0530
Message-ID: <20260429022722.1110289-4-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyMSBTYWx0ZWRfX8y8DYamQNhq+
 GgL+9j7YJtwIlhafBCrexMHt15stCIDk2txMXSMQB9TvR81xNb12HG6QT6RGzXjn9viu0enEJnV
 2jolT4ADuFOvJjDaXOXUvTr8aUJnyfOCDbMmpGKpPoE+UghN/4KBTMx7zyYeDhPQA4ZfhVgdM83
 2Io6UFhqJwE1C5kJIFH5SBldowU7LLNv16kDHVaskzWJDn7XtiqJsby31I8s689mhqnVa3WYyEj
 orZ7YlO5lUDZ4eieQZ3Nk639o+8+LpidQsnd19bgkiM4wAIiBP6GIB4hBeMexxLQymlfFtGHs1z
 irSTl+xypkRlSsbtGQu9kWeeS47/n7YMi+CMCdfSAiJiafvEbHdguaTy6YD1vx0n9GrlSywNUKI
 dL5S5yg8l7gpWbqNyw+6ZdFZP/9Tc74KQJ6NdL7SG5T+EvtTwbKnrhsAF42e00MbmgjTlaPYW2G
 RdULTjzZ8AWjyBe05uA==
X-Proofpoint-GUID: Wn0El8obKqoaxBjvkYsEzQ8W3wpVL1md
X-Authority-Analysis: v=2.4 cv=GvJyPE1C c=1 sm=1 tr=0 ts=69f16ca1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=9KWCGRY4Gl7Hj0uPvrUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Wn0El8obKqoaxBjvkYsEzQ8W3wpVL1md
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: C715548E55F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282208-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

npc_defrag_alloc_free_slots() allocates MCAM indexes in up to two passes on
bank0 then bank1. On failure it rolls back by freeing entries already
placed in save[].

__npc_subbank_alloc() can return a negative errno while only part of the
indexes are valid. The rollback loop used rc for
npc_mcam_idx_2_subbank_idx() as well, so a successful lookup stored zero in
rc and a later __npc_subbank_free() failure could still end with return 0
when the allocation path had also left rc at zero (for example shortfall
after zero return values from the alloc helpers).

Jump to the rollback path immediately when either __npc_subbank_alloc()
call fails, preserving its errno. If both calls succeed but the total
allocated count is still less than cnt, set rc to -ENOSPC before rollback.
Use a separate err variable for npc_mcam_idx_2_subbank_idx() so a
successful lookup no longer clears a non-zero rc from the allocation phase.

Cc: Dan Carpenter <error27@gmail.com>
Fixes: 645c6e3c1999 ("octeontx2-af: npc: cn20k: virtual index support")
Link: https://lore.kernel.org/netdev/adjNJEpILRZATB2N@stanley.mountain/
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c    | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 7170dcf26200..87da43088b67 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -2338,6 +2338,7 @@ static int __npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
 		__npc_subbank_mark_free(rvu, sb);
 err1:
 	kfree(save);
+	*alloc_cnt = 0;
 	return rc;
 }
 
@@ -3515,7 +3516,7 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
 {
 	int alloc_cnt1, alloc_cnt2;
 	struct npc_subbank *sb;
-	int rc, sb_off, i;
+	int rc, sb_off, i, err;
 	bool deleted;
 
 	sb = &npc_priv.sb[f->idx];
@@ -3529,6 +3530,7 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
 				 NPC_MCAM_LOWER_PRIO,
 				 false, cnt, save, cnt, true,
 				 &alloc_cnt1);
+
 	if (alloc_cnt1 < cnt) {
 		rc = __npc_subbank_alloc(rvu, sb,
 					 NPC_MCAM_KEY_X2, sb->b1b,
@@ -3544,15 +3546,17 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
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


