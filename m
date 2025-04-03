Return-Path: <netdev+bounces-179050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DBAA7A478
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 15:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88F61885F99
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4352B24E4D4;
	Thu,  3 Apr 2025 13:59:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D979224E00D;
	Thu,  3 Apr 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688771; cv=none; b=F7XIj2FzV88Zu70JleEGWTPIgzE3QJkttzLzy5sVj6x+dKczW5p7xAgmUrzvYGyrqAr3EpcmHFTQhG3qsHxniAjmF1vgQiJkLIDDeIRBn5O0neC/98+KSX567gI8grkf83C5vQTYznLMRTlQHfjd2o6DurDu2XVJwWyWauIMrQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688771; c=relaxed/simple;
	bh=paOeAlkX7Ug/OJ0UyAFOD59moM+PIORWmjZRIt4KWfU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=okJWuBgp045RWqc3alFSr477FK4jfeoZx+tIsgctd9VmwK3Y1gF+6tC0RM7tTsP4GKJYG7vEAjSeFAhH+xxKmrXlhhvcYdpmPU5do2AAtFePV/rh+QdIjnBdZAJCjsMO4KBxkA917vMjrlXiE/mH9ZU2gfLzmcru6PNYPj9rb5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZT3Hc0LzNz13L5q;
	Thu,  3 Apr 2025 21:58:52 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5998E140383;
	Thu,  3 Apr 2025 21:59:25 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 21:59:24 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net v2 0/7] There are some bugfix for hibmcge driver
Date: Thu, 3 Apr 2025 21:53:04 +0800
Message-ID: <20250403135311.545633-1-shaojijie@huawei.com>
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
 kwepemk100013.china.huawei.com (7.202.194.61)

There are some bugfix for hibmcge driver

---
ChangeLog:
v1 -> v2:
  - Add more details in commit log for patch1, suggested by Simon Horman.
  v1: https://lore.kernel.org/all/20250402133905.895421-1-shaojijie@huawei.com/
---

Jijie Shao (7):
  net: hibmcge: fix incorrect pause frame statistics issue
  net: hibmcge: fix incorrect multicast filtering issue
  net: hibmcge: fix the share of irq statistics among different network
    ports issue
  net: hibmcge: fix wrong mtu log issue
  net: hibmcge: fix the incorrect np_link fail state issue.
  net: hibmcge: fix not restore rx pause mac addr after reset issue
  net: hibmcge: fix multiple phy_stop() issue

 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  8 ++++---
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  | 11 +++++----
 .../ethernet/hisilicon/hibmcge/hbg_diagnose.c |  2 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  |  3 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  7 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 24 ++++++++++++-------
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  8 +++----
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 11 ++++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  3 +++
 9 files changed, 55 insertions(+), 22 deletions(-)

-- 
2.33.0


