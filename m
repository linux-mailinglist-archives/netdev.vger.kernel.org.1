Return-Path: <netdev+bounces-54954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E7180900F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EE41F21170
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279DB481A6;
	Thu,  7 Dec 2023 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0Rgrbty"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276D210E7
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701974215; x=1733510215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vm+p1HPYLMEP6pTnhkAjNt2c/G43BCy+qGmCaoSAe0w=;
  b=m0RgrbtyZFUwtdLcEY7w1aG4C/SpHO+TvuOY+/tpkVfzTG83xMdsIlRo
   b0acG3a7ZUl2hq33aK6l1XoxIJH9Ru43JHmub5WvDg4yZDJ1cfp7YttSi
   wbgfUpbE7gg3C6QlH3aJ2z8C8YbydMC3Av7AjijXFUc/VQL/QT4wNyHfo
   13k3CDrVHwZG79N0fXjZLS2MpO82z5keElen+YsfK331HcC4u9LdFD3WO
   Gp+g0CksJk75qUBDCthR/qyXV4RlgfQIzJYTsf5q3X8eLw6kJn7n9DYuu
   tv8D6Z16JMyosOqLbTDiFS2KKVDy9+9dzPVEhNEDmM44NwQ/63L+nCVOb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="398156921"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="398156921"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="862572676"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="862572676"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2023 10:36:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	anthony.l.nguyen@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next] i40e: remove fake support of rx-frames-irq
Date: Thu,  7 Dec 2023 10:36:47 -0800
Message-ID: <20231207183648.2819987-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since we never support this feature for I40E driver, we don't have to
display the value when using 'ethtool -c eth0'.

Before this patch applied, the rx-frames-irq is 256 which is consistent
with tx-frames-irq. Apparently it could mislead users.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index eb9a7b32af73..2a0a12a79aa3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2895,7 +2895,6 @@ static int __i40e_get_coalesce(struct net_device *netdev,
 	struct i40e_vsi *vsi = np->vsi;
 
 	ec->tx_max_coalesced_frames_irq = vsi->work_limit;
-	ec->rx_max_coalesced_frames_irq = vsi->work_limit;
 
 	/* rx and tx usecs has per queue value. If user doesn't specify the
 	 * queue, return queue 0's value to represent.
@@ -3029,7 +3028,7 @@ static int __i40e_set_coalesce(struct net_device *netdev,
 	struct i40e_pf *pf = vsi->back;
 	int i;
 
-	if (ec->tx_max_coalesced_frames_irq || ec->rx_max_coalesced_frames_irq)
+	if (ec->tx_max_coalesced_frames_irq)
 		vsi->work_limit = ec->tx_max_coalesced_frames_irq;
 
 	if (queue < 0) {
-- 
2.41.0


