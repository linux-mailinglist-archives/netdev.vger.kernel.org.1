Return-Path: <netdev+bounces-249609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B47A6D1B854
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC12A300FBF2
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79543354AF4;
	Tue, 13 Jan 2026 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBOn/x6w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A807354AE9
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341754; cv=none; b=mpJjo5BwMbP85KivICShaRRaJCr+/Wpjy4lsst6MSZhBpHmD+1+2xVpVpeu7111vEqbtMiEZoqQY8uNxogshLZagqdBBb61RUkcdwyjhRlMWGw/h2u+9KkNRy4EYeFgASmXp1T6tSPpB9aIVL7kXAZ6MK9toO03mDQ/NDR+12N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341754; c=relaxed/simple;
	bh=VfZx+6vMFCWhp5+5AclqfRlOCNS9CJuu6ubQONt55M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoyTEEtJQMuwgGf2z5iaHWRrvOBkRJM78vroeE6nTPP0SeCKNVAN/xzLVW6QdHuOtO40e3I6Or+oaF5o5carrpHVA/DjofrcBBMIpTZkSwJYG+fJtf9W6fhSMhIyaZP5K3Md0WjuSD7GIjxvfkFN7QnGNF3lYnrxJ0htvKMoKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBOn/x6w; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768341754; x=1799877754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VfZx+6vMFCWhp5+5AclqfRlOCNS9CJuu6ubQONt55M4=;
  b=FBOn/x6wVVkHWbm6G3ehIrjhG0uClgRU9HQTtj9J2ai2GYmRljt5ZvkN
   1rUIJKo6PoYjHCKYXsd5OuAcQfdboOwktf6ze4nCYQev/YCXNNP/lmmPD
   B6wZbbZM/+jDbx1aVDoVYTtPJ5ijB4vPEA3PLRwm7HIJ27hYUL44Yn+BD
   T1R1UTqCEJx1IQihVbUVkBgq7QrV5FD/9b9trI+y5W2fylQZlZXISgA2T
   wBLKvtmEpL/KMgAV/yjs/v/qv9ByaBLh97yNKnCRq4fLqNG6QOIUzIlOJ
   NgFHtMJ7ZJmgR1D4DnqyD6yeKCg/Jc1nun1WWerTINwTnuG9qvf2Zobdz
   Q==;
X-CSE-ConnectionGUID: h7mqVbIJQdK5RK4qfyZHyA==
X-CSE-MsgGUID: li6UUsWyTxmULQl+AyDBNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69558683"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69558683"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 14:02:29 -0800
X-CSE-ConnectionGUID: yUryBcAhSxOAOfQMG24ICw==
X-CSE-MsgGUID: cflAVd10RlevMqp31cKj9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204388181"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Jan 2026 14:02:28 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	bigeasy@linutronix.de,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH net 4/6] igc: Restore default Qbv schedule when changing channels
Date: Tue, 13 Jan 2026 14:02:17 -0800
Message-ID: <20260113220220.1034638-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260113220220.1034638-1-anthony.l.nguyen@intel.com>
References: <20260113220220.1034638-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

The Multi-queue Priority (MQPRIO) and Earliest TxTime First (ETF) offloads
utilize the Time Sensitive Networking (TSN) Tx mode. This mode is always
coupled to IEEE 802.1Qbv time aware shaper (Qbv). Therefore, the driver
sets a default Qbv schedule of all gates opened and a cycle time of
1s. This schedule is set during probe.

However, the following sequence of events lead to Tx issues:

 - Boot a dual core system
   igc_probe():
     igc_tsn_clear_schedule():
       -> Default Schedule is set
       Note: At this point the driver has allocated two Tx/Rx queues, because
       there are only two CPUs.

 - ethtool -L enp3s0 combined 4
   igc_ethtool_set_channels():
     igc_reinit_queues()
       -> Default schedule is gone, per Tx ring start and end time are zero

  - tc qdisc replace dev enp3s0 handle 100 parent root mqprio \
      num_tc 4 map 3 3 2 2 0 1 1 1 3 3 3 3 3 3 3 3 \
      queues 1@0 1@1 1@2 1@3 hw 1
    igc_tsn_offload_apply():
      igc_tsn_enable_offload():
        -> Writes zeros to IGC_STQT(i) and IGC_ENDQT(i), causing Tx to stall/fail

Therefore, restore the default Qbv schedule after changing the number of
channels.

Furthermore, add a restriction to not allow queue reconfiguration when
TSN/Qbv is enabled, because it may lead to inconsistent states.

Fixes: c814a2d2d48f ("igc: Use default cycle 'start' and 'end' values for queues")
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 4 ++--
 drivers/net/ethernet/intel/igc/igc_main.c    | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index e94c1922b97a..3172cdbca9cc 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1565,8 +1565,8 @@ static int igc_ethtool_set_channels(struct net_device *netdev,
 	if (ch->other_count != NON_Q_VECTORS)
 		return -EINVAL;
 
-	/* Do not allow channel reconfiguration when mqprio is enabled */
-	if (adapter->strict_priority_enable)
+	/* Do not allow channel reconfiguration when any TSN qdisc is enabled */
+	if (adapter->flags & IGC_FLAG_TSN_ANY_ENABLED)
 		return -EINVAL;
 
 	/* Verify the number of channels doesn't exceed hw limits */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7aafa60ba0c8..89a321a344d2 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7759,6 +7759,11 @@ int igc_reinit_queues(struct igc_adapter *adapter)
 	if (netif_running(netdev))
 		err = igc_open(netdev);
 
+	if (!err) {
+		/* Restore default IEEE 802.1Qbv schedule after queue reinit */
+		igc_tsn_clear_schedule(adapter);
+	}
+
 	return err;
 }
 
-- 
2.47.1


