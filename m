Return-Path: <netdev+bounces-27612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C627577C8D4
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC7428139B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A08AD38;
	Tue, 15 Aug 2023 07:49:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43660185D
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:49:47 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9252611A
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 00:49:46 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQ3Kk09rgz1GDV4;
	Tue, 15 Aug 2023 15:48:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 15:49:44 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <bongsu.jeon@samsung.com>, <krzysztof.kozlowski@linaro.org>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH -next] nfc: virtual_ncidev: Use module_misc_device macro to simplify the code
Date: Tue, 15 Aug 2023 15:49:27 +0800
Message-ID: <20230815074927.1016787-1-lizetao1@huawei.com>
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
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the module_misc_device macro to simplify the code, which is the
same as declaring with module_init() and module_exit().

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/nfc/virtual_ncidev.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index bb76c7c7cc82..b027be0b0b6f 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -200,18 +200,7 @@ static struct miscdevice miscdev = {
 	.mode = 0600,
 };
 
-static int __init virtual_ncidev_init(void)
-{
-	return misc_register(&miscdev);
-}
-
-static void __exit virtual_ncidev_exit(void)
-{
-	misc_deregister(&miscdev);
-}
-
-module_init(virtual_ncidev_init);
-module_exit(virtual_ncidev_exit);
+module_misc_device(miscdev);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Virtual NCI device simulation driver");
-- 
2.34.1


