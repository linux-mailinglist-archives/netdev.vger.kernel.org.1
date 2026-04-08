Return-Path: <netdev+bounces-276535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLdXMDBV1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:16:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3643BCB6E
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE14304075C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649ED3AF65E;
	Wed,  8 Apr 2026 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOdgitGc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D134FF59
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653919; cv=none; b=l+TpsHsd52BMtcUyML0JyA/U6i2rehnkzZdIjAkqpekeMcuejALGU/yh0mSi+vFmXTSA3ntjGe1ckSR8yorS6jEZuAZq24zYFQa1jeudi23qLS/AKkvwzTHxjyzbbMpCbIiA0ivvX/TYdWFP0Q2/J0CQMCxSDCl+5zgxe7FqiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653919; c=relaxed/simple;
	bh=xHT//3FdP0pzi+J3JCTY+FWqu5wZN0PFM98U8ARD2xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tmLi065Oo1JIdNy98CMI394WkrWe7h+Wj95B3aVPyfq5IiLeQDxiiFb1VqEAUutHGTVbsLx1ffg/jVuSt1xH3+w5ioyqgl0l+ZYU8YJ2jLjIjYor09ryK4AysNXVI7ER5EQfnZUWVUeplaCkvkVD2bHuC6JprE5WTvrZhu7zcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOdgitGc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775653918; x=1807189918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xHT//3FdP0pzi+J3JCTY+FWqu5wZN0PFM98U8ARD2xs=;
  b=EOdgitGcy9eWV40I4OW1O1E7VGJHysThShucfzhUIx5DbR/8Js2uHkeu
   Hf/DEnKvW0sXBDdw2iwO4jYBk/n1nxJ0dM1K++B3J6J0ayAvcZk6dNW1p
   hF/0ZGEpOj6YDEzA7ji21mNbz69SDXlQP96ziWcsarg5K3ERWlRMZQ5d1
   +S51PDfH1eQ7jtweRkvEs3R1MUG7aZQmygiONPNiAxiMMXIBBq9Rq29/8
   5XvPW5OmENhS7fJM15kPM1e8dGEktfvcRKg5Gw9WrVYqfTbV96UEWBrgQ
   MWWkGQYEeXopcrsp/LWPt8vrYIz/UhYR3d01ZGl4gdwEMeTgHER2gMlbq
   g==;
X-CSE-ConnectionGUID: dEvPd4fuThKZ9q1sU20VdQ==
X-CSE-MsgGUID: kvUrCWZOR5G9XQNfmAo/gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087224"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102087224"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:11:57 -0700
X-CSE-ConnectionGUID: 8xNg/nTORjGkvOQPG9kPaA==
X-CSE-MsgGUID: RYZ4mSObT7myxSFQlZguuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228714940"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:11:56 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 0/6] ixgbe: six bug fixes
Date: Wed,  8 Apr 2026 15:11:48 +0200
Message-ID: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276535-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 3A3643BCB6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Six fixes for the ixgbe driver, covering a SWFW semaphore timeout
miscalculation, a security-relevant debugfs out-of-bounds, a broken
flow-control NVM-reset path, a false-success return in the cls_u32
nexthdr path, an adaptive-ITR u8 overflow, and wrong bit positions in
the UP-to-TC register normalisation.

Patches 1-3 fix issues that could result in functional regressions
(FW update failures, OOB MMIO, traffic stall after NVM update).
Patches 4-6 fix correctness bugs with user-visible effects.

Patch 1 is a squash of two previously independent submissions:
  - "ixgbe: increase SWFW semaphore timeout for X550 FW updates"
    (Soumen Karmakar)
  - "ixgbe: extend 5 s SWFW semaphore timeout to all X550EM variants"
    (Marta Plantykow)

The commit message for patch 1 also fixes an error noted in review:
the previous description stated "200 ms" but the actual default is
1 s (200 iterations x 5 ms per poll).  Patch 1 also replaces the
">= X550 && <= x550em_a" range check with three explicit mac.type
comparisons per Tony Nguyen's request.

Patch 3 additionally handles the setup_fc() failure path that was
left unaddressed in the prior posting: fc_enable() is now skipped
when setup_fc() fails so the MDD-triggering stale state is not
committed to hardware.

Changes in v2:
 - 1/6: Squash two patches; fix commit msg ("200ms" -> "1s"); three
        explicit mac.type == comparisons instead of range check.
 - 2/6: Add Fixes: tag; reroute from iwl-next to iwl-net.
 - 3/6: Add Fixes: tag; reroute to iwl-net; skip fc_enable() when
        setup_fc() fails to avoid committing stale FC state.
 - 4/6: Add Fixes: tag; reroute from iwl-next to iwl-net.
 - 5/6: Add proper [N/M] patch numbering.
 - 6/6: Reroute to iwl-net; swap to (expr >> ..) & MASK operand order.

---

Aleksandr Loktionov (5):
  ixgbe: fix SWFW semaphore timeout for X550 family
  ixgbe: call ixgbe_setup_fc() before fc_enable() after NVM update
  ixgbe: fix cls_u32 nexthdr path returning success when no entry installed
  ixgbe: fix ITR value overflow in adaptive interrupt throttling
  ixgbe: fix integer overflow and wrong bit position in ixgbe_validate_rtr()

Paul Greenwalt (1):
  ixgbe: add bounds check for debugfs register access

 drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 18 ++++++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c    |  8 ++++++++
 3 files changed, 22 insertions(+), 8 deletions(-)
-- 
2.52.0

