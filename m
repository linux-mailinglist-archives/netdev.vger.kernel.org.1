Return-Path: <netdev+bounces-163674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E0BA2B51A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11C1167C11
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A90225A49;
	Thu,  6 Feb 2025 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGt4n6LT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3206522FF44
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738881079; cv=none; b=JelOZJTgU6z5BIXc/l19a/LQ33U5waJDjFYBAbk9i8pkU5DqEXXqumTi/gurKTn3H5O90b964RyO0lcxHMfXjNUiNR6cTvNhgRKx8S/s9ORDzQdp+G+uc/HA5GbGD6l90UW3opaoycbYme/jVu6QZBYEDoQFgJkKDRqnw6iDTOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738881079; c=relaxed/simple;
	bh=j5ZtwIwU7O/j1tNyCDeA8aSk+vuKi3hBGS+SQSjbZ50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBFVHuoESe9Q/wygwIGR4bgLj5UOfT9qh4DpBWRY2Nv+mvB00c3SzA7PM7qDnVqbQYcteq4VCJLHNhWfYzx+G+5JEABDW4AHBWmuvmoGPkVgA9HwSDr3sFUrlOA/HJfIiSwDmqbG13XIAKzSSvIGTLrFy+2zvjkbmArkeP2pw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGt4n6LT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738881077; x=1770417077;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j5ZtwIwU7O/j1tNyCDeA8aSk+vuKi3hBGS+SQSjbZ50=;
  b=lGt4n6LTbNwE+RwbkGaUeuFZZ8kyfR7vKUjBnJWCC2ombUt2KvSu9h3A
   1w5OFLE8Xzp8J2RTkPFezNAgCMBj/RNd0sgfM7BM/mH/Bifargoc3H7wn
   vCyW58jl+PE4sQLjnxLzGEH36s60Tkv9IUoYkcQKLJNUneJBd1bukvRsZ
   S57NQADlOqLkWVxkDMZjVhJzIJqcPV2Ym7TKNRpIdnrgCdD/0mbZUbb0T
   LYCQIaICfnNimbUeGEFGCiUB3BVUucLkKpo87Ze24OmPzGnMEWM59ttbW
   S6M5LiXntpuNob9CaYdrfvpbs255jltjrW4lPM4gGjxuUC4S7iSgl+T3a
   g==;
X-CSE-ConnectionGUID: Thy4jUuCSaOhsanniORGTA==
X-CSE-MsgGUID: NXHewU+HSJWShQZ24fLCGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43171994"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="43171994"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 14:31:17 -0800
X-CSE-ConnectionGUID: yIGMdLlGTSuLLfHFPfW1cA==
X-CSE-MsgGUID: 6JK31nweSsqve/vgMqcdVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="142225830"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 06 Feb 2025 14:31:13 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.89])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7179F32ECF;
	Thu,  6 Feb 2025 22:31:11 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH iwl-net v2] ice: health.c: fix compilation on gcc 7.5
Date: Thu,  6 Feb 2025 23:30:23 +0100
Message-ID: <20250206223101.6469-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC 7 is not as good as GCC 8+ in telling what is a compile-time
const, and thus could be used for static storage.
Fortunately keeping strings as const arrays is enough to make old
gcc happy.

Excerpt from the report:
My GCC is: gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0.

  CC [M]  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o
drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer element is not constant
   ice_common_port_solutions, {ice_port_number_label}},
   ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ice/devlink/health.c:35:3: note: (near initialization for 'ice_health_status_lookup[0].solution')
drivers/net/ethernet/intel/ice/devlink/health.c:35:31: error: initializer element is not constant
   ice_common_port_solutions, {ice_port_number_label}},
                               ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ice/devlink/health.c:35:31: note: (near initialization for 'ice_health_status_lookup[0].data_label[0]')
drivers/net/ethernet/intel/ice/devlink/health.c:37:46: error: initializer element is not constant
   "Change or replace the module or cable.", {ice_port_number_label}},
                                              ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ice/devlink/health.c:37:46: note: (near initialization for 'ice_health_status_lookup[1].data_label[0]')
drivers/net/ethernet/intel/ice/devlink/health.c:39:3: error: initializer element is not constant
   ice_common_port_solutions, {ice_port_number_label}},
   ^~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 85d6164ec56d ("ice: add fw and port health reporters")
Reported-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Closes: https://lore.kernel.org/netdev/CY8PR11MB7134BF7A46D71E50D25FA7A989F72@CY8PR11MB7134.namprd11.prod.outlook.com
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2: use static const char[] instead of #define - Simon
    +added RB tag from Michal, but not adding TB tag from Qiuxu

v1:
 https://lore.kernel.org/netdev/20250205104252.30464-2-przemyslaw.kitszel@intel.com

CC: Kees Cook <kees@kernel.org>
CC: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/net/ethernet/intel/ice/devlink/health.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index ea40f7941259..19c3d37aa768 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -25,10 +25,10 @@ struct ice_health_status {
  * The below lookup requires to be sorted by code.
  */
 
-static const char *const ice_common_port_solutions =
+static const char ice_common_port_solutions[] =
 	"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex.";
-static const char *const ice_port_number_label = "Port Number";
-static const char *const ice_update_nvm_solution = "Update to the latest NVM image.";
+static const char ice_port_number_label[] = "Port Number";
+static const char ice_update_nvm_solution[] = "Update to the latest NVM image.";
 
 static const struct ice_health_status ice_health_status_lookup[] = {
 	{ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_STRICT, "An unsupported module was detected.",

base-commit: 4241a702e0d0c2ca9364cfac08dbf134264962de
-- 
2.46.0


