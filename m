Return-Path: <netdev+bounces-228814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7CCBD4285
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27BD834E99A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AAA22157B;
	Mon, 13 Oct 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9JBEk5T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B792326B742
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368522; cv=none; b=FUhJIA2CcyprF7ITYvzagTn85xotTErJGlxZRPAhJKKXLRdlTfLJsoRMiGHXIS4wPEMuARb20EZz/ycIKhhgUKBV1PV4+5JgQZyRM7tGSL5KYUHzJC22dt9gAudYhv9vliIm5b3MZkjy0YMaWOI+m0J4rRckMHtwiXgpjUzeefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368522; c=relaxed/simple;
	bh=c4rS93Rby4lVufqazjHfnme806G3DSAkw+yIkKx5apk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PPNUUqKqgC5RbJuGaIryEoAUhwCfnRTphrDq/TQWmMMNtE2jEhwJajLwEd4y6fNcAPMvwvl6UW3zV90xZj3PeyMIdel3bawY55MDL0hDa2NkuQZYbXOpUkagLKHpy2RSXgF0/Qi4qpRne+3Q3UKtvExeCvhDDrH5QvLe+ae46z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9JBEk5T; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760368521; x=1791904521;
  h=from:to:cc:subject:date:message-id;
  bh=c4rS93Rby4lVufqazjHfnme806G3DSAkw+yIkKx5apk=;
  b=V9JBEk5TtzwzK4iTO4qbMA7QtTvioMmnK5lzFNEef34GmODATRhajnqR
   6XUtGobx9jr84iRYWmn+GJ/ssxUH6ZpN6GrT7I/hI7evHgBmqwNsUgBgB
   RBxvaR4V/izi57wUlcgA7104uuFH/1ffa5EfxMgU/IXCRc1S91qtJVjmS
   ww9VXwN8EK8NEn9429EFWsSGhG2xOGVjMjTmS+FL6tUJ9CtFGp16xTuN0
   /VH4iCKXydLWU0yPF5BJuQ1P+A0ylVgsIiSs8KZCUbKm7YaQsLz86bhZ0
   KReWx77O+SHDwIfPEkPRsFqGzHItf0bXlON26K+C1cMz12uM5b0DD4MLu
   g==;
X-CSE-ConnectionGUID: 71rfkS3nSfidZs89sjh92g==
X-CSE-MsgGUID: Tg1sd57BQOyna2SGWAaYNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62443343"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62443343"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 08:15:20 -0700
X-CSE-ConnectionGUID: KUykYF+DS+m5apxPfOqdrw==
X-CSE-MsgGUID: 6PMpYbLYRMaGGMZ/nd3AAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="181632216"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa008.jf.intel.com with ESMTP; 13 Oct 2025 08:15:20 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
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
	horms@kernel.org
Subject: [PATCH iwl-net] idpf: fix possible vport_config NULL pointer deref in remove
Date: Mon, 13 Oct 2025 08:08:24 -0700
Message-Id: <20251013150824.28705-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Attempting to remove the driver will cause a crash in cases where
the vport failed to initialize. Following trace is from an instance where
the driver failed during an attempt to create a VF:
[ 1661.543624] idpf 0000:84:00.7: Device HW Reset initiated
[ 1722.923726] idpf 0000:84:00.7: Transaction timed-out (op:1 cookie:2900 vc_op:1 salt:29 timeout:60000ms)
[ 1723.353263] BUG: kernel NULL pointer dereference, address: 0000000000000028
...
[ 1723.358472] RIP: 0010:idpf_remove+0x11c/0x200 [idpf]
...
[ 1723.364973] Call Trace:
[ 1723.365475]  <TASK>
[ 1723.365972]  pci_device_remove+0x42/0xb0
[ 1723.366481]  device_release_driver_internal+0x1a9/0x210
[ 1723.366987]  pci_stop_bus_device+0x6d/0x90
[ 1723.367488]  pci_stop_and_remove_bus_device+0x12/0x20
[ 1723.367971]  pci_iov_remove_virtfn+0xbd/0x120
[ 1723.368309]  sriov_disable+0x34/0xe0
[ 1723.368643]  idpf_sriov_configure+0x58/0x140 [idpf]
[ 1723.368982]  sriov_numvfs_store+0xda/0x1c0

Avoid the NULL pointer dereference by adding NULL pointer check for
vport_config[i], before freeing user_config.q_coalesce.

Fixes: e1e3fec3e34b ("idpf: preserve coalescing settings across resets")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Chittim Madhu <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 8c46481d2e1f..8cf4ff697572 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -63,6 +63,8 @@ static void idpf_remove(struct pci_dev *pdev)
 	destroy_workqueue(adapter->vc_event_wq);
 
 	for (i = 0; i < adapter->max_vports; i++) {
+		if (!adapter->vport_config[i])
+			continue;
 		kfree(adapter->vport_config[i]->user_config.q_coalesce);
 		kfree(adapter->vport_config[i]);
 		adapter->vport_config[i] = NULL;
-- 
2.37.3


