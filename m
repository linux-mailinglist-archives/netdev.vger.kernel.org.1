Return-Path: <netdev+bounces-190939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CCEAB95DB
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC98EA00587
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 06:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A0A21A95D;
	Fri, 16 May 2025 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrQ1k23L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CAE7D3F4
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747376128; cv=none; b=J2c+FgzvxG08CuMIyShOjJsuKwfvhSCkfM9GcBB1BIswS9kCcuI/kLx97tgpEX3uzZ8A3+EsGgPdieVfsuR//Bz3gY8ZCXY6toGxq3CnlMYiXaPzw5OpSipmGax6kstNIE+WVXOzH27HhFox5pyp76hLymB16s/ua5WzIWMwZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747376128; c=relaxed/simple;
	bh=8wwxeNfWPO7GulIi5/FvxZdUdXregi6tA5iZnPSN8hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ex1mXNuC/AMoOGob4+oFvVlSaPhB1BmvF5NYvcDxVJDPQeb7K8vOXqO/h70QwMYYi0niMQVOzOu8dxSUIrZ5ZQdxTv8K7mDUeplt4suGID7QK5DyQxxQljq9GxGyY1IDCgIP5oXl2NvBVYIL6TfGr5NrljG0s5+iHCMatoyI/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrQ1k23L; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747376127; x=1778912127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8wwxeNfWPO7GulIi5/FvxZdUdXregi6tA5iZnPSN8hY=;
  b=YrQ1k23LnuqBbpnALOwI71aoHkHBMjD4tZZ7W1yXwG0/4i84pmmSHAAo
   RGuy/WHuJEcxaXVNEzFKx+nvc0mlzXwz4zZDi0dBRRL+BKWoLR+hylcFm
   9Frp2V5unONEfqMsWnO7T1sEl8umT69sZN9uzTXnro2byzwjpBgrU3wOY
   PcPLffTRgB2W+3WthA7AvGHVCy1Ywc4OAm6DcBp/2RgLCkKljPecpOtEH
   4hUhtZOmbWffbpTsjz3fjkV5SZiTyLjwK3OJ3kTRRa2ilgABCOCWJe4Cm
   XSBZiMsDJTFtxhxhLArzAWtXNfhsU6Lp07rAjSL1pjl+v94UK0lJ+Y5Ep
   w==;
X-CSE-ConnectionGUID: hqZ37dIySzqb8AnvgsT46g==
X-CSE-MsgGUID: YiVv4pACSLWsnJbaq6OjYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59566838"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="59566838"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 23:15:26 -0700
X-CSE-ConnectionGUID: TfBu6B85QBahlJaMTvr0lA==
X-CSE-MsgGUID: /aKu2dEmSRa2TCm7/bwVFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138643161"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 15 May 2025 23:15:25 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v2] ice: add 40G speed to Admin Command GET PORT OPTION
Date: Fri, 16 May 2025 06:15:23 +0000
Message-ID: <20250516061523.369248-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the ICE_AQC_PORT_OPT_MAX_LANE_40G constant and update the code
to process this new option in both the devlink and the Admin Queue Command
GET PORT OPTION (opcode 0x06EA) message, similar to existing constants like
ICE_AQC_PORT_OPT_MAX_LANE_50G, ICE_AQC_PORT_OPT_MAX_LANE_100G, and so on.

This feature allows the driver to correctly report configuration options
for 2x40G on ICX-D LCC and other cards in the future via devlink.

Example command:
 devlink port split pci/0000:01:00.0/0 count 2

Example dmesg:
 ice 0000:01:00.0: Available port split options and max port speeds (Gbps):
 ice 0000:01:00.0: Status  Split      Quad 0          Quad 1
 ice 0000:01:00.0:         count  L0  L1  L2  L3  L4  L5  L6  L7
 ice 0000:01:00.0:         2      40   -   -   -  40   -   -   -
 ice 0000:01:00.0:         2      50   -  50   -   -   -   -   -
 ice 0000:01:00.0:         4      25  25  25  25   -   -   -   -
 ice 0000:01:00.0:         4      25  25   -   -  25  25   -   -
 ice 0000:01:00.0: Active  8      10  10  10  10  10  10  10  10
 ice 0000:01:00.0:         1     100   -   -   -   -   -   -   -

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v1->v2 - fix typo in commit message
---
 drivers/net/ethernet/intel/ice/devlink/port.c   | 2 ++
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1 +
 drivers/net/ethernet/intel/ice/ice_common.c     | 2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c    | 3 ++-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
index 767419a..63fb36f 100644
--- a/drivers/net/ethernet/intel/ice/devlink/port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/port.c
@@ -30,6 +30,8 @@ static const char *ice_devlink_port_opt_speed_str(u8 speed)
 		return "10";
 	case ICE_AQC_PORT_OPT_MAX_LANE_25G:
 		return "25";
+	case ICE_AQC_PORT_OPT_MAX_LANE_40G:
+		return "40";
 	case ICE_AQC_PORT_OPT_MAX_LANE_50G:
 		return "50";
 	case ICE_AQC_PORT_OPT_MAX_LANE_100G:
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index bdee499..2ff141a 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1672,6 +1672,7 @@ struct ice_aqc_get_port_options_elem {
 #define ICE_AQC_PORT_OPT_MAX_LANE_50G	6
 #define ICE_AQC_PORT_OPT_MAX_LANE_100G	7
 #define ICE_AQC_PORT_OPT_MAX_LANE_200G	8
+#define ICE_AQC_PORT_OPT_MAX_LANE_40G	9
 
 	u8 global_scid[2];
 	u8 phy_scid[2];
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 4fedf01..2519ad6 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4080,7 +4080,7 @@ int ice_get_phy_lane_number(struct ice_hw *hw)
 
 		speed = options[active_idx].max_lane_speed;
 		/* If we don't get speed for this lane, it's unoccupied */
-		if (speed > ICE_AQC_PORT_OPT_MAX_LANE_200G)
+		if (speed > ICE_AQC_PORT_OPT_MAX_LANE_40G)
 			continue;
 
 		if (hw->pf_id == lport) {
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 6488151..f2c0b28 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -667,7 +667,8 @@ static int ice_get_port_topology(struct ice_hw *hw, u8 lport,
 
 		if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_100G)
 			port_topology->serdes_lane_count = 4;
-		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G)
+		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G ||
+					 max_speed == ICE_AQC_PORT_OPT_MAX_LANE_40G)
 			port_topology->serdes_lane_count = 2;
 		else
 			port_topology->serdes_lane_count = 1;
-- 
2.49.0


