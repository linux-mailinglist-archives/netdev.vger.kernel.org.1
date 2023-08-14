Return-Path: <netdev+bounces-27225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE1E77AFC4
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 04:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9EA280E30
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 02:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A93442E;
	Mon, 14 Aug 2023 02:56:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471FE187C
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 02:56:08 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A8E6A;
	Sun, 13 Aug 2023 19:56:07 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPJpl01B4ztRxS;
	Mon, 14 Aug 2023 10:52:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 10:56:04 +0800
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
Subject: [PATCH net-next v3 5/5] wlcore: spi: Remove redundant of_match_ptr()
Date: Mon, 14 Aug 2023 10:55:19 +0800
Message-ID: <20230814025520.2708714-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814025520.2708714-2-ruanjinjie@huawei.com>
References: <20230814025520.2708714-2-ruanjinjie@huawei.com>
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
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The driver depends on CONFIG_OF, it is not necessary to use
of_match_ptr() here.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/wireless/ti/wlcore/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/spi.c b/drivers/net/wireless/ti/wlcore/spi.c
index 3f88e6a0a510..7d9a139db59e 100644
--- a/drivers/net/wireless/ti/wlcore/spi.c
+++ b/drivers/net/wireless/ti/wlcore/spi.c
@@ -554,7 +554,7 @@ static void wl1271_remove(struct spi_device *spi)
 static struct spi_driver wl1271_spi_driver = {
 	.driver = {
 		.name		= "wl1271_spi",
-		.of_match_table = of_match_ptr(wlcore_spi_of_match_table),
+		.of_match_table = wlcore_spi_of_match_table,
 	},
 
 	.probe		= wl1271_probe,
-- 
2.34.1


