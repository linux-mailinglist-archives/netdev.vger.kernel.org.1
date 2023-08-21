Return-Path: <netdev+bounces-29300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DA97829B4
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD7B280E4E
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B611663AF;
	Mon, 21 Aug 2023 13:00:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B38441D
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:00:10 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4972BD1
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:00:08 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTstG3rCXzcdFW;
	Mon, 21 Aug 2023 20:56:22 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 21:00:04 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <aelior@marvell.com>, <manishc@marvell.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] qed/qede: Remove unused declarations
Date: Mon, 21 Aug 2023 21:00:02 +0800
Message-ID: <20230821130002.36700-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 8cd160a29415 ("qede: convert to new udp_tunnel_nic infra")
removed qede_udp_tunnel_{add,del}() but not the declarations.
Commit 0ebcebbef1cc ("qed: Read device port count from the shmem")
removed qed_device_num_engines() but not its declaration.
Commit 1e128c81290a ("qed: Add support for hardware offloaded FCoE.")
declared but never implemented qed_fcoe_set_pf_params().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/qlogic/qed/qed.h   | 1 -
 drivers/net/ethernet/qlogic/qede/qede.h | 3 ---
 include/linux/qed/qed_fcoe_if.h         | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed.h b/drivers/net/ethernet/qlogic/qed/qed.h
index d613095b78e0..1d719726f72b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed.h
+++ b/drivers/net/ethernet/qlogic/qed/qed.h
@@ -909,7 +909,6 @@ void qed_configure_vp_wfq_on_link_change(struct qed_dev *cdev,
 					 u32 min_pf_rate);
 
 void qed_clean_wfq_db(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
-int qed_device_num_engines(struct qed_dev *cdev);
 void qed_set_fw_mac_addr(__le16 *fw_msb,
 			 __le16 *fw_mid, __le16 *fw_lsb, u8 *mac);
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede.h b/drivers/net/ethernet/qlogic/qede/qede.h
index 4d83ceebdc49..042a75f34060 100644
--- a/drivers/net/ethernet/qlogic/qede/qede.h
+++ b/drivers/net/ethernet/qlogic/qede/qede.h
@@ -556,9 +556,6 @@ void qede_config_rx_mode(struct net_device *ndev);
 void qede_fill_rss_params(struct qede_dev *edev,
 			  struct qed_update_vport_rss_params *rss, u8 *update);
 
-void qede_udp_tunnel_add(struct net_device *dev, struct udp_tunnel_info *ti);
-void qede_udp_tunnel_del(struct net_device *dev, struct udp_tunnel_info *ti);
-
 int qede_xdp(struct net_device *dev, struct netdev_bpf *xdp);
 
 #ifdef CONFIG_DCB
diff --git a/include/linux/qed/qed_fcoe_if.h b/include/linux/qed/qed_fcoe_if.h
index 90e3045b2dcb..0d3b6ed21628 100644
--- a/include/linux/qed/qed_fcoe_if.h
+++ b/include/linux/qed/qed_fcoe_if.h
@@ -67,9 +67,6 @@ struct qed_fcoe_cb_ops {
 	 u32 (*get_login_failures)(void *cookie);
 };
 
-void qed_fcoe_set_pf_params(struct qed_dev *cdev,
-			    struct qed_fcoe_pf_params *params);
-
 /**
  * struct qed_fcoe_ops - qed FCoE operations.
  * @common:		common operations pointer
-- 
2.34.1


