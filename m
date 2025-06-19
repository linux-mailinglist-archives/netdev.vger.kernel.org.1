Return-Path: <netdev+bounces-199516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F15CAE0937
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1483A1ACD
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712C523498F;
	Thu, 19 Jun 2025 14:51:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BD2D78A;
	Thu, 19 Jun 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344693; cv=none; b=HGM+FHWvS6926GqIGrvTSXn7s3cPzTK2C6ZlZR32cCcpsjWZyvA+yHtJKtls23h1C+oD521OCiXDWMQrHIYOPMQYy0PZiGQyU/Em+v1Xn9DeBG7CcFStKwQarUfS4Yf85DWVO+pvoD2zpc4hSVrostrtu5GR/r3Ap9AcwCgozD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344693; c=relaxed/simple;
	bh=46ySN3jtVdfOv6fpyJ7IOd/wZVhkO8P7KnJZ87YD0Xw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NUR8bdA8vQdf9mMjxqGQy2wQUQXQ3Ssn2j0HoPtWILuoot86bnpvdislmA/SdHnelm/MugP4o06/lZ8u2wnOJF9jdluQtIizohdEcVoHHR7AS9v58Kasu8ElQ9sjk99KKPMM+hL1J0rXUP0uDJgrveXVOJOv6P9DK8g7k+mgkXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bNNjV2Zq3z10XPL;
	Thu, 19 Jun 2025 22:46:54 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 173CD14011A;
	Thu, 19 Jun 2025 22:51:29 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Jun 2025 22:51:28 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 0/3] Support some features for the HIBMCGE driver
Date: Thu, 19 Jun 2025 22:44:20 +0800
Message-ID: <20250619144423.2661528-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Support some features for the HIBMCGE driver

Jijie Shao (3):
  net: hibmcge: support scenario without PHY.
  net: hibmcge: adjust the burst len configuration of the MAC controller
    to improve TX performance.
  net: hibmcge: configure FIFO thresholds according to the MAC
    controller documentation

 .../ethernet/hisilicon/hibmcge/hbg_diagnose.c |   6 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  |   3 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 100 +++++++++++++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  57 ++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  41 ++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c |  76 ++++++++++---
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |   3 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   9 ++
 8 files changed, 274 insertions(+), 21 deletions(-)

-- 
2.33.0


