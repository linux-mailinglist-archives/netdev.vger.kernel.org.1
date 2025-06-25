Return-Path: <netdev+bounces-200921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E549AE755F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847225A46B9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB31DE3C7;
	Wed, 25 Jun 2025 03:41:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FD81DE2DE;
	Wed, 25 Jun 2025 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750822893; cv=none; b=txoZ8/aGybkn63G+Tt6WONEgNM2MCvi3WS2Yr/v3zM4m8hpia6ovQP0JBUXXie6l8+S/pCV07iVE9M5OPAAtRkfugoWPuPLDEert8PrAGA0eySpU0Acld49/Bh0W/M9/eihFZ0TG6XYlnAGeP8iuupe15qxFSvN8gX0lquvYYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750822893; c=relaxed/simple;
	bh=pJlk/Vr+JnLP7Y7KbyoJrGrIKtFl7GSOR3i9X6pFKEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DSVmVDwsrUkOQ9O8vPXV55l8JgXoHQLYfqIjB7ZggXHIp8ub5pPpw9QRWSgkizOV8YWzsF/uxxBROU171oBwrkJMgRPjrS4lS7swrjiUK6JGBamZMlRZEUfGRnNLQWYpJ0aZm4SDUmaR0jhZQTuX4yqTb/MGbsOxWwel55dlfCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bRnZL2sfVz2Cfds;
	Wed, 25 Jun 2025 11:37:30 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id C95F1140279;
	Wed, 25 Jun 2025 11:41:27 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Jun 2025 11:41:26 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
	<mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v05 0/8] net: hinic3: Add a driver for Huawei 3rd gen  NIC - management interfaces
Date: Wed, 25 Jun 2025 11:41:11 +0800
Message-ID: <cover.1750821322.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

This is the 2/3 patch of the patch-set described below.

The patch-set contains driver for Huawei's 3rd generation HiNIC
Ethernet device that will be available in the future.

This is an SRIOV device, designed for data centers.
Initially, the driver only supports VFs.

Following the discussion over RFC01, the code will be submitted in
separate smaller patches where until the last patch the driver is
non-functional. The RFC02 submission contains overall view of the entire
driver but every patch will be posted as a standalone submission.

Changes:

PATCH 02 V01: https://lore.kernel.org/netdev/cover.1749561390.git.root@localhost.localdomain

PATCH 02 V02: https://lore.kernel.org/netdev/cover.1749718348.git.zhuyikai1@h-partners.com
* Fix build allmodconfig warning (patchwork)
* Update cover-letter changes information.

PATCH 02 V03: https://lore.kernel.org/netdev/cover.1750054732.git.zhuyikai1@h-partners.com
* Use refcount_*() instead of atomic_*() (Jakub Kicinski)
* Consistency fixes : HIG->HIGH, BAR45->BAR4/5 , etc (ALOK TIWARI)
* Code format fixes : use \n before return, remove extra spaces (ALOK TIWARI)
* Remove hinic3_request_irq redundant error print (ALOK TIWARI)
* Modify hinic3_wq_create error print (ALOK TIWARI)

PATCH 02 V04: https://lore.kernel.org/netdev/cover.1750665915.git.zhuyikai1@h-partners.com
* Break it up into smaller patches (Jakub Kicinski)

PATCH 02 V05:
* Fix build clang warning (Jakub Kicinski)

Fan Gong (8):
  hinic3: Async Event Queue interfaces
  hinic3: Complete Event Queue interfaces
  hinic3: Command Queue framework
  hinic3: Command Queue interfaces
  hinic3: TX & RX Queue coalesce interfaces
  hinic3: Mailbox framework
  hinic3: Mailbox management interfaces
  hinic3: Interrupt request configuration

 drivers/net/ethernet/huawei/hinic3/Makefile   |   4 +-
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 912 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  | 156 +++
 .../ethernet/huawei/hinic3/hinic3_common.c    |  31 +
 .../ethernet/huawei/hinic3/hinic3_common.h    |  27 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |  79 ++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   | 803 +++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   | 130 +++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  43 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  31 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  36 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 153 ++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  16 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 137 ++-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  65 +-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  | 843 +++++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  | 127 +++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  14 +-
 .../huawei/hinic3/hinic3_queue_common.h       |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    | 109 +++
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  11 +
 22 files changed, 3726 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h


base-commit: 5e95c0a3a55aea490420bd6994805edb050cc86b
-- 
2.43.0


