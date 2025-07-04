Return-Path: <netdev+bounces-204203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBD3AF97EC
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441F47B4FDA
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE3524DD0B;
	Fri,  4 Jul 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbDPewUN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91431863E
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645970; cv=none; b=R9KKsCBUN0pFiVrEmK7vBYvq4mbvHUlive1BzwY/YYlxvyRVItTl1gZluO9I2MWoqMaZLtXY8hz1XaVC0Q3FIFE05wQVQ5PLujs+QN7j2k8iEO6AQNV8aU59J85kzUnz72uj/GdEjboVdjt7gfjzGO+0EtEl5kkhskwLWCzqXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645970; c=relaxed/simple;
	bh=YdGfM372ecG5V/q2Nbx/zOdGtXzYtVGMC0tA7lzqA6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3lBDkI+tJhUgaHtFvo0XsOk1iW2dR5AwrYgfr0Q5DeEc+dUpKCT/64AIwhbGAr5u45WxIaMNinIGl/+K5DHgGGtOITF7FWT+0Vw1BsE/gNSaKkKOSOlln6NbgcGdDhVR+RO5udBv3UlUPx/WMXLpd67ajgeRYL9zujXaapY0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbDPewUN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751645969; x=1783181969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YdGfM372ecG5V/q2Nbx/zOdGtXzYtVGMC0tA7lzqA6Y=;
  b=dbDPewUN+cKUSXOMu0IKjsdQ1nNU7H03LWCYhrANjuod4BH2itW/XsGQ
   LJcIkE1QKz+kw3l+Rq2VGasLG+VsMEB+FZZxB90x890If6dgoqeoYUYPD
   PWX0vOEXTQwxYpnOCtfBpIsrCwSMfFc1oPFDj66zMeKdcrvpCwNGMC4gq
   urDLKXlK4ucSnP1Y6xI60khPfekMoI3c6RJOm+fpLdU6f/UxZMibjjRAY
   F9JnJzD/Ffr7eKEo1xyRhZ/XBNk4feElAI8c3mQBnvQ5zF6HcsNLH0a08
   URxo/eh0w5MCYM2x/qaf7WnYVIM6fRRahtnkmPvoyfiVd4ZxprT7uNcl2
   g==;
X-CSE-ConnectionGUID: vSU+3Nn9T020A5FVUjEGHg==
X-CSE-MsgGUID: R7w0b6kISLym0ubgJb4v5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="64672736"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="64672736"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 09:19:28 -0700
X-CSE-ConnectionGUID: M1rhPqLISli6My58NF8L5Q==
X-CSE-MsgGUID: ruTuhw9YT1S4DgcKXgABIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="154094638"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 09:19:26 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com,
	aleksander.lobakin@intel.com,
	larysa.zaremba@intel.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-next 0/3] ice: convert Rx path to Page Pool
Date: Fri,  4 Jul 2025 18:18:56 +0200
Message-ID: <20250704161859.871152-1-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes the Rx path in the ice driver by removing legacy
code and switching to the Page Pool API. The changes follow the same
direction as previously done for the iavf driver, and aim to simplify
buffer management, improve maintainability, and prepare for future
infrastructure reuse.

An important motivation for this work was addressing reports of poor
performance in XDP_TX mode when IOMMU is enabled. The legacy Rx model
incurred significant overhead due to per-frame DMA mapping, which
limited throughput in virtualized environments. This series eliminates
those bottlenecks by adopting Page Pool and bi-directional DMA mapping.

The first patch removes the legacy Rx path, which relied on manual skb
allocation and header copying. This path has become obsolete due to the
availability of build_skb() and the increasing complexity of supporting
features like XDP and multi-buffer.

The second patch drops the page splitting and recycling logic. While
once used to optimize memory usage, this logic introduced significant
complexity and hotpath overhead. Removing it simplifies the Rx flow and
sets the stage for Page Pool adoption.

The final patch switches the driver to use the Page Pool and libeth
APIs. It also updates the XDP implementation to use libeth_xdp helpers
and optimizes XDP_TX by avoiding per-frame DMA mapping. This results in
a significant performance improvement in virtualized environments with
IOMMU enabled (over 5x gain in XDP_TX throughput). In other scenarios,
performance remains on par with the previous implementation.

This conversion also aligns with the broader effort to modularize and
unify XDP support across Intel Ethernet drivers.

Tested on various workloads including netperf and XDP modes (PASS, DROP,
TX) with and without IOMMU. No regressions observed.

Last but not least, it is suspected that this series may also help
mitigate the memory consumption issues recently reported in the driver.
For further details, see:

https://lore.kernel.org/intel-wired-lan/CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com/

Thanks,
Michal

Michal Kubiak (3):
  ice: remove legacy Rx and construct SKB
  ice: drop page splitting and recycling
  ice: switch to Page Pool

 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/ice/ice.h          |   3 +-
 drivers/net/ethernet/intel/ice/ice_base.c     | 122 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  22 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |   1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  21 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 645 +++---------------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  37 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  65 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   7 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   5 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 120 +---
 drivers/net/ethernet/intel/ice/ice_xsk.h      |   6 +-
 13 files changed, 205 insertions(+), 850 deletions(-)

-- 
2.45.2


