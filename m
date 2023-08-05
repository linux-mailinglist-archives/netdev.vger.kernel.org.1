Return-Path: <netdev+bounces-24657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70119770F63
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 12:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1312D282439
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C1DA937;
	Sat,  5 Aug 2023 10:57:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B085238
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 10:57:44 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B7610CF
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 03:57:43 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHzzQ6lPnzrSBY;
	Sat,  5 Aug 2023 18:56:34 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 5 Aug
 2023 18:57:41 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <linux@armlinux.org.uk>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <rmk+kernel@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: sfp: Remove unused function declaration sfp_link_configure()
Date: Sat, 5 Aug 2023 18:57:40 +0800
Message-ID: <20230805105740.45980-1-yuehaibing@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit ce0aa27ff3f6 ("sfp: add sfp-bus to bridge between network devices and sfp cages")
declared but never implemented it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/phy/sfp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/phy/sfp.h b/drivers/net/phy/sfp.h
index c7cb50d10099..1fd097dccb9f 100644
--- a/drivers/net/phy/sfp.h
+++ b/drivers/net/phy/sfp.h
@@ -37,7 +37,6 @@ int sfp_module_insert(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 void sfp_module_remove(struct sfp_bus *bus);
 int sfp_module_start(struct sfp_bus *bus);
 void sfp_module_stop(struct sfp_bus *bus);
-int sfp_link_configure(struct sfp_bus *bus, const struct sfp_eeprom_id *id);
 struct sfp_bus *sfp_register_socket(struct device *dev, struct sfp *sfp,
 				    const struct sfp_socket_ops *ops);
 void sfp_unregister_socket(struct sfp_bus *bus);
-- 
2.34.1


