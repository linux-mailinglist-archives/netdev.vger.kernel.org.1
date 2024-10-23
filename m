Return-Path: <netdev+bounces-138242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73C9ACADE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD13B1C20EEA
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B881C303A;
	Wed, 23 Oct 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+990/1i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC491BFE0C;
	Wed, 23 Oct 2024 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689216; cv=none; b=XWnLm+XLCTibMUzAr67eH6XXIMjJ2TQtu2DYzF7qG1lYvYekQ5fOdDvdBogdW2m2XGBK/Xo/b0AU9P+9xpOlh5Wimm2eNP4skLJwq/Ns7tJ27oCSg7KwKzmiVDGR8WhPcwy5aDFbEraOCvssg/lyTtnr0KqQ4KSYxCQU9G/4OuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689216; c=relaxed/simple;
	bh=+mPa/jPAUkkjBYJVCw5ckmn4CgLVWcvx8RKEOZEn7wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZrVy5cu1DiZqsoZYHR80icp4l6rCuj6Ahg2uc1vodCNHCKFU6aQoyM1oCWWkzX3c/YvQjkuwIvqn6H379GWuWdYuhQZbl+wwfvSFLN5Osd9LoMcvwS+iU/2wGa2G2Dy+0GG2izq9XRbnRnQ+3UGoJPyH4LDJ288dM+HLwSEpeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+990/1i; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729689214; x=1761225214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+mPa/jPAUkkjBYJVCw5ckmn4CgLVWcvx8RKEOZEn7wY=;
  b=X+990/1i2PzMwrBAyc54+w8EDrD5ukgN5ZU8j33NE/cDtr2voLkgxKW3
   EOCQwRS+te2PBCD8EGiqwVMTBAr3Mslg4+TJHKdvTlz28debIYaVTrrQw
   LdJqIrJmlDSyEBKmLKp2n+XC45s8gfM+cEmeIYnumbXGf/D9POUWbtEe3
   AzuGab4Af+eYekoomDmhlaS8a3RfpVcI7HdBpxzB5UnhOUICMpLiXt4eY
   6U/WLJJvUkXUGy9O3PTh/aY5O+ZX6gYQnIvTJVOzXqHzvRidOJy6gB9FV
   4YKDSuZWeytRe00vMX5VY9vdaBV3XznWP0VJKTpg9aod0N9jaTus9Uh2P
   Q==;
X-CSE-ConnectionGUID: Z+Rl9n4YS32CW1A0yrtI3Q==
X-CSE-MsgGUID: mC2icEmSTE2UDQlwa4S6sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="46758594"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="46758594"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:13:34 -0700
X-CSE-ConnectionGUID: yLB7w7/lTgu/d9N2m2QBwA==
X-CSE-MsgGUID: /YHoKApITNClP71o8EAOSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84820125"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 23 Oct 2024 06:13:30 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.71])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8ABFE28780;
	Wed, 23 Oct 2024 14:13:28 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next v2 5/7] net: dsa: replace devlink resource registration calls by devl_ variants
Date: Wed, 23 Oct 2024 15:09:05 +0200
Message-ID: <20241023131248.27192-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
References: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace devlink_resource_register(), devlink_resource_occ_get_register(),
and devlink_resource_occ_get_unregister() calls by respective devl_*
variants. Mentioned functions have no direct users in any drivers, and are
going to be removed in subsequent patches.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 net/dsa/devlink.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
index 0aac887d0098..f41f9fc2194e 100644
--- a/net/dsa/devlink.c
+++ b/net/dsa/devlink.c
@@ -229,10 +229,15 @@ int dsa_devlink_resource_register(struct dsa_switch *ds,
 				  u64 parent_resource_id,
 				  const struct devlink_resource_size_params *size_params)
 {
-	return devlink_resource_register(ds->devlink, resource_name,
-					 resource_size, resource_id,
-					 parent_resource_id,
-					 size_params);
+	int ret;
+
+	devl_lock(ds->devlink);
+	ret = devl_resource_register(ds->devlink, resource_name, resource_size,
+				     resource_id, parent_resource_id,
+				     size_params);
+	devl_unlock(ds->devlink);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dsa_devlink_resource_register);
 
@@ -247,15 +252,19 @@ void dsa_devlink_resource_occ_get_register(struct dsa_switch *ds,
 					   devlink_resource_occ_get_t *occ_get,
 					   void *occ_get_priv)
 {
-	return devlink_resource_occ_get_register(ds->devlink, resource_id,
-						 occ_get, occ_get_priv);
+	devl_lock(ds->devlink);
+	devl_resource_occ_get_register(ds->devlink, resource_id, occ_get,
+				       occ_get_priv);
+	devl_unlock(ds->devlink);
 }
 EXPORT_SYMBOL_GPL(dsa_devlink_resource_occ_get_register);
 
 void dsa_devlink_resource_occ_get_unregister(struct dsa_switch *ds,
 					     u64 resource_id)
 {
-	devlink_resource_occ_get_unregister(ds->devlink, resource_id);
+	devl_lock(ds->devlink);
+	devl_resource_occ_get_unregister(ds->devlink, resource_id);
+	devl_unlock(ds->devlink);
 }
 EXPORT_SYMBOL_GPL(dsa_devlink_resource_occ_get_unregister);
 
-- 
2.46.0


