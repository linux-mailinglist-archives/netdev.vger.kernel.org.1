Return-Path: <netdev+bounces-306515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v+mSI2rPUGqA5QIAu9opvQ
	(envelope-from <netdev+bounces-306515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0983739E0C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:54:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=f8g3Qlj2;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306515-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306515-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F045F303A73B
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F1411699;
	Fri, 10 Jul 2026 10:54:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CE540E8FC
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:54:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680851; cv=none; b=G12NhTuGcZVkGrEt5neJxCRDpH1+t9OQWfsvZ8s5brgfw0qmJtuo9xwFwWF2+/tIvWtPqdmLZKDd8FV+F5EkxrCOV49KVQkA+yvdmOsikPXQEo3UhTBC5W9AN1+VgD5oXM1H4RR0qPMMlFe5iIhYBCDgZdJ5C8PPRsrKv6Dpgz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680851; c=relaxed/simple;
	bh=v+lj4eItScpbsuUVoYJ361waa9gsm1oFYCEJ7e2DDWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmFj6Gxzzu77chMLpPW456E6qHUZcXivy60IBXlHZXlOPv36PzyknPD4em1RJ0F3z+SyEcqMrxGy3hp70pVNnSBUIHakOzMP5sN9O38v9mZI6pKsQt2x9KlMIZsmSzCMB5WI99HtZWpwIT/kuFuSk0Q5zPUPRVOQkIC4d+Y1B8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8g3Qlj2; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783680849; x=1815216849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v+lj4eItScpbsuUVoYJ361waa9gsm1oFYCEJ7e2DDWI=;
  b=f8g3Qlj2HcSjI3phfvAyTw9xDUFSM1XCY6l+7hQK5ZXYUNDOvZYHTpNd
   aZH1EVPelVYSYcNs5Rl0AXAdutoHRAW5xvjedvUfth9foxERUWDLFhS8X
   CPgXBEg+UiGw0JjP1APjKFsWbaXJ0I5sNsI+PPX/rnL7CCG7Kyjevcjfz
   ZCe3EzOl7kCSLfD4SBsej5UMoWpaf1aKjCWFqXYemMnGsKNNlR25sEQx9
   l07c8+HjEuGgg5qVewdPrN9DP1eSdo+RGlFi2TwqJlxP+02yBPowpY+12
   Lgng1bsgaW6R3qQA65em8u4fKj1PDVrZM0Jcw3R9r4SxnofclCOZBls7Z
   g==;
X-CSE-ConnectionGUID: LaJFDV8NQtyp6yWLz/I1Ng==
X-CSE-MsgGUID: XmWsdWwBSKuMFOi2jmNcZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="86920269"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="86920269"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:54:07 -0700
X-CSE-ConnectionGUID: XEwqCZbuTB2AhqO+6IkBmw==
X-CSE-MsgGUID: lAfzOR/UQHuZ3JjkMszCVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259750960"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa005.fm.intel.com with ESMTP; 10 Jul 2026 03:54:06 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v1 2/2] ixgbe: Implement PCI reset handler
Date: Fri, 10 Jul 2026 10:54:03 +0000
Message-ID: <20260710105403.1050025-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710105403.1050025-1-sergey.temerkhanov@intel.com>
References: <20260710105403.1050025-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306515-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[sergey.temerkhanov@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergey.temerkhanov@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0983739E0C

Implement PCI device reset handler to allow the network device to
get re-initialized and function after a PCI-level reset.

This is necessary for the adapter to avoid TX queue timeouts
occurring after the PCI reset is performed via sysfs during
its operation.

The reset codepath may trigger a number of dependencies in the
reset of the driver, so that it is necessary to check if
the netdev is present and running there.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 42dac766c907..1865b604ace7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -12358,6 +12358,94 @@ static pci_ers_result_t ixgbe_io_slot_reset(struct pci_dev *pdev)
 	return result;
 }
 
+/**
+ * ixgbe_pci_reset_prepare - called before the pci bus is reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Quiesce the driver in preparation for a PCI function reset. Called from
+ * pci_dev_save_and_disable() before the core saves config state and writes
+ * PCI_COMMAND_INTX_DISABLE to clear bus mastering and MMIO decode, so MMIO
+ * access to the device is still valid here.
+ */
+static void ixgbe_pci_reset_prepare(struct pci_dev *pdev)
+{
+	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+
+	if (!adapter)
+		return;
+
+	netdev = adapter->netdev;
+
+	rtnl_lock();
+	netif_device_detach(netdev);
+	if (netif_running(netdev))
+		ixgbe_close_suspend(adapter);
+	rtnl_unlock();
+
+	/* __IXGBE_RESETTING is intentionally not set here: it is spun on
+	 * while holding rtnl by ixgbe_reinit_locked(), ixgbe_dcbnl_devreset()
+	 * and the ethtool reset paths, so holding it across the rtnl drop
+	 * would deadlock those callers against ixgbe_pci_reset_done(), which
+	 * needs to re-acquire rtnl.  During the reset window concurrent
+	 * rtnl-holding paths must treat the netdev as detached, while teardown
+	 * paths also observe __IXGBE_DOWN set by ixgbe_down() via
+	 * ixgbe_close_suspend(), matching the existing ixgbe_io_error_detected()
+	 * flow.
+	 */
+
+	if (test_bit(__IXGBE_SERVICE_INITED, &adapter->state)) {
+		/* The service timer was already stopped by ixgbe_down() via
+		 * ixgbe_close_suspend(); if the netdev was not running, the
+		 * timer is not armed.  Only the currently queued service task
+		 * (if any) still needs to be flushed here.
+		 */
+		cancel_work_sync(&adapter->service_task);
+		clear_bit(__IXGBE_SERVICE_SCHED, &adapter->state);
+	}
+}
+
+/**
+ * ixgbe_pci_reset_done - called after the pci bus has been reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Re-initialize the device after a PCI function reset. The PCI core has
+ * already called pci_restore_state() before invoking this callback, so the
+ * saved Command register (including bus mastering) is back in place.
+ */
+static void ixgbe_pci_reset_done(struct pci_dev *pdev)
+{
+	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+	bool running;
+	int err = 0;
+
+	if (!adapter)
+		return;
+
+	netdev = adapter->netdev;
+
+	rtnl_lock();
+	adapter->hw.hw_addr = adapter->io_addr;
+	ixgbe_reset(adapter);
+	IXGBE_WRITE_REG(&adapter->hw, IXGBE_WUS, ~0);
+	running = netif_running(netdev);
+	if (running) {
+		err = ixgbe_open(netdev);
+		if (err) {
+			e_dev_err("Cannot re-open netdev after PCI reset: %d. A new reset is needed.\n",
+				  err);
+			dev_close(netdev);
+		}
+	}
+	/* Restore presence so userspace can retry later. If ixgbe_open() failed,
+	 * dev_close() cleared IFF_UP first so netif_device_attach() will not wake
+	 * Tx queues without a successful open.
+	 */
+	netif_device_attach(netdev);
+	rtnl_unlock();
+}
+
 /**
  * ixgbe_io_resume - called when traffic can start flowing again.
  * @pdev: Pointer to PCI device
@@ -12390,6 +12478,8 @@ static const struct pci_error_handlers ixgbe_err_handler = {
 	.error_detected = ixgbe_io_error_detected,
 	.slot_reset = ixgbe_io_slot_reset,
 	.resume = ixgbe_io_resume,
+	.reset_prepare = ixgbe_pci_reset_prepare,
+	.reset_done = ixgbe_pci_reset_done,
 };
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ixgbe_pm_ops, ixgbe_suspend, ixgbe_resume);
-- 
2.53.0


