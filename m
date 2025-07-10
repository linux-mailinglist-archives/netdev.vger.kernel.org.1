Return-Path: <netdev+bounces-205943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6790FB00E08
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C311C42BD3
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6759612CDA5;
	Thu, 10 Jul 2025 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSXLoRJU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879674A0C
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183927; cv=none; b=owibaZxFJH9IAvUxPjoGVXrkFG1sZRA6UiIeuWMsgTYeA8KnwJQXl8Y7fBZLhzwEtfOcDVkqUZZ05Pos6nhjQD+YnCLABNNeIlcHlcEgZ5WDvaY68MyuNAWCaCk2fWINrkitebcwwzi8CBAKD1aiyPoKD8kEdU9XLh/5vM/ZFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183927; c=relaxed/simple;
	bh=iq04ZNNJcvAQvik1Ca5cj+ornOMueb6IOPlwrWoxtRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrEJn1E+bvGfVsvxbfqKYjM1APHAAUBcJ6PVa7BXj75c2pLqf2LBzlmzv/2OFSoufqESRbO67wAtq276/j7dD4t+hMD+7upaEHM7Wz3xOLikYXXWpcj1jom0FiNrY5+UkmKpu0CKNfwYf0llwbEqfCvvGkn+B28dIwnBGjsRk/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSXLoRJU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752183926; x=1783719926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iq04ZNNJcvAQvik1Ca5cj+ornOMueb6IOPlwrWoxtRU=;
  b=hSXLoRJUF1hOtkyvPMTErGe1o0Y48alfBy+6e140Mjz4BzHJHvGNSLuP
   BqdhyumYGLqcFz73rLriUDsmijpbAr1vd4MSsBKXtwg9Ayp3CK2LlMg1Y
   jY/7RKkmGqwZx3jK03VEatI/I71yf5qemd2OknL5SalL9t6ZnLd3RZtH8
   qdXG+WCVcBUwgQ1slus3qj1Gvfrmr9p2so0F5lhjLrudhIArXeArnM9YN
   a0GtnTempd23bR1sIbeSU6Xw5rMJDlse6wIj5QH3wi+fGjZIvMBbHvEvu
   ALZrOIiSMFPF6XSAcZMk359MdPRL1D1uNYJiBTKZC3er19u8xsa7kasao
   g==;
X-CSE-ConnectionGUID: HGSFBL00T8erGR2ZouPXmQ==
X-CSE-MsgGUID: GuJugpwSRS+gShXP4nYjtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54192340"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54192340"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 14:45:25 -0700
X-CSE-ConnectionGUID: z6WROwxXTPS9BF24MRIUpA==
X-CSE-MsgGUID: wdk2JgPsT+26j20waqyNDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="161764925"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jul 2025 14:45:24 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jacob.e.keller@intel.com,
	madhu.chittim@intel.com,
	yahui.cao@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next 0/8][pull request] ice: cleanups and preparation for live migration
Date: Thu, 10 Jul 2025 14:45:09 -0700
Message-ID: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jake Keller says:

Various cleanups and preparation to the ice driver code for supporting
SR-IOV live migration.

The logic for unpacking Rx queue context data is added. This is the inverse
of the existing packing logic. Thanks to <linux/packing.h> this is trivial
to add.

Code to enable both reading and writing the Tx queue context for a queue
over a shared hardware register interface is added. Thanks to ice_adapter,
this is locked across all PFs that need to use it, preventing concurrency
issues with multiple PFs.

The RSS hash configuration requested by a VF is cached within the VF
structure. This will be used to track and restore the same configuration
during migration load.

ice_sriov_set_msix_vec_count() is updated to use pci_iov_vf_id() instead of
open-coding a worse equivalent, and checks to avoid rebuilding MSI-X if the
current request is for the existing amount of vectors.

A new ice_get_vf_by_dev() helper function is added to simplify accessing a
VF from its PCI device structure. This will be used more heavily within the
live migration code itself.
---
This is the first eight patches of my full series to support live
migration. The full series (based on net-next) is available at [1] for
early preview if you want to see the changes in context.

Some of these changes are not "used" until the live migration patches
themselves. However, I felt they were sufficiently large and review-able on
their own. Additionally, if I keep them included within the live migration
series it is 15 patches which is at the limit of acceptable size for
netdev. I'd prefer to merge these cleanups first in order to reduce the
burden of review for the whole feature.

Link: [1] https://github.com/jacob-keller/linux/tree/e810-live-migration/jk-migration-tlv

The following are changes since commit e090f978054e1cfcd970234589168fcbcba33976:
  Merge branch 'net-dsa-rzn1_a5psw-add-compile_test'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jacob Keller (8):
  ice: add support for reading and unpacking Rx queue context
  ice: add functions to get and set Tx queue context
  ice: save RSS hash configuration for migration
  ice: move ice_vsi_update_l2tsel to ice_lib.c
  ice: expose VF functions used by live migration
  ice: use pci_iov_vf_id() to get VF ID
  ice: avoid rebuilding if MSI-X vector count is unchanged
  ice: introduce ice_get_vf_by_dev() wrapper

 drivers/net/ethernet/intel/ice/ice_adapter.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h  |   5 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  14 +-
 drivers/net/ethernet/intel/ice/ice_common.c   | 233 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_common.h   |   6 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |  35 +++
 drivers/net/ethernet/intel/ice/ice_lib.h      |   8 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  19 +-
 drivers/net/ethernet/intel/ice/ice_sriov.h    |   7 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   3 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  26 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  59 +----
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |  19 ++
 14 files changed, 378 insertions(+), 69 deletions(-)

-- 
2.47.1


