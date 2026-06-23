Return-Path: <netdev+bounces-301258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9iUqHRIHOmoc0QcAu9opvQ
	(envelope-from <netdev+bounces-301258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 06:09:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9C46B3F58
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 06:09:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=j27m4GWq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301258-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301258-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 553F23052E56
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 04:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D423A39BFFA;
	Tue, 23 Jun 2026 04:06:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D7939AD25;
	Tue, 23 Jun 2026 04:06:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187615; cv=none; b=TDrrdN7Idwy08YiU1lFck0S4WsPqyXNodQlygiQj+LUtByptrrKBRwXVmXhqHwrLMmwX06KQfpFndOlHUOzWamkvxXJDnH437wlRp3UxCOkP61lM6tBXuZNMPSBX9oP49y5XWzeYT+JTo9TkF6d617zoAY5/bCgTYCVan2B+LZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187615; c=relaxed/simple;
	bh=HlEDlPEgNiBf0/iFAhX+UDCIIQSnEDBvvj+jHhLEeVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrqMb8U3nzYu8zMa37UFRIp2sl6McGZMc6tx0NrvCXoQC1rQS2zYBwQo79yj6M0h1YtGd6mjdwhlEeDdXm+FvL5ecgZH0ShvByQQnhlQ7Zl0ChNvwxNNoi+a7Rr2VEOxvZCkJ5pLlpVhlf/7hL2Mb9vQY1wxe00IMN66NPFpGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=j27m4GWq; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0gVbB4058880;
	Mon, 22 Jun 2026 21:06:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	6tiWUARTEAHNGSanEy1YM1KtlSlrgJBmConQO5urt4=; b=j27m4GWqhbqJdlcaF
	KYlBV5pp3cYlgUEaZth1Qa3qhcrJ0aPmHjnacIYIEbgyPZpBoadH7RpkxGBx5+cO
	XLNRgels1Mohnyxr5SiO4nhk8x9SMFRYpnqtczios1EB/BimVIFnRabwm39XRxVC
	Dj8Mv7GIy0JFkeKB7L7OT7OM9wuI7O8bhftrkAU57zJht8nI5PfdHfOLIjF//Nnj
	n8rNmIhvi5Zq0XGy/67dPrd8tYhzPT/tLoVhVRa1stV3Y6+O72jD98c61KGaxodm
	qZLEz6PwelkNHsQe929I6+cT+zM/HQjytu+sjAbY0Rp+lu0itxiSINPwEaqNuqUg
	vEuyQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ewr7hg55p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 21:06:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 22 Jun 2026 21:06:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 22 Jun 2026 21:06:32 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 892BD3F705B;
	Mon, 22 Jun 2026 21:06:27 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <rkannoth@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <Sunil.Goutham@marvell.com>,
        <naveenm@marvell.com>, <hkalra@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>
Subject: [PATCH net v2 2/2] octeontx2-af: suppress kpu profile loading warning
Date: Tue, 23 Jun 2026 09:36:09 +0530
Message-ID: <20260623040609.3090846-3-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260623040609.3090846-1-nshettyj@marvell.com>
References: <20260623040609.3090846-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAyOSBTYWx0ZWRfX0WxwncPafqm9
 TbCfOztOFibza79leFQNGr5c2vAI9EOtQM5Qz1PC3wPF9j4ZWZ1dUyo5t/5tu5CQ10zyBzAShK/
 0LCG5mDW2TPGeaappvNnsYeixm02X0HzOvUvXaEgcbTcvLucSAK/1traksbVq1CG4al/Uw5sZNi
 XSl0Drgax5H+Y/YBZ2fOE66RFqcH+XK4nd49GzdZV+1MzEmsN0BKcGed2BNLQzCtvCStyTMzthD
 f9c3U+Wv7HDVAHXtQ/+F2LUO4No9X1lPNRSuv2aEd3pdLqr/JZF4bpx2DHTlsiLieI5x0pxgCEY
 RPZZ8Qpi+irXqrWNPM/hVC+st/Z1baG8HruzCu54YFBgsdIxIeJtrJa9yacAH3QV7Ho2czhPqD6
 trfji+Ha3eOYl5ePJsHvGgYyDvkD81L6iFBksPJ1uFkL5ZmpRFdRsY4uvfVzL5+DjSwjWoLvwUm
 PqjmH5/caRalhgA3QbQ==
X-Proofpoint-ORIG-GUID: JaLPedsJTU1dA36pzSxBB--zaYQsdLeV
X-Authority-Analysis: v=2.4 cv=aJTAb79m c=1 sm=1 tr=0 ts=6a3a064a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=0oH1JDAyb3HKMfM1TsUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAyOSBTYWx0ZWRfX/3nlapd2gkfx
 aQB0Fn04j4xjaNur3iDpG64Ot8MVOXRIitqWYYcMGK3UgWLfV+U/pCS9lP6WnzOVRH0qP4ix+/4
 7INm6Xxt1AbrOo+RarDGOr9ynmd4beA=
X-Proofpoint-GUID: 8bMca-nk26YS3bd8d-3KOMHvHCahSC8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301258-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Sunil.Goutham@marvell.com,m:naveenm@marvell.com,m:hkalra@marvell.com,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE9C46B3F58

From: Harman Kalra <hkalra@marvell.com>

There are three ways in which a KPU profile can be loaded
(in high to low priority order):
1. profile image integrated in kernel image
2. firmware database method
3. default profile

In most cases the profile is loaded using the 2nd method, which
causes a spurious warning from the Linux firmware subsystem (method 1)
due to the absence of firmware in the kernel image.

Replace request_firmware_direct() with firmware_request_nowarn() to
suppress such warnings when no image is integrated into the kernel image.

Fixes: c0c9ac88156a ("octeontx2-af: npc: Support for custom KPU profile from filesystem")
Signed-off-by: Harman Kalra <hkalra@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c7bc0b3a29b9..007d3f22b0c9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2246,7 +2246,7 @@ static int npc_load_kpu_profile_from_fs(struct rvu *rvu)
 
 	strcat(path, kpu_profile);
 
-	if (request_firmware_direct(&fw, path, rvu->dev))
+	if (firmware_request_nowarn(&fw, path, rvu->dev))
 		return -ENOENT;
 
 	dev_info(rvu->dev, "Loading KPU profile from filesystem: %s\n",
-- 
2.48.1


