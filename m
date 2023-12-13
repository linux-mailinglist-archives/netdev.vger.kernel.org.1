Return-Path: <netdev+bounces-57056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6B8811D20
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 19:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 592DBB20CAD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7AE5FEF5;
	Wed, 13 Dec 2023 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTBeFNJN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2CAE8
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 10:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702493054; x=1734029054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/KdPd4TgaCEAveMVDgJ9y6wl9ZF//UTHnwRESXo/ARs=;
  b=BTBeFNJNB+JhTWFHo0QdT/E6GoEtzFGqOZy4RyXgBs4SXEQyf201EevL
   tq6CDIpVHG/lkndZTpd3xg42b02U1s8/OBL08bJneBcKSl2OLi2gSQdAq
   PLI6Ap3fr1oKaT1Xzfb2+RuZlEBp5apzZ8uisXTR3qGOsqh0BPDARFxk6
   i6bqVovY8/Na7kKAbgFIPjUCwd/eWDeIMfX49VxZuR715OHcZ8MGjxa0m
   IDKck5bki+A9KEpfpgaFRaKPwNaZD5N6lyBxY4sAJuyq4/ynGeyAEXi6A
   frD5GUp3RBoUSK3srsX5xtV1A5R0qVblE/8OgpQ0vXsVyBQY1V0Rv+AgN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2093011"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="2093011"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:44:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="777600102"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="777600102"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 13 Dec 2023 10:44:13 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	anthony.l.nguyen@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2] i40e: remove fake support of rx-frames-irq
Date: Wed, 13 Dec 2023 10:44:05 -0800
Message-ID: <20231213184406.1306602-1-anthony.l.nguyen@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
v2:
- use the correct params in i40e_ethtool.c file as suggested by Jakub.

v1 :https://lore.kernel.org/netdev/20231207183648.2819987-1-anthony.l.nguyen@intel.com/

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index a0b10230268d..5b2f27142b49 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2893,7 +2893,6 @@ static int __i40e_get_coalesce(struct net_device *netdev,
 	struct i40e_vsi *vsi = np->vsi;
 
 	ec->tx_max_coalesced_frames_irq = vsi->work_limit;
-	ec->rx_max_coalesced_frames_irq = vsi->work_limit;
 
 	/* rx and tx usecs has per queue value. If user doesn't specify the
 	 * queue, return queue 0's value to represent.
@@ -3027,7 +3026,7 @@ static int __i40e_set_coalesce(struct net_device *netdev,
 	struct i40e_pf *pf = vsi->back;
 	int i;
 
-	if (ec->tx_max_coalesced_frames_irq || ec->rx_max_coalesced_frames_irq)
+	if (ec->tx_max_coalesced_frames_irq)
 		vsi->work_limit = ec->tx_max_coalesced_frames_irq;
 
 	if (queue < 0) {
@@ -5786,7 +5785,7 @@ static const struct ethtool_ops i40e_ethtool_recovery_mode_ops = {
 
 static const struct ethtool_ops i40e_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_MAX_FRAMES_IRQ |
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_RX_USECS_HIGH |
 				     ETHTOOL_COALESCE_TX_USECS_HIGH,
-- 
2.41.0


