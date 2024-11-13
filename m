Return-Path: <netdev+bounces-144553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAEA9C7C03
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7D5B3868F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580B2076D4;
	Wed, 13 Nov 2024 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmLzUEDb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8320721E
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524089; cv=none; b=d83daccSgdBkUFXFb56kVx+xQGQ7zByhUIRHyc1uGhQfH8Uxm9ua4F9jk4I4dkNCIhFy3j4dCz55HEByQPIbUQawQzz3A69A07o5I7DDBOJrU6LUSaed9lMgtOU/chTO5oT1dT3PsNG+NC7imtX1KMvcwdvUhBPfeyWHfNiZH5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524089; c=relaxed/simple;
	bh=3buNkZptrmm67XFSkWu1cSrwFgYDuF55Nz6t+nWwneA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ja8gFirwm5yjUMd+xHpmRUMMyo1euleGwFshiW6YvY2IziGczyglbY22JNYWneRAWarl+2/bw/aKiDPIlR2i/92P+VGGFxUjm6zs3E4Sg318ovOzPRDwlb4S11i4h0CtcLd72tA7RPakEbmyg9XQPfz2VudyUi1zYwoxAtwEE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmLzUEDb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731524088; x=1763060088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3buNkZptrmm67XFSkWu1cSrwFgYDuF55Nz6t+nWwneA=;
  b=nmLzUEDbKg5ZWCN/fUyGoQA+9a59FXRcDSs0CwrFIbjMzDI1PlA5IdUM
   9BzPTpQ89PWNwujugapTb6dr+e0E+YRmvSO4csG7kVC3U27KUCEeYe14+
   PrS6CI+WhP8GuaTxdDFr+TI6VFjqqObol/2ggM8nA1t+n1sOiIEOi0cIB
   KWuupBin0rB3OFFA5OvGtdHxzpOORj4Q199iGOVcvOHUQnv0ymVjhnlgc
   be7FOSKOz9wpq8y32uHbjJc2qR+bDMorHoOf+4pGqZ2uC37XGY0XAx3xh
   6t6fdcWg8/bj05tof+MOkV6HUjCcmI2LqS2WoB/eDczKleb24A8r2GQKm
   A==;
X-CSE-ConnectionGUID: H9HGRZTxT529AeDQIUr5dQ==
X-CSE-MsgGUID: XjBjwJXIRRy1TYit4JlSAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31589557"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31589557"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 10:54:43 -0800
X-CSE-ConnectionGUID: r95FmK5CTnu4fN0aNWFwoA==
X-CSE-MsgGUID: hObCrGulQRm9RBYg30T0Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87520774"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 10:54:42 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH net-next v2 14/14] e1000: Hold RTNL when e1000_down can be called
Date: Wed, 13 Nov 2024 10:54:29 -0800
Message-ID: <20241113185431.1289708-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
References: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe Damato <jdamato@fastly.com>

e1000_down calls netif_queue_set_napi, which assumes that RTNL is held.

There are a few paths for e1000_down to be called in e1000 where RTNL is
not currently being held:
  - e1000_shutdown (pci shutdown)
  - e1000_suspend (power management)
  - e1000_reinit_locked (via e1000_reset_task delayed work)
  - e1000_io_error_detected (via pci error handler)

Hold RTNL in three places to fix this issue:
  - e1000_reset_task: igc, igb, and e100e all hold rtnl in this path.
  - e1000_io_error_detected (pci error handler): e1000e and ixgbe hold
    rtnl in this path. A patch has been posted for igc to do the same
    [1].
  - __e1000_shutdown (which is called from both e1000_shutdown and
    e1000_suspend): igb, ixgbe, and e1000e all hold rtnl in the same
    path.

The other paths which call e1000_down seemingly hold RTNL and are OK:
  - e1000_close (ndo_stop)
  - e1000_change_mtu (ndo_change_mtu)

Based on the above analysis and mailing list discussion [2], I believe
adding rtnl in the three places mentioned above is correct.

Fixes: 8f7ff18a5ec7 ("e1000: Link NAPI instances to queues and IRQs")
Reported-by: Dmitry Antipov <dmantipov@yandex.ru>
Closes: https://lore.kernel.org/netdev/8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru/
Link: https://lore.kernel.org/netdev/20241022215246.307821-3-jdamato@fastly.com/ [1]
Link: https://lore.kernel.org/netdev/ZxgVRX7Ne-lTjwiJ@LQ3V64L9R2/ [2]
Signed-off-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 4de9b156b2be..3f089c3d47b2 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3509,7 +3509,9 @@ static void e1000_reset_task(struct work_struct *work)
 		container_of(work, struct e1000_adapter, reset_task);
 
 	e_err(drv, "Reset adapter\n");
+	rtnl_lock();
 	e1000_reinit_locked(adapter);
+	rtnl_unlock();
 }
 
 /**
@@ -5074,7 +5076,9 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
 			usleep_range(10000, 20000);
 
 		WARN_ON(test_bit(__E1000_RESETTING, &adapter->flags));
+		rtnl_lock();
 		e1000_down(adapter);
+		rtnl_unlock();
 	}
 
 	status = er32(STATUS);
@@ -5235,16 +5239,20 @@ static pci_ers_result_t e1000_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 
+	rtnl_lock();
 	netif_device_detach(netdev);
 
-	if (state == pci_channel_io_perm_failure)
+	if (state == pci_channel_io_perm_failure) {
+		rtnl_unlock();
 		return PCI_ERS_RESULT_DISCONNECT;
+	}
 
 	if (netif_running(netdev))
 		e1000_down(adapter);
 
 	if (!test_and_set_bit(__E1000_DISABLED, &adapter->flags))
 		pci_disable_device(pdev);
+	rtnl_unlock();
 
 	/* Request a slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
-- 
2.42.0


