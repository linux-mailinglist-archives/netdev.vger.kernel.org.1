Return-Path: <netdev+bounces-293094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPXBA+J6GWr3wwgAu9opvQ
	(envelope-from <netdev+bounces-293094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:39:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE3601B92
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39EDF3024157
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F583D75A1;
	Fri, 29 May 2026 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Gnmth0Ml"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADD83C5DD4;
	Fri, 29 May 2026 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054656; cv=none; b=muAkaqO02p4KSf0ePbGwQ7e5SatL59PuaBrlWVx0tSjxqtAKls2rvPmJNxjfpzFZAbgsc98za1/jFEuqzvEVeb3rqxJ3YAMRNPh65Nt7C1K/MvdQC1/Xp/UkkAUYDf8Q4WBZpX7DIAzD3oxwDcCQYGoQYRQZIH8NwX4QCQJQzgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054656; c=relaxed/simple;
	bh=W3mK8ZP+Yx7LcFMOnhqsHnLfXw1df//x6b2uTuyIPps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sw6s14suRovQEDzjQHyon+k+E64tSto0/fEP/TZ87ftxKXneAY8hhJ+fLtL5dArIOYYgz+a64SVyUwWlMTKOKmAdUo8IpPUMovzvTKuZIF4xuIrTi1a/cSWQtI1YjMj22ynYZlqEVkVNHBNbUvQK9Xw3IDNEjeSUrQc6OwEpFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Gnmth0Ml; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T8KajO3717182;
	Fri, 29 May 2026 04:37:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=aaTf0r3dBysBF+KS/KdANRhm9aMeOUQwActhVolWcxw=; b=Gnm
	th0Mldz2optw9prQiehFOOKgM1YvNMTUu/mnIrB8O5sfTmn8B5tu/UJCAEuFNzsT
	HaYBREG6uafPYah8Vms2BK2U9tMWZ9gQEyuoL/9G9cL+QEitK+Xza9QNOeWAqSgy
	L48YMAqKKcZNcKzvH6osOOSX91Cl0U/ePl4r/MRuiH5W/X29adMAqfycT+bk9Ock
	fTZ/94ZCFhUAiKKh4g0mYuB97JMgKk3u+CoSrgEYi+cPSd0kt73OISCR4z2kKszY
	ROoD8B5A3yWfSFiq2x2LJAFl5oMmV5qOSBuyVGW86+PpGaE99xWXHKCF03jvHITQ
	/wAht7VbUD0BkxhtBZg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eeydat1bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 04:37:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 29 May 2026 04:37:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 29 May 2026 04:37:11 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 871DF3F705F;
	Fri, 29 May 2026 04:37:07 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Ghosh
	<sumang@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH net] octeontx2-af: Fix initialization of mcam's entry2target_pffunc field
Date: Fri, 29 May 2026 17:07:05 +0530
Message-ID: <1780054625-17090-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 65OxAMlWioxBQyZN7sVyXy1VfIbnHESx
X-Proofpoint-ORIG-GUID: 65OxAMlWioxBQyZN7sVyXy1VfIbnHESx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDExNSBTYWx0ZWRfX1oJXWPp2NuHM
 Hry0XMePvQXj0w0hqKTQiGU0t+SUbTPPcgPXzwZG74Vz85PeExlEcrXTZvnLGIxGktoUsC6T/kX
 S08OLnJ1h2JZYXQMSVas5CbQp/VZbrjdd5JA0NN6I6sAb25f3tOxXH+CW0OHE47ukcFOAUCAscg
 m4Fcqyjafn2B2gkVLPkOaMEqTh25w1u6hcbaFrdLUJDdnryUh0as4+4zZEr0ThcNsYp62ness7j
 dI+XCuQN+phJjbulVFBSqdZK+T+6yDRbMv5yHJpZgkqrj7X38pB3wUxr/gniSR223AjTgh8dKN/
 yrbExoCi4kiN6EYf19EYJQFOxlCrP2CKvCjqWqR+qgzWGAC2lXgYxPVUcWERt7yJnS3XcUZ5oJZ
 IxeCwI8hhujZGMDINrTx1OPqV4u0R63NZjQy7cO1dAIwQKXfSXNpuHhe+r8/Qmr8my2AtZ7rPv+
 OatzxFd+pSnxKuNj6yw==
X-Authority-Analysis: v=2.4 cv=apOCzyZV c=1 sm=1 tr=0 ts=6a197a69 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=ggiXDvd6g2RT5aguthQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-293094-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 62AE3601B92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Suman Ghosh <sumang@marvell.com>

NPC mcam entry stores a mapping between mcam entry and target pcifunc.
During initialization of this field, API kmalloc_array has been used which
caused some junk values to array. Whereas, the array is expected to be
initialized by 0. This patch fixes the same by using kcalloc instead of
kmalloc_array.

Fixes: 55307fcb9258 ("octeontx2-af: Add mbox messages to install and delete MCAM rules")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 607d0cf1a778..6bbda0593fcd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2192,8 +2192,8 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 		goto free_entry_cntr_map;
 
 	/* Alloc memory for saving target device of mcam rule */
-	mcam->entry2target_pffunc = kmalloc_array(mcam->total_entries,
-						  sizeof(u16), GFP_KERNEL);
+	mcam->entry2target_pffunc = kcalloc(mcam->total_entries,
+					    sizeof(u16), GFP_KERNEL);
 	if (!mcam->entry2target_pffunc)
 		goto free_cntr_refcnt;
 
-- 
2.48.1


