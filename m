Return-Path: <netdev+bounces-299940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MjT9J6SeMWq/oQUAu9opvQ
	(envelope-from <netdev+bounces-299940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:06:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F5694BE1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:06:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=IPRSFJ2s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299940-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299940-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 571033271CAC
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F2F3DDDD5;
	Tue, 16 Jun 2026 19:00:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91480362149;
	Tue, 16 Jun 2026 19:00:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636447; cv=none; b=qHIdDggMS9Ibio/9ojHWMIAVus5+tMYSYzplNJMC6q46tcvsqTK1W6LMfeXF0yLrFKiWwYweDNX8CVOKkiDOX+PWFkiy4qagR1l11mXIQuknnh7pxJYtYgENXTEjG53OAltHgMy8O8XKGDjjpIcBMWp+KTzmz/uS9pnXhRAcE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636447; c=relaxed/simple;
	bh=GIy6PliBD4y+R8b6uO2g5XSkSc/3nMQi7P6B3FvBOXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDUh9c2InDWdj+cFcvA2BZrOIwOJcHxF3bEwYGSIEUiDeJK9rv0TJ9jNmUKQXDHmE5PIZ599pUhsbyG2MDBHFoK3ba5KYM3K727FGdQ3dv1i8fTB7Bw+wAcPu2pltWvr2ZaNWsBC9aRLAB0IXwC4LbvO7YLova8BRXgaAikDFZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IPRSFJ2s; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GIRuFM3433572;
	Tue, 16 Jun 2026 12:00:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=E4wuYy3vP4u2hYK1CCYuR6IyI
	uiVldv1KgZ/wsZ5Zvs=; b=IPRSFJ2sOuIeK5v081gHZveFajGFAaXnTM860qscm
	SCECInh5sPrM2UyFBeKyzKCEJgDKzyOCUs2E3RWOumrgqxIubz94pl4y3NPmoGck
	Evusrtv5mxYQka8i6t8LS2NUjkadzjJzi6ep2473uyByn229W2rKealSK5cLVDX9
	4Z1Ea9L0Cl2rW/Yt3xkyBuUBZ4VlXNlhmTdD4shMm5tFkLTcAuvyX2iV6Vpq979Y
	lL/K8BY8XimD2snlvC7lidAjyHDjRTNnCjgxQwiKGC4RRNcorA/RaTMS0jOenG+z
	4jrOtj4QfbyVFDClYLVl3+dsAKZx76FMBR1c4vdnTgJkQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eu9p7gqdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:00:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 12:00:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 12:00:31 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id A45543F7048;
	Tue, 16 Jun 2026 12:00:27 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>, <rkannoth@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [PATCH] octeontx2-pf: Clear stats of all resources when freeing resources
Date: Wed, 17 Jun 2026 00:30:19 +0530
Message-ID: <1781636420-19816-2-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1781636420-19816-1-git-send-email-sbhatta@marvell.com>
References: <1781636420-19816-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 7fL57m4u7vOuL8P1jvC0zgogW567puG8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MyBTYWx0ZWRfX7C8/jvCqgbPs
 nQNA/fVmAZ7WkGGHVztd6nbBrv00IBPcUTIzje2ZJBktp/zsPT5hLWG2V9YvvxV03FPL1Q5YJs4
 nwHyLm8xbi3QzI1M55oRTMhPBDzcQoo=
X-Proofpoint-ORIG-GUID: 7fL57m4u7vOuL8P1jvC0zgogW567puG8
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a319d50 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=xEhMEBUeZgw2hLcffmoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MyBTYWx0ZWRfX6MaY4AuoDi7S
 xwAgNCWj6Jvm5ShSd8Pwl3A7+DRFDWnW74qDhjKXHQ46fjxrm+NTBVK2dUaRNFKgRsi2j7N7LMU
 +ksJ55yrg/VZjVz4Ey+7MGXGXYDiAjd2vt5a1dOl/ZNnAzlqv52Ufe+1mGrWTQT6+VhV+1yoZam
 yE5/5qBz7aLgNl6XhdE53IDbJKbE2EwNxldJ6lPK66zrZVLuxLa5YcQHiwVcTeyh8Q5U19ULmJv
 NvJXaedskVqeFQFuX5RUTDanB0HOXqA20HgpRM69W1RBkVHpK0v/cG7/S4spkHlNT43Mf6x5xM5
 aNC3q0mWa80qweDbFXl4Q/c2xHxeF3b68gR1xIx6ahxUJYrnoX+0izJARIR079gavdq2CYwvDvs
 bFIlGvhnqFXGKJC3PDt+qWu2N94pWoGUnRWpGEq4lwPN8LufydkwB5ncbNCwlbjj5JBc+RPEmat
 hDxaglJaAFs1CLzJBhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299940-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F38F5694BE1

When all MCS resources mapped to a PF are being freed then clear
stats of all those resources too.

Fixes: 815debbbf7b5 ("octeontx2-pf: mcs: Clear stats before freeing resource")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 4d3a7f4be962..9524d38f1582 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -182,6 +182,7 @@ static void cn10k_mcs_free_rsrc(struct otx2_nic *pfvf, enum mcs_direction dir,
 	clear_req->id = hw_rsrc_id;
 	clear_req->type = type;
 	clear_req->dir = dir;
+	clear_req->all = all;
 
 	req = otx2_mbox_alloc_msg_mcs_free_resources(mbox);
 	if (!req)
-- 
2.48.1


