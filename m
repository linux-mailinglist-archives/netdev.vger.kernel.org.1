Return-Path: <netdev+bounces-274882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEdTNNNSz2nqvAYAu9opvQ
	(envelope-from <netdev+bounces-274882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:40:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E483911F0
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1A45302EEAA
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 05:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEB730F7F8;
	Fri,  3 Apr 2026 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mM282CX5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C824A076
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194833; cv=none; b=Vdv9Qhg7h5L+tAO1Uyj/5TVW8u0DWhX22gdwHo2VyCOrQLQLDqD+fznY6lqdRcWY8gK6ACsMQRGJ9OXmsVqjnkzY8LsPB6JHfN83BSMKxD1QH6d94v47wslghuVZ9gOswUbfJLHdJ8LkKmkgGe3xzIzeAozXNwqUN88Hxc2j+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194833; c=relaxed/simple;
	bh=kh+YWAf2VTHtmbkV09DF9p9P9mXR7YSvgJUqzn1JDT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1zmzugM3y+D621npJHVfQ9TgwZ3AZQWd9J66+YIUFMBNn+9P0QmdqouW2H3WdSuJNu0s16YttVEETytM4lqJKGIE7Q038syRvEDKp4n4QtqHuOcPm0vhVsvlMILHJoDVyRuh5Rvcqee5wkTfrzHEFHO33QaGVleDD2CL53eax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mM282CX5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775194832; x=1806730832;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kh+YWAf2VTHtmbkV09DF9p9P9mXR7YSvgJUqzn1JDT4=;
  b=mM282CX5FHSwTGnvAtLXYwmqGPNgH2262EPfkkQgu0M4E7Ox7rtK7jvI
   Rj1DXFLEhVk/h1iS7ZcRxRSQregFGT/rF3RpDQ0zGxeSCHARB2/brlZk5
   52YoMlEBimQyLzF6VDbNUxixJirLnCiOpI/dWImR54mdaBIh2f3UdeaXP
   IQrtRwJRsLvqoWrag7IQqNf0qjkiR+SfBmSSYxRa167JsjVRe6XQojYDY
   0w1yp3axp8mZvdNtvoOYsFZoumHLdIIxwOdsNhUCVd4PkEb8j7eDr1bYa
   XQA700+hEz5cE6hfWy5iPiUFKuHLj/t3cd27hPF3doX/wo38QzJV+POIX
   w==;
X-CSE-ConnectionGUID: HIO7Tcg6RH2DdbR3aPI6Yw==
X-CSE-MsgGUID: O0zczTk3RL+z00iL2akPSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981735"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75981735"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:40:32 -0700
X-CSE-ConnectionGUID: r8rkyP3US8i0+qhHWtPFkQ==
X-CSE-MsgGUID: rt+e5uHsTriKacNi9nmdlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="223904907"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:30 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net 0/10] ice: bug fixes -- no link, tc-flower, VF rate
Date: Fri,  3 Apr 2026 07:40:18 +0200
Message-ID: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274882-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 63E483911F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Good day,

Ten stand-alone bug fixes for the ice driver, all targeting functional
regressions or silent failures that affect connectivity.

Service task / unload races:
  - A scheduled service-task work item could fire after ice_remove()
    started, racing against freed per-PF state.  Check ICE_SHUTTING_DOWN
    at the top of the task body to close the window.

  - The DPLL input-pin callback accepted DPLL_PIN_STATE_CONNECTED and
    silently converted it to DISCONNECTED instead of returning an error.

Mirror / switch:
  - Mirror rules whose action is "to VSI list" had VSI count never set
    to 1, breaking subsequent deletions when a VSI list was involved.

DCB / LLDP:
  - Two missing `need_reconfig = true` assignments caused FW updates to
    be silently skipped when a DCB change only touched the TC bandwidth
    or TSA tables.

  - ice_set_dflt_mib() sent the initial default MIB to firmware with
    the ETS willing bit clear, preventing LLDP negotiation with a peer
    when the FW LLDP agent is active.

ethtool / link modes:
  - 10000baseCR_Full was absent from ice_adv_lnk_speed_10000[], causing
    an ethtool autoneg advertisement of this mode to be silently ignored
    (user gets "nothing changed" even on capable hardware).

  - ice_set_link_ksettings() derived the Autoneg-capable flag only from
    ice_phy_type_to_ethtool(); PHYs that report autoneg solely through
    PHY capabilities were missed.  Pull the flag from
    ice_is_phy_caps_an_enabled() to fix this.
    Fixes: 5cd349c349d6 ("ice: report supported and advertised autoneg using PHY capabilities")

  - 50G single-lane modes (50000baseCR/KR/SR/LR_ER_FR_Full) were absent
    from ice_adv_lnk_speed_50000[], so those link modes were silently
    rejected by ethtool.
    Fixes: 982b0192db45 ("ice: Refactor finding advertised link speed")

TC flower / switch:
  - ice_find_dummy_packet() chose the UDP inner template for rules that
    match ICE_IPV4_IL with ip_proto==TCP but no explicit L4 field,
    causing tc-flower rule installs to fail.
    Fixes: e33163a40d1a ("ice: switch: convert packet template match code to rodata")

SR-IOV / VF:
  - ice_set_vf_bw() refused any min_tx_rate value when total guaranteed
    bandwidth was already oversubscribed, making it impossible to clear
    the rate via "ip link set <pf> vf <id> min_tx_rate 0".  Allow a
    zero to bypass the oversubscription check so users can recover.

With the best regards,
Alex

---
Michal Swiatkowski (2):
  ice: fix mirroring to VSI list
  ice: select inner TCP dummy packet when matching on ip_proto TCP without explicit L4 field

Dave Ertman (2):
  ice: update FW on all DCB changes
  ice: disallow service task to run while driver is unloading

Arkadiusz Kubalewski (1):
  ice: error out on CONNECTED state for input pin

Voon Weifeng (1):
  ice: add 10000baseCR_Full to advertised link speed map

Jan Glaza (1):
  ice: check PHY autoneg capability before rejecting ethtool autoneg setting

Grzegorz Nitka (1):
  ice: fix missing 50G single-lane ethtool link speed mappings

Yochai Hagvi (1):
  ice: set ETS TLV willing bit in default MIB sent to firmware

Sudheer Mogilappagari (1):
  ice: allow setting min_tx_rate to 0 to resolve VF bandwidth oversubscription

 drivers/net/ethernet/intel/ice/ice_dcb.h     |  2 +
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  6 ++-
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c  |  0
 drivers/net/ethernet/intel/ice/ice_dpll.c    |  2 ++
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 29 +++++++++--
 drivers/net/ethernet/intel/ice/ice_main.c    |  2 +
 drivers/net/ethernet/intel/ice/ice_sriov.c   |  8 +++
 drivers/net/ethernet/intel/ice/ice_switch.c  |  8 ++-
 8 files changed, 52 insertions(+), 5 deletions(-)

