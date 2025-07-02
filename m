Return-Path: <netdev+bounces-203333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D1AF1FA7
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE344A78DA
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B5F276041;
	Wed,  2 Jul 2025 13:04:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F027A444;
	Wed,  2 Jul 2025 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461460; cv=none; b=DLN9kC6/DNi5PbnCFFjV17tIWAfdXOebPEVtQzjXpgNG/FP/Aa1V+eULcSixYpgPCkSV70it8RkesmiJjWlgBLQNrdgnG/sKAmljtB+YDrKJndYJsPmu7iHJ70tfxH46G1tdW2MrtECfMDWciaxim8MHhNISxE/bXwwU9U0hvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461460; c=relaxed/simple;
	bh=dj15Mi3BU8ND26XFMCNBWgqqYOyprcrvH39r/bX6qVk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HWcDUg60AqogK6Q72CCkzi3b/NgPGZSoxJoyN4ztcfoMKM3iIzdLqQDSrpQ023qLHG9FqhJNNr4sMNo1K/d7HNW1gCwyM2rVduCXemrrIA1qtYy0VxtKMxnjtOpVhSLfYZZJlCinMfP3/D1/Ii9zJYTSrwYlykAe+fSUaMtB7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bXKm94f0Vz1R7nZ;
	Wed,  2 Jul 2025 21:01:45 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B90A9140279;
	Wed,  2 Jul 2025 21:04:16 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Jul 2025 21:04:16 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 0/4] There are some bugfix for the HNS3 ethernet driver
Date: Wed, 2 Jul 2025 20:57:27 +0800
Message-ID: <20250702125731.2875331-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

There are some bugfix for the HNS3 ethernet driver

Hao Lan (1):
  net: hns3: fixed vf get max channels bug

Jian Shen (1):
  net: hns3: fix concurrent setting vlan filter issue

Jijie Shao (1):
  net: hns3: default enable tx bounce buffer when smmu enabled

Yonglong Liu (1):
  net: hns3: disable interrupt when ptp init failed

 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 31 ++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 ++
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 +++++++++++++++++
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 36 +++++++++++--------
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  9 +++--
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  6 +---
 6 files changed, 94 insertions(+), 23 deletions(-)

-- 
2.33.0


