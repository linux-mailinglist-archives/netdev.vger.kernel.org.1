Return-Path: <netdev+bounces-254673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLb2J2cme2nXBgIAu9opvQ
	(envelope-from <netdev+bounces-254673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:20:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F37AE139
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A60693006B38
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA437F749;
	Thu, 29 Jan 2026 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jr7YZTRz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79737F100;
	Thu, 29 Jan 2026 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678394; cv=none; b=p6JDiZJsndRhZ3C2Ha3vtvsOLjaEDiKoVdSJuzQSuLx5cqGFSbVOICb76t3rhE+/19CXKThD27Pq+9MJm/z7voHn7kdFRtNcRiHfJkRyQ9S0Pzad7l4YQ5ZAwHyFfx/NKlcbwJSzgZKjbC7/jMFCCpvVHPj2rlFo/WnLp4TcP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678394; c=relaxed/simple;
	bh=s2SOPYJU/BTA3veEbvycTwUsooD4K02B+CzrQcqJp2M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=REacqMaPfFYVBIRq5zuyoHafIsCjK4CGaRTimoB2+LpfSxr7KZhPsM3TD8kKElq3y9RaJY4TPSNmegMGYg6ZVyuIrKSXEzlxBAf1s+HtVRiU4gX5RF9QzdHGIqeGbtGyA1iolJxBkUSIjAhLuJXUP2gOmUwAjhCP8ZIePtGFLgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jr7YZTRz; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T0ft9I415471;
	Thu, 29 Jan 2026 01:19:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=lGof2MEXggJfTKBKwYMRHn1
	vXLKZ+RDcBWUSAdiWez0=; b=jr7YZTRzVxAGfnj9SNMR2MZZ+3lbmmFq2zR7iZE
	Y5/UKrg9Z6UvVeGXd9mNabDW4MNkZtleP2uV32vOxXH9sCuafQliFXUO1DrvXgVH
	WlZVx7X5ZlJnF071r2qL99gvJwcSBoi3NN97VVufeZ8M63rw+mOEFyIC0yhSnr7q
	yzasLdRwmnmL5ebfBS+fXU1GhMNFv0rdQ89cwVPog7M1RCsRfQmCGz7b6tLxTgfb
	pQLNTl5twnOwLaPlHIZcTQsATfkrT1F+lRrjiqC1+u3fwMHq6AEPD8KW4mCuLqFp
	ac4HmX+VwTDWQr0d/un0TpIWvswvvwweIz6hR8U8EtsqaTg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4by8r6bysm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 01:19:44 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 Jan 2026 01:19:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 29 Jan 2026 01:19:56 -0800
Received: from hyd1vellox1.032marvell.com032caveonetworks.com (unknown [10.29.37.43])
	by maili.marvell.com (Postfix) with ESMTP id 318AC3F70E1;
	Thu, 29 Jan 2026 01:19:35 -0800 (PST)
From: Anshumali Gaur <agaur@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Anshumali Gaur <agaur@marvell.com>, Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] octeontx2-af: Fix PF driver crash with kexec kernel booting
Date: Thu, 29 Jan 2026 14:49:25 +0530
Message-ID: <20260129091925.2465681-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ka/fcAYD c=1 sm=1 tr=0 ts=697b2630 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=mvZ6huRl78alZSWPuJQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA1OCBTYWx0ZWRfX7cIw3JSCmhue
 I/1eMLlKcrJC1t6xPlwdcySbIukljsLm628JCVeym3rz+Bpw6XuwLwzY6Zc7O8tbVdh6VDbLEQA
 a00XUKSoQbYzVCUAQysIEKNQy9DqEavYy4Og6qTaR/vfmExyz/LgmuFxgPqJomDL2+vqgiSObzz
 jRDi5qm1x86dB51NZ+uqqDaEBna8UuN0rBbd6U+sc5+vFpeWR9O2pqXWUhABdbvPkeH6oGxFnxU
 6fvacOoVqKInlWL6t722r4uv/iMYT9HrWF9b32mzQ5p/nmgebxQAIS1EHwPvroezsKkx6pGIRsw
 OFIw5Xi1Dw7ERC6sTMhgjdLJhGrK/ps/vYgCsErwsnku07XscNnOjb/9JSRvtEIG9fqcok601+b
 06XfR6cS7nQJtNP8Q8uYmSMc/Bla1KbKHmKCRf+kRqLJA/8FJaXmCc94NOIUaN8wo/2HqZhQ65W
 xD7+Ia8MxpO2ELkVdVQ==
X-Proofpoint-GUID: hcd1TUrvpEb4avTIz0daqTNNWcx5UpI8
X-Proofpoint-ORIG-GUID: hcd1TUrvpEb4avTIz0daqTNNWcx5UpI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_01,2026-01-28_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254673-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agaur@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: F3F37AE139
X-Rspamd-Action: no action

When both AF and PF drivers are built as modules, the PF driver in the
kexec kernel may probe before the AF driver is ready. This leads to
a crash due to uninitialized hardware state.

This patch ensures the PF driver properly detects and waits for AF
driver readiness before proceeding with initialization.

Fixes: 54494aa5d1e6 ("octeontx2-af: Add Marvell OcteonTX2 RVU AF driver")
Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 747fbdf2a908..8530df8b3fda 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3632,11 +3632,22 @@ static void rvu_remove(struct pci_dev *pdev)
 	devm_kfree(&pdev->dev, rvu);
 }
 
+static void rvu_shutdown(struct pci_dev *pdev)
+{
+	struct rvu *rvu = pci_get_drvdata(pdev);
+
+	if (!rvu)
+		return;
+
+	rvu_clear_rvum_blk_revid(rvu);
+}
+
 static struct pci_driver rvu_driver = {
 	.name = DRV_NAME,
 	.id_table = rvu_id_table,
 	.probe = rvu_probe,
 	.remove = rvu_remove,
+	.shutdown = rvu_shutdown,
 };
 
 static int __init rvu_init_module(void)
-- 
2.25.1


