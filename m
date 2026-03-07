Return-Path: <netdev+bounces-265084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPiLAE/Jq2m8gwEAu9opvQ
	(envelope-from <netdev+bounces-265084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:44:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B1122A6A4
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB3873034CA1
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F72376BE4;
	Sat,  7 Mar 2026 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vJUCyufT"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E76C31ED91;
	Sat,  7 Mar 2026 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865846; cv=none; b=FOR0e5Mlw10Z9dCei+slogOYGHKV7b9HpP8ChLS8u7EpMF3R+8EUDk+lsPA43jLxuVjRV9DNcnA3C9VmBHKtQbOiq8CW0Lk+QrNWJhVmIH6ozTD+gZWCEJj1hhptRIeD7LsAqhyGqomsmdAZ3OBK0fQig4uasqsE/2kABPZ/BP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865846; c=relaxed/simple;
	bh=cBBBKpPXddZkptUmBUTHDAQfh5sF/25fgz4gD3QHdw0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tC7+AzUKfci0CblLtHrzp+KOoYaGaTzHr+YN1ljcLbJMpXoMdm1mJHwALNzguIcDZUt0LT8o0q/9fUFcjRKHqUaEdJidyeAwgc2fLCKzdD7d4gvylP0H0nAvANSrwTclnTbJXhGXtlgd/DrIFoG5XZchmc81lrQUrbwqdEvMJqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vJUCyufT; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/kxfqd2fvOFXo7ubVlN6B0Vbep0oOaWXCHs4LlmtOgI=;
	b=vJUCyufTQ0aQcG9emMoeK6yCLYpmDifsN3X5ykvaqzcfUeCc4p4nFsLcWwa7oTspJRZpY4Ayf
	6pS/HHzut1t71EMalz2UpaMFMM6V4lwYmb2ClRNV8F2gWh2XAqoJGHjHCcCX6ehpjsPTwJWoQAM
	8QeyJAx+zrTqbhCYd/vI21o=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fSYX432k0z1prL0;
	Sat,  7 Mar 2026 14:39:00 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 9228B2010D;
	Sat,  7 Mar 2026 14:43:55 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 7 Mar 2026 14:43:54 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>
Subject: [PATCH net-next v02 0/9] net: hinic3: PF initialization
Date: Sat, 7 Mar 2026 14:43:39 +0800
Message-ID: <cover.1772697509.git.zhuyikai1@h-partners.com>
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
X-Rspamd-Queue-Id: A8B1122A6A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265084-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,h-partners.com:mid]
X-Rspamd-Action: no action

This is [2/3] part of hinic3 Ethernet driver second submission.
With this patch hinic3 becomes a complete Ethernet driver with
pf and vf.

Add cmdq detailed-response interfaces.
Add dump interfaces for cmdq, aeq, ceq and mailbox.
Add msg_send_lock for message sending concurrency.
Add PF device support and chip_present_flag to check cards.
Add rx vlan offload support.
Add PF FLR wait and timeout handling.
Add 5 ethtool ops for information of driver and link.

Changes:

PATCH 02 V01: https://lore.kernel.org/netdev/cover.1771916043.git.zhuyikai1@h-partners.com/
* Add err handling after cmdq_sync_cmd_direct_resp (AI review)
* Merge "cmdq_sync_cmd_detail_resp" and "cmdq_sync_cmd_direct_resp" into
   "cmdq_sync_cmd_exec" (AI review)
* Add "status == HINIC3_PCIE_LINK_DOWN" in check_hwif_ready_handler to check
  card present (AI review)
* Remove unneed GRO feature judgement and move csum_level to hinic3_rx_csum
  (AI review)
* Add chip_present_flag judgement in hinic3_check_flr_finish_handler to avoid
  meaningless polling (AI review)
* Remove unneed judgement in hinic3_parse_l2nic_res_cap (AI review)
* Add hinic3 prefix to get_cap_from_fw and modify error log (AI review)
* Execute hinic3_set_wq_page_size for both PF and VF (AI review)
* Divide v01 patch into two parts (Jakub Kicinski)

PATCH 02 V02:

Fan Gong (9):
  hinic3: Add command queue detailed-response interfaces
  hinic3: Add Command Queue/Async Event Queue/Complete Event
    Queue/Mailbox dump interfaces
  hinic3: Add chip_present_flag checks to prevent errors when card is
    absent
  hinic3: Add RX VLAN offload support
  hinic3: Add msg_send_lock for message sending concurrecy
  hinic3: Add PF device support and function type validation
  hinic3: Add PF FLR wait and timeout handling
  hinic3: Add PF/VF capability parsing and parameter validation
  hinic3: Add ethtool basic ops

 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 195 +++++++-
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  |  15 +
 .../ethernet/huawei/hinic3/hinic3_common.c    |   6 +-
 .../ethernet/huawei/hinic3/hinic3_common.h    |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   |  65 +++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   |   5 +
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 425 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  47 +-
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |   8 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  69 +++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   2 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  12 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |   9 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  23 +-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   3 +
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  39 +-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |   4 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  16 +-
 .../huawei/hinic3/hinic3_netdev_ops.c         |  16 +-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  83 ++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 110 +++++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   3 +
 .../huawei/hinic3/hinic3_pci_id_tbl.h         |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   |   2 +-
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  15 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |   3 +
 30 files changed, 1152 insertions(+), 30 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c


base-commit: ad3dfa80be765757f612da04318248f6d20e4f71
-- 
2.43.0


