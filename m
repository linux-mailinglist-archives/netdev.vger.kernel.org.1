Return-Path: <netdev+bounces-128796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5A797BC22
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 14:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711E9B221FF
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509DF189F5D;
	Wed, 18 Sep 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkEtjXCN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD16189B8A
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662057; cv=none; b=jltkdYSpvO6thd2Rx9kxzCAF/abdQXDQ7S+a/qdFo982cxZLgfRIStAVcecq0dlE8ULC29xWpsL1Vvf18zXzNcdxYTrSj/RHSwo/DDzU+N9miQFjXyIrDR8DxjfQsrGC1ECjCqh9VrRFlFbRUKRnnTHyJ2BhoihYQsc1afJoZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662057; c=relaxed/simple;
	bh=lJ78Iy+0jAEhk978rmTHFMofgR3SD6splpg+FTdIEG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Il1XlTxXk71PX/K7lEp4rnxhCKcBr5v61SjxUIWJc/TzYJUb2zUo6w41gVy3/MOOaMhwHvl1I6f4tIakU7Jmg7rEKye37jhILyzDmHzAkI4OuAVtfKcnW/vI1Xs86wge/+A3JONdWeixHXMYZ35eVVJrHn7tDEbBUD+pZ8qayXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkEtjXCN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726662056; x=1758198056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lJ78Iy+0jAEhk978rmTHFMofgR3SD6splpg+FTdIEG4=;
  b=EkEtjXCNsj0vq8KNayBluNp0SAHvYRKNnzhd/9x1ohuxSWR4v//BQXRU
   zV4hL0ibGvw6b73WhD7t/J7MW7EgBrEEK7v51A8CtUOtjDJNMFHMQrFMl
   xjjgd8NZcwLiUBPHEmAusTbURKvk0JPoWJuuyuNaynqG1TwiDsHhUcbly
   w/tgDaUYkvZNY53aKy5H4T4ABINpmi2AJhrQyciXdNx3ZFZyUBVTlry+d
   QDhV6NYu0dLs85cQ8vZ5CmzKPaln4devErOJoB23QWZZHyH62C2wmRthC
   AoRCwmjCALjYCdWbq/SM/f4rm8mgfYNqEWWXFxiDczE0eg/ew8HaJ+Y6X
   A==;
X-CSE-ConnectionGUID: n7dzuWtGT7uiMFO2W5Gutw==
X-CSE-MsgGUID: WrwECftnSU69AyvvA8cnNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25689203"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="25689203"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 05:20:55 -0700
X-CSE-ConnectionGUID: nTQcHm95TCuZ54+uIiDAWg==
X-CSE-MsgGUID: Pgt1I0SUQCC7gOpBtdrNvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="69636425"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by fmviesa008.fm.intel.com with ESMTP; 18 Sep 2024 05:20:52 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v11 iwl-next 0/7] ice: Implement PTP support for E830 devices
Date: Wed, 18 Sep 2024 14:12:28 +0200
Message-ID: <20240918122048.1554692-9-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add specific functions and definitions for E830 devices to enable
PTP support.

Refactor processing of timestamping interrupt, cross timestamping, and
remove usage of ice_is_e8xx() functions to avoid code redundancy.

Refactor GNSS presence check to be able to remove ice_is_e8xx()
functions.

Jacob Keller (1):
  ice: Add unified ice_capture_crosststamp

Karol Kolacinski (5):
  ice: Don't check device type when checking GNSS presence
  ice: Remove unncecessary ice_is_e8xx() functions
  ice: Use FIELD_PREP for timestamp values
  ice: Process TSYN IRQ in a separate function
  ice: Refactor ice_ptp_init_tx_*

Michal Michalik (1):
  ice: Implement PTP support for E830 devices

 drivers/net/ethernet/intel/Kconfig            |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |   5 -
 drivers/net/ethernet/intel/ice/ice_common.c   | 210 ++++----
 drivers/net/ethernet/intel/ice/ice_common.h   |   7 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c     |  29 +-
 drivers/net/ethernet/intel/ice/ice_gnss.h     |   4 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  27 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 509 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 407 ++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  41 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   9 -
 15 files changed, 734 insertions(+), 543 deletions(-)

V10 -> V11: Fixed adjustments not working on E830 in "ice: Implement PTP support
            for E830 devices"
V9 -> V10: Fixed E825C MAC condition in caps and and enabled
           ICE_FLAG_PTP_SUPPORTED for E830
V8 -> V9: Fixed compilation issue introduced after rebase in "ice: Remove
          unncecessary ice_is_e8xx()"
V7 -> V8: - reordered patches to have all E830 changes in "ice: Implement PTP
            support for E830 devices"
          - added "ice: Don't check device type when checking GNSS presence",
            which removes GNSS related changes from "ice: Remove unncecessary
            ice_is_e8xx() functions"
          - reworded commit messages
V6 -> V7: Fixed timestamp acquisition in "ice: Implement PTP support for
          E830 devices"
V5 -> V6: Fixed minor compilation issue in "ice: Use FIELD_PREP for timestamp
          values"
V4 -> V5: Added 2 patches: "ice: Remove unncecessary ice_is_e8xx()
          functions" and "ice: Use FIELD_PREP for timestamp values".
          Edited return values "ice: Implement PTP support for E830
          devices".
V3 -> V4: Further kdoc fixes in "ice: Implement PTP support for
          E830 devices"
V2 -> V3: Rebased and fixed kdoc in "ice: Implement PTP support for
          E830 devices"
V1 -> V2: Fixed compilation issue in "ice: Implement PTP support for
          E830 devices"

base-commit: abc6944428c5cf8d3ad3fb6de03939ec12289e14
-- 
2.46.0


