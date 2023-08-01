Return-Path: <netdev+bounces-23204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497DF76B4E4
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013F9281A1D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A09F20F8D;
	Tue,  1 Aug 2023 12:39:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA731E503
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 12:39:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DE8A8;
	Tue,  1 Aug 2023 05:39:32 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFZQr3QfQzrS51;
	Tue,  1 Aug 2023 20:38:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 20:39:29 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <borisp@nvidia.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next] net/mlx5: remove many unnecessary NULL values
Date: Tue, 1 Aug 2023 20:38:54 +0800
Message-ID: <20230801123854.375155-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ther are many pointers assigned first, which need not to be initialized, so
remove the NULL assignment.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c   | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c
index 39c03dcbd196..e5c1012921d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c
@@ -57,7 +57,7 @@ static const char * const mlx5_fpga_qp_error_strings[] = {
 };
 static struct mlx5_fpga_device *mlx5_fpga_device_alloc(void)
 {
-	struct mlx5_fpga_device *fdev = NULL;
+	struct mlx5_fpga_device *fdev;
 
 	fdev = kzalloc(sizeof(*fdev), GFP_KERNEL);
 	if (!fdev)
@@ -252,7 +252,7 @@ int mlx5_fpga_device_start(struct mlx5_core_dev *mdev)
 
 int mlx5_fpga_init(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_fpga_device *fdev = NULL;
+	struct mlx5_fpga_device *fdev;
 
 	if (!MLX5_CAP_GEN(mdev, fpga)) {
 		mlx5_core_dbg(mdev, "FPGA capability not present\n");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
index 4047629a876b..30564d9b00e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
@@ -40,7 +40,7 @@ struct mlx5_hv_vhca_agent {
 
 struct mlx5_hv_vhca *mlx5_hv_vhca_create(struct mlx5_core_dev *dev)
 {
-	struct mlx5_hv_vhca *hv_vhca = NULL;
+	struct mlx5_hv_vhca *hv_vhca;
 
 	hv_vhca = kzalloc(sizeof(*hv_vhca), GFP_KERNEL);
 	if (!hv_vhca)
-- 
2.34.1


