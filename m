Return-Path: <netdev+bounces-221557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BAEB50D9F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438241882F18
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 06:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901F0303A07;
	Wed, 10 Sep 2025 06:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jy6xy7XY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CEF3019C1
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484075; cv=none; b=UMn0QT+g6cq/UOwj612avFcsPJNLV54DKK41dieQe4kPgM0efkcQQMtvb9PuGA8Z3PH2hs9QtoTSjMoHD+wutamxVa/2KC/r0GQfk9Z8H2kN+XMz9HX68pbEEx/Byvf+gKtZM1GAiKsyWm4ZgqE68zKYl8a2zqIBr3g+W3JBYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484075; c=relaxed/simple;
	bh=grZ8xIw2oQRi1EBEOlVcofDCDFihthbxv3v/v65+s3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGqsey/5kounT0Ztwro1P/VzYuM0PC3pCmdYh7dyLWJBItdh6VxFvww6OEZ6htmVgBZiNUgy/6y2pcuFP983A4N/TeL5dSKKEQ7IKRKL6k0lYx/Il6MG6ppwpqfoFgDQ9iaPFZalenxiN8rvs9Dvyy5twSYgT1JvvPgKv+lcj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jy6xy7XY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757484074; x=1789020074;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=grZ8xIw2oQRi1EBEOlVcofDCDFihthbxv3v/v65+s3w=;
  b=jy6xy7XYbqSjcscW1MNnV/T1cXPSxhNIs2zjA7xQ12m4q4JpwyEnPMIj
   ome9H1PjrHt7JdqyYiVUgJGqSJxJ6Qgz5lZndyEyk+DSEct3hspM4AHGy
   4cl/oNd2Wwokjj0MxDEV3JfW2F7PFEptFRW6sOG6DbYrB2+tUIIGp0XHS
   X6xr/OiGjIDMYHqQ1qzW0r60w5+e5HYVTGzx5yhfdDlftHEqFBEp2Iie7
   H+2R1jupPvpAHunx6sWo7d9P26DdJyulCgqOyIaeLnZht4wqLEUdg0Dcb
   TAGRDDjvPn0UA/RCyL47khq3NQjrgIJXr7ln49VQ/arx+sYK3ao3x4TAy
   A==;
X-CSE-ConnectionGUID: Y1KsQTbaSHerMvPIZsSjuA==
X-CSE-MsgGUID: yNoR9PI4QM6ddgc/F4drEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="70474134"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="70474134"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 23:01:14 -0700
X-CSE-ConnectionGUID: ZP8buqKkTbuXwhpefTcIuA==
X-CSE-MsgGUID: MFBcrFZKSbat0SbSseOGAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="204058044"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2025 23:01:10 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v1] ixgbevf: fix proper type for error code in ixgbevf_resume()
Date: Wed, 10 Sep 2025 06:01:08 +0000
Message-ID: <20250910060108.126427-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable 'err' in ixgbevf_resume() is used to store the return value
of different functions, which return an int. Currently, 'err' is
declared as u32, which is semantically incorrect and misleading.

In the Linux kernel, u32 is typically reserved for fixed-width data
used in hardware interfaces or protocol structures. Using it for a
generic error code may confuse reviewers or developers into thinking
the value is hardware-related or size-constrained.

Replace u32 with int to reflect the actual usage and improve code
clarity and semantic correctness.

No functional change.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 535d0f7..28e2564 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4323,7 +4323,7 @@ static int ixgbevf_resume(struct device *dev_d)
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
-	u32 err;
+	int err;
 
 	adapter->hw.hw_addr = adapter->io_addr;
 	smp_mb__before_atomic();
-- 
2.49.0


