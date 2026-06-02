Return-Path: <netdev+bounces-294032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEFpKn1yHmoKjQkAu9opvQ
	(envelope-from <netdev+bounces-294032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:04:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B141F628D2C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7937300406D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 06:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2290314D05;
	Tue,  2 Jun 2026 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XIePuTVI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383E2F6562;
	Tue,  2 Jun 2026 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380278; cv=none; b=AoSywH6Zmzyfeyea86r0JYiG2TX2AgVDVfJGaflw6KsooFPQ1C+hu2rlx3P6ldduHMnTjuuC4GNXxx7DrdT3EbQ2kdCdXrww1CfiYa9Qqb86fc5Ir88wx2crccT8ruQJXa0BrDj2WiYD4yhufC9GYlWBNkfwSfDmGkYgZmDaDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380278; c=relaxed/simple;
	bh=OH+n74SEagdm8QEbvIldwukPM0QC+nXKFLuNWdeHYm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sZ9p2ua5QUsyzfGN5zYaW0GLrAXCTyUrdlZ3swf/OozqBT2SIMug7jXo3pE/+sAi6PTmQRgRF3lBjFqfDE6M1AmWkxQ1a0PAq6L908BtMyKntEG9kQLLRpQ+ibfRAZ3SNSs1rqoy6S4vbYjhFR7MOzggXe3jBhpDWJ8SXwPQlPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XIePuTVI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6520Ddn6930013;
	Mon, 1 Jun 2026 23:04:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=LkKOr9nR+GS7f2zrgKpfZel
	MgwO4J7nNVesglVW8cEs=; b=XIePuTVIa2B/hNBBWxAHa0Uq5URfidnamK5S3rv
	qNT1kHp0zn9+o+deEk1NwICYJj/3yl8zB8r/4264Oxmo+Isgvjyi0xjmqt2+1Sjn
	S4U/XOf++oie1ZfUmYqsSg7LHGIg1SZiq7oTILRJD67qhnBkzKgHZ/JxowPy+08a
	VOUjg+9kUouTSBQnImVqvoZKPmkuWup2jURqR8zlEzR4Km+2c8KKABsCCiiKcM2k
	M2URAbFPfGeDQFE1yA2ooVWsJFy/HTw5VYKYlkzydDad/5NGl7ztxDszfz1ffBTe
	J3LMqKylPOlxfL6YnnXS4uspDyD3ZoOk06r0Wc1WOsrg0LA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ehbxgajd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 23:04:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 23:04:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 23:04:25 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id CC7363F707F;
	Mon,  1 Jun 2026 23:04:21 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v18 net-next 0/8] octeontx2-af: npc: Enhancements.
Date: Tue, 2 Jun 2026 11:33:51 +0530
Message-ID: <20260602060359.1894952-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=V75NF+ni c=1 sm=1 tr=0 ts=6a1e726a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=SeT1LqxgmXCRxSVhd8sA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ffoFzLwzj2BDFZRFP5iV03YaW1Cft_v6
X-Proofpoint-GUID: ffoFzLwzj2BDFZRFP5iV03YaW1Cft_v6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA1NCBTYWx0ZWRfX8SJi8qhN3lmC
 x2ElwwTeIP6ar4En1EMlgnjeYIYiicL6gIWt2p/qZXVf+Nb0kLMWTyIJpg+Fx0crPeW3y9CTVJE
 JSmvHbajwShVCYdXqTkc0DtO1EmcX7qKrPw/xwfC6DNEbjEriil2BwlQujd6vpudmR2rIOaPVDK
 g95OAlUDErZlmqKMwSeHdZgpcK5hjFnbfAAEPhOK0C1tfrsTm+MZiBkOoPKeq6pbOVLxbwVhUtl
 zaJQGThyeuvVye5liW0GcCGo6zW1mDma2WGSwzkzGfneaGhTryVPBsBqcM+lUFzJji8aJ3nHAPF
 24eARCcsK4C7BRasUTicCHinus3AIuw/joU50qasY5Z3Z72jQq5/AE1NVJglCGrOMYyb3NAK/vL
 BQRtV4KfuDC0gsBjnMRflao0mUl02MMBbTS4hdmN901t7/wu83xxd+GPfTocV232kPqZKEm+hUx
 Vi+FQecqrk2atbD1Pug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294032-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B141F628D2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series extends Marvell octeontx2-af support for CN20K NPC (MCAM
debuggability, allocation policy, default-rule lifetime, optional KPU
profiles from firmware files, X2/X4 MCAM keyword handling in flows and
defaults, and dynamic CN20K NPC private state), adds a devlink mechanism
for multi-value parameters, and moves devlink_nl_param_fill() temporaries
to the heap so stack usage stays reasonable once union devlink_param_value
grows (patch 3).

Patch 1 improves CN20K MCAM visibility in debugfs: mcam_layout marks
enabled entries, dstats reports per-entry hit deltas (baseline updated in
software after each read; hardware counters are not cleared), and mismatch
lists enabled entries without a PF mapping.

Patch 2 allocates the per-configuration-mode union devlink_param_value
buffers and struct devlink_param_gset_ctx used by devlink_nl_param_fill()
with kcalloc()/kzalloc_obj() and funnels failures through a single cleanup
path so the netlink reply path stays safe as the union grows.

Patch 3 (Saeed) introduces DEVLINK_PARAM_TYPE_U64_ARRAY and nested
DEVLINK_ATTR_PARAM_VALUE_DATA attributes so drivers and user space can
exchange bounded u64 arrays; YAML, uapi, and netlink validation are
updated.

Patch 4 adds a runtime devlink parameter srch_order to reorder CN20K
subbank search during MCAM allocation (the param uses the u64 array type
from patch 3).

Patch 5 ties default MCAM entries to NIX LF alloc/free on CN20K, adds
NIX_LF_DONT_FREE_DFT_IDXS for PF teardown paths that must not drop default
NPC indexes while the driver still owns state, and tightens nix_lf_alloc
error propagation.

Patch 6 allows loading a custom KPU profile from /lib/firmware/kpu via
module parameter kpu_profile, with cam2 / ptype_mask wiring and helpers
that share firmware-sourced vs filesystem-sourced profile layouts.

Patch 7 makes default-rule allocation, AF flow install, and PF-side RSS,
defaults, and ethtool flows respect the active CN20K MCAM keyword width
(X2 vs X4), including X4 reference-index masking and -EOPNOTSUPP when a
flow needs X4 keys on an X2-only profile.

Patch 8 replaces file-scope npc_priv and static dstats with allocation
sized from discovered bank/subbank geometry, threads npc_priv_get()
through CN20K NPC paths, and allocates dstats via devm_kzalloc for the
debugfs helper.

Heap-backed devlink_nl_param_fill() sits immediately before the U64 array
param work so incremental builds stay stack-safe as the union grows; the
CN20K patches keep srch_order ahead of NIX LF coordination, optional KPU
profile load from firmware files, X2/X4 handling, and the npc_priv refactor
that touches the same files heavily.

Ratheesh Kannoth (7):
  octeontx2-af: npc: cn20k: debugfs enhancements
  devlink: heap-allocate param fill buffers in devlink_nl_param_fill
  octeontx2-af: npc: cn20k: add subbank search order control
  octeontx2: cn20k: Coordinate default rules with NIX LF lifecycle
  octeontx2-af: npc: Support for custom KPU profile from filesystem
  octeontx2: cn20k: Respect NPC MCAM X2/X4 profile in flows and DFT
    alloc
  octeontx2-af: npc: cn20k: Allocate npc_priv and dstats dynamically.

Saeed Mahameed (1):
  devlink: Implement devlink param multi attribute nested data values

 Documentation/netlink/specs/devlink.yaml      |   4 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 163 ++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 633 ++++++++++++------
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  17 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  17 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  12 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  92 ++-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  69 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 486 +++++++++++---
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |  17 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  12 +-
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 .../marvell/octeontx2/nic/otx2_flows.c        |  48 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   6 +-
 include/net/devlink.h                         |   8 +
 include/uapi/linux/devlink.h                  |   1 +
 net/devlink/netlink_gen.c                     |   2 +
 net/devlink/param.c                           |  95 ++-
 19 files changed, 1280 insertions(+), 404 deletions(-)

--

v17 -> v18: Addressed sashiko comments.
	https://lore.kernel.org/netdev/20260601025844.865865-1-rkannoth@marvell.com/

v16 -> v17: Addressed Jakub comments.
	https://lore.kernel.org/netdev/20260521095303.2395584-1-rkannoth@marvell.com/

v15 -> v16: Addressed Sashiko comments
	https://lore.kernel.org/netdev/20260520020939.1457231-1-rkannoth@marvell.com/

v14 -> v15: Addressed Paolo comments
	https://lore.kernel.org/netdev/20260514062537.3813802-1-rkannoth@marvell.com/

v13 -> v14: Addressed sashiko comments.
	I had to revert Jiri comment in v11 as sashiko was complaining about
	leaking kernel memory to userspace.
	https://lore.kernel.org/netdev/20260511033923.1301976-1-rkannoth@marvell.com/

v12 -> v13: Addressed David Laight comments
	https://lore.kernel.org/netdev/20260508034912.4082520-1-rkannoth@marvell.com/

v11 -> v12: Addressed Paolo,Jiri comments.
	https://lore.kernel.org/netdev/20260409025055.1664053-1-rkannoth@marvell.com/
	Added one patch which was rejected by simon in net
	(as it was kind of enhancement rather than a bug)
	Added one more patch- which allocates two variables from heap.

v10 -> v11: Addressed Paolo comments.
	https://lore.kernel.org/netdev/20260403025533.6250-1-rkannoth@marvell.com/

v9 -> v10: Addressed Paolo comments
	https://lore.kernel.org/netdev/
	20260330053105.2722453-1-rkannoth@marvell.com/

v8 -> v9: Addressed Simon comments
	https://lore.kernel.org/netdev/
	20260325072159.1126964-1-rkannoth@marvell.com/

v7 -> v8: Addressed Simon comments
	https://lore.kernel.org/netdev/
	20260323035110.3908741-1-rkannoth@marvell.com/T/#t

v6 -> v7: Addressed Simon comments
	https://lore.kernel.org/netdev/20260320165432.98832-1-horms@kernel.org/

v5 -> v6: Addressed Jakub,Jiri comments
	https://lore.kernel.org/netdev/
	20260317045623.250187-1-rkannoth@marvell.com/

v4 -> v5: Addressed Jakub comments
	https://lore.kernel.org/netdev/
	20260312022754.2029595-6-rkannoth@marvell.com/

v3 -> v4: Addressed Simon comments
	https://lore.kernel.org/netdev/abDeXLpMMxp7G1v3@rkannoth-OptiPlex-7090/#t

v2 -> v3: Addressed Simon comments.
	https://lore.kernel.org/netdev/
	20260304043032.3661647-1-rkannoth@marvell.com/

v1 -> v2: Addressed Jakub comments.
	https://lore.kernel.org/netdev/
	20260302085803.2449828-1-rkannoth@marvell.com/#t

2.43.0

