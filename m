Return-Path: <netdev+bounces-271991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL46E1YexWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-271991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:53:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAC6334BE8
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BB4030846B5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462C53F7895;
	Thu, 26 Mar 2026 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Od1nT4lc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A50A3FA5C7;
	Thu, 26 Mar 2026 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525782; cv=none; b=C5bFDCX4hFD4ouV/fXGJFyiJqJbVHwqdq24C33MaWJgK3jvaxJbkC8wb+RKiZAVlO73M/jdE85/yM4/IBMeXDB0vDS/07OMNYlQf6MXp1xbuq2U4riCD7P/ZlosD3GVRvnpOJWT7Odd1tl97CgvHSfV50IiKeNQvyKWkbJ7YtG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525782; c=relaxed/simple;
	bh=xFjviNipDLhR8rwfNROglO91Kk/zyF+M3xCXT4MhVmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OU2NHAkVcuL0I49WUQqqBNrxIjwFwetGSgiq5OmPQ7ytCcUDmOhxwJRr+sIKRlwtrlvgqnx+mP9XorOTKF7QHahFUX3aJIrncdMWMbZiTb37rvX8I+4LSL6cUK04zyZ9lovciO4dPjVn2sfX9lIg4X8L+30yl6YXee4UCt+jBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Od1nT4lc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774525773; x=1806061773;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xFjviNipDLhR8rwfNROglO91Kk/zyF+M3xCXT4MhVmY=;
  b=Od1nT4lcb2LQOQZBltQjWQIWhg4V4CstFhTQW+cyPeV/SzwnpIqCk00Y
   uQFqIrFbkugFZ7EEbPPQX2OMV/qRKjpvm0xBuWsUCTM4fxbjodCVDQkcl
   RFd/9bkraq9nxWzPK2hYPxuf76YWYT7zwrKUqW3hQIhaM6dK+g55/5p9U
   zsCpDvULyDNHbuYv1A8AGZg5FxBzmR9WC8ZmtQEoT3j1UTEO7+efmftsi
   K2T6mtonSeYJJMAK9IxXu90RVaurP8i+QpxmXSzqJRFzBKknI7eiYnorh
   p2ojin+48YHogDDSN1Rl0mtsYUbC0seSG5RfBnRUAhSRbBGFXbSpqMiJx
   Q==;
X-CSE-ConnectionGUID: d4TH90QERvuanzo9iVsZJQ==
X-CSE-MsgGUID: Q/rxDpIQTBKegxS0cmAGlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75776226"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75776226"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:49:31 -0700
X-CSE-ConnectionGUID: FhUjxxA7Ssq/OJzPnxPy7g==
X-CSE-MsgGUID: rM5bBhoMTxywHz8kefW4uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248028994"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 04:49:29 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 net 00/11] xsk: tailroom reservation and MTU validation
Date: Thu, 26 Mar 2026 12:49:08 +0100
Message-Id: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271991-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid,intel.com:url]
X-Rspamd-Queue-Id: DDAC6334BE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v3->v4:
- allow exact 128 bytes of space when user defined headroom is deducted
  from total frame size
- provide a routine for reading procfs entries within xskxceiver
  * use it to fetch cache line size and calculate skb_shared_info size
    on our own
- clean up gve and igc xsk pool enablement routines
- include mtu vs frame size * max zc segments validation in
  xp_assign_dev()

v2->v3:
- add tags from Bjorn/Stan
- provide at least 128 bytes instead ETH_ZLEN when validating frame
  headroom
  * this way we can get rid of i40e/ice changes
  * make sure xsk_pool_get_rx_frame_size() returns value 128b-aligned
  * and remove pre-check from idpf
- separate XDP_UMEM_SG_FLAG fixes from MTU validation in xsk_bind()
- make drop_idx a local variable in xsk's xdp drop prog
- adjust rx_dropped to new 128b related values
- move ugly placed define (Bjorn)
- remove READ_ONCE when fetching netdev->mtu (Bjorn)

v1->v2:
- remove xsk_pool_get_tailroom() definition for !CONFIG_XDP_SOCKETS
  (Stan)
- do not rely on pool->umem->zc when configuring tailroom (Stan, Bjorn)
- simplify dbuff setting in ZC drivers (Bjorn)
- use defines for {head,tail}room in tests (Bjorn)
- return EINVAL instead of EOPNOTSUPP when mtu setting is wrong (Bjorn)
- include vlan headers and fcs length when validating mtu (Olek)
- tighten umem headroom validation when registering umem (Sashiko AI)
- set XDP_USE_SG in xp_assign_dev_shared() (Sashiko AI)
- adjust rx dropped xskxceiver test

Hi,

here we fix a long-standing issue regarding multi-buffer scenario in ZC
mode - we have not been providing space at the end of the buffer where
multi-buffer XDP works on skb_shared_info. This has been brought to our
attention via [0].

Unaligned mode does not get any specific treatment, it is user's
responsibility to properly handle XSK addresses in queues.

With adjustments included here in this set against xskxceiver I have
been able to pass the full test suite on ice.

Thanks,
Maciej

[0]: https://community.intel.com/t5/Ethernet-Products/X710-XDP-Packet-Corruption-Issue-DRV-MODE-Zero-Copy-Multi-Buffer/m-p/1724208


Maciej Fijalkowski (11):
  xsk: tighten UMEM headroom validation to account for tailroom and min
    frame
  xsk: respect tailroom for ZC setups
  xsk: fix XDP_UMEM_SG_FLAG issues
  xsk: validate MTU against usable frame size on bind
  selftests: bpf: introduce a common routine for reading procfs
  selftests: bpf: fix pkt grow tests
  selftests: bpf: have a separate variable for drop test
  selftests: bpf: adjust rx_dropped xskxceiver's test to respect
    tailroom
  idpf: remove xsk frame size check against alignment
  igc: remove home-grown xsk's frame size validation
  gve: remove home-grown xsk's frame size validation

 drivers/net/ethernet/google/gve/gve_main.c    |  5 --
 drivers/net/ethernet/intel/idpf/xsk.c         | 10 ----
 drivers/net/ethernet/intel/igc/igc_xdp.c      | 11 ----
 include/net/xdp_sock.h                        |  2 +-
 include/net/xdp_sock_drv.h                    | 17 +++++-
 net/xdp/xdp_umem.c                            |  3 +-
 net/xdp/xsk_buff_pool.c                       | 11 +++-
 .../selftests/bpf/prog_tests/test_xsk.c       | 55 +++++++++----------
 .../selftests/bpf/prog_tests/test_xsk.h       |  2 +
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  4 +-
 tools/testing/selftests/bpf/xskxceiver.c      | 44 +++++++++++++++
 11 files changed, 104 insertions(+), 60 deletions(-)

-- 
2.43.0


