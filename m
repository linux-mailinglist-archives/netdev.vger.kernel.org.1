Return-Path: <netdev+bounces-27377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E049A77BB56
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 16:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108301C20A5C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB0BC143;
	Mon, 14 Aug 2023 14:16:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3CBA4C
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 14:16:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A629A1720
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:16:31 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RPbW26mpYzNn02;
	Mon, 14 Aug 2023 21:54:54 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 21:58:25 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: e1000e: Remove unused declarations
Date: Mon, 14 Aug 2023 21:58:21 +0800
Message-ID: <20230814135821.4808-1-yuehaibing@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit bdfe2da6aefd ("e1000e: cosmetic move of function prototypes to the new mac.h")
declared but never implemented them.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/e1000e/mac.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/mac.h b/drivers/net/ethernet/intel/e1000e/mac.h
index 6ab261119801..563176fd436e 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.h
+++ b/drivers/net/ethernet/intel/e1000e/mac.h
@@ -29,8 +29,6 @@ s32 e1000e_set_fc_watermarks(struct e1000_hw *hw);
 s32 e1000e_setup_fiber_serdes_link(struct e1000_hw *hw);
 s32 e1000e_setup_led_generic(struct e1000_hw *hw);
 s32 e1000e_setup_link_generic(struct e1000_hw *hw);
-s32 e1000e_validate_mdi_setting_generic(struct e1000_hw *hw);
-s32 e1000e_validate_mdi_setting_crossover_generic(struct e1000_hw *hw);
 
 void e1000e_clear_hw_cntrs_base(struct e1000_hw *hw);
 void e1000_clear_vfta_generic(struct e1000_hw *hw);
-- 
2.34.1


