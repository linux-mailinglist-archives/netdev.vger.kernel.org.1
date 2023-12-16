Return-Path: <netdev+bounces-58198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7487381584B
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 08:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B291C2499E
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 07:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78142134D9;
	Sat, 16 Dec 2023 07:41:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC0F134AD
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SsdL56GtXzWjRq;
	Sat, 16 Dec 2023 15:40:45 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 53251140415;
	Sat, 16 Dec 2023 15:40:59 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 16 Dec
 2023 15:40:58 +0800
From: Liu Jian <liujian56@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <vladimir.oltean@nxp.com>,
	<andrew@lunn.ch>, <d-tatianin@yandex-team.ru>, <justin.chen@broadcom.com>,
	<rkannoth@marvell.com>, <idosch@nvidia.com>, <jdamato@fastly.com>,
	<netdev@vger.kernel.org>
CC: <liujian56@huawei.com>
Subject: [PATCH net v3 0/2] check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()
Date: Sat, 16 Dec 2023 15:52:17 +0800
Message-ID: <20231216075219.2379123-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)

v2->v3: 
	Filter using vlan_hw_filter_capable().
	Add one basic test.

Liu Jian (2):
  net: check vlan filter feature in vlan_vids_add_by_dev() and
    vlan_vids_del_by_dev()
  selftests: add vlan hw filter tests

 net/8021q/vlan_core.c                         |  9 +++++-
 tools/testing/selftests/net/Makefile          |  1 +
 tools/testing/selftests/net/vlan_hw_filter.sh | 29 +++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/vlan_hw_filter.sh

-- 
2.34.1


