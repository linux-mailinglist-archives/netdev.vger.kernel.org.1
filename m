Return-Path: <netdev+bounces-130390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DCD98A584
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51ECE1F24258
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4523191F98;
	Mon, 30 Sep 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdfGe312"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D23191F75;
	Mon, 30 Sep 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703562; cv=none; b=tnuFimdB5qR3+0KgY/NmT5QOPFz0ScMpiPvDWzGyjkZ0Hd5vyws84f8DvpayXL/TG1HsnOL7Oxin3BPuiFMj4UhYuTCSuJ7RDzVy48AwbsH3x4jYxK0c+/Ab+xlLMLKjO0l429XHg1U7/Tq+nmDyN6SVJfIxArU2LjjRaBkTE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703562; c=relaxed/simple;
	bh=tSJvoTI7JMRNcMo45/NrSaup+zM/c96r4nWBeuj/344=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzCHHRiumqaRwAJ8iww96hs+f8wOMArrvKnJIUu58YLVbrq4DPqGg9kKhJm2lSPhEoQdR97bzWnD87fmUemqpZPwtwDGf93zxg5vCtwZjD1KjYyL6ZqzKws5gR11LPVMkK3fqiuoeB+f4XkKsm+j+vHJh9DJedFJZlH7RK+e2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdfGe312; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727703561; x=1759239561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tSJvoTI7JMRNcMo45/NrSaup+zM/c96r4nWBeuj/344=;
  b=JdfGe312mE1yLFxTIToNeBCy9Cu7q2OA5Q4vBH8hg18aAB7AtKlfxk9N
   B2kVXx16Zb5hlaT5MF8J1V0xfgr2DISr2EPcqMLyGNppdnyIHvJ29XEJU
   m8xroPzfi3kGbq74rr1nsMipX9RBxzdxK7QMGFeI0rg/qXOpIDqzRRZMG
   qFDN2khy0DUjGQzUt/86B2igves4jGI0od6YYu9wL6X4J97FC4BfukXf0
   669HLHvwiZoLgqBQIL5m/wT5dRRg0DgTlf/yi2K6g4Sxc+blI86xmMKnk
   mkay47pLFK5irqKexme/QnSRSXCoQdvgtwo1OkGmScmK1RnL6JTa9XiEe
   g==;
X-CSE-ConnectionGUID: uTuiv0ghSlWtDqbRtY4vyg==
X-CSE-MsgGUID: I4IX6wrBQ/iPfjqCCr81EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26601014"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26601014"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:39:21 -0700
X-CSE-ConnectionGUID: 5FZUgn7FTUWkL4vds5jRvQ==
X-CSE-MsgGUID: sYqFLxUITYqGjMNs4fSTyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="104109628"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 30 Sep 2024 06:39:18 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 974B128195;
	Mon, 30 Sep 2024 14:39:16 +0100 (IST)
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
Subject: [PATCH 4/7] ice: rename devlink_port.[ch] to port.[ch]
Date: Mon, 30 Sep 2024 15:37:21 +0200
Message-Id: <20240930133724.610512-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240930133724.610512-1-przemyslaw.kitszel@intel.com>
References: <20240930133724.610512-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop "devlink_" prefix from files that sit in devlink/.
I'm going to add more files there, and repeating "devlink" does not feel
good. This is also the scheme used in most other places, most notably the
devlink core files are named like that.

devlink.[ch] stays as is.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile                         | 2 +-
 .../net/ethernet/intel/ice/devlink/{devlink_port.h => port.h}   | 0
 drivers/net/ethernet/intel/ice/ice_eswitch.h                    | 2 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c                | 2 +-
 .../net/ethernet/intel/ice/devlink/{devlink_port.c => port.c}   | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c                       | 2 +-
 drivers/net/ethernet/intel/ice/ice_repr.c                       | 2 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c                     | 2 +-
 8 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.h => port.h} (100%)
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.c => port.c} (99%)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 3307d551f431..56aa23aee472 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -32,7 +32,7 @@ ice-y := ice_main.o	\
 	 ice_parser_rt.o \
 	 ice_idc.o	\
 	 devlink/devlink.o	\
-	 devlink/devlink_port.o \
+	 devlink/port.o \
 	 ice_sf_eth.o	\
 	 ice_sf_vsi_vlan_ops.o \
 	 ice_ddp.o	\
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/port.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/devlink/devlink_port.h
rename to drivers/net/ethernet/intel/ice/devlink/port.h
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index ac7db100e2cd..5c7dcf21b222 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -5,7 +5,7 @@
 #define _ICE_ESWITCH_H_
 
 #include <net/devlink.h>
-#include "devlink/devlink_port.h"
+#include "devlink/port.h"
 
 #ifdef CONFIG_ICE_SWITCHDEV
 void ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf);
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 415445cefdb2..1b10682c00b8 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -6,7 +6,7 @@
 #include "ice.h"
 #include "ice_lib.h"
 #include "devlink.h"
-#include "devlink_port.h"
+#include "port.h"
 #include "ice_eswitch.h"
 #include "ice_fw_update.h"
 #include "ice_dcb_lib.h"
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
similarity index 99%
rename from drivers/net/ethernet/intel/ice/devlink/devlink_port.c
rename to drivers/net/ethernet/intel/ice/devlink/port.c
index 928c8bdb6649..b7308f508774 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/port.c
@@ -5,7 +5,7 @@
 
 #include "ice.h"
 #include "devlink.h"
-#include "devlink_port.h"
+#include "port.h"
 #include "ice_lib.h"
 #include "ice_fltr.h"
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2fafb56728b2..8fc5be85c2ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -14,7 +14,7 @@
 #include "ice_dcb_lib.h"
 #include "ice_dcb_nl.h"
 #include "devlink/devlink.h"
-#include "devlink/devlink_port.h"
+#include "devlink/port.h"
 #include "ice_sf_eth.h"
 #include "ice_hwmon.h"
 /* Including ice_trace.h with CREATE_TRACE_POINTS defined will generate the
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 970a99a52bf1..fb7a1b9a4313 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -4,7 +4,7 @@
 #include "ice.h"
 #include "ice_eswitch.h"
 #include "devlink/devlink.h"
-#include "devlink/devlink_port.h"
+#include "devlink/port.h"
 #include "ice_sriov.h"
 #include "ice_tc_lib.h"
 #include "ice_dcb_lib.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 75d7147e1c01..1a2c94375ca7 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -5,8 +5,8 @@
 #include "ice_txrx.h"
 #include "ice_fltr.h"
 #include "ice_sf_eth.h"
-#include "devlink/devlink_port.h"
 #include "devlink/devlink.h"
+#include "devlink/port.h"
 
 static const struct net_device_ops ice_sf_netdev_ops = {
 	.ndo_open = ice_open,
-- 
2.39.3


