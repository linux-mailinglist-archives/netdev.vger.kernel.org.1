Return-Path: <netdev+bounces-144482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDF19C78BB
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC4BB3E8A8
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7FB7083B;
	Wed, 13 Nov 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAoK1ORO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF21632F2
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512974; cv=none; b=Icf2GAVPLvVOzJD7xWeXU0G9zqUotPT8oP6K/p1unapQ5ZJXGZI5J/NC6QN4P46DrrFg9OuxqpZaiRonbQm/KuxI1fPSUzrM84h8y4I7jjQ8MJAn5bNA0CUtrImJq8fQgUdstEqGogw3zC4LTJgOC/Mm8NNiX5hiCsFykigSupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512974; c=relaxed/simple;
	bh=rL0Rj5BohAoFW1JXrmppR3BKs8WOPEHIQVuBaPVC7kU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shGf+w6H+EChCQHE99/gvDCr6po1D7KNQeYzFqjDlttr3DvjU6U0NTpYkjDvpfksxxuU8VyhAS5K8ZJ5Q+5XsTjF5M/krxqzRT429pj9TUeO27qCAnMch+lndU6CQos6H/Pzjgi4vUeNHSpuf9WVRXD6z6GFAre+uNNjX6QH7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAoK1ORO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731512972; x=1763048972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rL0Rj5BohAoFW1JXrmppR3BKs8WOPEHIQVuBaPVC7kU=;
  b=UAoK1OROGxK6xBtwmLvIrk7i2B3RyghFuvivINciRM4TsuQCmxQIZh7t
   fc/owI1Y+tAC6iHj18cKjg2eD14XO6Po6TN9PjUtk0r11BZ4Y9ZfpOasd
   fdeGIMl8S4Nbg+CDbP7Rw9cNUaE9GDacowjMhRx9QKA9y30+O65Dtreys
   nwajlsGcqp4nWLcAXpOPkcgnT3ZXdsWktNfa6nV00pFs3Of2u+gFaFXJX
   HdHkVXnj+EQ5RJKFvdYXQL6/MAdjukvsi9axsoJERXdezczToQzNHFrpg
   cD+bg85Bxge6I7WHrdBPn3Ee6+3v9mv4szSnti0OCpTVQYfSS71Ejze9r
   g==;
X-CSE-ConnectionGUID: QUbcfwQRRjupa9D4cT8sCA==
X-CSE-MsgGUID: GfwBPOoQSpWzUbotBghIGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="48919108"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="48919108"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:49:32 -0800
X-CSE-ConnectionGUID: BnI3RWUpQxu+9MHlN9r2uQ==
X-CSE-MsgGUID: niPavKQcQ6ODjmWInptQlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="92869407"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa005.jf.intel.com with ESMTP; 13 Nov 2024 07:49:31 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH iwl-net 10/10] idpf: change the method for mailbox workqueue allocation
Date: Wed, 13 Nov 2024 16:46:25 +0100
Message-Id: <20241113154616.2493297-11-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241113154616.2493297-1-milena.olech@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
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
 drivers/net/ethernet/intel/idpf/idpf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 22d9e2646444..31fe3e4b8162 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -196,8 +196,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_serv_wq_alloc;
 	}
 
-	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", 0, 0,
-					  dev_driver_string(dev),
+	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", WQ_UNBOUND | WQ_HIGHPRI,
+					  0, dev_driver_string(dev),
 					  dev_name(dev));
 	if (!adapter->mbx_wq) {
 		dev_err(dev, "Failed to allocate mailbox workqueue\n");
-- 
2.31.1


