Return-Path: <netdev+bounces-101153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE248FD7B1
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165E31F23C9F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76CE15FA69;
	Wed,  5 Jun 2024 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYeyE0aX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BD15F408
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620051; cv=none; b=SSCpKHNh7hGx8o/Y5obLAN8ScbrQwjGGmhZgXRwGPRAuWjX3d0vnpv4BqLuu18QcUtII+PPjEl+c33Upb13u0r++o2+Zcn0Ul4EtxtPwRi2JZCdZPbICULufUijnac3Q8mehUQu83yYKxFvFALW9HJp1jfmX4qpZxR6tRtgzJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620051; c=relaxed/simple;
	bh=EdspLI47a6CE1Xn4Ii0/m2F/9uaHZygxyEKNw3RB6HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0T97SAK+9w9ubtIaXXRmNeAhfEna6Fqlxl2CJRgZv6P+cOPTqHX8WTYPhv0zlAlcgI4WhccYIPZnW79w2br/HBcWOfQTK8xPm39Bd8asQRqQEmKQgEKrbj0TDRREom7Hr77dG/YHry2wxO5IHcmYtY4EsQlqnt1j568nuoXf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYeyE0aX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717620050; x=1749156050;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EdspLI47a6CE1Xn4Ii0/m2F/9uaHZygxyEKNw3RB6HE=;
  b=cYeyE0aXmssIeJu3IIVjLbXVd967pG9FjoUJN8nfvBMWQ/B7XYeUaiuJ
   s5EVDDhVHI9bKYiVrtvjGgeRU6s6jib7WFchZzyWKcgkkJbqyhzmz2Dr/
   bru1yy2nPJa4gnYOx4dtd+2ASYc6zDzx1O3ndtNfedyOqzdtwqt2YrK6i
   dELgS/j1LbLApviPyUQVquPcrg6MICWOJ3dNqNVVpKURsVNDG0MYcILZF
   Kirv2AyPVhjjq1r20H65wly7AWH3s6VoDh70ddUk1SWRza0+GDf9o9i+C
   C9WiqZrQf2ZhGMlQ+ibIwFW3yV/Q+NDvG0oEmYjXpp843DhAn4rZDdt5d
   A==;
X-CSE-ConnectionGUID: RKhh+hk/RKOkrX3AiGBRbQ==
X-CSE-MsgGUID: 9fVmFXbqSVqpvByGzyOeZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18103068"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="18103068"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:40:46 -0700
X-CSE-ConnectionGUID: TlKKZKIXSBCqNNIRjUZZ0A==
X-CSE-MsgGUID: 0euAE5BtTL6qKiQAGRWyQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37824326"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:40:46 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 05 Jun 2024 13:40:47 -0700
Subject: [PATCH v2 7/7] ice: use irq_update_affinity_hint()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-next-2024-06-03-intel-next-batch-v2-7-39c23963fa78@intel.com>
References: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
In-Reply-To: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
To: netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, 
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


