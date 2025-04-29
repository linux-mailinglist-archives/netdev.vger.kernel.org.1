Return-Path: <netdev+bounces-186871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0765AA3B08
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D2A1BC4899
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0910227055F;
	Tue, 29 Apr 2025 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mytpMI6c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594F26A098
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964641; cv=none; b=emdK5zlqjLch8AQpNbmuCHTLfhfm8Xxc7IW9iR4HoGeZg76qHZ8414Lx8K0kF8XOQ2LKxMBs0IU206KBwE1e4orlLnsz1uXtbRaQE13PdB3PJ40pBq71kOQWRMw6epsnZjTbm3r1E3Rssx36lV5l9lDcbPQH2Mhe7MK/h41HzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964641; c=relaxed/simple;
	bh=mZx28ntK+B0ntG4gaTgyi46oO7IgAkRfrm4xIfPPd1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKKASLcF06nq7M/TnHF+Nl/oX2HfSUVZbPNRylNEIJF5Tq5F4/G4jdSdbFrG5eGsOv2ENesc7BYWU0OU7eneYyTRVhmml1rfUrVOrwpPyiqaIqVyyqb3vAbFiyMvZueMy+pPRIj3HZ6PP47Ff6s/C7q0FQW/yFuucr8q+qOl28U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mytpMI6c; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745964640; x=1777500640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mZx28ntK+B0ntG4gaTgyi46oO7IgAkRfrm4xIfPPd1A=;
  b=mytpMI6cR0/Y6Irx5sOTZUnQELeOZbShBm5aKr2qDBOq2LolQnX50ab/
   I9kLFn4cmFTvOFnHe6CSxCDxGaTBvubNylnbtNBHehp2vgG0r9q9QqIo9
   D/Lc+kYZC6/5PS98JrS8H+O6X07macoP1qKfPI7UFj6ZkM3JoHgQ0nUv3
   i3BFOYnoRp2tyf+Xjqh/W/XYZW9tJmdmRGDRKZz7mYIrQ2foTkwO5m6+N
   XcyJ61aDlWKTvBK75G4AKxOoAfUO4mAJxsX+FPqQ+dKDfJi4aKfQb59Rp
   tb/S/O19DlI8pEmW8gER+XUGMhQf4oCKvj80/DvFGBUTPLoGjy9oq/5g1
   Q==;
X-CSE-ConnectionGUID: Q8K+l74sSUGmQH25DBPvYA==
X-CSE-MsgGUID: Lj5q55CtTCGPdViNBs+Mbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47620120"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="47620120"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 15:10:37 -0700
X-CSE-ConnectionGUID: hmuQL8rXROChaKUC5IY4vg==
X-CSE-MsgGUID: lPjZNqtuS7G25uiNgNjEWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="138750758"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 29 Apr 2025 15:10:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 1/3] idpf: fix potential memory leak on kcalloc() failure
Date: Tue, 29 Apr 2025 15:10:31 -0700
Message-ID: <20250429221034.3909139-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429221034.3909139-1-anthony.l.nguyen@intel.com>
References: <20250429221034.3909139-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

In case of failing on rss_data->rss_key allocation the function is
freeing vport without freeing earlier allocated q_vector_idxs. Fix it.

Move from freeing in error branch to goto scheme.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Suggested-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 730a9c7a59f2..82f09b4030bc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1113,11 +1113,9 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 
 	num_max_q = max(max_q->max_txq, max_q->max_rxq);
 	vport->q_vector_idxs = kcalloc(num_max_q, sizeof(u16), GFP_KERNEL);
-	if (!vport->q_vector_idxs) {
-		kfree(vport);
+	if (!vport->q_vector_idxs)
+		goto free_vport;
 
-		return NULL;
-	}
 	idpf_vport_init(vport, max_q);
 
 	/* This alloc is done separate from the LUT because it's not strictly
@@ -1127,11 +1125,9 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	 */
 	rss_data = &adapter->vport_config[idx]->user_config.rss_data;
 	rss_data->rss_key = kzalloc(rss_data->rss_key_size, GFP_KERNEL);
-	if (!rss_data->rss_key) {
-		kfree(vport);
+	if (!rss_data->rss_key)
+		goto free_vector_idxs;
 
-		return NULL;
-	}
 	/* Initialize default rss key */
 	netdev_rss_key_fill((void *)rss_data->rss_key, rss_data->rss_key_size);
 
@@ -1144,6 +1140,13 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	adapter->next_vport = idpf_get_free_slot(adapter);
 
 	return vport;
+
+free_vector_idxs:
+	kfree(vport->q_vector_idxs);
+free_vport:
+	kfree(vport);
+
+	return NULL;
 }
 
 /**
-- 
2.47.1


