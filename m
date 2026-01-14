Return-Path: <netdev+bounces-249750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A1CD1D287
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AA8C300725C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F165037F735;
	Wed, 14 Jan 2026 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="355YhUvD"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A93793B5;
	Wed, 14 Jan 2026 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379926; cv=none; b=exgN24H6OtuGCNDbmZTh+6E7Bj00tDg/UG2gfAmIrKMwJ+7//p77RKEr8qieo5lv1Xz1OBxXxzYp6edrqljo5Cqzck16Ei7rlrZEQjB+IptBz3DSKLj5S0vaaTkr0aMWw4QHU8oQ/gmdANhr8hVpO4gEIavkZo9Ff4gqJzHU+DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379926; c=relaxed/simple;
	bh=b852mEZyBqKveQe2DXe4cTu9iNPUiXVeQu2Hu9DhHXk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hrj1eT3Be9zPMU77iC9fuhA/lj7H1Lolm1wK0vvsGZIfa3YCRmbSIn/CDMlQnLVp6m+pbpy2nYFs6Sn//C8F15gOLAvdcanHqtg7HpNxEu8bDmTcF5TDms/lyYD/5pEuIdiFF/Ids4si7OCHiXgV4r7+mhOgGwCbhjtSN/OAslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=355YhUvD; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=S0XJZwAwC/prQTtOt6fOEBsFP+NulB7dQ3M7bRZ024M=;
	b=355YhUvD3NeGJXtTmebENz0hk8/5WsFm0yj4Vn4nDDklQLqg3BXL5ElSNGX4K+wsZ2gcd0p4h
	b0EwnrBu9ewqYXCs1+NlxV++me+lE4Ce1XwLHbi7ZME2f9Ij1cyG7fKDSNJCciKdgtbaG26OX3u
	K3wnzw4jmPOtduCwZpnkiKo=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4drfZD67Gqz1cyTM;
	Wed, 14 Jan 2026 16:35:16 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id E26C140536;
	Wed, 14 Jan 2026 16:38:35 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 14 Jan 2026 16:38:34 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net-next v11 0/9] net: hinic3: PF initialization
Date: Wed, 14 Jan 2026 16:38:19 +0800
Message-ID: <cover.1768375903.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)

This is [1/3] part of hinic3 Ethernet driver second submission.
With this patch hinic3 becomes a complete Ethernet driver with
pf and vf.

The driver parts contained in this patch:
Add support for PF framework based on the VF code.
Add PF management interfaces to communicate with HW.
Add 8 netdev ops to configure NIC features.
Support mac filter to unicast and multicast.
Add HW event handler to manage port and link status.

Changes:

PATCH 01 V01: https://lore.kernel.org/netdev/cover.1760502478.git.zhuyikai1@h-partners.com/

PATCH 01 V02: https://lore.kernel.org/netdev/cover.1760685059.git.zhuyikai1@h-partners.com/
* Change the order of hinic3_netdev_event (Jakub Kicinski)
* Use netdev_hold/put instead of dev_hold/put (Jakub Kicinski)
* Remove the semicolon at the end of switch case (Jakub Kicinski)
* Remove redundant PF judgement in hinic3_rx_tx_flush (Paven Chebbi)
* change hinic3_send_mbox_to_mgmt errcode to EFAULT (Paven Chebbi)
* Optimize hinic3_set_bdf_ctxt parameters (Paven Chebbi)
* Modify main and CC recipients (Markus Elfring)

PATCH 01 V03: https://lore.kernel.org/netdev/cover.1761362580.git.zhuyikai1@h-partners.com/
* Use disable_delayed_work_sync instead of cancel_delayed_work_sync (Paolo Abeni)
* Fill in the missing hinic3_sync_time & hinic3_free_ppf_work (Paolo Abeni)
* Refactor hinic3_mac_filter_sync to implement linux coding style(err label)
  and improve readability (Paolo Abeni & Markus Elfring)

PATCH 01 V04: https://lore.kernel.org/netdev/cover.1761711549.git.zhuyikai1@h-partners.com/
* Use linux error value(EADDRINUSE) instead of custom value in set_mac (Simon Horman)
* Use "hinic3_check_pf_set_vf_already" function instead of macro (Simon Horman)

PATCH 01 V05: https://lore.kernel.org/netdev/cover.1762414088.git.zhuyikai1@h-partners.com/
* Code format fixes: wrap the code at 80 characters (Jakub Kicinski)
* Use str_up_down instead of ternary expression (Simon Horman)
* Remove needless override of error value (Simon Horman)

PATCH 01 V06: https://lore.kernel.org/netdev/cover.1762581665.git.zhuyikai1@h-partners.com/
* Update dev_err messages (ALOK TIWARI)
* Remove redundant codes "message from vf" in get_mbox_msg_desc (ALOK TIWARI)
* Code spell fix (ALOK TIWARI)
* Modfiy hinic3_uc_sync/unsync to hinic3_filter_mac_sync/unsync (ALOK TIWARI)
* Modify hinic3_mac_filter_sync_hw to return error code (ALOK TIWARI)

PATCH 01 V07: https://lore.kernel.org/netdev/cover.1763555878.git.zhuyikai1@h-partners.com/
* Change port_state_sem to mutex (Jakub Kicinski)
* Use DIM infrastructure to change itr moderation configuration (Jakub Kicinski)
* Remove redundant TX TIMEOUT counter (Jakub Kicinski)
* Use txqueue in tx_timeout instead of searching for timeout queue (Jakub Kicinski)
* Remove redundant initialization to ndev features with more than 1
  vlan depth. (Jakub Kicinski)
* Split patch for one single thing and optimize commit information (Jakub Kicinski)

PATCH 01 V08: https://lore.kernel.org/netdev/cover.1767495881.git.zhuyikai1@h-partners.com/
* Remove netdev notifier interfaces and use ndo_features_check to solve packets
  with multiple vlan tags instead of using vlan_features (Paolo Abeni)

PATCH 01 V09: https://lore.kernel.org/netdev/cover.1767707500.git.zhuyikai1@h-partners.com/
* Add null check in hinic3_mbox_func_aeqe_handler (AI review)
* Add disable_delayed_work_sync in err_uninit_nic_feature (AI review)
* Add vlan_filter's zero initialization (AI review)
* Add disable_work_sync in hinic3_qps_irq_uninit (AI review)
* Adjust hinic3_mac_filter_sync_hw params for readability (AI review)

PATCH 01 V10: https://lore.kernel.org/netdev/cover.1767861236.git.zhuyikai1@h-partners.com/
* Fix wrong filter state in hinic3_mac_filter_sync error path (AI review)
* Fix the case that mgmt_work->msg is not initialized (AI review)
* Use vlan_features_check & vxlan_features_check intead of custom funcion (AI review)
* Fix wrong error path of netif_set_real_num_queues (AI review)

PATCH 01 V11:
* Use kmemdup instead of kmalloc + memcpy (Jakub Kicinski)
* Add tx/rx syncp initialization (AI review)
* Fix wrong error status assessment in hinic3_undo_del_filter_entries (AI review)

Fan Gong (9):
  hinic3: Add PF framework
  hinic3: Add PF management interfaces
  hinic3: Add .ndo_tx_timeout and .ndo_get_stats64
  hinic3: Add .ndo_set_features and .ndo_fix_features
  hinic3: Add .ndo_features_check
  hinic3: Add .ndo_vlan_rx_add/kill_vid and .ndo_validate_addr
  hinic3: Add adaptive IRQ coalescing with DIM
  hinic3: Add mac filter ops
  hinic3: Add HW event handler

 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |   6 +
 .../ethernet/huawei/hinic3/hinic3_filter.c    | 417 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 115 +++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   6 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  24 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  97 +++-
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  90 +++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  23 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  97 +++-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |  53 ++-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 182 +++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  53 ++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  | 313 ++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  53 +++
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  69 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 377 +++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 284 +++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  47 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  60 ++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  27 ++
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  27 ++
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  16 +
 26 files changed, 2444 insertions(+), 37 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_filter.c


base-commit: dbf8fe85a16a33d6b6bd01f2bc606fc017771465
-- 
2.43.0


