Return-Path: <netdev+bounces-270779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MUUKMi9wWlSWAQAu9opvQ
	(envelope-from <netdev+bounces-270779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:25:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D42FE346
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C218301BDC3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C9C382F1E;
	Mon, 23 Mar 2026 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxbsGxw3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6C3822BF;
	Mon, 23 Mar 2026 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304711; cv=none; b=hR1pltBVrnlgPExUXCLdjY7eW3ewKm5SqEhRJgb5C00d2lYAckk9cjdOI2ALxY1dD8vaTVJkQX1aU744YDEljTOXbddzUXTZ57RR/6VDiW7t0aLHVce8n0pxrdlgbq6YM25FSVoUbhDEogCs1kVwtSBrmGmoaxTre0F1ngqjC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304711; c=relaxed/simple;
	bh=sjFyRv66DAaBXLmXzPIDUVSo3fvSMJQ1La8ROeyuq+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g/WGvxxltJT8wBs6lb94nMfQhf1uDZwgh4lGrZ88OtYfmfP0mZrZhW0+I1z8YE6TkAtSd4eWpgPn5vqzITiJRu+YLI/qse+VZZ6ljOtWVQF5QwAF2aFnsDqdIRMtTJBmPonRT7IoQNr+6UKX1q7GyMg8WbN064ra5lpiXtIeEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxbsGxw3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774304709; x=1805840709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sjFyRv66DAaBXLmXzPIDUVSo3fvSMJQ1La8ROeyuq+c=;
  b=VxbsGxw3uOST+zVNGi7OU4EZ5VXKI1zalpVuVLnwmIW4yT+DS6tIPiaN
   9rhVMdH+03w+GPuBWf79gvEX3qRk8g29QDMOpataMPQhGwj+GETF7Cno9
   VGxcxP+2uN4PU1QrcVv/RO62GFfU7ml5L4VVBxjiO3ADdDu9xGFx2DZwq
   MStKUad+k9nKU31ZFPzzAFuQuCSJ9OUyv1tzjWKKQkmbYCwgHdjsF+2CE
   bfKOGkyUnqgoEyDG0JuIsUw6YcrPqLA4635x3jja5cKE9cpis99EEQO/v
   RufZsvPhlkfMMDMAkE8vFnIC8fA+THzgE0cGMdLrCSAxOXtST0f21OWw3
   w==;
X-CSE-ConnectionGUID: kVGbg+YEQdW4VRZIe7zCCA==
X-CSE-MsgGUID: +hexiCR6RLezOQSF32Kz+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75221811"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75221811"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:25:08 -0700
X-CSE-ConnectionGUID: gKe+7TSoSy2oArqP4LvONQ==
X-CSE-MsgGUID: +0z0P1H4SUGh0RXQiFStcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247207235"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa002.fm.intel.com with ESMTP; 23 Mar 2026 15:25:03 -0700
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
Subject: [PATCH v3 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX reference clock control for E825
Date: Mon, 23 Mar 2026 23:21:25 +0100
Message-Id: <20260323222133.1796997-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-270779-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 393D42FE346
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


NOTE: This series is intentionally submitted on net-next (not
intel-wired-lan) as early feedback of DPLL subsystem changes is
welcomed. In the past possible approaches were discussed in [1].

This series extends the DPLL subsystem and the ICE driver to fully
support transmit‑clock (TXC) reference selection on Intel E825‑class
hardware. These devices expose a dedicated TX reference clock domain
separate from PPS and SyncE/EEC, and they allow switching between
multiple PHY‑sourced references (TXC0, EREF0, SyncE). Until now
the kernel lacked a DPLL type to represent TXC‑class devices, and
the ICE driver had no way to control or report the active TX reference.
The series introduces: 

Subsystem‑wide improvements:

- A new DPLL type (DPLL_TYPE_TXC) to represent devices that generate a TX
SERDES reference clock.
- Improvements to pin registration for fwnode‑identified pins.
- Addition of a notification source identifier (src_id) for more accurate
pin event routing in both netlink and internal notifiers.

Hardware/driver support:

- ZL3073x: allow control of the SyncE_Ref pin state.
- ICE/E825: full TXC DPLL instance with dedicated pins (EXT_EREF0 and
SyncE) and proper integration into the notifier/mux logic.
-A new CPI (Converged PHY Interface) subsystem implementing the low‑level
command protocol required by E825 PHY clocking control.
- Extension of the Restart AN AQ command with a TX reference clock
selector.
- Complete support for selecting, enabling, disabling, and tracking the
active TX reference clock for E825 devices, including peer‑PHY routing
and safe clean‑up of unused clock sources.

This enables proper userspace‑driven clock control via the DPLL API and
is a prerequisite for advanced SyncE deployments, link recovery modes, and
multi‑clock orchestration on E825 NICs.

Patch summary:

dpll: add new DPLL type for transmit clock (TXC) usage
Introduces DPLL_TYPE_TXC and publishes it through netlink.

dpll: allow registering FW‑identified pin with a different DPLL
Relax the (module, clock_id) matching rules when fwnode pins are
involved.

dpll: extend pin notifier and netlink events with notification source ID
Adds src_id to pin notification paths and updates all callers.

dpll: zl3073x: allow SyncE_Ref pin state change
Advertise hardware support for state toggling.

ice: add TX clock (TXC) DPLL interface for E825 devices
Introduces the ICE TXC DPLL, its pins, and relations to existing PHY
fwnode pins.

ice: implement CPI support for E825C
Adds the CPI command engine used for PHY‑side clock control.

ice: add Tx reference clock index handling to AN restart command
Wires the refclk field into the AQ Restart AN command.

ice: add TX reference clock (tx_clk) control for E825 devices
Implements full clock‑selection logic, state tracking, cleanup, and
DPLL pin ops integration.


Testing was performed on E825C hardware in multi‑port configurations,
verifying TXC pin exposure, SyncE/EREF0 switching via DPLL netlink, and
link recovery across all combinations.

[1] https://lore.kernel.org/netdev/20250905160333.715c34ac@kernel.org/

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

Grzegorz Nitka (8):
  dpll: add new DPLL type for transmit clock (TXC) usage
  dpll: allow registering FW-identified pin with a different DPLL
  dpll: extend pin notifier and netlink events with notification source
    ID
  dpll: zl3073x: allow SyncE_Ref pin state change
  ice: add TX clock (TXC) DPLL interface for E825 devices
  ice: implement CPI support for E825C
  ice: add Tx reference clock index handling to AN restart command
  ice: add TX reference clock (tx_clk) control for E825 devices

 Documentation/netlink/specs/dpll.yaml         |   3 +
 drivers/dpll/dpll_core.c                      |  32 +-
 drivers/dpll/dpll_core.h                      |   2 +-
 drivers/dpll/dpll_netlink.c                   |  10 +-
 drivers/dpll/dpll_netlink.h                   |   4 +-
 drivers/dpll/dpll_nl.c                        |   2 +-
 drivers/dpll/zl3073x/prop.c                   |   9 +
 drivers/net/ethernet/intel/ice/Makefile       |   2 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_cpi.c      | 347 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_cpi.h      |  69 ++++
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 327 +++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |   6 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  22 ++
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   7 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  37 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  34 ++
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c    | 237 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_txclk.h    |  41 +++
 include/linux/dpll.h                          |   1 +
 include/uapi/linux/dpll.h                     |   2 +
 25 files changed, 1163 insertions(+), 48 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.h


base-commit: fb78a629b4f0eb399b413f6c093a3da177b3a4eb
-- 
2.39.3


