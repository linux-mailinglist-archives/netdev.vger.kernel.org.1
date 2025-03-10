Return-Path: <netdev+bounces-173475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC5DA59265
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D967A3A4DE6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF05B227586;
	Mon, 10 Mar 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWSumPbZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388F224252
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605253; cv=none; b=ndj0Q2R/zyNn8pevFIkuWMssdGPeAfFpDJ1m4aacAdxSB0UTu/Cux8URpYycC6iojJQZqvPlq3rw6sbkZyfSG46ozGZ17SBfAbuRBIjKj0O9xATMBDCW+pMhui9FLXf7wSBmFVMW3WnfpMNaVbZbAuqg8in9jt1jeAJVLgh8B6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605253; c=relaxed/simple;
	bh=UlgUaNk4Hl2rsXKsSeQprHfcgFzi8IEM0uNFUjWDwdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ju4bKvJ26aZVJUlyWBksTQucZ52fNC6eLfsi9nvcRZPCSAhQ0HEbrwTTV5C+DW7fai0RhJY0zJHJfmiFFfOXet03LeeEJZtcjdd6GCJcsMKocA5XWiRF6pEoIS+nHTy9VpoJ0gIbmXCLJ1WbRQiVN1i0XJSGjQarrL/s+dI1iNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWSumPbZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741605252; x=1773141252;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UlgUaNk4Hl2rsXKsSeQprHfcgFzi8IEM0uNFUjWDwdA=;
  b=FWSumPbZf+AZDAuJxE2/A6G70YiFU9Fj685SnzvTh88PaELyQhq46BvZ
   8XsfRaLOb8RMCaJm2NdzoqoS/rbwqnGo4mmknjXwwZZY0QioPUU3OBngR
   aMyS7CMqruUjcVBQCA+n2jF7/3dRzgiga+txjOpFoSFPcsLMPBYQeSTFE
   1QLqvMBE6RJYEamw3WtALF0NF/K4qHjMCr4hAYx9tQXbKLma4IYavRcTV
   E/9Q+kea0KQqVqvPcwObRbbxslJMlG59HlzaJl6mCAngSdqD6uSc+102v
   svEmj/m75zo3bBtQ87b5pOCGPHq12qJrfrkom6pUru/gLmR7Ps9OVFvQG
   w==;
X-CSE-ConnectionGUID: xvDzARWqRM+PQCQJ24Y1WQ==
X-CSE-MsgGUID: ogqeN5+bQI+Mbb/VKwl3xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="65048660"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="65048660"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 04:14:11 -0700
X-CSE-ConnectionGUID: dZL6+079Q6OwfjitwQWQBA==
X-CSE-MsgGUID: vB5lMReOQi+vTsMY8taOGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119968304"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2025 04:14:09 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next 00/10] ice: Separate TSPLL from PTP and clean up
Date: Mon, 10 Mar 2025 12:12:44 +0100
Message-ID: <20250310111357.1238454-12-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate TSPLL related functions and definitions from all PTP-related
files and clean up the code by implementing multiple helpers.

Adjust TSPLL wait times and fall back to TCXO on lock failure to ensure
proper init flow of TSPLL.

Karol Kolacinski (10):
  ice: move TSPLL functions to a separate file
  ice: rename TSPLL and CGU functions and definitions
  ice: use designated initializers for TSPLL consts
  ice: add TSPLL log config helper
  ice: add ICE_READ/WRITE_CGU_REG_OR_DIE helpers
  ice: use bitfields instead of unions for CGU regs
  ice: add multiple TSPLL helpers
  ice: wait before enabling TSPLL
  ice: fall back to TCXO on TSPLL lock fail
  ice: move TSPLL init calls to ice_ptp.c

 drivers/net/ethernet/intel/ice/Makefile       |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h | 181 ------
 drivers/net/ethernet/intel/ice/ice_common.c   |  69 ++-
 drivers/net/ethernet/intel/ice/ice_common.h   |  58 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  14 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   | 177 +-----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 566 +-----------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  54 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c    | 508 ++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_tspll.h    |  28 +
 drivers/net/ethernet/intel/ice/ice_type.h     |  20 +-
 12 files changed, 698 insertions(+), 980 deletions(-)
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_cgu_regs.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_tspll.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_tspll.h


base-commit: daa2036c311e81ee32f8cccc8257e3dfd4985f79
-- 
2.48.1


