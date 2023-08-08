Return-Path: <netdev+bounces-25397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C981773DB7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4A7280BEC
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAB11401C;
	Tue,  8 Aug 2023 16:21:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE36813FFF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:21:41 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718A901F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:21:23 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKwsF4FXbz1hwHd;
	Tue,  8 Aug 2023 22:42:57 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 22:45:46 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: phy: Remove two unused function declarations
Date: Tue, 8 Aug 2023 22:45:45 +0800
Message-ID: <20230808144545.37484-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 1e2dc14509fd ("net: ethtool: Add helpers for reporting test results")
declared but never implemented these function.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/phy.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index ba08b0e60279..b963ce22e7c7 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1732,10 +1732,6 @@ int phy_start_cable_test_tdr(struct phy_device *phydev,
 }
 #endif
 
-int phy_cable_test_result(struct phy_device *phydev, u8 pair, u16 result);
-int phy_cable_test_fault_length(struct phy_device *phydev, u8 pair,
-				u16 cm);
-
 static inline void phy_device_reset(struct phy_device *phydev, int value)
 {
 	mdio_device_reset(&phydev->mdio, value);
-- 
2.34.1


