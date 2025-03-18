Return-Path: <netdev+bounces-175599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DDEA669BE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 06:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BE43BBBE8
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 05:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EC51D90C5;
	Tue, 18 Mar 2025 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="At16XDG8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C2028373
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276676; cv=none; b=oSucZNqRRPk3m+bmbFuRVNBF8PsZvJKQxb9207oa9siUb4EjiW/lPO+8T542WMuUbkyywyON2AcW3h+shuG1CCNk8KS1nb7mq2JaKkpUK7wAbPx/qYxbw6sUHx/QCkCZzPNx4IdELeHOwgc3PElZe1TEaAsx8uRfxG4u56Idq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276676; c=relaxed/simple;
	bh=1ZdTYdh9OBD8bz6WNb3r2HqcCV8AD+25uxF+8QeNH2c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cOcgoSOKYBvgUB3gnsxxJ7C6+WsgKnzVhO0uTR4E2LoKftxiZ2nWZB94AT7VASmqcxAeHwOkzrBcSGYEj7VdaX9ysqLbvoaeleYi7xrD9F/naQCnJQZ8XB1HX1KUS7+4ystEq1m6odQ46E49JBoahP0yvcYVVKf4WbhJDU1pWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=At16XDG8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742276675; x=1773812675;
  h=from:to:cc:subject:date:message-id;
  bh=1ZdTYdh9OBD8bz6WNb3r2HqcCV8AD+25uxF+8QeNH2c=;
  b=At16XDG8VZ9Hu41TrIglrC12XxT6nRzfcW2faaOy2/1dihz32LHCDHAk
   SklxA2Put5OIl3QvV0LtDIrE8fFL8tawvhWFBQkmEQ4ntk5Vtrru9zD3b
   IFlP+M2c4TfqljmkLTHLGiBMEql/Zbk6lCqNPykvk3FNHA7Z5bkcojVMh
   rHpSKXYGjFYJgea0Ldolrfu919ri/r+2OfGzRBqxIWp7W5s0m7/9ATOob
   f3u1Vu2T3I2ZHwmtx56BIe0oOW7xTP+GfT7REdw+76ZgGkw7f+ST/W+mx
   VDUm/4oZRQk7YnM8GXwsLx2ghl+tV2AP4RqWVAYYoEK9+8zzxRbWoFTtL
   Q==;
X-CSE-ConnectionGUID: fEWl6yudTnmWNG7MvMQAnA==
X-CSE-MsgGUID: BX5VP5EFTfyFlbXzqKcrNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43281364"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43281364"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 22:44:34 -0700
X-CSE-ConnectionGUID: A6ecuG6OTUifUqxqisT1qA==
X-CSE-MsgGUID: MCyqfzBzTq68hRyHhrCF9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="122324625"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa008.fm.intel.com with ESMTP; 17 Mar 2025 22:44:33 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	decot@google.com,
	willemb@google.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	madhu.chittim@intel.com,
	Aleksandr.Loktionov@intel.com,
	yuma@redhat.com,
	mschmidt@redhat.com,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com
Subject: [PATCH iwl-net v2] idpf: fix adapter NULL pointer dereference on reboot
Date: Mon, 17 Mar 2025 22:42:02 -0700
Message-Id: <20250318054202.17405-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

With SRIOV enabled, idpf ends up calling into idpf_remove() twice.
First via idpf_shutdown() and then again when idpf_remove() calls into
sriov_disable(), because the VF devices use the idpf driver, hence the
same remove routine. When that happens, it is possible for the adapter
to be NULL from the first call to idpf_remove(), leading to a NULL
pointer dereference.

echo 1 > /sys/class/net/<netif>/device/sriov_numvfs
reboot

BUG: kernel NULL pointer dereference, address: 0000000000000020
...
RIP: 0010:idpf_remove+0x22/0x1f0 [idpf]
...
? idpf_remove+0x22/0x1f0 [idpf]
? idpf_remove+0x1e4/0x1f0 [idpf]
pci_device_remove+0x3f/0xb0
device_release_driver_internal+0x19f/0x200
pci_stop_bus_device+0x6d/0x90
pci_stop_and_remove_bus_device+0x12/0x20
pci_iov_remove_virtfn+0xbe/0x120
sriov_disable+0x34/0xe0
idpf_sriov_configure+0x58/0x140 [idpf]
idpf_remove+0x1b9/0x1f0 [idpf]
idpf_shutdown+0x12/0x30 [idpf]
pci_device_shutdown+0x35/0x60
device_shutdown+0x156/0x200
...

Replace the direct idpf_remove() call in idpf_shutdown() with
idpf_vc_core_deinit() and idpf_deinit_dflt_mbx(), which perform
the bulk of the cleanup, such as stopping the init task, freeing IRQs,
destroying the vports and freeing the mailbox. This avoids the calls to
sriov_disable() in addition to a small netdev cleanup, and destroying
workqueues, which don't seem to be required on shutdown.

Reported-by: Yuying Ma <yuma@redhat.com>
Fixes: e850efed5e15 ("idpf: add module register and probe functionality")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
Changelog:
v2:
- Updated the description to clarify the path leading up to the crash,
  and the difference in the logic between remove and shutdown as result
  of this change.

v1:
https://lore.kernel.org/intel-wired-lan/20250307003956.22018-1-emil.s.tantilov@intel.com/
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index b6c515d14cbf..bec4a02c5373 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -87,7 +87,11 @@ static void idpf_remove(struct pci_dev *pdev)
  */
 static void idpf_shutdown(struct pci_dev *pdev)
 {
-	idpf_remove(pdev);
+	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&adapter->vc_event_task);
+	idpf_vc_core_deinit(adapter);
+	idpf_deinit_dflt_mbx(adapter);
 
 	if (system_state == SYSTEM_POWER_OFF)
 		pci_set_power_state(pdev, PCI_D3hot);
-- 
2.17.2


