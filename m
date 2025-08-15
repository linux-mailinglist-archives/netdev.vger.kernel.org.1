Return-Path: <netdev+bounces-213903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BA4B27476
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE436A02CA9
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD222D052;
	Fri, 15 Aug 2025 01:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672E273FE;
	Fri, 15 Aug 2025 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219737; cv=none; b=OOUKzPYV50GWJiNO8589DB4ccICNWrZqtorqxZpXLqAjUlXFBsyRPn70vqwaqk3YH52aEBhbVb4GqQS1z1KFzQeoWmIuPow5A47E0n+yLMJhuJlMBlwW+INq6mOYoXSqitYsYci5CgkHlMIwZCMZTQozO5BtMgwI/ijg9rpjDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219737; c=relaxed/simple;
	bh=cakiAVAfsBPYraANyCmMHZvo/cmXUdZEL0RnfhMkqCI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AzSVdRluzUo4OclKlSNdUW6EgqVjRCMtQyRMWlM+sTMuZbRYuHGdZDOjOFjsJwmhQVrviA4S3U2YCOJscOYB1UN1vH00L6N+kHWZmmbXyv5ynQEXZVs8rEOvKGhRkQgoLIBnz4qD3gbfWnKbB4FBuUQktW3SbjNrZhPR8xha9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c33cZ1WDKz2Cg12;
	Fri, 15 Aug 2025 08:57:50 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 863651A0188;
	Fri, 15 Aug 2025 09:02:10 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 09:02:08 +0800
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
	<shijing34@huawei.com>, Fu Guiming <fuguiming@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v13 0/8] net: hinic3: Add a driver for Huawei 3rd gen  NIC - management interfaces
Date: Fri, 15 Aug 2025 09:01:56 +0800
Message-ID: <cover.1755176101.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

PATCH 02 V05: https://lore.kernel.org/netdev/cover.1750821322.git.zhuyikai1@h-partners.com
* Fix build clang warning (Jakub Kicinski)

PATCH 02 V06: https://lore.kernel.org/netdev/cover.1750937080.git.zhuyikai1@h-partners.com
* Use kmalloc instead of kzalloc for cmd_buf allocation (Vadim Fedorenko)
* Use usleep_range() for avoid CPU busy waiting (Vadim Fedorenko)
* Use kcalloc for intr_coalesce initialization (Vadim Fedorenko)
* Code format fixes: use reverse x-mas tree (Vadim Fedorenko)
* Simplify hinic3_mbox_pre_init logic (Vadim Fedorenko)

PATCH 02 V07: https://lore.kernel.org/netdev/cover.1751597094.git.zhuyikai1@h-partners.com
* Use threaded IRQ instead of tasklet (Paolo Abeni)
* Use wmb instead of rmb in cmdq_sync_cmd_handler (Paolo Abeni)

PATCH 02 V08: https://lore.kernel.org/netdev/cover.1752126177.git.zhuyikai1@h-partners.com
* Remove msg_send_lock to avoid a double-locking schema (Vadim Fedorenko)
* Use send_msg_id when assigning the value to msg_id (Vadim Fedorenko)

PATCH 02 V09: https://lore.kernel.org/netdev/cover.1752489734.git.zhuyikai1@h-partners.com
* Use iowrite32be & ioread32be instead of writel & readl (Jakub Kicinski)
* Use queue_work instead of queue_work_on(WORK_CPU_UNBOUND...) (Jakub Kicinski)
* Modify aeqe & ceqe wmb comment (Jakub Kicinski)
* Remove synchronize_irq before free_irq (Jakub Kicinski)

PATCH 02 V10: https://lore.kernel.org/netdev/cover.1753152592.git.zhuyikai1@h-partners.com
* Use spin_lock in aeq & ceq events instead of bits ops (Jakub Kicinski)
* Modify memory barriers comments to explain more clearly (Jakub Kicinski)

PATCH 02 V11: https://lore.kernel.org/netdev/cover.1753240706.git.zhuyikai1@h-partners.com
* Remove unused cb_state variable (Simon Horman)

PATCH 02 V12: https://lore.kernel.org/netdev/cover.1754998409.git.zhuyikai1@h-partners.com
* Use swab32_array instead of swab32 (Simon Horman)
* Use __le16/32/64 value in structs for interacting with HW (Simon Horman)
* Remove const char __iomem * casts (Simon Horman)
* use u8 * instead of void * to be more meaningful (Simon Horman)
* use FIELD_PREP to mask and shift up values (Simon Horman)

PATCH 02 V13:
* Handle sparse build warnings (Kernel test robot)

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
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 915 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  | 156 +++
 .../ethernet/huawei/hinic3/hinic3_common.c    |  23 +
 .../ethernet/huawei/hinic3/hinic3_common.h    |  27 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |  79 ++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   | 776 +++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   | 122 +++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  43 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  31 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  36 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 148 ++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  16 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 136 ++-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  61 +-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  | 847 +++++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  | 126 +++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  14 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |   6 +-
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    | 109 +++
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  19 +-
 22 files changed, 3685 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h


base-commit: bc4c0a48bdad7f225740b8e750fdc1da6d85e1eb
-- 
2.43.0


