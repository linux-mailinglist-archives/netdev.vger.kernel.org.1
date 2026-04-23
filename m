Return-Path: <netdev+bounces-280710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKxYMhz56WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:49:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF827450E4B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EC263022E0A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238183E025A;
	Thu, 23 Apr 2026 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ezJ3pbir"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954173E3D8B;
	Thu, 23 Apr 2026 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941033; cv=none; b=Cw9y//O86903k3oJT6k+vOD3u9dkEgH72MuKpZRQEA9MbkoIZ2UTMEggppnUdYPNZc7u+8kZIOxAc5Z05ZhViI9cVLbCXUGTU3Dma8d0EPheiVGYjNQksAVG7eJEp09BNmJF2W6SeD6OSUsDhdsUk/meIjz0ADum6EdbKIT3hL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941033; c=relaxed/simple;
	bh=IZ2hBW4Bo+GoLShx0jd516Ciam03WnWE2BZj7aa7U/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEjmAscs8dRkT9sxlbEaO8VO8CMRFWPdUgdTBs5V2YqXQQwSHTPPvCQDWn+d5tFyo9ar7w5JRLBprkUCWgNYpTxA/Wp9wVqR4/k3EB7Nu+hh/Z+qz/TVqWNOcCFMyPcTbV3HaEQnRXjnTIPrFEnDVdVS2HgUIvUfH8SUVpVKEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ezJ3pbir; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MMeeBU1379722;
	Thu, 23 Apr 2026 03:43:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	Y6zj6dIb+/s9m3Kq874+RzZ1yvcw6vlIyoIaBodjWs=; b=ezJ3pbirFn3pv7Dfv
	+JXQOEl66TP/HpHWvvJ2thcyS0COCi4nJnqrvOVc5URoBtoMMIYzwciEndyHTHip
	dZkYpyWroWEpS2vEEdV8AitV2C9mzQlYVl/QU3Ztjjpp2SNI/+AuZOKXkFEC5PYP
	InPkgB8tk5gwrqVeb0F0fq2jcJOG+rZ8QHh7sBQIs1pi2eWTXTDtGVJ8uzKgPbkM
	Wnz+gXEpbQDM8ctfUqQSZvBp85QzdTrZXXxZ2ASpZxn9x/nLaTkWO0KljPoS6GK9
	X9zh2b9xsd9NmFtJCuuyyl1/ZXF3feVwCBQ/MgC8c2hFL/ypG+Fj8+7RVMTA8jXZ
	dr+aQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dpepgwd8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 03:43:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Apr 2026 03:43:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Apr 2026 03:43:31 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 03D513F7044;
	Thu, 23 Apr 2026 03:43:27 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Dan Carpenter <error27@gmail.com>, "Simon
 Horman" <horms@kernel.org>
Subject: [PATCH v3 net 02/11] octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in init
Date: Thu, 23 Apr 2026 16:13:08 +0530
Message-ID: <20260423104317.2707923-3-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: MlFDro9Drw31PzqvEGRY7qk8NJWMAL73
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNSBTYWx0ZWRfX+jski/THEfe+
 1K/t6Nhuylt/L6BiEEy9xthai2uNQ0wM0iYpagP3jy6d3fO9rRpJQ6egU5q4vcvpHL9jLgqXKP5
 s656G6YRqbz5cjesR5voHDuGOFsw9i5LBx03LS5ftYC7iU7rV5jJWopMYXz7xTYY8X/dXdLIHPZ
 pmo3aj3wtrABoxJN2aU2jnA3alpgMwY2lzB58z7QRBJI8ua5Au7p8aW8c6+8IZlDPX/il+83Wi2
 Cc7OLaq5z6Yyl5DNtbGhR5NmsHzhcBTAlLCqHA9UviR4F2IdOhIqvz4uBMxlDz9vWKXfAVnlJ1L
 9pQmFof7kJcjBJtBFoIgZB5sjtPhNiURGtMmUPC02evK4uU13dYp6YFcYjkhQx4iKYj6VKgbDYb
 wIoLD6V7HKfTNb4slvebPUawAM1i0fTl0TiXe+83gNgtsPx/aWpeQe+OKuEMK83Yetz5xYpZSyU
 FxfPqOUOxwVPHkIetzQ==
X-Proofpoint-GUID: MlFDro9Drw31PzqvEGRY7qk8NJWMAL73
X-Authority-Analysis: v=2.4 cv=SJBykuvH c=1 sm=1 tr=0 ts=69e9f7d4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=5dRrolKJAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=m_5JYv9Gamu-D5dMTTYA:9 a=y3-2bcJ53AEkEa81XYCb:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280710-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: BF827450E4B
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


