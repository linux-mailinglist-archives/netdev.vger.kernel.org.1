Return-Path: <netdev+bounces-156480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EABCA06813
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE083167BE2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16856204C01;
	Wed,  8 Jan 2025 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghWWiPP5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725181F76AC
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374687; cv=none; b=s0/pQY+nT1gjp5fJkG+mPIXQNkoDd7pROPd90DtgqWRlNzuGme7qBEKM5pinH8Q6rMkxjm6GFev/ym9kso8zmcrJNDIH/UZ6xFN6EhzcHKHfyoAOOvL2AD2Un/mqS+9P4zZ87IZpfWhxkKBq6XjzRtLDwiHm5sOM0cujVHt5mfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374687; c=relaxed/simple;
	bh=H2rjiwuBDH+v++VYQzOQXaoIqU6zYrlDWgNkO9LruCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWImT5QiEAakeMaaqAN0TT/rDlOOAGb9buCNOaJ4RuCVCceOXLU5pbgmqoZdX52MBc8hrwKm2SiTgvCIxD+cCaPqiOvq2OozVBI7j8XiADThoC6CpAsrtbIac2HIJfG0T0h0O6md8Jc4g4Ys6cKnxnvfSGCmPCVM/HesTx0QzMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghWWiPP5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736374685; x=1767910685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H2rjiwuBDH+v++VYQzOQXaoIqU6zYrlDWgNkO9LruCo=;
  b=ghWWiPP5WVtG0HdgklXp/A+7CnD5fXgBoCo4ZitPykO4noC9EEMR17fz
   9xsaK83/7CUMy8+xtOhWhzRUjQYTOT90enUZsgSl0ABGd124Y6yBnaTCw
   1Q5nGHSKUUebo6T28dv0vXspUFQP3VvzMZJsxX3ActFlnFU9mlDqGqF9I
   aA6c3FjL7Myw5hnYUqSYjV8UhM1biQa+tgHAzq6ZZje1SyAVuPjYxYoH9
   lFeL4oCmgxBx//MgPUmoNCQSX0HqqAWrtMya0LbrmO0MPtfbnUvfJJWr0
   kbiXC1SsCZE7QCHBkViuFix9uBSLhRudWzZRadhkrpBD7S3JnzbhN25Z1
   Q==;
X-CSE-ConnectionGUID: LNwRoyTITSu3I4Fg2MFclQ==
X-CSE-MsgGUID: hPPb0xuNQYyX+g/49tk6wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40384650"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40384650"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:18:03 -0800
X-CSE-ConnectionGUID: 3a6eUl3PTHCgoF/ggEv1lw==
X-CSE-MsgGUID: nS5jiP1yStazwCQazXwDFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140545114"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 08 Jan 2025 14:18:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 03/13] ice: minor: rename goto labels from err to unroll
Date: Wed,  8 Jan 2025 14:17:40 -0800
Message-ID: <20250108221753.2055987-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Clean up goto labels after previous commit, to conform to single naming
scheme in ice_probe() and ice_init_dev().

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5d7d4a66fbcd..7fd79482116f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4799,7 +4799,7 @@ int ice_init_dev(struct ice_pf *pf)
 	if (err) {
 		dev_err(dev, "ice_init_interrupt_scheme failed: %d\n", err);
 		err = -EIO;
-		goto err_init_interrupt_scheme;
+		goto unroll_pf_init;
 	}
 
 	/* In case of MSIX we are going to setup the misc vector right here
@@ -4810,14 +4810,14 @@ int ice_init_dev(struct ice_pf *pf)
 	err = ice_req_irq_msix_misc(pf);
 	if (err) {
 		dev_err(dev, "setup of misc vector failed: %d\n", err);
-		goto err_req_irq_msix_misc;
+		goto unroll_irq_scheme_init;
 	}
 
 	return 0;
 
-err_req_irq_msix_misc:
+unroll_irq_scheme_init:
 	ice_clear_interrupt_scheme(pf);
-err_init_interrupt_scheme:
+unroll_pf_init:
 	ice_deinit_pf(pf);
 	return err;
 }
@@ -5324,18 +5324,18 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	devl_lock(priv_to_devlink(pf));
 	err = ice_load(pf);
 	if (err)
-		goto err_load;
+		goto unroll_init;
 
 	err = ice_init_devlink(pf);
 	if (err)
-		goto err_init_devlink;
+		goto unroll_load;
 	devl_unlock(priv_to_devlink(pf));
 
 	return 0;
 
-err_init_devlink:
+unroll_load:
 	ice_unload(pf);
-err_load:
+unroll_init:
 	devl_unlock(priv_to_devlink(pf));
 	ice_deinit(pf);
 unroll_hw_init:
-- 
2.47.1


