Return-Path: <netdev+bounces-277176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHTnNV082Gk5aQgAu9opvQ
	(envelope-from <netdev+bounces-277176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 01:55:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 392413D099B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 01:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B162E300D858
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 23:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BCA39F182;
	Thu,  9 Apr 2026 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQKEbPo9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F9C18C02E;
	Thu,  9 Apr 2026 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778907; cv=none; b=Ivb1HvydzRmmCLeInzXvmpPIQc/wz3xnQw60G11IQRaCNdydIblUPWxvzN7au+uHS/JAIfat9bRudzU+O9mK5ztRWnu/xxbbJyTzpl+7lZUDDnyHkXL7w10t7GvDiXc6MCQh6KhP0hJY0478+9z6SDEMSu373Sqt+FluQdmhICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778907; c=relaxed/simple;
	bh=+DkDhE3MSB+tWlg/ttUoEXBLRBLLHvQjNBR6RSY4g40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aGct+fCiFewOwBRv9JbMnqvbycTxTNWvC+V7nduJIe9QBxJObuPFrrvM4bAKpFTvxqWDmesmezaN9bRHDhxaelmusv4285w9HoE2Pp43Ritn4nmGmVvCy53vYMXS7M7+ADk6gLT1CvTxJHYqcs9a3hnwjj2G3vK65M/heWBu9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQKEbPo9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775778905; x=1807314905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+DkDhE3MSB+tWlg/ttUoEXBLRBLLHvQjNBR6RSY4g40=;
  b=EQKEbPo9sBfXNBFKmW7Hm9qKZW34l6sr87CSyAlNgaHvD7LKR9pWITnk
   b4oV1duIvfo8kAzVto4S3KCZG0Q33hMbVf1iXpjVpAETCAZttXpuwV41s
   jgaj2OpLa1toNn+KTnzQNjiaXHuKw8FG0AL/NlUVRHNaxUVY/UavD+pEI
   IZab9eKgtpLitaFHv9YJFwsE9YoPS/eHioLTLYv15xW/UcDYDvtesMNdN
   1nuHE83XLOKpWkEQIt3nD6Yl0hdAy3JxVDlc3zBPmukbdZkzB0mYSIHPu
   t4oJ2d4fvydGnxIb6Ja6FHaETzGH3m6Nc0RJ7tqAuts696PZN9qE/vzBR
   g==;
X-CSE-ConnectionGUID: MLd80FJcRFKCPuwKVGaBMg==
X-CSE-MsgGUID: Wo/wN4gzSl2ZkRSLYklZzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87424021"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="87424021"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 16:55:05 -0700
X-CSE-ConnectionGUID: CgDjMLetSwqfqnzJQ7HpYw==
X-CSE-MsgGUID: x7mu9uWySIalAGHnfO4qzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="228859678"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa008.jf.intel.com with ESMTP; 09 Apr 2026 16:55:00 -0700
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
Subject: [PATCH v6 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX reference clock control for E825
Date: Fri, 10 Apr 2026 01:51:14 +0200
Message-Id: <20260409235122.436749-1-grzegorz.nitka@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-277176-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 392413D099B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NOTE: This series is intentionally submitted on net-next (not
intel-wired-lan) as early feedback of DPLL subsystem changes is
welcomed. In the past possible approaches were discussed in [1].

This series adds TX reference clock support for E825 devices and exposes
TX clock selection and synchronization status via the Linux DPLL
subsystem.
E825 hardware contains a dedicated Tx clock (TXC) domain that is
distinct
from PPS and EEC. TX reference clock selection is device‑wide, shared
across ports, and mediated by firmware as part of the link bring‑up
process. As a result, TX clock selection intent may differ from the
effective hardware configuration, and software must verify the outcome
after link‑up.
To support this, the series introduces TXC support incrementally across
the DPLL core and the ice driver:

- add a new DPLL type (TXC) to represent transmit clock generators;
- relax DPLL pin registration rules for firmware‑described shared pins
  and extend pin notifications with a source identifier;
- allow dynamic state control of SyncE reference pins where hardware
  supports it;
- add CPI infrastructure for PHY‑side TX clock control on E825C;
- introduce a TXC DPLL device and TX reference clock pins (EXT_EREF0 and
  SYNCE) in the ice driver;
- extend the Restart Auto‑Negotiation command to carry a TX reference
  clock index;
- implement hardware‑backed TX reference clock switching, post‑link
- verification, and TX synchronization reporting.

TXCLK pins report TX reference topology only. Actual synchronization
success is reported via the TXC DPLL lock status, which is updated after
hardware verification: external Tx references report LOCKED, while the
internal ENET/TXCO source reports UNLOCKED.
This provides reliable TX reference selection and observability on E825
devices using standard DPLL interfaces, without conflating user intent
with effective hardware behavior.

[1] https://lore.kernel.org/netdev/20250905160333.715c34ac@kernel.org/

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

Grzegorz Nitka (8):
  dpll: add new DPLL type for transmit clock (TXC) usage
  dpll: allow registering FW-identified pin with a different DPLL
  dpll: extend pin notifier and netlink events with notification source
    ID
  dpll: zl3073x: allow SyncE_Ref pin state change
  ice: introduce TXC DPLL device and TX ref clock pin framework for E825
  ice: implement CPI support for E825C
  ice: add Tx reference clock index handling to AN restart command
  ice: implement E825 TX ref clock control and TXC hardware sync status

 Documentation/netlink/specs/dpll.yaml         |   3 +
 drivers/dpll/dpll_core.c                      |  32 +-
 drivers/dpll/dpll_core.h                      |   3 +-
 drivers/dpll/dpll_netlink.c                   |  10 +-
 drivers/dpll/dpll_netlink.h                   |   4 +-
 drivers/dpll/dpll_nl.c                        |   2 +-
 drivers/dpll/zl3073x/prop.c                   |   9 +
 drivers/net/ethernet/intel/ice/Makefile       |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  12 +
 drivers/net/ethernet/intel/ice/ice_adapter.c  |   4 +
 drivers/net/ethernet/intel/ice/ice_adapter.h  |   7 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_cpi.c      | 364 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_cpi.h      |  61 +++
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 380 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  10 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  26 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   7 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  37 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  34 ++
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c    | 251 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_txclk.h    |  38 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
 include/linux/dpll.h                          |   1 +
 include/uapi/linux/dpll.h                     |   2 +
 29 files changed, 1265 insertions(+), 53 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.h


base-commit: b6e39e48469e37057fce27a1b87cf6d3e456aa42
-- 
2.39.3


