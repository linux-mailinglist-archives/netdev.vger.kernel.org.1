Return-Path: <netdev+bounces-247741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4DDCFDF8F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA81A301936B
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A91334C05;
	Wed,  7 Jan 2026 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lXN1hqlW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA43346B9;
	Wed,  7 Jan 2026 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792266; cv=none; b=Mcxs34TNhtsZCuY9mjh6Ng9t3JAZozu0ZdyeVFeXTmUNAJapoacWcu0HHSnpeHfaYfC2jLCMUiqQbRhhhD+Ui+THotR6K3qfVuJ7D6lbnIHCthyM5H22pZLWsaO+wjYyFdDSP9C5TIFtDe+mfGXuc/dYEfcaExm4VIzM5INAMLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792266; c=relaxed/simple;
	bh=F9RrKDoP89ksDR30EK1rrk2PGiB8ie+HEZ1iF2jUPeE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cueXq3lXLF44lsN3lHwu0BxS+8WxdujIip9PbL7JiAG5ZdKTfYjqpCMPye5DgYWMVNi56LQDYLr0dNtUB6plRvWVPFgTHTGfGk4XhhFSfyds2LvIyZau4fUNvntZowX/oCKR8aMjhlnom57RuMF4L5ctiG1PiGdJobn+EIVjpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lXN1hqlW; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6071DbME2795403;
	Wed, 7 Jan 2026 05:24:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=lp3ipfX6smHR4mmwoTsnFb+
	75o6rQsxaBkPodIDUj9Y=; b=lXN1hqlW0za/fhXCafSlS+TJAajw5rL9mMI4UJW
	1CIonKWZ+BCajkXQISvwdoNRtWsLi9rZTGHoBAZee5f90yDIE0m8rEamnjMRzbpY
	Arq6qDWnTaquZBBZCdTZMTuFdAlCdqPdNtU4GTVMnGHDnOyqfK7F1pAvhSRMdJBc
	zR9rRFAiWzpJFdMh7of4kQoKc8o7juwYAS9jIL3ilO9PnoEswV+NOalaY4NxYduV
	y0DCjQflBzrnLfVtDcoFIc3cYaIYFMTgyB6upjKDsnGjSCrTm4Uktln6YMMWd4Jc
	WCODAGSvSux+JJiQLxJs5xBuMjy3FsfXxZKl4UuiorBRmNQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bgf3fw1ux-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:24:17 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:24:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:24:31 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id AD7D03F70B2;
	Wed,  7 Jan 2026 05:24:13 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next v2 00/10] Switch support
Date: Wed, 7 Jan 2026 18:53:58 +0530
Message-ID: <20260107132408.3904352-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PLgCOPqC c=1 sm=1 tr=0 ts=695e5e81 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=4rCbcO1rH8UwRTBQTsMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfX8ZMf81LORnp2
 bK7zTGYW5EXlJbovyZrDb1AiHDaxTtPYVe0oG+7qWwswKArogQZweFUtX89EjIHEDQLbtNCDJTn
 jnnPDK40kHC6FD1aXkqoAdMpriXICMSkEwXph2FZvlM9oRPDrOfuFI0pc/6eDMgjeGpEnlaNL4K
 UZDjXubK2uQKjCzWYnhnDlaITD9aUY9GnNsnOkBbLiBnGTsRHI98j0ura51mhWi4DiwHK04KjNx
 qtvgyXrVA3zU34SRGF46iBNKxjXWB6zeZqoCSTkVuys3RqclpNRvW885uJEaSz0X7BMGhyHNPbu
 hVLpAQcyte4eObyYlzARhQd6IjDLky+G1qXV5u4N2wb8f3y6P8yGKKai8qFUDwQfTVnpQREk2G+
 vxbJ1YHNwC2wh6+mZw/llvSq4xlHS1+M4PdQxi9yqAqRqe0a7aovTTEq58RC0alcfwh6nxJP2vP
 +wSALJPXK3Tyta5HlmA==
X-Proofpoint-GUID: _PtcE0-NN43kQ6hA_X3qWaGWJ6Hx9n57
X-Proofpoint-ORIG-GUID: _PtcE0-NN43kQ6hA_X3qWaGWJ6Hx9n57
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01

Marvell CN10K switch hardware is capable of accelerating L2, L3,
and flow. The switch hardware runs an application that
creates a logical port for each representor device when representors
are enabled through devlink.

This patch series implements communication from Host OS to switch
HW and vice versa.

   |--------------------------------|
   |            HOST OS             |
   |                                |
   | eth0(rep-eth0)  eth1(rep-eth1) |
   |  |                 |           |
   |  |                 |           |
   ---------------------------------|
      |                 |
      |                 |
  ---------------------------------|
  |  lport0             lport1     |
  |                                |
  |            switch              |
  |                                |
  ---------------------------------|

When representors are created, corresponding "logical ports" are
created in switchdev. The switch hardware allocates a NIX PF and
configures its send queues. These send queues should be able to
transmit packets to any channel, as send queues as from same NIX PF.
Switch is capable of forwarding packets between these logical ports.

Notifier callbacks are registered to receive system events such as
FDB add/delete and FIB add/delete. Flow add/delete operations are
handled through the .ndo_setup_tc() interface. These events are
captured and processed by the NIC driver and forwarded to the switch
device through the AF driver. All message exchanges use the mailbox
interface.

Bridge acceleration:
FDB add/delete notifications are processed, and learned SMAC
information is sent to the switch hardware. The switch inserts a
hardware rule to accelerate packets destined to the MAC address.

Flow acceleration:
NFT and OVS applications call .ndo_setup_tc() to push rules to
hardware for acceleration. This interface is used to forward
rules to the switch hardware through the mailbox interface.

Ratheesh Kannoth (10):
  octeontx2-af: switch: Add AF to switch mbox and skeleton files
  Mbox message for AF to switch

  octeontx2-af: switch: Add switch dev to AF mboxes
  Switch to AF driver mbox messages

  octeontx2-pf: switch: Add pf files hierarchy
  PF skeleton files for bridge, fib and flow

  octeontx2-af: switch: Representor for switch port
  Switch ID is copied and sent to switch when Representors are
  enabled thru devlink. Upon receipt of the message, switch queries
  AF driver to get info on rep interfaces.

  octeontx2-af: switch: Enable Switch hw port for all channels
  Switch ports should be configured to TX packets on any channel.

  octeontx2-pf: switch: Register for notifier chains.
  Notifier callback for various system events.

  octeontx2: switch: L2 offload support
  Bridge (L2) offload support

  octeontx2: switch: L3 offload support
  FIB (L3) offload support.

  octeontx2: switch: Flow offload support
  Flow (5/7 tuple) offload support.

  octeontx2: switch: trace support
  Trace logs for flow and action

 .../net/ethernet/marvell/octeontx2/Kconfig    |  12 +
 .../ethernet/marvell/octeontx2/af/Makefile    |   2 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 219 ++++++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 111 +++-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  54 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  77 ++-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  13 +-
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   |   3 +-
 .../marvell/octeontx2/af/switch/rvu_sw.c      |  47 ++
 .../marvell/octeontx2/af/switch/rvu_sw.h      |  14 +
 .../marvell/octeontx2/af/switch/rvu_sw_fl.c   | 294 ++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.h   |  13 +
 .../marvell/octeontx2/af/switch/rvu_sw_l2.c   | 284 ++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.h   |  13 +
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   | 215 ++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.h   |  11 +
 .../ethernet/marvell/octeontx2/nic/Makefile   |   8 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |  17 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   8 +
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  10 +
 .../marvell/octeontx2/nic/switch/sw_fdb.c     | 143 ++++
 .../marvell/octeontx2/nic/switch/sw_fdb.h     |  18 +
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 133 ++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     |  16 +
 .../marvell/octeontx2/nic/switch/sw_fl.c      | 544 +++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.h      |  15 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 629 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.h      |  31 +
 .../marvell/octeontx2/nic/switch/sw_trace.c   |  11 +
 .../marvell/octeontx2/nic/switch/sw_trace.h   |  82 +++
 32 files changed, 3040 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h

--
ChangeLog:
v1 -> v2: Fixed build errors
2.43.0

