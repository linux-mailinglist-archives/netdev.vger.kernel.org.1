Return-Path: <netdev+bounces-279637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIuGMU+R5WlNlgEAu9opvQ
	(envelope-from <netdev+bounces-279637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:37:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22622426561
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0458F303F7C0
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA6637880E;
	Mon, 20 Apr 2026 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZqXFC/yJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA5378D8A;
	Mon, 20 Apr 2026 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652531; cv=none; b=MV9lIjwYeeXxqP36bD6fq0oPCujLVwD1TOUnKHG2d/F42b0VCC2Ub1X6vM/sy0FrkkEknsC3buvCtir1VopAr6OlDC2Cl2QKaORIb/8zKgGjeEhni6qHhLsGVYL5xvi8SrMANTGyj5jK2jq1Ki0tTo7kCwskaSTAy1uqQXHuwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652531; c=relaxed/simple;
	bh=71MicUOqIEmx1kfHQTkpfZrEBt7UhK3/C2DWxKhdNC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAQF3dLugCsmrVCD1mcrShZRJXk0Xq+7/G0dgur9S6W6assoztUSD6hpaDh4ojGaxJGPwgnDlJL7vSNIwe6fibIlhkfnED9Ep1xP7tEyMc2Yr6kJzQ1doUeyxhKHfuP0nkwEI06nXEFxFKKL5Qo6+Cyfmqa3HBacQu+hgRFmMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZqXFC/yJ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JJg1je1882585;
	Sun, 19 Apr 2026 19:35:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
	3uNmAOJwNLaHrFA1kwhDbQ9a+SapkNnL26Nhuoz/JA=; b=ZqXFC/yJbIAB64XbY
	eLr0hNzZiDeGPlVDpDdVB2bxUUuM68fnwjgJ+MaXwE5IMqilCuI10KvlXNm+bVNR
	g2UhA8LxIzFjPLwXcwvZA474bALwhrheZgqLJWHHmFv6Mh6HOzezuBBE84jUZN9m
	Zq3wo9ao3MgMvJIhKZytwfWz7MSARJ5VZxqnDRpH5mNKxvzUCe6E/lErLWSteRCd
	7AM3RJaZuOpRF6/g5bDBrupB0j/4kc/M3SRZKHSJ/41R6XqRC40SQpQ+bUvJ8jCd
	BKqAceiNUTHhj+uGUZLkOqg6eroZ9Jl4VgKGnZsQwGmJqjIRoNmKYwWM/+W9MGv3
	uoHPQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dmx77h2n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Apr 2026 19:35:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:14 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 19 Apr 2026 19:35:13 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 419AE3F7041;
	Sun, 19 Apr 2026 19:35:10 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
        "Dan
 Carpenter" <error27@gmail.com>
Subject: [PATCH v2 net 03/11] octeontx2-af: npc: cn20k: Propagate errors in defrag MCAM alloc rollback
Date: Mon, 20 Apr 2026 08:04:34 +0530
Message-ID: <20260420023442.3295891-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420023442.3295891-1-rkannoth@marvell.com>
References: <20260420023442.3295891-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyMyBTYWx0ZWRfX7IhAsxHv6/FS
 TPq8sMGKmuTGPx3wGtn7QvKsVxe03NR0xEjGX8AmxlQ1oQhbjmXwD35ZVNGsG0Z3LbySTHl/II6
 6rCL3LhMBAtkjyk1V8mPSPJwmj3w4a4r5SE4EIjDZ5sxahAVzHdalu9PmwdK9qstzYNGRT4usks
 1aHKv4zyNtJQWGh3XLzpWNIY1/ltFYPuL1KgVBDrxleqfj4FKPx2Y9tqT0lgQvtqs6p721gZHGt
 9fAQ5JDQeA3xqiAuyfRr0C5/1EFfIqeHZW61nYjJ8pb5C3DLYaLLZ8khdEZ202fBaEFRA8u172K
 u/9WeC/eIxhW73p0Sa/uVavbOcjR+y6JdkT6OLnW/w4ne+Nc34ovxfSq6Ptc7trZ3onNEM0Q11h
 KnNrvZgrlearP4DSUvPWj4SEovZ621pQeJI4AFulm0c9Ep8qJICzU9+hPStUWnGeER7RcuKnzyR
 640O7WFN0eD6VYbNPcA==
X-Proofpoint-GUID: -fgZQvQlYuv-26PYTEYL6mZnze9-FpeQ
X-Authority-Analysis: v=2.4 cv=P4IKQCAu c=1 sm=1 tr=0 ts=69e590e3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=LeiQjOPAn9kEfegU1kYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: -fgZQvQlYuv-26PYTEYL6mZnze9-FpeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279637-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,linaro.org,gmail.com];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 22622426561
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
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 18d70f4527d1..7f897ce0d17d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3502,7 +3502,7 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
 {
 	int alloc_cnt1, alloc_cnt2;
 	struct npc_subbank *sb;
-	int rc, sb_off, i;
+	int rc, sb_off, i, err;
 	bool deleted;
 
 	sb = &npc_priv.sb[f->idx];
@@ -3516,6 +3516,9 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
 				 NPC_MCAM_LOWER_PRIO,
 				 false, cnt, save, cnt, true,
 				 &alloc_cnt1);
+	if (rc)
+		goto fail_free_alloc;
+
 	if (alloc_cnt1 < cnt) {
 		rc = __npc_subbank_alloc(rvu, sb,
 					 NPC_MCAM_KEY_X2, sb->b1b,
@@ -3525,21 +3528,25 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
 					 save + alloc_cnt1,
 					 cnt - alloc_cnt1,
 					 true, &alloc_cnt2);
+		if (rc)
+			goto fail_free_alloc;
 	}
 
 	if (alloc_cnt1 + alloc_cnt2 != cnt) {
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


