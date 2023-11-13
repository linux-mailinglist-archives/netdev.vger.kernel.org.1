Return-Path: <netdev+bounces-47515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87A37EA6C3
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930872810CE
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1976F3FB2B;
	Mon, 13 Nov 2023 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOywrb+5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2E3D966
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:11:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F06D7A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699917063; x=1731453063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B6Z+C38xdLW+8EhvkfTKZm9JNbTyYcj0/cms45Asj3w=;
  b=cOywrb+5hlAZjmbBDhzfPMD8kUfulfckrapvU73IF8bziHxmKyZQSCv4
   BAa15iHTm7Hy1MiyGkW77RLNEdGknaNaKFmodSZ0RctnVxHyQX3WTFAGG
   CBfb6fsDn/HqQ+rYzWE6n3L8NhAk4KPYkmQ7sQ6NctSzVaZ4WV7vtDG3E
   pycthV9Z4DRbMfirdnMmxIbyrpEZW32WlKmnRZW4b8HgBgOIKfgzrkTUP
   E0NvAUt6WznxIjDCFRZfjdz6GHoUYc8NKO6TLh+VH3opXxUTWM7u8P7AQ
   CZb8HOFpaSRM0Mh7NIQGuqKCWGT3QG7pQPe77mm6LwM5zPU4/tF7OE41J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375562671"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375562671"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:10:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888051442"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888051442"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 15:10:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 15/15] i40e: Delete unused i40e_mac_info fields
Date: Mon, 13 Nov 2023 15:10:34 -0800
Message-ID: <20231113231047.548659-16-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
References: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

From commit 9eed69a9147c ("i40e: Drop FCoE code from core driver files")
the field i40e_mac_info.san_addr is unused (never filled).
The field i40e_mac_info.max_fcoeq is unused from the beginning.
Remove both.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c  | 5 +----
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 3 +--
 drivers/net/ethernet/intel/i40e/i40e_type.h    | 2 --
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
index 1ee77a2433c0..4721845fda6e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -827,15 +827,12 @@ static void i40e_dcbnl_get_perm_hw_addr(struct net_device *dev,
 					u8 *perm_addr)
 {
 	struct i40e_pf *pf = i40e_netdev_to_pf(dev);
-	int i, j;
+	int i;
 
 	memset(perm_addr, 0xff, MAX_ADDR_LEN);
 
 	for (i = 0; i < dev->addr_len; i++)
 		perm_addr[i] = pf->hw.mac.perm_addr[i];
-
-	for (j = 0; j < dev->addr_len; j++, i++)
-		perm_addr[i] = pf->hw.mac.san_addr[j];
 }
 
 static const struct dcbnl_rtnl_ops dcbnl_ops = {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index e0849f0c9c27..88240571721a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -147,9 +147,8 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 "    state[%d] = %08lx\n",
 			 i, vsi->state[i]);
 	if (vsi == pf->vsi[pf->lan_vsi])
-		dev_info(&pf->pdev->dev, "    MAC address: %pM SAN MAC: %pM Port MAC: %pM\n",
+		dev_info(&pf->pdev->dev, "    MAC address: %pM Port MAC: %pM\n",
 			 pf->hw.mac.addr,
-			 pf->hw.mac.san_addr,
 			 pf->hw.mac.port_addr);
 	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
 		dev_info(&pf->pdev->dev,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index e3f73be5eb09..de69c2e22448 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -270,9 +270,7 @@ struct i40e_mac_info {
 	enum i40e_mac_type type;
 	u8 addr[ETH_ALEN];
 	u8 perm_addr[ETH_ALEN];
-	u8 san_addr[ETH_ALEN];
 	u8 port_addr[ETH_ALEN];
-	u16 max_fcoeq;
 };
 
 enum i40e_aq_resources_ids {
-- 
2.41.0


