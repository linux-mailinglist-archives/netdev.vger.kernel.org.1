Return-Path: <netdev+bounces-167296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086E7A39A26
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6D73B48DE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D523C8A3;
	Tue, 18 Feb 2025 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFLP61vb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C723BF96
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877135; cv=none; b=UZcF6yctVJ2ml7NYkHi5bYM8CCU8DKEiMvwFMSiL0+WKJzGto7DLJUMKebU+NPHmarM3ilFHuU/n0qSuOZ+X2e56x+lLP4G9dQDxgpmUywXw8WXn59wZ5d4tupg3ZWOW4VcCXLneXVM9LBwI80apy7PuIAv1jW3Jd9Ybo5c8BFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877135; c=relaxed/simple;
	bh=N77XQ5Q5mO4PoQ6m80+S+vewn+DOxv1GOBJVib08tpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwYvusLmRSQpuBlqEJ30/zMlv7W+B8782OgS+O1p7/8VENxAkyYQHvkO7bFPq74OOTAPEObB/GQktlqVA6B4mutDJ6E4RNZrDskzhkEUQnxjuqABCTrq7UKkNRFiu1OF1FjyLVkl+B5RvvWEYKHGE2GI8oeQ0S3UEtmHPXisq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFLP61vb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739877133; x=1771413133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N77XQ5Q5mO4PoQ6m80+S+vewn+DOxv1GOBJVib08tpY=;
  b=oFLP61vbmdRwNS0SDyyXWGi0ZWzc1VgBtIHpmFNVvWxDvLWblzjNVFeG
   EJyC7+Vuj89MSJZ+Ng1kDH5Yvc/tvFEtrtkGIxK3Sjck1/u11dACEhCPj
   8WE1EtfZqJkphv0Yurbge+Rvg+VL5nVA0TUL2dEfsEzqBebxRk6Lfu7cZ
   hHg7dYK3AW9DHCqyr+BE5NTEHEFfXQl6bre6RFxmF+jGTOGc6OIUD90tx
   PtPnz79nSC/Kjcji0lzW91fshtinw+IWfa/LWJ8Y3nRUysZK/ss3o4pfa
   0JnPcH17yo62fDiKKMhgr0yoo4uUrvskdC1BuJs/Tzo4yPLFvJKVjdP8E
   g==;
X-CSE-ConnectionGUID: MZ35P5kyRvqbPu96jZ/u1A==
X-CSE-MsgGUID: HOi5uw9+TDeCZOMxeM3xmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51208308"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="51208308"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 03:12:13 -0800
X-CSE-ConnectionGUID: cR29wDLgR4SeDV0DtzKc4Q==
X-CSE-MsgGUID: Wkpk2dCkTWWvw6oD1l3CQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114234023"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa010.jf.intel.com with ESMTP; 18 Feb 2025 03:12:11 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v6 iwl-next 10/10] idpf: change the method for mailbox workqueue allocation
Date: Tue, 18 Feb 2025 12:07:37 +0100
Message-Id: <20250218110724.2263357-11-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250218110724.2263357-1-milena.olech@intel.com>
References: <20250218110724.2263357-1-milena.olech@intel.com>
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
index 60bae3081035..022645f4fa9c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -198,9 +198,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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


