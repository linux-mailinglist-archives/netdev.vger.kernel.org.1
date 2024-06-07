Return-Path: <netdev+bounces-101822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2AA900328
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85408286A76
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208D51922C4;
	Fri,  7 Jun 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3NIgCE2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80537190696
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762505; cv=none; b=Vt+bZdRTiTngJP/MJsbBzf3nyPq7GgTqLZqqOym3Xbw5kvEBsmRTDQlL+iQebk91SeXUBaCVivvzWwIpH3uKpCWMWNy7n2FgbAkBvumoIXGIPHsloOSg3owOZs92GrRolRWBGEnEz63PM1m5IDEmv0r87iCJv0xGyGHrjD/E/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762505; c=relaxed/simple;
	bh=HQUYtmzjk3nbtKwBo0iMqw6E+1YQOvSX8err0DHZcxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDgq04sWebOXLrDxJo2P6DD/SoielgEJb8ah6bm3UDlcTsf68oJdIlZ3KdqwgH0a3mXDE00IvBt4DGN3+BAzwN62Ssl9i1f4Sq+2gdT1QXtKrw94gb5h+VB8G3laf3uHq9r9/UY5iyZoQzhyIaIRK/pKabntQ6ZsqS5U2mE9y4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3NIgCE2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717762504; x=1749298504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HQUYtmzjk3nbtKwBo0iMqw6E+1YQOvSX8err0DHZcxU=;
  b=l3NIgCE2068r76frM88ZpS0iWoOIFbOfNzzK5uJeM6MtRMGGhwxjL0ci
   r3mmKuD4DvViTNMXm/pqJjkreiQU5gTCGjDpdF/hm2AdgBUwjp60Qu9M9
   GLoLWMROwFHZIlAm9kg2frx/iXdX+n2ughrJIUv9MNy/cT05WQ/qfpeUs
   NSeiOf1HyQKEDYfi5EhsEAag2Q4vefzMFn6R8rjymsy+j97Xf5fZo8hKN
   ZIEJrc5+a9FuzCTp22o3tEFkWyD7EbUBkGdnjCSW+VfrbK7GRJ4INS5hd
   P6PzDocM4kCKptjOPiJ3vxRn0fVgg+P0MkVHQ3dVKMhtP34gEjzM3FtNN
   Q==;
X-CSE-ConnectionGUID: aQSKfmq7THO6bTtuH4zYMw==
X-CSE-MsgGUID: 6xcplEq+SJi7/56RRKw2ig==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14312978"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14312978"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:15:03 -0700
X-CSE-ConnectionGUID: gowl1lNuRrSYgMKN9jm7AQ==
X-CSE-MsgGUID: SdhAQElOS1+QrFSfvKb8pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38304095"
Received: from unknown (HELO localhost.igk.intel.com) ([10.91.240.220])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:15:00 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH iwl-net v5] ice: Do not get coalesce settings while in reset
Date: Fri,  7 Jun 2024 14:15:52 +0200
Message-ID: <20240607121552.15127-1-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Getting coalesce settings while reset is in progress can cause NULL
pointer deference bug.
If under reset, abort get coalesce for ethtool.

We cannot use ice_wait_for_reset() since both the ethtool handler and the
adapter reset flow call rtnl_lock() during operation. If we wait for
reset completion inside of an ethtool handling function such as
ice_get_coalesce(), the wait will always timeout due to reset being
blocked by rtnl_lock() inside of ice_queue_set_napi() (which is called
during reset process), and in turn we will always return -EBUSY anyways,
with the added hang time of the timeout value.

Fixes: 67fe64d78c43 ("ice: Implement getting and setting ethtool coalesce")
Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
Changes since v1:
* Added "Fixes:" tag
Changes since v2:
* Rebased over current IWL net branch
* Confirmed that the issue previously reported for this patch [1] by
Himasekhar Reddy Pucha was caused by other, internally tracked issue
Changes since v3:
* Using ice_wait_for_reset() instead of returning -EBUSY 
Changes since v4:
* Rebased over current IWL net branch
* Rollback the use of ice_wait_for_reset() due to rtnl_lock() deadlock
issue described in [2] and commit msg

[1] https://lore.kernel.org/netdev/BL0PR11MB3122D70ABDE6C2ACEE376073BD90A@BL0PR11MB3122.namprd11.prod.outlook.com/
[2] https://lore.kernel.org/netdev/20240501195641.1e606747@kernel.org/T/#m1629ecfe88d26551852c5c97982cd10314991422
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 62c8205fceba..2ffe864a364c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3810,6 +3810,9 @@ __ice_get_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec,
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 
+	if (ice_is_reset_in_progress(vsi->back->state))
+		return -EBUSY;
+
 	if (q_num < 0)
 		q_num = 0;
 
-- 
2.44.0


