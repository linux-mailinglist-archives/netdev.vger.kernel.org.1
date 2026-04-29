Return-Path: <netdev+bounces-282205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHOoByxt8WkIgwEAu9opvQ
	(envelope-from <netdev+bounces-282205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE848E519
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08A85307A688
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98220383C7C;
	Wed, 29 Apr 2026 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JjxOrZP1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41789382F33;
	Wed, 29 Apr 2026 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429684; cv=none; b=KdZpxj+2TBDt7CVx+McJ612dM6vm4AW3E/OFiAgWbHRF11G2d/4SAjr7YxlEj5SXkKdm7ooGe9yMo6HIO321uDOdSzhKrlD4ymIordwTTevoX62DzkA+pq1B9/aOOM4wAG9GCHwPLdTJFYun1OhYeFUuTzmdPUZJ6alZWc2rx/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429684; c=relaxed/simple;
	bh=XhqzLpEnwfzhPwJCWhVWmmh+pfeOdxOR9GyDMbRstdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VL9K+/mhA8yhIKmEpluTVZUu55xBegDfkLkR0r+kaXqJCsJ17f3tk179waj/kPy3Mrhe/f2sqs/HUZ3LumZhrNhFg6g4Dt1/txGhqSrZeXngp69LDnRjBIEM53Zn0OJA12/3EKyLuhxJit1zlxbPjjU7gts/KysLOZnXI9jRjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JjxOrZP1; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SLBpP72973475;
	Tue, 28 Apr 2026 19:27:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
	vywY/PJ0lfvtyEyr5qh5q99krHESGVDKQ+kBuDPTUE=; b=JjxOrZP1jpHqRbKyg
	WHst4LSX7VROoCAKjw6h/stqZeIe+5bNWefHHr0VLFNFY9oJvXmM3wJJwiCMmVip
	u49QIJe2iu6rD+UAmfD7fLFvtAjn/vWTZOf/bZ+Z6wfRFUItWYGvoCoJ3sPAZMAG
	q8oMajXefcWQg7BY0AhYJl8EjUy6G4QrI+CzsJ65lU6s807kYxi4arKEHgTE5n+A
	4gzkot1ZYB+ekmaKaLiRQN8mT4LVxaLFxH97N7fEDDGp3TUP85UWecVCU0J1A7Tl
	MiG3HBbRvdqns+hBMvjgkGcX/Y9RaDxC7m93GtfaBUwn+eGTBnj6QBX/LZpJwVqq
	WHjtA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dth1mby01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 19:27:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Apr 2026 19:27:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Apr 2026 19:27:40 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 9B3603F70E5;
	Tue, 28 Apr 2026 19:27:37 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Dan Carpenter <error27@gmail.com>, "Simon
 Horman" <horms@kernel.org>
Subject: [PATCH v5 net 02/10] octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in init
Date: Wed, 29 Apr 2026 07:57:14 +0530
Message-ID: <20260429022722.1110289-3-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyMSBTYWx0ZWRfX5MDTWmcq+LQN
 ZJFk1y4NMu2fO/Sg0uWeThM94ZDYYGwu43y1guHcyiZGeYx58OSBFj7fE4GvXrAf4h4sjq/C9yZ
 D3u0s62nD/1IyWWkAS5JUxJuiDilnCGXLRh+afErRQZZ0sTJj3m8vK4MFuVFA1y8hvAKIP+IGYG
 1VOblZQXzj2BDcUiPTZ77+PsdHD9CBLFJK304s0+3uQe2IAshqRhuCVdb2OQsgyjNyPTDZcFPvi
 eras+nGbMr32oQe47vLYYVHoEwsbk1wtb/z5GP+B3F1uYdDrJf6bOQY0omnvgTANzOvI2AK8U+6
 W+Uhqb17uuLkdxShd2rE58SWvWgTkU3aB2OfxIGAb7kqpb3w0ELYWypwgJhS9LuCW7gexfmQ9oW
 gWGaQsy6kYWGOA1eCqG5E8QXFyudTzK74G9oLjDXn8fXLD26Da87WF4/9f/V85x3SdnXLH/C3Wb
 fAOyT+ChMfkHZsQ2ZfQ==
X-Proofpoint-GUID: 3af8GUxowFaJ5gSXL1LpG73pxZTEzAXf
X-Proofpoint-ORIG-GUID: 3af8GUxowFaJ5gSXL1LpG73pxZTEzAXf
X-Authority-Analysis: v=2.4 cv=bapbluPB c=1 sm=1 tr=0 ts=69f16c9d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=5dRrolKJAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=m_5JYv9Gamu-D5dMTTYA:9 a=y3-2bcJ53AEkEa81XYCb:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: BECE848E519
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
	TAGGED_FROM(0.00)[bounces-282205-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

debugfs is not intended to be checked for allocation failures the way other
kernel APIs are: callers should not fail probe or subsystem init because a
debugfs node could not be created, including when debugfs is disabled in
Kconfig. Replacing NULL checks with IS_ERR() checks is similarly wrong for
optional debugfs.

Remove dentry checks and -EFAULT returns from npc_cn20k_debugfs_init().
See:
https://staticthinking.wordpress.com/2023/07/24/
debugfs-functions-are-not-supposed-to-be-checked/

Cc: Dan Carpenter <error27@gmail.com>
Fixes: 528530dff56b ("octeontx2-af: npc: cn20k: add debugfs support")
Link: https://lore.kernel.org/netdev/adjNGPWKMOk3KgWL@stanley.mountain/
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 33 ++++++-------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
index 3debf2fae1a4..6f13296303cb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
@@ -249,34 +249,21 @@ DEFINE_SHOW_ATTRIBUTE(npc_defrag);
 int npc_cn20k_debugfs_init(struct rvu *rvu)
 {
 	struct npc_priv_t *npc_priv = npc_priv_get();
-	struct dentry *npc_dentry;
 
-	npc_dentry = debugfs_create_file("mcam_layout", 0444, rvu->rvu_dbg.npc,
-					 npc_priv, &npc_mcam_layout_fops);
+	debugfs_create_file("mcam_layout", 0444, rvu->rvu_dbg.npc,
+			    npc_priv, &npc_mcam_layout_fops);
 
-	if (!npc_dentry)
-		return -EFAULT;
+	debugfs_create_file("mcam_default", 0444, rvu->rvu_dbg.npc,
+			    rvu, &npc_mcam_default_fops);
 
-	npc_dentry = debugfs_create_file("mcam_default", 0444, rvu->rvu_dbg.npc,
-					 rvu, &npc_mcam_default_fops);
+	debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
+			    npc_priv, &npc_vidx2idx_map_fops);
 
-	if (!npc_dentry)
-		return -EFAULT;
+	debugfs_create_file("idx2vidx", 0444, rvu->rvu_dbg.npc,
+			    npc_priv, &npc_idx2vidx_map_fops);
 
-	npc_dentry = debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
-					 npc_priv, &npc_vidx2idx_map_fops);
-	if (!npc_dentry)
-		return -EFAULT;
-
-	npc_dentry = debugfs_create_file("idx2vidx", 0444, rvu->rvu_dbg.npc,
-					 npc_priv, &npc_idx2vidx_map_fops);
-	if (!npc_dentry)
-		return -EFAULT;
-
-	npc_dentry = debugfs_create_file("defrag", 0444, rvu->rvu_dbg.npc,
-					 npc_priv, &npc_defrag_fops);
-	if (!npc_dentry)
-		return -EFAULT;
+	debugfs_create_file("defrag", 0444, rvu->rvu_dbg.npc,
+			    npc_priv, &npc_defrag_fops);
 
 	return 0;
 }
-- 
2.43.0


