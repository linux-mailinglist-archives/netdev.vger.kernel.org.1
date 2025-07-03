Return-Path: <netdev+bounces-203784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47110AF72CE
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24CD1C83307
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1962E4983;
	Thu,  3 Jul 2025 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nuzt0dvx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5352E3B0D
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543204; cv=none; b=lwZKQzOXbxjrrW4tZCtGz/DubbDJTWUn4zXMrGhYIf0mqlSjplAV5oalaUkjIJxcwHMkIiFcxUb73U7wNga1PnPPQh8n6ddIYo4aoHXI/leCE7+rYOB7H6fj6aN3ZCyc6VJypkiLOUnsqJYANhkW9gzDk4UGc897VH7lUAeshpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543204; c=relaxed/simple;
	bh=KZQ0phePQAB4080RNDczJJT3Ff0gY6JEBjYAn+tJzi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmbib/1OmROwSDd1CzjBCm4nyuLbGHect2f0rWj8ocJw22fKLtHiKtnvgbKI2ug4r0aAcoYLEuvxoxYbfDVeWw9EgddBsq3mxagvpLmB02mFMlLQhx6lvqB4n32bY+Ul89LyIA9Rel+z4s6uxembDLRtQl1I5IfyiHfWSMWqYcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nuzt0dvx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751543204; x=1783079204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KZQ0phePQAB4080RNDczJJT3Ff0gY6JEBjYAn+tJzi8=;
  b=Nuzt0dvxqhYrK6RfHP6FNQrN+LJzki2ZhqEx7sY6wCpnHo1E4eKWRAIH
   4UlYsVSt13gMGfN9QeH7bBB79b+2xZBBzmhzn4FFA+6Y7OM3OypDDokyo
   tWbbPYfBihn2E1fXg6Sd2fLxiYewSpu6veCS3NcMoJnMJlZ1GR5m3RUZl
   lXBz5cCZXIQUP02LjtGkZehd8AlQ+Hced7/ypodXc5R8D7YYBxeJNgEKD
   gGfl0s6tZ5XNdJy+elDbxZTa3HURbiLdHEkD/+OB4YUg/B9TRqxkEQs3U
   xG5aA+yA48J7q78EDKCiOLxAiZQZ7RZBRa9tWqSA7dX7SUEGavnZu7fEI
   w==;
X-CSE-ConnectionGUID: PA7teV8tQOKvBtUOwXSUrw==
X-CSE-MsgGUID: x1WK5HuPQRyl33+j8Vy2JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="76411126"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="76411126"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 04:46:43 -0700
X-CSE-ConnectionGUID: WitRaSFrRIKq6SVESFwcMA==
X-CSE-MsgGUID: poo7VvSxTBKyx4CmnSkXVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="153780339"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa006.jf.intel.com with ESMTP; 03 Jul 2025 04:46:41 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	david.kaplan@amd.com,
	dhowells@redhat.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	David Kaplan <David.Kaplan@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v1 2/2] ixgbe: prevent from unwanted interfaces names changes
Date: Thu,  3 Jul 2025 13:30:22 +0200
Message-Id: <20250703113022.1451223-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250703113022.1451223-1-jedrzej.jagielski@intel.com>
References: <20250703113022.1451223-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users of the ixgbe drivers report that after adding devlink
support by the commit a0285236ab93 ("ixgbe: add initial devlink support")
their configs got broken due to unwanted changes of interfaces names.
It's caused by changing names by devlink port initialization flow.

To prevent from that add an empty implementation of ndo_get_phys_port_name
callback.

Reported-by: David Howells <dhowells@redhat.com>
Closes: https://lkml.org/lkml/2025/4/24/2052
Reported-by: David Kaplan <David.Kaplan@amd.com>
Closes:https://www.spinics.net/lists/netdev/msg1099410.html
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Fixes: a0285236ab93 ("ixgbe: add initial devlink support")
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 48063586063c..e63a1831e661 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11043,6 +11043,12 @@ static int ixgbe_xdp_xmit(struct net_device *dev, int n,
 	return nxmit;
 }
 
+static int ixgbe_get_phys_port_name(struct net_device *netdev, char *name, size_t len)
+{
+	/* Avoid devlink adding unwanted suffix to interface name. */
+	return 0;
+}
+
 static const struct net_device_ops ixgbe_netdev_ops = {
 	.ndo_open		= ixgbe_open,
 	.ndo_stop		= ixgbe_close,
@@ -11088,6 +11094,7 @@ static const struct net_device_ops ixgbe_netdev_ops = {
 	.ndo_bpf		= ixgbe_xdp,
 	.ndo_xdp_xmit		= ixgbe_xdp_xmit,
 	.ndo_xsk_wakeup         = ixgbe_xsk_wakeup,
+	.ndo_get_phys_port_name = ixgbe_get_phys_port_name,
 };
 
 static void ixgbe_disable_txr_hw(struct ixgbe_adapter *adapter,
-- 
2.31.1


