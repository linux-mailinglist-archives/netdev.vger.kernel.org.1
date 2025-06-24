Return-Path: <netdev+bounces-200690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6603FAE68D0
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F676A3525
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2735C2D29B7;
	Tue, 24 Jun 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Djd+NzIq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486212D131D
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775257; cv=none; b=qiACoGI/9QkDj1pBvu9V48jyBEbtLS/1SrLKw7ICXhI/8NQs6dtDNakGIUZ6SVtf702PWIj52QagZKhQv1iIk9v4ZwSuAUGdoyGw6QwBPqwXq4iGU4ApYh9djF6PI/2KKShKfT3Eg38sg8EJPf6hHaZ1f2QXPapI4Q8xTtnl+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775257; c=relaxed/simple;
	bh=pMVZuMp81uJ7pEBtzL1PGYWRrDHY2p+u4Dzw0rMjW6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rJfXD3jticmuNc7E/TTzw4Bo5O0pTR3hxD/FCKS8iAKQqxfCh0IrOHHr7oLlL/z1CE8hCgs2jEwJtzg9JlmJ6UxKjDvcYs8QQlnt/zPxgI45h6ijQJ5odXstenCm5L43/CS+BWyRtLS4z3Y84ZQjVUknm6UI4lRw1nPUFgM76wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Djd+NzIq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750775255; x=1782311255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pMVZuMp81uJ7pEBtzL1PGYWRrDHY2p+u4Dzw0rMjW6c=;
  b=Djd+NzIq/fGxSjQ7Xmwo4AEXk6/n2nGHnf+hjgT8yuHIROcKyWypGaOP
   OkjvvswYAZYpwzZCTfl9VojvWolUqkMDuoWxu4RAxmL3R0QdBy8zIIWCc
   bsm2adOlc9QV76amm+kb0JdX5VOrurUFuzaTGRWZO9vJ70xO4iA2u/eUm
   SRIpX4Qq/5StgiYiV/MqTlcq/wvUinRv4V/FFwSGIQDwo0+odnHWMfYVv
   MRckaHBU9Nfb5v8mmsZk6TVUMg7OOgWW9BFK8tSXrVyxPF13ljvPS2HPi
   SUGWJX4v1YX/Cn+xQT18TefhfDQsbBO2bx8yfDb/80j+INIkvHnkyfhub
   A==;
X-CSE-ConnectionGUID: JK26hDPiSd2UKyhKLdVn1g==
X-CSE-MsgGUID: TJmSVHO7SsK8vv/CxB9mwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="70441043"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="70441043"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:27:32 -0700
X-CSE-ConnectionGUID: NS39t5JmSteAzcSN/VsMGg==
X-CSE-MsgGUID: 6ZcSDeVRRHuTjO8Ox5u3Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="155965570"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jun 2025 07:27:31 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	david.m.ertman@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH iwl-net 2/2] ice: fix possible leak in ice_plug_aux_dev() error path
Date: Tue, 24 Jun 2025 07:26:41 -0700
Message-Id: <20250624142641.7010-3-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20250624142641.7010-1-emil.s.tantilov@intel.com>
References: <20250624142641.7010-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Fix a memory leak in the error path where kfree(iadev) was not called
following an error in auxiliary_device_add().

Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_idc.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 420d45c2558b..8c4a3dc22a7c 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -322,16 +322,12 @@ int ice_plug_aux_dev(struct ice_pf *pf)
 		"roce" : "iwarp";
 
 	ret = auxiliary_device_init(adev);
-	if (ret) {
-		kfree(iadev);
-		return ret;
-	}
+	if (ret)
+		goto free_iadev;
 
 	ret = auxiliary_device_add(adev);
-	if (ret) {
-		auxiliary_device_uninit(adev);
-		return ret;
-	}
+	if (ret)
+		goto aux_dev_uninit;
 
 	mutex_lock(&pf->adev_mutex);
 	cdev->adev = adev;
@@ -339,6 +335,13 @@ int ice_plug_aux_dev(struct ice_pf *pf)
 	set_bit(ICE_FLAG_AUX_DEV_CREATED, pf->flags);
 
 	return 0;
+
+aux_dev_uninit:
+	auxiliary_device_uninit(adev);
+free_iadev:
+	kfree(iadev);
+
+	return ret;
 }
 
 /* ice_unplug_aux_dev - unregister and free AUX device
-- 
2.37.3


