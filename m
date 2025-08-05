Return-Path: <netdev+bounces-211817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E333B1BCB4
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 00:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD2A16A9F2
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 22:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEF7264612;
	Tue,  5 Aug 2025 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GX7cHvSv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84A25A34D
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433315; cv=none; b=LZE6i+ONAbVmc+yahH9g7d898a+RQnA4f5EP/OUXwcMjwC3hsFriKfBAFP6falejrZ9Q4ErfkDmBMwl1UOAb/7YLC23UylvAHVCJBlIU/JXSoQ0S/QjSFLR+k2jPVqeXovR/7gKr2QYn+z62UY6T+8Xuti/6E1HxVl4fbl6MkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433315; c=relaxed/simple;
	bh=UPGvCivxFmjnIY2MQezeHrvI6YIuplJ2yTrRrIBGbqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjYj8n/xG7CyBsqkpq/U3d0ertmhUFHpdXcUfyddn1ZvA0jKjyr+cM8GxN7mQAMvR4Z9eIzQPDYJ1yq9H5kMrs2Hn+YAU/BsjOt6J4ixy/W/8TwV0kcyz2lIf7HjiwaTPjKY0fBGWlHP/5KE370TyblDqsaV3K75SO+mjlpRuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GX7cHvSv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754433314; x=1785969314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UPGvCivxFmjnIY2MQezeHrvI6YIuplJ2yTrRrIBGbqw=;
  b=GX7cHvSvgPl2Cuosy5HhVjPxuGJR7eDg1p6zptKwy8C5mcxNs5BGrRdC
   NiAYbyTJcc8P/uzXWNWU979t7iiI82/fVcXr96RUj78zLVFGVBN32bD+A
   +jxnabqfQlJRDk2wn0kJzQRFwI4VYmQxRpSxdE0DYUHftvUeFn5OW4FkE
   UjE0dUWtDsNyIOW2zCLt28WcWbHXMUKTeFJ8hxeaYbxcZpoZTFu1/edbQ
   BMWuMhIzVHou6Mo9VMtsM3ZneUK6PiqbAraAdlWvThiCl6tNInywWlAPO
   tYBTK6Lkj9hBAkazt8LrJB8SLhAQ1lxk7lpMprWCDcbHxj0P8u/6wCXPq
   g==;
X-CSE-ConnectionGUID: wPoY82raTXqBPMpSLU6u5Q==
X-CSE-MsgGUID: b6I4pv9ET1+up9j54Rp7ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56658104"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56658104"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:35:13 -0700
X-CSE-ConnectionGUID: JbEF3Fv5Rregq4R3yghnhw==
X-CSE-MsgGUID: TEltvrN4TFKWu/h+XyqXow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164515368"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 05 Aug 2025 15:33:55 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Kaplan@amd.com,
	dhowells@redhat.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net v2 2/2] ixgbe: prevent from unwanted interface name changes
Date: Tue,  5 Aug 2025 15:33:42 -0700
Message-ID: <20250805223346.3293091-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250805223346.3293091-1-anthony.l.nguyen@intel.com>
References: <20250805223346.3293091-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Users of the ixgbe driver report that after adding devlink support by
the commit a0285236ab93 ("ixgbe: add initial devlink support") their
configs got broken due to unwanted changes of interface names. It's
caused by automatic phys_port_name generation during devlink port
initialization flow.

To prevent from that set no_phys_port_name flag for ixgbe devlink ports.

Reported-by: David Howells <dhowells@redhat.com>
Closes: https://lore.kernel.org/netdev/3452224.1745518016@warthog.procyon.org.uk/
Reported-by: David Kaplan <David.Kaplan@amd.com>
Closes: https://lore.kernel.org/netdev/LV3PR12MB92658474624CCF60220157199470A@LV3PR12MB9265.namprd12.prod.outlook.com/
Fixes: a0285236ab93 ("ixgbe: add initial devlink support")
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index 54f1b83dfe42..d227f4d2a2d1 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -543,6 +543,7 @@ int ixgbe_devlink_register_port(struct ixgbe_adapter *adapter)
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
 	attrs.phys.port_number = adapter->hw.bus.func;
+	attrs.no_phys_port_name = 1;
 	ixgbe_devlink_set_switch_id(adapter, &attrs.switch_id);
 
 	devlink_port_attrs_set(devlink_port, &attrs);
-- 
2.47.1


