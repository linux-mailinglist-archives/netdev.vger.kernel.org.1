Return-Path: <netdev+bounces-116131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DDC94932C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBDD1F25054
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EF81D27A3;
	Tue,  6 Aug 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCGoDHnC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A11C3789
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954896; cv=none; b=uqB2f3kolLfHJJghXdj/PE+u6bxZN/Mnk5SIf5Y+kf3h1uK9xxMmH5P3vKjujPRl9RWJg98cLiOzji6WJRWRZVMDhueWhZkGK/JFMpxxzIgsvyaKXHQjmEEz4rJv7PDu3XFeHvBTLnrTvaZNHdpSh4CPxKPpmlhAYnwCAkK/stI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954896; c=relaxed/simple;
	bh=gF3KbyWMt7RLSqbMQB9ay8P9po3XOk7tPnnw9LpN3L0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=acKjeSGgGEsuabC9XmRXUhIqnJbmOWaE/YO2BQpM0OPObd2A2kRYJQTS47MRNfp6FPLhz7+J+XBG0ECJtlqHQsqA/bpECxBR0UW7pJwV9/1fr3+Bh4/vd3h0+r4iO+/b23/0mpFwiCsdsYveJ+vaILk0q6Zf/zrePbBYV4u6JaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCGoDHnC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722954895; x=1754490895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gF3KbyWMt7RLSqbMQB9ay8P9po3XOk7tPnnw9LpN3L0=;
  b=CCGoDHnCVNAYRg7zztSu0WrEQ408TaeHkVfaz0VTJtTkT7XyLs1wnhRy
   5L8P5OqG/hFTEqZ5dut+bqxxh5BJk9gdf/DKvi5Y7aagBjARoHb5voSEY
   gnHb8D5eMt2yzMa+RmH5ObLMR8rHayNVaT44US26BUaJ2ojbnQ+lzNktS
   CWtR6WvSzHPz3LDcau4b2bXOqQyToG2nQdJLMB4hv8CjPq7QkfO85pOz+
   4rBZZm93gok5zzpv1x76Omd47mAaOi3685WTN/ySiZBwpPO6F1ko3PCu1
   PP6E7xzILYnxkVDAswwRhJZ40w6k9VpDXT4rOrT8qNVA5YFAdEzWWwDKk
   w==;
X-CSE-ConnectionGUID: 9KvonjZTQnuxySrLs3Wu/g==
X-CSE-MsgGUID: E/KPJAw2SDaumH4Q5gZpuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38428596"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38428596"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:34:53 -0700
X-CSE-ConnectionGUID: TS0pstdTRmqGpSV7qtqWDg==
X-CSE-MsgGUID: LVfcf6CDScGPK7chXZc++Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56502655"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2024 07:34:49 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6E6F32879E;
	Tue,  6 Aug 2024 15:34:47 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net-next 3/5] devlink: remove unused devlink_resource_register()
Date: Tue,  6 Aug 2024 16:33:05 +0200
Message-Id: <20240806143307.14839-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused devlink_resource_register(); all the drivers use
devl_resource_register() variant instead.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/net/devlink.h  |  6 ------
 net/devlink/resource.c | 33 ---------------------------------
 2 files changed, 39 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index fdd6a0f9891d..fbb9a2668e24 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1779,12 +1779,6 @@ int devl_resource_register(struct devlink *devlink,
 			   u64 resource_id,
 			   u64 parent_resource_id,
 			   const struct devlink_resource_size_params *size_params);
-int devlink_resource_register(struct devlink *devlink,
-			      const char *resource_name,
-			      u64 resource_size,
-			      u64 resource_id,
-			      u64 parent_resource_id,
-			      const struct devlink_resource_size_params *size_params);
 void devl_resources_unregister(struct devlink *devlink);
 void devlink_resources_unregister(struct devlink *devlink);
 int devl_resource_size_get(struct devlink *devlink,
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 6ae4b2080399..15efa9f49461 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -384,39 +384,6 @@ int devl_resource_register(struct devlink *devlink,
 }
 EXPORT_SYMBOL_GPL(devl_resource_register);
 
-/**
- *	devlink_resource_register - devlink resource register
- *
- *	@devlink: devlink
- *	@resource_name: resource's name
- *	@resource_size: resource's size
- *	@resource_id: resource's id
- *	@parent_resource_id: resource's parent id
- *	@size_params: size parameters
- *
- *	Generic resources should reuse the same names across drivers.
- *	Please see the generic resources list at:
- *	Documentation/networking/devlink/devlink-resource.rst
- *
- *	Context: Takes and release devlink->lock <mutex>.
- */
-int devlink_resource_register(struct devlink *devlink,
-			      const char *resource_name,
-			      u64 resource_size,
-			      u64 resource_id,
-			      u64 parent_resource_id,
-			      const struct devlink_resource_size_params *size_params)
-{
-	int err;
-
-	devl_lock(devlink);
-	err = devl_resource_register(devlink, resource_name, resource_size,
-				     resource_id, parent_resource_id, size_params);
-	devl_unlock(devlink);
-	return err;
-}
-EXPORT_SYMBOL_GPL(devlink_resource_register);
-
 static void devlink_resource_unregister(struct devlink *devlink,
 					struct devlink_resource *resource)
 {
-- 
2.39.3


