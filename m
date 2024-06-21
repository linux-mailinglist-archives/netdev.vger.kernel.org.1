Return-Path: <netdev+bounces-105760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA708912AF0
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947A51F27CCB
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E8515FA6A;
	Fri, 21 Jun 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqVLsA7Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9ED15F40C
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986108; cv=none; b=ONyxD/LGjUjizS6ZMsznAnD5XNKQOy0NYv9hd1PcGAxrAHqAlwH5qkDkm+2q+jfcw1hps6plCa90rh35X2O2hWVlF6ktZ/5Q7rPV3cVomzCHdl7AP39eThn26iFOD4ursnU4rlOvAGnKfEyKdIu0AIwV5TRd3YlenicYDC8fuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986108; c=relaxed/simple;
	bh=8jOc0OqzwpS0iyLZTn63cpatsiJm1NyC3N3cCRCfVfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vF4XNSdzy8jp8NVuDgKBuntI/V9NoAyK0f7glfwmtYb5AGYtW0BBosL5kD/pQ6vzGysGD4EzKvK+WcVCeDRNFSsjKqcxejM9InvoOOy4ErfKCO6Cy5putbTYSG94g0NrmNvekLBvMcxhLh7D0Hdh/NXL3qY9HROEPVJMiWRESnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqVLsA7Q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718986107; x=1750522107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8jOc0OqzwpS0iyLZTn63cpatsiJm1NyC3N3cCRCfVfo=;
  b=GqVLsA7QXrIRayXDif8ROHdIe+UKXSX62xd2XzXb0peto/ujD9LxGLG8
   Il9wHdv1MWzDjXiWm+fe6mGY0zE/U7RL7kS4ixyWFrVIIGEt4+3kGlvqi
   9eGpm+Gy5Arwa/R+BaU2av6r1XyTWETEDtbO8SY3LCeTSuzf86Qkup3sk
   q48eX6Vh8IBymldGfny6Cx9OAcsX1emeo/iQxqsfH6ZVZn7QyWEA01MJX
   Q8K6UMgzLJw3B59X6etikCR8/cOW9nOfaQC5TLkG4EEgBHWfNou6NKrly
   uGjKCZoAQZW71QxSjSb4576bo3zPcpRstCLbWsMMMCFm/aXyzwVMdDqwK
   w==;
X-CSE-ConnectionGUID: rDSpQwbbS4uFwZmDw7Tdfg==
X-CSE-MsgGUID: obWdnPAvQeKSaicNPKHO8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="19801396"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="19801396"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 09:08:26 -0700
X-CSE-ConnectionGUID: jNBpswm9RBii83Ya1+wjFA==
X-CSE-MsgGUID: O36Zk70pQCCHQswL5eUF7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="47149795"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 21 Jun 2024 09:08:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	michal.swiatkowski@linux.intel.com
Subject: [PATCH net-next 0/4][pull request] ice: prepare representor for SF support
Date: Fri, 21 Jun 2024 09:08:13 -0700
Message-ID: <20240621160820.3394806-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Michal Swiatkowski says:

This is a series to prepare port representor for supporting also
subfunctions. We need correct devlink locking and the possibility to
update parent VSI after port representor is created.

Refactor how devlink lock is taken to suite the subfunction use case.

VSI configuration needs to be done after port representor is created.
Port representor needs only allocated VSI. It doesn't need to be
configured before.

VSI needs to be reconfigured when update function is called.

The code for this patchset was split from (too big) patchset [1].

[1] https://lore.kernel.org/netdev/20240213072724.77275-1-michal.swiatkowski@linux.intel.com/
---
Originally from https://lore.kernel.org/netdev/20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com/
Changes:
- delete ice_repr_get_by_vsi() from header
- rephrase commit message in moving devlink locking

The following are changes since commit 3226607302ca5a74dee6f1c817580c713ef9d0dd:
  selftests: net: change shebang to bash in amt.sh
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Michal Swiatkowski (4):
  ice: store representor ID in bridge port
  ice: move devlink locking outside the port creation
  ice: move VSI configuration outside repr setup
  ice: update representor when VSI is ready

 .../net/ethernet/intel/ice/devlink/devlink.c  |  2 -
 .../ethernet/intel/ice/devlink/devlink_port.c |  4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 85 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_eswitch.h  | 14 ++-
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  4 +-
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_repr.c     | 16 ++--
 drivers/net/ethernet/intel/ice/ice_repr.h     |  3 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  2 +-
 9 files changed, 90 insertions(+), 41 deletions(-)

-- 
2.41.0


