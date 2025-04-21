Return-Path: <netdev+bounces-184377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC0EA951FA
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 15:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5393B3B3448
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26A266581;
	Mon, 21 Apr 2025 13:50:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DD264A74;
	Mon, 21 Apr 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243443; cv=none; b=AZOJwprdr7l3OGkgh03OgWq/4qaDgq08ZTYujWzUfH3cu9Foei9DfC1YrbNJWiXRVzvOU7ZSrlphTnmXgp/ax/pRa2uLYSDH1v8MWTdqN5RgvBiaqhCC5da5JHQHdH8F0Pcxh52H6Sv1RnVqhkQPjQ/llWXoJr39dtwGGVULHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243443; c=relaxed/simple;
	bh=SEMtQfQ8NsSlHutbWhTDFmQl9QLQKGw1LL1AgG36Arg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZPZvPleVfrVF7G43zM+W/30sSkrU1kKNVTYoLtuf/3n5xxx1b7nAZWh550prS5iukccpdKDLnC9je84XcSZHFRsjxLCnW4tKkxfDwqwLHdGeyRSbtkqitwSJXVv5Ui2tOSVVETGe8WjAn0C6iTLGAna/A20zjy3vCm4eVmbvGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Zh6FW401szsShh;
	Mon, 21 Apr 2025 21:50:23 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6900D1400DD;
	Mon, 21 Apr 2025 21:50:38 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 21:50:37 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gerhard@engleder-embedded.com>,
	<shaojijie@huawei.com>
Subject: [PATCH RFC net-next 0/2] net: hibmcge: add support for selftest
Date: Mon, 21 Apr 2025 21:43:56 +0800
Message-ID: <20250421134358.1241851-1-shaojijie@huawei.com>
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
 kwepemk100013.china.huawei.com (7.202.194.61)

patch1: the net_selftest_custom() interface is added
to support driver customized loopback tests and
common loopback tests.

patch2: add selftest support for hibmcge

Jijie Shao (2):
  net: selftest: add net_selftest_custom() interface
  net: hibmcge: add support for selftest

 .../ethernet/hisilicon/hibmcge/hbg_common.h   |   2 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  |  60 +++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |   6 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c |   3 +-
 include/net/selftests.h                       |  61 ++++++
 net/core/selftests.c                          | 188 +++++++++++++++++-
 8 files changed, 310 insertions(+), 12 deletions(-)

-- 
2.33.0


