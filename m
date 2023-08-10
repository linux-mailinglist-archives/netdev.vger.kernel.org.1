Return-Path: <netdev+bounces-26200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F33777274
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6015B2821CA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5811DDD3;
	Thu, 10 Aug 2023 08:11:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D35667
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:11:43 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82D72106;
	Thu, 10 Aug 2023 01:11:42 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM00p1pRhztSDr;
	Thu, 10 Aug 2023 16:08:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:11:39 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <linus.walleij@linaro.org>, <alsi@bang-olufsen.dk>, <andrew@lunn.ch>,
	<f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<clement.leger@bootlin.com>, <ulli.kroll@googlemail.com>, <kvalo@kernel.org>,
	<bhupesh.sharma@linaro.org>, <robh@kernel.org>, <elder@linaro.org>,
	<wei.fang@nxp.com>, <nicolas.ferre@microchip.com>,
	<simon.horman@corigine.com>, <romieu@fr.zoreil.com>,
	<dmitry.torokhov@gmail.com>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-wireless@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [patch net-next 1/5] net: dsa: realtek: Remove redundant of_match_ptr()
Date: Thu, 10 Aug 2023 16:10:58 +0800
Message-ID: <20230810081102.2981505-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810081102.2981505-1-ruanjinjie@huawei.com>
References: <20230810081102.2981505-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The driver depends on CONFIG_OF, it is not necessary to use
of_match_ptr() here.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/dsa/realtek/realtek-mdio.c | 2 +-
 drivers/net/dsa/realtek/realtek-smi.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 4310e7793e58..292e6d087e8b 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -276,7 +276,7 @@ MODULE_DEVICE_TABLE(of, realtek_mdio_of_match);
 static struct mdio_driver realtek_mdio_driver = {
 	.mdiodrv.driver = {
 		.name = "realtek-mdio",
-		.of_match_table = of_match_ptr(realtek_mdio_of_match),
+		.of_match_table = realtek_mdio_of_match,
 	},
 	.probe  = realtek_mdio_probe,
 	.remove = realtek_mdio_remove,
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index c2bd8bb6c9c2..ff13563059c5 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -556,7 +556,7 @@ MODULE_DEVICE_TABLE(of, realtek_smi_of_match);
 static struct platform_driver realtek_smi_driver = {
 	.driver = {
 		.name = "realtek-smi",
-		.of_match_table = of_match_ptr(realtek_smi_of_match),
+		.of_match_table = realtek_smi_of_match,
 	},
 	.probe  = realtek_smi_probe,
 	.remove = realtek_smi_remove,
-- 
2.34.1


