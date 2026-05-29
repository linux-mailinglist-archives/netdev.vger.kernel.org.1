Return-Path: <netdev+bounces-293096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL59HbJ6GWr3wwgAu9opvQ
	(envelope-from <netdev+bounces-293096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:38:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CA6601B6A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0AD530207F0
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8483D75C7;
	Fri, 29 May 2026 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EGZ+PAy/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE7D3D9053;
	Fri, 29 May 2026 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054676; cv=none; b=F6HDxKNO88BTunX1p4O4bUxZxcAx+KtSj1ZUNXwNxHeX/5rg/rW6495DasIJBSHwh2UecTOIvZYO9J7FgXaIz07nFZR5xwBDywBURDva/fvDz5U9JttMYA6NmvU5WX9vVWwQU941VU+0TxQJcq7TEiA4suGWvEmgeyLrybV0n2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054676; c=relaxed/simple;
	bh=TEbwrGU2wAn4G2vQzf5i50fbVJAipq/Y6JZLdjfLhiU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=knKLwEPkZSLVepRyKEzv2c3xb+iW1Mz/WDIMpdVZIwSrTmp5Hvlmg66IybFZaY2ynkCbEURsgsUm0pw8vluL8NKeHPC1vuMM1zSs/io5PhILp2dRJn6BuzqmnxFqupfHQghoLgVjLKhZR8d3Pf4Qndc4uUQ2ptlWmGlN8mehQlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EGZ+PAy/; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6fxkg3253235;
	Fri, 29 May 2026 04:37:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=k9Tmzwgjsu09NIRPcTlZyp/5GTY8ObhjgF4cyoxNbeo=; b=EGZ
	+PAy/vUGZjb6zWT9qDf69R24mtj9n+a5xHZO/bVVbj9DVbKOsJw37EdrVu+H2ER8
	IeFDoY0LAeoKUgwSTFUUtJW7rGC1MVRNJ3+wHydAOCmle1fsuNkAautlMNT54bx4
	fRCQcjQKsU3Wg1ddX6xfZnfTJdquiU8kRVNcZL7OmDjIRJEpJkGoNcHbo0KOJkj6
	OrvZTCr8MKlpmYLgFtndqFs7NC4qaHpkVWqBHsmu0XaM0gc2bPcUU2UgnnwwTKri
	hyoe3wq07pQj1PQXU6Tf3KZBf0xwPZBOuLlYjj0TPFt3zcHaDfqQaZGNXxWzTlui
	hgkL02kWX6Uyj4bUZzg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eeud7axr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 04:37:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 29 May 2026 04:37:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 29 May 2026 04:37:47 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 199573F705F;
	Fri, 29 May 2026 04:37:42 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [PATCH net] octeontx2-af: mcs: Fix unsupported secy stats read
Date: Fri, 29 May 2026 17:07:41 +0530
Message-ID: <1780054661-17194-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDExNSBTYWx0ZWRfX9n4zm79B1JCZ
 G33kFwBTrtGHYXDiwE3lKlHwkNWpEGuf4nC9zgvcyM1puMDEzEp4qTAxMhj5O8VtT5YlphqtChg
 +TsmTLp3geI2PlRGzi03doXO0XH3qmIACFiakZbJqCbxZ8bAP1Aq+PMRtv+vT3AmkrdAZaasb6P
 8VP0QEZ3lyNjMVfvOYfET6R+iCTNONiCP0AHeI+4wWGz61upNoffMMkSnd3yVTsL0Tw7Uoz2K/9
 BmLpHAPR/Y6ebPO9dH7udaZEieqtW0BW6sKWov9z0MzOZ8YN3e0hcynu6S8+HFxNMATpKX0KZQC
 GiX6QEzP5W9HcyrXMTxqLGcZX+GcWIIjzPRSMCRbEXsfw39YeIBM6W0+HWJYIXcDL+emJqtrQ0h
 5rMGfVGZ1U5KEE7Si5NR8r3X8C85KTpt0AhRLC+f0xwhDJUy/hCDEsgnUbqLxnB3O9hILWrXgWn
 B9mTRP4dQc76Z30C5cg==
X-Proofpoint-ORIG-GUID: tWOV7fhihQ-pX_HTrE0z1YuWi1Yp5hSF
X-Proofpoint-GUID: tWOV7fhihQ-pX_HTrE0z1YuWi1Yp5hSF
X-Authority-Analysis: v=2.4 cv=ApLeGu9P c=1 sm=1 tr=0 ts=6a197a8c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=eiSVTP9ZytZqG4kkt4QA:9
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293096-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 75CA6601B6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Geetha sowjanya <gakula@marvell.com>

Secy control stats counter doesn't exist for CNF10KB platform.
Skip reading this respective register for CNF10KB silicon while
fetching secy stats.

Fixes: 9312150af8da ("octeontx2-af: cn10k: mcs: Support for stats collection")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
index c1775bd01c2b..a07e0b3d8d00 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
@@ -120,13 +120,13 @@ void mcs_get_rx_secy_stats(struct mcs *mcs, struct mcs_secy_stats *stats, int id
 	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(id);
 	stats->pkt_untaged_cnt = mcs_reg_read(mcs, reg);
 
-	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(id);
-	stats->pkt_ctl_cnt = mcs_reg_read(mcs, reg);
-
 	if (mcs->hw->mcs_blks > 1) {
 		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYNOTAGX(id);
 		stats->pkt_notag_cnt = mcs_reg_read(mcs, reg);
+		return;
 	}
+	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(id);
+	stats->pkt_ctl_cnt = mcs_reg_read(mcs, reg);
 }
 
 void mcs_get_flowid_stats(struct mcs *mcs, struct mcs_flowid_stats *stats,
-- 
2.48.1


