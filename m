Return-Path: <netdev+bounces-159289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F693A14F92
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A6A168743
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BD41FF61B;
	Fri, 17 Jan 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U35uVHrK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C92EAE5
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117943; cv=none; b=JRQvwS+AsuXzvEwsIh4m5Bv+K0+i5ddYBo3sCK/TuHMarOqIA6Im3ou5Xyx9iO9IHuekdcLWp6tSkjksYieKARoSVy/F9JONi0hryMvXQ5ynF6mjAo3pi0WPswWXIdxCp9yCi7UsM+3ksFvsqZ8evsxK0zu0p7sIX9NiKlWTQEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117943; c=relaxed/simple;
	bh=lO44xu74L9hP8teUnj4QEYpRhlSZ+ynqWFZz1/lGBeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K5mOTUNW4QTL1sR63jHQvrksm1SMtmlrhMjxzMok6i4nMoD+tv3reg0oCpVCpg31FTRHY8+qBuHVkyKxovC8llWwjb1+TQl1mM4AMV7d4r2ez3wUGZQ1jnz+fOEnL/6qddrjdGxc95mIJrPSpIV+FXtTTDaadUC5pgVdurkaIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U35uVHrK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737117942; x=1768653942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lO44xu74L9hP8teUnj4QEYpRhlSZ+ynqWFZz1/lGBeM=;
  b=U35uVHrKdTnAORZEbq3AghWfzgJgh4n+BdYjidVW0GsoZ2k6gvS6CplM
   ag7YOKGEqex5UMRkTDyOjwMLuJtBBkL/DNnf/ePkLirfSIJzg0VVWSKK+
   mkOD00rKbZ9z4i0TVEONWqUOx6BwXlpLxiuz1DuhCXdL4tQhyayDhaSBq
   YzKoQ1wTsTPDSo02/T9yuHy727q56we8oasyrUgAYqkN7BPfSwtxtSUqs
   LDcuQhTsJXoo0DqZ1ee6pRYgyLwXsXKZF8+QkfTssudslyyH20U/RFsCa
   0NbjdoFYbgzPQKZSmGYLn2mdUpU8S0a8EnW9fGoQ20zblRSHuoXLtxDYs
   Q==;
X-CSE-ConnectionGUID: rgmT8Xk9SwyjCJH30z9DDg==
X-CSE-MsgGUID: nwSaZ06LR1WIL7jOSRs+Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37431254"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="37431254"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 04:45:42 -0800
X-CSE-ConnectionGUID: w5ahOcPVSbO3p87VkUzOOA==
X-CSE-MsgGUID: PxT6/IYlSLyKp6OTF/7L1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136681921"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by fmviesa001.fm.intel.com with ESMTP; 17 Jan 2025 04:45:40 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v5 iwl-next 10/10] idpf: change the method for mailbox workqueue allocation
Date: Fri, 17 Jan 2025 13:41:21 +0100
Message-Id: <20250117124109.967889-11-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250117124109.967889-1-milena.olech@intel.com>
References: <20250117124109.967889-1-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since workqueues are created per CPU, the works scheduled to this
workqueues are run on the CPU they were assigned. It may result in
overloaded CPU that is not able to handle virtchnl messages in
relatively short time. Allocating workqueue with WQ_UNBOUND and
WQ_HIGHPRI flags allows scheduler to queue virtchl messages on less loaded
CPUs, what eliminates delays.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 85c65c2145f7..66f9e4633e3a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -222,9 +222,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_serv_wq_alloc;
 	}
 
-	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx",
-					  WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
-					  dev_driver_string(dev),
+	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", WQ_UNBOUND | WQ_HIGHPRI,
+					  0, dev_driver_string(dev),
 					  dev_name(dev));
 	if (!adapter->mbx_wq) {
 		dev_err(dev, "Failed to allocate mailbox workqueue\n");
-- 
2.31.1


