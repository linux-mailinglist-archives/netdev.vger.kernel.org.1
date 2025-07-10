Return-Path: <netdev+bounces-205950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE08B00E0F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05AB5C3E65
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75398299931;
	Thu, 10 Jul 2025 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKoXEmmW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E851822FDFA
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183932; cv=none; b=W2dwSyuayuX7RpfBXUDeRh8+G0E4cvnImYlyaXMj3F+aUy2hE8aZInJdNd0crrTyEnwfjicix+xCpXZINsX0wKF6mv8pfscnWbg/zyx6wCPxFEEitMdoIX0cu2fIRm7i9btyzmvevk2KKeyHgcXAg6VIh6vPMsssRmpkIbHZLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183932; c=relaxed/simple;
	bh=FFEy91odWCdkta6vhA4hUKv0G7R09vfph0TqUxMA/b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+i9lnK6cqS5jTGyIcZDcgTL4A24PTiD/ITA1FXhfzMzAyTSwL5/csMOttROn1CNQQ2/rYVTb/qrTu2sXftZEw2FIlOLJwoenbxOprNfDU7LuOU/Qi6O5RE+WVsGzyJJWsHudzp4pu88k0YWXxKwmdavhPqeJqelZiI7L1QZKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKoXEmmW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752183932; x=1783719932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FFEy91odWCdkta6vhA4hUKv0G7R09vfph0TqUxMA/b4=;
  b=JKoXEmmWySc42DglJ5kpMwkUMCD0SnWQD0ngIjOKX9RrzSgLrxHm9snr
   4+t9aAK3TmzVdBjx0qNb5DpyYf7eJyU1IpgNIX4BXqD7DLwEtBvVCwpY2
   FjwHPDR4xUHoKjxzw2j63lKk2qyGzLms4noOPYMTZuEZtenzcmmtG3U0E
   /lv0iuXv48Cf+USymQXawZ+VgxmUDRmQqaJ4wiLcJYl2450wsFN6kdlgE
   7GtmU3TB7SNr1YR2xOHfzy6dCWRe/YCfKZkFlWXGNNAjy+BX2+m/OHqBp
   xg2M+pqcJpCxAr4FOs2e2BW0c483WW5huSkrrvInc6jJLSAoaRlg7GF6/
   A==;
X-CSE-ConnectionGUID: 1xj8ViSZQriiJH28yUVX1g==
X-CSE-MsgGUID: Vi+nVmAYQjyHbb8aol27mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54192385"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54192385"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 14:45:28 -0700
X-CSE-ConnectionGUID: 9DxF1Q29Q/6AActKXZ5vaw==
X-CSE-MsgGUID: mG1IBrndSPe4EaVkAJOwIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="161764961"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jul 2025 14:45:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	madhu.chittim@intel.com,
	yahui.cao@intel.com,
	przemyslaw.kitszel@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 7/8] ice: avoid rebuilding if MSI-X vector count is unchanged
Date: Thu, 10 Jul 2025 14:45:16 -0700
Message-ID: <20250710214518.1824208-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
References: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Commit 05c16687e0cc ("ice: set MSI-X vector count on VF") added support to
change the vector count for VFs as part of ice_sriov_set_msix_vec_count().
This function modifies and rebuilds the target VF with the requested number
of MSI-X vectors.

Future support for live migration will add a call to
ice_sriov_set_msix_vec_count() to ensure that a migrated VF has the proper
MSI-X vector count. In most cases, this request will be to set the MSI-X
vector count to its current value. In that case, no work is necessary.
Rather than requiring the caller to check this, update the function to
check and exit early if the vector count is already at the requested value.
This avoids an unnecessary VF rebuild.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index f88bfd2f3f00..f78d5d8d516c 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -966,6 +966,12 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 		return -ENOENT;
 	}
 
+	/* No need to rebuild if we're setting to the same value */
+	if (msix_vec_count == vf->num_msix) {
+		ice_put_vf(vf);
+		return 0;
+	}
+
 	prev_msix = vf->num_msix;
 	prev_queues = vf->num_vf_qs;
 
-- 
2.47.1


