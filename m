Return-Path: <netdev+bounces-182108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A343A87DF6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654577A3579
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A0C27703C;
	Mon, 14 Apr 2025 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQD17jsl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1EF27604D
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627709; cv=none; b=huTxpi5tvpQZVGqVSNEeB+DzKAwXAuZFSBbhwNj+KbKlSuRX9o3VvRZsNJfyEj2auIdtH7Wpc5p5NFtjRy/IEo75ynWR72dySkhmE/encBvSdpOfayjOtPJZVFUpXkqxyIYTiY4gz2yys/qMge9zM57uLetA+59Jx+2hHqtDmnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627709; c=relaxed/simple;
	bh=9IwVWgo5udn4b2yOTlk4DNHB+R6yGbvF8aZSC4ElHzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgs+i2pI2mz5AMQpO41zlmao37Uo4OdKRSvcLGisNZocA8R6dyQJ0POuwlyhDfHDy0XhlpaM61tCZ1NkvjKv9fVhp5AynpLacp6qjkWxXK4T+sfEK64I4+Iaqi90lKeWzFxmRm6huE2amkOhUgQMuvKFLQBSPwARnUSgoSsPMNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQD17jsl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744627707; x=1776163707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9IwVWgo5udn4b2yOTlk4DNHB+R6yGbvF8aZSC4ElHzo=;
  b=KQD17jslLAu1S39IZIJT9bIUf/SjptakfuNm0i+xSh7aBRO+XP8+t/7W
   obCe7t5zEIge0hYRUvtqHhMNhIZqM7QOR1UXxMveY2EfPDDQe04ftD+//
   U34u1XZqJKL0OjU6jeWq7eKp1gNHoTJaW5fjTN4E+t0Nie7X7nnUhE5+Y
   /vKN6aClXhrZ0pNK13Tn/Tr/nYx9zK/aiVkTFz0K2W9dwFBEF+15+aTzQ
   02VI59c3IMGdty5Xe8HsOCrh6MTOYPq5o2gtwtaPCE1nAHMF6bmCkdAQb
   70Wf21aY+I/EIDRt6AmetPN2p/WN+BIcCO/KNDHgnEt3gZ0BcinPipDso
   Q==;
X-CSE-ConnectionGUID: xuBuEIklSGmhtkhODB9vwQ==
X-CSE-MsgGUID: nZeSElfzSVStnFgSOTKIUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="71478048"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="71478048"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 03:48:26 -0700
X-CSE-ConnectionGUID: YIeEAv/kQ8GnErhcsDF3+A==
X-CSE-MsgGUID: LfwY9bZkRQS7RzzfXtWmnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="160739772"
Received: from gklab-003-014.igk.intel.com ([10.211.116.96])
  by orviesa002.jf.intel.com with ESMTP; 14 Apr 2025 03:48:25 -0700
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v11 iwl-next 01/11] idpf: change the method for mailbox workqueue allocation
Date: Mon, 14 Apr 2025 12:45:07 +0200
Message-ID: <20250414104658.14706-3-milena.olech@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414104658.14706-1-milena.olech@intel.com>
References: <20250414104658.14706-1-milena.olech@intel.com>
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index bec4a02c5373..1284ab2adaf1 100644
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
2.43.5


