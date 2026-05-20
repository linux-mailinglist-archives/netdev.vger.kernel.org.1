Return-Path: <netdev+bounces-289960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KlLFD/DDWr32wUAu9opvQ
	(envelope-from <netdev+bounces-289960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:20:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A06D758F7A0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5CEA3071DA3
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE9E3E9C07;
	Wed, 20 May 2026 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="breMbFYf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1413E7BDE;
	Wed, 20 May 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286323; cv=none; b=d6cJWn7PTSWbBe0Ivn2KzlAzKMN/QO3v293Gn58MGQ4MDbsthARN8Tx8f45BZ2HxkZMhmfUIegFZjwYAlJUNJ1wnnbNdutP8PxTPJ/VyKLn0thc4GvXlCm1ZRz3fOsLZdpyoGj3V6kHYfIFe1c22V+oGx5z6eAYT+46VWb5iafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286323; c=relaxed/simple;
	bh=E8Htrmt+rcJg87AeWDWQQUXKfzR1tZ+ZBs2ylFXMXa8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j+I81BsM3zA69tRiNL6Mk6lapgaC41XtAm8kw0ZJdoAGAOoZadq3yFSKlh4skX6Hb5wC0qJV69MFI2Lxyf9qd4ZnCE/amR/COPemJ7YHzFfswrrSvk9kHGbwMeIK1377obj48dDiJRN4v4mrTT/mHYilGcAtdAZnlSbtQdwBzyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=breMbFYf; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7fNc22111008;
	Wed, 20 May 2026 07:11:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Pof6lr/YrcVa4PI1wy0F3Gr
	aN7DWq5zF9dRrK6mLma0=; b=breMbFYfr6/TwnbyCBV2d/ytuG4qn7zuqwTas6M
	/XTCHdx+BXeS2MJ6bXA+vWPbCJCfT+8y9wfoeqSqu4V28oagaGhfRPPo8jGPBBhg
	eWEwgSs5zGkxKqExtsBVlXHCWlk0W6u2VebMdMEorrVvyms0L7DgKKFsB3K9zHOb
	pEtuWnfNxPYyTvii9MV2riF9MhZAkwQ/3r18xqDCsF7Zi+LO5fqwPqFjSeqHSPYo
	/+16MIIUHq9x0TwOsE9mYuIm+2I1in9E4Uzn8VTM9dured0Zjyad+aaN6xCCVd2u
	e75A0MnUpYILs07pQ49Jrvblz/9vFyDWgRRsM5VrFcYJfXw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e8cfmdver-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:11:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 07:11:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 07:11:13 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.74.182])
	by maili.marvell.com (Postfix) with ESMTP id E85715B693E;
	Wed, 20 May 2026 07:11:07 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v3 0/12] net: atlantic: add PTP support for AQC113 (Antigua)
Date: Wed, 20 May 2026 19:40:33 +0530
Message-ID: <20260520141046.2151-1-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=JYuMa0KV c=1 sm=1 tr=0 ts=6a0dc102 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=6fsxrlAsxaJq5BRL9bcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 0VUrMCVjp29sgyG4dfXWQtvxhCIeQ6GA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfX7kRloHb2Ke8c
 odGNcBS82CtMbTpmYoKcT7ZTDpyy6dE7EWiHZP+wYse56uo7buUDHG4SEAaU2JCcDvUl2qgzE+C
 C0pbYvipwvuohA0Ddbt1Ev1w07YhA5HhAlJWLRYUaTynXpAZ432UzkBTv23Ro9PiEqGb1jxRpIo
 XDKvNt4dV7CC1HbPsd+T+TQJ5hDtyKtB9g0Fu3EUPMtJykWdBlZ9AKIDgVE+TBeTLPbgfZD+1Ij
 Rdy8cI5QbSyEzHHHPScm8ReE4jDmrEruOiQaAJkX+qX91RmLDQq2T1/hI0C5hjFynobTLe/7CTT
 bvfBHjTa+sDFTUKYSOjFvDf+++fGzCNL0zUHTMLMI9P1/VX9WMWpqEzobk8oqNEQ8F32S+bLh2w
 eReffZFzocEVUibCxF8c0u8I0Nll20Abkmv6A7IJ4DArg4gNuF+Dh5celC6zTK+5J/7lX3AEYiM
 uE+3ZV4+Q4t/+fcpS0Q==
X-Proofpoint-GUID: 0VUrMCVjp29sgyG4dfXWQtvxhCIeQ6GA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289960-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A06D758F7A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sukhdeep Singh <sukhdeeps@marvell.com>

This series adds IEEE 1588 PTP support for the AQC113 (Antigua) network
controller. AQC113 is the successor to the existing AQC107 (Atlantic)
chip already supported by the atlantic driver.

AQC113 uses a substantially different hardware architecture for PTP
compared to AQC107:

  - Dual on-chip TSG clocks with direct register access instead of
    PHY-based timestamping via firmware
  - TX timestamps via descriptor writeback instead of firmware mailbox
  - Hardware L3/L4 RX filters for PTP multicast steering with both
    IPv4 and IPv6 support
  - Reference-counted shared filter slots managed through an Action
    Resolver Table (ART), allowing multiple rules to share L3/L4
    hardware filters when their match criteria are identical

The series is structured in four parts:

Patches 1-3 prepare the existing L3/L4 filter path:

  Patch 1 corrects flow_type masking and IPv6 address handling in
  aq_set_data_fl3l4(). Patch 2 moves the active_ipv4/ipv6 bitmap
  updates to after the hardware write succeeds. Patch 3 decouples
  the function from driver-internal structures so it can be called
  directly by the AQC113 PTP filter setup code.

Patches 4-5 add the AQC113 hardware infrastructure:

  Patch 4 adds the low-level register definitions and accessor
  functions. Patch 5 adds filter data structures and firmware
  capability query.

Patches 6-7 implement the AQC113 L2/L3/L4 RX filter management:

  Patch 6 fixes the AQC113 HW init path: ART section selection,
  L2 filter slot assignment, and MAC address programming. Patch 7
  implements the complete L3/L4 RX filter ops including reference-
  counted ART sharing and IPv4/IPv6 steering.

Patches 8-12 add the AQC113 PTP feature:

  Patch 8 reserves the dedicated PTP traffic class buffer and
  configures the TX path. Patch 9 extends the hw_ops interface
  with PTP-specific function pointers and updates AQC107 to the
  new signatures. Patches 10-12 implement the full PTP subsystem:
  Patch 10 adds the hw_atl2 register-level PTP clock ops, Patch 11
  adds TX timestamp polling and PTP TX traffic classification, and
  Patch 12 integrates PTP into aq_ptp and the driver core.

The existing AQC107 PTP implementation is not functionally changed
by this series; AQC113-specific code paths are gated on chip
detection throughout.

Tested on AQC113 at 1G, 2.5G, 5G, and 10G link speeds using
ptp4l/phc2sys with hardware timestamping in both L2 and L4
(IPv4/IPv6) modes.

Changes in v3:

Structural (suggested by Paolo Abeni):
- Split old patch 6 into two patches: patch 6 now covers the AQC113
  HW init fixes (ART section selection, L2 filter slot, MAC address),
  and patch 7 covers the L2/L3/L4 RX filter ops
- Split old patch 9 into three patches: patch 10 covers hw_atl2 PTP
  register ops, patch 11 covers TX timestamp polling and PTP TX
  classification, and patch 12 covers aq_ptp and driver core
  integration

Patch 2:
- Fix commit message: remove incorrect claim that bitmap updates are
  removed from aq_nic_reserve_filter() and aq_nic_release_filter();
  the updates are intentionally retained there to support the AQC113
  PTP path which programs filters directly without going through
  aq_add_del_fl3l4()

Patch 5:
- Clamp mac_regs_count loop bound with min_t(ARRAY_SIZE) to prevent
  out-of-bounds reads if firmware reports an inflated count
- Add base_index overflow check for l3_v6_filter_count (was missing,
  already present for l3_v4 and l4 categories)

Patches 6-7 (old patch 6):
- Drop unused hw_get_version op from hw_atl2_ops
- Clamp art_first_sec/art_last_sec to 16 before BIT() to avoid
  shift-past-width UB on section indices >= 32
- Fix hw_atl2_hw_init() to call hw_atl2_hw_mac_addr_set() instead
  of the A1 function hw_atl_b0_hw_mac_addr_set()
- Fix hw_atl2_hw_init_rx_path() to enable the l2_filters_base_index
  slot rather than a hardcoded slot 0
- Fix L3 filter family-switch undo path: remove cross-family pointer
  aliasing; add a guard that aborts reconfiguration when the address
  family changes and the old slot is still in use

Patch 8 (old patch 7):
- Remove unconditional accept_all_mc enable: per-multicast L2 filter
  handles PTP multicast steering; accept_all caused non-PTP multicast
  traffic to receive false timestamps
- Fix commit message: PCIe extended tag enablement is unconditional
  for AQC113 when firmware has enabled the feature, not gated on PTP

Patches 10-12 (old patch 9):
- Initialize clk_select = -1 in aq_pci_probe() instead of
  aq_nic_hw_prepare() so that the sentinel survives resume and
  hw_atl2_hw_reset() can distinguish uninitialised from active
- Add clk_sel < 0 guard in all TSG clock helpers (hw_atl2_tsg_clock_
  read/add/sub/increment_set) to prevent out-of-range MMIO access
  during the window between ptp_clock_register() and
  hw_atl2_enable_ptp() setting clk_select to 0 or 1
- Use WRITE_ONCE/READ_ONCE for clk_select accesses in
  hw_atl2_enable_ptp() and ring init to prevent compiler tearing
- Add READ_ONCE(txts->ctrl) + dma_rmb() before reading txts->ts in
  hw_ring_tx_ptp_get_ts to prevent speculative load reordering on
  weakly-ordered architectures
- Declare hw_atl2_txts_s::ts as __le64 and use le64_to_cpu() for
  correct big-endian portability
- Fix teardown order in aq_ptp_free(): cancel_delayed_work_sync()
  must precede hw_atl2_enable_ptp(..., 0) to prevent the work item
  from re-arming itself after cancellation
- Add ptp_filter_lock mutex in both aq_ptp_clock_init() and
  aq_ptp_hwtstamp_config_set() to serialise concurrent filter
  enable/disable from link state changes and ioctl
- Gate hw_filter_l2_set on AQ_HW_PTP_L2_ENABLE flag in
  aq_ptp_dpath_enable() to prevent a spurious zero-ethertype L2
  filter being installed when only L4 mode is active
- Fix error path in aq_ptp_ring_alloc() to use aq_ring_hwts_rx_free()
  instead of aq_ring_free() (wrong DMA size)
- Propagate PTP ring init return values from hw_atl2_hw_ring_rx_init()
  and hw_atl2_hw_ring_tx_init()
- Move skb_tx_timestamp() from aq_ndev_start_xmit() to aq_nic_xmit()
  after aq_nic_map_skb(), ensuring the SW timestamp is recorded after
  the DMA mapping is committed
- Remove AQ_HW_FLAG_STARTED flag: it has no reader in this series
- Remove stale references to aq_ptp_tx_ts_timedout/aq_ptp_tx_ts_clear
  (functions that do not exist); describe the actual timeout mechanism
  via ptp_ts_deadline in the commit message
- Document double-unmap prevention: buff->is_mapped and buff->pa are
  cleared before the ts==0 break, preventing a second DMA unmap on
  the next aq_ring_tx_clean() pass
- Update HW_ATL2_RXBUF_MAX comment: 172 is the AQC113 hardware
  maximum for data TCs (not a PTP-specific reduction)

Changes in v2:
- Patch 6: Remove redundant variable initializers for art_mask, h, l
  and err as suggested by Vadim Fedorenko

Sukhdeep Singh (12):
  net: atlantic: correct L3L4 filter flow_type masking and IPv6 handling
  net: atlantic: move active_ipv4/ipv6 bitmap updates after HW write
  net: atlantic: decouple aq_set_data_fl3l4() from driver internals
  net: atlantic: add AQC113 hardware register definitions and accessors
  net: atlantic: add AQC113 filter data structures and firmware query
  net: atlantic: fix AQC113 HW init: ART sections, L2 filter slot, MAC address
  net: atlantic: implement AQC113 L2/L3/L4 RX filter ops
  net: atlantic: add AQC113 PTP traffic class and TX path setup
  net: atlantic: extend hw_ops and TX descriptor for AQC113 PTP
  net: atlantic: add AQC113 PTP hardware ops in hw_atl2
  net: atlantic: add AQC113 TX timestamp polling and PTP TX classification
  net: atlantic: add AQC113 PTP support in aq_ptp and driver core

 .../net/ethernet/aquantia/atlantic/aq_filters.c    |  98 ++-
 .../net/ethernet/aquantia/atlantic/aq_filters.h    |   3 +
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |  35 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.c   |  30 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |  53 +-
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |   5 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c    | 540 ++++++++++---
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.h    |  15 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  22 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h   |   5 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |  15 +-
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c   | 834 ++++++++++++++++++++-
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.h   |  12 +
 .../aquantia/atlantic/hw_atl2/hw_atl2_internal.h   |  68 +-
 .../aquantia/atlantic/hw_atl2/hw_atl2_llh.c        | 359 +++++++++
 .../aquantia/atlantic/hw_atl2/hw_atl2_llh.h        | 107 ++-
 .../atlantic/hw_atl2/hw_atl2_llh_internal.h        | 204 ++++-
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.c      |  33 +
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.h      |  15 +
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c   |  52 ++
 20 files changed, 2287 insertions(+), 218 deletions(-)

-- 
2.43.0

