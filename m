Return-Path: <netdev+bounces-25827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEF9775F35
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17914281C8B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12B018019;
	Wed,  9 Aug 2023 12:36:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D917724
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:36:36 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8FA1BF7
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:36:33 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLTws6D17z9txT;
	Wed,  9 Aug 2023 20:33:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 20:36:29 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next 0/5] bonding: do some cleanups in bond driver
Date: Wed, 9 Aug 2023 20:41:02 +0800
Message-ID: <20230809124107.360574-1-shaozhengchao@huawei.com>
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
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Do some cleanups in bond driver.

Zhengchao Shao (5):
  bonding: add modifier to initialization function and exit function
  bonding: remove warning printing in bond_create_debugfs
  bonding: remove unnecessary NULL check in debugfs function
  bonding: use bond_set_slave_arr to simplify code
  bonding: remove unnecessary NULL check in bond_destructor

 drivers/net/bonding/bond_debugfs.c | 16 ++------------
 drivers/net/bonding/bond_main.c    | 34 +++++-------------------------
 drivers/net/bonding/bond_sysfs.c   |  4 ++--
 3 files changed, 9 insertions(+), 45 deletions(-)

-- 
2.34.1


