Return-Path: <netdev+bounces-245235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA09CC9712
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 20:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8A7E3062917
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF452F12B7;
	Wed, 17 Dec 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dthkBWts"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9602F3C22
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001004; cv=none; b=TkAN2mPUFj7Wooj8SXU4zA9PRtCnj6NeQqxzgQidpyLT8NOIIpVt8AVkejfUaf5+VuLZUkn2wc6I5e+NPTgCDjzA/ieMynFokKsuhTb7Qx+xE0zw2R/VXZqmXWN34f7OcgLmPig8e7HliXtRU/5ejiFLkeF0A4BF97B3A3yxE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001004; c=relaxed/simple;
	bh=Rnzn8uHp8Vb2LRNCtlCCRsFIchlby8Rs1Nvc5BkUMOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xp3by9EiiO2zU9BQnp1vJGcbMNn6aY3JGjNgWNXq8p45ScwyTHQrDzctBInl8PfhT8Ajkh6HRRsUySV4MG6bd0dLg1As0OB0niUh+5vUb6Ka/Xpj6K9RjET3qDv14iKRcRnJ6dOqBUrPW8kcNp41wIkOxuHfeBES1HjFs8owcMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dthkBWts; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766001003; x=1797537003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rnzn8uHp8Vb2LRNCtlCCRsFIchlby8Rs1Nvc5BkUMOo=;
  b=dthkBWtszUKo7J6nw9tbhVMji5NKkSdJSRjwT0XouN/yj0LywNO0Ql/B
   7Qrf4CoFoRpBrRnV8RT4/+fl7mdXTQjcJynrqAqtQrdgl2LN4GmCn8XD4
   ZzELGBwm5rFf5/PDk1k+lOXqZ3vkCLIgJLXRZx7uz9CVr/QqcLl7yYDuJ
   CdECEYqb3Y0CsD7IIamoIrbalQluos6hgN3OFsGnZRzRq9DIoO2tMH9GF
   t9GgTAc6yJ9EQ+Sv5HgHgQY6Dwa/4WOETxbvyWWq7uqCpVArS2E85Nqgl
   QNxQW09lshx7Bcp+zzhWxr+0fD+QhP41OsSsrSBTwE7iIoZUJKdD7vyvc
   g==;
X-CSE-ConnectionGUID: cIPLfEm6Qyaann9l2jfYhw==
X-CSE-MsgGUID: MGybaMApRnSadUgFUrbIIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67841417"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="67841417"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 11:50:01 -0800
X-CSE-ConnectionGUID: yrLUXQBlSaqJWTgWssi20g==
X-CSE-MsgGUID: FJiRA297S4ab8oqIaec6kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="202898036"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 17 Dec 2025 11:50:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemyslaw Korba <przemyslaw.korba@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 1/6] i40e: fix scheduling in set_rx_mode
Date: Wed, 17 Dec 2025 11:49:40 -0800
Message-ID: <20251217194947.2992495-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
References: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemyslaw Korba <przemyslaw.korba@intel.com>

Add service task schedule to set_rx_mode.
In some cases there are error messages printed out in PTP application
(ptp4l):

ptp4l[13848.762]: port 1 (ens2f3np3): received SYNC without timestamp
ptp4l[13848.825]: port 1 (ens2f3np3): received SYNC without timestamp
ptp4l[13848.887]: port 1 (ens2f3np3): received SYNC without timestamp

This happens when service task would not run immediately after
set_rx_mode, and we need it for setup tasks. This service task checks, if
PTP RX packets are hung in firmware, and propagate correct settings such
as multicast address for IEEE 1588 Precision Time Protocol.
RX timestamping depends on some of these filters set. Bug happens only
with high PTP packets frequency incoming, and not every run since
sometimes service task is being ran from a different place immediately
after starting ptp4l.

Fixes: 0e4425ed641f ("i40e: fix: do not sleep in netdev_ops")
Reviewed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 50be0a60ae13..07d32f2586c8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2234,6 +2234,7 @@ static void i40e_set_rx_mode(struct net_device *netdev)
 		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
 		set_bit(__I40E_MACVLAN_SYNC_PENDING, vsi->back->state);
 	}
+	i40e_service_event_schedule(vsi->back);
 }
 
 /**
-- 
2.47.1


