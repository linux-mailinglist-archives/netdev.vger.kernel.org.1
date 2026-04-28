Return-Path: <netdev+bounces-281631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFJ9DU1E8GmDQwEAu9opvQ
	(envelope-from <netdev+bounces-281631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:23:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D51BC47D875
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E892A3027689
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEDA30C63B;
	Tue, 28 Apr 2026 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j04yeEYn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E42DF6F4
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353799; cv=none; b=NIoob4wGEIh+46w3w7rwr5RZLPtxfR7ZZkc3v1KM5wIcUBaW1v1w6jflHxPnTk5glpvqIgsHdXqYHvOJu8AyVxJaIPtBPULyl2Eij5BCrz0tEDIDkYqB+vdQVxjpn1eBxXa7HiriTg69MJSMo5ojXY6799SyVGZLDRDCVqCpbNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353799; c=relaxed/simple;
	bh=StRjMfHN7tbp0NeymR8K0WicMNs/0ucToWoMm54RtTI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cOJRVEootuk+huvz5lcTpFlVGAx1fWm49AKDVWf8ljtWNPkCaPB8NuvlNRxYKzvoXap/yHY1yMRsqcn5C8WuFqO0vaf0qK2xah/5oi8v8Mz62VHYysn658Ash9zCfDZrmKl5OrRLaSllGO3DGLD5jnoBW4zothVC7cjTxmiyp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j04yeEYn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353798; x=1808889798;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=StRjMfHN7tbp0NeymR8K0WicMNs/0ucToWoMm54RtTI=;
  b=j04yeEYnQXpGpqcKQxn6WVqexKomwBqOJZTeMvfRETYTA65YEaQZbteo
   l+QtgyZTPRuqVogQcbu0jlQeIa/T7/MRgVEUcUWtZAfUjwGjgd4qRHtRU
   j/OymSLXkCBW3IZYTfrdJVNq6STWezpg2l5WmnaEiiMTpBfCc32yeUS9i
   inArlO3WnYPgi5LER8CUoFle7nJuOc3O1iglapBDQA/JEUmtb1SfkKlc6
   7Dpg2fEbBtQlzZBBkX6WDXKNY0SaOMXz+hbZdEZU9Z7W0awD33O4FhAJs
   RkPvZycNSJbRDuYwUQcDBIR2+Jewrb6Ppqn5L8vV+gEayayBfOEysHdUM
   g==;
X-CSE-ConnectionGUID: t9sQCeNGSrWyZK2J6TcnCw==
X-CSE-MsgGUID: kubTEV+FTNiGANNKH+FBdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100910501"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="100910501"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:15 -0700
X-CSE-ConnectionGUID: HAg1XeZwTVaTvMvPyDfbfQ==
X-CSE-MsgGUID: 6sCg3vUJS52bPwFuW7mXMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237800191"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 00/11] Intel Wired LAN Update 2026-04-27 (ice, iavf)
Date: Mon, 27 Apr 2026 22:22:12 -0700
Message-Id: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM2wrCQAxEf6Xk2UCNZb38ivTBrqmmym5JVlso/
 XejvgycGc4sYKzCBqdqAeW3mOTksN1UEO+XdGOUqzNQTaFuaI/DA2V6YuKCIxfFrNmwl5k9+4Y
 CHXehO0Twg1H5N7h/Bheg/Zf26gaO5XsL6/oBppHZoIMAAAA=
X-Change-ID: 20260427-jk-iwl-net-petr-oros-fixes-ff4262936b8c
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Petr Oros <poros@redhat.com>, Rafal Romanowski <rafal.romanowski@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Ivan Vecera <ivecera@redhat.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3114;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=StRjMfHN7tbp0NeymR8K0WicMNs/0ucToWoMm54RtTI=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswPLjZtHd1yf76cenbeiH+W7jxvvd/JSX8SGV56r/tz2
 P1BhadqRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABMpt2JkOL5x+568y9Nv7eup
 c4n6EeaVUWI79e48nssW1+Yo7sjtO8bIcHbZIrUzn7z6GxaZiTi7PE9a4xRwTmRbCGup8KwLbVO
 7mAE=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: D51BC47D875
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281631-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

Petr Oros from RedHat has accumulated a number of fixes for the Intel ice
and iavf drivers, bundled together in this series.

First, a series of 4 fixes to resolve issues with the iavf driver logic for
handling VLAN filters. This includes keeping VLAN filters while the
interface is brought down, waiting for confirmation on filter deletion
before deleting filters from the driver tracking structures, and handling
the VIRTCHNL_OP_ADD_VLAN for the old v1 VLAN_ADD command.

A fix for a crash in ice_reset_all_vfs(), properly checking for errors when
ice_vf_rebuild_vsi() fails.

A fix for a possible infinite recursion in ice_cfg_tx_topo() that occurs
when trying to apply invalid Tx topology configuration.

A fix to initialize the SMA pins in the DPLL subsystem properly.

A fix to change the SMA and U.FL pin state for paired pins, ensuring that
all flows changing one pin will also update its shared pin appropriately.

A preparatory patch to export __dpll_pin_change_ntf() so that drivers can
notify pin changes while already holding the dpll_lock.

A fix to ensure DPLL notifications are sent for the software-controlled
pins which wrap the physical CGU input/output pins.

A fix to add DPLL notifications for peer pins when changing the SMA or U.FL
pins, ensuring DPLL subsystem is notified about the paired connected pins.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Ivan Vecera (1):
      dpll: export __dpll_pin_change_ntf() for use under dpll_lock

Petr Oros (10):
      iavf: rename IAVF_VLAN_IS_NEW to IAVF_VLAN_ADDING
      iavf: stop removing VLAN filters from PF on interface down
      iavf: wait for PF confirmation before removing VLAN filters
      iavf: add VIRTCHNL_OP_ADD_VLAN to success completion handler
      ice: fix NULL pointer dereference in ice_reset_all_vfs()
      ice: fix infinite recursion in ice_cfg_tx_topo via ice_init_dev_hw
      ice: fix missing SMA pin initialization in DPLL subsystem
      ice: fix SMA and U.FL pin state changes affecting paired pin
      ice: fix missing dpll notifications for SW pins
      ice: add dpll peer notification for paired SMA and U.FL pins

 drivers/dpll/dpll_netlink.h                      |   2 -
 drivers/net/ethernet/intel/iavf/iavf.h           |   9 +-
 include/linux/dpll.h                             |   1 +
 drivers/dpll/dpll_netlink.c                      |  10 ++
 drivers/net/ethernet/intel/iavf/iavf_main.c      |  52 ++------
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c  |  76 ++++++------
 drivers/net/ethernet/intel/ice/devlink/devlink.c |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c      |   2 -
 drivers/net/ethernet/intel/ice/ice_dpll.c        | 146 +++++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_main.c        |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c      |   7 +-
 11 files changed, 207 insertions(+), 102 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260427-jk-iwl-net-petr-oros-fixes-ff4262936b8c

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


