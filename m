Return-Path: <netdev+bounces-279639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD9HDaiR5WlNlgEAu9opvQ
	(envelope-from <netdev+bounces-279639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:38:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCB2426597
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D6473017C12
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E01D3783C4;
	Mon, 20 Apr 2026 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Z2miBqlu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA0378D98;
	Mon, 20 Apr 2026 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652542; cv=none; b=POeYORFN9lcsUYAy1YncavFt8blyMtQ2VfaCzq2FONulLDb3y59G2m0zIq8ZJM3/tupvW7SIbWc8Hj4Js0kIjejJ33T6XGZS6/q03nVCiHsc1b50nd8wdicNXbnFKK1fQ9voDmo7uon+KC7R9p8voZN7lanapqmJq8/d9RQmGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652542; c=relaxed/simple;
	bh=IZ2hBW4Bo+GoLShx0jd516Ciam03WnWE2BZj7aa7U/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVCwwJBnTrUOh5fPm6Y8JOrTOe8sHNdl67JIBXgSxuRXz3ZTARhasGP04wKzVjwMR0NQMlR8VGriifwdYwjajnZiqMJlz8qAbz8pdKLRLEI3TM4TMmoF48pIBl/OUUtRo2uQR0thVtsCV1wJtan2A9SmzLXOZqmkZCw1B4TgfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Z2miBqlu; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JJg1jd1882585;
	Sun, 19 Apr 2026 19:35:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	Y6zj6dIb+/s9m3Kq874+RzZ1yvcw6vlIyoIaBodjWs=; b=Z2miBqlu995GTPo95
	R19Nm9j9HQiYeWkOcuskh/vIEvxRKCTI3MlaMsifbCgqCDiiRRE/Jb+Un2MFkEsW
	jz2IDch8oRLIbDIfQYyrQZbvtadBIa8gwuqUf7U3AlEGUIj7uzCOdIOMqECn9QAY
	0rqYLowlZEmUew0D9N5FfDLVMOrvwNYaLEPKJYYVvgsX+OKDanf298ThzRaGydx6
	jbAXS4tDn0bTl4ztr3fHGTlQsnJ6i71mSG5ustuYJGqb4gl4oH1rFceWGA47LHct
	6SqDsoj8Ukmv8az+W8Q9uVTDitqwavFyTgcpYAtThBmuZyC7c5zuk3pnGqmctDO2
	6o93Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dmx77h2n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Apr 2026 19:35:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 19 Apr 2026 19:35:09 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 1C5B73F7041;
	Sun, 19 Apr 2026 19:35:05 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
        "Dan
 Carpenter" <error27@gmail.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net 02/11] octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in init
Date: Mon, 20 Apr 2026 08:04:33 +0530
Message-ID: <20260420023442.3295891-3-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyMyBTYWx0ZWRfX97hnm0faECvU
 Lk9sxOrhywnxDFwuPU03Y0a1XtvBEr+GqydgzMwokw3/6dt0q1p3zBIoK4c1mQuntLxg35YHbma
 tnssFqrhKqhoKQKsldUZYbW6KRF7LEWKQtpj6o0T5E8diFD+SbxRjQmDcIXokYjs2jYbHDU0YB7
 e4CUCjsnQ92nbeSWpaEPiqr81++NtGYdCtKuU8L3TZG1IOW09nAyRohYrgAPaK/JaiOIzehEh8/
 eF2KabHb3xxuref4UN1CvS8NDNiWkWpCa/IVSCpOxsbJYvE+/9AlyHysYkag6bXdP98eNJB43J0
 WKE1Uf14T/D4pklACrA1osohS4pAVlNcIWS9zWEpTG9EvjBjSndd7NtZRpCIvPdqHwPmZSA/Eq7
 FsO53561UNVmqcfpanuKxyMwt89837KunJLIZSQu0I3GalqWSFE3TpzVG6VMf2Gret7cusmBFHt
 8Q3L9FP+h/WOL92oiBg==
X-Proofpoint-GUID: sVbBgjIBeL8MFptzV07m8rPu_PsAcTWN
X-Authority-Analysis: v=2.4 cv=P4IKQCAu c=1 sm=1 tr=0 ts=69e590de cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=5dRrolKJAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=m_5JYv9Gamu-D5dMTTYA:9 a=y3-2bcJ53AEkEa81XYCb:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: sVbBgjIBeL8MFptzV07m8rPu_PsAcTWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
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
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,linaro.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279639-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3CCB2426597
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

debugfs is not intended to be checked for allocation failures the way
other kernel APIs are: callers should not fail probe or subsystem init
because a debugfs node could not be created, including when debugfs is
disabled in Kconfig.  Replacing NULL checks with IS_ERR() checks is
similarly wrong for optional debugfs.

Remove dentry checks and -EFAULT returns from npc_cn20k_debugfs_init().
https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/

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


