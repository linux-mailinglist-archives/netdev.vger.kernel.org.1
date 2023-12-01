Return-Path: <netdev+bounces-52878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C465F800835
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC0C281376
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752E11709;
	Fri,  1 Dec 2023 10:30:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA88FDD;
	Fri,  1 Dec 2023 02:30:53 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ShTjf2xhqzMnbl;
	Fri,  1 Dec 2023 18:25:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 18:30:51 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/2] There are some bugfix for the HNS ethernet driver
Date: Fri, 1 Dec 2023 18:27:01 +0800
Message-ID: <20231201102703.4134592-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected

There are some bugfix for the HNS ethernet driver

Yonglong Liu (2):
  net: hns: fix wrong head when modify the tx feature when sending
    packets
  net: hns: fix fake link up on xge port

 .../net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 28 ++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 53 +++++++++++--------
 drivers/net/ethernet/hisilicon/hns/hns_enet.h |  3 +-
 3 files changed, 61 insertions(+), 23 deletions(-)

-- 
2.30.0


