Return-Path: <netdev+bounces-200459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9637AAE5888
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7FE1B65146
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BD2142E67;
	Tue, 24 Jun 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mk9Ihu/q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D1717C77
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725008; cv=none; b=njqh1XW3PgM9VmdKeqiLuoWiOfrj+Vbn32H3e858i39ae2PKiWh5u0GY0GCvKVaHZ/0vF/wLpAMe1elAfoKRdAe003mWxiPZx4POfbTG51ROS2XHQtBUaaXjMTR0EjNM0pTL71bn/X7oLdT9DV7xusu3NCkSD+Akw3DVqnsksa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725008; c=relaxed/simple;
	bh=M3dT3Lmb9P6DmC2Z6O4e6DegMD+JK3r2HsY4a9sPCkU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tZwppOq2EqAxCfgfWBWigrUlAFrq/RdhUOCrPxmhhd4kxaQK19fOBg4VjHa3olBUE/1xBjCXzfLwhIszWQt/mZ+M9qMP8DhxknjWxOgqZYeDYEjZQvWyoVLZUDBrU9ybLikG8j6xaB/7XABYIfURcMfAwMeY1Mf0mWMElZbPvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mk9Ihu/q; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750725007; x=1782261007;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=M3dT3Lmb9P6DmC2Z6O4e6DegMD+JK3r2HsY4a9sPCkU=;
  b=Mk9Ihu/qK2iyAkFIKW1wxmK4GyXWvrQVrq1E5NTiotvyiIWSbpD8kTgT
   JJ5xvXQQXUIlXyRrElOIdIrM6G9HiMVvy2uC5hQFW6ZUBQ+3m8eYYBSi/
   6eeqlffXp0bYdg4veulr6GXlWFesvNSdTzb/NUhUHiCcH3nhVvRVcDKZz
   xP711bl9XlO+pxeKYXdNwSm2fmyoFxZjdLRy0Y55mbbHxIN7xnz0Ps/dg
   eowKuZXYFoLoyklWDZ0LWH+DCRMYgzAXCgJVdFMYm++6H8JnuiM/Gc4Li
   0xsDUlF+obSU3TUuhrrEgCZAk7lCBwGClM8YCi4WoCykJ3nLFpuWOTJX9
   A==;
X-CSE-ConnectionGUID: VJ6Ca9PkSd61Ell5pAWFig==
X-CSE-MsgGUID: TC49yGpjSWu8ZJ8HLF1GWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52067907"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="52067907"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:30:06 -0700
X-CSE-ConnectionGUID: R2Ed3IvbSPGjghvOEmt/Fw==
X-CSE-MsgGUID: cMgRiCE8S2KLpMQWjZQZ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="157534030"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:30:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 0/8] ice: Separate TSPLL from PTP and cleanup
Date: Mon, 23 Jun 2025 17:29:56 -0700
Message-Id: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIXxWWgC/x2NywqDMBAAf0X23IUYfLW/UjykcdXFGENWRJD8e
 6O3mcvMBUKRSeBTXBDpYOHNZylfBdjZ+ImQh+ygla5VVba4LLhLcA55DXE7aCW/CxrHk78Rtf2
 ptjPD+G4gR0Kkkc9n8O1T+gP34eo/cAAAAA==
X-Change-ID: 20250417-kk-tspll-improvements-alignment-2cb078adf96
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Milena Olech <milena.olech@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>
X-Mailer: b4 0.14.2

This is the remaining 8 patches from the previous submission. I've rebased
them on top of what Jakub pulled and deleted the control-flow macros.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Jacob Keller (3):
      ice: clear time_sync_en field for E825-C during reprogramming
      ice: read TSPLL registers again before reporting status
      ice: default to TIME_REF instead of TXCO on E825-C

Karol Kolacinski (5):
      ice: use bitfields instead of unions for CGU regs
      ice: add multiple TSPLL helpers
      ice: wait before enabling TSPLL
      ice: fall back to TCXO on TSPLL lock fail
      ice: move TSPLL init calls to ice_ptp.c

 drivers/net/ethernet/intel/ice/ice_common.h | 212 +++-----------
 drivers/net/ethernet/intel/ice/ice_common.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  11 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  22 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c  | 425 ++++++++++++++++++----------
 5 files changed, 315 insertions(+), 357 deletions(-)
---
base-commit: 96c16c59b705d02c29f6bef54858b5da78c3fb13
change-id: 20250417-kk-tspll-improvements-alignment-2cb078adf96

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


