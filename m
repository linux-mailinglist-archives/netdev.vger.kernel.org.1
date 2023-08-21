Return-Path: <netdev+bounces-29214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6497821AC
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 04:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D54280E98
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 02:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA4410E1;
	Mon, 21 Aug 2023 02:50:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEFEA1
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 02:50:57 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD669C
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 19:50:56 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTcMM4nD4ztRr9;
	Mon, 21 Aug 2023 10:47:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 10:50:52 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <andrew@lunn.ch>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v4 0/3] net: Return PTR_ERR() for fixed_phy_register()
Date: Mon, 21 Aug 2023 10:50:17 +0800
Message-ID: <20230821025020.1971520-1-ruanjinjie@huawei.com>
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
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

fixed_phy_register() returns not only -EIO or -ENODEV, but also
-EPROBE_DEFER, -EINVAL and -EBUSY. The Best practice is to return these
error codes with PTR_ERR().

Changes in v4:
- Keep the code context consistent with another patch set.
- Update to bring the author's name before.

Jinjie Ruan (3):
  net: bgmac: Return PTR_ERR() for fixed_phy_register()
  net: bcmgenet: Return PTR_ERR() for fixed_phy_register()
  net: lan743x: Return PTR_ERR() for fixed_phy_register()

 drivers/net/ethernet/broadcom/bgmac.c         | 2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c  | 2 +-
 drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1


