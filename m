Return-Path: <netdev+bounces-268932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Hm2D85sumkUWgIAu9opvQ
	(envelope-from <netdev+bounces-268932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:13:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D48D2B8BD0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5C5C31315E7
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFD939903B;
	Wed, 18 Mar 2026 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHpRepes"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C353A2550;
	Wed, 18 Mar 2026 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825048; cv=none; b=J+pxjdl1fK9yn/aRx+O0rYkAwZM1E22bu7moILhPiRQeC2XjfwTyRTxfxfhM47yoIN6I6auoUbKpXy+pSTkQ1tKNwtxW7F+0yK2CDJuSI3BBpvO62zxCU/JYvJBLQ+iPe3KGicpiSZ90nd7Cg0NA+3j3Z0t3M/OeU9sFOKAp1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825048; c=relaxed/simple;
	bh=OsUq9MT/WKFFuHoE98s1zqbaF+bdeR1BsToST9eQjI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dRtjTSAFxkM70++iZ7fa7V083w5wTby91hYHW3irwsEKUeQ87gNFVeL0or6pKzlu23TwNZdI8ifEEvP35ZCLRYRatUvG95ee7vfCnSWMCjeO6qMEEUEnl6bzwr/G1fr/e4wo/cKwZ0bogAuCk/D6NMctjRQIELn0j1xVjm1T70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHpRepes; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773825047; x=1805361047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OsUq9MT/WKFFuHoE98s1zqbaF+bdeR1BsToST9eQjI0=;
  b=YHpRepespxW0jKGO19fQ35c/RzsuaD0UziCURf1LSuelHnoDJOpx91Gt
   SzVhCcFmGeZxXE41q6ka7YPlnvGRc6vXVlyUv9Ph/FxYhiaWTcy7JI65m
   41as3xNNTs8gaST0sDmeKCN2+xfrSWw2gBZOSEibGjevMHghUocmM8lEy
   yVY2f8+/J8m1+bj0MigS9aTD5VlQe6syQiQCpDw8iL5TSIeeGuj5D9HzO
   QGEdJ/uvJL4PL5QYt8cHsYmprtMYx42MsARPIK82Ebbz67rJKk4PayZw9
   cmTOuEZZsgy2f//WnqAQukG1UkmnyBDNNslW3/dP2Y7XoGRIJx/YuRuQU
   A==;
X-CSE-ConnectionGUID: e6WdMkz0T3C1UbrOSbUIcg==
X-CSE-MsgGUID: LxtAb9D9QKeLOmnF6yB7iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="77484364"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="77484364"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:10:46 -0700
X-CSE-ConnectionGUID: ldzrgTbyR2urNR9buiKorQ==
X-CSE-MsgGUID: 11omW2hOTOSG0QdCNDDYhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="226699879"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa003.jf.intel.com with ESMTP; 18 Mar 2026 02:10:42 -0700
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
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH net-next 0/8] dpll/ice: Add TXC DPLL type and full TX reference clock control for E825
Date: Wed, 18 Mar 2026 10:06:46 +0100
Message-Id: <20260318090654.611349-1-grzegorz.nitka@intel.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268932-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9D48D2B8BD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NOTE: This series is intentionally submitted on net-next (not
intel-wired-lan) as early feedback od DPLL subsystem changes is
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
 drivers/dpll/zl3073x/prop.c                   |   9 +
 drivers/net/ethernet/intel/ice/Makefile       |   2 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_cpi.c      | 337 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_cpi.h      |  69 ++++
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 298 ++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |   6 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  22 ++
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   7 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  35 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  34 ++
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c    | 235 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_txclk.h    |  41 +++
 include/linux/dpll.h                          |   1 +
 include/uapi/linux/dpll.h                     |   2 +
 24 files changed, 1122 insertions(+), 44 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.h


base-commit: 8737d7194d6d5947c3d7d8813895b44a25b84477
-- 
2.39.3


