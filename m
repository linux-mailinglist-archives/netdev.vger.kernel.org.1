Return-Path: <netdev+bounces-100853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ED88FC482
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2F7B23F87
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD77F1922D6;
	Wed,  5 Jun 2024 07:26:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56DA1922C6;
	Wed,  5 Jun 2024 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572389; cv=none; b=nEg5Xp4Za0o1cEelKpiyAjz6bBNSyHCf0b62EYromiZu00KhCj7sFPNf75GYNBVyRFMKKgPeQ0bR6NB8jkFg/yYPGr12XHb8aioY6aVLLpG0hPlajoGyLiq5JwuujsbQ5ERNpxp4QrEcjLYQskStatev5Yyf48AJaQmkI12YO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572389; c=relaxed/simple;
	bh=qmLLSMhiIObbss0HvgBEKSsJcplmB/eshsA7eGBWv3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SGlTC+Yw0efBlBLdFuE6BWUDEIeNw9lQMncMTf3odFfL0bqikwpO8fYLm4+zmwan7y+xtgapdS8saJ2CBo9wFv6M9nyTmUgjKXsVyr8o59lZvGjb9F+ImYUcoMJ7RBIUIxujf51c2CtiqsWgsThDZ55iQbg8ARJZcU1RSlX7fMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VvJmv05wqzmXyX;
	Wed,  5 Jun 2024 15:21:51 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 04986140258;
	Wed,  5 Jun 2024 15:26:09 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 15:26:08 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/2] There are some bugfix for the HNS3 ethernet driver
Date: Wed, 5 Jun 2024 15:20:56 +0800
Message-ID: <20240605072058.2027992-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)

There are some bugfix for the HNS3 ethernet driver

Jie Wang (1):
  net: hns3: add cond_resched() to hns3 ring buffer init process

Yonglong Liu (1):
  net: hns3: fix kernel crash problem in concurrent scenario

 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  4 ++++
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 ++
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 21 ++++++++++++++-----
 3 files changed, 22 insertions(+), 5 deletions(-)

-- 
2.30.0


