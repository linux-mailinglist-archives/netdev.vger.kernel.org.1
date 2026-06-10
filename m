Return-Path: <netdev+bounces-297640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id swVVFKVQKWogUwMAu9opvQ
	(envelope-from <netdev+bounces-297640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:55:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F25668FEA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:55:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="Fjg/VGYH";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297640-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297640-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C93A03028176
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C63DCDAD;
	Wed, 10 Jun 2026 11:55:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CE37F741;
	Wed, 10 Jun 2026 11:55:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092512; cv=none; b=XUTdWqwlmdWW0CnE/iYgRSUBR9/Pihm3lzNIBe3RU0WsBn1/W7NZPHZ4XpTLp6AY/sKJsOpG5hN3tbuwvNuI8aKEbz5pS6ZYR6t7gGXcWd4EUA+b5eE/uZ0qSw8b35hrXpsovIx7U7i9gMzjx1zI2uBbSoXsIrkoRzN8p7NGfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092512; c=relaxed/simple;
	bh=dgU8ktpYnLZv/bUvWKVk3HCVcT2LcT0W5RKltS6Erds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDVt5kR1yY25dKvwsPMO0IJHW2qoMgcCmZT8GzOHs2zZiUf96NpHzKEkziHoqoEdAVPoycNBnrd5qedrHxD+oV+MB7q3r8Q1XX6Io0SBOIqMRn+Yle6qQ4Ps/w1ZoSbEomnx9VHgqgXeddq6qPKKdbc3OnfgeaiS9A79ZzaJBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Fjg/VGYH; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7kZZC3564383;
	Wed, 10 Jun 2026 04:54:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Kvg1v4hrpOQ20ZqtXzaSnNU
	zkaTRUFyxExpx9VSVLgk=; b=Fjg/VGYHoONM46PO6izCFl/ExSicEB6SCV//vlV
	A1/UwF4/ePHVLGIgAD70TDJmnmBC6pkGOd1Jt6RRayCn9O97B3zYwPUhUrLOjnb4
	vy7BaSneHEOMVWYbHuNSM/zOIOQmL8w+0GduYgqRVMuxhT0yOzyazTqujprXHro1
	hPfYfakKZ15PiFPmXigwmvImADYOxFlNpzHG1s1sMi6WZTnIB8umRmqr8liOg0ax
	ox0RUxxa2oWHTPPJcd2Cght+BctSt87GeLNAMBrqEYRQD2sXP586qrMXyIgq0uh7
	zJDj9J+gy79ELtKBX74P2c5oPunJPKRS+I+R3EaiBJWqyTA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epbqpdty8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 04:54:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 10 Jun 2026 04:54:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 10 Jun 2026 04:54:57 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.66.228])
	by maili.marvell.com (Postfix) with ESMTP id 56E4F3F708D;
	Wed, 10 Jun 2026 04:54:53 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v5 0/12] net: atlantic: add PTP support for AQC113 (Antigua)
Date: Wed, 10 Jun 2026 17:24:36 +0530
Message-ID: <20260610115448.272-1-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMiBTYWx0ZWRfX+EOzmuvAIL0u
 2SX1F+hqTcCegdQzbmp3fxUvakPWX5xWJL9op8psv1pjlEVNa9lV2byEpajmNltmc/pbZxX6Mfd
 fCcYtOgafSM9cF3zlhP5zg4FFt7llblDOOlrdOLOVBJYW9QbPyMjI2GkqlocQ8iaK98XSW6Ro1k
 Fsdp725DZFWXN6+B9nahPIZg8/ExF9wiKbCI3NSu3rhpJd960t2JOIHrBu/7PpDqJyBrenPxdMT
 e16hzeJorRbx73CpomIekq8X2N6USz44lFeU+NK+mFHd3iWyB50AiGBhqIeeGLRHpe55QRIagvf
 ipUmvKxqW5QH88BcOxd8f85VwmfTN97ps7DGp0DwWD19NpGoK/gYF5EvxNfQrlDA8s18aXx3jL/
 vyAzDruhTg3WTBCqts1ukn/EB5s9tunBL5k1S4up2noAQOL9BiG2xUqnNNsgqWclANEJzUaDaMe
 PzX8VOnYinlKYix36oQ==
X-Authority-Analysis: v=2.4 cv=Y6zIdBeN c=1 sm=1 tr=0 ts=6a295093 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=JjdeT4c0pHzb5jEgIKkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: MVyG_7adt7VPd8LRG2qPNfhBhE_6k3XJ
X-Proofpoint-ORIG-GUID: MVyG_7adt7VPd8LRG2qPNfhBhE_6k3XJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297640-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:sukhdeeps@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76F25668FEA

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

Changes in v5:

Patch 5:
- Promote art_count fallback literal to HW_ATL2_ART_TOTAL_ENTRIES 128
- Remove hw_atl2_utils_get_action_resolve_table_caps(): art_base_index
  is now written only by hw_atl2_utils_get_filter_caps()
- Fix L3v4, L3v6, and L4 filter count clamp formulas: remove the
  erroneous - base_index subtraction that made the last hardware slot
  unreachable; re-add HW_ATL2_RPF_L3V4_FILTERS (8),
  HW_ATL2_RPF_L3V6_FILTERS (6), HW_ATL2_RPF_L4_FILTERS (8) as the
  per-type upper bounds in min_t()
- Update commit message: s/reference-counted/serialized usage counter/
- Update subject to reflect hw_atl2_utils_hw_get_regs() addition

Patch 6:
- hw_atl2_hw_multicast_list_set(): use priv->l2_filters_base_index + 1
  as the base slot for multicast L2 filter entries instead of
  HW_ATL2_MAC_MIN, preventing multicast programming from overwriting
  the firmware-assigned UC MAC slot

Patch 7:
- hw_atl2_filter_tag_get(): return -ENOSPC instead of -1, consistent
  with sibling helpers
- Fix L4 error path: return l4_idx (propagates -ENOSPC) instead of
  -EINVAL

Patch 10:
- Move clk_select = -1 sentinel initialization to aq_pci_func.c so
  the guard in TSG clock helpers is effective on the very first
  hw_reset()
- Use local s8 sel in hw_atl2_enable_ptp() after WRITE_ONCE to avoid
  mixed WRITE_ONCE/plain reads of clk_select
- Zero *stamp on the clk_sel < 0 early-return path in aq_get_ptp_ts()
  to prevent uninitialized output
- Use READ_ONCE(self->clk_select) in hw_atl2_hw_rx_ptp_ring_init()
- Simplify ring init: remove redundant inner if (!res) wrappers

Patch 11:
- Add aq_ptp_tx_skb_drop_head() and call it in the per-packet
  ptp_ts_deadline timeout path so the skb_ring head is consumed and
  the ring does not stall

Patch 12:
- Call mutex_destroy(&aq_ptp->ptp_filter_lock) before kfree(aq_ptp)
- Move ptp_en_flags computation into ptp_filter_lock in
  aq_ptp_clock_init() to close the data race with a concurrent
  SIOCSHWTSTAMP updating hwtstamp_config.rx_filter
- Move AQ_NIC_PTP_DPATH_UP set/clear to after the error check so the
  flag is not asserted when aq_ptp_dpath_enable() fails
- Move aq_utils_obj_clear(AQ_HW_PTP_AVAILABLE) and
  aq_nic->aq_ptp = NULL before kfree(aq_ptp) in aq_ptp_free()
- aq_ptp_add_a2_filter(): change return type to void; remove dead
  if (!err) guard

Changes in v4:

Patch 6:
- Fix commit message: the selective memset replaces the unconditional
  memset(priv, 0) specifically to allow -1 sentinel initialization for
  l3l4_filters[i].l3_index/l4_index, since 0 is a valid filter index;
  the previous "preserve firmware layout" rationale was inaccurate as
  hw_atl2_utils_get_filter_caps() repopulates those fields unconditionally
  after reset
- Add art_mask == 0 fallback: if FW reports rslv_tbl_base_index >= 16,
  both clamped section values collapse to 16 and art_mask becomes 0;
  add guard to fall back to 0xFFFF in that case to avoid disabling the
  entire Action Resolver Table
- Add l2_filters_base_index bounds check in
  hw_atl2_utils_get_filter_caps(): clamp to HW_ATL2_MAC_UC if >=
  HW_ATL2_MAC_MAX, protecting all three consumer sites
  (hw_atl2_hw_init_new_rx_filters, hw_atl2_hw_init_rx_path,
  hw_atl2_hw_mac_addr_set) from out-of-range MMIO access

Patch 10:
- Declare hw_atl2_txts_s::ctrl as __le32 (was u32) and add le32_to_cpu()
  in hw_ring_tx_ptp_get_ts for correct big-endian portability

Patch 11:
- Fix timeout path in aq_ring_tx_clean(): add goto out after
  buff->skb = NULL to prevent fall-through to aq_ptp_tx_hwtstamp()
  with a freed skb, which would report a bogus zero timestamp
- Move aq_reapply_rxnfc_all_rules() and aq_filters_vlans_update()
  removal from aq_ndev_open() and addition to aq_nic_start() into
  this patch; previously the removal was in patch 11 and the addition
  in patch 12, leaving a bisect window where filters were dropped but
  not yet restored

Patch 12:
- Move dx_buff->skb = skb and dx_buff->xdpf = NULL before the PTP
  timestamp block in aq_nic_map_skb() to prevent skb leak and
  potential use-after-free when hw_get_clk_sel() returns negative
- Clear all existing L3L4 hardware filters at the start of the
  if (enable_flags) path in aq_ptp_dpath_enable() to prevent stale
  L4 filters remaining active when reconfiguring from L2+L4 to L2-only
- Update aq_ptp->hwtstamp_config inside ptp_filter_lock on success to
  prevent aq_ptp_clock_init() on a concurrent link bounce from reading
  a stale software filter state

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
  net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address
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

