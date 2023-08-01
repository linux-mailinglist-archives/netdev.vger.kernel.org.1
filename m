Return-Path: <netdev+bounces-23202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956F76B4D9
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D46C281977
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C42E1FB5F;
	Tue,  1 Aug 2023 12:35:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5D1E503
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 12:35:02 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B564B1FC6;
	Tue,  1 Aug 2023 05:35:00 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFZGr4VdmzNmYn;
	Tue,  1 Aug 2023 20:31:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 20:34:57 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <tariqt@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next] net/mlx4: remove many unnecessary NULL values
Date: Tue, 1 Aug 2023 20:34:22 +0800
Message-ID: <20230801123422.374541-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ther are many pointers assigned first, which need not to be initialized, so
remove the NULL assignment.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 10 +++++-----
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c  |  4 ++--
 drivers/net/ethernet/mellanox/mlx4/main.c       | 12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 7d45f1d55f79..164a13272faa 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1467,8 +1467,8 @@ static int add_ip_rule(struct mlx4_en_priv *priv,
 		       struct list_head *list_h)
 {
 	int err;
-	struct mlx4_spec_list *spec_l2 = NULL;
-	struct mlx4_spec_list *spec_l3 = NULL;
+	struct mlx4_spec_list *spec_l2;
+	struct mlx4_spec_list *spec_l3;
 	struct ethtool_usrip4_spec *l3_mask = &cmd->fs.m_u.usr_ip4_spec;
 
 	spec_l3 = kzalloc(sizeof(*spec_l3), GFP_KERNEL);
@@ -1505,9 +1505,9 @@ static int add_tcp_udp_rule(struct mlx4_en_priv *priv,
 			     struct list_head *list_h, int proto)
 {
 	int err;
-	struct mlx4_spec_list *spec_l2 = NULL;
-	struct mlx4_spec_list *spec_l3 = NULL;
-	struct mlx4_spec_list *spec_l4 = NULL;
+	struct mlx4_spec_list *spec_l2;
+	struct mlx4_spec_list *spec_l3;
+	struct mlx4_spec_list *spec_l4;
 	struct ethtool_tcpip4_spec *l4_mask = &cmd->fs.m_u.tcp_ip4_spec;
 
 	spec_l2 = kzalloc(sizeof(*spec_l2), GFP_KERNEL);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index e11bc0ac880e..403604ceebc8 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -291,7 +291,7 @@ mlx4_en_filter_alloc(struct mlx4_en_priv *priv, int rxq_index, __be32 src_ip,
 		     __be32 dst_ip, u8 ip_proto, __be16 src_port,
 		     __be16 dst_port, u32 flow_id)
 {
-	struct mlx4_en_filter *filter = NULL;
+	struct mlx4_en_filter *filter;
 
 	filter = kzalloc(sizeof(struct mlx4_en_filter), GFP_ATOMIC);
 	if (!filter)
@@ -2935,7 +2935,7 @@ static void mlx4_en_bond_work(struct work_struct *work)
 static int mlx4_en_queue_bond_work(struct mlx4_en_priv *priv, int is_bonded,
 				   u8 v2p_p1, u8 v2p_p2)
 {
-	struct mlx4_en_bond *bond = NULL;
+	struct mlx4_en_bond *bond;
 
 	bond = kzalloc(sizeof(*bond), GFP_ATOMIC);
 	if (!bond)
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 61286b0d9b0c..9320b57cf788 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -864,7 +864,7 @@ static void mlx4_slave_destroy_special_qp_cap(struct mlx4_dev *dev)
 
 static int mlx4_slave_special_qp_cap(struct mlx4_dev *dev)
 {
-	struct mlx4_func_cap *func_cap = NULL;
+	struct mlx4_func_cap *func_cap;
 	struct mlx4_caps *caps = &dev->caps;
 	int i, err = 0;
 
@@ -908,9 +908,9 @@ static int mlx4_slave_cap(struct mlx4_dev *dev)
 {
 	int			   err;
 	u32			   page_size;
-	struct mlx4_dev_cap	   *dev_cap = NULL;
-	struct mlx4_func_cap	   *func_cap = NULL;
-	struct mlx4_init_hca_param *hca_param = NULL;
+	struct mlx4_dev_cap	   *dev_cap;
+	struct mlx4_func_cap	   *func_cap;
+	struct mlx4_init_hca_param *hca_param;
 
 	hca_param = kzalloc(sizeof(*hca_param), GFP_KERNEL);
 	func_cap = kzalloc(sizeof(*func_cap), GFP_KERNEL);
@@ -2294,8 +2294,8 @@ static int mlx4_init_fw(struct mlx4_dev *dev)
 static int mlx4_init_hca(struct mlx4_dev *dev)
 {
 	struct mlx4_priv	  *priv = mlx4_priv(dev);
-	struct mlx4_init_hca_param *init_hca = NULL;
-	struct mlx4_dev_cap	  *dev_cap = NULL;
+	struct mlx4_init_hca_param *init_hca;
+	struct mlx4_dev_cap	  *dev_cap;
 	struct mlx4_adapter	   adapter;
 	struct mlx4_profile	   profile;
 	u64 icm_size;
-- 
2.34.1


