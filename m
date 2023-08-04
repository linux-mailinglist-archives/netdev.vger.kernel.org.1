Return-Path: <netdev+bounces-24343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8858976FDF9
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8741C217C6
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EF5AD26;
	Fri,  4 Aug 2023 10:00:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF7A924
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:00:18 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605D046AC
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 03:00:17 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RHLjk1JZQz1Z1S9;
	Fri,  4 Aug 2023 17:57:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 18:00:14 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <ioana.ciornei@nxp.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 0/2] net: Remove redundant initialization owner
Date: Fri, 4 Aug 2023 17:59:44 +0800
Message-ID: <20230804095946.99956-1-lizetao1@huawei.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch set removes redundant initialization owner when register a
fsl_mc_driver driver

Li Zetao (2):
  net: dpaa2-eth: Remove redundant initialization owner in
    dpaa2_eth_driver
  net: dpaa2-switch: Remove redundant initialization owner in
    dpaa2_switch_drv

 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c    | 1 -
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 1 -
 2 files changed, 2 deletions(-)

-- 
2.34.1


