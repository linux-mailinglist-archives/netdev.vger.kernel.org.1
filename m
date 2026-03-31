Return-Path: <netdev+bounces-273487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBcRBNJ0y2k3HwYAu9opvQ
	(envelope-from <netdev+bounces-273487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:16:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2EC364F0B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B923063D69
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B463BC69F;
	Tue, 31 Mar 2026 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SKQsDO+A"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0083B6C11;
	Tue, 31 Mar 2026 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940939; cv=none; b=qtkMFFhWzRVggauCtqd9qW4j1aZt01eE+55fQfaUkOsmf+KeUzLMlMn3Ci4slJVav1o9jYNcqL8jcHvhhNQWpxv3eG2qaitpR+qcUYymCaUwdeKkv3TRc6q7oSUAl5HClld5OcsnEo7aTAvl+N5oNtR1VYBBx14/7BRvO/dTsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940939; c=relaxed/simple;
	bh=aEBWUE+5VJaMMY9MVKFdfiwsKalag01/tsPY5DXQb6g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WH/Mum4mkPChxt+bB9b3YGK6WK+/puePPuHzlzxq80AjeEpvrT4MpGp25yTaPFxz4ddq57d5gVJF0GQ8CWb8VZT3GQRinYXhl8fWDwd8adgl5D5eL2lVj9/y1WJCLDdC/OCVNbpIq1+ZQo+AgK0lNseoeovp+nQMaAb0zg5qRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SKQsDO+A; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V1Qx2F3007426;
	Tue, 31 Mar 2026 00:08:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=jFo6MZvlvETMB+g7irvbfXX94q8x1N3GX9LZrcgNHVk=; b=SKQ
	sDO+AKWxHC4UVdm7kBZlQkOsxAi12vY060gBFsG97xEfUSMeNItsQCExQFlwwJf6
	HsElBugQU+3hb1IgjgSX8L3hnntQHBoMS4uoVmTbTJbdG6E4MfkIA2uXRPNPPYXf
	8/JcIxhAmJa/u1S+Y4QzxRVfRWdSs/guOjytzykNBEcGJIUvbdR5iKDF60mGSs7p
	lm8zZpjyDrgrN2d8uakMvXj+cmibtaKCy8aqFvqN+vq6byWbE66PyHBSnEZ1D1u8
	mhC34BEMTJUa14zGPlaLDsSBNVF8+gXPoj0wD1+TbiOLt6igpEFuAfQQ4ASKUKAE
	Q/oSxFFbAu/nKQjyHPw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d7u0rhyjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 00:08:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 31 Mar 2026 00:08:48 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 31 Mar 2026 00:08:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 31 Mar 2026 00:08:47 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id E85E53F704B;
	Tue, 31 Mar 2026 00:08:43 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net-next PATCH v4 0/4] octeontx2: CN20K NPA Halo context support
Date: Tue, 31 Mar 2026 12:38:35 +0530
Message-ID: <1774940919-1599-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA2NiBTYWx0ZWRfXzq9BfirdRRwm
 DUTsTiKroO3YpmaVgQJX0fCFo66qxvOXwuwsmNFM0a+w1eoLUjXXE+ZsP+wN4xFLZuJ+ySlYv06
 FHB/eHcxFFgDLogPm4sHqNJJwYNdRFOBTKvWaPP5cp1V5doWAW7zdHl21JoAcDOHxsfDsWJTzyk
 4VOmIQ917622oXCLrDGdV1zWoicbK93b23xELFRribWJhQ6kaZ90kLS23xHjcuPltQc0blfJpi9
 rVDsZioflYBve/TOrMok94Gb7CE2CYfdJDFcSylFqhAMWGS1oSaBWLM5fdFGwmH8pZfHHomI3ZU
 Gq/Zq+aXlNkip30BhGV2bARv0oRFKh6wHyioMD932ff8TpXaAyfRb/rO2M8g2DGiqO8Ufb7nJaA
 eAas7YZo76F0jFyRj0qkniYr9wF7aa5RPYF0tq8W76oOY04CaayfzHceiIn6E4ipmI2YE7SqOZn
 ETTRHXUSni7q5V7Ts2g==
X-Proofpoint-ORIG-GUID: Y-VBGepANALumi1uJbiR3NLMCLTdei82
X-Authority-Analysis: v=2.4 cv=UJzQ3Sfy c=1 sm=1 tr=0 ts=69cb7301 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=Apbl8yOqu0udmtBCm5gA:9
X-Proofpoint-GUID: Y-VBGepANALumi1uJbiR3NLMCLTdei82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273487-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6B2EC364F0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds NPA Halo support for CN20K in the octeontx2 AF and
PF drivers. On CN20K, NPA supports a unified "Halo" context that combines
aura and pool contexts in a single structure. This is a simplification
in hardware so that there is no need to initialize both Aura and Pool
contexts for queues. Separate Aura and Pool contexts are needed say if
we have to point many Auras to a single pool but we always use 1:1 Aura
and Pool map in Octeontx2 netdev driver. Hence for CN20K use Halo
context for netdevs.

The series:

  1) Adds Halo context type, mbox handling, and halo_bmap tracking in AF.
  2) Adds NPA DPC (diagnostic/performance counters) 32 counters with
     per-LF permit registers, mbox alloc/free, and teardown handling.
  3) Adds debugfs for Halo (halo_ctx file and NPA context display/write
     for HALO ctype).
  4) Switches the CN20K PF driver to use the unified Halo context and
     allocates a DPC counter for the NPA LF.

Changes for v4:
 Fixed DPC counter leak as per AI review
Changes for v3:
 Fixed all AI reviews
 Removed inline for npa_ctype_invalid(as per Simon)

Changes for v2:
 Fixed all AI reviews
 Removed inline and added const for npa_ctype_str(as per Simon)
 Fixed build warning flagged with W=1


Thanks,
Sundeep


Linu Cherian (3):
  octeontx2-af: npa: cn20k: Add NPA Halo support
  octeontx2-af: npa: cn20k: Add DPC support
  octeontx2-af: npa: cn20k: Add debugfs for Halo

Subbaraya Sundeep (1):
  octeontx2-pf: cn20k: Use unified Halo context

 .../ethernet/marvell/octeontx2/af/cn20k/api.h |   6 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      |  60 +++++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |   2 +
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c | 156 +++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   7 +
 .../marvell/octeontx2/af/cn20k/struct.h       |  81 +++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  25 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   5 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  71 +++++-
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   |  77 ++++++-
 .../marvell/octeontx2/af/rvu_struct.h         |   1 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 213 +++++++++---------
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   3 +
 .../marvell/octeontx2/nic/otx2_common.h       |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   8 +
 15 files changed, 599 insertions(+), 119 deletions(-)

-- 
2.48.1


