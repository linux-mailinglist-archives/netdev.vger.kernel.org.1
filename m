Return-Path: <netdev+bounces-251763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBssNfNLcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:45:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A13F2508AA
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF7DF5E1B85
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6D358D3E;
	Wed, 21 Jan 2026 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Jdgr6DfI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D517A300;
	Wed, 21 Jan 2026 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966813; cv=none; b=r2H56/yjYozfyhdSs5SlS28Z+hiy/in+e11RXJpTfsjmpNKOZsZbuqy2GKPridmx220fyiSNuCQa2WKB48COTTD316PH7kGie6/FPpHfavT5HcgPoMYx1w0jioG0x471Pm4kNpBdeBNyC+yJdFT3e/sF9yye0/Yed0VUMotVwE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966813; c=relaxed/simple;
	bh=aKOcTZLADCkJZN5mIhBNx70TqafieIXhVm252+suLfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d+EUhbt26lommS6y7U/nGtYUFAvdxsZX50lpDKAYtVgKf8TGA2Eh/6MqmQuCZ779MWLKGGPfNQ5KbER4hPS7cFj+OBFrv4A+oVGpZjc/DHENR8GM9SVibWAeUSko6cgTzoVhLcDhQYh1qb47bZT+rGnHm7lodR6ksLAXYI1MeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Jdgr6DfI; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L0FNVM483754;
	Tue, 20 Jan 2026 19:39:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=yStS11VMC4uC8GzoTOz/40n
	4LTtScVSijY+6GzHiJeU=; b=Jdgr6DfIqwm8xdxoi/1ZneUOgoC6feHTcDa48Ty
	v5MlLq/wH6QiuWCEAlp6G27mdFlCgYl9K8Dlk0TxUDEjKGdRtbrK+96e1PdefxLr
	JJaQ71iOGG3/iAETeQQMbN1w508lURCsr+qM2NoKqdV00rVB63Rb3BPL+CtupLHG
	erqn/dca5XlkOp2RLXoTcx85udZxa2njO571S2X+70AwkQGlM+OG8U8cd4rjx710
	xQAtKlHuqN2B/YqkghkBaFyDc/GGn7DjkcPqYjB5Os/+Bl0F8WXgj9bmcHf0BJIj
	8TK9RhhJJARJWeKvkPpTikMEugbbLLktpS2PWhs391iOM7g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4btm3jrawy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 19:39:54 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 Jan 2026 19:40:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 20 Jan 2026 19:40:07 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 961313F7082;
	Tue, 20 Jan 2026 19:39:49 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net v2] octeontx2-af: Fix error handling
Date: Wed, 21 Jan 2026 09:09:34 +0530
Message-ID: <20260121033934.1900761-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=EqLfbCcA c=1 sm=1 tr=0 ts=69704a8a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=8cN1D9mWTfhImOw0RpUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: D9BHer66b8YiUCJcaOdJriapEkCBXTTO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAyNyBTYWx0ZWRfX+s5QcvFyWr3O
 b+aExjJDF3Z0pAZ8s9KjxJGZMjpBwzO+1NTg24ACmmnCfwAa0/VS8R2V0BQRSUlkCUy4hFFZFww
 2RtdFsa0S9rR4Y96SgGEdquqBC+Nt7ZnHNDY2zpzZ78M+Gg0uaaFTx0UCd+/WPa0pXE22HTO31H
 tkS6Y65MEadHZPwoRvTwOJAMF/i4eFTTCblTa/+hN9tVMjZgkLLT7qB2nzIisduGh5THrOwUzM3
 auA330iFzkb1k20cHEjnHpEQEwGEugF2uY5RE2zBfMaPnaMkycB/KtVlwGfpJSotQ7wKkKCHjLL
 1PL0mg8f1gYIU/dmZ+Q0Fdwzl2dOkSeNurBFKpP0WSZs/5qTkxu5na79M5b5YCtb94GHHK+Hpr3
 3YaTcD1xn78I1+W79tQ9y4Y7dPelb5biKHghr8wCbdF26iBdd5ecnMcqEa0p5cES1HyddUTyThO
 HqM26m3gc5o7xQqGoNw==
X-Proofpoint-GUID: D9BHer66b8YiUCJcaOdJriapEkCBXTTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[marvell.com,none];
	TAGGED_FROM(0.00)[bounces-251763-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A13F2508AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This commit adds error handling and rollback logic to
rvu_mbox_handler_attach_resources() to properly clean up partially
attached resources when rvu_attach_block() fails.

Fixes: 746ea74241fa0 ("octeontx2-af: Add RVU block LF provisioning support")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
ChangeLog:
v1 -> v2: Fix AI reviews
---
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 86 ++++++++++++++-----
 1 file changed, 64 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 2d78e08f985f..747fbdf2a908 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1551,8 +1551,8 @@ static int rvu_get_attach_blkaddr(struct rvu *rvu, int blktype,
 	return -ENODEV;
 }
 
-static void rvu_attach_block(struct rvu *rvu, int pcifunc, int blktype,
-			     int num_lfs, struct rsrc_attach *attach)
+static int rvu_attach_block(struct rvu *rvu, int pcifunc, int blktype,
+			    int num_lfs, struct rsrc_attach *attach)
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
 	struct rvu_hwinfo *hw = rvu->hw;
@@ -1562,21 +1562,21 @@ static void rvu_attach_block(struct rvu *rvu, int pcifunc, int blktype,
 	u64 cfg;
 
 	if (!num_lfs)
-		return;
+		return -EINVAL;
 
 	blkaddr = rvu_get_attach_blkaddr(rvu, blktype, pcifunc, attach);
 	if (blkaddr < 0)
-		return;
+		return -EFAULT;
 
 	block = &hw->block[blkaddr];
 	if (!block->lf.bmap)
-		return;
+		return -ESRCH;
 
 	for (slot = 0; slot < num_lfs; slot++) {
 		/* Allocate the resource */
 		lf = rvu_alloc_rsrc(&block->lf);
 		if (lf < 0)
-			return;
+			return -EFAULT;
 
 		cfg = (1ULL << 63) | (pcifunc << 8) | slot;
 		rvu_write64(rvu, blkaddr, block->lfcfg_reg |
@@ -1587,6 +1587,8 @@ static void rvu_attach_block(struct rvu *rvu, int pcifunc, int blktype,
 		/* Set start MSIX vector for this LF within this PF/VF */
 		rvu_set_msix_offset(rvu, pfvf, block, lf);
 	}
+
+	return 0;
 }
 
 static int rvu_check_rsrc_availability(struct rvu *rvu,
@@ -1724,22 +1726,31 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
 	int err;
 
 	/* If first request, detach all existing attached resources */
-	if (!attach->modify)
-		rvu_detach_rsrcs(rvu, NULL, pcifunc);
+	if (!attach->modify) {
+		err = rvu_detach_rsrcs(rvu, NULL, pcifunc);
+		if (err)
+			return err;
+	}
 
 	mutex_lock(&rvu->rsrc_lock);
 
 	/* Check if the request can be accommodated */
 	err = rvu_check_rsrc_availability(rvu, attach, pcifunc);
 	if (err)
-		goto exit;
+		goto fail1;
 
 	/* Now attach the requested resources */
-	if (attach->npalf)
-		rvu_attach_block(rvu, pcifunc, BLKTYPE_NPA, 1, attach);
+	if (attach->npalf) {
+		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_NPA, 1, attach);
+		if (err)
+			goto fail1;
+	}
 
-	if (attach->nixlf)
-		rvu_attach_block(rvu, pcifunc, BLKTYPE_NIX, 1, attach);
+	if (attach->nixlf) {
+		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_NIX, 1, attach);
+		if (err)
+			goto fail2;
+	}
 
 	if (attach->sso) {
 		/* RVU func doesn't know which exact LF or slot is attached
@@ -1749,33 +1760,64 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
 		 */
 		if (attach->modify)
 			rvu_detach_block(rvu, pcifunc, BLKTYPE_SSO);
-		rvu_attach_block(rvu, pcifunc, BLKTYPE_SSO,
-				 attach->sso, attach);
+		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_SSO,
+				       attach->sso, attach);
+		if (err)
+			goto fail3;
 	}
 
 	if (attach->ssow) {
 		if (attach->modify)
 			rvu_detach_block(rvu, pcifunc, BLKTYPE_SSOW);
-		rvu_attach_block(rvu, pcifunc, BLKTYPE_SSOW,
-				 attach->ssow, attach);
+		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_SSOW,
+				       attach->ssow, attach);
+		if (err)
+			goto fail4;
 	}
 
 	if (attach->timlfs) {
 		if (attach->modify)
 			rvu_detach_block(rvu, pcifunc, BLKTYPE_TIM);
-		rvu_attach_block(rvu, pcifunc, BLKTYPE_TIM,
-				 attach->timlfs, attach);
+		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_TIM,
+				       attach->timlfs, attach);
+		if (err)
+			goto fail5;
 	}
 
 	if (attach->cptlfs) {
 		if (attach->modify &&
 		    rvu_attach_from_same_block(rvu, BLKTYPE_CPT, attach))
 			rvu_detach_block(rvu, pcifunc, BLKTYPE_CPT);
-		rvu_attach_block(rvu, pcifunc, BLKTYPE_CPT,
-				 attach->cptlfs, attach);
+		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_CPT,
+				       attach->cptlfs, attach);
+		if (err)
+			goto fail6;
 	}
 
-exit:
+	mutex_unlock(&rvu->rsrc_lock);
+	return 0;
+
+fail6:
+	if (attach->timlfs)
+		rvu_detach_block(rvu, pcifunc, BLKTYPE_TIM);
+
+fail5:
+	if (attach->ssow)
+		rvu_detach_block(rvu, pcifunc, BLKTYPE_SSOW);
+
+fail4:
+	if (attach->sso)
+		rvu_detach_block(rvu, pcifunc, BLKTYPE_SSO);
+
+fail3:
+	if (attach->nixlf)
+		rvu_detach_block(rvu, pcifunc, BLKTYPE_NIX);
+
+fail2:
+	if (attach->npalf)
+		rvu_detach_block(rvu, pcifunc, BLKTYPE_NPA);
+
+fail1:
 	mutex_unlock(&rvu->rsrc_lock);
 	return err;
 }
-- 
2.43.0


