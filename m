Return-Path: <netdev+bounces-240590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BCCC76BA5
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD3FB3566E0
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CE920DD48;
	Fri, 21 Nov 2025 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a866KVpY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B961EFF9B
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684358; cv=none; b=HHPVvpSei6vX+hzDB5rOKA6Q68luVL/xsNMtP9IOt1e6fTSO6LElN65EJ7vna0T+whW8KbXtQP7xxAvgkg4jqApG2QAbh+0gbowU+e7rowMubotiZdddwNWRPe/sSX60Kqb9Xqq3doqS2ugKyVu5Qn55muM0tfueVASp+3O2SwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684358; c=relaxed/simple;
	bh=wLTUmV+ApT/9ZBDzo80caj17Ob/F6zvbzNLQMrOPOYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sanjx4yqYn/1Zapkw7izfwqFeciUI1UtpypIKTFwqHAlASBPH0dr2Fey7wgrDgE96yzbY0rqa5NzUvMgCDjrHMvuLT3/oghvjAk192lyk07qrFqi155dP171QO2tt6wL8ipUZCYketykKjhHLlJyhE3PWU4S1hLMVR3xp7E9/qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a866KVpY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763684357; x=1795220357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=wLTUmV+ApT/9ZBDzo80caj17Ob/F6zvbzNLQMrOPOYY=;
  b=a866KVpY9SVfSnqJJjNczx7V+TGGMoDQQBqw403yfQrutAAXnybSgZT9
   sbBtCelPKkbG3EZ8R/ehGFnjnhrVfrLW+xEBoOS4aJ3xxSMAOoDqcbiQd
   +9NcU93L/HcLTYmEGpKB2kW0t5omU9nbSD8aN+2EmHDunTvKinJmk77um
   YEFw3FQq+WNbUITbzbOCOwpyOy/R9E3P+c0hz7jUQ3rBehJl5dPJM2FWe
   m4CuVMaTfO0SnnGhUdkCxvUaDGCXi4uNg5iUSYP/NDqPq7HZy1+JPrYNn
   A7VAlkdOq3BRy7FTuXripvIWIS66E2d8yN6FRHB1L8tmSRtBZVbz2xm3a
   w==;
X-CSE-ConnectionGUID: MRoEy2U1SBi9dEVhONrX6g==
X-CSE-MsgGUID: eJfH6/CRRmm9FSwPuaQJSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65704051"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="65704051"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 16:19:15 -0800
X-CSE-ConnectionGUID: uj3c/WGXTmmFa65o21We+A==
X-CSE-MsgGUID: 0zXK9SydSO2PMNVZ/aQSQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="190815171"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa010.jf.intel.com with ESMTP; 20 Nov 2025 16:19:14 -0800
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
Subject: [PATCH iwl-net v2 1/5] idpf: keep the netdev when a reset fails
Date: Thu, 20 Nov 2025 16:12:14 -0800
Message-Id: <20251121001218.4565-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20251121001218.4565-1-emil.s.tantilov@intel.com>
References: <20251121001218.4565-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

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
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index bd38ecc7872c..2a53f3d504d2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1604,6 +1604,10 @@ void idpf_init_task(struct work_struct *work)
 		goto unwind_vports;
 	}
 
+	err = idpf_send_get_rx_ptype_msg(vport);
+	if (err)
+		goto unwind_vports;
+
 	index = vport->idx;
 	vport_config = adapter->vport_config[index];
 
@@ -1616,15 +1620,11 @@ void idpf_init_task(struct work_struct *work)
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
@@ -1671,11 +1671,6 @@ void idpf_init_task(struct work_struct *work)
 
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
2.37.3


