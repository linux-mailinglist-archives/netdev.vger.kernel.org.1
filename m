Return-Path: <netdev+bounces-179271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1BDA7BAD5
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2956F189AA9C
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948931EB5E8;
	Fri,  4 Apr 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0QlFeTA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6F1EA7C7
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762586; cv=none; b=gUPimwXvR0A6E9aoRWDrMBAw+63C9EiLWfo4YR7aECw75LIl4xa/QiWIZ2qgUE54Z6zH92qkwGKaq5hJplK3n1CQx8OyeI6ogwa6sFpEl42vSb6utNclhLwKCuBnHmBvCooUmhssfpUB9KgOWculyLHHv6NoMQOcFmdUNnKNBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762586; c=relaxed/simple;
	bh=NW3OBKs3WPyCL79JIJvILc4MYb4J04/cCYCmFvTX3qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TK9sgnoZx418MdFKdcgjHZcPKQfVKIbdj5mnc9JtfQUWm0NVHuETPDIX441Q4wCuKm4XlhhhfXC9RShgfdNGow8qYK0wQRrYgVzIzoPcO3MhE73NhqZILdPjX5/17sfgvUSFJuryZ0XVKSFvrfzn9UBdVOwzkPjkATglzZ2qbTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0QlFeTA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743762584; x=1775298584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NW3OBKs3WPyCL79JIJvILc4MYb4J04/cCYCmFvTX3qU=;
  b=K0QlFeTARUDa2M6xFBp/kjJ03r/2X9fZGI4bV+wBaSbZKVDVuNkc3KTs
   1oTgkUqMg89K5Kp+27ciGZfkhqAJ9ARKfidYn/TFyVP5/zbjsIn0zsNLL
   IO1k6K3/Yzcvh0ooopnG6Nir8GoYL2MUcgNFTp5mfvTV8vAd/Og8ZrevP
   RiRWezV/+wYPPjseigL4J4LBdtCRNK0J+gYr/mv+HdHw5jcrXR3MhEMNW
   setB6PDC+5P0Qa3I+j184FIgWRrkVhyz2vEvJp9DCBG1C7rzefTe1aGzE
   aBp6V2K/ILFN31fkJ5gyg0J06T695AGpLI8iKmRRniDkofm0ci5JSnF/B
   A==;
X-CSE-ConnectionGUID: W4cnwIEURl2baAN3fbZJRw==
X-CSE-MsgGUID: Sf14pXuMQNuWQRI1OASK7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="48992430"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="48992430"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:29:43 -0700
X-CSE-ConnectionGUID: NnJR/y/7TrG1X2gTytrqMQ==
X-CSE-MsgGUID: g0qWmz3eTmSxqKp3E4ZJ2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="164485290"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 04 Apr 2025 03:29:41 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2B4DA33E9C;
	Fri,  4 Apr 2025 11:29:40 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stefan Assmann <sassmann@kpanic.de>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH iwl-net 1/6] iavf: iavf_suspend(): take RTNL before netdev_lock()
Date: Fri,  4 Apr 2025 12:23:16 +0200
Message-Id: <20250404102321.25846-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250404102321.25846-1-przemyslaw.kitszel@intel.com>
References: <20250404102321.25846-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an obvious violation of lock ordering.
Jakub's [1] added netdev_lock() call that is wrong ordered wrt RTNL,
but the Fixes tag points to crit_lock being wrongly placed (by lockdep
standards).

Actual reason we got it wrong is dated back to critical section managed by
pure flag checks, which is with us since the very beginning.

[1] afc664987ab3 ("eth: iavf: extend the netdev_lock usage")
Fixes: 5ac49f3c2702 ("iavf: use mutexes for locking of critical sections")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
CC: Stefan Assmann <sassmann@kpanic.de>
CC: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 6d7ba4d67a19..a77c72643528 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5596,22 +5596,27 @@ static int iavf_suspend(struct device *dev_d)
 {
 	struct net_device *netdev = dev_get_drvdata(dev_d);
 	struct iavf_adapter *adapter = netdev_priv(netdev);
+	bool running;
 
 	netif_device_detach(netdev);
 
+	running = netif_running(netdev);
+	if (running)
+		rtnl_lock();
+
 	netdev_lock(netdev);
 	mutex_lock(&adapter->crit_lock);
 
-	if (netif_running(netdev)) {
-		rtnl_lock();
+	if (running)
 		iavf_down(adapter);
-		rtnl_unlock();
-	}
+
 	iavf_free_misc_irq(adapter);
 	iavf_reset_interrupt_capability(adapter);
 
 	mutex_unlock(&adapter->crit_lock);
 	netdev_unlock(netdev);
+	if (running)
+		rtnl_unlock();
 
 	return 0;
 }
-- 
2.39.3


