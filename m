Return-Path: <netdev+bounces-212755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF00B21C42
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75F9425001
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A618929BDA4;
	Tue, 12 Aug 2025 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECdhEod0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7A32E11B5
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974020; cv=none; b=nnMBSvz5JLFVXYQGv6Q4cnwaJihWPR0BXHfDtC0Jvdc0F2m5NZuX1VuoLPJXzBMMdKpkgtowKQUL3LasIes+tdkdGZ6w6pYAwULcudfXZj5xPwB93r2+me8WTFvKvHsXgzSo6uRxZkWGsjBt0xKXD8yaI1vHGZit0TG6tM00qjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974020; c=relaxed/simple;
	bh=PaZZF0HWeOxzeShIIUkYktbU75Xpo9jQY2Rd+3NRG2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mo0470jIS11aRbVbGWYnyyCvSxfpft8hpi6SzW/kNPwdsU0KSkwe2aUeGmdK/deCkRKOjSKVqscagnA+jyKX4Nzyp1a5V7u0jATJEBtfTbR8S+6ryRh8ed8iWGar35LXp+/+Y1gwKLOou1HLPAhsZGh001nObiaRv6xUHq42hG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECdhEod0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754974019; x=1786510019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PaZZF0HWeOxzeShIIUkYktbU75Xpo9jQY2Rd+3NRG2A=;
  b=ECdhEod0KrOuSHqEaCgmz1yMXPC5YtrDjDi5J0eKqj1VzvPWDp/ibx+e
   MOzvUfIOEMLT+Xul4jk216LglTl2/P0YfZDJuWuIfQlCFor923JozC9E8
   fdmEl0HMGQZh/H734hNWgvxVBu826naVud6md4F8V9lUP8XUWq+UCa3A8
   fWQXovuiAZAMQdkRF6nAkTpC2pfm9nIdoL+86APZ+k14YX/Eq8kEKdXeV
   kOY3jnTsqBCdMjax1ZSpUiaN7RHEHPc2nER/CMU6vkzFMGxqagpE379mI
   9L2mwk6zYtfpD7xAz6YPaAuii7bDdL0qu9+CyMvrm+J5elPkMdORUiaT5
   Q==;
X-CSE-ConnectionGUID: EqjlzkHwTyCOdCfbRr+RwQ==
X-CSE-MsgGUID: mZqw0kmlRqeft1A/DUS49g==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68612731"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68612731"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:46:58 -0700
X-CSE-ConnectionGUID: wav7H8lBRZi4r02d4qYlHg==
X-CSE-MsgGUID: fKr5GQw8SW6k70Hc+gFkCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165327876"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2025 21:46:57 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH iwl-next v2 03/15] ice: drop ice_pf_fwlog_update_module()
Date: Tue, 12 Aug 2025 06:23:24 +0200
Message-ID: <20250812042337.1356907-4-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Any other access to fwlog_cfg isn't done through a function. Follow
scheme that is used to access other fwlog_cfg elements from debugfs and
write to the log_level directly.

ice_pf_fwlog_update_module() is called only twice (from one function).
Remove it.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 -
 drivers/net/ethernet/intel/ice/ice_debugfs.c |  5 +++--
 drivers/net/ethernet/intel/ice/ice_main.c    | 13 -------------
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index e952d67388bf..a6803b344540 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -912,7 +912,6 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf);
 void ice_debugfs_pf_deinit(struct ice_pf *pf);
 void ice_debugfs_init(void);
 void ice_debugfs_exit(void);
-void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module);
 
 bool netif_is_ice(const struct net_device *dev);
 int ice_vsi_setup_tx_rings(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index cb71eca6a85b..170050548e74 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -164,6 +164,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 	struct ice_pf *pf = file_inode(filp)->i_private;
 	struct dentry *dentry = file_dentry(filp);
 	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_hw *hw = &pf->hw;
 	char user_val[16], *cmd_buf;
 	int module, log_level, cnt;
 
@@ -192,7 +193,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 	}
 
 	if (module != ICE_AQC_FW_LOG_ID_MAX) {
-		ice_pf_fwlog_update_module(pf, log_level, module);
+		hw->fwlog_cfg.module_entries[module].log_level = log_level;
 	} else {
 		/* the module 'all' is a shortcut so that we can set
 		 * all of the modules to the same level quickly
@@ -200,7 +201,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 		int i;
 
 		for (i = 0; i < ICE_AQC_FW_LOG_ID_MAX; i++)
-			ice_pf_fwlog_update_module(pf, log_level, i);
+			hw->fwlog_cfg.module_entries[i].log_level = log_level;
 	}
 
 	return count;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6b8eedc86b69..156e47927a5a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4624,19 +4624,6 @@ static void ice_print_wake_reason(struct ice_pf *pf)
 	dev_info(ice_pf_to_dev(pf), "Wake reason: %s", wake_str);
 }
 
-/**
- * ice_pf_fwlog_update_module - update 1 module
- * @pf: pointer to the PF struct
- * @log_level: log_level to use for the @module
- * @module: module to update
- */
-void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module)
-{
-	struct ice_hw *hw = &pf->hw;
-
-	hw->fwlog_cfg.module_entries[module].log_level = log_level;
-}
-
 /**
  * ice_register_netdev - register netdev
  * @vsi: pointer to the VSI struct
-- 
2.49.0


