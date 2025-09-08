Return-Path: <netdev+bounces-220799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0E1B48C70
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39243407FF
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622562F7AB4;
	Mon,  8 Sep 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFbp8tMI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E161D5150
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331835; cv=none; b=Bp1oQOwOo5Yt7x4g89xlhToTaEwDQGO8t1+5rhwiL39XjzEbs7DC+K6hkoQ9F2fCLdH4uqZsvGln0XKhfCHs2+tC4SV4vvPwKyAvNgRb7dWRNHVjws9ljYP9VqjG73Go///36AKMIsR3ztVVgjrf+1YNY4B5RvRgkgTwqzXIVQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331835; c=relaxed/simple;
	bh=xec1VPGHlx9EpynMQeGA+2Z16GYEO+EPbYhiVsEFspk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxAIKC5O9Yj4zhBDKB72KdYPtKs01jphD01qanD+bls0LT/QjEv3dvpweLDvMVMT/EDWfHwDSdA+z6yVSSe+SiF5fohnMLbBrgYgZxG8FQ7BOo8s9h9uhN8vV4JBxtZKnu1JmdDgqU/6vtjqxL29BwO1NXWVc7tHVff2SBBWaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFbp8tMI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757331834; x=1788867834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xec1VPGHlx9EpynMQeGA+2Z16GYEO+EPbYhiVsEFspk=;
  b=cFbp8tMICBhizZRJXaKT5+3dHXDMDn5NDlM6atowGxwc97anwdKXCE2J
   Mg192f3wnt4VhP4eGb4o7HhRdU25IsOd3bXZkeeOBDK7CPWgVK8zUj/OF
   fu0JWfAB15XrUqYlmBfBPvF9xHmnZFlioJMfBGJ6SHUw7KxXULLumZxfZ
   k6x4qNfvpLCsIAxP05VOszQgdtZKYAomSKuzdLowHOITTgO8FHPzjtkQL
   c8ZFnXATZ9aZzAxRX1RsOVvVAFAZwqwYczcLmTpR5rEJLQDT1LaIu9de7
   eHzSdEMSV3KTzCvGa96OWFwmyWmMD8o04M44aaCnF0ftkBSsKuTmn42KT
   Q==;
X-CSE-ConnectionGUID: ddQH3EofTHOeqTol3F9H/w==
X-CSE-MsgGUID: CWP8DMDEQreC6cU7TNNizA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="63412836"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="63412836"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:43:53 -0700
X-CSE-ConnectionGUID: PYbwz/gySpaq9McUCDIZrA==
X-CSE-MsgGUID: j+51e6ORQ1GhghtfBg7Slw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="177126092"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa005.fm.intel.com with ESMTP; 08 Sep 2025 04:43:52 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-net v2 2/2] ixgbe: destroy aci.lock later within ixgbe_remove path
Date: Mon,  8 Sep 2025 13:26:29 +0200
Message-Id: <20250908112629.1938159-3-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250908112629.1938159-1-jedrzej.jagielski@intel.com>
References: <20250908112629.1938159-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's another issue with aci.lock and previous patch uncovers it.
aci.lock is being destroyed during removing ixgbe while some of the
ixgbe closing routines are still ongoing. These routines use Admin
Command Interface which require taking aci.lock which has been already
destroyed what leads to call trace.

[  +0.000004] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[  +0.000007] WARNING: CPU: 12 PID: 10277 at kernel/locking/mutex.c:155 mutex_lock+0x5f/0x70
[  +0.000002] Call Trace:
[  +0.000003]  <TASK>
[  +0.000006]  ixgbe_aci_send_cmd+0xc8/0x220 [ixgbe]
[  +0.000049]  ? try_to_wake_up+0x29d/0x5d0
[  +0.000009]  ixgbe_disable_rx_e610+0xc4/0x110 [ixgbe]
[  +0.000032]  ixgbe_disable_rx+0x3d/0x200 [ixgbe]
[  +0.000027]  ixgbe_down+0x102/0x3b0 [ixgbe]
[  +0.000031]  ixgbe_close_suspend+0x28/0x90 [ixgbe]
[  +0.000028]  ixgbe_close+0xfb/0x100 [ixgbe]
[  +0.000025]  __dev_close_many+0xae/0x220
[  +0.000005]  dev_close_many+0xc2/0x1a0
[  +0.000004]  ? kernfs_should_drain_open_files+0x2a/0x40
[  +0.000005]  unregister_netdevice_many_notify+0x204/0xb00
[  +0.000006]  ? __kernfs_remove.part.0+0x109/0x210
[  +0.000006]  ? kobj_kset_leave+0x4b/0x70
[  +0.000008]  unregister_netdevice_queue+0xf6/0x130
[  +0.000006]  unregister_netdev+0x1c/0x40
[  +0.000005]  ixgbe_remove+0x216/0x290 [ixgbe]
[  +0.000021]  pci_device_remove+0x42/0xb0
[  +0.000007]  device_release_driver_internal+0x19c/0x200
[  +0.000008]  driver_detach+0x48/0x90
[  +0.000003]  bus_remove_driver+0x6d/0xf0
[  +0.000006]  pci_unregister_driver+0x2e/0xb0
[  +0.000005]  ixgbe_exit_module+0x1c/0xc80 [ixgbe]

Same as for the previous commit, the issue has been highlighted by the
commit 337369f8ce9e ("locking/mutex: Add MUTEX_WARN_ON() into fast path").

Move destroying aci.lock to the end of ixgbe_remove(), as this
simply fixes the issue.

Fixes: 4600cdf9f5ac ("ixgbe: Enable link management in E610 device")
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 18cae81dc794..4aa4ca603584 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11891,10 +11891,8 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	set_bit(__IXGBE_REMOVING, &adapter->state);
 	cancel_work_sync(&adapter->service_task);
 
-	if (adapter->hw.mac.type == ixgbe_mac_e610) {
+	if (adapter->hw.mac.type == ixgbe_mac_e610)
 		ixgbe_disable_link_status_events(adapter);
-		mutex_destroy(&adapter->hw.aci.lock);
-	}
 
 	if (adapter->mii_bus)
 		mdiobus_unregister(adapter->mii_bus);
@@ -11954,6 +11952,9 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	disable_dev = !test_and_set_bit(__IXGBE_DISABLED, &adapter->state);
 	free_netdev(netdev);
 
+	if (adapter->hw.mac.type == ixgbe_mac_e610)
+		mutex_destroy(&adapter->hw.aci.lock);
+
 	if (disable_dev)
 		pci_disable_device(pdev);
 }
-- 
2.31.1


