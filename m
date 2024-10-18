Return-Path: <netdev+bounces-136946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01619A3B5C
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B71F1C23CFD
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A229E202F8D;
	Fri, 18 Oct 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFpA+nX1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C1202F72
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246839; cv=none; b=k5w6NZmcnc8YO8tHiLA97bblMgdJrVJAeOLF823q6fUvjPlNsc0IuVZTkLFQznFZVxF13Z8WJKU5uTlOISKZiLpgmWi4IkvnaBoSoWfYG5pL0CCrJNMW52btxMkl/8hPtf7rdjDFlcAuIKWmlyn0k8X+U5QIaZjemjjbA9qo0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246839; c=relaxed/simple;
	bh=4DXTv1CJFQk1suv7J7d/Rlhy6YGYnvNDamBfwpq0f3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwCNjA3RpK/7jKpvUS36teaBCNThBkr9ol1kw+QQX91pD4qMCyilfY7TQKVcecTvXmM6HYbH8DnVcDJ6NeOL63qO4u5Dn0lQ3HfSAPstgh2BUQNLgpikVNuRptPgp7mCZ9FZS3MxqH6W0Ooai6pjXc9KfrbCwyW+GBFtlv4hhu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFpA+nX1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729246838; x=1760782838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4DXTv1CJFQk1suv7J7d/Rlhy6YGYnvNDamBfwpq0f3Y=;
  b=OFpA+nX1ouX5Yc/atqjI9BupLBdPEmO7fEvIYak/gLaPZC90z9VWHHSJ
   uIibKwBvwH+LlgWhTMOfhGNBNPucAgecEJvl07aar38Phnc/HRiukhf49
   hQQ1m9ZPlpjvZoAgWoEhe3fliWrxeBS/CDCkGriEwZ1KKcG4gqQSbqmho
   HQgQSgyHZ5sb5cBh9nk2W0HABbYWMjU6o8/o3e8cJ7LgQuuTBJh8u6EAQ
   QLsdt6U2RLU5Xh/WfUmnQQIercza0SKJ4yrWxoR/rZgB7BICfHkeV/+Ie
   KJGOWagR/NeVooumMZ4/5LmsX0BigM/c0rtfDTNTi/y1spCOkgY+71kiQ
   w==;
X-CSE-ConnectionGUID: h+c4utkpQw2KQeW82t41IA==
X-CSE-MsgGUID: r2GP01pgRc20OmwVSLNEXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39401230"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="39401230"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 03:20:38 -0700
X-CSE-ConnectionGUID: u5ZmbGYuRuelYCIXQwP9Gw==
X-CSE-MsgGUID: GRXcktseS5CDazj/KWcDNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78789320"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 18 Oct 2024 03:20:36 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.186])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E36112816E;
	Fri, 18 Oct 2024 11:20:34 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH v1 5/7] net: dsa: replace devlink resource registration calls by devl_ variants
Date: Fri, 18 Oct 2024 12:18:34 +0200
Message-ID: <20241018102009.10124-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
References: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
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


