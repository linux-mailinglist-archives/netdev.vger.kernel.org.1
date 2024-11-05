Return-Path: <netdev+bounces-142120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CCD9BD881
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D851C2224E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E306A216DFD;
	Tue,  5 Nov 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eq4nIxG9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D4A216DF9
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845449; cv=none; b=TPXF/B4dS5kmvF3nhInqvTSNAzXpR6JgReMw3Bx+5e0c4TPCWqeqlMh0hWEJeIJvfHEefu5EG3xR8sXXT2WSzbDw1XSBQux50VkVT7pu/VwvVbpyO3T4Ao7RJEryIwo2rHVKtR37yB4XzoMvf5/r6Ku9gvL6fyT3h7mgn7BSeg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845449; c=relaxed/simple;
	bh=2122BFx7wZd5PY+V5o0vzfvpOOTUFdW+arY4RIKKIrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl9Oikv8MyGDSTbYi9cKEtZ8k4nc8WJn5EmyteRQmfSZIdPlMLOztDMi2BaM1GCxrBOm1zPvhSDt2kO0MdY9fNP1UMR7EMhk8NO9So4t9H7l6xvSKdaQYEDAON4EGzQRqo/zo3TPPIOVB+HkaGZ6nTgDkT6jMsuYqk/7XX8Z13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eq4nIxG9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845448; x=1762381448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2122BFx7wZd5PY+V5o0vzfvpOOTUFdW+arY4RIKKIrM=;
  b=eq4nIxG9635F1zvRII3m7CcrA9xKX7WepK31x8HWnloAPeX6QZjul+fA
   AEH8SKSAVpVpLX0GOVb/r7UlVSWxmhYAtSgjcPHw+tCaOKpOtBgM8Du6C
   +VB6dX8mF4cKGmLLiXuqcLI6GqW7O+P04pYZoai6YkejVRxFEPPro6q4l
   z0wfPaFz+LjJgMWkCy0we/L2ql/5N/zz57gGhOnewL5b/aZVfiXLZKoIS
   wc1n2KT+iM/NUqoCpTkVoVZyXqnTCcnQ1fAuPJAIa2ZNHyOJSbHONneW+
   B/B9I84GwplqLsNGPfbNeP3I8sgxEpQi/ix1chEcrfbWwL9GyjngNDe71
   A==;
X-CSE-ConnectionGUID: sHGhAJPjScyCuzMXY9CUGg==
X-CSE-MsgGUID: hLXU7C6zQd2ledmcOOQZ0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314327"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314327"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:24:03 -0800
X-CSE-ConnectionGUID: k6c/d9oERuybEhmAeHlk3g==
X-CSE-MsgGUID: wwysqthqQ/m9ikP85ZrDpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322474"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:24:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Johnny Park <pjohnny0508@gmail.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 13/15] igb: Fix 2 typos in comments in igb_main.c
Date: Tue,  5 Nov 2024 14:23:47 -0800
Message-ID: <20241105222351.3320587-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johnny Park <pjohnny0508@gmail.com>

Fix 2 spelling mistakes in comments in `igb_main.c`.

Signed-off-by: Johnny Park <pjohnny0508@gmail.com>
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b83df5f94b1f..37b674f8cbcd 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1204,7 +1204,7 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 	/* initialize pointer to rings */
 	ring = q_vector->ring;
 
-	/* intialize ITR */
+	/* initialize ITR */
 	if (rxr_count) {
 		/* rx or rx/tx vector */
 		if (!adapter->rx_itr_setting || adapter->rx_itr_setting > 3)
@@ -3906,7 +3906,7 @@ static void igb_remove(struct pci_dev *pdev)
  *
  *  This function initializes the vf specific data storage and then attempts to
  *  allocate the VFs.  The reason for ordering it this way is because it is much
- *  mor expensive time wise to disable SR-IOV than it is to allocate and free
+ *  more expensive time wise to disable SR-IOV than it is to allocate and free
  *  the memory for the VFs.
  **/
 static void igb_probe_vfs(struct igb_adapter *adapter)
-- 
2.42.0


