Return-Path: <netdev+bounces-100396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB718FA5D8
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276A51F240F2
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 22:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736781411F9;
	Mon,  3 Jun 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/Dtqyvo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A281411C1
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454309; cv=none; b=osw8YzCSkF6jHAqWOGDgVqEg+kVa4QOJ57QRD938h9HvgburkPjVQsinGfNR+0hVpQ7IhWEbIKBp8MrANTHv0oQjZIGqJcHD7kjcOawFHlyzaArZ1h6F8QkNoFY3KkIx/S1fOIyW9Fsx2LbUgSl7oaW/L5u4b9LZ/vdm52d+6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454309; c=relaxed/simple;
	bh=EdspLI47a6CE1Xn4Ii0/m2F/9uaHZygxyEKNw3RB6HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mQFGcFbsXRBxUAuF8aiXPWswzT5EsIa/3ww8Wqif6E/9pJ5SqkASyxWglsrL0jSJE437YSXQ+XrGpoO2Luwk6qEVv8Vcpury833Vy2hU3aHaZ0qytevvnKVRj1VIhdtydeHPl0THNmkuiVAlBbO+3qM8UJEqRc8MiHqp84W1Kg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/Dtqyvo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717454308; x=1748990308;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EdspLI47a6CE1Xn4Ii0/m2F/9uaHZygxyEKNw3RB6HE=;
  b=U/DtqyvoaseMmfEm6SvB3ETTCXJERLK43Ter8CDt0aAfTSoP+w4OLBeP
   2qs7p8YTWGhDmCspgvPyYCTGqCNRgZu2qIep2UVc1ZHmaYxoZNjApyMbC
   d/vWiwUCLl5Y/v3joh0BWE/xkWsGPaesgWzqjy/fIzASuNfb4YqjTCWtq
   U8yYLDbWtR2gpvLslFF3b+N0KLw1qi14vyyoQn3UlfHx01CVsrQNqcLNa
   V0k9Pu3febALnVYZhmdh4ScFHJS19/bh94mslGB59J1fMjKmP5MkVcoUS
   p6uE0mEG93wYr8aYGDvs83iUlksBfK1CLD06rSx603YTPbXUYAP1tyWvu
   A==;
X-CSE-ConnectionGUID: tO8btnTCTk67KX7NApcUNA==
X-CSE-MsgGUID: s4mwhm0USLutrXKYEJsWQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13780126"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="13780126"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:22 -0700
X-CSE-ConnectionGUID: YgQPV1SwRZ+GHhKpp1S2sA==
X-CSE-MsgGUID: 6Py0WW6fQYCT5XfFx/eflg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41471200"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:22 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Jun 2024 15:38:19 -0700
Subject: [PATCH 7/9] ice: use irq_update_affinity_hint()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-next-2024-06-03-intel-next-batch-v1-7-e0523b28f325@intel.com>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
In-Reply-To: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
To: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Schmidt <mschmidt@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

From: Michal Schmidt <mschmidt@redhat.com>

irq_set_affinity_hint() is deprecated. Use irq_update_affinity_hint()
instead. This removes the side-effect of actually applying the affinity.

The driver does not really need to worry about spreading its IRQs across
CPUs. The core code already takes care of that.
On the contrary, when the driver applies affinities by itself, it breaks
the users' expectations:
 1. The user configures irqbalance with IRQBALANCE_BANNED_CPULIST in
    order to prevent IRQs from being moved to certain CPUs that run a
    real-time workload.
 2. ice reconfigures VSIs at runtime due to a MIB change
    (ice_dcb_process_lldp_set_mib_change). Reopening a VSI resets the
    affinity in ice_vsi_req_irq_msix().
 3. ice has no idea about irqbalance's config, so it may move an IRQ to
    a banned CPU. The real-time workload suffers unacceptable latency.

I am not sure if updating the affinity hints is at all useful, because
irqbalance ignores them since 2016 ([1]), but at least it's harmless.

This ice change is similar to i40e commit d34c54d1739c ("i40e: Use
irq_update_affinity_hint()").

[1] https://github.com/Irqbalance/irqbalance/commit/dcc411e7bfdd

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Sunil Goutham <sgoutham@marvell.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5371e91f6bbb..0f8b622db2b5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2587,8 +2587,8 @@ void ice_vsi_free_irq(struct ice_vsi *vsi)
 		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
 			irq_set_affinity_notifier(irq_num, NULL);
 
-		/* clear the affinity_mask in the IRQ descriptor */
-		irq_set_affinity_hint(irq_num, NULL);
+		/* clear the affinity_hint in the IRQ descriptor */
+		irq_update_affinity_hint(irq_num, NULL);
 		synchronize_irq(irq_num);
 		devm_free_irq(ice_pf_to_dev(pf), irq_num, vsi->q_vectors[i]);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f60c022f7960..a5d369b8fed5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2607,7 +2607,7 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 		}
 
 		/* assign the mask for this irq */
-		irq_set_affinity_hint(irq_num, &q_vector->affinity_mask);
+		irq_update_affinity_hint(irq_num, &q_vector->affinity_mask);
 	}
 
 	err = ice_set_cpu_rx_rmap(vsi);
@@ -2625,7 +2625,7 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 		irq_num = vsi->q_vectors[vector]->irq.virq;
 		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
 			irq_set_affinity_notifier(irq_num, NULL);
-		irq_set_affinity_hint(irq_num, NULL);
+		irq_update_affinity_hint(irq_num, NULL);
 		devm_free_irq(dev, irq_num, &vsi->q_vectors[vector]);
 	}
 	return err;

-- 
2.44.0.53.g0f9d4d28b7e6


