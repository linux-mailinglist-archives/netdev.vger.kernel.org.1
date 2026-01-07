Return-Path: <netdev+bounces-247502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C98A1CFB6BE
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 01:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CE98300A98B
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 00:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527823C2F;
	Wed,  7 Jan 2026 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U80zrXY3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A8800
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744417; cv=none; b=kP4gflBzbjdA4L8PUGXlJEKyngbDkHvE7XQdqWuf1XiZS/VuMkUFLRUi/cpYYnOt0erKkl775s82Ph2UyfHgJyNKblyj5/n+cv1yagFYIPeLdMBWK55w8wwBAh2nhW2bwCF6EH/W9gRjtSRO2xTsCqsRn2nEVvUK3KO+MhH+FXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744417; c=relaxed/simple;
	bh=fCJFs1kc3dtnQM9oZ+GzPT6Iuvq8MdFNd5AsMEeUzvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEGDOSJSsVm2LjFBAtg1c15E0F9Qig8SSlyXqTVJQGsNpgY4osj+FsF8JjQY2dD1xkvRuzRFSGCXrcGvQMmdMcn8HEyLteTBAZZB9l6xlHWPtcyZOEfycInNFCAwsFZCp94yJCoh7Mn95qHfoBUX31zk65zScts1Wn6PfjlUtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U80zrXY3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767744416; x=1799280416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fCJFs1kc3dtnQM9oZ+GzPT6Iuvq8MdFNd5AsMEeUzvE=;
  b=U80zrXY3T/DKT7o/VjREQr0lVKUhoNKktGX4juifkmW62SI+iL9jsZGr
   EXo18X7XnAuksEzM4CnfqKMHRqoTAXBD9XJwSEOZXcxti2gajU+b/V/ki
   VO8niZiU/3wkP93lsXOzWZtP3Z27O5Dv3l2rOhzObuRgE8/3YS6guMKyI
   4FVmiBX9EUyKDEbaoBBycqn4+IcVu/u64udBwJKcbfMb5tDIYnw/XK/Ai
   BdJP+lxQGMIx+3cfML+c8RMSGqChVfrEaEe2jdOIxisX7jQGZELBbayEw
   hHJ038nNPWf9Tv6rX/GVRPVPCTv17yXVQG+TXbt43q8XbNA+k8U5Q6obh
   A==;
X-CSE-ConnectionGUID: qie8QYkfTcCmZbMrKS6Cjw==
X-CSE-MsgGUID: ftUArzh9Qu+XhKHZe7pTfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69161617"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69161617"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:06:53 -0800
X-CSE-ConnectionGUID: iqGh7j7TRuOY1073itmo9w==
X-CSE-MsgGUID: qpLT4t8lQtmeP0iXPbN7kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207841178"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 06 Jan 2026 16:06:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	iamvivekkumar@google.com,
	decot@google.com,
	willemb@google.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 01/13] idpf: keep the netdev when a reset fails
Date: Tue,  6 Jan 2026 16:06:33 -0800
Message-ID: <20260107000648.1861994-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
References: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

During a successful reset the driver would re-allocate vport resources
while keeping the netdevs intact. However, in case of an error in the
init task, the netdev of the failing vport will be unregistered,
effectively removing the network interface:

[  121.211076] idpf 0000:83:00.0: enabling device (0100 -> 0102)
[  121.221976] idpf 0000:83:00.0: Device HW Reset initiated
[  124.161229] idpf 0000:83:00.0 ens801f0: renamed from eth0
[  124.163364] idpf 0000:83:00.0 ens801f0d1: renamed from eth1
[  125.934656] idpf 0000:83:00.0 ens801f0d2: renamed from eth2
[  128.218429] idpf 0000:83:00.0 ens801f0d3: renamed from eth3

ip -br a
ens801f0         UP
ens801f0d1       UP
ens801f0d2       UP
ens801f0d3       UP
echo 1 > /sys/class/net/ens801f0/device/reset

[  145.885537] idpf 0000:83:00.0: resetting
[  145.990280] idpf 0000:83:00.0: reset done
[  146.284766] idpf 0000:83:00.0: HW reset detected
[  146.296610] idpf 0000:83:00.0: Device HW Reset initiated
[  211.556719] idpf 0000:83:00.0: Transaction timed-out (op:526 cookie:7700 vc_op:526 salt:77 timeout:60000ms)
[  272.996705] idpf 0000:83:00.0: Transaction timed-out (op:502 cookie:7800 vc_op:502 salt:78 timeout:60000ms)

ip -br a
ens801f0d1       DOWN
ens801f0d2       DOWN
ens801f0d3       DOWN

Re-shuffle the logic in the error path of the init task to make sure the
netdevs remain intact. This will allow the driver to attempt recovery via
subsequent resets, provided the FW is still functional.

The main change is to make sure that idpf_decfg_netdev() is not called
should the init task fail during a reset. The error handling is
consolidated under unwind_vports, as the removed labels had the same
cleanup logic split depending on the point of failure.

Fixes: ce1b75d0635c ("idpf: add ptypes and MAC filter support")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 7ce4eb71a433..313803c08847 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1579,6 +1579,10 @@ void idpf_init_task(struct work_struct *work)
 		goto unwind_vports;
 	}
 
+	err = idpf_send_get_rx_ptype_msg(vport);
+	if (err)
+		goto unwind_vports;
+
 	index = vport->idx;
 	vport_config = adapter->vport_config[index];
 
@@ -1590,15 +1594,11 @@ void idpf_init_task(struct work_struct *work)
 	err = idpf_check_supported_desc_ids(vport);
 	if (err) {
 		dev_err(&pdev->dev, "failed to get required descriptor ids\n");
-		goto cfg_netdev_err;
+		goto unwind_vports;
 	}
 
 	if (idpf_cfg_netdev(vport))
-		goto cfg_netdev_err;
-
-	err = idpf_send_get_rx_ptype_msg(vport);
-	if (err)
-		goto handle_err;
+		goto unwind_vports;
 
 	/* Once state is put into DOWN, driver is ready for dev_open */
 	np = netdev_priv(vport->netdev);
@@ -1645,11 +1645,6 @@ void idpf_init_task(struct work_struct *work)
 
 	return;
 
-handle_err:
-	idpf_decfg_netdev(vport);
-cfg_netdev_err:
-	idpf_vport_rel(vport);
-	adapter->vports[index] = NULL;
 unwind_vports:
 	if (default_vport) {
 		for (index = 0; index < adapter->max_vports; index++) {
-- 
2.47.1


