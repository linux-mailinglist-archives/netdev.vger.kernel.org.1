Return-Path: <netdev+bounces-278715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOAmK2pN32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:33:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E91402065
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDF5D300D45D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF88321457;
	Wed, 15 Apr 2026 08:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-109.mail.aliyun.com (out28-109.mail.aliyun.com [115.124.28.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299602F1FC9;
	Wed, 15 Apr 2026 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241825; cv=none; b=ZNud1cNpSRibFa72ayXIX5BAxhAO3GujYinHWFADWwZGcrmIxtVWP+omKhbbaJXV51O+bZ1NjNOwcsswwNvPbxHKMvNyG1KQqv+BvwlBIS2Zp/tCi8Bk/fa0Ak2KNXzPjNnAV/L6d2Ul/tc+aHKOB+HnXKDm9/Pjgn8nabIIHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241825; c=relaxed/simple;
	bh=ZFWNY7o1gS8U/ryZVFGW84W4xPzvZ1rSWcQxubmrT+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTFUYoIqX2Cdrg17awyF4n3owMzBuLMFp+QeMJExB4T4ktRmGYYrkLsUWDu+f7Hb/SVpSPVSkUL/bmaHUbSZ4ckpwl/JOE1MCzjCT6sH3mzxoLUj7p6cedCQbQaeA1Pls62dkOFKvN9BLOQNmFxzt2MaP3xFPEOcoomNu3/6t1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=SUSPECT;BC=0.6694804|-1;BR=01201311R191b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_alarm|0.114224-0.0105365-0.87524;FP=5076060736871470642|2|1|10|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.hCYiVa._1776241812;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.hCYiVa._1776241812 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 15 Apr 2026 16:30:13 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: netdev@vger.kernel.org
Cc: "illusion.wang" <illusion.wang@nebula-matrix.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 net-next 00/11] nbl driver for Nebulamatrix NICs
Date: Wed, 15 Apr 2026 16:29:59 +0800
Message-ID: <20260415033608.2438-1-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415033608.2438-2-illusion.wang@nebula-matrix.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278715-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Queue-Id: 17E91402065
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series represents the first phase. We plan to integrate it in
two phases: the first phase covers mailbox and chip configuration,
while the second phase involves net dev configuration.
Together, they will provide basic PF-based Ethernet port transmission and
reception capabilities.

After that, we will consider other features, such as ethtool support,
flow management, adminq messaging, VF support, debugfs support, etc.

changes v11->v12
Link to v10:https://lore.kernel.org/netdev/20260408093739.56001-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v10->v11
Link to v10:https://lore.kernel.org/netdev/20260401022318.28550-1-illusion.wang@nebula-matrix.com/
1.Issues found by Mohsin
2.AI review issues
changes v9->v10
Link to v9:https://lore.kernel.org/netdev/20260325040048.2313-1-illusion.wang@nebula-matrix.com/
1.Issues found by Jakub
2.AI review issue
changes v8->v9
Link to v8:https://lore.kernel.org/netdev/20260317034533.5600-1-illusion.wang@nebula-matrix.com/
1.Issues found by Jakub
2.AI review issue
Changes v7→v8
Link to v7:https://lore.kernel.org/netdev/20260310120959.22015-1-illusion.wang@nebula-matrix.com/
1.Issues found by Paolo
Changes v6->v7
Link to v6:https://lore.kernel.org/netdev/20260306033451.5196-1-illusion.wang@nebula-matrix.com/
1.Issue found by Jakub
2.AI review issue
Changes v5->v6
Link to V5:https://lore.kernel.org/netdev/20260226073840.3222-1-illusion.wang@nebula-matrix.com/
1.put all standard linux includes files the .c file which needs it & others
--Andrew
2.AI review issue
Changes v4->v5
Link to V4:https://lore.kernel.org/netdev/20260206021608.85381-1-illusion.wang@nebula-matrix.com/
1.change nbl_core to nbl & change ** pointers to *pointers & others
--Andrew
2.AI review issue
Changes v3->v4
Link to v3: https://lore.kernel.org/netdev/20260123011804.31263-1-illusion.wang@nebula-matrix.com
1.cut down to part of a mini driver(mailbox and chip init)
--Jakub Kicinski Simon Horman(some sort of staged approached)
2.modify issues found by ai.
3. Reverse Christmas tree/nbl_err/devm_kfree/remove some macros/
void type to real type/others
--Andrew Lunn
4.change deprecated pci_enable_msix_range to pci_alloc_irq_vectors
5.delete service layer
6.the style of kconfig---Randy Dunlap
7.add to Documentation/networking/device_drivers/ethernet/index.rst
--Simon Horman
Changes v2 →v3
Link to v2: https://lore.kernel.org/netdev/20260109100146.63569-1-illusion.wang@nebula-matrix.com/
1.cut down to a mini driver:
    delete vf support
    use promisc mode to cut down flow management
    drop patch15 in v2
    delete adminq msg
    delete abnormal handling
    delete some unimportant interfaces
2.modify issues found by ai review
Changes v1->v2
Link to v1: https://lore.kernel.org/netdev/20251223035113.31122-1-illusion.wang@nebula-matrix.com/
1.Format Issues and Compilation Issues
- Paolo Abeni
2.add sysfs patch and drop coexisting patch
- Andrew Lunn
3.delete some unimportant ndo operations
4.add machine generated headers patch
5.Modify the issues found in patch1-2 and apply the same fixes to other
patches
6.modify issues found by nipa

illusion.wang (11):
  net/nebula-matrix: add minimum nbl build framework
  net/nebula-matrix: add our driver architecture
  net/nebula-matrix: add chip related definitions
  net/nebula-matrix: channel msg value and msg struct
  net/nebula-matrix: add channel layer
  net/nebula-matrix: add common resource implementation
  net/nebula-matrix: add intr resource implementation
  net/nebula-matrix: add vsi resource implementation
  net/nebula-matrix: add Dispatch layer implementation
  net/nebula-matrix: add common/ctrl dev init/reinit operation
  net/nebula-matrix: add common dev start/stop operation

 .../device_drivers/ethernet/index.rst         |    1 +
 .../ethernet/nebula-matrix/nbl.rst            |   27 +
 MAINTAINERS                                   |   10 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/nebula-matrix/Kconfig    |   34 +
 drivers/net/ethernet/nebula-matrix/Makefile   |    6 +
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   16 +
 .../nbl/nbl_channel/nbl_channel.c             |  843 +++++
 .../nbl/nbl_channel/nbl_channel.h             |  163 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  214 ++
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   33 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   59 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      |  441 +++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |   58 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c |  487 +++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   56 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  797 +++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  493 +++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c | 2901 +++++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h |   11 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  264 ++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   10 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |   68 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  |  246 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |   12 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  118 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  116 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        |   51 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |   11 +
 .../nbl/nbl_include/nbl_def_channel.h         |  362 ++
 .../nbl/nbl_include/nbl_def_common.h          |   80 +
 .../nbl/nbl_include/nbl_def_dev.h             |   16 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |   42 +
 .../nbl/nbl_include/nbl_def_hw.h              |   54 +
 .../nbl/nbl_include/nbl_def_resource.h        |   37 +
 .../nbl/nbl_include/nbl_include.h             |   79 +
 .../nbl/nbl_include/nbl_product_base.h        |   19 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  329 ++
 39 files changed, 8566 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
 create mode 100644 drivers/net/ethernet/nebula-matrix/Kconfig
 create mode 100644 drivers/net/ethernet/nebula-matrix/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

-- 
2.47.3


