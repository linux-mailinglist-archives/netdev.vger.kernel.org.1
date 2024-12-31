Return-Path: <netdev+bounces-154625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD19FEE9C
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 10:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CC47A0FD5
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4DE18A95A;
	Tue, 31 Dec 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLJEw9E1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8CEDE
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735638736; cv=none; b=NYDWhvO747uNLgS4lXgo8lhJhHApR5KYskCQcIMbT0lq7s6QKv3A56N/rYvfyhwFtwRsYAlufk4vttf0+cZ1/cSQMSO749Q02ggdGhc98U6zTJrHX5twSPvbhF3Yoo53I6CjEmNILucSHhkDO1fg9XXy5unswuQgqkmaaBrccWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735638736; c=relaxed/simple;
	bh=trPPlrmkaokGszHUJ2Zza6/CiedOSJPQxAu/cKcQe6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UnC6Fq+aZs3Ni7NjAdtEomlyJEfvJxX+OpXxeD/zlIAe4M4P9hBUgsNU1HOdNvjwuWh4+LE28CyYUI45qChhLDCExi2kPFO6+eGB5WLJle3k11r9O9YJrHp2LLFN3J2JHSQqNTtnQedLleN3Gg6GdQReJkNKqRWg7xTBuvFtlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLJEw9E1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735638734; x=1767174734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=trPPlrmkaokGszHUJ2Zza6/CiedOSJPQxAu/cKcQe6w=;
  b=QLJEw9E1QHEOKnRTDY3d2tLFblUF4UW5g6auaCXTSJjAdN59QkLQ6EYo
   I/H/SDyQeYLfNZhHMEmZE4B4Euig0ne+brhGK75ugFwgGHJz9kflejVrR
   HuMOVVNZNMhzZIwSRdvK1dE6QSUUFuCm5TzFeyGvf2LU47GOmCHIkut0m
   bDOn82NAXJa5pyvXtsTPMkQX/6WqHoWwY1b+PYFuQXBxyDe49MCo87b6Y
   KwkeyztKYsu4HlUwbvS9pILZKmCR03ZWFCK7kFSO4eLzprg/jIoo4U4ux
   npc+pXcaXl8nJxnnIHy7lauMGKB48ecocpoN1KwClJmXls649T5Sq6seg
   g==;
X-CSE-ConnectionGUID: 3ToIKgvVRoavGUlPgBh51A==
X-CSE-MsgGUID: PA8/yHuLQMCVPa1GRQQu5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11301"; a="35821811"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="35821811"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 01:52:14 -0800
X-CSE-ConnectionGUID: EZN/LjbjQfuJBGpga3mkeA==
X-CSE-MsgGUID: 0zD24EPZTXmrfT9M6jMNIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="101515664"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 31 Dec 2024 01:52:13 -0800
Received: from metan.igk.intel.com (metan.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D9D672876E;
	Tue, 31 Dec 2024 09:52:11 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: remove invalid parameter of equalizer
Date: Tue, 31 Dec 2024 10:50:44 +0100
Message-Id: <20241231095044.433940-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It occurred that in the commit 70838938e89c ("ice: Implement driver
functionality to dump serdes equalizer values") the invalid DRATE parameter
for reading has been added. The output of the command:

  $ ethtool -d <ethX>

returns the garbage value in the place where DRATE value should be
stored.

Remove mentioned parameter to prevent return of corrupted data to
userspace.

Fixes: 70838938e89c ("ice: Implement driver functionality to dump serdes equalizer values")
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c    | 1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.h    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 3bf05b135b35..73756dbfc77f 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1498,7 +1498,6 @@ struct ice_aqc_dnl_equa_param {
 #define ICE_AQC_RX_EQU_POST1 (0x12 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_BFLF (0x13 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_BFHF (0x14 << ICE_AQC_RX_EQU_SHIFT)
-#define ICE_AQC_RX_EQU_DRATE (0x15 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_CTLE_GAINHF (0x20 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_CTLE_GAINLF (0x21 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_CTLE_GAINDC (0x22 << ICE_AQC_RX_EQU_SHIFT)
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 3072634bf049..f241493a6ac8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -710,7 +710,6 @@ static int ice_get_tx_rx_equa(struct ice_hw *hw, u8 serdes_num,
 		{ ICE_AQC_RX_EQU_POST1, rx, &ptr->rx_equ_post1 },
 		{ ICE_AQC_RX_EQU_BFLF, rx, &ptr->rx_equ_bflf },
 		{ ICE_AQC_RX_EQU_BFHF, rx, &ptr->rx_equ_bfhf },
-		{ ICE_AQC_RX_EQU_DRATE, rx, &ptr->rx_equ_drate },
 		{ ICE_AQC_RX_EQU_CTLE_GAINHF, rx, &ptr->rx_equ_ctle_gainhf },
 		{ ICE_AQC_RX_EQU_CTLE_GAINLF, rx, &ptr->rx_equ_ctle_gainlf },
 		{ ICE_AQC_RX_EQU_CTLE_GAINDC, rx, &ptr->rx_equ_ctle_gaindc },
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
index 8f2ad1c172c0..23b2cfbc9684 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
@@ -15,7 +15,6 @@ struct ice_serdes_equalization_to_ethtool {
 	int rx_equ_post1;
 	int rx_equ_bflf;
 	int rx_equ_bfhf;
-	int rx_equ_drate;
 	int rx_equ_ctle_gainhf;
 	int rx_equ_ctle_gainlf;
 	int rx_equ_ctle_gaindc;
-- 
2.38.1


