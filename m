Return-Path: <netdev+bounces-300201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jJKSBCvAMmpc5AUAu9opvQ
	(envelope-from <netdev+bounces-300201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:41:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC869B160
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:41:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="lIt PHOU";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300201-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300201-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCD953025F68
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40934963BB;
	Wed, 17 Jun 2026 15:41:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA9481AB2;
	Wed, 17 Jun 2026 15:41:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710881; cv=none; b=jYQD+JqsiRqqvS0f4H48b/egvMJh3rhAO0/RVmppnN9Ssl9QKVVT2KGmQ+VQrp+kpVZTu4PJlgi45MYwQWyR+tmaMH2x9ypFhNLSCfVaPqUvqtO+3PAFZSfTX0aqXjG9NAlWFtuaqwHLrm45T4F54SXaudjbitSbm8+rPlpCofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710881; c=relaxed/simple;
	bh=sJMPrx7l6NL8vOIMAOYuR0uKTUks1N6yoVQIz+MbfU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j9TYqH7I+9Fbym+5sP31pckv0Y4XuNuQkOQ2QBPhGgq0u2BjOGOiZlM51wHl6j2PvqM1RWuomP9KTdYO7yDtCdyJmshxJ72ZNARHG7D7kbBgQ4hSp3Np5r/I0lrWe7fgbmtNtUpfQ4N/wm0yzBSb2bbVABjYxs9kdP7+hld52vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lItPHOUk; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HFTg6K1545848;
	Wed, 17 Jun 2026 08:41:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=K6UI6h3r/uijKFewerhnjQmF3YEgCfjfjpqbO1cRh4I=; b=lIt
	PHOUkTTaDKNBrQ8xXd18czttFc/GxzFauS73YwyZNqDEwcGkBXW/eFTw38xxpTEb
	mhyxbCmhsrczyWm97k8tF69ClBRuy5/3G3CFLcK1b7z1NPP9KD3yYARr2qTCK3yv
	wEFS59wP3XYtz4qYokQrBSZp5L8geY6mExjlw+CV4OlEqeUmsCga0hIy4lyoF2C5
	HdNw80B4N1cfdfjhbGl96HklLUEScF7uIsjcEGzp+0sQzc9bTRgE5z3RvhKquWvs
	xPOjYe76/132Q3QQmQmNT69d0tw1+70p/T3MEvOcC7jrebR8nmoaaloxajqgQA69
	0eTSBLR4oybmjw/yxTw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eueggk5jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 08:41:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 17 Jun 2026 08:40:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 17 Jun 2026 08:40:59 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id B49563F703F;
	Wed, 17 Jun 2026 08:40:55 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>, <rkannoth@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net PATCH v3] octeontx2-af: Validate NIX maximum LFs correctly
Date: Wed, 17 Jun 2026 21:10:53 +0530
Message-ID: <1781710853-23420-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1MSBTYWx0ZWRfX9772ZpV8IdAN
 nIVDHomTykWwhVMIDPkf+Ic845h6l/Bp/nLaKUAFs6PdS4G4PBXSa3zMdt4UjYsOsTjJ3+gb8vz
 GmUMM0CqgFWlg8Ha1k9eWtn8wQbHiQo=
X-Authority-Analysis: v=2.4 cv=e442j6p/ c=1 sm=1 tr=0 ts=6a32c00c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=uS7SUEiOpQzJ16ilQwoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: P9JJgRowJ-9DxnwW2o5Zc5ePlEIZPYUF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1MSBTYWx0ZWRfX7uhh4I5PinDK
 XYTLqrZaYOlBnFnKfDipiz8E3Oyo39Ef7fHL7QB1+iTC2J9hJT3bOfhMP52tXDPMwVAWQp5N6UR
 m0Qd+rovzbjTh6nMzjURoQabHdc6ezfgtIE0rmpwNU3kUakOfPaYDbnh9QiYJQIN5zRJCi6rOWV
 jf1eBhKzWkghbtD7HvhSb3SoOJfUJ8sOb7EKOz3IxZRTOV1t3Uh8kugojfpSorVgMb8oQ8UMp7x
 MjkpwovdaWVe1YI61yAgP5OKtN4XWGeHbHywxH0Ju5TLdsnZu3vtPTkAVSeiajzn0D1n5TBtKwZ
 wnLv57ZXECdVHsDzTQjhwV1jHdGek2h8bXDn46hUryZTXxB2PFruApUn6DK9BnRIQVXn7pkfa2Y
 vI7eWl4HRuX2UT4Uo5VVjHbmzgadp0KWQsjQ0Ou2kUjg9FR8YBb70bIbpmo6eydJgPnS+EI5wk4
 VPBZCRldlh7CBmJXlNA==
X-Proofpoint-GUID: P9JJgRowJ-9DxnwW2o5Zc5ePlEIZPYUF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300201-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77FC869B160

NIX maximum number of LFs can be set via devlink command
but that can be done before assigning any LFs to a PF/VF.
The condition used to check whether any LFs are assigned is
incorrect. This patch fixes that condition.

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v3 changes:
	None, updated changelog
v2 changes:
	Fixed AI review by updating error message
	Updated comment to mention modifying NIXLFs has to be done prior
	to attaching NIXLFs to any PFs/VFs.

 .../marvell/octeontx2/af/rvu_devlink.c        | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 6494a9ee2f0d..3b47ecb44d51 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1510,7 +1510,9 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
 	u16 max_nix0_lf, max_nix1_lf;
-	struct npc_mcam *mcam;
+	struct rvu_block *block;
+	int blkaddr = 0;
+	int free_lfs;
 	u64 cfg;
 
 	cfg = rvu_read64(rvu, BLKADDR_NIX0, NIX_AF_CONST2);
@@ -1518,14 +1520,23 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
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
 
 	if (max_nix0_lf && val.vu16 > max_nix0_lf) {
-- 
2.48.1


