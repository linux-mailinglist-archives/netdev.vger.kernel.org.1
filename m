Return-Path: <netdev+bounces-272142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lz3HalixWkJ+AQAu9opvQ
	(envelope-from <netdev+bounces-272142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:45:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD949338A57
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5BE33135D5D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13181378D8B;
	Thu, 26 Mar 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbGO5AFv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137F2DA755;
	Thu, 26 Mar 2026 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542740; cv=none; b=P4Tl6Na1SU2oqBhJGE/CtNvAqU11voYPZMsfa7K3aPZOHfXfJU+aatfcj2q+GtCwFfO9rTKmSo9Z2vl+dk7w0ADD++/A+lS1MvqMPjc6jOUbikfl94vw76DtZPEXMm8xA+F3wsTyPi3QVrO1/GtJmcoNXR2GpGsCT9ewKdh6iYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542740; c=relaxed/simple;
	bh=wwTIrqtwLgvHf+RVkDregSmCC7vSro8vZJLp94r7apQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ghRa1+rf/aVZAxDYcdLOR+KydpwJfEMm7J+kjQA1mR59zcb5IYuQFJl9m4WuzemaGIcq14r7havll4nxMdKRyweA6D6M0iJ7+9LD+k2BDGRivS3peKB2Idab8t3713t4XYjxDHYF6ieh8TqjRwiZtudG9mLuQk0JodJ1x2KArag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbGO5AFv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774542738; x=1806078738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wwTIrqtwLgvHf+RVkDregSmCC7vSro8vZJLp94r7apQ=;
  b=FbGO5AFvyCEZiW9QkxXutjadamopzygC1RXRmbrm3iUTa/tQKNjSwcwx
   FVmlvY8gttZRJ6a7L8f53XmBiWlcdMNilG9FdzTRMTo7aF6mRX93Hv9Xu
   k6BNHgzlIjCMd0uG2StSyJcri+FxlWGTqsl9IrRm6EYyiHtRLxg5KJ2EL
   4hvSHxafI7XPTPJjjGeg65YFSI0lFpRGCM0GiCeeYDoaXgu+CJi7qKzHP
   GU7KfEQaW4KhUoiwnONfnw8mmXdh3hgoRNmgiZB5dhddfAijR9TJ0mktL
   0WHsZyT8v7kOlfokS0zsBIFbeWGYRkoNJDZuZ0ZkQqWOy97oRP5yIaPmL
   g==;
X-CSE-ConnectionGUID: eipKUXmiQcqIDniFaKJPcg==
X-CSE-MsgGUID: 0jmMD7tuRHmU/0ZYjxAuDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74636532"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="74636532"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 09:32:17 -0700
X-CSE-ConnectionGUID: yWty21wOQLieRFpmZS22Eg==
X-CSE-MsgGUID: 2/jK9f1iQ2WB6beh716Fgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="225310843"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa007.jf.intel.com with ESMTP; 26 Mar 2026 09:32:13 -0700
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
Subject: [PATCH v4 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX reference clock control for E825
Date: Thu, 26 Mar 2026 17:28:24 +0100
Message-Id: <20260326162832.3135857-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-272142-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: DD949338A57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/ethernet/intel/ice/ice.h          |  12 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_cpi.c      | 347 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_cpi.h      |  69 ++++
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 327 +++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |   6 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  27 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   7 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  37 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  34 ++
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c    | 256 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_txclk.h    |  41 +++
 include/linux/dpll.h                          |   1 +
 include/uapi/linux/dpll.h                     |   2 +
 26 files changed, 1194 insertions(+), 53 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.h


base-commit: d1e59a46973719e458bec78d00dd767d7a7ba71f
-- 
2.39.3


