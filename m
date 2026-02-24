Return-Path: <netdev+bounces-260380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJBLBM9anWmxOgQAu9opvQ
	(envelope-from <netdev+bounces-260380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:01:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A305A1835C1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1379303DD07
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A1A3033E2;
	Tue, 24 Feb 2026 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iPIFVqCq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABCF2571B0;
	Tue, 24 Feb 2026 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920059; cv=none; b=MMTDY1FrG9r99hFYTHCpxttLTtjIE+uFSaayWfUvVkU0p0ZFrKQyHkT6JzmJwubcNgANfLWGfdeABfrGTNI+daOJu6WM/wys+2GS9kuFbF/oRnthJS5EQCGc9VarZR0muqSOwpWhZGKsjCuYab/GoZdIkwK8gJbpTCdbmdLCXWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920059; c=relaxed/simple;
	bh=zbtuI8w3o6dXC3snaIA6r/A/uxmP5T8uEVf6KF8rG5o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XyhOyALvwOn8Q2GTbKvOoDB9XnYYd8El4mqVlW6/HxSzZnUPNhSCQ0oS6a9biUWPLS6JYQVPRrIlqch3AdwcI8CS/15/3ckk3x6jJ1EJ1BNZJEUSwjTRTiAu4d0a8kpYpqbVB99PAh+HtdLwoGZjU2MIC1ERUuTXXPltXWj94sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iPIFVqCq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NHMfgf2182532;
	Tue, 24 Feb 2026 00:00:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=92dQ08cIVB14o1Mw+igvNGH
	fOQqoLkwI9H9JiUa3LJA=; b=iPIFVqCq75IjUuGAdjfqV0J9Ll4ECGvUP9+vSPz
	cQwA1l2fhvqdS6T5iV8xcPPgYE7hbme4deT5esLt2TBql/o9VQk/YTQxkABUvyxL
	5+ZfYrhDdn1BaaO8JRmFI0/3i/X1Jt1FTFXaYKGz//hHQE42Dfj0l3FSWzvzRFwY
	FgdlanFeQX/xY2wa+2RvztcJ9fZMFa+4nODGbZ9RUXcCEIuN3Q/F41VRasqxP3Ez
	gWyQpyq0/7Odgegz7cBSQ8U3xSwPKKr7FtgfkPiDVcNJ4VtZPMCOv/Bbl2qP/ctF
	IPfaQRYRFMMBPYTI2w7UN25IcmylqrTEulII9iHWzDxJyqg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cfd3gwarp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 00:00:45 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Feb 2026 00:00:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Feb 2026 00:00:43 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B787E3F70DE;
	Tue, 24 Feb 2026 00:00:31 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v9 00/13] NPC HW block support for cn20k
Date: Tue, 24 Feb 2026 13:29:56 +0530
Message-ID: <20260224080009.4147301-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: u6_rCF7PxZcbIcE4wWciBXfnqgXl78xI
X-Proofpoint-GUID: u6_rCF7PxZcbIcE4wWciBXfnqgXl78xI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA2OCBTYWx0ZWRfX1HpSppQS+L37
 BYp8YmwqV3M59gUsd0SFD2tthcgjs7kdJa5tVwY29HcjPR0XkfNlfwelDXX+NrikJCMJnvBAZyZ
 oV8nS6EJQqVTpoTqDJfHPLfMNvZ1NgJiJONJfhc99xKg55EQeYY4eJndTIF20BOtcqSX7Nnh8gw
 +PAPpZ+WRNRZZdfNg5ghzq6TSlqujW2W7nZpa3pnTzL/Na1tHH6lMZeS+GZl+gUFdPsGGHUlG03
 Rm9Jnuy7filaKfZT6m0c94BG4zWQD4uAMJ1yzmc2zaBzNpKXbBoHy5MRwJARuHb2slBwlVYDMzI
 Cggfna3ArbzY+HKkT+ekPce5JbiTKAvgHigs9mGN5+hZMKVZS5zn9kEbCVZOjmUrEsA3OXnvneO
 grEy1vTsC8rFEkXi2m7SBQPqTCdiXcpijfOhJ/5hZyDsbsTNk8jVUFdXtD/zBqsLpEShV/k7sVD
 RwrE3nCeJREnwOFWR2g==
X-Authority-Analysis: v=2.4 cv=H5XWAuYi c=1 sm=1 tr=0 ts=699d5aad cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=nQb7NifI8gXvS-jv4YYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[marvell.com:query timed out];
	TAGGED_FROM(0.00)[bounces-260380-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A305A1835C1
X-Rspamd-Action: no action

This patchset adds comprehensive support for the CN20K NPC
architecture. CN20K introduces significant changes in MCAM layout,
parser design, KPM/KPU mapping, index management, virtual index handling,
and dynamic rule installation. The patches update the AF, PF/VF, and
common layers to correctly support these new capabilities while
preserving compatibility with previous silicon variants.

MCAM on CN20K differs from older designs: the hardware now contains
two vertical banks of depth 8192, and thirty-two horizontal subbanks of
depth 256. Each subbank can be configured as x2 or x4, enabling
256-bit or 512-bit key storage. Several allocation models are added to
support this layout, including contiguous and non-contiguous allocation
with or without reference ranges and priorities.

Parser and extraction logic are also enhanced. CN20K introduces a new
profile model where up to twenty-four extractors may be configured for
each parsing profile. A new KPM profile scheme is added, grouping
sixteen KPUs into eight KPM profiles, each formed by two KPUs.

Support is added for default index allocation for CN20K-specific
MCAM entry structures, virtual index allocation, improved defragmentation,
and TC rule installation by allowing the AF driver to determine
required x2/x4 rule width during flow install.

Ratheesh Kannoth (7):
  octeontx2-af: npc: cn20k: Index management
  Add CN20K MCAM allocation support. Implements contiguous and
  non-contiguous allocation models with ref, limit, contig,
  priority, and count support.

  octeontx2-af: npc: cn20k: Allocate default MCAM indexes
  Allocate default MCAM entries dynamically in descending index
  order during NIX LF attach, reducing MCAM wastage

  octeontx2-af: npc: cn20k: Prepare for new SoC
  Introduce MCAM metadata structure so low-level functions no
  longer receive SoC-specific structures directly.

  octeontx2-af: npc: cn20k: virtual index support
  Add virtual MCAM index allocation and improve CN20K MCAM
  defragmentation handling. Track virtual indexes and restore
  statistics correctly.

  octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation
  Extend install_flow mailbox so AF can determine rule width and
  complete allocation and installation in a single exchange.

  octeontx2-af: npc: cn20k: add debugfs support
  Debugfs entries to show mcam layout and default mcam entry allocations
  Legacy debugfs entries are modified to show hardware priority on cn20k
  SoC.

  octeontx-af: npc: Use common structures
  Low level functions should use maximum mcam size array and modify cam0
  and cam1. This is a cleanup patch.

Subbaraya Sundeep (1):
  octeontx2-pf: cn20k: Add TC rules support
  Add full TC dynamic rule support for CN20K. Handle x2/x4 rule
  widths, dynamic allocation, and shifting restrictions when
  mixed rule sizes exist.

Suman Ghosh (5):
  octeontx2-af: npc: cn20k: KPM profile changes
  Add support for CN20K KPM profiles. Sixteen KPUs are grouped
  into eight KPM configurations to improve resource usage

  octeontx2-af: npc: cn20k: Add default profile
  Update mkex profile for CN20K and mark unused objects with
  may_be_unused to silence compiler warnings.

  ocetontx2-af: npc: cn20k: MKEX profile support
  Add support for the new CN20K parser profile. Introduces the
  extractor-based model with up to twenty-four extractors per
  profile.

  octeontx2-af: npc: cn20k: Use common APIs
  Update common MCAM APIs for CN20K. Add new register handling,
  new access algorithms, and CN20K-specific index management.

  octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon
  Add CN20K-specific MCAM mailbox messages for updated mcam_entry
  layout and avoid breaking backward compatibility.

 .../ethernet/marvell/octeontx2/af/Makefile    |    2 +-
 .../marvell/octeontx2/af/cn20k/debugfs.c      |  273 +
 .../marvell/octeontx2/af/cn20k/debugfs.h      |    3 +
 .../marvell/octeontx2/af/cn20k/mbox_init.c    |   17 +
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 4421 +++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  340 ++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   65 +
 .../ethernet/marvell/octeontx2/af/common.h    |    4 -
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  172 +-
 .../net/ethernet/marvell/octeontx2/af/npc.h   |    2 +
 .../marvell/octeontx2/af/npc_profile.h        |   84 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   94 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   18 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |   76 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |   90 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |    1 -
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  580 ++-
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |   21 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  693 ++-
 .../marvell/octeontx2/af/rvu_npc_fs.h         |   14 +-
 .../marvell/octeontx2/af/rvu_npc_hash.c       |  128 +-
 .../marvell/octeontx2/af/rvu_npc_hash.h       |    2 +-
 .../ethernet/marvell/octeontx2/nic/cn20k.c    |  265 +
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   13 +
 .../marvell/octeontx2/nic/otx2_common.h       |   35 +
 .../marvell/octeontx2/nic/otx2_flows.c        |  267 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |   77 +-
 27 files changed, 7286 insertions(+), 471 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h

--
v1 -> v2: Addressed comments
v2 -> v3: Resolved build errors, addressed comments
v3 -> v4: Address comments from Jakub
	 https://lore.kernel.org/netdev/20260109054828.1822307-12-rkannoth@marvell.com/T/#t
v4 -> v5: Addressed comments from Jakub
	https://lore.kernel.org/netdev/20260113101658.4144610-6-rkannoth@marvell.com/
v5 -> v6: Addressed Jakub comments.
	https://lore.kernel.org/netdev/20260126123254.1000480-11-rkannoth@marvell.com/T/#t
v6 -> v7: Addressed Jakub comments.
	https://lore.kernel.org/netdev/20260128071235.3577206-2-rkannoth@marvell.com/T/#t
v7 -> v8: Addressed Jakub comments.
	https://lore.kernel.org/netdev/20260129083339.264386-12-rkannoth@marvell.com/T/#t
v8 -> v9: Addressed Jakub comments.
	https://lore.kernel.org/netdev/20260204182428.05a77b13@kernel.org/

2.43.0

