Return-Path: <netdev+bounces-271432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKFeMA2Ow2lVrgQAu9opvQ
	(envelope-from <netdev+bounces-271432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:26:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D7320AA0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 348513068A03
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858CA368263;
	Wed, 25 Mar 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I1XG84Qf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE03734CFBA;
	Wed, 25 Mar 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423363; cv=none; b=ASssgRODrs7fJyZfeZeEDhINE4uKkaoYfgnaC9HTE3qk2tn3h8R7Za1x1Ti4VzaXcmUup9XXP6/S8quexC+Nnh49hdd47TNm0YfJyvfrOe3Pia033QnxoM1otvUMjDrjOd3G3Rmd5me3ZYctvyf/c5I6AXJ3SAbY0gvVlQ7rFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423363; c=relaxed/simple;
	bh=U3SiB4CukSaaSjz/3kNQBGMuzbBCfZ3W2vcn/WOQprw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LwcsleKdRr4iybIuwVFeuk+Xav8PmfHYaHq4OzQUqzBxcjzd9ONolYM5kx8C8SqRI/Itkv6jIjDfWqSlXOktfJm4oYqmlkpFGyLh33K0aBBazAYeKB40FGiLipSR0ZNYPS+4448LP4jfrUWc9UB8EohIxBtXUG9L4tRk65rP0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I1XG84Qf; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P3GsEa462835;
	Wed, 25 Mar 2026 00:22:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=XmZZcFAzYgebUWMrfydMr17
	wUwT/vxzmz11i787uBpc=; b=I1XG84QfhF1SSxJ95Nj2l0+O4RZgkOxwyzoSlK5
	2DVzZfEd1zlPJ2i1+BQi9GiiI9agDDw4qUsSA8QTSkWrLiOvz+k6ix5ZcT1NMETk
	jVfpCQ5FAvRG0yAgW2Kexk1FHj0UlT7V/rvZ5ObjIGP6tAXPCPNhbWgGW+xV8RhI
	qNAFuNQQ3amKKDXCxsh79U38W0LNFdEwLLhCqnEBk4TwfJ6dT0dzxvLr3+521q63
	p1HWWhgWJ3u5GWYRqxyCDePmaj00H37e8YScSUUPLtxkSlfxtDwbkVpkCZppr9qW
	yzkiqcO8BXlZ+2IQibMzYR6l4q2YNeueXLi4LrrY+Be8AsQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d47na8e4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 00:22:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Mar 2026 00:22:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 25 Mar 2026 00:22:10 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 533993F7076;
	Wed, 25 Mar 2026 00:22:05 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, <dtatulea@nvidia.com>, <tariqt@nvidia.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v8 net-next 0/6] octeontx2-af: npc: Enhancements.
Date: Wed, 25 Mar 2026 12:51:53 +0530
Message-ID: <20260325072159.1126964-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA1MSBTYWx0ZWRfX4BDNcVj5/exS
 OUSfCHLzKmBQOZJfYhLk+aIfaU1P88w3mkToGvd9OiYHOiUiUQeSeudr91m68JvMbRYemJQ6DSs
 WWoltt86QPRrM/OTz8+CGoy7/WqbnR2XERz/BAHWboCaAVeFkV17YiRH3Dhk2JoCkRHK+aRyPed
 CJqUmlZDIGCeF5tS436YjSyipE9PqDxaRBybrJ0rkqkMm02T+/0b2gYVcejLrfQamLbaCXoTc7F
 alKUO0lufw35LeR5sEQPN3feBHA87QWHkumSj5QKWOqa3VB1gI76qnHGBuOumfSpvs9kSU9QTfO
 t2twN9l5FWe+kQ+bcsDvRYbmqLHMJa7JNoPezGs+GfYDXWpVBC0n/14nt5jCkSz5WzjH+LEo1/H
 0X+EzvCAZr9liSuvQ/qr1NpIcyLzlOSTVxl58/Ff6BLm9xpGsWCqIIoUuE+LxCCjV6hNXOaWEpR
 RV/OTYeOBX9GooRgFgQ==
X-Authority-Analysis: v=2.4 cv=LsifC3dc c=1 sm=1 tr=0 ts=69c38d24 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=F3GfQixlnA_JdfTOFKwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: duHt4wvvFaWv8zdS5RIvqbZDlO0kJFEk
X-Proofpoint-GUID: duHt4wvvFaWv8zdS5RIvqbZDlO0kJFEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271432-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E46D7320AA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series extends Marvell octeontx2-af support for CN20K NPC (MCAM
debuggability, allocation policy, default-rule lifetime, and optional
KPU profiles from firmware files) and adds a devlink mechanism for
multi-value parameters, with a small mlx5 follow-up to keep stack usage
within -Wframe-larger-than limits once union devlink_param_value grows.

Patch 1 improves CN20K MCAM visibility in debugfs: mcam_layout marks
enabled entries, dstats reports per-entry hit deltas, and mismatch lists
enabled entries without a PF mapping. MCAM enable state is tracked in a
bitmap updated from the CN20K enable path.

Patch 2 heap-allocates the temporary devlink param value array in
mlx5e_pcie_cong_get_thresh_config() so a larger union devlink_param_value
does not overflow the stack (patch 3).

Patch 3 (Saeed) introduces DEVLINK_PARAM_TYPE_U64_ARRAY and nested
DEVLINK_ATTR_PARAM_VALUE_DATA attributes so drivers and user space can
exchange bounded u64 arrays; devlink_nl_param_fill() moves large locals
to the heap as well.

Patch 4 adds a runtime devlink parameter npc_srch_order (U64 array) to
reorder CN20K subbank search during MCAM allocation.

Patch 5 ties default MCAM entries (broadcast, multicast, promisc, ucast)
to NIX LF alloc/free on CN20K, adds NIX_LF_DONT_FREE_DFT_IDXS for kernel
PF suspend-style teardown, and adjusts free-all and default-entry paths
so default rules are not freed as ordinary user rules.

Patch 6 allows loading a custom KPU profile from /lib/firmware/kpu via
module parameter kpu_profile on non-CN20K paths, with cam2/ptype support
and shared helpers for firmware-sourced vs filesystem-sourced profiles;
CN20K continues to use its existing custom KPU apply path.

The mlx5 change is placed immediately before the devlink union growth
so the series applies cleanly and stays warning-free when built
incrementally.

Ratheesh Kannoth (5):
  octeontx2-af: npc: cn20k: debugfs enhancements
  net/mlx5e: heap-allocate devlink param values
  octeontx2-af: npc: cn20k: add subbank search order control
  octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM
    entries
  octeontx2-af: npc: Support for custom KPU profile from filesystem

Saeed Mahameed (1):
  devlink: Implement devlink param multi attribute nested data values

 Documentation/netlink/specs/devlink.yaml      |   4 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 126 ++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 255 +++++++--
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  10 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  17 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   6 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  92 +++-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  16 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 521 ++++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |  17 +
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   6 +-
 .../mellanox/mlx5/core/en/pcie_cong_event.c   |  11 +-
 include/net/devlink.h                         |   8 +
 include/uapi/linux/devlink.h                  |   1 +
 net/devlink/netlink_gen.c                     |   2 +
 net/devlink/param.c                           |  91 ++-
 18 files changed, 979 insertions(+), 206 deletions(-)

--
v7 -> v8: Addressed Simon comments
	https://lore.kernel.org/netdev/20260323035110.3908741-1-rkannoth@marvell.com/T/#t

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

