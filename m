Return-Path: <netdev+bounces-278916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGpzOLpd4GkcfgAAu9opvQ
	(envelope-from <netdev+bounces-278916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:55:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E229040A19C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02EBD302CA66
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 03:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F173093BB;
	Thu, 16 Apr 2026 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="H3CWcjGN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93182F8BC3;
	Thu, 16 Apr 2026 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776311735; cv=none; b=Owpa47NoZ+A0vPxRPSmQ8FW/M6C1w8fVewKB8bYCVRTyt8BTCnq3EXhlU0NW3thdEBoqZfW+gh/UvGdopbRHaOodMyAX+lHmPJw2yKR4Ujbrg1dyenumR5fbovAUb4qiOwoMDUm7d1yMYTw9FAnH+ZF29Ue5hz/qslgrdfPaaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776311735; c=relaxed/simple;
	bh=p0Hi5KhG7hcLhB2XwVYaWw7oEBl8Qu4UyipOQvs+Ris=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZHPY6rugENA5orf+UMRqIutEHAXLZbT7ddd1OZ1bu7AebE80n/ghWLPA2pojLSKOUCT0C+YzluSbweyyUsKd/prEhIWQtpGSQdSTfVqWWpK4FU/rgAwiJi6VuIiRHEZgvI5htdqXyTFm8FJL66QjukCS8Yb05N5/GOnGnsKnR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=H3CWcjGN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FLRNEh431389;
	Wed, 15 Apr 2026 20:55:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
	Ju8pcT/zGuvuUykAuGSa5f0qgCTaSf+tMvhssydGEk=; b=H3CWcjGNsobb4uBG8
	0laAzNAjN5c473nycHEYDk0kXvr7rxlNSkTRReERurajLAg40JQmCi3dGxJk54/j
	pSHGIRf0XlQ3d47FbMoYjy7HrW0AHryxlXnpDZhUHn2dbBFBizcv0wtnfEX4/Zu5
	2a5zoHkKmpzrukIRd2afVDYA2/rKh6UCmgVJsd3IlMO+9q/4v6Fm6QLXklTBpRhV
	Tq8H5BYtCDJYgoXN8szql+PBFvfvRB9kMekMJwNWAkksRljtCENoCmkuVfbfkqLn
	R9IZgjtPpRnXmBasVmTExRIDY+JmwSiJQlogi4na4OxugeX/a6Lg0XNtMPyWwaaT
	AJ3IQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dh84n6vuk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 20:55:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 15 Apr 2026 20:55:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 15 Apr 2026 20:55:14 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 055CC3F7079;
	Wed, 15 Apr 2026 20:55:10 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
        "Dan
 Carpenter" <error27@gmail.com>
Subject: [PATCH net 2/3] octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in init
Date: Thu, 16 Apr 2026 09:23:51 +0530
Message-ID: <20260416035352.333808-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416035352.333808-1-rkannoth@marvell.com>
References: <20260416035352.333808-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=B7OJFutM c=1 sm=1 tr=0 ts=69e05da4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=5dRrolKJAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=1ymndBUdME0ty6P6ZmIA:9 a=y3-2bcJ53AEkEa81XYCb:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: g_dJhIxtZODVR3PcEaXyknZCj0rH51H0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDAzMyBTYWx0ZWRfXyBZTvtE4SqQT
 XtDRShjZHN1gCk5w1p7fXqR3wpRG1YfObRGleCVcK0ERolpF07w5a3HeubILTORt8AozTHFzowc
 alVGKjeQVpsuL+QcQ4ymYqz1wSmfQ4XVeDQC8pj09msChW4N8OPzM/cx6/gTAP4FpPb4lXjqKJf
 BaorBZiXw4mY+cf9g72qEPBlGO53in8RRGffLpiSOH3IuX0u4w1ltA1+rW901rLdJMer5C6sZvy
 WPgda4BHg7/C74kcsuMIO3Y0MA7Kbxgi4OJwJHq7lFmXlXMj3NYmBsxCMphXZRmkRWvjOlqJGnh
 r1XDRCkordOBs74YY4U4nORFe8gY2ChH1MIMxhPROdio2iCsKP4vhOnu/X+e1kCx1rhaocnfX2B
 gETD4MEpE6osg7xQV341tv/sKyCgtMJJ/0AuC+8kfhxANiY5HNYdccs58x6l8MiauPtHRJwhFED
 KQcTS20O85Ze7Z0tw7g==
X-Proofpoint-ORIG-GUID: g_dJhIxtZODVR3PcEaXyknZCj0rH51H0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN_FAIL(0.00)[74.135.232.172.asn.rspamd.com:server fail];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,linaro.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278916-lists,netdev=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E229040A19C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

debugfs is not intended to be checked for allocation failures the way
other kernel APIs are: callers should not fail probe or subsystem init
because a debugfs node could not be created, including when debugfs is
disabled in Kconfig.  Replacing NULL checks with IS_ERR() checks is
similarly wrong for optional debugfs.

Remove dentry checks and -EFAULT returns from npc_cn20k_debugfs_init().
https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/

CC: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/netdev/adjNGPWKMOk3KgWL@stanley.mountain/
Fixes: 528530dff56b ("octeontx2-af: npc: cn20k: add debugfs support")
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


