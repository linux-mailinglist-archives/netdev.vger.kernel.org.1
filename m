Return-Path: <netdev+bounces-26202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E3777283
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C41F1C20FA8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1611E51D;
	Thu, 10 Aug 2023 08:11:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523571DDFB
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:11:47 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C3710EC;
	Thu, 10 Aug 2023 01:11:46 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RM01c4PVVzqSpm;
	Thu, 10 Aug 2023 16:08:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:11:42 +0800
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
Subject: [patch net-next 3/5] net: gemini: Remove redundant of_match_ptr()
Date: Thu, 10 Aug 2023 16:11:00 +0800
Message-ID: <20230810081102.2981505-4-ruanjinjie@huawei.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The driver depends on CONFIG_OF, it is not necessary to use
of_match_ptr() here.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/cortina/gemini.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 692cb2d04c1c..a8b9d1a3e4d5 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2538,7 +2538,7 @@ MODULE_DEVICE_TABLE(of, gemini_ethernet_port_of_match);
 static struct platform_driver gemini_ethernet_port_driver = {
 	.driver = {
 		.name = "gemini-ethernet-port",
-		.of_match_table = of_match_ptr(gemini_ethernet_port_of_match),
+		.of_match_table = gemini_ethernet_port_of_match,
 	},
 	.probe = gemini_ethernet_port_probe,
 	.remove = gemini_ethernet_port_remove,
@@ -2604,7 +2604,7 @@ MODULE_DEVICE_TABLE(of, gemini_ethernet_of_match);
 static struct platform_driver gemini_ethernet_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(gemini_ethernet_of_match),
+		.of_match_table = gemini_ethernet_of_match,
 	},
 	.probe = gemini_ethernet_probe,
 	.remove = gemini_ethernet_remove,
-- 
2.34.1


