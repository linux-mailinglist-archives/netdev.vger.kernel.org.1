Return-Path: <netdev+bounces-268438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FkJGB7fuGnDkgEAu9opvQ
	(envelope-from <netdev+bounces-268438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 05:57:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 545EF2A3D95
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 05:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3697630106B7
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AE9372B27;
	Tue, 17 Mar 2026 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="K5Cf0Tok"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BA336EAAA;
	Tue, 17 Mar 2026 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773723416; cv=none; b=LEyVT3tccXTbZLAkFrs4foZJ3EwpWMNPs9PPkp4k/zZDLdWwYVy5P8HdFncOdYn8/qtyOXncgTuAs7zSydcMaasuXFByAmqQEeualX2B6qLKE2KINwG3o4nXCwICtK2oDo/fLsV2CQgpSiW33ZiTS1pHzTakHhDaa4y4HaUSiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773723416; c=relaxed/simple;
	bh=tZoB5PAwNpbH9k9qqUrxUGDYlJ1goV22aiZRutMELSM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MswHiE5UHamZpqm8b/LIvkPgD9tq2Hp4ZKZeA+Qku/HcI5AdCpqwXIqyT+aSAR6UnuBhqEJaeimm7SJEJpIbrE8XNn+V564DXhclyl5qj3RNMUrma7mwoXZ+nwQZZnoH8+A6HK5yBdSVuhUutbEZL11UBsfpjmfUdAfCIIZaH8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=K5Cf0Tok; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GGDvhW2890592;
	Mon, 16 Mar 2026 21:56:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=4240NiIZbudyseRhy0vJYG8
	tMMlICjitLuh+dQN35C0=; b=K5Cf0TokGqFIAv2EJK2ZZX8dyPI+AYmNOS0HjJ5
	pHt73ICO6PNKtcCNtXMrWqZTxAppB+1zExCiU8siNdq9LFr+zR0z7fw71o7LvSS4
	ZXENZZwyp6Af6yngNvwtC0csv/aze2Nj6381bUJDM6Mdr09hcRwI5MFt4PuDqJz8
	GREnYxmNagN7LKmmARCbmqiPQfdb2v7g3zLowqvf/+jG/agXthNP01WhTPhn1EL4
	2cZe5F6WA2MqdMURwKOqEvxfwZzCDIrHPlOy3jD3uCQyVYDkPIW306dWphb95KOV
	1EpEuwaEPbnt1YNIqxCdIjZtvOpuCgORWzOyJTZyxbKD2hg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cxn6w9ktg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 21:56:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Mar 2026 21:56:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Mar 2026 21:56:34 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 8E3933F7078;
	Mon, 16 Mar 2026 21:56:30 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v5 net-next 0/5] octeontx2-af: npc: Enhancements.
Date: Tue, 17 Mar 2026 10:26:18 +0530
Message-ID: <20260317045623.250187-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Bob7c29v7xrFMJL_gUHB3WSJQmBL5D6z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA0MCBTYWx0ZWRfXx2yLCU+bca35
 UloGanbp5ztV2/DmNapmRD/ZRXY8F30vEa/r0/uP2BXlvsoem1pqxToi5PXKg4O37mSRcWG2R8n
 0sjQly/TcHycHnCPkwgaZv1K+YuPszogw3UxkLpZYhWxKfnPQNtbhDYGHgfR5DNo6GDDoB26mF1
 0Gw+eHjukn33iHYvEvezuxLr2+RqeCI0A04CPO1iEUhltzZHv/zSXXKWwInlnNYfDxU8Abd5tXi
 Ly5OVTfZsWt2yqiSRf7P51NiFMWtaj4bYlufDvLyFwpPXImGcWPuR5uZ7KCVCkkKq2srcR2I2EH
 fQRFf7Krm2uUiKzRaL/YcR4jAbKb/sDp+QcFiB7KtODjOK99kko0el3L+VryAMmxJ2WktBAjBcQ
 AIesKzkBDxRr6cUSLuehE78fmAuw5zjPPn3MoTfY7nQGdWBtx6X1UoYrdm67T0VVLVOvjl4CHPe
 gAlSNdB/asOnSBp7P+A==
X-Proofpoint-ORIG-GUID: Bob7c29v7xrFMJL_gUHB3WSJQmBL5D6z
X-Authority-Analysis: v=2.4 cv=McJhep/f c=1 sm=1 tr=0 ts=69b8df04 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=32TfifE4CFI_pm9Ig-oA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268438-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 545EF2A3D95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
v4 -> v5: Addressed Jakub comments
	https://lore.kernel.org/netdev/20260312022754.2029595-6-rkannoth@marvell.com/

v3 -> v4: Addressed Simon comments
	https://lore.kernel.org/netdev/abDeXLpMMxp7G1v3@rkannoth-OptiPlex-7090/#t

v2 -> v3: Addressed Simon comments.
	https://lore.kernel.org/netdev/20260304043032.3661647-1-rkannoth@marvell.com/
v1 -> v2: Addressed Jakub comments.
	https://lore.kernel.org/netdev/20260302085803.2449828-1-rkannoth@marvell.com/#t

2.43.0

