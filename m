Return-Path: <netdev+bounces-29299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C854782999
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 14:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAE3280E22
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E239563C9;
	Mon, 21 Aug 2023 12:55:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F155258
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 12:55:14 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E295B1
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 05:55:13 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RTsqD08lgz1L9S9;
	Mon, 21 Aug 2023 20:53:44 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 20:55:10 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux@armlinux.org.uk>, <linux@rempel-privat.de>
CC: <netdev@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: dsa: microchip: Remove unused declarations
Date: Mon, 21 Aug 2023 20:55:01 +0800
Message-ID: <20230821125501.19624-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 91a98917a883 ("net: dsa: microchip: move switch chip_id detection to ksz_common")
removed ksz8_switch_detect() but not its declaration.
Commit 6ec23aaaac43 ("net: dsa: microchip: move ksz_dev_ops to ksz_common.c")
declared but never implemented other functions.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/dsa/microchip/ksz8.h    | 2 --
 drivers/net/dsa/microchip/ksz9477.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index e68465fdf6b9..4cea811e73ac 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -48,13 +48,11 @@ int ksz8_port_mirror_add(struct ksz_device *dev, int port,
 			 bool ingress, struct netlink_ext_ack *extack);
 void ksz8_port_mirror_del(struct ksz_device *dev, int port,
 			  struct dsa_mall_mirror_tc_entry *mirror);
-int ksz8_get_stp_reg(void);
 void ksz8_get_caps(struct ksz_device *dev, int port,
 		   struct phylink_config *config);
 void ksz8_config_cpu_port(struct dsa_switch *ds);
 int ksz8_enable_stp_addr(struct ksz_device *dev);
 int ksz8_reset_switch(struct ksz_device *dev);
-int ksz8_switch_detect(struct ksz_device *dev);
 int ksz8_switch_init(struct ksz_device *dev);
 void ksz8_switch_exit(struct ksz_device *dev);
 int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu);
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index b6f7e3c46e3f..a6f425866a29 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -36,7 +36,6 @@ int ksz9477_port_mirror_add(struct ksz_device *dev, int port,
 			    bool ingress, struct netlink_ext_ack *extack);
 void ksz9477_port_mirror_del(struct ksz_device *dev, int port,
 			     struct dsa_mall_mirror_tc_entry *mirror);
-int ksz9477_get_stp_reg(void);
 void ksz9477_get_caps(struct ksz_device *dev, int port,
 		      struct phylink_config *config);
 int ksz9477_fdb_dump(struct ksz_device *dev, int port,
@@ -54,7 +53,6 @@ void ksz9477_config_cpu_port(struct dsa_switch *ds);
 int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val);
 int ksz9477_enable_stp_addr(struct ksz_device *dev);
 int ksz9477_reset_switch(struct ksz_device *dev);
-int ksz9477_dsa_init(struct ksz_device *dev);
 int ksz9477_switch_init(struct ksz_device *dev);
 void ksz9477_switch_exit(struct ksz_device *dev);
 void ksz9477_port_queue_split(struct ksz_device *dev, int port);
-- 
2.34.1


