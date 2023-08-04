Return-Path: <netdev+bounces-24394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A83D277008B
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A3B28268F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2DBBA5E;
	Fri,  4 Aug 2023 12:52:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED2A929
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 12:52:18 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DBF46A8
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 05:52:16 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHQWM3NvQzGpnc;
	Fri,  4 Aug 2023 20:48:47 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 20:52:13 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <daniel@veobot.com>, <yuehaibing@huawei.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next] ixgbe: Remove unused function declarations
Date: Fri, 4 Aug 2023 20:52:03 +0800
Message-ID: <20230804125203.30924-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit dc166e22ede5 ("ixgbe: DCB remove ixgbe_fcoe_getapp routine")
leave ixgbe_fcoe_getapp() unused.
Commit ffed21bcee7a ("ixgbe: Don't bother clearing buffer memory for descriptor rings")
leave ixgbe_unmap_and_free_tx_resource() declaration unused.
And commit 3b3bf3b92b31 ("ixgbe: remove unused fcoe.tc field and fcoe_setapp()")
removed the ixgbe_fcoe_setapp() implementation.

Commit c44ade9ef8ff ("ixgbe: update to latest common code module")
declared but never implemented ixgbe_init_ops_generic().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h        | 6 ------
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 63d4e32df029..b6f0376e42f4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -945,8 +945,6 @@ void ixgbe_update_pf_promisc_vlvf(struct ixgbe_adapter *adapter, u32 vid);
 void ixgbe_clear_interrupt_scheme(struct ixgbe_adapter *adapter);
 netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *, struct ixgbe_adapter *,
 				  struct ixgbe_ring *);
-void ixgbe_unmap_and_free_tx_resource(struct ixgbe_ring *,
-				      struct ixgbe_tx_buffer *);
 void ixgbe_alloc_rx_buffers(struct ixgbe_ring *, u16);
 void ixgbe_write_eitr(struct ixgbe_q_vector *);
 int ixgbe_poll(struct napi_struct *napi, int budget);
@@ -997,10 +995,6 @@ int ixgbe_setup_fcoe_ddp_resources(struct ixgbe_adapter *adapter);
 void ixgbe_free_fcoe_ddp_resources(struct ixgbe_adapter *adapter);
 int ixgbe_fcoe_enable(struct net_device *netdev);
 int ixgbe_fcoe_disable(struct net_device *netdev);
-#ifdef CONFIG_IXGBE_DCB
-u8 ixgbe_fcoe_getapp(struct ixgbe_adapter *adapter);
-u8 ixgbe_fcoe_setapp(struct ixgbe_adapter *adapter, u8 up);
-#endif /* CONFIG_IXGBE_DCB */
 int ixgbe_fcoe_get_wwn(struct net_device *netdev, u64 *wwn, int type);
 int ixgbe_fcoe_get_hbainfo(struct net_device *netdev,
 			   struct netdev_fcoe_hbainfo *info);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
index 4b531e8ae38a..34761e691d52 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
@@ -8,7 +8,6 @@
 #include "ixgbe.h"
 
 u16 ixgbe_get_pcie_msix_count_generic(struct ixgbe_hw *hw);
-s32 ixgbe_init_ops_generic(struct ixgbe_hw *hw);
 s32 ixgbe_init_hw_generic(struct ixgbe_hw *hw);
 s32 ixgbe_start_hw_generic(struct ixgbe_hw *hw);
 s32 ixgbe_start_hw_gen2(struct ixgbe_hw *hw);
-- 
2.34.1


