Return-Path: <netdev+bounces-299938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eTVpL5WeMWq6oQUAu9opvQ
	(envelope-from <netdev+bounces-299938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:05:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B8B694BD6
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:05:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=eM0uS4uv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299938-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299938-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7259326987A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24263644AF;
	Tue, 16 Jun 2026 19:00:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F62318EDA;
	Tue, 16 Jun 2026 19:00:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636447; cv=none; b=s0hg9R9tMUGa8Kxc4rbu+biJWmb/aUUh5abOpgI1eJZzSfyijqCN+uhHgeqAT+JP0NGbBo+KY/byf5E7JkaOAHqkw9HeqRRAHLkp7Ec0k6mTPCGXuOAqvbe11kWi0EHniGZvhKaiVAGm9WjGmPZIdVhVhQ548tWeu9Dc5PzI35U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636447; c=relaxed/simple;
	bh=9zauKfd9oMsCKcEZ6eUaZtCHNQadiZAVA7ORXQdY+/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdbbCp4OrQNYkZx5JomtqfIWVbHDACG+uGSfGBNKOnkgNImBfyC3c1gFNGnwtNkomgQ/ooqcvHJynzsnPkVBdIkbC14G+K8TMlHFVK9OaRZw8cL2maMmePMuz/fs5XvRBnDjez2bZtb1I/uyeUy249Q+UjfacaFj0RkV8O74jPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eM0uS4uv; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GISO8Z3375474;
	Tue, 16 Jun 2026 12:00:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=2aVRr/bPvNmfWYUZAinz1L3Uz
	wOSbEM/AR7QGk4sb3U=; b=eM0uS4uv0oRCaTroeq+iQ/ALpYdsVqXGCmJxQlByK
	9ulvAMXrR2aNJpyXdsprmY3wrutsVGlNzFKv4OFIiG2fzoIFl/tzkBPIKFXHh0tL
	Ssu45S6Q/03usiWBl4kYwgnzGOViz9a1bnhKnZ6XC9VF2sFd01kQNq1fuQuQ9Xh+
	t3rxGDdY2KNaGSnOShJvBPjcfKfind17V/NXU2y5fkJi9Ae7VzJ4w/DaPch5WQHZ
	cPdDsswiz9lTsopEWYkRU/sw770CABMeda4RMNAjNz/oMVoDf6MImWnA+hl3MSQc
	3oCpz2fvsVF9SXHpWyeJ62mb/9AbXkTzwAMq2JCg//tKA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4etu38m5gu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:00:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 12:00:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 12:00:35 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id E008E3F7048;
	Tue, 16 Jun 2026 12:00:31 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>, <rkannoth@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net PATCH v2] octeontx2-pf: mcs: Fix mcs resources free on PF shutdown
Date: Wed, 17 Jun 2026 00:30:20 +0530
Message-ID: <1781636420-19816-3-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-GUID: _9O7P8tW9pcMG5N0c5IRyp8fVsq8r8CF
X-Proofpoint-ORIG-GUID: _9O7P8tW9pcMG5N0c5IRyp8fVsq8r8CF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MyBTYWx0ZWRfX8lGo+MvqWDEk
 6N3wxgjlVBaKesLBQSwSr7Rwp2KgR5W35+6Fy8f+yo6MORxu/6IrGr5b/WNKVMtss1G4Fp6AXmI
 t50JbPYTag5lUZLa9ijxc4b9EcWkOg8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MyBTYWx0ZWRfX6h9tk+tpfe6G
 mPmd+xd9LdQ3IteY77eSaP+l655oHcInOYfFxjTNOvnF/3PXA3FoorruRiZanBkic1BjmTyZAW2
 AoLK4wYj+3cgqYoBSs41yyuBmRzeQMcT+B4alo7r415r6conLq3Q4Cd0L7xsX4jgbxQNq4IAcEB
 DChgKX8dmaVSUjGS/Pu5m1HnrdY7iPdgj0wK8WhH54mcHYsqkjE83Lcdd9Dw2A935KswhtzzGrY
 qqT9Ia0SOaRNVTwC8QkiRbOo2gUJFgVBq2Rm/eOooLPMk/RNaByHS4bFFRGhK3xyMkg0Jk9+/vU
 /4O8HauejsypMJOM/xBCBzbToBO20U/DRiE3OxGBBwGpaOaIOY2KaBP/+KN+PgRj9QvruvnRg/m
 FnfdphEAXfuraCjaNWivsYt7dSjZs09/ncGILtLyFA0TJnnTmBYMb5xMM59AAJG9nfBhK7V2hr2
 qVTWOCw7QmGOpvUjutA==
X-Authority-Analysis: v=2.4 cv=SeXHsPRu c=1 sm=1 tr=0 ts=6a319d54 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=NPitHzPN1ilE7Q4tvNMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299938-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40B8B694BD6

From: Geetha sowjanya <gakula@marvell.com>

On PF shutdown, the current driver free mcs hardware
resources though mcs resources are not allocated to it.
This patch checks the mcs resources status and if resources
are allocated then only sends mailbox message to free them.

Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v2 changes:
 Fixed AI review so that pfvf->macsec_cfg is freed correctly

 .../net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 2cc1bdfd9b2e..4d3a7f4be962 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -1776,11 +1776,16 @@ int cn10k_mcs_init(struct otx2_nic *pfvf)
 
 void cn10k_mcs_free(struct otx2_nic *pfvf)
 {
+	struct cn10k_mcs_cfg *cfg = pfvf->macsec_cfg;
+
 	if (!test_bit(CN10K_HW_MACSEC, &pfvf->hw.cap_flag))
 		return;
 
-	cn10k_mcs_free_rsrc(pfvf, MCS_TX, MCS_RSRC_TYPE_SECY, 0, true);
-	cn10k_mcs_free_rsrc(pfvf, MCS_RX, MCS_RSRC_TYPE_SECY, 0, true);
+	if (!list_empty(&cfg->txsc_list)) {
+		cn10k_mcs_free_rsrc(pfvf, MCS_TX, MCS_RSRC_TYPE_SECY, 0, true);
+		cn10k_mcs_free_rsrc(pfvf, MCS_RX, MCS_RSRC_TYPE_SECY, 0, true);
+	}
+
 	kfree(pfvf->macsec_cfg);
 	pfvf->macsec_cfg = NULL;
 }
-- 
2.48.1


