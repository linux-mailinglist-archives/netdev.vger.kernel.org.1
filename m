Return-Path: <netdev+bounces-28336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DD377F15D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FC9281DD6
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4077CD2E5;
	Thu, 17 Aug 2023 07:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316192100
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:40:25 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BF32D66
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:40:23 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RRH1w1C0mz1GF3t;
	Thu, 17 Aug 2023 15:39:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 15:40:20 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <Shyam-sundar.S-k@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <iyappan@os.amperecomputing.com>,
	<keyur@os.amperecomputing.com>, <quan@os.amperecomputing.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<yankejian@huawei.com>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next 0/3] net: Fix return value check for get_phy_device()
Date: Thu, 17 Aug 2023 15:39:57 +0800
Message-ID: <20230817074000.355564-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The get_phy_device() function returns error pointers and never
returns NULL. Update the checks accordingly.

And get_phy_device() returns -EIO on bus access error and -ENOMEM
on kzalloc failure in addition to -ENODEV, return PTR_ERR is more
sensible.

Ruan Jinjie (3):
  net: mdio: Fix return value check for get_phy_device()
  amd-xgbe: Return proper error code for get_phy_device()
  net: hisilicon: hns: Fix return value check for get_phy_device()

 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c       | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 4 ++--
 drivers/net/mdio/mdio-xgene.c                     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


