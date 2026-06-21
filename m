Return-Path: <netdev+bounces-300934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mlbjBUhtOGrHcAcAu9opvQ
	(envelope-from <netdev+bounces-300934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 01:01:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA166ABCA4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 01:01:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="lJF W6nx";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300934-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300934-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 616023006519
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 23:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F122561A7;
	Sun, 21 Jun 2026 23:01:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7681241C8C;
	Sun, 21 Jun 2026 23:01:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782082884; cv=none; b=c5edIP0TMIsS7PBviBAWFo1K7df9Bc+tPHPaQioDtfOGzSihuRi6FoV8s8dxrOlJh7FslMbWt4nEtVzriHVSMXDhrvfVPrlPYjLUC547RZ0lu1f9GWoENp1PQHF/YR9vc9qLXY6RryD5JcPpB36bqVmt06qmkvt5Ty1AkunvJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782082884; c=relaxed/simple;
	bh=EflFA4WT/HqrFWMkasNEjKCdJiSRnEMTolO9I4XL9O4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZlaUsEuSaIrFWeGnKj1Rv3g1kktOBwM1EZ80BC7SLEJBDN1FCTucrf7wC2zz8SJGu/wQnYDCzbW92SC4CiETqZmW6Tw6rTzr4y7clcQnse4vWaCTBNsGH58K0RzVlIBYBj2Jd6UXtDEt9CGlkDkLcyjZPIDuic3lJj/qEWX9RsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lJFW6nxt; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65LMIXav4062566;
	Sun, 21 Jun 2026 16:01:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=K5tCmnoPFiXx0yrOCuzVSFn8vfJM+8+NNvACzKv/Pu4=; b=lJF
	W6nxtyoF5DT/kYvLamRDvS5vSra7JkLM6yMeni7zGObUYzcmVvXwhJDcdrI9V/GD
	z5FNqh8zV7UC7Uk0MlTmy5OkYxCwRq7JulBSbjd6SznW560ccN2ox50LeLtETuV3
	NmOR7XhergELB8IGGa/2wqvXbpUjieFdoVmJZbZ2iOeKjRG9VufcYrVIZufKMyK3
	Sl3bRw1jsOgDIz4KYeeC7QV80x3wgXO7G5a00DOrJ/UBbelfPqPhdQ8traRBozsf
	1jVmZHgfcz/EUR7DAGpDV/Bf24+lenR1MZ597bKJzTMAYVsFC2Z6mJwoklgOhvGl
	jXX1HrvK33c8wjA85bA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4exbm99dy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Jun 2026 16:01:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 21 Jun 2026 16:01:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 21 Jun 2026 16:01:00 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 7BDB05C68F5;
	Sun, 21 Jun 2026 16:00:56 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>, <rkannoth@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net PATCH v4] octeontx2-af: Validate NIX maximum LFs correctly
Date: Mon, 22 Jun 2026 04:30:53 +0530
Message-ID: <1782082853-6941-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qb70nfuE1cuYSI4oH6Cg9jSjHYwrlj9g
X-Proofpoint-GUID: qb70nfuE1cuYSI4oH6Cg9jSjHYwrlj9g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDIzNCBTYWx0ZWRfX6CEbU4F8E8ot
 ZEy6mOLpteXIZnOU+9lrtVwjXNJotICSOeKtDV2Hor71pKd/I0qv3k5P7sLApx507H1eH2Swv5t
 rlq+ys9ynfbJ42weclD9UnhHkInEwCo=
X-Authority-Analysis: v=2.4 cv=BLiDalQG c=1 sm=1 tr=0 ts=6a386d2d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=uS7SUEiOpQzJ16ilQwoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDIzNCBTYWx0ZWRfX85fUechaVAtV
 D5qPTtebWL4lGLfo5MuIlhJLRaIDEqqrH7i/A/7cz9xX2eaZDc2wTXhfXeAifs0A2dNg68Cc5tM
 7O/Ye+PRTahAiy9IQbAP4VWFuDpbH79RqHrIoJRdhnoH+tJeCVHJANpa2MhyBRW0EvtiQuNeean
 Sx2OCVFQBP8NoIOkRpBr1uWIKERmTEsKE8M/xf3kiF/6zme7iNQNwJBDtO95vY+EX4Iwu6K+lsU
 WbSOiSdksSZZ0o/WhnFfcyhdmWz8M09quegG3cldWqiCsQlUIFH6jwtD5FoG8i25d0fUgdbTtrg
 n1eNRdtmidVUUnA1Lp7kImzqqPdRN/iPitera/Mhx0OO6+88zA3RreYhYCVZHja6opf4kwguesz
 z4vw5/xb1eUEZ352cVVQ4SurkvcG8v10vD2oSpn7DJpT49tXflShy+WjCrK/UV3TKSEv0Jl+Y7j
 pAEAH1KNR83X2Wycraw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-21_02,2026-06-18_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300934-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:rkannoth@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sbhatta@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AA166ABCA4

NIX maximum number of LFs can be set via devlink command
but that can be done before assigning any LFs to a PF/VF.
The condition used to check whether any LFs are assigned is
incorrect. This patch fixes that condition.

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v4 changes:
	Rebased to latest net
v3 changes:
        None, updated changelog
v2 changes:
        Fixed AI review by updating error message
        Updated comment to mention modifying NIXLFs has to be done prior
        to attaching NIXLFs to any PFs/VFs.

 .../marvell/octeontx2/af/rvu_devlink.c        | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index aa3ecab5ebd8..d63c3d33775a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1511,7 +1511,9 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
 	u16 max_nix0_lf, max_nix1_lf;
-	struct npc_mcam *mcam;
+	struct rvu_block *block;
+	int blkaddr = 0;
+	int free_lfs;
 	u64 cfg;
 
 	cfg = rvu_read64(rvu, BLKADDR_NIX0, NIX_AF_CONST2);
@@ -1519,14 +1521,23 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
 	cfg = rvu_read64(rvu, BLKADDR_NIX1, NIX_AF_CONST2);
 	max_nix1_lf = cfg & 0xFFF;
 
-	/* Do not allow user to modify maximum NIX LFs while mcam entries
-	 * have already been assigned.
+	/* Do not allow user to modify maximum NIX LFs while NIX LFs
+	 * have already been assigned. Note that modifying NIX LFs count
+	 * can be done only before any LF attach requests from PFs and VFs
+	 * and not later or concurrently.
 	 */
-	mcam = &rvu->hw->mcam;
-	if (mcam->bmap_fcnt < mcam->bmap_entries) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "mcam entries have already been assigned, can't resize");
-		return -EPERM;
+	blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
+	while (blkaddr) {
+		block = &rvu->hw->block[blkaddr];
+
+		free_lfs = rvu_rsrc_free_count(&block->lf);
+		if (free_lfs != block->lf.max) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "NIX LFs already assigned, can't resize");
+			return -EPERM;
+		}
+
+		blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
 	}
 
 	if (max_nix0_lf && val->vu16 > max_nix0_lf) {
-- 
2.48.1


