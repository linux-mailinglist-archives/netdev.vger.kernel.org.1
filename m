Return-Path: <netdev+bounces-178702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A36A78544
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 01:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E6216D45E
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 23:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEDF21CC5F;
	Tue,  1 Apr 2025 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGU6K6fB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40F21B9CF
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743550571; cv=none; b=gyLYTTml1JCs8hffutUym5yUor9CQyP6T5FoK30UvpdcCOdSKOZe+hvr3D9s9q8Nyt82u1dS/LiTRNC0aF8Ra1+ehDOZmxSTRfCITDwWJ7f8Ci0ZSbAkeyzP+dBxD5lnxi783jY05kO72ZBkMqKI5dwVu6Tsu88SlyqZa3NdNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743550571; c=relaxed/simple;
	bh=r9elFfmdNnFOLsoFRTnfW3g1ifqPmYejRjnzaCtqkus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UglVLJVKiE4qucly0EFkAoN+uhObXijoxE49q+k8IxtqyVtF6a+DTemMaJ+KKeR1BM9nvCQiRea1TFcF4FcuGmwqZu6ny4pBPlXu+rouSsFC5qESfdUUmwf5e31bfiGQYSuOURZcMpmDv44QM0NxFc1LwJuhIx5vltL+o7ijxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGU6K6fB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743550569; x=1775086569;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=r9elFfmdNnFOLsoFRTnfW3g1ifqPmYejRjnzaCtqkus=;
  b=EGU6K6fBCuhrBim92BzCR20ZrmMDvKw1W2txNV/VE7Ghyt7J9ZpbftiV
   O36YlhDYXaNOVprLkgjv8Xt93dkQlxnrrfNh41XCgZ5UGnIz5oZi1MNbY
   xcASAtW2dLFL31GwzOu+SX2wbUwmBeTOAYEXmwQAeIzXwnhWhyVH4znyH
   Y0xdtE3V9qY2s9nGAioWph4smwzc4l4NBIibtpfXWTji8gcZVYjxfVjGo
   u5gkUph1w3GgnJ59iW1eMrpmDdNorSKectefBGmkeCe3k3voNA4q64kAv
   X77dQk8lb/HZ/SIJBoGQDCD0RCXkn6tL9jjU7dvyTCrmENYjbNv4Wy85X
   A==;
X-CSE-ConnectionGUID: tnnXOY/dSZqEQkSs27e+pw==
X-CSE-MsgGUID: hRdyKWlJT8CXDRCxWV47Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55527613"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="55527613"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:36:07 -0700
X-CSE-ConnectionGUID: s5hdVtKyQfmYF/5EH5sS7A==
X-CSE-MsgGUID: WmeZcmdITWq06w3QfFK5zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="127354858"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:36:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 01 Apr 2025 16:35:33 -0700
Subject: [PATCH iwl-net v4 5/6] igc: cleanup PTP module if probe fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-jk-igc-ptm-fixes-v4-v4-5-c0efb82bbf85@intel.com>
References: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
In-Reply-To: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: david.zage@intel.com, vinicius.gomes@intel.com, 
 rodrigo.cadore@l-acoustics.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Christopher S M Hall <christopher.s.hall@intel.com>, 
 Corinna Vinschen <vinschen@redhat.com>
X-Mailer: b4 0.14.2

From: Christopher S M Hall <christopher.s.hall@intel.com>

Make sure that the PTP module is cleaned up if the igc_probe() fails by
calling igc_ptp_stop() on exit.

Fixes: d89f88419f99 ("igc: Add skeletal frame for Intel(R) 2.5G Ethernet Controller support")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
Reviewed-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 491d942cefca7add260a76b06aea9d2e2a9e4cce..e62d76e857c7d7d3197014d90902a1abad4ee497 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7231,6 +7231,7 @@ static int igc_probe(struct pci_dev *pdev,
 
 err_register:
 	igc_release_hw_control(adapter);
+	igc_ptp_stop(adapter);
 err_eeprom:
 	if (!igc_check_reset_block(hw))
 		igc_reset_phy(hw);

-- 
2.48.1.397.gec9d649cc640


