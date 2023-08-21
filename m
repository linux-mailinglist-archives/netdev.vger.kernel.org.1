Return-Path: <netdev+bounces-29303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C37BE7829D9
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD4C1C208DB
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5063063D3;
	Mon, 21 Aug 2023 13:02:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4680C5258
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:02:27 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6716D9
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:02:26 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTsyf0NSjzVkCQ;
	Mon, 21 Aug 2023 21:00:10 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 21:02:22 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <vladimir.oltean@nxp.com>, <claudiu.manoil@nxp.com>,
	<alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<yuehaibing@huawei.com>, <colin.foster@in-advantage.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: mscc: ocelot: Remove unused declarations
Date: Mon, 21 Aug 2023 21:02:18 +0800
Message-ID: <20230821130218.19096-1-yuehaibing@huawei.com>
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 6c30384eb1de ("net: mscc: ocelot: register devlink ports")
declared but never implemented ocelot_devlink_init() and
ocelot_devlink_teardown().
Commit 2096805497e2 ("net: mscc: ocelot: automatically detect VCAP constants")
declared but never implemented ocelot_detect_vcap_constants().
Commit 403ffc2c34de ("net: mscc: ocelot: add support for preemptible traffic classes")
declared but never implemented ocelot_port_update_preemptible_tcs().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/mscc/ocelot.h      | 2 --
 drivers/net/ethernet/mscc/ocelot_vcap.h | 1 -
 include/soc/mscc/ocelot.h               | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index 87f2055c242c..e50be508c166 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -97,8 +97,6 @@ int ocelot_netdev_to_port(struct net_device *dev);
 int ocelot_probe_port(struct ocelot *ocelot, int port, struct regmap *target,
 		      struct device_node *portnp);
 void ocelot_release_port(struct ocelot_port *ocelot_port);
-int ocelot_devlink_init(struct ocelot *ocelot);
-void ocelot_devlink_teardown(struct ocelot *ocelot);
 int ocelot_port_devlink_init(struct ocelot *ocelot, int port,
 			     enum devlink_port_flavour flavour);
 void ocelot_port_devlink_teardown(struct ocelot *ocelot, int port);
diff --git a/drivers/net/ethernet/mscc/ocelot_vcap.h b/drivers/net/ethernet/mscc/ocelot_vcap.h
index 523611ccc48f..6f546695faa5 100644
--- a/drivers/net/ethernet/mscc/ocelot_vcap.h
+++ b/drivers/net/ethernet/mscc/ocelot_vcap.h
@@ -15,7 +15,6 @@
 int ocelot_vcap_filter_stats_update(struct ocelot *ocelot,
 				    struct ocelot_vcap_filter *rule);
 
-void ocelot_detect_vcap_constants(struct ocelot *ocelot);
 int ocelot_vcap_init(struct ocelot *ocelot);
 
 int ocelot_setup_tc_cls_flower(struct ocelot_port_private *priv,
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index a8c2817335b9..1e1b40f4e664 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -1165,7 +1165,6 @@ int ocelot_port_get_mm(struct ocelot *ocelot, int port,
 		       struct ethtool_mm_state *state);
 int ocelot_port_mqprio(struct ocelot *ocelot, int port,
 		       struct tc_mqprio_qopt_offload *mqprio);
-void ocelot_port_update_preemptible_tcs(struct ocelot *ocelot, int port);
 
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
 int ocelot_mrp_add(struct ocelot *ocelot, int port,
-- 
2.34.1


