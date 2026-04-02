Return-Path: <netdev+bounces-274608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEKDDd+RzmnAogYAu9opvQ
	(envelope-from <netdev+bounces-274608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:57:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C114338B8C0
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 266633046530
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A811225F7A9;
	Thu,  2 Apr 2026 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sktb5+Ha"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F5D1A275;
	Thu,  2 Apr 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145032; cv=none; b=E/BYsvFJ3xdhgyzFaDJ7bKpbZZlsfYA22KLE9WvoTR/wU9+i7oYWvnr7NlDVSLoVb82McYgkpllvykvPkFHd1ougMM19rtjPsOmjrIyJb9Ye9cGJyP3aZlSXL3hsa+Saro4zhVBOwuP16D2faqJbEd5kTjTLa2vrjvzlJxWxzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145032; c=relaxed/simple;
	bh=L9nSB2zGv5s1Ukyjt8BADP5tuYIuTVy496+BN6s0rYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hzuoGyP3KR7WBmsYZoU8alm2ad8KfPi6nhGnjo/ywpyLFXLyx0J2SJrwFOYM0pj2YfXRIOdz1damb2mRo4dyRRUHwwd8+bKfsFJem4lLisO5NdN56pgIGMCR4IZAM3j/0xXQpRNBJg5MYn4FrjdbJB45miV0Q1mqcaArfcSglp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sktb5+Ha; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775145032; x=1806681032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L9nSB2zGv5s1Ukyjt8BADP5tuYIuTVy496+BN6s0rYc=;
  b=Sktb5+Ha6tB7lcpxSIYmZKtY18X/laR34w0jzT0glG+rCbgoherwju/Z
   TJdwwcpS4Yhglc5dJBoRc/+/OCq4DHqPvghV1S1KHFDXeWAkvqqQPZa60
   sOqSIeYsUgu6IeTk++4mONyd17+2uV2Qgs4aRAM5ML8hSMWHbjym3dkEr
   5YNPsJmJYsML873X3qsb5BSloYhY/iNxaCqQ6yjOnB7SZoS0PzSI9JHSe
   3llc6/7VwNryixHoZ71xjHRY5AwlzZ1WhgLlu+P03FUBw2zPxiUAgfU+J
   JmF3n0oq5IJLUMugtcYiK0CCVmsv7xlbbUzfmCHurDUSR81abLwNr30uN
   A==;
X-CSE-ConnectionGUID: D9QwgTfdSkOIfmWxfRWCSA==
X-CSE-MsgGUID: WNvSiCi/SgqINHNxeXSBvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75927952"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75927952"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 08:50:31 -0700
X-CSE-ConnectionGUID: STA1VVJnTNKig09jVeqTDg==
X-CSE-MsgGUID: 3PUOWBCsSyaj2o7f69XRWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="224157475"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 02 Apr 2026 08:50:27 -0700
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
Subject: [PATCH v6 net 0/8] xsk: tailroom reservation and MTU validation
Date: Thu,  2 Apr 2026 17:49:50 +0200
Message-Id: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274608-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid,intel.com:url]
X-Rspamd-Queue-Id: C114338B8C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v5->v6:
- refrain from relying on umem refcnt when disabling zc on error path
  (Sashiko)
- have a separate __xsk_pool_get_rx_frame_size() which preserves old
  behavior and use it on copy path (Sashiko)
- drop driver cleanups

v4->v5:
- add further review tags from Bjorn
- fix ./test_progs -t xsk
 * do so by making the procfs reading common so test_xsk.c can use it
- get back to idea of relying on pool->umem->zc in
  xsk_pool_get_tailroom(); that is because we now call its caller
  (xsk_pool_get_rx_frame_size()) before getting down to driver via
  ndo_bpf - we do it to rule out invalid setups in terms of MTU vs xsk
  frame size/number of exposed segments by driver
- bring back explicit rejection of mbuf && segs == 1 combo

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


Maciej Fijalkowski (8):
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

 include/net/xdp_sock.h                        |  2 +-
 include/net/xdp_sock_drv.h                    | 23 +++++++-
 net/xdp/xdp_umem.c                            |  3 +-
 net/xdp/xsk.c                                 |  4 +-
 net/xdp/xsk_buff_pool.c                       | 32 ++++++++++-
 .../selftests/bpf/prog_tests/test_xsk.c       | 55 +++++++++----------
 .../selftests/bpf/prog_tests/test_xsk.h       | 23 ++++++++
 tools/testing/selftests/bpf/prog_tests/xsk.c  | 19 +++++++
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  4 +-
 tools/testing/selftests/bpf/xskxceiver.c      | 23 ++++++++
 10 files changed, 150 insertions(+), 38 deletions(-)

-- 
2.43.0


