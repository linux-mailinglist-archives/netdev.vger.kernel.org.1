Return-Path: <netdev+bounces-288429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IUGOjduB2rY2gIAu9opvQ
	(envelope-from <netdev+bounces-288429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:04:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C4D556909
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14A5C3008D3B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EF53815F1;
	Fri, 15 May 2026 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gE5LAX6f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E735E1DD
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871861; cv=none; b=lkjqOWwUBGcwuE3XAQTE6PXu5DLpE+q2U2tMXEW01an/uh+gprzMKzIkVlgBiUNNFHyiMXgB6ddo+tPI29FdDrFfrrdosicDs9emNG2ggrOZoGTqn23nJr1YtzngR9LIt05Xw3EBSV8ZRNWqLCX3GuBahg1wdG/iUlA/INPny0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871861; c=relaxed/simple;
	bh=Ent00k7exvK8hToZmNFZmmOeIHqZFUsATQ6w071IpCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dw93J2cF2+gQE7q3ujvtB2mAEJpI3pdMAd8BlxKkSHLH/jrHNJdMYJOFDap8v4LIJklJKghwkxYqQLNNjDFA60iyUVbXllXzssqQ2LqUWD7g/mRF7maN34a4XIp0BrSw1BWhyhxozcVrzNiGnpt+Qg0M4bI/pV0rsRDsovcbtqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gE5LAX6f; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778871860; x=1810407860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ent00k7exvK8hToZmNFZmmOeIHqZFUsATQ6w071IpCY=;
  b=gE5LAX6f9ypJi7LDk0b86D8ujYLgzd1EgEzE8X0X3TlGUm5ii3PWvgNh
   NoRLq+gQXTEidsZPwiRJFWohojZk9JyQ6yb9V06EbXMxqaxy6Bf2zAZq5
   +AmdtRrLX164nuPwpRkivOPYBLyng/0ZTJcNsJAWvo7ENstPpWVMKXUwU
   hGwY5J/M1gtUBsHK343NMLuDmTBGrYPSOuIAsEBR8gOQU4EkiS65vNk43
   mBCfRlkIDUkSERtbG8H68bK+qDt+nr+1T+1HE2ciVUVhSyG/1fsOq+aNZ
   SbEzyqImci2mH5YaA5aYB3Q+ObRu6ye8ee5IKbTE4wM6D4+8U/idhySbg
   g==;
X-CSE-ConnectionGUID: trGk82ZIQOurxr3f1hqhxQ==
X-CSE-MsgGUID: ggiBiH3wRYO70duNo1EaHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79725694"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79725694"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 12:04:19 -0700
X-CSE-ConnectionGUID: oXDAhsc2QdiyuCfl5fL8Vg==
X-CSE-MsgGUID: kHBkbUshStS3S5OjmrBe2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238895618"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa009.jf.intel.com with ESMTP; 15 May 2026 12:04:18 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v5 0/4] ixgbe: four bug fixes
Date: Fri, 15 May 2026 21:04:13 +0200
Message-ID: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52C4D556909
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-288429-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Four fixes for the ixgbe driver, covering a SWFW semaphore timeout
miscalculation, a false-success return in the cls_u32 nexthdr path,
an adaptive-ITR u8 overflow, and wrong bit positions in the UP-to-TC
register normalisation.

Patch 1 fixes a timeout too short for X550 family FW update operations,
which caused spurious EBUSY failures during module-update and SR-dump
commands.

Patches 2-4 fix correctness bugs with user-visible effects: a cls_u32
nexthdr offload path that silently dropped filter-install errors, an
adaptive-ITR path that corrupted the mode flag via u8 truncation, and
a UP-to-TC validation loop that cleared only UP1 regardless of which
user priority was out of bounds.

Patch 3 reworks the ITR write-back to keep the mode flag
(IXGBE_ITR_ADAPTIVE_LATENCY, bit 7) and the usec delay in separate
operands until the final store, and clamps the delay to
[IXGBE_ITR_ADAPTIVE_MIN_USECS, IXGBE_ITR_ADAPTIVE_MAX_USECS] via
clamp_val().

Patch 4 corrects the Fixes: tag to 8b1c0b24d9af ("ixgbe: configure
minimal packet buffers to support TC") per Simon Horman.

Changes in v5:
 - DROPPED "ixgbe: call ixgbe_setup_fc() before fc_enable() after NVM
   update" (was 2/5 in v4).
   ixgbe_setup_fc_e610() is documented as an init-time-only operation.
   Calling it unconditionally from ixgbe_watchdog_update_link() on
   every link-up event causes it to issue an ACI set_phy_cfg command
   with IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT on E610 (Linkville) devices.
   That flag instructs the firmware to re-initialise the PHY, which
   immediately drops the link; the resulting link-up triggers another
   watchdog call, which issues another set_phy_cfg, creating a rapid
   reset loop during early init.  The E610 firmware's fault-detection
   logic sets IXGBE_GL_MNG_FWSM_RECOVERY_M in response, causing all
   E610 ports to report "Firmware recovery mode detected. Limiting
   functionality." and enumerate no network interfaces.
   A correct fix must gate the setup_fc() call on an actual NVM-update
   event rather than on every link-up; that rework will be sent as a
   separate series once the interaction with the E610 ACI PHY-config
   path is fully understood.
 - 1/4 (was 1/5), 2/4 (was 3/5), 3/4 (was 4/5), 4/4 (was 5/5):
   renumbered only; no code or commit-message change.

Changes in v4:
 - DROPPED "ixgbe: add bounds check for debugfs register access"
   (was 2/6 in v3).  The WARN_ON_ONCE(reg > IXGBE_HFDR) guard added
   to ixgbe_read_reg() fires on legitimate driver code paths on
   X550EM_a / E610 (LKV): probe reads IXGBE_EEC(hw), which on those
   parts resolves to IXGBE_EEC_X550EM_a == 0x15FF8, exceeding
   IXGBE_HFDR == 0x15FE8.  IXGBE_LINKS_10G_LANE_SYNC (0x17000) is
   another in-driver register beyond IXGBE_HFDR.  The premise of the
   patch -- that IXGBE_HFDR is the highest valid MMIO offset -- is
   incorrect, so the read-side guard cannot be retained as written,
   and the debugfs-side bound suffers from the same wrong ceiling.
   A correct debugfs-only bound (against pci_resource_len(BAR0)) will
   be sent separately if/when needed; that work is outside the scope
   of these -net fixes.  Reported by Larysa Zaremba.
 - 1/5 (was 1/6), 2/5 (was 3/6), 3/5 (was 4/6), 4/5 (was 5/6),
   5/5 (was 6/6): renumbered only; no code or commit-message change.

Changes in v3:
 - cover: removed Patch 1 squash-history description.
 - 1/6: add Reviewed-by: Simon Horman, Reviewed-by: Jacob Keller.
 - 2/6: add Reviewed-by: Simon Horman; no code change.
 - 3/6: add backplane-link guard in ixgbe_watchdog_update_link().
 - 4/6: add Reviewed-by: Simon Horman; no code change.
 - 5/6: rework clamping -- use clamp_val() with mode and delay as
        separate operands; clamp to [IXGBE_ITR_ADAPTIVE_MIN_USECS,
        IXGBE_ITR_ADAPTIVE_MAX_USECS].
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

Aleksandr Loktionov (4):
  ixgbe: fix SWFW semaphore timeout for X550 family
  ixgbe: fix cls_u32 nexthdr path returning success when no entry installed
  ixgbe: fix ITR value overflow in adaptive interrupt throttling
  ixgbe: fix integer overflow and wrong bit position in ixgbe_validate_rtr()

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 17 +++++++++--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  8 ++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)

