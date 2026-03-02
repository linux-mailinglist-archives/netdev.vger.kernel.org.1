Return-Path: <netdev+bounces-262948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GO9IS4gpmkuKwAAu9opvQ
	(envelope-from <netdev+bounces-262948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:41:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF711E6BF0
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD953306FCCF
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 23:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4AA33F59A;
	Mon,  2 Mar 2026 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLvlnlMa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A533EAE6
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494872; cv=none; b=OAkhWw/B0tG4cGNAXBwC2h3lUYSc8uFxQq0KVnFvttXKFV56gPrkrFZodKEWECl2WRjRQ+wJeG1I7/KafLjSe58KAi2X339jX34ONSoDSlr8AD6RzTD9AxOzNP/ieba6lZ0PlW9TXWraoGGjhIddnhhY2jTL8PP2RKTdFtPyjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494872; c=relaxed/simple;
	bh=chb8/3+KwEnu+9Il+xDkHx9S/nonCgjB6/9Jy6tM1f8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTMghDRbZnjLvjKD8AQ0q/EALqRpYlS3bup8UZV+/AnZY7bKl0gAGTr8OL539SvEQSttE3WppZ6+Xvd6BT8/M6Df/JADFQkFV10uXlkSIdExef04gtIwGxJgQtvX/e2UMCkUtXK1GLLitSdUt4DAFK5sfPTY3ftvaC5N0frk++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLvlnlMa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772494870; x=1804030870;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=chb8/3+KwEnu+9Il+xDkHx9S/nonCgjB6/9Jy6tM1f8=;
  b=BLvlnlMaQdw9jFkHq+B51/MJneU4djGHlQRl17xdk7tW52BD2PLaFq3a
   8gkEUd/Xaq4jZyk7BoKc7FMPiqURsyWfWhHWyHEf0EZu32JonrA9KWp5t
   D7yHn13mHUb0ARW1932yDk0j5GqdX14A74beVAj3l9oQkUTh2cOQ1OCyS
   4NiQ+UT8a2hmQs7JljMGGlm5g5tAguFReP3hRahfl5ft5+UFI90pScBz6
   gFrGTZNYE4/bfOX4jK0E8Ef9WL39ExEYQ6/1FKJkmSSYfrpHakPLv3Aoe
   AdwqYxyv8+lrsk/ekFxu7TC45SO7d4UT6nR3aQ0lbXLm0ophSd2gfYqI1
   w==;
X-CSE-ConnectionGUID: ILl1pIxES4WIOPJ/zm0vPA==
X-CSE-MsgGUID: dvoAKKo0QaW/P7qhcxPDMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73585723"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73585723"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 15:41:09 -0800
X-CSE-ConnectionGUID: Q4Oe82NMT12yQJj6SI4xnQ==
X-CSE-MsgGUID: h5L1zg2JRDKsKIrVSpw95Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="216233662"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 02 Mar 2026 15:41:09 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/4][pull request] Intel Wired LAN Driver Updates 2026-03-02 (ice, i40e, ixgbe)
Date: Mon,  2 Mar 2026 15:40:58 -0800
Message-ID: <20260302234105.2658400-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DEF711E6BF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262948-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

For ice:
Simon Horman adds const modifier to read only member of a struct.

For i40e:
Yury Norov removes an unneeded check of bitmap_weight().

Andy Shevchenko adds a missing include.

For ixgbe:
Aleksandr changes declaration of a bitmap to utilize DECLARE_BITMAP()
macro.
---
These originally come from this series; ice devmem/io_uring patches are
excluded while they are being updated.
https://lore.kernel.org/netdev/20260206174910.4066255-1-anthony.l.nguyen@intel.com/

The following are changes since commit 01857fc712f6469cab9cc578120cdc80f1c2a634:
  Merge branch 'net-sched-refactor-qdisc-drop-reasons-into-dedicated-tracepoint'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Aleksandr Loktionov (1):
  ixgbe: refactor: use DECLARE_BITMAP for ring state field

Andy Shevchenko (1):
  i40e: Add missing header

Simon Horman (1):
  ice: Make name member of struct ice_cgu_pin_desc const

Yury Norov (NVIDIA) (1):
  i40e: drop useless bitmap_weight() call in i40e_set_rxfh_fields()

 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 21 +++----
 drivers/net/ethernet/intel/i40e/i40e_hmc.h    |  2 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 27 ++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 56 +++++++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  2 +-
 7 files changed, 56 insertions(+), 58 deletions(-)

-- 
2.47.1


