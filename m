Return-Path: <netdev+bounces-253610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMicM1/ud2kVmgEAu9opvQ
	(envelope-from <netdev+bounces-253610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:44:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 390168E04B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B9DA300C5A2
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F653093BA;
	Mon, 26 Jan 2026 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyr0nSpq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A01301001
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467401; cv=none; b=ZpG+beKraf4m4pGXlnzub8k3MhGwoIiB9UIBEd+GTgu9k3w/2Ne8HZXUi/gxEdIz6OruSCQ5hmexIaeows7Cbc4Lhe+6e0Yh90lz8BbbQNVNfBF8kQE+zAHN4TtC/hce5BPTG5MmSgUcHxvx3t6UF7+72R21fkwfTcOD1X4CZq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467401; c=relaxed/simple;
	bh=RfyDEgsYX9RrWcW5/oYxXGuI1diVQ4blJbQaUrRMiLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=muPR1TXaXZI2wRrBPQxIwRIegfcYCp6L8BIY6UIJ6N/WXyEmconbaHMekdarPIQEQ4OM3sRu67g63p2xN688B+IDYIR7XZhLZ+WOliDLZS9L/d/pTREMz63Gf9BjZoOacYS1gJ5r92RKYsldgdbq3uzjlHyd2Bk7YPesVPOGTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyr0nSpq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769467400; x=1801003400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RfyDEgsYX9RrWcW5/oYxXGuI1diVQ4blJbQaUrRMiLs=;
  b=gyr0nSpqXeYPqcVRT3p9KdHF9X0wDTk9cu0h9dcHFyxLzfQO05xfq4dx
   VVWkmKqu6H97CQnnY5li49yexEXBrMIx1TXP1BBkQI4gxwTkLaO0MMoLk
   9LBZIo8ih3h3YU3jw81FVGeTlqRFbPAykDpYQzsDkzSAC0AlhH9WKXkvK
   vWe3EsGA7F3yvRtlTgZtTH0bZksfIvxVeNKafPL1rWiCV+ABaWc9bfgyd
   0peNCdHbqMXWE3ks+HGQo4UIqkZHhw0EpBTRiIoK0S7h2ZQLOkIbVv+4V
   9Gel4JENas22NflIFOvuwKRTesICOIOGPR+hnp3mkb8gQSLzQyNlfep5V
   A==;
X-CSE-ConnectionGUID: ZF7ladSkTPqkWwEQ8I0ypg==
X-CSE-MsgGUID: Aqbc2IzeQ2aZYYH9/kRAYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70369379"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70369379"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 14:43:19 -0800
X-CSE-ConnectionGUID: PakfrPnJTiWOiyoLZJx6yg==
X-CSE-MsgGUID: ZJRhZ1LPTIaS9IA8Ope24g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="230754271"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jan 2026 14:43:18 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/7][pull request] Intel Wired LAN Driver Updates 2026-01-26 (ice, idpf)
Date: Mon, 26 Jan 2026 14:43:04 -0800
Message-ID: <20260126224313.3847849-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253610-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 390168E04B
X-Rspamd-Action: no action

For ice:
Jake converts ring stats to utilize u64_stats APIs and performs some
cleanups along the way.

Alexander reorganizes layout of Tx and Rx rings for cacheline
locality and utilizes __cacheline_group* macros on the new layouts.

For idpf:
YiFei Zhu adds support for BPF kfunc reporting of hardware Rx timestamps.

The following are changes since commit bf2e36c9dab95e41516fbcf7b1cc804539b2d021:
  dt-bindings: net: dsa: fix typos in bindings docs
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Alexander Lobakin (1):
  ice: reshuffle and group Rx and Tx queue fields by cachelines

Jacob Keller (5):
  ice: pass pointer to ice_fetch_u64_stats_per_ring
  ice: remove ice_q_stats struct and use struct_group
  ice: use u64_stats API to access pkts/bytes in dim sample
  ice: shorten ring stat names and add accessors
  ice: convert all ring stats to u64_stats_t

YiFei Zhu (1):
  idpf: export RX hardware timestamping information to XDP

 drivers/net/ethernet/intel/ice/ice.h          |   3 -
 drivers/net/ethernet/intel/ice/ice_base.c     |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  31 ++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  56 +++--
 drivers/net/ethernet/intel/ice/ice_lib.h      |   6 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 196 +++++++++++------
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  46 ++--
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 199 +++++++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   5 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   4 +-
 drivers/net/ethernet/intel/idpf/xdp.c         |  31 +++
 drivers/net/ethernet/intel/idpf/xdp.h         |  20 ++
 13 files changed, 396 insertions(+), 207 deletions(-)

-- 
2.47.1


