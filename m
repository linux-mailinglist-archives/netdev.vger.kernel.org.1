Return-Path: <netdev+bounces-295656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ijDM1N1ImrPXgEAu9opvQ
	(envelope-from <netdev+bounces-295656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:05:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF794645C24
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:05:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=XoI911Z9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295656-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295656-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA4C03007B03
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 06:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8436F42EEC8;
	Fri,  5 Jun 2026 06:59:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88740B6C6;
	Fri,  5 Jun 2026 06:59:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642790; cv=none; b=XCryLaS/UY3YraPOJm0fUHlffoi6/fFrBerK8znZ9zz0RIj65LstIqMufTe3itP30yn+Qhs+sCFcdwg9GzIKtSuqQ8b2vkxtAxe1Gczpm0PcBuJfaollntRAmeN5tA742JV2BaLSG7suNE5oTf3g3g5skRUTaB+AmUY+Q/xe9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642790; c=relaxed/simple;
	bh=ekTe7hbZIQd0YB91tpENtmYdl4mtyIgE3ISkU1IeIFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PU0jIzXEfZAdoYYloYKxPm8RdWn8VUWKXBiGWefvueJhdpsXbWy5SV8FGr5Vb9lHAy2AEMeVCz4Fo+ISSFFjKvTF5BmDeBuB0DQ62tY7/mufyJofoq9UyaS/u4wvgly8Lu6IghN6UhvUOQVKIjjITNzxluV2KWO070bRYL7w72I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XoI911Z9; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655373hh302316;
	Thu, 4 Jun 2026 23:59:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	tuEsZkKi1uXw2QsAcERI5P9a0jvBAlIqlvADZAAJ84=; b=XoI911Z9+Eeps93sB
	XvQjrR+MKaTpnN1kk5BYUeSqvtMHeN0P+0ga7NbDQiaN4CT+42QCL9QmmnpIzYMd
	39E/aC4klW3kPRcCUicYrxupf5iEfSO+04YNoD3rI/t12Kko8Akrt5S0gaHY5wpd
	FNXQ3Bir60BYZSBnpU2DykBRrnIdJTMhOzgODP++yQrx+WiHE3yi3bpL+RclGQRG
	4Q51j2sjgCiJ79hRXi+rTrKM3ElN/ejBr4BTUBQCqbafb1ZeYragzrpRyeNy6mWC
	i0fe1uiKC9gIidwSNh+q2GJNmeqLzUnWMCb7sRlQDPey25rF+ZP3ex3E7OMiD/VT
	XFGzA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ekcj0ajjn-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 23:59:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Jun 2026 23:59:34 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Jun 2026 23:33:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 4 Jun 2026 23:33:02 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 86F4B3F7074;
	Thu,  4 Jun 2026 23:32:57 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v19 net-next 1/9] octeontx2-af: Enforce single RVU AF probe
Date: Fri, 5 Jun 2026 12:02:37 +0530
Message-ID: <20260605063245.3553861-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605063245.3553861-1-rkannoth@marvell.com>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=G78s1dk5 c=1 sm=1 tr=0 ts=6a2273da cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=T1-iXrwByj4Y60gxB9YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA2NCBTYWx0ZWRfX3d7P7VKmkqm5
 R5QnhJoVF7KKREpssG6UIMbE5/IGVYuMD6+eXfhS9mlZkLOdg7AGRZJq8bI7dTuW7WqH8V+gER1
 hfWwJ6ZjHQr5TYF15c9N0LoFsqGbOq9tO/l5dp1RFGiqbY0z99cm+eqSs2G9peNtNhLDCJ5FPlY
 SUKDnnRUHAJDsD7ZgBMjwtX9Mi3rQ51SPCNNXZXwXHPk/VkTkrEiGZAkW/0gj0ITxGISbQnpZSr
 3Vfr401TJlBPT8NREQylJgr9Bn7eb13sCAKLKvP8WNbAKHGuytUlzCQMnExCD47DhkU1hNl/uUj
 9cTdDHyaUexfdTbXX/DvsMNmPVM0yWgXZYdG6/9x9k5O8DRBIL/WgLz3lNfKhKMH92mOU3ee5Z6
 v447iWIWFA+E1STqribOdy+0tkZkLu8G0xi4yxtXK7YKRNhsoZxxjQoD0exe6gVcct0TUiUG5DX
 4CvlDdbdCayc0g8nsyw==
X-Proofpoint-GUID: 1HZ8lQNiyzAYDbhlEWtpCpoCiQLNE-wf
X-Proofpoint-ORIG-GUID: 1HZ8lQNiyzAYDbhlEWtpCpoCiQLNE-wf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-295656-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF794645C24

There is only one admin-function PCI device per system.
Reject any additional AF probe with -EBUSY so the driver model matches
hardware and automated reviewers can rely on a single bound instance.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 3cf131508ecf..1f0c962e10f4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3542,12 +3542,19 @@ static void rvu_update_module_params(struct rvu *rvu)
 		kpu_profile ? kpu_profile : default_pfl_name, KPU_NAME_LEN);
 }
 
+static atomic_t device_bound = ATOMIC_INIT(0);
+
 static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
 	struct rvu *rvu;
 	int    err;
 
+	if (atomic_cmpxchg(&device_bound, 0, 1) != 0) {
+		dev_warn(dev, "Only one af device is supported.\n");
+		return -EBUSY;
+	}
+
 	rvu = devm_kzalloc(dev, sizeof(*rvu), GFP_KERNEL);
 	if (!rvu)
 		return -ENOMEM;
-- 
2.43.0


