Return-Path: <netdev+bounces-293097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC0jEcd6GWr3wwgAu9opvQ
	(envelope-from <netdev+bounces-293097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:38:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 537D2601B87
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D437F301906B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E103D7D9D;
	Fri, 29 May 2026 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="esQgCBvu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFC3D8115;
	Fri, 29 May 2026 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054693; cv=none; b=hhF7107xhW4dX7C+ATh1k4JsQOTuETb8yDoRwLopJbmiQ9Dcml537FIkQhjVUFQWSl5nZIKBbaMbGntMHPhFHPKmYYh9HlPDyPJOTMB5LL4Fdib5jrsFdDr0eYvLtl4maUC6W3JvJmPKDXca2GRe26cmgWCs+471lMOa0LvQvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054693; c=relaxed/simple;
	bh=JkhL1w6iENuXUSl0yVpL58S5lnZSo+6IcDBeFsZae8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DUkaGcrU6gxd2shtILCB3VSVgHikLdJtCCWhDNLHJZ/HByo0OHXeNND3sVz1Gj9SuHysqOMqIpx2A1fGccJu5wckAMdCP8U3oAqyNQdtUuwpVxEqH+7m4d6U9YiVyeT3NvgKCRFAvPMsNgImMOR6WHikl+XmZd63ryhVOTnEP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=esQgCBvu; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6hFTf3253295;
	Fri, 29 May 2026 04:38:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=t5SJpklHxAB3o5rFgA1qFNq+Qu33AMgEFHPOx3Pwxxg=; b=esQ
	gCBvuqig8QbD+ak0cTPXxK6Mh7jo/vUxPNRwyLrTceH1Yy6NTs6qhwCknPCYEpDz
	XhnJBvWVnnMd227esYuHDo+s85+hM98bRThBo1/3WAn1TktccKDsXrEGcpNUWl98
	uLsEF40mefa8laer5cS/XEns7+1RixE0Q/0JjU1cMkavRh7sTYH/zZXYmokds/pZ
	4bcw/WVTp92m4UxZJr/GlgC1UaWIxIh9t1rqBoJXop5Hh0xC5YNSAeswnQu1/gxw
	tRTQwXplhWmBvz+Mv8N3KFruXZPclZCehLpqovGs8HROfdik4JNHWX0ikHHDxjMN
	dqjhTzd++IW287hQEDw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eeud7axrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 04:38:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 29 May 2026 04:38:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 29 May 2026 04:38:03 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 76D533F705F;
	Fri, 29 May 2026 04:37:59 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [PATCH net] octeontx2-pf: Fix NDC sync operation errors
Date: Fri, 29 May 2026 17:07:57 +0530
Message-ID: <1780054677-17249-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDExNiBTYWx0ZWRfXw2Y8X5OBuawl
 WwLR6nbJyPv6OC2KvyCoN8p3g/+xe1iKMsYvUCR399/2nApD/xm0TFdQM0x9kq8fyXmJjFQCr58
 7kYS0MibQRobWAWJ4BWmg4eN3dYl/gHL/1Mr2OUoZwVlgtXbR5YsMk1NxdMxjMPaPIvbj2+gHBo
 tjggSb8D951rdrS9+NiMozdDgYoAdlYiiZzyZvQHpX1TXKcl930iKI3In8fOR6PV9E76zoom1ky
 6gc0wqwvUnh0n9A3pCc95I9duF4FCScdlxPaI66EAg/rSBsj9kobmsVc4ukRav6PvzRzxOsinOd
 zDCK5aCni/HMRH9NB9zcYWqC3n7hApa/mv+bgkesq6Kgq4ChqMp4oJjH3nVZFPVkZSLMli/m6yN
 fwXvKq3kIQugtPxwElg9dVEqdadRg0YsF/HfXOoonUBcTJWXGADYnyKPVEEQj1tSbaOxka6lWn3
 uDN8PJkVYppf2rfV6MA==
X-Proofpoint-ORIG-GUID: la4Um883XxCkz_jbAyzYzkq2LoD4v85V
X-Proofpoint-GUID: la4Um883XxCkz_jbAyzYzkq2LoD4v85V
X-Authority-Analysis: v=2.4 cv=ApLeGu9P c=1 sm=1 tr=0 ts=6a197a9c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=3jbiP4eJcJXSsgJETLEA:9
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293097-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 537D2601B87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Geetha sowjanya <gakula@marvell.com>

On system reboot "rvu_nicpf 0002:03:00.0: NDC sync operation failed"
error messages are shown, even if the operations is successful.
This is due to wrong if error check in ndc_syc() function.

Fixes: 42c45ac1419c ("octeontx2-af: Sync NIX and NPA contexts from NDC to LLC/DRAM")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ee623476e5ff..f9fbf0c17648 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3473,7 +3473,7 @@ static void otx2_ndc_sync(struct otx2_nic *pf)
 	req->nix_lf_rx_sync = 1;
 	req->npa_lf_sync = 1;
 
-	if (!otx2_sync_mbox_msg(mbox))
+	if (otx2_sync_mbox_msg(mbox))
 		dev_err(pf->dev, "NDC sync operation failed\n");
 
 	mutex_unlock(&mbox->lock);
-- 
2.48.1


