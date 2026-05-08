Return-Path: <netdev+bounces-285588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CiJE6JU/WnZagAAu9opvQ
	(envelope-from <netdev+bounces-285588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:12:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A34FE4F101D
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 111E03005ABD
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 03:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375B72C21C5;
	Fri,  8 May 2026 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbix+BuY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85264285CAE
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 03:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209952; cv=none; b=RAA3OHBtbC7tgqMmIVVwe1DwmeBhEXGtI2EVUgOQRWDj1FldTz5JQRvgLo9T7MXp2mFmK2R57l0Fc7oshSKpRYP83p2w52QnuohyxHpxFzyMqgMVRO/MVfMvp3YaTwBzRTxXWJcyNnOrq5UHi3fkmBoEsatCSSYK+sDGNx8ee0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209952; c=relaxed/simple;
	bh=5syTiBGIJkTfSWeQklIrIr7jq5li2r8OQfmkyePbRFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEvwF5EukD7RMF9aDBk+tcxaB/Dzv8DrsuwjO8klV4vcAjptP2WSAMxb8WHi90BPbuwwa7GXRVa5zlawwvRhwmfc6hZgFxTS46/tRVaqmv3SIWJiNL6zMBBFIw8FWnbl2q/DbifiG0v1sqQ713cbBfUuaivvDH+XHN5rVav/VxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbix+BuY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778209950; x=1809745950;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5syTiBGIJkTfSWeQklIrIr7jq5li2r8OQfmkyePbRFQ=;
  b=jbix+BuYZv4aM0MREo3SfUXbY3eAeS3Ql1nfBg4E2Ht1PyY3oXIwpnR4
   c9/ghvpaWFXDIfjNCay2HLn0IxRIKs19GQdd5qR6yShaqEiQs7WcW3txt
   XZuRn7I3H6kGVBGOYGxNB6NgdNwyBjPcgjaoli9wjK/mNeBveW933OXYl
   6RzSLVHXCjGQ8ryRiDnLdUWPQOnxGayCx0/bw9pDnDAxFG7lRVw5pQE72
   XVYziPl1CyA5p/FvfGB/IwmTJLAbr8zf/kd1iY2GjQMm9lar1Yx55yx7E
   uja08yvrhmgbXboSbzbaq50immzRe8jV3a4FXGvTNMHPPe8IcoQGPfMtx
   A==;
X-CSE-ConnectionGUID: OL5l14sZRFek7pYUgvztoA==
X-CSE-MsgGUID: MtCFUlVPQJaylysBNJKh3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79027478"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="79027478"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:12:29 -0700
X-CSE-ConnectionGUID: BmjWfNWDQcWypu3CAzhaYw==
X-CSE-MsgGUID: 2RtA3QfuQIi8gEegXE6y+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="241623170"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2026 20:12:28 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 0/8] ixgbe: small cleanups and improvements
Date: Fri,  8 May 2026 05:12:18 +0200
Message-ID: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A34FE4F101D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285588-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Eight independent cleanups and improvements for the ixgbe driver,
grouped by theme:

Naming / type hygiene (patches 1-2):
  Patch 1 renames ixgbe_q_vector::numa_node to ::node.  The field name
  shadows the struct device numa_node accessor, causing a sparse warning.
  The rename aligns with other Intel drivers (ice, igc).

  Patch 2 changes local error-code variables from u32 to int in six
  functions across ixgbe_main.c, ixgbe_phy.c and ixgbe_x550.c.  Storing
  a signed errno in an unsigned type works by accident for truthiness
  checks but breaks exact comparisons and proper propagation.

Bug fix (patch 3):
  Patch 3 rejects duplicate FDIR perfect-filter rules before programming
  hardware.  The same 5-tuple with a different sw_idx would silently
  consume a second scarce FDIR slot and confuse rule deletion.
  Returns -EEXIST to userspace on duplicate rather than -EINVAL.

Performance (patch 4):
  Patch 4 replaces the busy-wait udelay(1000) in the SECRX_RDY poll
  loop with usleep_range(10, 20) and raises the iteration count from
  40 to 4000.  Because usleep_range(min, max) is guaranteed to sleep
  at least 'min' us, 4000 * 10 us preserves the original 40 ms
  minimum-wait-before-timeout; worst-case grows to ~80 ms (acceptable
  since SECRX_RDY failing to assert is non-fatal and only logged).
  Typical stall on fast hardware drops from up to ~1 ms per iteration
  to ~10-20 us.

Code quality (patches 5-8):
  Patch 5 replaces ktime_to_ns(ktime_get_real()) with the direct
  ktime_get_real_ns() helper.

  Patch 6 factors the three-line autoneg-restart sequence duplicated in
  ixgbe_setup_phy_link_generic() and ixgbe_setup_phy_link_tnx() into a
  static helper ixgbe_restart_auto_neg().  The helper checks the return
  value of read_reg() and returns early on error to avoid writing
  uninitialized data to the PHY register.

  Patches 7-8 improve the adaptive-ITR algorithm in two steps:
    7/8: Limit ITR decrease in latency mode to at most
         IXGBE_ITR_ADAPTIVE_MIN_INC (2 us) per step so that ACK-driven
         workloads do not overdrive interrupt rate.  Uses max_t() to
         ensure the clamp never drives ITR below the algorithm's own
         computation.
    8/8: Add IXGBE_ITR_ADAPTIVE_MASK_USECS (= IXGBE_ITR_ADAPTIVE_LATENCY
         - 1) to replace the open-coded ~IXGBE_ITR_ADAPTIVE_LATENCY
         mask in ixgbe_set_itr() with the cleaner AND form.

Aleksandr Loktionov (1):
  ixgbe: use int instead of u32 for error code variables

Alexander Duyck (2):
  ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
  ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant

Jacob Keller (2):
  ixgbe: rename numa_node to node in struct ixgbe_q_vector
  ixgbe: use ktime_get_real_ns() in ixgbe_ptp_reset()

Jakub Chylkowski (1):
  ixgbe: extract ixgbe_restart_auto_neg() to avoid code duplication

Maciej Rabeda (1):
  ixgbe: increase SECRX_RDY polling frequency in
    ixgbe_disable_rx_buff_generic

Piotr Skajewski (1):
  ixgbe: prevent adding duplicate FDIR perfect filter rules

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |  5 +--
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 27 +++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 19 ++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 42 +++++++++++--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 12 +++---
 8 files changed, 77 insertions(+), 35 deletions(-)

-- 
2.52.0


