Return-Path: <netdev+bounces-246834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 641C0CF1A19
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 03:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 355E33006620
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 02:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70C72D7DD3;
	Mon,  5 Jan 2026 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Mp+1yKpM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB322129B;
	Mon,  5 Jan 2026 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767580424; cv=none; b=JRO5j5DpDCH7ZR+njJtCu8tWhnAOpORsQzG1HZZ7D1uul6AOOxw0WHdzRgwLDjiWjYl/zh2WHoIJ4wimaPvlwJyCg4x9VDqdjDIVQA3eDl9aMhjVa1En445+XCojnobrFjyr4XFCPLA/8bgynoI6GhdSnCj/MkLZOheJTD3IyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767580424; c=relaxed/simple;
	bh=gU6/7Gxe/8XpDkO/Rn49b8/WoDEfiAp+9Qe/G5Z9aaE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uraple+E5QuVWSY9c5GCuyuIWi4ejFQW/b5rHNq2rdjStEfVo3a4f82eR9kEpYjT7M6v9VLy2jq1pzX4XAS3Ku0B3L38AIB4Oy7rm7NNIRc3AGErFggOCyJTtQpJMsHoYzvkYN50AQ0T1GomMWyN0ywBRGxY0zFZEaOik/J9ncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Mp+1yKpM; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604NvfsS2372107;
	Sun, 4 Jan 2026 18:33:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=4Y3H16f2BXhqxQ0f1EsQ5t+
	TeoNT+ZCevUxpClG9IOs=; b=Mp+1yKpMDyiWw8jJaZr60KhBMgFHCyKyIlM4CBT
	kkymSnJHzBpqE6/4dBBmsMP3WTstzMaoZOS+bQXx5aGIxJx98Tr0uS8t7fE4NwbM
	fwrQijwL0uitVnC6DbfiF3l0OUlpDIacEL2xMnK8eW4DOXk+ftsBg+PlDprJR1Ok
	Abou7qnoDqh05qB2owuVSXKdkdQSAG1eZpyAhkSip4hsUE7NSf6+Eon3OqA4FhHg
	UnGJxrBmXQ/j5q7JCd9tDwt8fCxVj54/SKeI0mVAdlKOhiS3D2abN9Rng9PYw4kh
	hcKFaKlduMhKN7WcFbO8ORIGvnMYKahXQPCBMh/9hPnGMXQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bfmrbs02q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 18:33:20 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 4 Jan 2026 18:33:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 4 Jan 2026 18:33:19 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A8A835C68EE;
	Sun,  4 Jan 2026 18:33:16 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <sumang@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next 00/13] NPC HW block support for cn20k
Date: Mon, 5 Jan 2026 08:02:41 +0530
Message-ID: <20260105023254.1426488-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=bN0b4f+Z c=1 sm=1 tr=0 ts=695b22f0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=A1wDlwXRn1NGPBHeO_kA:9
X-Proofpoint-ORIG-GUID: VekP7mLR382D3ztcNdQ8owg698QMySRA
X-Proofpoint-GUID: VekP7mLR382D3ztcNdQ8owg698QMySRA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDAyMSBTYWx0ZWRfX+HdEY5CTKnou
 K12FAfaYzjRbl1hb1SOTDqvObhPwppR3cGu3kZjyxx2jWjik/O7FixuxutiiJ9MxCQKSzNnkFx2
 TLosSjgtonKDlt41tEqnydKOY89Ob1GJVRd+fee6NXLi8SBhvIOQn0+XjdnrbQx5wa3jPWIijgR
 HTP9QBS2uTL7tyXM1KG+2GC3rHF97XsIy0zhg4wXRF0bDjDI1jlNQTr0BvPF/ZWL7uxHOZ00sDs
 Fun2JdaONqGaiNYe3y84ncCKuOSsLDLI5sd8QgZXaJPRaAWVl/+T0zlf7bs/BCTTFVM5EiAXeVY
 Tk8pRZe7G2NBmU0m6qOBCiMRLy5gsm0YxU0yXNlkAwbhNsHJTJGSrDT6GQ6i8Rck3iCNyZuXhXc
 MJhI33GdFiTphCwYeaPWoAfGJEQMXy1cRvdJR5KA+XlY215PZ76Hsm9p1GgIVn8XICiuHrKRey0
 Yt8Ch1IuEkqRf4f5DSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_07,2025-12-31_01,2025-10-01_01

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
2.43.0

