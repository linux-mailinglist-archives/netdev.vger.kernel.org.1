Return-Path: <netdev+bounces-281224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHjABtED72kj3wAAu9opvQ
	(envelope-from <netdev+bounces-281224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:36:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E7D46D9DC
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66373301D073
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A26371043;
	Mon, 27 Apr 2026 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ai9NGlZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0DD35F5F8;
	Mon, 27 Apr 2026 06:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271561; cv=none; b=e3yptdj8wTkSWz67QPFFGCRRxVlI4ec2ZKW1jca0F0xB0Qmn7LEiex8v/q6U3zp0vd2RB0YIKSGWcOvNoFxBN2eEV09qcZqQbd12jmYvqv4B3NMAY/KEthr3QfBg1yjQH9K3XvokvtlzzF297bbpmdLm5BYisOPYbd7VoPzJIOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271561; c=relaxed/simple;
	bh=IZ2hBW4Bo+GoLShx0jd516Ciam03WnWE2BZj7aa7U/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IN/kM4NBjmGDlDmYEXeuor23SPLAEWZp61ZEDP/Nu37ms8hyE/4L/mi0w4M8UeJkqrMJih+CzaAVclq6HjHUFnaKtvQkPZHHWttaYlcfaU4KnnL8GgHFTfvdl+OdqSRNGbXWk2WIjQF5vQVDBXraOl2kcjuhHZ61X2GNMatCZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ai9NGlZ6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QKclrS3253803;
	Sun, 26 Apr 2026 23:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	Y6zj6dIb+/s9m3Kq874+RzZ1yvcw6vlIyoIaBodjWs=; b=Ai9NGlZ6BYirlTAVn
	ya80YEjJAbNAVnW9hVY+EEKV/vu1rGodUiEKN/N0xsCL4W5echtC2ZmXaYf0CISp
	Ogk7nud+JmixvnjBBkA3xsVx8+YL/Oz3Xyt4RaToWU2F7KhV21UdfuFmbu98KqYe
	sVF3jQYFNMoVYQLhSlMgDDFPgSzIxlwOMs+KnXazIfeMGg3JzWnzmi7wifoT95CJ
	T3uQIQYJaE9WLHeyI3smd+6/lyJuFVKgtoLXaGRsqGHyutdtetV5U3GqTy4WBLEy
	wSmFB+pKCBhx2VCcIAr4nPZFvBmFmBQmCd5a/xv/zurRU3mvMNC04MiZ7/pHgSYd
	Qe+ow==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dshv89fcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 23:32:29 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 23:32:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 23:32:27 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B75D33F70BB;
	Sun, 26 Apr 2026 23:32:23 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Dan Carpenter <error27@gmail.com>, "Simon
 Horman" <horms@kernel.org>
Subject: [PATCH v4 net 02/10] octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in init
Date: Mon, 27 Apr 2026 12:02:05 +0530
Message-ID: <20260427063213.3937451-3-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2NyBTYWx0ZWRfX+I7f9mzmgc7S
 maN+WsouV8yKqGr47R02N5idYjA+VURJRIu4QskFOGhTwsGVEhaJkkmS+vqvn5RjKn8qlljb4i7
 HcnT3fHmD1V6cpFq2c+S8ad3+UwFufHbwOumv6gELA53JxRmZZoEiHEqcIdPqksHA1Vy6Ltqx6F
 Fb/2jOUP80SXZDNx9Fgzr1ol/XlNoxfmEe9gfyNteKbVueQdDW6ImyQsQJbf1JvVo3tAXtXJfrD
 C4rvdToi4mAeY+JzbZbYw72d573JaZ7ex4eLlfvc8IGhnuwaXu9jJ143O5kje2rd9xZHWhGA/tc
 tmJGezD2IobaGUwB/koTbM0vd3saLjq7UMQ+CI6io93qFkVmwFW/EEAGGvoazEgvo/dA9GmY+Vh
 dSNWkWhnD8p9Inh19p62/gEK/SjDj3qKTaPUdGagtH+voNQopb698fxEsPjqcAHX8sQR5h09jvv
 27E9wmgig22kSnOrs6w==
X-Proofpoint-GUID: 0r60Kb92HT_Ufya9V7Wu_oKHOg7hS0Qg
X-Authority-Analysis: v=2.4 cv=ILgyzAvG c=1 sm=1 tr=0 ts=69ef02fe cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=5dRrolKJAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=m_5JYv9Gamu-D5dMTTYA:9 a=y3-2bcJ53AEkEa81XYCb:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 0r60Kb92HT_Ufya9V7Wu_oKHOg7hS0Qg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 79E7D46D9DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-281224-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

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


