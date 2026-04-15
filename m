Return-Path: <netdev+bounces-278801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Pu5MCqi32mBXAAAu9opvQ
	(envelope-from <netdev+bounces-278801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:35:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F1D405580
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 943F830AABF7
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3933D3D1E;
	Wed, 15 Apr 2026 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeQp5uSU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6930C631
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263325; cv=none; b=DSAn4XXdf2/QTit72csnN54zgtGOXXJb5PnIGaxA0scbAuAbDgcziZI9DzKSg5CFe87FWitpssOGvVphoBoF69nhKTtkNPX8ILPSF83amp2DaWkSzcKoErjp/JPA2/V+SgSD1cIfqXm9DEIQw7pjChjam+XNODEAbQ+b7yUDr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263325; c=relaxed/simple;
	bh=hGYpdPt5f7E7jW84kiyLG0thuZ8oo2TpL9uLwiLJ2N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FW7DVtrSxwNJvSlWtvZD/teCfSdYi4vQvjrJFh05t5gd6PbQqJpUMrb81LVmbgwmgmh00LwrQKI8ZGk/HHaiAhDPibO/XzjWCRnptS2/6bPJkybfVL4nBtG9YlkVDM7HbKZeRe5ggw+Y4QeFEcebzfXhQY2K4l0HxYnze0MoMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeQp5uSU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776263324; x=1807799324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hGYpdPt5f7E7jW84kiyLG0thuZ8oo2TpL9uLwiLJ2N4=;
  b=HeQp5uSUXuVE0ECZ5zIGz+15RcMpahn3a15VHAC0SDW0clRENssUShfk
   OYOg4fyvBGOMGj6gQlGoSoww6lW7Zp8aC6mhJlFpQ848J26b1nbm4XMSk
   4oFFy4DIY/ubW9Y0zEV0+7b9mt60bomksiseqWdQgFIPZam+QcyhMMpAx
   HWGru9DanReC+w/WbexSKF84qR/mLvkvt5irIMQ2pCUq/eghoqv4deFQu
   Y7nxgEo2ippZoOTr+Chol2xYv2B41GyVU3wMdebbys9K2B55owT3q6ZUJ
   QoOpMp/Sw+DnkUmG10Q25K8BXHxeZC+HUhz6Emi5+06AgN/r6aX6W67/M
   A==;
X-CSE-ConnectionGUID: Jmwjkp2nSuSgfs+Ty5SExw==
X-CSE-MsgGUID: rqbGkG+tSJiIB+fB9YUhIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423725"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77423725"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:28:43 -0700
X-CSE-ConnectionGUID: 3CeTPOSiQZ6o5qn6eSGebw==
X-CSE-MsgGUID: HNKefGP3R3a9pY2lsv6PCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234467814"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:42 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v3 0/6] ixgbe: six bug fixes
Date: Wed, 15 Apr 2026 16:28:35 +0200
Message-ID: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
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
	TAGGED_FROM(0.00)[bounces-278801-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15F1D405580
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

Patch 3 guards against calling setup_fc() on 82599 backplane links:
on those interfaces setup_fc() resolves to prot_autoc_write() ->
ixgbe_reset_pipeline_82599(), which toggles IXGBE_AUTOC_AN_RESTART
and causes an infinite link-flap loop.  setup_fc() is now skipped for
ixgbe_media_type_backplane; fc_enable() is still called.  The failure-
path guard introduced in v2 (skip fc_enable when setup_fc fails) is
preserved.

Patch 5 reworks the ITR write-back to keep the mode flag
(IXGBE_ITR_ADAPTIVE_LATENCY, bit 7) and the usec delay in separate
operands until the final store, and clamps the delay to
[IXGBE_ITR_ADAPTIVE_MIN_USECS, IXGBE_ITR_ADAPTIVE_MAX_USECS] via
clamp_val().

Patch 6 corrects the Fixes: tag to 8b1c0b24d9af ("ixgbe: configure
minimal packet buffers to support TC") per Simon Horman.

Changes in v3:
 - cover: removed Patch 1 squash-history description (v1->v2 background
          no longer needed in the cover letter).
 - 1/6: add Reviewed-by: Simon Horman, Reviewed-by: Jacob Keller;
        no code change (Jacob suggested read_poll_timeout() but
        accepted as-is for net).
 - 2/6: add Reviewed-by: Simon Horman; no code change.
 - 3/6: add backplane-link guard in ixgbe_watchdog_update_link();
        skip setup_fc() when media type is ixgbe_media_type_backplane
        to prevent infinite link-flap on 82599 backplane interfaces.
 - 4/6: add Reviewed-by: Simon Horman; no code change.
 - 5/6: rework clamping -- use clamp_val() with mode and delay as
        separate operands; clamp to [IXGBE_ITR_ADAPTIVE_MIN_USECS,
        IXGBE_ITR_ADAPTIVE_MAX_USECS] instead of LATENCY-1.
 - 6/6: correct Fixes: tag to 8b1c0b24d9af; add Reviewed-by:
        Simon Horman.

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

