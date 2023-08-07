Return-Path: <netdev+bounces-24973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D26772672
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9297C281292
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688D107B3;
	Mon,  7 Aug 2023 13:48:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD18107A0
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:48:28 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B919B7;
	Mon,  7 Aug 2023 06:48:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RKHhB5VLTz4f3lWx;
	Mon,  7 Aug 2023 21:47:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.111])
	by APP2 (Coremail) with SMTP id Syh0CgCnyW0N9tBkkl+cAA--.36243S2;
	Mon, 07 Aug 2023 21:47:57 +0800 (CST)
From: Xiang Yang <xiangyang@huaweicloud.com>
To: clement.leger@bootlin.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	olteanv@gmail.com,
	f.fainelli@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	xiangyang3@huawei.com
Subject: [PATCH -next] net: pcs: Add missing put_device call in miic_create
Date: Mon,  7 Aug 2023 13:47:14 +0000
Message-Id: <20230807134714.2048214-1-xiangyang@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnyW0N9tBkkl+cAA--.36243S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWDGr47ZFWxuF4fuw1rJFb_yoWDWFcE93
	y7Zr1fXr45Gwnaq34UAw43ZFyFkFs2qFWrWF4IgryrJ3yxWFs7Xrs7ursIq3y3Xa9FgasF
	9rn8AFZF93yxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_JrC_JFWl1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: x0ld0wp1dqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xiang Yang <xiangyang3@huawei.com>

The reference of pdev->dev is taken by of_find_device_by_node, so
it should be released when error out.

Fixes: 7dc54d3b8d91 ("net: pcs: add Renesas MII converter driver")
Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index e5d642c67a2c..d097f123635a 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -318,8 +318,10 @@ struct phylink_pcs *miic_create(struct device *dev, struct device_node *np)
 		return ERR_PTR(-EPROBE_DEFER);
 
 	miic_port = kzalloc(sizeof(*miic_port), GFP_KERNEL);
-	if (!miic_port)
+	if (!miic_port) {
+		put_device(&pdev->dev);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	miic = platform_get_drvdata(pdev);
 	device_link_add(dev, miic->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
-- 
2.34.1


