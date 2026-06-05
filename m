Return-Path: <netdev+bounces-295859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M88xLZXrImr/fAEAu9opvQ
	(envelope-from <netdev+bounces-295859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:30:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2825B649522
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=T5yPbBDC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295859-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295859-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C009C3002798
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3892B3B71B1;
	Fri,  5 Jun 2026 15:24:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDA212B2F;
	Fri,  5 Jun 2026 15:24:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673096; cv=none; b=cJmZ1BN7LjXDpvu4qZP0WGV3ddbxv50X1L6jPKLEGH/GTsOZb9yoBeuIIHI9F1/y75ZjKARAUvEERUs6ASDVizBmlWnetreOCGnsQL1x8lSlMLE5B/M4eoSp2qOL2dCqjKjwWHy34ennT19KWO7/bKJqlkiAJfe04+/fY9sIjuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673096; c=relaxed/simple;
	bh=8OxUDQ3/e0Fu095IQe8eyi8DfotROE8t9tHxgHyiBcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H+sXouAXw+dfy5QfTgvLMQ/qR7XflihIkLGaKWviHX1MEKdUP2l7ACL8PkUxtw4PVkj6ZUex8EpT2WigvMzYeE6UmJXjptT6yWcH5CB6w+B1tx4SOmeepz2GfesXAs3aUXe9RK0UM5l5kxIRaY38iMREu0pL+Vqqg9Y0o5o0VvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5yPbBDC; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780673094; x=1812209094;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8OxUDQ3/e0Fu095IQe8eyi8DfotROE8t9tHxgHyiBcQ=;
  b=T5yPbBDCF4K6c3ZwopnLCt9YZYQMckTG8AFFSGvNhG+u6eVCquZ4Ep4o
   mTSuC5RHVDreMgd1NoDfzRu6IPtI456gC099hc7Kg3mbOkKxnjSbTVo8k
   W7aupwhvv7h6ilCxhqGjOLarBe3JgSG1Nxr3rHE20JYNMg0cRZBshaBI3
   XHYByXNcD5LQBeDYXZkbiL+U4jB/zW+VKIglb19WV3u+bB/HTzkcqpb0Q
   fPPsRdIAXp95mM++s0dBOhSKUXDYdLcHQfm2WVzghZEhMZ+4rn9ZRhT9e
   BMWlGE36HaCqhN2WIFj1HluqvOfqIWrYiZg2x5tJq7Tkf8f4yhnqxyj9i
   w==;
X-CSE-ConnectionGUID: X9ilHSKxQe26zeZgPrLOSg==
X-CSE-MsgGUID: Zz5Dex66QRaHOue8LJSlKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="106948903"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="106948903"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:24:53 -0700
X-CSE-ConnectionGUID: P9gA1J+BTu6AKSb6sfTMHg==
X-CSE-MsgGUID: kmhn5D48TVG5KSNirbs+wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="249798564"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa005.jf.intel.com with ESMTP; 05 Jun 2026 08:24:48 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v13 net-next 00/11] dpll/ice: Add generic DPLL type and full TX reference clock control for E825
Date: Fri,  5 Jun 2026 17:20:19 +0200
Message-Id: <20260605152030.891570-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295859-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:grzegorz.nitka@intel.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:from_mime,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2825B649522

NOTE: This series is intentionally submitted on net-next (not
intel-wired-lan) as early feedback of DPLL subsystem changes is
welcomed. In the past possible approaches were discussed in [1].

This series adds TX reference clock support for E825 devices and exposes
TX clock selection and synchronization status via the Linux DPLL
subsystem.

Here is the high-level connection diagram for E825 device:
  +------------------------------------------------------------------+
  |                                                                  |
  |                           +-----------------------------+        |
  |                           |                             |        |
  |                           |         MAC                 |        |
  |                           |+------------+-----+         |        |
  |                           ||RX/1588 |PHC|tspll<----\    |        |
+---+----+                    ||MUX     +---+-^---|    |    |        |
| E | RX >--------------------->              |   >--\ |    |        |
| T |    |    /---------------->              |   >-\| |    |        |
| H |----+    |               |+---------+----^---+ || |    |        |
| 1 | TX <----|----------------+TX MUX   < OCXO   | || |    |        |
|   |PLL |    |               ||         |--------| || |    |        |
+---+----+    |           /----+         <-ext_ref<-||-|----|------ext_ref
| E | RX >----/           |   ||         |--------+ || |    |        |
| T |    |                |   ||         <  SyncE | || |    |        |
| H |----+                |   |+-----------^------+ || |    |        |
| 2 | TX <----------------/   |            | /------||-/    |        |
|   |PLL |                    +------------|-|------||------+        |
+---+----+                              /--/ |      ||               |
| . | RX >---                           |    |      ||               |
| . |    |                   +----------|----|------||--+            |
| . |----+                   |        +-^-+--^+     ||  |            |
|   | TX <---                |        |EEC|PPS|     ||  |            |
|   |PLL |                   |        +-------+     ||  |            |
+---+----+                   |        |       <-CLK0/|  |            |
| E | RX >---                |        |  DPLL |      |  |            |
| T |    |                   |        |       <-CLK1-/  |            |
| H |----+                   |        |       |         |            |
| X | TX <---                |        |       <---SMA---<            |
|   |PLL |                   |        |       |         |            |
+---+----+                   |        |       <---GPS---<            |
  |                          |        |       |         |            |
  |                          |        |       <---...---<            |
  |                          |        |       |         |            |
  |                          |        +-------+         |            |
  |                          | External timing module   |            |
  |                          +--------------------------+            |
  +------------------------------------------------------------------+

E825 hardware contains a dedicated TX clock domain with per-port source
selection behavior that is distinct from PPS handling and from board-level
EEC distribution. TX reference clock selection is device-wide, shared
across ports, and mediated by firmware as part of link bring-up. As a
result, TX clock selection intent may differ from effective hardware
configuration, and software must verify outcome after link-up.

To support this, the series extends the DPLL core and the ice driver
incrementally. The series also introduces DPLL_TYPE_GENERIC as a broad
UAPI class for DPLL instances outside PPS/EEC categories. The intent is
to keep type naming reusable and scalable across different ASIC
topologies while preserving functional discoverability via
driver/device context and pin topology.

This follows netdev discussion guidance that UAPI type naming should avoid
location-specific or vendor-specific taxonomy, because such labels do not
scale across different ASIC designs. The function of a given DPLL instance
is already discoverable from driver/device context and pin topology, and
does not require an additional narrow type identifier in UAPI.

At the same time, a separate DPLL object is still needed for E825 TX clock
control/reporting semantics. Using DPLL_TYPE_GENERIC provides a reusable
class for devices outside PPS/EEC without overfitting UAPI naming to one
topology.

The relevant discussion is in [2].

Series content
- add a new generic DPLL type for devices outside PPS/EEC classes;
- relax DPLL pin registration rules for firmware-described shared pins
  and extend pin notifications with a source identifier;
- allow dynamic state control of SyncE reference pins where hardware
  supports it;
- add CPI infrastructure for PHY-side TX clock control on E825C;
- introduce a TX-clock DPLL device and TX reference clock pins
  (EXT_EREF0 and SYNCE) in the ice driver;
- extend the Restart Auto-Negotiation command to carry a TX reference
  clock index;
- implement hardware-backed TX reference clock switching, post-link
  verification, and TX synchronization reporting.

TXCLK pins report TX reference topology only. Actual synchronization
success is reported via DPLL lock status, updated after hardware
verification: external TX references report LOCKED, while the internal
ENET/TXCO source reports UNLOCKED.

This provides reliable TX reference selection and observability on E825
devices using standard DPLL interfaces, without conflating user intent
with effective hardware behavior.

[1] https://lore.kernel.org/netdev/20250905160333.715c34ac@kernel.org/
[2] https://lore.kernel.org/netdev/20260402230626.3826719-1-grzegorz.nitka@intel.com/

Changes in v13:
- rebased
- addressed AI review comments:
  New dpll-core fixes (prerequisites for the ice patches; surfaced
  under rmmod/rebind with zl3073x sharing the fwnode RCLK parent):

  * 3/11 dpll: fix stale iteration in dpll_pin_on_pin_unregister().
    Walk pin->dpll_refs and filter by
    dpll_pin_registration_find(cookie=parent); both
    parent->dpll_refs and an unfiltered pin->dpll_refs are unsafe
    when another driver (un)registers the parent against more
    DPLLs after the child was attached, leaving WARN_ON(!reg) and
    dangling registrations.

  * 4/11 dpll: send delete notification before unregister in
    on-pin rollback. Otherwise the last unregister clears
    DPLL_REGISTERED and the notification fails
    dpll_pin_available() with -ENODEV.

  * 5/11 dpll: emit per-dpll delete notifications in
    dpll_pin_on_pin_unregister(). Register emits N creates over
    parent->dpll_refs; unregister now emits N matching deletes.

  Fix possible deadlock on flush_workqueue() on error path:
  * 8/11 (was 5/8) ice: introduce TXC DPLL device...: signal
    pf->dplls.dpll_init from the error path of
    ice_dpll_init_fwnode_pins() so a notifier worker blocked on it
    can drain, avoiding a flush_workqueue() deadlock during teardown.

- Renumbered v12 3-4/8 and 6-8/8; rebased on net-next; no
  functional change in those.

Changes in v12:
- rebased
- rename the second parameter of ice_cpi_ena_dis_clk_ref() from
  "port" to "phy"; the value is a PHY index, not a port number (patch 6/8)
- Addressed AI review concerns (patch 8/8):
  - Close UAF on rmmod in ice_dpll_txclk_state_on_dpll_set(): hold
    pf->dplls.txclk_notify_rwsem for read and gate on ICE_FLAG_DPLL
    under pf->dplls.lock so a late netlink set call cannot queue
    txclk_work after cancel_work_sync() and touch freed pins.

  - ice_dpll_deinit_txclk_pins(): NULL the EREF pin slot after
    ice_dpll_release_pins() (the SYNCE path already does this via
    ice_dpll_release_fwnode_pin()), so ice_txclk_get_pin() cannot
    return a dangling pointer to late callers.

  - ice_dpll_init_info_e825c(): seed dt->dpll_state from
    ice_txclk_lock_status(pf->ptp.port.tx_clk) so boards that boot
    with SYNCE or EREF0 already selected report LOCKED at probe
    instead of staying UNLOCKED until the next switch.

  - ice_txclk_set_clk() and ice_txclk_enable_peer(): hold
    ctrl_pf->dplls.lock across the any_port_uses() check and the
    ice_cpi_ena_dis_clk_ref() enable AQ, closing the cross-PF
    check-then-act window that allowed duplicate enables.

  - ice_txclk_set_clk(): clear pf->dplls.txclk_switch_requested
    before submitting the AN restart so the post-AN link-up running
    ice_txclk_update_and_notify() does not bail on a stale
    "switch still pending" check.

  - ice_txclk_update_and_notify(): take ctrl_pf->dplls.lock
    (conditionally when ctrl_pf != pf) across the tx_refclks[phy][i]
    update loops per the documented order
    pf->dplls.lock -> ctrl_pf->dplls.lock, so writers and readers
    on non-controlling PFs share a non-empty lockset.

Patches 1-5, 7: no functional change

Changes in v11:
- rebased
- changed 'opcode' argument type to u8 (patch 6/8)
- fixed white spaces (changed to TAB) in ice_cpi.h (patch 6/8)
- removed duplicated definition of ICE_E825_MAX_PHYS (patch 8/8)

Changes in v10:
- rebased
Addressed AI review (Sashiko) concerns (all in patch 8/8):
- moved INIT_WORK(txclk_work) and added init_rwsem(txclk_notify_rwsem)
  next to mutex_init(&d->lock) in ice_dpll_init_e825() so both are
  initialized before any path that can fail and trigger ice_dpll_deinit()
- added struct rw_semaphore txclk_notify_rwsem to struct ice_dplls and
  used it (down_read across the whole critical region of
  ice_txclk_update_and_notify(), including the out-of-lock dpll_*_change_ntf()
  calls; down_write/up_write barrier in ice_dpll_deinit() to drain
  in-flight notifiers before pins and the TXC DPLL device are freed) -
  closes a use-after-free window on rmmod
- ice_dpll_txclk_state_on_dpll_set(): reject pin states other than
  CONNECTED/DISCONNECTED with -EINVAL and NL_SET_ERR_MSG() instead of
  silently treating them as a connect request
- ice_dpll_txclk_work(): on a failed switch, capture old/new pin pointers
  under the lock and emit dpll_pin_change_ntf() after dropping it, so
  userspace sees the requested pin flip back to DISCONNECTED and the
  effective pin to CONNECTED
- ice_dpll_txclk_work(): only clear txclk_switch_requested / roll back
  tx_clk_req when no newer request arrived while the lock was dropped,
  so a re-queued worker run picks up the updated value
- ice_txclk_update_and_notify(): replaced the
  pf->dplls.txc.dpll = ERR_PTR(-ENODEV) "suppress notification" hack
  with an explicit local bool notify_dpll; the dpll_state update and
  the notification decision are made under the lock, the notification
  itself is emitted after unlock
- ice_ptp_setup_pf(): seed the per-PHY Tx reference clock usage map
  only on E825 and explained the "no locking needed" invariant in a
  comment (runs before pf->dplls.lock exists and before any link event
  or DPLL callback can observe the map)
- moved port_num/phy and tx_ref_clk locals into the E825-only branches
  where they are actually used
- ice_txclk_enable_peer(): use ice_pf_to_dev(pf) for dev_err() to match
  the rest of the file (was ice_hw_to_dev(&pf->hw))
- extended ctrl_pf->dplls.lock coverage in ice_txclk_set_clk() and
  ice_txclk_enable_peer() across both the usage check and the
  ice_cpi_ena_dis_clk_ref() AQ command so two PFs racing to switch to
  the same (phy, clk) cannot both observe clk_in_use == false and issue
  duplicate enables
Other:
- replaced ternary-for-statement-effect (`(clk == i) ? set_bit() :
  clear_bit();`) with plain if/else in the two tx_refclks bitmap loops
- dropped 15 unused CFG_*/CFG_RESERVED* SERDES field defines in
  ice_ptp_hw.h; kept only CFG_ICTL_PCS_REF_SEL_RX_NT,
  CFG_ICTL_PCS_REF_SEL_TX_NT and REF_SEL_NT_ENET/EREF0/SYNCE which are
  actually consumed
- updated kernel-doc for struct ice_dpll
Patch 7/8:
- cosmetic: removed a stray double space in the
  ice_aq_set_link_restart_an() prototype
Patches 1-6: unchanged

Changes in v9:
- rebased
- fixed kernel-doc: member 'module_name' not described in 'dpll_pin' (patch 2/8)
Addressed AI review concerns:
- reworded commit message to use 'src_clock_id' instead 'src_id' (patch 3/8)
- use rclk.num_parents when setting is_rclk_parent (patch 5/8)
- fixed retry mechanism in ice_cpi_wait_ack (patch 6/8)
- fixed txclk_switch_requested, tx_clk, tx_clk_req settings on HW
  failure (patch 8/8)
- use cancel_work_sync instead flush_work (patch 8/8)
- protect clearing ICE_FLAG_DPLL flag with mitex on DPLL
  deinit (patch 8/8)
- dpll_state update and the notify_dpll decision are made inside
  the lock (patch 8/8)

Changes in v8:
- rebased
Addressed AI review concerns:
- caching the module name in the pin object at allocation time and using
  the cached string in netlink paths (patch 2/8)
- dropped references to netlink in the commit message for (patch 3/8, it's
  internal notification only)
- replaced the commit 4/8 with the new one (relax the capability check in
  dpll_pin_state_set)
- resolved potential teradown race between ice_dpll_deinit_txclk_pins and
  ice_dpll_pin_notify_work() that is about to register the SYNCE pin
  (patch 5/8)
- resolved potential path deadlock during driver probe and error path
  (patch 5/8)
- relaxed kernel-doc regarding cpi mutex usage (patch 6/8)
- fixed ice_cpi.c header (patch 6/8)
- fix retry mechanism in ice_cpi_wait_req0_ack0 (patch 6/8)
- fix potrntial leaving LM.REQ stuck asserted on the hardware (patch 6/8)
- fix kernel-doc for ice_cpi_ena_dis_clk_ref
- removed unused CPI definitions (patch 6/8)
- fix header inclusion (patch 6/8)
- addressed Sashiko issues for patch (8/8)

Changes in v7:
- rebased
- replace TXC-specific DPLL type with DPLL_TYPE_GENERIC (patch 1/8)
- update TXC framework to use DPLL_TYPE_GENERIC instead of DPLL_TYPE_GENERIC
  (patch 5/8)
- AI-review: added short trailing comment to the local mutex declaration
  to satisfy checkpatch report (patch 6/8)

Changes in v6:
 - rebased
 - AI-review: fix unprotected concurrent access to shared clock
   bitmap (patch 8/8)
 - AI-review: fix potential issue in tx-clk pin state request handling
   ('already set' early-exit based now on tx_clk_req comparison, patch 8/8)
 - AI-review: CPI transaction serialization (patch 6/8) 

Changes in v5:
 - rebased
 - reworded cover letter
 - replace 'ntfy_src' new argument name with 'src_clk_id' and use it
   consistently in DPLL notification calls (patch 3/8)
 - reworded commit message (patch 5/8)
 - use FIELD_PREP/GENMSK macros instead of struct bitfields (patch 6/8)
 - reworded commit message (patch 5/8, patch 8/8)
 - refactor the code to avoid sleeping while DPLL mutex is held (using
   work_queue, patch 8/8)
 - added TXCLK pins and TXC DPLL notifications (patch 8/8)
 - removed 'unused clock disable' mechanism from the scope of this series

Changes in v4:
 - rebased
 - edited, shortened the commit message in 3/8 patch
 - moved ice_get_ctrl_pf to the header file (patch 8/8) and
   removed duplicated static definitions from ice_ptp and ice_txlck
   modules
 - add NULL/invalid pointer checker for returned pointer from
   ice_get_ctrl_pf (patch 8/8)
 - edited error message in case AN restart failure (patch 8/8)

Changes in v3:
- improved commit message (patch 1/8, AI review comment)
- improved deinitialization path in ice_dpll_deinit_txclk_pins to
  avoid potential NULL dereference. NULL checking moved to
  ice_dpll_unregister_pins (patch 5/8, found by AI review)
- removed redundant semicolon (patch 6/8)

Changes in v2:
- rebased
- added autogenerated DPLL files (patch 1/8)
- fixed checkpatch 'parenthesis alignment' warning (patch 2/8)
- fixed error path in ice_dpll_init_txclk_pins (AI warning, patch 5/8)
- fixed kdoc warnings (patch 6/8, patch 8/8)

Grzegorz Nitka (11):
  dpll: add generic DPLL type
  dpll: allow registering FW-identified pin with a different DPLL
  dpll: fix stale iteration in dpll_pin_on_pin_unregister()
  dpll: send delete notification before unregister in on-pin rollback
  dpll: emit per-dpll delete notifications in
    dpll_pin_on_pin_unregister()
  dpll: extend pin notifier with notification source ID
  dpll: allow fwnode pins to attempt state change without capability bit
  ice: introduce TXC DPLL device and TX ref clock pin framework for E825
  ice: implement CPI support for E825C
  ice: add Tx reference clock index handling to AN restart command
  ice: implement E825 TX ref clock control and TXC hardware sync status

 Documentation/netlink/specs/dpll.yaml         |   3 +
 drivers/dpll/dpll_core.c                      |  43 +-
 drivers/dpll/dpll_core.h                      |   5 +-
 drivers/dpll/dpll_netlink.c                   |  26 +-
 drivers/dpll/dpll_netlink.h                   |   4 +-
 drivers/dpll/dpll_nl.c                        |   2 +-
 drivers/net/ethernet/intel/ice/Makefile       |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  12 +
 drivers/net/ethernet/intel/ice/ice_adapter.c  |   4 +
 drivers/net/ethernet/intel/ice/ice_adapter.h  |   7 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_cpi.c      | 362 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_cpi.h      |  58 +++
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 493 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  36 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  37 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   6 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  37 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  17 +
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c    | 347 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_txclk.h    |  40 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
 include/linux/dpll.h                          |   1 +
 include/uapi/linux/dpll.h                     |   2 +
 28 files changed, 1500 insertions(+), 63 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.h


base-commit: bfa3d89cc15c09f7d1581c834a5ed725189ec19f
-- 
2.39.3


