Return-Path: <netdev+bounces-130386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97FC98A576
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5212A1C2097D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F89318FC79;
	Mon, 30 Sep 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZED7bdn5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2F118F2FD;
	Mon, 30 Sep 2024 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703545; cv=none; b=GIKPrsugeyE1jVk9tNAyQWoz8gvZADL6EY+IE2cs2geGwXSZw0574cu2tOZLUutRhrtOiRQPQOr83UXbNzZQ29nrYpEnU0JDe++GtDxn6uZL9UG2dpjMGlzbNBODZNGPHviSJJvKuILwLrK3h2YGf8dTbypZGu+pQKzDEkURGAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703545; c=relaxed/simple;
	bh=amz7lzdIctZaiT18tOT05jELSOgRlg/OpvFf3N9t3uM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L1be6M8l0ZrlDISoyUtZrfnclHYdn9xLuS59IoVQRZ7k3rnT97wxfDX5dWYCQjH7ye08QAKsyHsNDALcp53sN89ipfPPDMqxjHSdRsYHciJfnZfWum53oJRDwt/cGQLVabaSymJGkMvDgUWiLVWnaiYzJ47ivB2N2H5l4oPEMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZED7bdn5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727703543; x=1759239543;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=amz7lzdIctZaiT18tOT05jELSOgRlg/OpvFf3N9t3uM=;
  b=ZED7bdn5954IXWUTpmEI+JVd6btPajrZMpHR82FXh4AazO+T34XC9q44
   0GHkUFxe11NZhfP5PMpFm/+rxOINxyNvIiwalJ70Mt2SppXPUN+3n9WOM
   5tM5n/37pcb68qC2f2u26EP3sOfjZzz4cILLJbUPLdT2uQa16eMljzjgF
   PFyYKoKFOETPbKnJGftxEgvNF55Ior8B9DiURu2g0lN9gmeVwelSzFPRX
   Cy4uf9qCuRUG+gEQv+VnrE0YObUWDKvMqFebBdih93oDkL/3K4Dh3C4AT
   Yec9NFlq0OgOV7JJx526U4M/HREKhzgpKHwgNDVpiqGbQCpIyPe015I7F
   w==;
X-CSE-ConnectionGUID: NWV3QJC1RC+3v9NK1tMvsA==
X-CSE-MsgGUID: BHoXRoV5Tz+XiWwigejVbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44312393"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44312393"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:39:03 -0700
X-CSE-ConnectionGUID: 18py0tMcTP6VRr0dm1/nUA==
X-CSE-MsgGUID: xIfpSmwzRrqWXwIQ8gEyAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="77831808"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2024 06:38:59 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5E5D328169;
	Mon, 30 Sep 2024 14:38:58 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH 0/7] ice: add support for devlink health events
Date: Mon, 30 Sep 2024 15:37:17 +0200
Message-Id: <20240930133724.610512-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reports for two kinds of events are implemented, Malicious Driver
Detection (MDD) and Tx hang.

Patches 1, 2, 3: core improvements (checkpatch.pl, devlink extension)
Patch 4: rename current ice devlink/ files
Patches 5, 6, 7: ice devlink health infra + reporters

Mateusz did good job caring for this series, and hardening the code.
---
v4:
    - rebase, added patch 4 that renames curent devlink_port files

v3: - extracted devlink_fmsg_dump_skb(), and thus removed ugly copy-pasta
      present in v2 (Jakub);
    - tx hang reported is now called from service_task, to resolve calling
      it from atomic (watchog) context - patch 4
https://lore.kernel.org/netdev/20240821133714.61417-5-przemyslaw.kitszel@intel.com

v2: patch 3 (patch 4 in v3)
    - added additional cast to long in ice_tx_hang_reporter_dump()
    - removed size_mul() in devlink_fmsg_binary_pair_put() call
https://lore.kernel.org/netdev/20240712093251.18683-1-mateusz.polchlopek@intel.com

v1:
https://lore.kernel.org/netdev/20240703125922.5625-1-mateusz.polchlopek@intel.com
---

Ben Shelton (1):
  ice: Add MDD logging via devlink health

Mateusz Polchlopek (1):
  devlink: add devlink_fmsg_dump_skb() function

Przemek Kitszel (5):
  checkpatch: don't complain on _Generic() use
  devlink: add devlink_fmsg_put() macro
  ice: rename devlink_port.[ch] to port.[ch]
  ice: add Tx hang devlink health reporter
  ice: dump ethtool stats and skb by Tx hang devlink health reporter

 drivers/net/ethernet/intel/ice/Makefile       |   3 +-
 scripts/checkpatch.pl                         |   2 +
 .../net/ethernet/intel/ice/devlink/health.h   |  59 ++++
 .../ice/devlink/{devlink_port.h => port.h}    |   0
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |   2 +
 .../ethernet/intel/ice/ice_ethtool_common.h   |  19 ++
 include/net/devlink.h                         |  13 +
 .../net/ethernet/intel/ice/devlink/devlink.c  |   2 +-
 .../net/ethernet/intel/ice/devlink/health.c   | 302 ++++++++++++++++++
 .../ice/devlink/{devlink_port.c => port.c}    |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  26 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   |   2 +-
 net/devlink/health.c                          |  67 ++++
 17 files changed, 498 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.h
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.h => port.h} (100%)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool_common.h
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.c
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.c => port.c} (99%)

-- 
2.39.3


