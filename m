Return-Path: <netdev+bounces-129111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0204297D8A4
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 18:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03211F23E1B
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F317E8F7;
	Fri, 20 Sep 2024 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4kwWWRz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6034A1442F4
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851398; cv=none; b=o17ZSVxzDZQRKWukx6fKwgWeexDYWkbNjoDU9unfZ74dJtMDd65ndqVhYnnu6a9WKiUM1HL1ARw+YhvKZtlulK+AixVblfH47JUDhD8vUjfd08ps61b7hMKQ4J7DR/+4xVQO6KPgOCzstnujjDDCSAml0wOzuE3pevmi/y4ss1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851398; c=relaxed/simple;
	bh=Nh6mv2oBHb6+3x6OvpdB6dRt4qnb/Og0Cfl844iEMEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KR8ZuB/naAc90/1TvOmqdrGT1Jau/hIuGLK6iDK96WmJhX4RHA0k9OJ9aIoaxEASM/AyRiWOI4U7qCxYxzAPVU+U/YyCOFpone6nJW5jxmsogu1j9raITI/p8xoq1zNpheMlq31nE9v+ZvRmUybWSKEWjLZz1YidwV2yzb3UpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4kwWWRz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726851398; x=1758387398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nh6mv2oBHb6+3x6OvpdB6dRt4qnb/Og0Cfl844iEMEI=;
  b=X4kwWWRzFBYFFuKd2qzqQSDEKk1grpcQ3NxKATIEGX0VEfkPx8mj8KZp
   7GF9fgIeWrFRd9kF5EMP5YKTh0pTSDf/XGMO8ve7Bd1Z78wXxH8TOHmeE
   75VEOqaxM++Rj/B8lIKOXKqsI+6CizQlIacIGBGI/zPrgmWFyLYRkSrMj
   hFw4oIRLyAunc60hQiMG+RGuFSRk7rIaA2IvysaYxZyjSlqoSLNXbX6Oz
   npcVlt9o8PbfnraMXVU1ZOqyA/Md6fW+X0v8no7MblPZ5eJWvJ+cPjRVC
   nq/c7O/9FJ+Rn75DB/E2BnHZPMTpR0a48w0TcVsOOFcktLHdxLMOqpEk2
   Q==;
X-CSE-ConnectionGUID: vl4b6dXiTHWRY2WYgcTSSQ==
X-CSE-MsgGUID: 2bV5q+HyTXekMxczEGT6wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="25813931"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25813931"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 09:56:37 -0700
X-CSE-ConnectionGUID: o9BcRg3NQJCMVsHwBLFplQ==
X-CSE-MsgGUID: SN4S7695QtSOf9iEZ7aKcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="101100626"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 20 Sep 2024 09:56:35 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3B10827BD5;
	Fri, 20 Sep 2024 17:56:33 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	mateusz.polchlopek@intel.com,
	maciej.fijalkowski@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v2 2/2] ice: Fix netif_is_ice() in Safe Mode
Date: Fri, 20 Sep 2024 18:59:18 +0200
Message-ID: <20240920165916.9592-4-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240920165916.9592-3-marcin.szycik@linux.intel.com>
References: <20240920165916.9592-3-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netif_is_ice() works by checking the pointer to netdev ops. However, it
only checks for the default ice_netdev_ops, not ice_netdev_safe_mode_ops,
so in Safe Mode it always returns false, which is unintuitive. While it
doesn't look like netif_is_ice() is currently being called anywhere in Safe
Mode, this could change and potentially lead to unexpected behaviour.

Fixes: df006dd4b1dc ("ice: Add initial support framework for LAG")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index aeebf4ae25ae..f0f27e78bde9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -87,7 +87,8 @@ ice_indr_setup_tc_cb(struct net_device *netdev, struct Qdisc *sch,
 
 bool netif_is_ice(const struct net_device *dev)
 {
-	return dev && (dev->netdev_ops == &ice_netdev_ops);
+	return dev && (dev->netdev_ops == &ice_netdev_ops ||
+		       dev->netdev_ops == &ice_netdev_safe_mode_ops);
 }
 
 /**
-- 
2.45.0


