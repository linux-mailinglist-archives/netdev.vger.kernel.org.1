Return-Path: <netdev+bounces-293095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDyXLL56GWr3wwgAu9opvQ
	(envelope-from <netdev+bounces-293095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:38:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3494D601B80
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD8803025A60
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA783D7D8F;
	Fri, 29 May 2026 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hNdfFQpJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8AD3D6CDE;
	Fri, 29 May 2026 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054672; cv=none; b=hBmIXUzRhjviZ87YRVv2ghpu/KfjKuhcfZxIS/dXhSo/l88AkFCORWYTpe1eCUfseVsbDpGSgvXnsHW6av8StIrPM+Iq1+zvR38nZH9tJ4bFDHoDt/q+2jm3JaSUfdQEH9m00qPhV2kdlK8KAVv9O0bt230ADFPUiz2wn+DYzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054672; c=relaxed/simple;
	bh=wBWH3ZUI0xb8L/HK5p9ri9zWGFCagjd+ayCdvt5QO1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F7fBI103SZ7/tyvjDbtRhq3NSX02Q+cIKtWSH4RFjdB6T+U9g86AonVwL7HuiNutRZBHQFQLbCFHbd+hoo1GglnWMP4mwr6nOmQSEo1mxzPCOqK5F1dgDwiab+9KHo0qXCWxjGKc5fExUE0DTa2yF5fOHVu3iQbRv1fTcrQCUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hNdfFQpJ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6WmLh3252248;
	Fri, 29 May 2026 04:37:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=XP5Ovn0G5marqPxS9bVSt1H2qRXmDhQ0A3sAHXl1jaU=; b=hNd
	fFQpJVCp5hpY0HP2AE1ApcNKkEanKNiMImbOzlOqJlA4xgxTxIu4XSAOiKrxXKdY
	1/BZiYgrmlxaeNWF9L2mZ5nAaD2WkrFrBkkmBKcm0gqAIzTyT2K7pAkE9QliyoUc
	hBnE7sKr4TKgtUzeCw5rJfof/30Jf/oT+7ZSFMOa7C9+T/SiRlOPmb4cympGrL7+
	wQpsHSlVG3mOeGConP6EX8CmzoEKYVWLhGufRa722RpywOqAaqqOJfYa8hXRJh6U
	yXxTeoDSgZjNN3RcwDIOIZ/bR4UlRGzJyMRWyNGFZqUkT2W9X3aeP5de+e+6Rxv1
	tLT6ec9vlc71nkZAtgg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eeud7axqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 04:37:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 29 May 2026 04:37:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 29 May 2026 04:37:30 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 01B0E3F705F;
	Fri, 29 May 2026 04:37:26 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [PATCH net] octeontx2-af: Validate NIX maximum LFs correctly
Date: Fri, 29 May 2026 17:07:25 +0530
Message-ID: <1780054645-17142-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDExNSBTYWx0ZWRfXxD7ZV71jkm1y
 QNbdbZuXPA7WKwo1imkclHDXlba0Ts9A0r48iqoPX0j4WWvNTKOO7W85/fR/oX+A2lmXv6kpkGD
 9Hlr35Upqm4aQ8TEEi1lgjjFV5+Tomu9yLa71AnKg2yE4W2GpihgblMgfeSeZhML3+yfGhI0MfS
 cCmSTHQ+r3rkEgvvGY+ivHMrgNOnQw6Pz1K6/lKPwSruViJuSp1RsGuWMLzMBmUqs68JJ013+By
 c17GZZz2DnOtJ312effBiYnZcdNCTdlTIuJkvkSnSNYRPQ4SigymolFma2ghDpy/IqcglbV6g4h
 b933myBzRYTZomukTD76qcJS194nWd5/vKp0m0ob6If+nB9FDFyM6+cLyeaDEwtfx/PXErSij3H
 i48zLN6Nk1EFoITVVHg1nTdE5cxSSxQhEFAipl8m1A2JJsEca+O7ioQGm2IZDpwtTAE8ZDomGCR
 lcGU0pLhzTZ4EgUA2TQ==
X-Proofpoint-ORIG-GUID: kq97JyHldkVw3FTZb2MeiUlDvRSUhAAe
X-Proofpoint-GUID: kq97JyHldkVw3FTZb2MeiUlDvRSUhAAe
X-Authority-Analysis: v=2.4 cv=ApLeGu9P c=1 sm=1 tr=0 ts=6a197a7b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=_iAZQAUI9C_cJxmoXsgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293095-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3494D601B80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NIX maximum number of LFs can be set via devlink command
but that can be done before assigning any LFs to a PF/VF.
The condition used to check whether any LFs are assigned is
incorrect. This patch fixes that condition.

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../marvell/octeontx2/af/rvu_devlink.c        | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 6494a9ee2f0d..8ba4b5ba9d2c 100644
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
@@ -1521,11 +1523,18 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
 	/* Do not allow user to modify maximum NIX LFs while mcam entries
 	 * have already been assigned.
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
+					   "mcam entries have already been assigned, can't resize");
+			return -EPERM;
+		}
+
+		blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
 	}
 
 	if (max_nix0_lf && val.vu16 > max_nix0_lf) {
-- 
2.48.1


