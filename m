Return-Path: <netdev+bounces-273364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPDgJzQBy2k2CgYAu9opvQ
	(envelope-from <netdev+bounces-273364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:03:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D7362360
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2B06300E4A5
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FA83B47CF;
	Mon, 30 Mar 2026 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBQH/bhM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B6382361;
	Mon, 30 Mar 2026 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911777; cv=none; b=DGHvm/SDzr7SGQrQiTYYxdeh5jSUFtWBOsOw+tjqEfOgvKVJoGdZf0JhYXHprEKEITf99rEvHeYAaqNWS0Q8k5knp/qgd+WPn2KPyKf95DvuKk0EDshV7SD+SFqy5OkNvmmeHwrwPhkaYAYNuRQPYsDJ5WZO5JOGJ18Pg+8/1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911777; c=relaxed/simple;
	bh=StCsVXFtilgxDwmQumd/9OlNzZNm50bY5SkQdRGSzQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkSpQeU/e2k7kGR7itKXY3vr+sn1TK9ATkdTn5LK4hF2xWofxhn5bvb9wfblGxGvq+3DnHvPK8bjSAwxuG/bBV4fHthvb1T94JCbsli+OD8bDQ/jHfF+6QqDM4YXonJDNexnQjz05Yh6s8cuvfC9me//y1plPS7/QU8HfrPIfVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBQH/bhM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774911775; x=1806447775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=StCsVXFtilgxDwmQumd/9OlNzZNm50bY5SkQdRGSzQI=;
  b=CBQH/bhM+ZO4OYObY28+E67UIBDfTE7PcU0jS43+qSprc1nSEN0UWvD3
   NrdeJMWUB5SdLynmWuNTqMkxUpdiwIm+WMzzEUiBF7JU8D887BlpA9Zgu
   0QTvXDgs/btw3/3nfiPX7P3yXGopUERiZ6qZYyev8nDyUNNJsQKeE1kGI
   Oe6wj7cG2kZbx2b2OkFjEaYDQMnbij/lSeZrlVYCXzmAImYcjTKh14Pld
   H3i99xbhQBuMca5lNX8bBW16ryZ3xHO10OCrxx3RFD6fUAXuCq2N6oMEt
   6sScJux388PfqVd9RhCPmtvJM65Klu8zs2Ittjry4GAZamMO0mUftHu0Z
   w==;
X-CSE-ConnectionGUID: homnb37RTIW1EBwRYH9KpQ==
X-CSE-MsgGUID: /vzQENSeSVWaJLi7mrEURg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93297549"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="93297549"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:02:52 -0700
X-CSE-ConnectionGUID: YAt7oqhWQrmoXpmTwYJfqQ==
X-CSE-MsgGUID: /GR8r7ItSS6Hke8ALKTCaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="256687707"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 30 Mar 2026 16:02:52 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	andriy.shevchenko@intel.com,
	ilpo.jarvinen@linux.intel.com,
	dima.ruinskiy@intel.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	linux-pci@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	lukas@wunner.de,
	bhelgaas@google.com,
	richardcochran@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 02/15] igc: Let the PCI core deal with the PM resume flow
Date: Mon, 30 Mar 2026 16:02:31 -0700
Message-ID: <20260330230248.646900-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
References: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,nvidia.com,kernel.org,vger.kernel.org,wunner.de,google.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273364-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 9E2D7362360
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Currently igc driver calls pci_set_power_state() and pci_restore_state()
and the like to bring the device back from low power states. However,
PCI core handles all this on behalf of the driver. Furthermore with PTM
enabled the PCI core re-enables it on resume but the driver calls
pci_restore_state() which ends up disabling it again.

For this reason let the PCI core handle the common PM resume flow.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 98024b46789f..0e785af0a3a3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7544,9 +7544,6 @@ static int __igc_resume(struct device *dev)
 	struct igc_hw *hw = &adapter->hw;
 	u32 err, val;
 
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
 	if (!pci_device_is_present(pdev))
 		return -ENODEV;
 	err = pci_enable_device_mem(pdev);
@@ -7556,9 +7553,6 @@ static int __igc_resume(struct device *dev)
 	}
 	pci_set_master(pdev);
 
-	pci_enable_wake(pdev, PCI_D3hot, 0);
-	pci_enable_wake(pdev, PCI_D3cold, 0);
-
 	if (igc_is_device_id_i226(hw))
 		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
 
-- 
2.47.1


