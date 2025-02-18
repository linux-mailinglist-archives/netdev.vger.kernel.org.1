Return-Path: <netdev+bounces-167441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 142B8A3A498
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D4D188A283
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06826FDAD;
	Tue, 18 Feb 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="go4Ql9AB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893B26B975
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900849; cv=none; b=ptiLDndJ2TbxszA0sm//XfrHO5iJXmdJvIwLE26aydhWYSi78EAu0G03PWUj3re+wOG7ght8iAgR6OR67Q5ILZe28Fs+vkQqaN7nOj3/AX2GLhMHGbAk8a7zQ+8AHiQeAKLDE1N4hgXLnBaDpcm70bTBzu1Mt7wPJ/GWeRZEVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900849; c=relaxed/simple;
	bh=N77XQ5Q5mO4PoQ6m80+S+vewn+DOxv1GOBJVib08tpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6fCI40Es1VlB26d+b68vtl0Jk9K9Hbql05LyYZBnA5AwFMKwCrdy474RSSuYcVHbWKxB935boi3OiT49eZywc7YrDN43DK6tKM1JecA24ax/bu1AfhbmcV24wlUY3Ht5mOAmBuLgjML/+nusWTRMbQNmHlh5AT3cNn92VumGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=go4Ql9AB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739900848; x=1771436848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N77XQ5Q5mO4PoQ6m80+S+vewn+DOxv1GOBJVib08tpY=;
  b=go4Ql9AB0PGrZVWLdI3ABe9NB5IlAWYCwOKEjLHmDXTSoiI9B5LxuC74
   2UcBY6vZy6bMRAqFY4eJWQXlm/UO1kJavdrm83VBBHpLuihSRVsnTYRwz
   EdHEKEFM4WZ+g9g8SuRRiOyB02krT7U2x+IONX09roUlnkhAmtqdlUZG8
   mjhUNIePv/nRNRdbuIaMEnGOGSBETv5T/qPmRQHzCWug83ZM8pMgd+ztc
   BwI1qxwJ6hrKjXw35JPm15mnOyxtGwhLy/Uh/j7tpZMWAqG8LqVHbF+ZZ
   X0SbbchCkVf1hQyAT6LrELqG5jiCDTL8KQ79ex6hrpjDdRer3+Y86e3DQ
   Q==;
X-CSE-ConnectionGUID: FebntgmIRJWlUycDhgk9ww==
X-CSE-MsgGUID: caik0tk6T0eKy4R8tKdnkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44368502"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="44368502"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 09:47:28 -0800
X-CSE-ConnectionGUID: bI+yRe0sRZ6TvppdCpo8kw==
X-CSE-MsgGUID: ahusy2nzQMGJcZQP9+ekJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119396148"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa003.jf.intel.com with ESMTP; 18 Feb 2025 09:47:26 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v7 iwl-next 10/10] idpf: change the method for mailbox workqueue allocation
Date: Tue, 18 Feb 2025 18:42:37 +0100
Message-Id: <20250218174221.2291673-11-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250218174221.2291673-1-milena.olech@intel.com>
References: <20250218174221.2291673-1-milena.olech@intel.com>
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


