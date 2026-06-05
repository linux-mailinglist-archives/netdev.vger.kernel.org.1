Return-Path: <netdev+bounces-295613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4pXGOqVHImqJUgEAu9opvQ
	(envelope-from <netdev+bounces-295613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:51:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DAB644F25
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:51:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=YB0hkUnJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295613-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295613-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E80B9301E54C
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 03:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4F93F20EE;
	Fri,  5 Jun 2026 03:50:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102637756F;
	Fri,  5 Jun 2026 03:50:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780631459; cv=none; b=AGixtVjHCmuPnY9RFdiP7DA9CEXxrZm0eErMU1hrrRCjTBjaXosuubYzdvUIrgksROnWqFUwkTGMHXuSk4IWN4slMx1Cnmer00iUrWv16qCLYVfPrx/t+anXY47dyfsnw5B9BZi+Oho6R+dlll/YjmAbHsDgdAZGAvFPevXeuX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780631459; c=relaxed/simple;
	bh=/gYjDDnZRR1Vd0bQ9tglUxNvtcLGHf1+DH9L0c64xvc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eClKs33pa/zc//S4ce+f4wVolpXgq3WwKNsOVVGAXp7uF52lXdonWYkTuBcyL2wdCn/85NpBAdWsxuMIrVlSxmpfR606zAtY6PWmAG/MMeuF+FMGj6N0CCQX1xhxLONFyHLpmF+gFIqsMroujVUmHm5vzGHCWYpHSyhpYCDpb6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YB0hkUnJ; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654NJb8P3656238;
	Thu, 4 Jun 2026 20:50:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=WGhBn0re31fLd4RFFPlltu3
	Z9cx7X0PPG+2ZxQ+uAHs=; b=YB0hkUnJKYwuEEBapw0pK+JfAf9mUAzP//rkB0n
	lkFguB2dRS3jO1sGSSX+RzS8pBUTR6lujPexmTT/0JWgBb7fV8qxiGkw2hTz0U9a
	xrz6gwDIqdMNtemvRO+0Pcv+YRNed0WLPY8PUnA7GjhTNuJn7b8nAIbqK9lM3Cvd
	CEkMzB64acwpwy+G5NlPHExjImh7N+c71vuJsckk5yyDY+awfgVkOGzhcIZQIQHx
	FmUm74dKiY90zRWP/0k5C8IMA2G+R+1mhpnWuS4YvA6JVEbfosa6irUC4tns+NKH
	iRlfEUbPFRJD8kNN6QAI+WT/HJT5Rsi7czry1zK2VmombEg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ejgsp7v3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 20:50:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Jun 2026 20:50:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 4 Jun 2026 20:50:45 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 0CAA63F707A;
	Thu,  4 Jun 2026 20:50:41 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v19 net-next 0/9] octeontx2-af: npc: Enhancements.
Date: Fri, 5 Jun 2026 09:20:20 +0530
Message-ID: <20260605035030.3195141-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2DZXtSRqLuRJACzXgxSI1XvmIMxBuleJ
X-Proofpoint-GUID: 2DZXtSRqLuRJACzXgxSI1XvmIMxBuleJ
X-Authority-Analysis: v=2.4 cv=FJkrAeos c=1 sm=1 tr=0 ts=6a224796 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=1rdZWFfAsYpIarNArpIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMyBTYWx0ZWRfX+O/bQqnDsPFt
 fnNOvI25sx+YxWONVKSs1lY5QiBF2604zVP6KipzKkkkvBFkjwu5GfQVYgkV4glzzrCEwvCWC5n
 F+gWU5fuzGW2PIEUHr5r+zeam/dU8VmsjttqISxNVSz+IOrx/Eobf3sxG2+PmqfuWbFdHEk6SqB
 oGI1OHhbHtOV/83ao+HTCdlanRSeVYZGVD38IZ/Bo7RgwDf6GEfjEv0x+55ZgEhgFW3HPn9+fuw
 mbFoHKOL8C0OGx6MyPz8i4smyG2aFMNJgKHE/lf46oqcK1KkB9HseiOV2GGW5AMCvto8a7vX6Ku
 ZnHj4+TN0T4IRUKDWOKLJW1DovQLFEbnJjhy195V7tYSLpLGEE3BMREvqinz6SpDF1m9V8zFNwk
 Q6yCzCAb7GbTvPKDHeVf5+8TEF8Jm5gUTMrd1mUi2ZqnfpZECAIUJmVXCLTwdnWl/WvRg8kqp8M
 1Q9hRrKIX18acoZ0ESA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295613-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76DAB644F25

This series extends Marvell octeontx2-af support for CN20K NPC (MCAM
debuggability, allocation policy, default-rule lifetime, optional KPU
profiles from firmware files, X2/X4 MCAM keyword handling in flows and
defaults, and dynamic CN20K NPC private state), adds a devlink mechanism
for multi-value parameters, and moves devlink_nl_param_fill() temporaries
to the heap so stack usage stays reasonable once union devlink_param_value
grows (patch 3).

Patch 1 enforces a single RVU admin-function PCI device per system: there
is only one AF; rvu_probe() rejects any additional bind with -EBUSY, logs a
warning, and matches the hardware model so automated reviewers and tooling
can rely on exactly one bound AF instance.

Patch 2 improves CN20K MCAM visibility in debugfs: mcam_layout marks
enabled entries, dstats reports per-entry hit deltas (baseline updated in
software after each read; hardware counters are not cleared), and mismatch
lists enabled entries without a PF mapping.

Patch 3 allocates the per-configuration-mode union devlink_param_value
buffers and struct devlink_param_gset_ctx used by devlink_nl_param_fill()
with kcalloc()/kzalloc_obj() and funnels failures through a single cleanup
path so the netlink reply path stays safe as the union grows.

Patch 4 (Saeed) introduces DEVLINK_PARAM_TYPE_U64_ARRAY and nested
DEVLINK_ATTR_PARAM_VALUE_DATA attributes so drivers and user space can
exchange bounded u64 arrays; YAML, uapi, and netlink validation are
updated.

Patch 5 adds a runtime devlink parameter srch_order to reorder CN20K
subbank search during MCAM allocation (the param uses the u64 array type
from patch 4).

Patch 6 ties default MCAM entries to NIX LF alloc/free on CN20K, adds
NIX_LF_DONT_FREE_DFT_IDXS for PF teardown paths that must not drop default
NPC indexes while the driver still owns state, and tightens nix_lf_alloc
error propagation.

Patch 7 allows loading a custom KPU profile from /lib/firmware/kpu via
module parameter kpu_profile, with cam2 / ptype_mask wiring and helpers
that share firmware-sourced vs filesystem-sourced profile layouts.

Patch 8 makes default-rule allocation, AF flow install, and PF-side RSS,
defaults, and ethtool flows respect the active CN20K MCAM keyword width
(X2 vs X4), including X4 reference-index masking and -EOPNOTSUPP when a
flow needs X4 keys on an X2-only profile.

Patch 9 replaces file-scope npc_priv and static dstats with allocation
sized from discovered bank/subbank geometry, threads npc_priv_get()
through CN20K NPC paths, and allocates dstats via devm_kzalloc for the
debugfs helper.

This guard is ordered first so later patches assume a single bound AF.
Heap-backed devlink_nl_param_fill() sits immediately before the U64 array param work so
incremental builds stay stack-safe as the union grows; the CN20K patches
keep srch_order ahead of NIX LF coordination, optional KPU profile load
from firmware files, X2/X4 handling, and the npc_priv refactor that touches
the same files heavily.

Ratheesh Kannoth (8):
  octeontx2-af: Enforce single RVU AF probe
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
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  18 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  17 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   7 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  12 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  92 ++-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  77 ++-
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
 20 files changed, 1295 insertions(+), 405 deletions(-)

--

v18 -> v19: Addressed Jakub comments.
	https://lore.kernel.org/netdev/20260602060359.1894952-1-rkannoth@marvell.com/
	Added 1 more patch.

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

