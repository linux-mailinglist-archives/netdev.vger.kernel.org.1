Return-Path: <netdev+bounces-270354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK5gAMm4wGmpKQQAu9opvQ
	(envelope-from <netdev+bounces-270354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 04:51:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0543A2EC461
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 04:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30B183002908
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 03:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2774925A359;
	Mon, 23 Mar 2026 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JUIFsqpq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977D48CFC;
	Mon, 23 Mar 2026 03:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774237891; cv=none; b=duc/FrUbyHkzVERDV5HCl61/eQPksBZggHktuVFiq7XdRp5HbVEQPxgvorCotwXeO+DJ63osFL3dbItqu59ArPHDUiJE4ltVGVwchsHa7cJOahXnEwft3BeV3zyfUD1RT4cKmoARfDfBjWfgG8Rqr89dCgOYvkEDvi1mH/ekeok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774237891; c=relaxed/simple;
	bh=ibNfuLJddlRU4MNlk0R41FCtc5q2mRNXd9NOqBg+z8A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pRYlwgqspavWuFkLClUTSBhVBLJDTPJn3REw9uGysnj0FacLy2ZV4yLgOwThe+X2SoghIbq+U6YxvTNG2HhwUsJ1bKfwrprosOSWZKU2IwR9lZyS72UQSHgppM/0Ienc+lxlH/LMafvRm/Xg1FSuFdo6LgE7WkZIzqeQPwdvN4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JUIFsqpq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N1fWSq1176460;
	Sun, 22 Mar 2026 20:51:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=/xff4bkI7qvvO2oYJh+v2fT
	z3ZqjdV0a+xeGV5qDDXg=; b=JUIFsqpqxcBpO0HGwy27hhOfeAxJTW8zJlZkcaE
	/r93HOKe05Y4HV+HAHRcgLxVmXTRMWrxQc0IvMbNV+Tp0xu5DQ9d/f942xtNMcmP
	2ZSrTxvbXw2ds6thIZR5jF9YYfTq6Jf2KMYE5u2wvaJqoHVIOFrNz9mhMh7utAem
	gKtjwiV0Lcba9th72TQR1p2HPHj7rdsfbYc2Nh6rhCmJlsuuJXRERB3xGQr9JNkx
	IdoXh1Ikz0kMqgI1Q8KLnWpidH9j13fWW2FIELZv7kwa1J+uEo4vDsdiADVSYkBA
	cWBbl1gst2iYMzuF5lKzQLg3snMC5DqechYe0NeFq4ASzuw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d1tugja7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Mar 2026 20:51:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Mar 2026 20:51:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 22 Mar 2026 20:51:18 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id EEAE43F70A1;
	Sun, 22 Mar 2026 20:51:12 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, <dtatulea@nvidia.com>, <tariqt@nvidia.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v7 net-next 0/5] octeontx2-af: npc: Enhancements.
Date: Mon, 23 Mar 2026 09:21:05 +0530
Message-ID: <20260323035110.3908741-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lMhXyYO074GDYVy85xMTTSJoCOuQ7ADv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyNSBTYWx0ZWRfX/MuwqecuYgmF
 iJg3aTSNZyT2plBrP7PsgIHrx8KOOrkVhf24CrDWwyA4D4T5a+X25n1FiT1XH1oT6DRkYTPPtBZ
 BZ1U3X8tqcKvLAavzH3j6SC9XxzJuXC1jGue6y/hUGxQbZ0RDsLLFVem7ss9IyVH28iDduNJ9hT
 Hv1Ji5iK2fD2wd/o0LYE/TKTX9D3BT0oPyLPWYkwnQgLwSpvcHwlXo4jVWd9LAOMolDG5WOGfsK
 FbXRGE4CLthEiNKlhPErVkXzB4Np8/MjnUfldrfq3ww5bdgRZtabYNKmu4cnztKkTdNiLttC0wc
 IyQ7SoPLp7fPW5utRjuiyw9urnDWZjKDZ1T+S6s4KMVlA044I+V7m3fR7Q0eJXzK24eYjJvXf94
 fvvixtodlCaIoysgiDLo3DZ9cPQqOtFBhBQxCB11iGaONNEm3XgWepq/GnpjZmyekDu7Kz4rz+N
 3SVYvZFvQ7zGHcT1qfg==
X-Proofpoint-GUID: lMhXyYO074GDYVy85xMTTSJoCOuQ7ADv
X-Authority-Analysis: v=2.4 cv=Pu6ergM3 c=1 sm=1 tr=0 ts=69c0b8b7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=32TfifE4CFI_pm9Ig-oA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270354-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 0543A2EC461
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
v6 -> v7: Addressed Simon comments
	https://lore.kernel.org/netdev/20260320165432.98832-1-horms@kernel.org/

v5 -> v6: Addressed Jakub,Jiri comments
	https://lore.kernel.org/netdev/20260317045623.250187-1-rkannoth@marvell.com/

v4 -> v5: Addressed Jakub comments
	https://lore.kernel.org/netdev/20260312022754.2029595-6-rkannoth@marvell.com/

v3 -> v4: Addressed Simon comments
	https://lore.kernel.org/netdev/abDeXLpMMxp7G1v3@rkannoth-OptiPlex-7090/#t

v2 -> v3: Addressed Simon comments.
	https://lore.kernel.org/netdev/20260304043032.3661647-1-rkannoth@marvell.com/
v1 -> v2: Addressed Jakub comments.
	https://lore.kernel.org/netdev/20260302085803.2449828-1-rkannoth@marvell.com/#t

2.43.0

