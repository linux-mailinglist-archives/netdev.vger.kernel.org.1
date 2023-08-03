Return-Path: <netdev+bounces-24105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBBD76EC72
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6B61C215E9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658421D5F;
	Thu,  3 Aug 2023 14:25:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B882200CA
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 14:25:11 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023B81BFA
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:25:04 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGrct6fddzNmPC;
	Thu,  3 Aug 2023 22:21:34 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 22:25:00 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <idosch@nvidia.com>, <petrm@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] mlxsw: spectrum: Remove unused function declarations
Date: Thu, 3 Aug 2023 22:20:47 +0800
Message-ID: <20230803142047.42660-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit c3d2ed93b14d ("mlxsw: Remove old parsing depth infrastructure")
left behind mlxsw_sp_nve_inc_parsing_depth_get()/mlxsw_sp_nve_inc_parsing_depth_put().
And commit 532b49e41e64 ("mlxsw: spectrum_span: Derive SBIB from maximum port speed & MTU")
remove mlxsw_sp_span_port_mtu_update()/mlxsw_sp_span_speed_update_work() but leave the
declarations.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h      | 4 ----
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 62151f0531ae..8da7bb04fc3a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -1401,10 +1401,6 @@ void mlxsw_sp_port_nve_fini(struct mlxsw_sp_port *mlxsw_sp_port);
 int mlxsw_sp_nve_init(struct mlxsw_sp *mlxsw_sp);
 void mlxsw_sp_nve_fini(struct mlxsw_sp *mlxsw_sp);
 
-/* spectrum_nve_vxlan.c */
-int mlxsw_sp_nve_inc_parsing_depth_get(struct mlxsw_sp *mlxsw_sp);
-void mlxsw_sp_nve_inc_parsing_depth_put(struct mlxsw_sp *mlxsw_sp);
-
 /* spectrum_trap.c */
 int mlxsw_sp_devlink_traps_init(struct mlxsw_sp *mlxsw_sp);
 void mlxsw_sp_devlink_traps_fini(struct mlxsw_sp *mlxsw_sp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h
index 82e711afb02b..c59b5f11f357 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h
@@ -93,13 +93,8 @@ void mlxsw_sp_span_respin(struct mlxsw_sp *mlxsw_sp);
 struct mlxsw_sp_span_entry *
 mlxsw_sp_span_entry_find_by_port(struct mlxsw_sp *mlxsw_sp,
 				 const struct net_device *to_dev);
-
 void mlxsw_sp_span_entry_invalidate(struct mlxsw_sp *mlxsw_sp,
 				    struct mlxsw_sp_span_entry *span_entry);
-
-int mlxsw_sp_span_port_mtu_update(struct mlxsw_sp_port *port, u16 mtu);
-void mlxsw_sp_span_speed_update_work(struct work_struct *work);
-
 int mlxsw_sp_span_agent_get(struct mlxsw_sp *mlxsw_sp, int *p_span_id,
 			    const struct mlxsw_sp_span_agent_parms *parms);
 void mlxsw_sp_span_agent_put(struct mlxsw_sp *mlxsw_sp, int span_id);
-- 
2.34.1


