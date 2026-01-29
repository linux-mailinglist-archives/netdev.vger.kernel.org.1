Return-Path: <netdev+bounces-254640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNrqH4wbe2msBQIAu9opvQ
	(envelope-from <netdev+bounces-254640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:34:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A60AD8CD
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79318300493A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609FB37BE73;
	Thu, 29 Jan 2026 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="amtVoAHq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32D2BEC5E;
	Thu, 29 Jan 2026 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769675657; cv=none; b=osSwZ0FjK3SMNJjR/wuzKFcg6lvpqJR9OUDq/GXSjFm51tGRe//iy3am5s3dpyzvz/Vfx7ke8y5GbugS5G2kzjpX8mV5wm/yCD0T5+pBlhSy0pUskNmEFqpKzBWKAzFjluWUsuz1ayhJ4BsA283rfCAEwRzsfdU5cxZSX4DE3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769675657; c=relaxed/simple;
	bh=y5Gx2vaK3nsC5q+0hq1g7QI5tPImpOaai6abjH9sQvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D8wOU0wowGME5k+Zlh6EQ20KEf3Bf1DFBamL6peBNnD4rhCP0Uj6BC9xY40wOMaohR0jOzOyEh6amMD1XLblf2OnoP0064v/VYTCxfIGU5+1T0cyP5ePv3z1mpWdJMBhu0HAySAJeNvInC99JSXnLiaAJU4sbGiYUqEOnflLhQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=amtVoAHq; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T0vxPs3596678;
	Thu, 29 Jan 2026 00:33:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=+i65iIqChd+r5VBtxPWcC0d
	GRfRMITjzY7V1wto3NPg=; b=amtVoAHqkzD6B0/em96kdi+ng5ScZCRkKi4Gs7E
	QQ+Xen7KPsYzn/Huisqz6aZP64vI9Xu9Jh3MY8PAH89VUhVPMuB4U0LDZA6ov4o3
	803tgMtlnH+1h2ZV+G8RqzeXNXpDBAFp5hksoDpSqUdVUXe/HhNgKa+0YDhVSAW7
	d9W318C0yYGYDmPdbsSaRX4eBlZqeYK2cRwNtui3QPYEtEDNugVHLPob9OtudMRo
	Q/TI74+Ooat8FbVXHFi8e49DRopygZ0LBYhHpCsEI1rlwZYbXZ5pa9MFmsyCdGLO
	kLRMV0fwckxe8Bwr2amtUrzp6t6MsmzLKnVQ11JXNfgmX1A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4byd0fkeh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 00:33:48 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 Jan 2026 00:34:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 29 Jan 2026 00:34:04 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 16DE33F70DC;
	Thu, 29 Jan 2026 00:33:44 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v7 00/13] NPC HW block support for cn20k
Date: Thu, 29 Jan 2026 14:03:26 +0530
Message-ID: <20260129083339.264386-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Vpkuwu2n c=1 sm=1 tr=0 ts=697b1b6c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=nQb7NifI8gXvS-jv4YYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: mQkz9soYRu-C6prf9VFxI5wFDUnBBHIz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA1MiBTYWx0ZWRfX6wtyOa/Ps+EN
 G0jIsz6rTf1uNvSRz88cL0NDU0EsnbzMo9EPupMGKL5LWTuLzb1ldmEc9d+kKwo4WZaj8kBmzf9
 Y336K7fYrTs8JnxonhARmy/ytOwNCb1Hykccd4wsYIgWtNPz2IqFES7KCgRAw5XzJ30mUL9rkgW
 i84YSKFHjMCmCPJuGSZYNpAlHigCRfqFAh6yWHNLLxnzPOrF/xQV5L/wGYY6Qiv7yJOHRSic3cb
 WVME54sjpJwPKHegvJFk30kkoRl/cVu7FmPSG8qOTnB557e4SJQk79ZbWdO/5Hf6HKtYUKgETIR
 5BY2910mbvDFkA9hM9ygyZ390l6Uthn9yVGRRiIUIj957xeRNn4VUP/ict734kLqKoF+vAW8l4V
 6LclXI3kEDEpM2dzlFvaQyK94kXsDdnrdmrnALKF63jrnMMWeXe3PNvbixPb6CHMJJHieKa0Sr7
 caJ6KjlvBEIDmWZ+AgQ==
X-Proofpoint-ORIG-GUID: mQkz9soYRu-C6prf9VFxI5wFDUnBBHIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_01,2026-01-28_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254640-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22A60AD8CD
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

2.43.0

