Return-Path: <netdev+bounces-51469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613257FAC51
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 22:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E241C20EDA
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 21:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F86A446DF;
	Mon, 27 Nov 2023 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAP5XBgL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B16919D
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 13:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701119444; x=1732655444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DXfQEDvOJm0FuxXXFHs8PIqhuz2Wco+AKySmuSAO9Uc=;
  b=hAP5XBgLLb7DP0/HXHdrlrzFlQffbeg72kemdxXz6og9c6yMyFVRzE4J
   WR2WWj3GF+LWb5n3oj8Or5n7MZzvXo69g0scNYvldhz1nmJYCnPvxlgOc
   0ISOnrm373hJAFqZcFYa1iGC8Wu8X7eTSXlryk4Ahsv4VN+XEdXYczeqE
   jjnX9bl6G/fCGq9VcaNR9z66cHy5F5im1tOIE1mK4i5nV8wi6+pHJ5oRc
   QCsCW74B3ewiPg5V/DGV8mY5sW7ZD3citNGluOonAh+IMOD3Z/L6RWAn+
   ljDuIKCG71Q42WhKjNa2CcNTWlNmM19LbQ4c0+zB56MPL0+S/CdWYDEYU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="5982905"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="5982905"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 13:10:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="9724670"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 27 Nov 2023 13:10:45 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/5][pull request] Intel Wired LAN Driver Updates 2023-11-27 (i40e, iavf)
Date: Mon, 27 Nov 2023 13:10:30 -0800
Message-ID: <20231127211037.1135403-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to i40e and iavf drivers.

Ivan Vecera performs more cleanups on i40e and iavf drivers; removing
unused fields, defines, and unneeded fields.

Petr Oros utilizes iavf_schedule_aq_request() helper to replace open
coded equivalents.

The following are changes since commit e1df5202e879bce09845ac62bae30206e1edfb80:
  net :mana :Add remaining GDMA stats for MANA to ethtool
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Ivan Vecera (4):
  i40e: Delete unused and useless i40e_pf fields
  i40e: Remove AQ register definitions for VF types
  i40e: Remove queue tracking fields from i40e_adminq_ring
  iavf: Remove queue tracking fields from iavf_adminq_ring

Petr Oros (1):
  iavf: use iavf_schedule_aq_request() helper

 drivers/net/ethernet/intel/i40e/i40e.h        | 16 ----
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 86 +++++++------------
 drivers/net/ethernet/intel/i40e/i40e_adminq.h |  7 --
 drivers/net/ethernet/intel/i40e/i40e_common.c |  8 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  3 -
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 26 ++----
 .../net/ethernet/intel/i40e/i40e_register.h   | 10 ---
 drivers/net/ethernet/intel/iavf/iavf_adminq.c | 86 +++++++------------
 drivers/net/ethernet/intel/iavf/iavf_adminq.h |  7 --
 drivers/net/ethernet/intel/iavf/iavf_common.c |  8 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 10 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 23 ++---
 12 files changed, 90 insertions(+), 200 deletions(-)

-- 
2.41.0


