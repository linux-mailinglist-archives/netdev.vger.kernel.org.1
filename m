Return-Path: <netdev+bounces-26361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F967779CB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A98A1C2150F
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEE31ADC6;
	Thu, 10 Aug 2023 13:45:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EA1E1D8
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:45:37 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D166E54
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:45:36 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RM7Qn4vzkzqT2q;
	Thu, 10 Aug 2023 21:42:41 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 21:45:32 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <shaozhengchao@huawei.com>, <liuhangbin@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next,v2 0/5] bonding: do some cleanups in bond driver
Date: Thu, 10 Aug 2023 21:50:02 +0800
Message-ID: <20230810135007.3834770-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Do some cleanups in bond driver.

---
v2: use IS_ERR instead of NULL check in patch 2/5, update commit 
    information in patch 3/5, remove inline modifier in patch 4/5
---
Zhengchao Shao (5):
  bonding: add modifier to initialization function and exit function
  bonding: use IS_ERR instead of NULL check in bond_create_debugfs
  bonding: remove redundant NULL check in debugfs function
  bonding: use bond_set_slave_arr to simplify code
  bonding: remove unnecessary NULL check in bond_destructor

 drivers/net/bonding/bond_debugfs.c | 15 +++-----------
 drivers/net/bonding/bond_main.c    | 32 ++++--------------------------
 drivers/net/bonding/bond_sysfs.c   |  4 ++--
 3 files changed, 9 insertions(+), 42 deletions(-)

-- 
2.34.1


