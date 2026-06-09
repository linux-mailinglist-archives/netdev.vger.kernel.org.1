Return-Path: <netdev+bounces-296890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FJMmFbKRJ2r/ywIAu9opvQ
	(envelope-from <netdev+bounces-296890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 06:08:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A210265C291
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 06:08:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=PvNRLtFx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296890-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296890-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BB733054C3A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 04:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A635364933;
	Tue,  9 Jun 2026 04:05:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEBB3911A2;
	Tue,  9 Jun 2026 04:05:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780977938; cv=none; b=XW8oJzRYdHqK/0rKMKzA/6Ox559vRC+IhLgPooRdnEZWoZeRY3QAvqLOdDucEe/D4+zpGt62oH/s7e8+7cFlnJmVqWGs+1SDnTmYOeIdB5rpJu5arKmjjF/YasnY5xaH8pyHT60Z+7uzpmdWnQkh57RBt79TdvWOU722XBBK4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780977938; c=relaxed/simple;
	bh=IGvTcYIvP72VHynQ3fkQoKPaVJfRYqENeJm+MK8j+iQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLSP72PkbGBWP1XclA8aaDQTUDIUK1cbmhbSbt0RSOjqLIzN4S1tIuavP8ZS+tQm7l7qpBS47Ef5TLC+rP91pg280isngxUztgxPJ0M8n1Vf1qwRcRV3lROPBTR2GteXmHajrVxat5wF44JqsU3WFor/7+CIZFAdBjrLNkIe+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PvNRLtFx; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65942FF04101369;
	Mon, 8 Jun 2026 21:05:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
	pVlX6tD4EvftNHKBuX7pDDQVzbLdtAl6r3xqpe3pr4=; b=PvNRLtFxI0R59FCVm
	lU2zMgJRBz3agvkwN88aU4pSqYX/Qao6BETokN6oIGd5iiJsZRcuxyzDYMG+Pdil
	zhdhItYjwovKmp85L1xCHB8Rbrq2R6wW3A/YPJlPUtWMXB6mntku4Ovc3ZoOoVev
	y4+u9OdC3/vuTftUYgIVwStB9F1UaZ+oULk5IdqPVbxdpW+vzhe/UHlYr7dvBBEB
	qzlkHBKT5OZE2867d77Nn6d/5SAScWZtrqiyTVtC4uaRCVesW1bjAwnK1ZI88odK
	KxrZlPMQa5fG/vHjlP0+yi9HZyRs9D6dIU2fAWdWWbNaGzlFCCaILW9VIWTaf/n2
	onwVw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4emk2esuqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 21:05:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 8 Jun 2026 21:05:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 8 Jun 2026 21:05:12 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 91F143F704E;
	Mon,  8 Jun 2026 21:05:08 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v20 net-next 1/9] octeontx2-af: enforce single RVU AF probe
Date: Tue, 9 Jun 2026 09:34:45 +0530
Message-ID: <20260609040453.711932-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609040453.711932-1-rkannoth@marvell.com>
References: <20260609040453.711932-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAzMyBTYWx0ZWRfX2J6mkvVPdxGS
 669P9c9TmMgWgT/RLPUNcNZaaDHi1ouRA7a9uAZYH9I89roqjL25IveU/egSuRSIbUjAmKGXcIG
 O/Y08X7rHpnwtJ5F+g0DC6fE4oYUJ9cnXEnA/j2UBO44X9ki5Z/xrGBPW2H8HWI+9c5+LwaPgqA
 6R1E5v2kQKm046mBCw0EC5oDQpvjuOMeSoihnfDUB3DpskZlQYZs70vnkjzjMtPJHHCQG4hRL+0
 Zy4X9Z4Jc+12Ll75Si5XF6V+CTsDbL7q0DhH9+uKT1y0bTMiUM7wrInLlclY/XLJdmAtMx22i/0
 G4VboqFIsYeWFeTljep1/+T1RH8kF/UMuQe4UNnhF1cTy5p3Ckha+7+x2SfZ2FdjLFu2C3zVA1D
 2X5D9Jr22edRbh0M+TfGChDmZsPAw/NLIYbRzbNdQWtU0QYM9bUgbZmarjUw7V1mQaNfJ4rya9x
 uYRv/G4RE2G0UAvsgMQ==
X-Proofpoint-GUID: qRX_1sj0EGrgW1_7TaprJzjElOimNX0t
X-Authority-Analysis: v=2.4 cv=bJUm5v+Z c=1 sm=1 tr=0 ts=6a2790f9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=QyIiUewd21HjhqVtCQUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: qRX_1sj0EGrgW1_7TaprJzjElOimNX0t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296890-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A210265C291

On Octeon series SoCs, the AF is an integrated device within the SoC, and
hardware resources such as NPC, NIX and related blocks are global and
coordinated by the AF driver.  Physical and virtual functions request those
resources via AF mailbox messages, so two AF driver instances cannot both
own that global state; firmware exposes only one AF PCI function at boot
and any further octeontx2-af PCI probe returns -EBUSY so software matches
the single-AF model.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 3cf131508ecf..12db4c7a11f8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3542,19 +3542,29 @@ static void rvu_update_module_params(struct rvu *rvu)
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
-	if (!rvu)
+	if (!rvu) {
+		atomic_set(&device_bound, 0);
 		return -ENOMEM;
+	}
 
 	rvu->hw = devm_kzalloc(dev, sizeof(struct rvu_hwinfo), GFP_KERNEL);
 	if (!rvu->hw) {
 		devm_kfree(dev, rvu);
+		atomic_set(&device_bound, 0);
 		return -ENOMEM;
 	}
 
@@ -3687,6 +3697,7 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, NULL);
 	devm_kfree(&pdev->dev, rvu->hw);
 	devm_kfree(dev, rvu);
+	atomic_set(&device_bound, 0);
 	return err;
 }
 
@@ -3716,6 +3727,7 @@ static void rvu_remove(struct pci_dev *pdev)
 		cn20k_free_mbox_memory(rvu);
 	kfree(rvu->ng_rvu);
 	devm_kfree(&pdev->dev, rvu);
+	atomic_set(&device_bound, 0);
 }
 
 static void rvu_shutdown(struct pci_dev *pdev)
-- 
2.43.0


