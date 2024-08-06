Return-Path: <netdev+bounces-116130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4180094932B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1931F25082
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380B21C3F0B;
	Tue,  6 Aug 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjVMwRL4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE661BE875
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954895; cv=none; b=cdPZiq4mylWI/fPqxu+x6qz7bB79RlIZ6doCDw3tRbDdlEWckoKYF7xMj+OSqkyj4D+nTizreFJxSW/onTZ0274aToKorg+2diD//Aj7M/3MGEZaxtP6hJHryfn73SGHyJoX/2T5tI53/gJQ3bma44QbjINLlH9LieLuKN9RYs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954895; c=relaxed/simple;
	bh=hvJcyTQU8clBOnn9VsyeWAQ6y5rQrHzJ6jXZvpaL/GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wi498xRfBcfjmvGuZEbZQYo6Juu8b7xXtYSUzmB8rhNilRI7BaXqWzJnxt0U55rpVZRZCa0hfanqIMSUnXnjHkCuAIGvznHKUxIb9it7y8wU6CRKrZR7OJFN5rBobDrAeHkJ44CcayLlP7He6vOJjrx0TR5SUGPY3NeG4kKK/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjVMwRL4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722954894; x=1754490894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hvJcyTQU8clBOnn9VsyeWAQ6y5rQrHzJ6jXZvpaL/GA=;
  b=LjVMwRL4NpcfXQwKtfIT3PUzkMi20+y/1vy9k7TIA1CoUNFDSe65Rzyn
   a+sBhviXsOHHWwrzyCLCzCXzf0y8bTvQN75pUvAme9wGfBbODh87smB7Q
   uUTRLITAPamxlAtvWqfjVY9wBOlyaRi6o2lz0r72cGs+SnDa1nNuPoYOt
   dUruIHI/6dCyj++UID8yZqhCxNOnl0uMjP/HfDO4ttxjuo3rBHHaJbwbJ
   ILTHY5ZIl7x+d2/CN+dGoXROgBGomNJtoxJkj4svPPpfTQFSyEQs4HsGi
   +Qy9KRU/XX50ngZDu4+43cClLKLdLVeWBoz4UzWPVrKiAyr0f45EDFo0i
   w==;
X-CSE-ConnectionGUID: jruYfb/TSVOXl1rJun007Q==
X-CSE-MsgGUID: aKxIoWZEQU2Y1G4loVtyIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38428585"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38428585"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:34:52 -0700
X-CSE-ConnectionGUID: CWdc+eIbRQSCGiDvEFg6FA==
X-CSE-MsgGUID: fNcRvlaOR+2NRnb37rwVkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56502651"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2024 07:34:48 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4155728796;
	Tue,  6 Aug 2024 15:34:46 +0100 (IST)
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
Subject: [PATCH net-next 2/5] devlink: remove unused devlink_resource_occ_get_register() and _unregister()
Date: Tue,  6 Aug 2024 16:33:04 +0200
Message-Id: <20240806143307.14839-3-przemyslaw.kitszel@intel.com>
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

Remove not used devlink_resource_occ_get_register() and
devlink_resource_occ_get_unregister() functions; current devlink resource
users are fine with devl_ variants of the two.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/net/devlink.h  |  7 -------
 net/devlink/resource.c | 39 ---------------------------------------
 2 files changed, 46 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index db5eff6cb60f..fdd6a0f9891d 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1797,15 +1797,8 @@ void devl_resource_occ_get_register(struct devlink *devlink,
 				    u64 resource_id,
 				    devlink_resource_occ_get_t *occ_get,
 				    void *occ_get_priv);
-void devlink_resource_occ_get_register(struct devlink *devlink,
-				       u64 resource_id,
-				       devlink_resource_occ_get_t *occ_get,
-				       void *occ_get_priv);
 void devl_resource_occ_get_unregister(struct devlink *devlink,
 				      u64 resource_id);
-
-void devlink_resource_occ_get_unregister(struct devlink *devlink,
-					 u64 resource_id);
 int devl_params_register(struct devlink *devlink,
 			 const struct devlink_param *params,
 			 size_t params_count);
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 594c8aeb3bfa..6ae4b2080399 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -516,28 +516,6 @@ void devl_resource_occ_get_register(struct devlink *devlink,
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_register);
 
-/**
- *	devlink_resource_occ_get_register - register occupancy getter
- *
- *	@devlink: devlink
- *	@resource_id: resource id
- *	@occ_get: occupancy getter callback
- *	@occ_get_priv: occupancy getter callback priv
- *
- *	Context: Takes and release devlink->lock <mutex>.
- */
-void devlink_resource_occ_get_register(struct devlink *devlink,
-				       u64 resource_id,
-				       devlink_resource_occ_get_t *occ_get,
-				       void *occ_get_priv)
-{
-	devl_lock(devlink);
-	devl_resource_occ_get_register(devlink, resource_id,
-				       occ_get, occ_get_priv);
-	devl_unlock(devlink);
-}
-EXPORT_SYMBOL_GPL(devlink_resource_occ_get_register);
-
 /**
  * devl_resource_occ_get_unregister - unregister occupancy getter
  *
@@ -560,20 +538,3 @@ void devl_resource_occ_get_unregister(struct devlink *devlink,
 	resource->occ_get_priv = NULL;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
-
-/**
- *	devlink_resource_occ_get_unregister - unregister occupancy getter
- *
- *	@devlink: devlink
- *	@resource_id: resource id
- *
- *	Context: Takes and release devlink->lock <mutex>.
- */
-void devlink_resource_occ_get_unregister(struct devlink *devlink,
-					 u64 resource_id)
-{
-	devl_lock(devlink);
-	devl_resource_occ_get_unregister(devlink, resource_id);
-	devl_unlock(devlink);
-}
-EXPORT_SYMBOL_GPL(devlink_resource_occ_get_unregister);
-- 
2.39.3


