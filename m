Return-Path: <netdev+bounces-262562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EaPAdZRpWmU8wUAu9opvQ
	(envelope-from <netdev+bounces-262562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:01:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C35C1D52A2
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD1E304DF35
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 08:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CDB38CFEB;
	Mon,  2 Mar 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jF2Msk6g"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522A38A73E;
	Mon,  2 Mar 2026 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441919; cv=none; b=iT0L7RLPD8ZH+IBxfSoF9GpnD8nAV3iIZ7SK2w3VWvnq7nFAFHkmPArJ5a+UDZFeUY1pMqxIhKq6qX3DhLp7shWzFTMdhv5i11mkO9+JY+Bhb06J6JmDaxfEMh+2bWdoaoossKhM1hl/fFmzC4xtSJuAKp4xcTbYNQhuxuQJeIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441919; c=relaxed/simple;
	bh=JlXCVofsQIzOfaJB0628zEDKjj2XSvW/j7NZYEqGRJI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eQqHQiicReCoQZElmEsdjVuSlo/+jrFcO3W/4ye1eTNT8jg9vr4MEBF8zxYn9lXzDBP/d+dr57iN9PNEVmD451fdJiR+k0FX9924aZxRUK0rKVy4r8U0lYnNzW7WYrgQAR2tuJuTQ6+Znzq6bZU94PZEaiPdM3QL7WvmAjTdznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jF2Msk6g; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621MWZrD1434187;
	Mon, 2 Mar 2026 00:58:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=QweyjosiKEdK28e5y/P3kTm
	PDBEDXn5HbM0kGUSGfNA=; b=jF2Msk6gqb/xkw+L4WlOwqmOPQSCpslEg2OJsUD
	6SJkSXCOYQY1j2XceKdjqa2/DFUveYSgRdrW3nZP77z+Q9Da9KRMpiig5UKb+4v8
	AweCcXjBhym+z4Q/AafctUg9UBAACcnOIzhPrKUdYPzQSa/XMChL2WWGjgMs8cxI
	s3xEFIEYRk5S9WQKBjBwb8+s5t/uN4ze726h/NVPfgKgBY3jFTdnvSYymaaKKoWb
	11Rg15BB/MKG3JybljG8RWxEQqFPiY+ZgrTux11ZxXU55QVOuCSPS6C1/MPaqpYm
	X8+Bs2/w9KFP98de6epOBR5F4nyUMVQHN6kUnvgh6+64uWw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ckxkp2xuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 00:58:15 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Mar 2026 00:58:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Mar 2026 00:58:14 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id CB23B3F7064;
	Mon,  2 Mar 2026 00:58:09 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next 0/5] octeontx2-af: npc: Enhancements.
Date: Mon, 2 Mar 2026 14:27:58 +0530
Message-ID: <20260302085803.2449828-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XrTQSZB3W1CZmD7olABXHiYwygDI3pmT
X-Authority-Analysis: v=2.4 cv=eYUwvrEH c=1 sm=1 tr=0 ts=69a55127 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=hejfvb9J70K0_1iCNg8A:9
X-Proofpoint-ORIG-GUID: XrTQSZB3W1CZmD7olABXHiYwygDI3pmT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3NyBTYWx0ZWRfX8lGd/S2YRK48
 R5Et5EoaeW0nEXIqL815Za+5SS+vNMVTpS8SY4tiyMGo02Ftrr5pp7KjhDmZ7jwrRZCNTn0bb5o
 6PP9ve3blMbiaNVlO8AZT6S0sdrIoLkHUCqqW/CklkuOEJVrwHZwX3aL/DtkHtqy3+syKFUQdC4
 Kd99X7MOsUMOEJEUi2ni6OzQGWs49KLi0y7oF3N/EAq9F0AsF22ibTB4lGbCW8taMpbTzQcX4mG
 ZRTMk7hQDb0jwqfghUmW+czMRq1Fqes6uNU+I2m2/pZNnF5ElSDfDRrvvbwg59RNHW5FUcH4dyg
 kMB/hCzc7UhJ6/elxJ0nlPmAf7MbJy2qFI5p7X4QPke4PbmmjX7XmL90ta5KSPD1YL/PGMas51u
 8iv/Jt1ylmvtd/vfqQ5I3DWjUfQZ0p5mSFnW/M5Cj1Ch4is32cLumpvPJDff/7JwrcEDlwNqM00
 9RLrUSsWEF6VmI2VT+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262562-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:mid,marvell.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5C35C1D52A2
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
2.43.0

