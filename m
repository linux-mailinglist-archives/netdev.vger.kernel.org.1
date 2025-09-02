Return-Path: <netdev+bounces-219365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B28B410B8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B89A16922A
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4017281366;
	Tue,  2 Sep 2025 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyqOpJ8o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBB327FB1E
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855304; cv=none; b=CPkc7/GR9SjLH6FG4ZHVpHLSIBV/eZiCvN1Ymn7rtMwA9Rmfnd/Z1+yR/Y2IA9VNcUD+Z6i4XJ1CO/Oy7XZ7Bl7ZFM8ouRc6qLMD2e9B48IipOCPHgzE826Vo9MHqKhGFiAER77Y5A9shodd83UZWobmqjiHsa9Dii2uUXf1MMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855304; c=relaxed/simple;
	bh=l+KerzrKuoywucPWElv9ak/P0pbeaJh/rnHwYkeMsvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/a35lvAaF1ieHUoHsbq0QIDLWUIR+aU97wSbWHYaxZUzPGqTenNknVOmDDtCXFJAtq32UNg+u62Kmo7sONSMo6NHlWilfidMMH9laQ1sbgLs/613fyA3ofHJZ3JcB3VmpWibtszKReHIp2Ss7ZbJWC3Oo/+N2EHFp7vu8RqROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyqOpJ8o; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756855303; x=1788391303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+KerzrKuoywucPWElv9ak/P0pbeaJh/rnHwYkeMsvQ=;
  b=DyqOpJ8o1Cf/WOR4bvPAsBc5n8rci8CJq7TtBOVBtdzH4nkgIdsHc5Ju
   AiUjiwL7YWzVLMeC/0RHTAFTNlRZik/kDU4ECKBoArJH6isWx+k5Sh/6F
   IiYqfQI5/+rWTek0LRHs+q7/ikD5SF8gKMiiUCrwH18aXjbipr4m9CjlQ
   UmYiYFj8FOI0sd9v2khTs1aT3OT5GC8+diEkqBOc32t3AceWKWuYWMICW
   5d6DWFoL7uf42DcO9VIi5uqZDK5m2rE8WPNwsOSBnsRCPKDFhPVRwvXNm
   Nj6rG7lp4JQl+ZkKzl7xHYnp3sYcGZESiTGUFhXxZPD+S8Gz9ClGnDVwI
   g==;
X-CSE-ConnectionGUID: SzLBd45pSPif45HBl2x/qA==
X-CSE-MsgGUID: n387Y4knQOyHj6Vpq3ZIOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69767230"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69767230"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 16:21:38 -0700
X-CSE-ConnectionGUID: U1NcbfPjTueW6n0SiiUwAQ==
X-CSE-MsgGUID: xa4bSjsCTtaV6pRkjE2PZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171575912"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2025 16:21:39 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 7/8] ixgbe: fix incorrect map used in eee linkmode
Date: Tue,  2 Sep 2025 16:21:27 -0700
Message-ID: <20250902232131.2739555-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
References: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alok Tiwari <alok.a.tiwari@oracle.com>

incorrectly used ixgbe_lp_map in loops intended to populate the
supported and advertised EEE linkmode bitmaps based on ixgbe_ls_map.
This results in incorrect bit setting and potential out-of-bounds
access, since ixgbe_lp_map and ixgbe_ls_map have different sizes
and purposes.

ixgbe_lp_map[i] -> ixgbe_ls_map[i]

Use ixgbe_ls_map for supported and advertised linkmodes, and keep
ixgbe_lp_map usage only for link partner (lp_advertised) mapping.

Fixes: 9356b6db9d05 ("net: ethernet: ixgbe: Convert EEE to use linkmodes")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 25c3a09ad7f1..1a2f1bdb91aa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3571,13 +3571,13 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 
 	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
 		if (hw->phy.eee_speeds_supported & ixgbe_ls_map[i].mac_speed)
-			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
+			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
 					 edata->supported);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
 		if (hw->phy.eee_speeds_advertised & ixgbe_ls_map[i].mac_speed)
-			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
+			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
 					 edata->advertised);
 	}
 
-- 
2.47.1


