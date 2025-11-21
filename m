Return-Path: <netdev+bounces-240591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FBBC76BC9
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA8144E65A6
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472FD219303;
	Fri, 21 Nov 2025 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dK7g25fX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CFE1F2B88
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684359; cv=none; b=db5mQ6sAOxDqz5sYpeINnzBEPKrRShA4/MOLBYrX4dZSDocSfTUMBMhjzWQuAtdqFzxJU+zPO4oLh5A74eEgGVRH4Q9lBqrlLjNOSB0swTHlngzYxiFdhxDGv4eqETy1DRjTYexST3rgZhi/6FBa3kHDKzdMu5g1itzeo5yEFps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684359; c=relaxed/simple;
	bh=EvNO+KdWSPi28pDJ/MIWGko7BrdlbWMFg4vALv+xPBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TBLnnIRVK4S/GyJFOVB/3WXLXF7EivCs13sgNIWOrtr9kMJH8+hvxhlr1G+LWltUq3WwcFgtLkNJwmCxV15dPv7fh7yjhWmTsTu8aF62UvwYsyj90di/5JVkG0KdKyUTT64vkxXXsuH1qmWhNBOpMjwalKlbEFls9uCOxgtbwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dK7g25fX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763684358; x=1795220358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=EvNO+KdWSPi28pDJ/MIWGko7BrdlbWMFg4vALv+xPBc=;
  b=dK7g25fXApIv7eMDsRhQNB8+l/Nki3PZ1K2g3lmVF+DjzMNGBXfqU9Da
   Q2BHWPXzl8V6G3sipF8UD5hGDYRUbRXnKO/jGf85d268OuR3lsVxjnqaX
   OlLlj3adIaUdYv01Y+scirFhqUnn2jCiMKxlpI+DRCdhhWI6QzXoR4kN7
   DYIlKKOWhms0sxRCxx5Tyfi8SML9V25V94e2aVuWAYPJ33QFB1roSJ0fd
   bb90RKkLdFhLsAp9wnS6lCtnudImKuZVwe3IjUiv0VrthpqPCaUHdPo1e
   fUSBVM9+EGA4XzVRWVg4YmN3+0SwY8eNGB37Z0S4jx5M4LsHJycaMxjs8
   g==;
X-CSE-ConnectionGUID: 8q5lMRGPQ2q6YVMImCj5xQ==
X-CSE-MsgGUID: jsUyRPMBQs+6bnIic5LRqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65704061"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="65704061"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 16:19:15 -0800
X-CSE-ConnectionGUID: alKz7LWKTWiYFxTqnGDiVA==
X-CSE-MsgGUID: 3BAXjurcSq6BRw296+gIwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="190815176"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa010.jf.intel.com with ESMTP; 20 Nov 2025 16:19:15 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	aleksander.lobakin@intel.com,
	larysa.zaremba@intel.com,
	iamvivekkumar@google.com
Subject: [PATCH iwl-net v2 2/5] idpf: detach and close netdevs while handling a reset
Date: Thu, 20 Nov 2025 16:12:15 -0800
Message-Id: <20251121001218.4565-3-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20251121001218.4565-1-emil.s.tantilov@intel.com>
References: <20251121001218.4565-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Protect the reset path from callbacks by setting the netdevs to detached
state and close any netdevs in UP state until the reset handling has
completed. During a reset, the driver will de-allocate resources for the
vport, and there is no guarantee that those will recover, which is why the
existing vport_ctrl_lock does not provide sufficient protection.

idpf_detach_and_close() is called right before reset handling. If the
reset handling succeeds, the netdevs state is recovered via call to
idpf_attach_and_open(). If the reset handling fails the netdevs remain
down. The detach/down calls are protected with RTNL lock to avoid racing
with callbacks. On the recovery side the attach can be done without
holding the RTNL lock as there are no callbacks expected at that point,
due to detach/close always being done first in that flow.

The previous logic restoring the netdevs state based on the
IDPF_VPORT_UP_REQUESTED flag in the init task is not needed anymore, hence
the removal of idpf_set_vport_state(). The IDPF_VPORT_UP_REQUESTED is
still being used to restore the state of the netdevs following the reset,
but has no use outside of the reset handling flow.

idpf_init_hard_reset() is converted to void, since it was used as such and
there is no error handling being done based on its return value.

Before this change, invoking hard and soft resets simultaneously will
cause the driver to lose the vport state:
ip -br a
<inf>	UP
echo 1 > /sys/class/net/ens801f0/device/reset& \
ethtool -L ens801f0 combined 8
ip -br a
<inf>	DOWN
ip link set <inf> up
ip -br a
<inf>	DOWN

Also in case of a failure in the reset path, the netdev is left
exposed to external callbacks, while vport resources are not
initialized, leading to a crash on subsequent ifup/down:
[408471.398966] idpf 0000:83:00.0: HW reset detected
[408471.411744] idpf 0000:83:00.0: Device HW Reset initiated
[408472.277901] idpf 0000:83:00.0: The driver was unable to contact the device's firmware. Check that the FW is running. Driver state= 0x2
[408508.125551] BUG: kernel NULL pointer dereference, address: 0000000000000078
[408508.126112] #PF: supervisor read access in kernel mode
[408508.126687] #PF: error_code(0x0000) - not-present page
[408508.127256] PGD 2aae2f067 P4D 0
[408508.127824] Oops: Oops: 0000 [#1] SMP NOPTI
...
[408508.130871] RIP: 0010:idpf_stop+0x39/0x70 [idpf]
...
[408508.139193] Call Trace:
[408508.139637]  <TASK>
[408508.140077]  __dev_close_many+0xbb/0x260
[408508.140533]  __dev_change_flags+0x1cf/0x280
[408508.140987]  netif_change_flags+0x26/0x70
[408508.141434]  dev_change_flags+0x3d/0xb0
[408508.141878]  devinet_ioctl+0x460/0x890
[408508.142321]  inet_ioctl+0x18e/0x1d0
[408508.142762]  ? _copy_to_user+0x22/0x70
[408508.143207]  sock_do_ioctl+0x3d/0xe0
[408508.143652]  sock_ioctl+0x10e/0x330
[408508.144091]  ? find_held_lock+0x2b/0x80
[408508.144537]  __x64_sys_ioctl+0x96/0xe0
[408508.144979]  do_syscall_64+0x79/0x3d0
[408508.145415]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[408508.145860] RIP: 0033:0x7f3e0bb4caff

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 121 ++++++++++++---------
 1 file changed, 72 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 2a53f3d504d2..5c81f52db266 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -752,6 +752,65 @@ static int idpf_init_mac_addr(struct idpf_vport *vport,
 	return 0;
 }
 
+static void idpf_detach_and_close(struct idpf_adapter *adapter)
+{
+	int max_vports = adapter->max_vports;
+
+	for (int i = 0; i < max_vports; i++) {
+		struct net_device *netdev = adapter->netdevs[i];
+
+		/* If the interface is in detached state, that means the
+		 * previous reset was not handled successfully for this
+		 * vport.
+		 */
+		if (!netif_device_present(netdev))
+			continue;
+
+		/* Hold RTNL to protect racing with callbacks */
+		rtnl_lock();
+		netif_device_detach(netdev);
+		if (netif_running(netdev)) {
+			set_bit(IDPF_VPORT_UP_REQUESTED,
+				adapter->vport_config[i]->flags);
+			dev_close(netdev);
+		}
+		rtnl_unlock();
+	}
+}
+
+static void idpf_attach_and_open(struct idpf_adapter *adapter)
+{
+	int max_vports = adapter->max_vports;
+
+	for (int i = 0; i < max_vports; i++) {
+		struct idpf_vport *vport = adapter->vports[i];
+		struct idpf_vport_config *vport_config;
+		struct net_device *netdev;
+
+		/* In case of a critical error in the init task, the vport
+		 * will be freed. Only continue to restore the netdevs
+		 * if the vport is allocated.
+		 */
+		if (!vport)
+			continue;
+
+		/* No need for RTNL on attach as this function is called
+		 * following detach and dev_close(). We do take RTNL for
+		 * dev_open() below as it can race with external callbacks
+		 * following the call to netif_device_attach().
+		 */
+		netdev = adapter->netdevs[i];
+		netif_device_attach(netdev);
+		vport_config = adapter->vport_config[vport->idx];
+		if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED,
+				       vport_config->flags)) {
+			rtnl_lock();
+			dev_open(netdev, NULL);
+			rtnl_unlock();
+		}
+	}
+}
+
 /**
  * idpf_cfg_netdev - Allocate, configure and register a netdev
  * @vport: main vport structure
@@ -1064,10 +1123,11 @@ static void idpf_vport_dealloc(struct idpf_vport *vport)
 	idpf_idc_deinit_vport_aux_device(vport->vdev_info);
 
 	idpf_deinit_mac_addr(vport);
-	idpf_vport_stop(vport, true);
 
-	if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
+	if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags)) {
+		idpf_vport_stop(vport, true);
 		idpf_decfg_netdev(vport);
+	}
 	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags)) {
 		idpf_del_all_mac_filters(vport);
 		idpf_del_all_flow_steer_filters(vport);
@@ -1569,7 +1629,6 @@ void idpf_init_task(struct work_struct *work)
 	struct idpf_vport_config *vport_config;
 	struct idpf_vport_max_q max_q;
 	struct idpf_adapter *adapter;
-	struct idpf_netdev_priv *np;
 	struct idpf_vport *vport;
 	u16 num_default_vports;
 	struct pci_dev *pdev;
@@ -1626,12 +1685,6 @@ void idpf_init_task(struct work_struct *work)
 	if (idpf_cfg_netdev(vport))
 		goto unwind_vports;
 
-	/* Once state is put into DOWN, driver is ready for dev_open */
-	np = netdev_priv(vport->netdev);
-	np->state = __IDPF_VPORT_DOWN;
-	if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED, vport_config->flags))
-		idpf_vport_open(vport, true);
-
 	/* Spawn and return 'idpf_init_task' work queue until all the
 	 * default vports are created
 	 */
@@ -1807,27 +1860,6 @@ static int idpf_check_reset_complete(struct idpf_hw *hw,
 	return -EBUSY;
 }
 
-/**
- * idpf_set_vport_state - Set the vport state to be after the reset
- * @adapter: Driver specific private structure
- */
-static void idpf_set_vport_state(struct idpf_adapter *adapter)
-{
-	u16 i;
-
-	for (i = 0; i < adapter->max_vports; i++) {
-		struct idpf_netdev_priv *np;
-
-		if (!adapter->netdevs[i])
-			continue;
-
-		np = netdev_priv(adapter->netdevs[i]);
-		if (np->state == __IDPF_VPORT_UP)
-			set_bit(IDPF_VPORT_UP_REQUESTED,
-				adapter->vport_config[i]->flags);
-	}
-}
-
 /**
  * idpf_init_hard_reset - Initiate a hardware reset
  * @adapter: Driver specific private structure
@@ -1836,28 +1868,17 @@ static void idpf_set_vport_state(struct idpf_adapter *adapter)
  * reallocate. Also reinitialize the mailbox. Return 0 on success,
  * negative on failure.
  */
-static int idpf_init_hard_reset(struct idpf_adapter *adapter)
+static void idpf_init_hard_reset(struct idpf_adapter *adapter)
 {
 	struct idpf_reg_ops *reg_ops = &adapter->dev_ops.reg_ops;
 	struct device *dev = &adapter->pdev->dev;
-	struct net_device *netdev;
 	int err;
-	u16 i;
 
+	idpf_detach_and_close(adapter);
 	mutex_lock(&adapter->vport_ctrl_lock);
 
 	dev_info(dev, "Device HW Reset initiated\n");
 
-	/* Avoid TX hangs on reset */
-	for (i = 0; i < adapter->max_vports; i++) {
-		netdev = adapter->netdevs[i];
-		if (!netdev)
-			continue;
-
-		netif_carrier_off(netdev);
-		netif_tx_disable(netdev);
-	}
-
 	/* Prepare for reset */
 	if (test_and_clear_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
 		reg_ops->trigger_reset(adapter, IDPF_HR_DRV_LOAD);
@@ -1866,7 +1887,6 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
 
 		idpf_idc_issue_reset_event(adapter->cdev_info);
 
-		idpf_set_vport_state(adapter);
 		idpf_vc_core_deinit(adapter);
 		if (!is_reset)
 			reg_ops->trigger_reset(adapter, IDPF_HR_FUNC_RESET);
@@ -1913,11 +1933,14 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
 unlock_mutex:
 	mutex_unlock(&adapter->vport_ctrl_lock);
 
-	/* Wait until all vports are created to init RDMA CORE AUX */
-	if (!err)
-		err = idpf_idc_init(adapter);
-
-	return err;
+	/* Attempt to restore netdevs and initialize RDMA CORE AUX device,
+	 * provided vc_core_init succeeded. It is still possible that
+	 * vports are not allocated at this point if the init task failed.
+	 */
+	if (!err) {
+		idpf_attach_and_open(adapter);
+		idpf_idc_init(adapter);
+	}
 }
 
 /**
-- 
2.37.3


