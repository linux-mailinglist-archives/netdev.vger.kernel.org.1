Return-Path: <netdev+bounces-187759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36A2AA98A1
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B155617B829
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95971269AFD;
	Mon,  5 May 2025 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G39OUPaI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88CD6F30C
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461990; cv=none; b=Su7Vvmn0xbe0aFd9OQSreAWXjQvpQEnW8UELQAxCe4avvq/FJpHWX8H9GS6Pid75FjteVfKXsyPkgmQ9cADb1kszz6DZMdXLIgnav+ZA1LhyO13x9WOkG16+EpBK62ZDIH2zW6vF3GQcjW1ND1cJyNfB53SYo4sg66TSwKnMZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461990; c=relaxed/simple;
	bh=TLGx2zXG4R5RwLk/UaHbeOUNlqg+YLAi7dg7YS5VLMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1OWM/l6sMuR442siMA4ShG+sQqGMWJEOnmuG2CDWccDWHNsiJmiMqPKk8f04F49lWxmD8/5LwJV51Tc9USZiTEsMYkrNc8Qa7YGGmbl1ZEdS0++eArkWk5wt3JYcSa1Q24CXRx+o6MyrNdbVz/eDxKEY9vnUw6ZFRCqdXdzUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G39OUPaI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746461988; x=1777997988;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TLGx2zXG4R5RwLk/UaHbeOUNlqg+YLAi7dg7YS5VLMw=;
  b=G39OUPaIawA2CZa3BYsZXMXYXa3zHK7wnqixB8MZTdE3xZhEvVw89Qeu
   X/5mq/4uKMy3iPw8RrB4SAa0LXgT7chJc7ck4feeEe+c2JJ9Qva9QV1mP
   Sxp46I1enfdFRFopDcGOy2GvoB+Eq7O4oZ0a0mqOCIPhfa5Y/tdL5Yebk
   /edSrb/HW55lq6MqAioPveaY4uSFiSzZVfTppSeCcm40aw58gJaPM7f51
   BYIFruYpV37RzAEGoHZxYYZbkeYkF8tqgh2eBG/LWpe71zMiL1mmguiJK
   BTe0U6PDnaXZ3VEUbO0xy/N8+3r9KE+TwpRY2g+IShfkBOOG8gjR23A79
   g==;
X-CSE-ConnectionGUID: OX9HGmAHQvG89NwdHt/kTw==
X-CSE-MsgGUID: kZl5hVhVQ2KrGEyf/cIj9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47187075"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47187075"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 09:19:47 -0700
X-CSE-ConnectionGUID: dxbsDDWORMSte9Wtdrqabg==
X-CSE-MsgGUID: EdkXhvHzSOaGq0Dmjzgp1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135811630"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 05 May 2025 09:19:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	karol.kolacinski@intel.com,
	sergey.temerkhanov@intel.com,
	michal.kubiak@intel.com,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	mschmidt@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net] ice: use DSN instead of PCI BDF for ice_adapter index
Date: Mon,  5 May 2025 09:19:38 -0700
Message-ID: <20250505161939.2083581-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Use Device Serial Number instead of PCI bus/device/function for
the index of struct ice_adapter.

Functions on the same physical device should point to the very same
ice_adapter instance, but with two PFs, when at least one of them is
PCI-e passed-through to a VM, it is no longer the case - PFs will get
seemingly random PCI BDF values, and thus indices, what finally leds to
each of them being on their own instance of ice_adapter. That causes them
to don't attempt any synchronization of the PTP HW clock usage, or any
other future resources.

DSN works nicely in place of the index, as it is "immutable" in terms of
virtualization.

Fixes: 0e2bddf9e5f9 ("ice: add ice_adapter for shared data across PFs on the same NIC")
Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Jiri Pirko <jiri@resnulli.us>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
IWL: https://lore.kernel.org/intel-wired-lan/20250414131241.122855-1-przemyslaw.kitszel@intel.com/

 drivers/net/ethernet/intel/ice/ice_adapter.c | 47 ++++++++------------
 drivers/net/ethernet/intel/ice/ice_adapter.h |  6 ++-
 2 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 01a08cfd0090..66e070095d1b 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // SPDX-FileCopyrightText: Copyright Red Hat
 
-#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -14,32 +13,16 @@
 static DEFINE_XARRAY(ice_adapters);
 static DEFINE_MUTEX(ice_adapters_mutex);
 
-/* PCI bus number is 8 bits. Slot is 5 bits. Domain can have the rest. */
-#define INDEX_FIELD_DOMAIN GENMASK(BITS_PER_LONG - 1, 13)
-#define INDEX_FIELD_DEV    GENMASK(31, 16)
-#define INDEX_FIELD_BUS    GENMASK(12, 5)
-#define INDEX_FIELD_SLOT   GENMASK(4, 0)
-
-static unsigned long ice_adapter_index(const struct pci_dev *pdev)
+static unsigned long ice_adapter_index(u64 dsn)
 {
-	unsigned int domain = pci_domain_nr(pdev->bus);
-
-	WARN_ON(domain > FIELD_MAX(INDEX_FIELD_DOMAIN));
-
-	switch (pdev->device) {
-	case ICE_DEV_ID_E825C_BACKPLANE:
-	case ICE_DEV_ID_E825C_QSFP:
-	case ICE_DEV_ID_E825C_SFP:
-	case ICE_DEV_ID_E825C_SGMII:
-		return FIELD_PREP(INDEX_FIELD_DEV, pdev->device);
-	default:
-		return FIELD_PREP(INDEX_FIELD_DOMAIN, domain) |
-		       FIELD_PREP(INDEX_FIELD_BUS,    pdev->bus->number) |
-		       FIELD_PREP(INDEX_FIELD_SLOT,   PCI_SLOT(pdev->devfn));
-	}
+#if BITS_PER_LONG == 64
+	return dsn;
+#else
+	return (u32)dsn ^ (u32)(dsn >> 32);
+#endif
 }
 
-static struct ice_adapter *ice_adapter_new(void)
+static struct ice_adapter *ice_adapter_new(u64 dsn)
 {
 	struct ice_adapter *adapter;
 
@@ -47,6 +30,7 @@ static struct ice_adapter *ice_adapter_new(void)
 	if (!adapter)
 		return NULL;
 
+	adapter->device_serial_number = dsn;
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	refcount_set(&adapter->refcount, 1);
 
@@ -77,23 +61,26 @@ static void ice_adapter_free(struct ice_adapter *adapter)
  * Return:  Pointer to ice_adapter on success.
  *          ERR_PTR() on error. -ENOMEM is the only possible error.
  */
-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 {
-	unsigned long index = ice_adapter_index(pdev);
+	u64 dsn = pci_get_dsn(pdev);
 	struct ice_adapter *adapter;
+	unsigned long index;
 	int err;
 
+	index = ice_adapter_index(dsn);
 	scoped_guard(mutex, &ice_adapters_mutex) {
 		err = xa_insert(&ice_adapters, index, NULL, GFP_KERNEL);
 		if (err == -EBUSY) {
 			adapter = xa_load(&ice_adapters, index);
 			refcount_inc(&adapter->refcount);
+			WARN_ON_ONCE(adapter->device_serial_number != dsn);
 			return adapter;
 		}
 		if (err)
 			return ERR_PTR(err);
 
-		adapter = ice_adapter_new();
+		adapter = ice_adapter_new(dsn);
 		if (!adapter)
 			return ERR_PTR(-ENOMEM);
 		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
@@ -110,11 +97,13 @@ struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
  *
  * Context: Process, may sleep.
  */
-void ice_adapter_put(const struct pci_dev *pdev)
+void ice_adapter_put(struct pci_dev *pdev)
 {
-	unsigned long index = ice_adapter_index(pdev);
+	u64 dsn = pci_get_dsn(pdev);
 	struct ice_adapter *adapter;
+	unsigned long index;
 
+	index = ice_adapter_index(dsn);
 	scoped_guard(mutex, &ice_adapters_mutex) {
 		adapter = xa_load(&ice_adapters, index);
 		if (WARN_ON(!adapter))
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index e233225848b3..ac15c0d2bc1a 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -32,6 +32,7 @@ struct ice_port_list {
  * @refcount: Reference count. struct ice_pf objects hold the references.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
+ * @device_serial_number: DSN cached for collision detection on 32bit systems
  */
 struct ice_adapter {
 	refcount_t refcount;
@@ -40,9 +41,10 @@ struct ice_adapter {
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
+	u64 device_serial_number;
 };
 
-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
-void ice_adapter_put(const struct pci_dev *pdev);
+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
+void ice_adapter_put(struct pci_dev *pdev);
 
 #endif /* _ICE_ADAPTER_H */
-- 
2.47.1


