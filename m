Return-Path: <netdev+bounces-246852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4320FCF1B46
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 04:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C98B3007943
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 03:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A811531DD96;
	Mon,  5 Jan 2026 03:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1KGt/28C"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EDF229B18;
	Mon,  5 Jan 2026 03:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767582813; cv=none; b=naQtvpKOWxcP2NGkuqCpfS7HYS8760bP4sGcZ8AwgcluJYeQpgCSF+3rFANJz8VPpZdfeTlXsZXF2f3wUr4wHjogFjJdGq5z6TO0G1KjJBHCxs+8R2aqvj5jqhRytEQqLLftcSYaN8bH4WiPvzRdXlXHh4p5mbxgQSMMd3yeuL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767582813; c=relaxed/simple;
	bh=OhXaNpnM88uh60zV9MNuNq/p2Ngch3J4Uz1jYdED/Qo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sihUoz3fcH+mj1YjMOCkRiiGv2aY5dvN5VZwZA9oe/KcyByeCyfWOEa72j8vvFFym956vy/ZJ0RDtDqBkR6ocMy1Frjtzl0K8AIlZubXBXl3CSRYFB+g3sw/gNzy9h6LxheYII4gQN2n7bUgR5vo8aUZS9KOjJDiSCghT0SNC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1KGt/28C; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Avf6Loonv93Or49Wuy8lkOEDMIA95ehEwIKvt2FV9KE=;
	b=1KGt/28CYPhnLS8QdHM7vqp52FcGx1qvWqibzkZcTJeMdvCJHwJAb/pm/ZY5Lxv9CJZtnoLGj
	FsUrouhoKJm3u1bWFuGt8V798lqBC/LX5Zf2LZsW3YIWaFoKPriE/gW/rNtnWfLmMKB4jtesFqK
	GBuJ6hrzOIAjPse2NCmSNlU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dkznF2J87zLm0y;
	Mon,  5 Jan 2026 11:10:09 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id ABDE64057C;
	Mon,  5 Jan 2026 11:13:22 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 5 Jan 2026 11:13:21 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
	<luoyang82@h-partners.com>
Subject: [PATCH net-next v08 0/9] net: hinic3: PF initialization
Date: Mon, 5 Jan 2026 11:13:03 +0800
Message-ID: <cover.1767495881.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
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

Patch 01 V08:
* Remove netdev notifier interfaces and use ndo_features_check to solve packets
  with multiple vlan tags instead of using vlan_features (Paolo Abeni)

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
 .../ethernet/huawei/hinic3/hinic3_filter.c    | 416 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 115 +++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   6 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  24 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  97 +++-
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  90 +++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  23 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  97 +++-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |  53 ++-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 181 +++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  47 +-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  | 311 ++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  53 +++
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  69 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 378 ++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 284 +++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  47 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  60 ++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  16 +
 24 files changed, 2382 insertions(+), 36 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_filter.c


base-commit: dbf8fe85a16a33d6b6bd01f2bc606fc017771465
-- 
2.43.0


