Return-Path: <netdev+bounces-130637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E3198AFEF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912F21F216B8
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF47188CD8;
	Mon, 30 Sep 2024 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCdl1CBO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906618893A
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735767; cv=none; b=hUDIHu7WNDr5EJ7HUBYQgsQsUIPZ8hVNLL2dHa0JmHmzk9cqXdvrTUBDG5iv1SvosXxXhmKuJ0rauk2gDhKsl3x3ky9SSO5n96jbuO9COUNbTlYtyWKHdTobdgL8mvMShKFbZvnLz4hGjbwqL8GaWnKZ9hAGXxll+JBPQ8u3m7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735767; c=relaxed/simple;
	bh=XxYBal3nHsHT30HMeyTUqnzOhu/7gX3UwWewL1VUWFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cqoyf3kxm+luw6A6b8fsIDJHtwXpKGVdYM1mdiK5aIhuH0y9e8h7HoZ8UzmbwEilLe5t5xSYQ561dnOMiw9yAtDrIMjA5XVOIMtZXBNr58EaDByeJV6fj+uFGyjF0j+ehCLOjeBZMm3Bxyvj81R4x2B5wEb5V4iA305smQwnYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCdl1CBO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727735766; x=1759271766;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XxYBal3nHsHT30HMeyTUqnzOhu/7gX3UwWewL1VUWFY=;
  b=NCdl1CBOej8Pq15YUVWp8ArHN9fwYK3J+vQUlFPMDMD7sY7viyouiEyh
   skeJrlPHwdRTqHWY026lmNcWSY2oRnnCghve8QBFFoW7UImyQ2GEYPEpU
   kRigKLgQv6RPf5LMSlz/gTtlqZGjvrmGbkEMl/QRz+tSgJXH4P3ltEa3H
   BhOZPteRLnQSG8/MT8L+sXT3d2fJTmNnYuB1CgxIv0YzMbqHv2sIn2Vri
   nvdijeonijuSzLPJ1GO86uc98r5pjlWTqKAH77VsK41WyM7f73wfm9jmb
   UEM0Mppd1OX9D7LF1gdIOtNndjRGg31ySBqL09WTuCjEoS/4msoojRPl4
   Q==;
X-CSE-ConnectionGUID: V0lQyBOqTeKkM0sqf02pTg==
X-CSE-MsgGUID: QaKy8DFCSfa12hyFoWN9qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30734846"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="30734846"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:36:05 -0700
X-CSE-ConnectionGUID: hRGxI4jPQlqHIzr3j9JJEA==
X-CSE-MsgGUID: dSioeqmKS0Cpqwl+O3raaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73496604"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 30 Sep 2024 15:36:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 00/10][pull request] Intel Wired LAN Driver Updates 2024-09-30 (ice, idpf)
Date: Mon, 30 Sep 2024 15:35:47 -0700
Message-ID: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice and idpf drivers:

For ice:

Michal corrects setting of dst VSI on LAN filters and adds clearing of
port VLAN configuration during reset.

Gui-Dong Han corrects failures to decrement refcount in some error
paths.

Przemek resolves a memory leak in ice_init_tx_topology().

Arkadiusz prevents setting of DPLL_PIN_STATE_SELECTABLE to an improper
value.

Dave stops clearing of VLAN tracking bit to allow for VLANs to be properly
restored after reset.

For idpf:

Ahmed sets uninitialized dyn_ctl_intrvl_s value.

Josh corrects use and reporting of mailbox size.

Larysa corrects order of function calls during de-initialization.

The following are changes since commit d505d3593b52b6c43507f119572409087416ba28:
  net: wwan: qcom_bam_dmux: Fix missing pm_runtime_disable()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Ahmed Zaki (1):
  idpf: fix VF dynamic interrupt ctl register initialization

Arkadiusz Kubalewski (1):
  ice: disallow DPLL_PIN_STATE_SELECTABLE for dpll output pins

Dave Ertman (1):
  ice: fix VLAN replay after reset

Gui-Dong Han (2):
  ice: Fix improper handling of refcount in ice_dpll_init_rclk_pins()
  ice: Fix improper handling of refcount in
    ice_sriov_set_msix_vec_count()

Joshua Hay (1):
  idpf: use actual mbx receive payload length

Larysa Zaremba (1):
  idpf: deinit virtchnl transaction manager after vport and vectors

Michal Swiatkowski (2):
  ice: set correct dst VSI in only LAN filters
  ice: clear port vlan config during reset

Przemek Kitszel (1):
  ice: fix memleak in ice_init_tx_topology()

 drivers/net/ethernet/intel/ice/ice_ddp.c      | 58 +++++++++----------
 drivers/net/ethernet/intel/ice/ice_ddp.h      |  4 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c     |  6 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  8 +--
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  8 ++-
 drivers/net/ethernet/intel/ice/ice_switch.c   |  2 -
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 11 ++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  7 +++
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c | 57 ++++++++++++++++++
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.h |  1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  1 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 11 +---
 12 files changed, 120 insertions(+), 54 deletions(-)

-- 
2.42.0


