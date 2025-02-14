Return-Path: <netdev+bounces-166515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C76BA3647D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF033B4604
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E53269804;
	Fri, 14 Feb 2025 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwAqEiPn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172572690FC
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553648; cv=none; b=CdnnNqkqecsx1fG2iCbXlZ4WbMFKsOyYP087d5tXiZ8THDQ7HNa2WFpIIhJ7eUgHxYNYlZrbfLbsEqcGyJgdNigd1KYyzsjA7LHd23v/sHIqHI0bMiywv4um6eS0zQC2MeJfPG8orn7Uck9Ie+DQ+PFjWBhss4zslR5oqeh4Tjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553648; c=relaxed/simple;
	bh=c7VfgXKHp1OZBgXtuywg0L2o48OTJ5wlU6SbWNc1s2k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QVWrpFLF0F3FqC3eA4nv8fikwf9Kh2+GM4kEru/F34x6FDd1MXuh0dWToIZLzxvbzBhxbsaA5VRQJJy7ar5qgZbdR27vfKp07kHih8c/T7WugzTBdS+Nt/RRbH7ojoEWqDqXBcTNqmM5oEEFhhHq/OK+7zoLr9msKB9JWWYWH4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwAqEiPn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739553647; x=1771089647;
  h=from:to:cc:subject:date:message-id;
  bh=c7VfgXKHp1OZBgXtuywg0L2o48OTJ5wlU6SbWNc1s2k=;
  b=GwAqEiPn9bYS/dKamH4NaGykhftUg+tsKbQzT6jjjKsSiikyGzxbkDG7
   cYu2VQjKoEcuYCaHkqcSYxRK7AkgnqHHr7gZdXPEAgaryuwwyw/FhymYz
   h8PdSqsxmSUy/aaJZI6hsN/eMvKupMKoSRALFn4KzYmP72Lh7Y2nqfiUS
   9+h39CD4K1bVyfozPdQcTMSieybeQf4t660qTGdMCeB2V/Er2DulKUJ8B
   HdnOraihRk362Yw7geD8waK5UhTxJL3konzG6qVZvAyy260q4C+2/CRu8
   lkK3Z3NwWcXNy/8L3qZ1hppVjxtaJFS5YpP/qqlreDJA6SsATxVF7bIMY
   A==;
X-CSE-ConnectionGUID: aYq2238ySDu6HCBn6PHhCA==
X-CSE-MsgGUID: 6zCPnCYXQ52FgVpNw23OMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40434011"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40434011"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:20:46 -0800
X-CSE-ConnectionGUID: sQb1IXE0QfGcsCoFStU+gQ==
X-CSE-MsgGUID: trJRopkRRpe1+E2xLqg3cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="114146891"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2025 09:20:45 -0800
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
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [PATCH iwl-net v2] idpf: check error for register_netdev() on init
Date: Fri, 14 Feb 2025 09:18:16 -0800
Message-Id: <20250214171816.30562-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Current init logic ignores the error code from register_netdev(),
which will cause WARN_ON() on attempt to unregister it, if there was one,
and there is no info for the user that the creation of the netdev failed.

WARNING: CPU: 89 PID: 6902 at net/core/dev.c:11512 unregister_netdevice_many_notify+0x211/0x1a10
...
[ 3707.563641]  unregister_netdev+0x1c/0x30
[ 3707.563656]  idpf_vport_dealloc+0x5cf/0xce0 [idpf]
[ 3707.563684]  idpf_deinit_task+0xef/0x160 [idpf]
[ 3707.563712]  idpf_vc_core_deinit+0x84/0x320 [idpf]
[ 3707.563739]  idpf_remove+0xbf/0x780 [idpf]
[ 3707.563769]  pci_device_remove+0xab/0x1e0
[ 3707.563786]  device_release_driver_internal+0x371/0x530
[ 3707.563803]  driver_detach+0xbf/0x180
[ 3707.563816]  bus_remove_driver+0x11b/0x2a0
[ 3707.563829]  pci_unregister_driver+0x2a/0x250

Introduce an error check and log the vport number and error code.
On removal make sure to check VPORT_REG_NETDEV flag prior to calling
unregister and free on the netdev.

Add local variables for idx, vport_config and netdev for readability.

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
Changelog:
v2:
- Refactored a bit to avoid >80 char lines.
- Changed the netdev and flag check to allow for early continue in the
  max_vports loop, which also helps to reduce the identation.

v1:
https://lore.kernel.org/intel-wired-lan/20250211023851.21090-1-emil.s.tantilov@intel.com/

---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 31 +++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a3d6b8f198a8..a055a47449f1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -927,15 +927,19 @@ static int idpf_stop(struct net_device *netdev)
 static void idpf_decfg_netdev(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
+	u16 idx = vport->idx;
 
 	kfree(vport->rx_ptype_lkup);
 	vport->rx_ptype_lkup = NULL;
 
-	unregister_netdev(vport->netdev);
-	free_netdev(vport->netdev);
+	if (test_and_clear_bit(IDPF_VPORT_REG_NETDEV,
+			       adapter->vport_config[idx]->flags)) {
+		unregister_netdev(vport->netdev);
+		free_netdev(vport->netdev);
+	}
 	vport->netdev = NULL;
 
-	adapter->netdevs[vport->idx] = NULL;
+	adapter->netdevs[idx] = NULL;
 }
 
 /**
@@ -1536,13 +1540,22 @@ void idpf_init_task(struct work_struct *work)
 	}
 
 	for (index = 0; index < adapter->max_vports; index++) {
-		if (adapter->netdevs[index] &&
-		    !test_bit(IDPF_VPORT_REG_NETDEV,
-			      adapter->vport_config[index]->flags)) {
-			register_netdev(adapter->netdevs[index]);
-			set_bit(IDPF_VPORT_REG_NETDEV,
-				adapter->vport_config[index]->flags);
+		struct net_device *netdev = adapter->netdevs[index];
+		struct idpf_vport_config *vport_config;
+
+		vport_config = adapter->vport_config[index];
+
+		if (!netdev ||
+		    test_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags))
+			continue;
+
+		err = register_netdev(netdev);
+		if (err) {
+			dev_err(&pdev->dev, "failed to register netdev for vport %d: %pe\n",
+				index, ERR_PTR(err));
+			continue;
 		}
+		set_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags);
 	}
 
 	/* As all the required vports are created, clear the reset flag
-- 
2.17.2


