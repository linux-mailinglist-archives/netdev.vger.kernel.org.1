Return-Path: <netdev+bounces-253467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MC0Icxfd2n8eQEAu9opvQ
	(envelope-from <netdev+bounces-253467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:36:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F678858D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 829933026AA7
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FEE3016FC;
	Mon, 26 Jan 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hRiZFrh4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34025DD1E;
	Mon, 26 Jan 2026 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430804; cv=none; b=C3l0cuxHEE9pU97+qpRk2Uj/PhjVduZ7bJueKvY1uwqyw2lHlx2YcxZWrNq7lZBKlLv7YN1husil0bXM7OVSDTgF7ERPVtQXeeCu9LEd1Sx9OAiIgswoTkwXx2EKZnKT2h4ZPmDG062QrT4Rzfamta8YOjEYCTZo9izv/CnVR74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430804; c=relaxed/simple;
	bh=ZREDIf6krv7feMki999FgAwEP76fHYD8y3XIdOwuu6g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PggNeqj/RUG2xREd5xlSmmTbfn+3VAUfKHJN+5Mmj4H9oEWexlwnu2vRJ1T9Psf+a/F4KAXvYUgh05k6Z3JRsKCDsjO2U/t5KzEAbwlnCU2gwcEHZ9muOdmthJpUPOWtH0XW0lO8l6rJbupkNmw6azC7OaMkBaG5phPkNhPIxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hRiZFrh4; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q9dhtg4175220;
	Mon, 26 Jan 2026 04:33:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=vRyKl4mOPGPHX0rmBrOfwRm
	MIucbzDb0IO+yMjyJBN8=; b=hRiZFrh4Y0FND65f7d7hhDUESXecZgSGGz6LqrY
	PnCSCECmbEQDuUKAtFXEFPc0PaJm47fGIpB7VeWdEjzoWm/+CSG6UbIXW1JFlwLW
	HxZgiCRft8IzXSL9ye2ATKJLJlG5go9ui21t5XESX4/QjSdea24E6O5UoXASN+So
	p1mJnLLfl7y1az0jVTUP613SXYKt0ImKx8bKAUbqfjp6mYdi7viInGqSSiswB7m1
	SdvwkKZaovMJn17oGaaFhOMZplZzCmMr+zseIuuEKeNsc94P2ZvahNorLcOLiABb
	Yk7rDgX76BZC3HaknEeuOQjhFjQFsOZRGlA/YncHD8kwdaA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bvxfjjqk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 04:33:13 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 Jan 2026 04:33:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 26 Jan 2026 04:33:12 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 1CA143F70B4;
	Mon, 26 Jan 2026 04:33:09 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v5 00/13] NPC HW block support for cn20k
Date: Mon, 26 Jan 2026 18:02:40 +0530
Message-ID: <20260126123254.1000480-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qn0-nzvO54DHXBXERd-Y2WR5fDLmI_r8
X-Proofpoint-ORIG-GUID: qn0-nzvO54DHXBXERd-Y2WR5fDLmI_r8
X-Authority-Analysis: v=2.4 cv=S9LUAYsP c=1 sm=1 tr=0 ts=69775f09 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=A1wDlwXRn1NGPBHeO_kA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEwNiBTYWx0ZWRfX7OKoYr6JfkoQ
 Y3WoB1UqNpRAw/Nds5CO/U/T8Sqf6OzMCowyVoAgpUPj52w9H8xlH6QIIUZSLA7u2qVMzAplvqd
 6KdkwahVHtoFZOUdmoI5hXNZ4e3ioNhD8jah4ObM3MqW3NAOswuIx6nl4HXt8VLeq6DE0YTINeM
 Rd2J88OT3tMWHyt6TTA9Dw/XhAhZwpLP0gfYi6S7NaG2CSteBVElFtjHmQPPlNBj30ZO/Ql6ZoE
 y81sMZ4FrLDmc8sHZSlXveWNXG3cOastbtYhQMZJL20DJkcLjr98hgdHmnIaqktq+S9+1fIz2bf
 n9NwZVp1FPnyMFMLNFukmYtwGYGO3Xydoyf7LWgtEUHWkK5f8g2WAjhRUakGr4WdW5VykKYH27X
 K9GfWzRYWRHPEiE8m2jzrjuc3Mh6LHxnlQ54Ih1IPFrVVWKRfWhXAbDptFlU+RSW65VvxfuvmzJ
 aVIngliDkNHiEvCtXww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253467-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E8F678858D
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

 MAINTAINERS                                   |    2 +-
 .../ethernet/marvell/octeontx2/af/Makefile    |    2 +-
 .../marvell/octeontx2/af/cn20k/debugfs.c      |  437 ++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |    3 +
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 4368 +++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  262 +
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   58 +
 .../ethernet/marvell/octeontx2/af/common.h    |    4 -
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  173 +-
 .../net/ethernet/marvell/octeontx2/af/npc.h   |    2 +
 .../marvell/octeontx2/af/npc_profile.h        |   84 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   17 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   18 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |   68 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |   81 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |    1 -
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  513 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |   21 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  664 ++-
 .../marvell/octeontx2/af/rvu_npc_fs.h         |   14 +-
 .../marvell/octeontx2/af/rvu_npc_hash.c       |   21 +-
 .../marvell/octeontx2/af/rvu_npc_hash.h       |    2 +-
 .../ethernet/marvell/octeontx2/nic/cn20k.c    |  265 +
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   13 +
 .../marvell/octeontx2/nic/otx2_common.h       |   35 +
 .../marvell/octeontx2/nic/otx2_flows.c        |  263 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |   77 +-
 27 files changed, 7086 insertions(+), 382 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h

--
ChangeLog:
v1 -> v2: Addressed comments
v2 -> v3: Resolved build errors, addressed comments
v3 -> v4: Address comments from Jakub
	 https://lore.kernel.org/netdev/20260109054828.1822307-12-rkannoth@marvell.com/T/#t
v4 -> v5: Addressed comments from Jakub
	https://lore.kernel.org/netdev/20260113101658.4144610-6-rkannoth@marvell.com/
	Removed "write to debugfs" code. Will come back to it after devlink array support is added.
2.43.0

