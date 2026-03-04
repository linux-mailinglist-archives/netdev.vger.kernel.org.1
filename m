Return-Path: <netdev+bounces-263582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UsJFB8G1p2l0jQAAu9opvQ
	(envelope-from <netdev+bounces-263582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:32:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF31FAB0A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D557B3044676
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 04:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1331B280035;
	Wed,  4 Mar 2026 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CCOoPt53"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A41F5EA;
	Wed,  4 Mar 2026 04:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772598716; cv=none; b=Swv85q5CYhCbN8CcydKsYEGFh+wFxBbe/WtdKGJHursDbkHyg72PWaj1faSh/+fBzHFOD/5lv6T4xpwo1+kQFfxiUEa2bRKEMRdW0GF0NsGSgoJu5BnH+C5TdcQQ0NxerMcC4LlFndWOF5NGxmmBkXEMreCx218Cy/7TNqhCNm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772598716; c=relaxed/simple;
	bh=Uo1gvJPTx803nj3HcvrD0VYwIUlaIVc41X1cSGMdn5o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WBgAuB4B5rIRuskMMq54m44W4LNFovVlG5RaUsYEqyXUYavtrULFrAstHXtBBgDnUmiKMRPLAfSNpcS1Zl6BY7i+Xhp2pSQtPWYcjtY9z7xRRzzBu0q8b2/aYR4DoMr45A7nBovmAt/akYTPltqIPBFZ+NBrJRsSFC1+4Vy+nTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CCOoPt53; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623KR9Hw2339921;
	Tue, 3 Mar 2026 20:31:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=6/KMB4GTNq0RXTdL8xHuhpX
	T910e1VennePI/5OCG1U=; b=CCOoPt53r4hnpoXBxomFxV8MV5+jvn+f6dCY2bq
	k60n7CA98DwU2NVNmXq1Gwatfril+TZ4PCSLC0jncxyaDvWVtgpgEgT14hFHKLTy
	7OOyV6XVsGVPhj2iRNwSAB9mAvq+PpmDXfoLKdMOBI7O2UD4+ueRUEYUa3g5IV0h
	2gNG/+K+WR2CJ1ASiKIoG1X6Jxd3V1wINGtJ4cKPzwjOp0vblp1G5DYS129UGv70
	RN+NUqVoVE4wpzK9W07S9+gUhmoG8ZlgEC3EzknjQScozuEcwgBIkjrXSw7dOwvJ
	BoSgv978SRZ3Qlip7OQb/lT9YHyLk6xp811O1nq8N6UKbtQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cp6pg8ynb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 20:31:31 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Mar 2026 20:31:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 3 Mar 2026 20:31:30 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D2E843F7076;
	Tue,  3 Mar 2026 20:31:25 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v2 net-next 0/5] octeontx2-af: npc: Enhancements.
Date: Wed, 4 Mar 2026 10:00:27 +0530
Message-ID: <20260304043032.3661647-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CWmLoBDLPwOFNDv0mjv1HaKbXQazPke0
X-Proofpoint-ORIG-GUID: CWmLoBDLPwOFNDv0mjv1HaKbXQazPke0
X-Authority-Analysis: v=2.4 cv=O8c0fR9W c=1 sm=1 tr=0 ts=69a7b5a3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=hejfvb9J70K0_1iCNg8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAzNSBTYWx0ZWRfXzKL8wuuBCSRO
 1a/wPDjmgYTM/gd1lpLOOuKK73+wj3sJyqqJwWRFr8cX3/tC/vs4jCWRbD8MZZaM50FaSovslDC
 AGdPGlWNdLEdieP+Cdcm31aK9mpfYvTjta/0Xiap7q8mnZcpuFc6IXJfSyRXnsMuzW15R6VC0yn
 y6JN6aPOPp7rHTKkoeyqyHjOmzbr5Je6aQq7w4KO5q074n7sEX65KcT6q5SAJ0tWS4E9mq87K4n
 9qb/VNWg/ctWGQaLiMb60szJOWLFm7O59XrLk7ZBVtogv5Bd8IZl3xho/WeycQitEY/VNrt7Tpj
 ZRUQvdHWG58zNeC2haz16ls0+az4ltIYEU43JIGQs2teOAuDCtZq6+kGls5ipa3dgrRlsvdO7c6
 5k4hiNG+YyTJ4WwDZ9HdUdfHPVQpB4EZva7hXleiIQAZsLnhKxHe2CYd71jNRtXSPApagPvgNLh
 xbFpENHvNsdBbs2v5tA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Rspamd-Queue-Id: 78BF31FAB0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263582-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

This series adds features in NPC HW block in the OcteonTX2 AF driver
for better observability, configuration, and resource management.

Patch 1 adds debugfs enhancements for CN20K: mcam_layout now shows
enabled/disabled state per MCAM entry; a new "dstats" entry reports hit
counts with delta semantics; and "mismatch" lists entries that are
enabled but not explicitly allocated.

Patch 2 (from Saeed) extends devlink with DEVLINK_PARAM_TYPE_U32_ARRAY
so params can accept multiple u32 values in a single value. This is
used by patch 3 for subbank search order.

Patch 3 adds a devlink parameter "srch_order" for CN20K to control
the order in which NPC subbanks are searched during MCAM allocation,
allowing users to tune rule priority without firmware changes.

Patch 4 ties default MCAM entries (broadcast, multicast, promisc, ucast)
to NIX LF lifetime: they are allocated when a NIX LF is allocated and
freed when it is released, improving MCAM utilization.
NIX_LF_DONT_FREE_DFT_IDXS lets the kernel PF retain default entries
across suspend/resume.

Patch 5 allows loading a custom KPU profile from the filesystem via
a module parameter (kpu_profile=), avoiding firmware flashes for
profile updates.

Ratheesh Kannoth (4):
  octeontx2-af: npc: cn20k: debugfs enhancements
  octeontx2-af: npc: cn20k: Add devlink support for search order
  octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM
    entries
  octeontx2-af: Add support for loading custom KPU profile from
    filesystem

Saeed Mahameed (1):
  devlink: Implement devlink param multi attribute nested data values

 Documentation/netlink/specs/devlink.yaml      |   4 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 120 +++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 192 ++++++++++---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   9 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  14 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   3 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  88 +++++-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  14 +
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 269 ++++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 .../marvell/octeontx2/nic/otx2_pf.c          |   6 +-
 include/net/devlink.h                         |   8 +
 include/uapi/linux/devlink.h                 |   1 +
 net/devlink/netlink_gen.c                     |   2 +
 net/devlink/param.c                           |  78 +++--
 16 files changed, 674 insertions(+), 136 deletions(-)

--
v1 -> v2: Addressed Jakub comments.
	https://lore.kernel.org/netdev/20260302085803.2449828-1-rkannoth@marvell.com/#t

2.43.0

