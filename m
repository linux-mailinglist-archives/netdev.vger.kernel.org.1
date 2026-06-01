Return-Path: <netdev+bounces-293508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH/iK5T1HGrxUQkAu9opvQ
	(envelope-from <netdev+bounces-293508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:59:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC5A618FD1
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FB9130045BD
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 02:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D772823392E;
	Mon,  1 Jun 2026 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="c2ihjLm/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695F21ABD7;
	Mon,  1 Jun 2026 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282769; cv=none; b=NhoJsbrs83OyAGlH+oZOUSmmhDdy1gzm7IEZa0RsgLTAdCUVFpPnYMkFliEp3OZpsr8XXJJoEafgPUw2Pe833olteclYvsjqE57gNuJSt8ya1XqUan54BPUfvHziCLPeZksq3PTuhnyAj1p6s3tIuoFRvXA7I2+wG2jDq8exnz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282769; c=relaxed/simple;
	bh=FmFqgQAt0eQIDZAi2GPn1wzrwvwbq+ISRskukpTt9Z4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MmZ/DPGtCoTv71D8wFBlvlgST80m+J3k+jjKyPbt0Fo0QP/iSdjFuIkPoPBFCSFalf+nvyqXdk/2bjjh9rY/fr2kIvq/7Ng4JGe9WEcXYb5gsh8gQpnKjH1LGEMOhl5HYGSXVOSmn6CwIDJtWP8nIKnHlg6km72stgettG5opdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=c2ihjLm/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VLj6OS3311732;
	Sun, 31 May 2026 19:59:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=2HDJvk0F2mYD3za+rdS7Qr/
	vg+SzUi8BHCRCzRY1on4=; b=c2ihjLm/f+7WbOGAl38GG0vTGDT2Dm436jtMqtx
	Bbojr+wmVn8JqbIRyNacxheVN7o9zR8+1H+F+2EE0PcpBGFPU2EcG8/bowegc4+S
	21xulqDgkvZbJSvjRRoFnr1X/j4FDbs7G5+9KQsRSyT1ovtLbV8Ccv1F5QH/39sH
	pXEmc+oaAhESh3xaRwFpSKJdDzIfcofqSbgrjH+8qh7QUoA+2Lj8UJWGGSEOiy2F
	USCBqQM8LAZqFQsw18LnJ+2PYwN/21I8pKnbzK0+zqvt6oXpaQ/SokqXrRP5ASce
	YBBd5imv2YL1+gajNOdWUGouIRuUKRNZgr694nZlw1XnPSQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eggn8a4wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 19:59:17 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 31 May 2026 19:59:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 31 May 2026 19:59:16 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 970EB3F7062;
	Sun, 31 May 2026 19:59:10 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v17 net-next 0/8] octeontx2-af: npc: Enhancements.
Date: Mon, 1 Jun 2026 08:28:35 +0530
Message-ID: <20260601025844.865865-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9_hsPPCaNDLS8nS5HYSF6lae7Zd3k3bL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAyOCBTYWx0ZWRfX4RbzZhUa2GOL
 30jku1am7AMH4Q/eo/DTdrV1a5PSxsRq8YRut00QbTq+3cNEmYhZA5LulfcWR/jqhpQv4BmMjCq
 iAQCVJCI9n1qNTIBWW1xxmVIF4lu9eFWpgv0J9f2oXXeGIT6NL/oogvessWKTEwnGvfk2JvdlEr
 NO+ftJskq8nXUq36eFbx9lv77yftIFUI2UMfmkF9XdA2QMXkdkUHApR8qZJb56ofSOpM1IWtlLM
 Hs5rrXQh0c3T/FUOK3+uIuJ5H+4lEYg1xXrqcoDciyC/t3TofkXQlEyJuLc96e7X6FP3qkbjSJS
 UhBUwBEcFUSjRLDyOV41Zr+mwvwdBWFN99hZI8HwzY4XHVHKTztejSklQaWRhhEg+ph5zN9hoFU
 1/cnEKN6r+9emxaZDDWjd1LUzpG2dCTXWqstO+LI6gzNxOlt6OkAIfzjNfUkcHqkudeGfzdMWJd
 Ym4D1qnQNuk94KpKsdA==
X-Proofpoint-GUID: 9_hsPPCaNDLS8nS5HYSF6lae7Zd3k3bL
X-Authority-Analysis: v=2.4 cv=ON0XGyaB c=1 sm=1 tr=0 ts=6a1cf585 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=SeT1LqxgmXCRxSVhd8sA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293508-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2BC5A618FD1
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

v16 -> v17: Addressed Jacub comments.
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

