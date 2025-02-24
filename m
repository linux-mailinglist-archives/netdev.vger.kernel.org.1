Return-Path: <netdev+bounces-169190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF49A42E8B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6513B2A79
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC0413C3F6;
	Mon, 24 Feb 2025 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6slrNY/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889C284A35
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431007; cv=none; b=FcXtWfvub7lv+jshQXCDRLHwcOwk6O7DWZ+Ofmfl1qjcpmqZjajhXnqBhxtKJjKrr1OxjHfyLJJbHW4gld6023y/vL9CKdA7fStRCHa46udARis/AGj4Y8yTkS6wf9hM3fenO/V5NivtabKcft58jCys5WdkceDu308/O0p3WdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431007; c=relaxed/simple;
	bh=FecevnrZjEY6MuxSUygLgUocjSQRIPcMELLd9y7TwaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lb++n9MDISr7SwwReYRbKKeAgJWI/kYogoAJ/wclQzN5O9FeKaRJoKS7GidX6wohXFm6+KbQNUXjHb5o4AgyZG05JfB+gcWmTReUkVl/0somWsH1T+BN5xUSifRs+4lSHH7H6xfYtqn0wsAjGDCmoPuIA5JzUu+ur5EYKuAXONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6slrNY/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740431006; x=1771967006;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FecevnrZjEY6MuxSUygLgUocjSQRIPcMELLd9y7TwaY=;
  b=n6slrNY/SL6+awQYMOn4iG3SrulH7OQjiG5J70Nzp1gphSfel1TtiLyu
   6qw1WO1RGjY79S5vKECC6OrqQRCKPmMhQ07GevBiePSYMziqEA9fXdFne
   sUF4iLeTNCEjGjagVHMZ8bnDhKDbDfaZ8OvsWpgh7643Gcuk0jxBJdMIi
   ejP8IiU9sydP5glaUJRQ9Hu05Gf/UsBsMYwOAPluDBCptqXfQ9v8uvhvU
   8Y1hriTDJiSiVl7tdiyWXQ/MWkuVP30LNJGTUer7pgRlOonc1zM9ZOVBU
   Am0FopoSIdbyZDw8jk01/qTOCD3L30KuB7yomPHRYxJNYmsHQxEicSVPD
   Q==;
X-CSE-ConnectionGUID: SvW1aGK9R6ywWcWfg05Bag==
X-CSE-MsgGUID: e/5sa79CRr2LFyJ8XCB0oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41470669"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="41470669"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 13:03:25 -0800
X-CSE-ConnectionGUID: mQGPtJhjRQm+iy1rFWkBrA==
X-CSE-MsgGUID: LP/yvMm5SL2xdY/pfLtUhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121426750"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa005.jf.intel.com with ESMTP; 24 Feb 2025 13:03:23 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH iwl-next v2] ice: Allow 100M speed for E825C SGMII device
Date: Mon, 24 Feb 2025 21:59:24 +0100
Message-Id: <20250224205924.2861584-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add E825C 10GbE SGMII device to the list of devices supporting 100Mbit
link mode. Without that change, 100Mbit link mode is ignored in ethtool
interface. This change was missed while adding the support for E825C
devices family.

Testing hints (please note, for previous version, 100baseT/Full entry
was missing):
[root@localhost]# ethtool eth3
Settings for eth3:
        Supported ports: [ TP ]
        Supported link modes:   100baseT/Full
                                1000baseT/Full
                                10000baseT/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: None
        Advertised link modes:  100baseT/Full
                                1000baseT/Full
                                10000baseT/Full
	...

Fixes: f64e189442332 ("ice: introduce new E825C devices family")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

---
Changes in v2:
- improved commit meassege (added testing hint)
---
 drivers/net/ethernet/intel/ice/ice_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7a2a2e8da8fa..caf3af2a32c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3180,6 +3180,7 @@ bool ice_is_100m_speed_supported(struct ice_hw *hw)
 	case ICE_DEV_ID_E822L_SGMII:
 	case ICE_DEV_ID_E823L_1GBE:
 	case ICE_DEV_ID_E823C_SGMII:
+	case ICE_DEV_ID_E825C_SGMII:
 		return true;
 	default:
 		return false;

base-commit: bf7e01518c9f3f77c220bf153411d9d3d2511f16
-- 
2.39.3


