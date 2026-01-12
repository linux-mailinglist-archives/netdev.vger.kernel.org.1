Return-Path: <netdev+bounces-249044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB4D1317F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC1C43018F58
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5C6252292;
	Mon, 12 Jan 2026 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6FNS0i9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544831E22E9
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227519; cv=none; b=Rcw9aNygO/OwalPnwgwCbIu089zf0jo93fhmGqZVMtkqO46cysBAeUo+WJT2A1B3P0p2o8dXejovQtn9L7mSBUVrWzNqdCZWzwDMapo23GqtyXibluxDIEdGNcWbFYCCpyRkoFsby094quM7XZ8U6QHiWWTtsXrmsfqValdNa2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227519; c=relaxed/simple;
	bh=vPeDa8uyWuQnIXSJZ4FwePDJ5JKSHDvAEnccORld0bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Id6sK8O0ieF5FfdO6cNrpWUFRYKodVrjngJV+6qm88gouwxx50OhJsKK1gw9glRaLVHtvKeg9+MgUaeaGJEvOhqtbLhyfoMtWh16bUmD6M1wxFx1GHMchBIcdfS90R8cTirkHzFqMxyiBlzvZwdUU5BrcOOBHR2c+9szwH82XfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6FNS0i9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768227517; x=1799763517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vPeDa8uyWuQnIXSJZ4FwePDJ5JKSHDvAEnccORld0bc=;
  b=Z6FNS0i9B2L3MUNcb3sn4S2UYKUr8MpuGFh1Vo/+9bxYWmVob01WItFT
   In+QR+9oaJfN8TI74p25Db1jlAajK3WECaW8PPZs46DCBrZHQHkth5gPT
   roUpyxheJaCrOLSgXzJaXtYyIhGwd9yqhDRYrGZxe1EYMO/tQTlUDUIPL
   zJF3rKBJz1FqhLhkUnSx9/hlAOsdK34nhIaXYRCKANjEHZcP9UbCIMEYC
   I2y0WwppIIDK3hmG2b2jcaQnIIclrjwBOy3RB79NibXyxvkbKDAVG5XwG
   ZsXEAuO47bwLNMo6b2O0QWT8RaIsFBaqpibKYEEp87PeUF8hnKY9PIGY+
   A==;
X-CSE-ConnectionGUID: mtNB8PHVT1qcsd+6l5XpzA==
X-CSE-MsgGUID: ny+egBSUSMOx6UbIS8HvdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73352277"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="73352277"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 06:18:37 -0800
X-CSE-ConnectionGUID: rVOT95v5QEeVCqlu981b5Q==
X-CSE-MsgGUID: cMpwmWyVTiOvqeTm28QMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="227355621"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jan 2026 06:18:36 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v1 0/7] ixgbe: enable EEE for E610 devices
Date: Mon, 12 Jan 2026 15:01:01 +0100
Message-Id: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align SW structs with latest FW changes related to EEE enablement.
Address compatibility issues caused by the buffer size changes.
Implement ethtool callbacks which can be used to enable/disable EEE, but
generally the feature itself is enabled by default. What's important it
works only for link speeds > 1Gb/s, so even if enabled, it gets down
anytime link conditions aren't met. Once met again the feature gets
restored. Still cannot configure LPI timers and EEE advertised speeds.

Jedrzej Jagielski (7):
  ixgbe: E610: add discovering EEE capability
  ixgbe: E610: use new version of 0x601 ACI command buffer
  ixgbe: E610: update EEE supported speeds
  ixgbe: E610: update ACI command structs with EEE fields
  ixgbe: move EEE config validation out of ixgbe_set_eee()
  ixgbe: replace EEE enable flag with state enum
  ixgbe: E610: add EEE support

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  13 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  77 +++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 250 +++++++++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  42 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   1 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  38 ++-
 include/linux/net/intel/libie/adminq.h        |   1 +
 8 files changed, 358 insertions(+), 65 deletions(-)


base-commit: 8fccf912252d8d61064058caf4d6e1085c5ac309
-- 
2.31.1


