Return-Path: <netdev+bounces-140364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C882C9B62B4
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A374C1F22E51
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FE81E5722;
	Wed, 30 Oct 2024 12:12:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE51EABB5;
	Wed, 30 Oct 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290332; cv=none; b=b/Qz1+PEU6++P+mCJ6gvwHqHGTBqDYnpGKnKXsUzKGk0IGzHEDvTCoWAVZbn9HDA/mN5U2aOfRI6VXYlN9GrG3uw9vycBi027mJQjcPUYO1cLYDW4wwwj5tCA7igujh1A+7pxmii36sBCzjSqwgpOoVhNweMHaU7mv7SX7a1Q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290332; c=relaxed/simple;
	bh=YhUDhebNCajc5OzErByVGwgZLCFXDKCTkMuYZ+By6co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YybNg6ftqcrQU/MXBNJcI5iAmCptdhlEw+7K0Jm5tu32aQ1fxShzM7ghaPChBFn/kXfN0ns3rhz7zWr1HrCR7hzlVm9kE4pF84djdOlnzyxsJP9/B+0DO2TWcCoqSIJpfBsFDPzfALawfU7SdCatqAW0iPOaQ+4wJ7Ao82rzXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xdm7g30M8z6GFvK;
	Wed, 30 Oct 2024 20:06:39 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 65477140D1D;
	Wed, 30 Oct 2024 20:11:30 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 13:11:19 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>, gongfan <gongfan1@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Cai Huoqing
	<cai.huoqing@linux.dev>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Meny Yossefi
	<meny.yossefi@huawei.com>
Subject: [RFC net-next v01 1/1] net: hinic3: Add a driver for Huawei 3rd gen NIC
Date: Wed, 30 Oct 2024 14:25:47 +0200
Message-ID: <ebb0fefe47c29ffed5af21d6bd39d19c2bcddd9c.1730290527.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730290527.git.gur.stavi@huawei.com>
References: <cover.1730290527.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500005.china.huawei.com (7.182.85.13)

From: gongfan <gongfan1@huawei.com>

The patch-set contains driver for Huawei's 3rd generation HiNIC
Ethernet device that will be available in the future.

This is an SRIOV device, designed for data centers.
The driver supports both PFs and VFs.

More detail in device documentation:
Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst

Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Gur Stavi <gur.stavi@huawei.com>
Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
Signed-off-by: gongfan <gongfan1@huawei.com>
---
 .../device_drivers/ethernet/huawei/hinic3.rst |  126 ++
 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/huawei/Kconfig           |    1 +
 drivers/net/ethernet/huawei/Makefile          |    1 +
 drivers/net/ethernet/huawei/hinic3/Kconfig    |   16 +
 drivers/net/ethernet/huawei/hinic3/Makefile   |   27 +
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 1196 +++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  |  184 +++
 .../ethernet/huawei/hinic3/hinic3_common.c    |  105 ++
 .../ethernet/huawei/hinic3/hinic3_common.h    |   57 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |   85 ++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   |  914 +++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   |  152 ++
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 1340 +++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_filter.c    |  405 +++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  475 ++++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  102 ++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  632 ++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   50 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  316 ++++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  736 +++++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  117 ++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  576 +++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  125 ++
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  324 ++++
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |  503 +++++++
 .../net/ethernet/huawei/hinic3/hinic3_lld.h   |   19 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  691 +++++++++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  | 1054 +++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |  158 ++
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  |  358 +++++
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |   78 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  389 +++++
 .../huawei/hinic3/hinic3_netdev_ops.c         |  951 ++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  808 ++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  471 ++++++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  213 +++
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    |  897 +++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |  155 ++
 .../huawei/hinic3/hinic3_pci_id_tbl.h         |   11 +
 .../huawei/hinic3/hinic3_queue_common.c       |   66 +
 .../huawei/hinic3/hinic3_queue_common.h       |   51 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   |  873 +++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |   33 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  735 +++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  174 +++
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  881 +++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  182 +++
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    |  142 ++
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |   96 ++
 50 files changed, 18058 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
new file mode 100644
index 000000000000..ab6fe6aa123b
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
@@ -0,0 +1,126 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================================================
+Linux kernel driver for Huawei Ethernet Device Driver (hinic3) family
+=====================================================================
+
+Overview
+========
+
+The hinic3 is a network interface card(NIC) for Data Center. It supports
+a range of link-speed devices (10GE, 25GE, 100GE, etc.). The hinic3
+devices can have multiple physical forms (LOM NIC, PCIe standard NIC,
+OCP NIC etc.).
+
+The hinic3 driver supports the following features:
+- IPv4/IPv6 TCP/UDP checksum offload
+- TSO (TCP Segmentation Offload), LRO (Large Receive Offload)
+- RSS (Receive Side Scaling)
+- MSI-X interrupt aggregation configuration and interrupt adaptation.
+- SR-IOV (Single Root I/O Virtualization).
+
+Content
+=======
+
+- Supported PCI vendor ID/device IDs
+- Source Code Structure of Hinic3 Driver
+- Management Interface
+
+Supported PCI vendor ID/device IDs
+==================================
+
+19e5:0222 - hinic3 PF/PPF
+19e5:375F - hinic3 VF
+
+Prime Physical Function (PPF) is responsible for the management of the
+whole NIC card. For example, clock synchronization between the NIC and
+the host.
+Any PF may serve as a PPF. The PPF is selected dynamically.
+
+Source Code Structure of Hinic3 Driver
+======================================
+
+========================  ================================================
+hinic3_pci_id_tbl.h       Supported device IDs.
+hinic3_hw_intf.h          Interface between HW and driver.
+hinic3_queue_common.[ch]  Common structures and methods for NIC queues.
+hinic3_common.[ch]        Encapsulation of memory operations in Linux.
+hinic3_csr.h              Register definitions in the BAR.
+hinic3_hwif.[ch]          Interface for BAR.
+hinic3_eqs.[ch]           Interface for AEQs and CEQs.
+hinic3_mbox.[ch]          Interface for mailbox.
+hinic3_mgmt.[ch]          Management interface based on mailbox and AEQ.
+hinic3_wq.[ch]            Work queue data structures and interface.
+hinic3_cmdq.[ch]          Command queue is used to post command to HW.
+hinic3_hwdev.[ch]         HW structures and methods abstractions.
+hinic3_lld.[ch]           Auxiliary driver adaptation layer.
+hinic3_hw_comm.[ch]       Interface for common HW operations.
+hinic3_mgmt_interface.h   Interface between firmware and driver.
+hinic3_hw_cfg.[ch]        Interface for HW configuration.
+hinic3_irq.c              Interrupt request
+hinic3_netdev_ops.c       Operations registered to Linux kernel stack.
+hinic3_nic_dev.h          NIC structures and methods abstractions.
+hinic3_main.c             Main Linux kernel driver.
+hinic3_nic_cfg.[ch]       NIC service configuration.
+hinic3_nic_io.[ch]        Management plane interface for TX and RX.
+hinic3_rss.[ch]           Interface for Receive Side Scaling (RSS).
+hinic3_rx.[ch]            Interface for transmit.
+hinic3_tx.[ch]            Interface for receive.
+hinic3_ethtool.c          Interface for ethtool operations (ops).
+hinic3_filter.c           Interface for mac address.
+========================  ================================================
+
+Management Interface
+====================
+
+Asynchronous Event Queue (AEQ)
+------------------------------
+
+AEQ receives high priority events from the HW over a descriptor queue.
+Every descriptor is a fixed size of 64 bytes. AEQ can receive solicited or
+unsolicited events. Every device, VF or PF, can have up to 4 AEQs.
+Every AEQ is associated to a dedicated IRQ. AEQ can receive multiple types
+of events, but in practice the hinic3 driver ignores all events except for
+2 mailbox related events.
+
+MailBox
+-------
+
+Mailbox is a communication mechanism between the hinic3 driver and the HW.
+Each device has an independent mailbox. Driver can use the mailbox to send
+requests to management. Driver receives mailbox messages, such as responses
+to requests, over the AEQ (using event HINIC3_AEQ_FOR_MBOX). Due to the
+limited size of mailbox data register, mailbox messages are sent
+segment-by-segment.
+
+Every device can use its mailbox to post request to firmware. The mailbox
+can also be used to post requests and responses between the PF and its VFs.
+
+Completion Event Queue (CEQ)
+--------------------------
+
+The implementation of CEQ is the same as AEQ. It receives completion events
+form HW over a fixed size descriptor of 32 bits. Every device can have up
+to 32 CEQs. Every CEQ has a dedicated IRQ. CEQ only receives solicited
+events that are responses to requests from the driver. CEQ can receive
+multiple types of events, but in practice the hinic3 driver ignores all
+events except for HINIC3_CMDQ that represents completion of previously
+posted commands on a cmdq.
+
+Command Queue (cmdq)
+--------------------
+
+Every cmdq has a dedicated work queue on which commands are posted.
+Commands on the work queue are fixed size descriptor of size 64 bytes.
+Completion of a command will be indicated using ctrl bits in the
+descriptor that carried the command. Notification of command completions
+will also be provided via event on CEQ. Every device has 4 command queues
+that are initialized as a set (called cmdqs), each with its own type.
+Hinic3 driver only uses type HINIC3_CMDQ_SYNC.
+
+Work Queues(WQ)
+---------------
+
+Work queues are logical arrays of fixed size WQEs. The array may be spread
+over multiple non-contiguous pages using indirection table.
+Work queues are used by I/O queues and command queues.
diff --git a/MAINTAINERS b/MAINTAINERS
index f39ab140710f..3b03c0a41c5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10486,6 +10486,13 @@ S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/huawei/hinic.rst
 F:	drivers/net/ethernet/huawei/hinic/
 
+HUAWEI 3RD GEN ETHERNET DRIVER
+M:	gongfan <gongfan1@huawei.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
+F:	drivers/net/ethernet/huawei/hinic3/
+
 HUGETLB SUBSYSTEM
 M:	Muchun Song <muchun.song@linux.dev>
 L:	linux-mm@kvack.org
diff --git a/drivers/net/ethernet/huawei/Kconfig b/drivers/net/ethernet/huawei/Kconfig
index c05fce15eb51..7d0feb1da158 100644
--- a/drivers/net/ethernet/huawei/Kconfig
+++ b/drivers/net/ethernet/huawei/Kconfig
@@ -16,5 +16,6 @@ config NET_VENDOR_HUAWEI
 if NET_VENDOR_HUAWEI
 
 source "drivers/net/ethernet/huawei/hinic/Kconfig"
+source "drivers/net/ethernet/huawei/hinic3/Kconfig"
 
 endif # NET_VENDOR_HUAWEI
diff --git a/drivers/net/ethernet/huawei/Makefile b/drivers/net/ethernet/huawei/Makefile
index 2549ad5afe6d..59865b882879 100644
--- a/drivers/net/ethernet/huawei/Makefile
+++ b/drivers/net/ethernet/huawei/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_HINIC) += hinic/
+obj-$(CONFIG_HINIC3) += hinic3/
diff --git a/drivers/net/ethernet/huawei/hinic3/Kconfig b/drivers/net/ethernet/huawei/hinic3/Kconfig
new file mode 100644
index 000000000000..8af0e9138878
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Huawei driver configuration
+#
+
+config HINIC3
+	tristate "Huawei Intelligent Network Interface Card 3rd"
+	# Fields of HW and management structures are little endian and will not
+	# be explicitly converted
+	depends on !CPU_BIG_ENDIAN
+	depends on PCI_MSI && (X86 || ARM64)
+	help
+	  This driver supports HiNIC PCIE Ethernet cards.
+	  To compile this driver as part of the kernel, choose Y here.
+	  If unsure, choose N.
+	  The default is N.
diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
new file mode 100644
index 000000000000..b72dbeb824e2
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+obj-$(CONFIG_HINIC3) += hinic3.o
+
+hinic3-objs := hinic3_hwdev.o \
+	       hinic3_lld.o \
+	       hinic3_common.o \
+	       hinic3_hwif.o \
+	       hinic3_hw_cfg.o \
+	       hinic3_eqs.o \
+	       hinic3_queue_common.o \
+	       hinic3_mbox.o \
+	       hinic3_mgmt.o \
+	       hinic3_hw_comm.o \
+	       hinic3_wq.o \
+	       hinic3_cmdq.o \
+	       hinic3_nic_io.o \
+	       hinic3_nic_cfg.o \
+	       hinic3_tx.o \
+	       hinic3_rx.o \
+	       hinic3_netdev_ops.o \
+	       hinic3_irq.o \
+	       hinic3_rss.o \
+	       hinic3_filter.o \
+	       hinic3_ethtool.o \
+	       hinic3_main.o
\ No newline at end of file
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
new file mode 100644
index 000000000000..cff03a47c462
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
@@ -0,0 +1,1196 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/errno.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+
+#include "hinic3_common.h"
+#include "hinic3_hwif.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_eqs.h"
+#include "hinic3_wq.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_cmdq.h"
+
+#define HINIC3_CMDQ_BUF_SIZE  2048U
+#define CMDQ_WQEBB_SIZE       64
+#define CMDQ_WQE_HEAD_LEN     32
+
+/* milliseconds */
+#define CMDQ_CMD_TIMEOUT               5000
+#define WAIT_CMDQ_ENABLE_TIMEOUT       300
+
+#define CMDQ_CTXT_CURR_WQE_PAGE_PFN_MASK  GENMASK_ULL(51, 0)
+#define CMDQ_CTXT_EQ_ID_MASK              GENMASK_ULL(60, 53)
+#define CMDQ_CTXT_CEQ_ARM_MASK            BIT_ULL(61)
+#define CMDQ_CTXT_CEQ_EN_MASK             BIT_ULL(62)
+#define CMDQ_CTXT_HW_BUSY_BIT_MASK        BIT_ULL(63)
+
+#define CMDQ_CTXT_WQ_BLOCK_PFN_MASK       GENMASK_ULL(51, 0)
+#define CMDQ_CTXT_CI_MASK                 GENMASK_ULL(63, 52)
+#define CMDQ_CTXT_SET(val, member)  \
+	FIELD_PREP(CMDQ_CTXT_##member##_MASK, val)
+
+#define CMDQ_WQE_HDR_BUFDESC_LEN_MASK        GENMASK(7, 0)
+#define CMDQ_WQE_HDR_COMPLETE_FMT_MASK       BIT(15)
+#define CMDQ_WQE_HDR_DATA_FMT_MASK           BIT(22)
+#define CMDQ_WQE_HDR_COMPLETE_REQ_MASK       BIT(23)
+#define CMDQ_WQE_HDR_COMPLETE_SECT_LEN_MASK  GENMASK(28, 27)
+#define CMDQ_WQE_HDR_CTRL_LEN_MASK           GENMASK(30, 29)
+#define CMDQ_WQE_HDR_HW_BUSY_BIT_MASK        BIT(31)
+#define CMDQ_WQE_HDR_SET(val, member)  \
+	FIELD_PREP(CMDQ_WQE_HDR_##member##_MASK, val)
+#define CMDQ_WQE_HDR_GET(val, member)  \
+	FIELD_GET(CMDQ_WQE_HDR_##member##_MASK, val)
+
+#define CMDQ_CTRL_PI_MASK              GENMASK(15, 0)
+#define CMDQ_CTRL_CMD_MASK             GENMASK(23, 16)
+#define CMDQ_CTRL_MOD_MASK             GENMASK(28, 24)
+#define CMDQ_CTRL_HW_BUSY_BIT_MASK     BIT(31)
+#define CMDQ_CTRL_SET(val, member)  \
+	FIELD_PREP(CMDQ_CTRL_##member##_MASK, val)
+#define CMDQ_CTRL_GET(val, member)  \
+	FIELD_GET(CMDQ_CTRL_##member##_MASK, val)
+
+#define WQE_ERRCODE_VAL_MASK              GENMASK(30, 0)
+#define WQE_ERRCODE_GET(val, member)  \
+	FIELD_GET(WQE_ERRCODE_##member##_MASK, val)
+
+#define CMDQ_DB_INFO_HI_PROD_IDX_MASK  GENMASK(7, 0)
+#define CMDQ_DB_INFO_SET(val, member)  \
+	FIELD_PREP(CMDQ_DB_INFO_##member##_MASK, val)
+
+#define CMDQ_DB_HEAD_QUEUE_TYPE_MASK   BIT(23)
+#define CMDQ_DB_HEAD_CMDQ_TYPE_MASK    GENMASK(26, 24)
+#define CMDQ_DB_HEAD_SET(val, member)  \
+	FIELD_PREP(CMDQ_DB_HEAD_##member##_MASK, val)
+
+#define SAVED_DATA_ARM_MASK               BIT(31)
+#define SAVED_DATA_SET(val, member)  \
+	FIELD_PREP(SAVED_DATA_##member##_MASK, val)
+
+#define CEQE_CMDQ_TYPE_MASK               GENMASK(2, 0)
+#define CEQE_CMDQ_GET(val, member)  \
+	FIELD_GET(CEQE_CMDQ_##member##_MASK, val)
+
+#define WQE_HEADER(wqe)           ((struct hinic3_cmdq_header *)(wqe))
+#define WQE_COMPLETED(ctrl_info)  CMDQ_CTRL_GET(ctrl_info, HW_BUSY_BIT)
+
+#define UPPER_8_BITS(data)  (((data) >> 8) & 0xFF)
+#define LOWER_8_BITS(data)  ((data) & 0xFF)
+
+#define CMDQ_DB_PI_OFF(pi)    (((u16)LOWER_8_BITS(pi)) << 3)
+#define CMDQ_DB_ADDR(db, pi)  (((u8 __iomem *)(db)) + CMDQ_DB_PI_OFF(pi))
+
+#define CMDQ_PFN_SHIFT  12
+#define CMDQ_PFN(addr)  ((addr) >> CMDQ_PFN_SHIFT)
+
+/* cmdq work queue's chip logical address table is up to 512B */
+#define CMDQ_WQ_CLA_SIZE  512
+
+#define COMPLETE_LEN  3
+
+/* Completion codes: send, direct sync, force stop */
+#define CMDQ_SEND_CMPT_CODE         10
+#define CMDQ_DIRECT_SYNC_CMPT_CODE  11
+#define CMDQ_FORCE_STOP_CMPT_CODE   12
+
+enum data_format {
+	DATA_SGE,
+	DATA_DIRECT,
+};
+
+enum cmdq_scmd_type {
+	CMDQ_SET_ARM_CMD = 2,
+};
+
+enum ctrl_sect_len {
+	CTRL_SECT_LEN        = 1,
+	CTRL_DIRECT_SECT_LEN = 2,
+};
+
+enum bufdesc_len {
+	BUFDESC_LCMD_LEN = 2,
+	BUFDESC_SCMD_LEN = 3,
+};
+
+enum completion_format {
+	COMPLETE_DIRECT,
+	COMPLETE_SGE,
+};
+
+enum completion_request {
+	CEQ_SET = 1,
+};
+
+enum cmdq_cmd_type {
+	SYNC_CMD_DIRECT_RESP,
+	SYNC_CMD_SGE_RESP,
+};
+
+#define NUM_WQEBBS_FOR_CMDQ_WQE  1
+
+static struct hinic3_cmdq_wqe *cmdq_read_wqe(struct hinic3_wq *wq, u16 *ci)
+{
+	if (hinic3_wq_is_empty(wq))
+		return NULL;
+
+	*ci = wq->cons_idx & wq->idx_mask;
+	return get_q_element(&wq->qpages, wq->cons_idx, NULL);
+}
+
+static void hinic3_dump_cmdq_wqe_head(struct hinic3_hwdev *hwdev,
+				      struct hinic3_cmdq_wqe *wqe)
+{
+	u32 *data = (u32 *)wqe;
+	u32 i;
+
+	for (i = 0; i < (CMDQ_WQE_HEAD_LEN / sizeof(u32)); i += 0x4) {
+		dev_dbg(hwdev->dev, "wqe data: 0x%08x, 0x%08x, 0x%08x, 0x%08x\n",
+			*(data + i), *(data + i + 0x1), *(data + i + 0x2),
+			*(data + i + 0x3));
+	}
+}
+
+struct hinic3_cmd_buf *hinic3_alloc_cmd_buf(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmd_buf *cmd_buf;
+	struct hinic3_cmdqs *cmdqs;
+
+	cmdqs = hwdev->cmdqs;
+
+	cmd_buf = kzalloc(sizeof(*cmd_buf), GFP_ATOMIC);
+	if (!cmd_buf)
+		return NULL;
+
+	cmd_buf->buf = dma_pool_alloc(cmdqs->cmd_buf_pool, GFP_ATOMIC,
+				      &cmd_buf->dma_addr);
+	if (!cmd_buf->buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmdq cmd buf from the pool\n");
+		goto err_alloc_pci_buf;
+	}
+
+	cmd_buf->size = HINIC3_CMDQ_BUF_SIZE;
+	atomic_set(&cmd_buf->ref_cnt, 1);
+
+	return cmd_buf;
+
+err_alloc_pci_buf:
+	kfree(cmd_buf);
+	return NULL;
+}
+
+void hinic3_free_cmd_buf(struct hinic3_hwdev *hwdev, struct hinic3_cmd_buf *cmd_buf)
+{
+	struct hinic3_cmdqs *cmdqs;
+
+	if (!atomic_dec_and_test(&cmd_buf->ref_cnt))
+		return;
+
+	cmdqs = hwdev->cmdqs;
+
+	dma_pool_free(cmdqs->cmd_buf_pool, cmd_buf->buf, cmd_buf->dma_addr);
+	kfree(cmd_buf);
+}
+
+static void cmdq_clear_cmd_buf(struct hinic3_cmdq_cmd_info *cmd_info,
+			       struct hinic3_hwdev *hwdev)
+{
+	if (cmd_info->buf_in)
+		hinic3_free_cmd_buf(hwdev, cmd_info->buf_in);
+
+	if (cmd_info->buf_out)
+		hinic3_free_cmd_buf(hwdev, cmd_info->buf_out);
+
+	cmd_info->buf_in = NULL;
+	cmd_info->buf_out = NULL;
+}
+
+static void cmdq_set_cmd_buf(struct hinic3_cmdq_cmd_info *cmd_info,
+			     struct hinic3_hwdev *hwdev,
+			     struct hinic3_cmd_buf *buf_in,
+			     struct hinic3_cmd_buf *buf_out)
+{
+	cmd_info->buf_in = buf_in;
+	cmd_info->buf_out = buf_out;
+
+	if (buf_in)
+		atomic_inc(&buf_in->ref_cnt);
+
+	if (buf_out)
+		atomic_inc(&buf_out->ref_cnt);
+}
+
+static void clear_wqe_complete_bit(struct hinic3_cmdq *cmdq,
+				   struct hinic3_cmdq_wqe *wqe, u16 ci)
+{
+	struct hinic3_cmdq_header *hdr = WQE_HEADER(wqe);
+	u32 header_info = hdr->header_info;
+	struct hinic3_ctrl *ctrl;
+	enum data_format df;
+
+	df = CMDQ_WQE_HDR_GET(header_info, DATA_FMT);
+	if (df == DATA_SGE)
+		ctrl = &wqe->wqe_lcmd.ctrl;
+	else
+		ctrl = &wqe->inline_wqe.wqe_scmd.ctrl;
+
+	/* clear HW busy bit */
+	ctrl->ctrl_info = 0;
+	cmdq->cmd_infos[ci].cmd_type = HINIC3_CMD_TYPE_NONE;
+
+	wmb(); /* verify wqe is clear */
+
+	hinic3_wq_put_wqebbs(&cmdq->wq, NUM_WQEBBS_FOR_CMDQ_WQE);
+}
+
+static int cmdq_arm_ceq_handler(struct hinic3_cmdq *cmdq,
+				struct hinic3_cmdq_wqe *wqe, u16 ci)
+{
+	struct hinic3_ctrl *ctrl = &wqe->inline_wqe.wqe_scmd.ctrl;
+	u32 ctrl_info = ctrl->ctrl_info;
+
+	if (!WQE_COMPLETED(ctrl_info))
+		return -EBUSY;
+
+	clear_wqe_complete_bit(cmdq, wqe, ci);
+
+	return 0;
+}
+
+static void cmdq_update_cmd_status(struct hinic3_cmdq *cmdq, u16 prod_idx,
+				   struct hinic3_cmdq_wqe *wqe)
+{
+	struct hinic3_cmdq_cmd_info *cmd_info;
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd;
+	u32 status_info;
+
+	wqe_lcmd = &wqe->wqe_lcmd;
+	cmd_info = &cmdq->cmd_infos[prod_idx];
+
+	if (cmd_info->errcode) {
+		status_info = wqe_lcmd->status.status_info;
+		*cmd_info->errcode = WQE_ERRCODE_GET(status_info, VAL);
+	}
+
+	if (cmd_info->direct_resp)
+		*cmd_info->direct_resp = wqe_lcmd->completion.resp.direct.val;
+}
+
+static void cmdq_sync_cmd_handler(struct hinic3_cmdq *cmdq,
+				  struct hinic3_cmdq_wqe *wqe, u16 ci)
+{
+	spin_lock(&cmdq->cmdq_lock);
+
+	cmdq_update_cmd_status(cmdq, ci, wqe);
+
+	if (cmdq->cmd_infos[ci].cmpt_code) {
+		*cmdq->cmd_infos[ci].cmpt_code = CMDQ_DIRECT_SYNC_CMPT_CODE;
+		cmdq->cmd_infos[ci].cmpt_code = NULL;
+	}
+
+	/* Ensure that completion code has been updated before updating done */
+	smp_rmb();
+
+	if (cmdq->cmd_infos[ci].done) {
+		complete(cmdq->cmd_infos[ci].done);
+		cmdq->cmd_infos[ci].done = NULL;
+	}
+
+	spin_unlock(&cmdq->cmdq_lock);
+
+	cmdq_clear_cmd_buf(&cmdq->cmd_infos[ci], cmdq->hwdev);
+	clear_wqe_complete_bit(cmdq, wqe, ci);
+}
+
+void hinic3_cmdq_ceq_handler(struct hinic3_hwdev *hwdev, u32 ceqe_data)
+{
+	enum hinic3_cmdq_type cmdq_type = CEQE_CMDQ_GET(ceqe_data, TYPE);
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd;
+	struct hinic3_cmdq_cmd_info *cmd_info;
+	struct hinic3_cmdq_wqe *wqe;
+	struct hinic3_cmdq *cmdq;
+	u32 ctrl_info;
+	u16 ci;
+
+	cmdq = &cmdqs->cmdq[cmdq_type];
+	while ((wqe = cmdq_read_wqe(&cmdq->wq, &ci)) != NULL) {
+		cmd_info = &cmdq->cmd_infos[ci];
+
+		switch (cmd_info->cmd_type) {
+		case HINIC3_CMD_TYPE_NONE:
+			return;
+		case HINIC3_CMD_TYPE_TIMEOUT:
+			dev_warn(hwdev->dev, "Cmdq timeout, q_id: %u, ci: %u\n", cmdq_type, ci);
+			hinic3_dump_cmdq_wqe_head(hwdev, wqe);
+			fallthrough;
+		case HINIC3_CMD_TYPE_FAKE_TIMEOUT:
+			cmdq_clear_cmd_buf(cmd_info, hwdev);
+			clear_wqe_complete_bit(cmdq, wqe, ci);
+			break;
+		case HINIC3_CMD_TYPE_SET_ARM:
+			/* arm_bit was set until here */
+			if (cmdq_arm_ceq_handler(cmdq, wqe, ci))
+				return;
+			break;
+		default:
+			/* only arm bit is using scmd wqe, the other wqe is lcmd */
+			wqe_lcmd = &wqe->wqe_lcmd;
+			ctrl_info = wqe_lcmd->ctrl.ctrl_info;
+			if (!WQE_COMPLETED(ctrl_info))
+				return;
+
+			dma_rmb();
+			/* For FORCE_STOP cmd_type, we also need to wait for
+			 * the firmware processing to complete to prevent the
+			 * firmware from accessing the released cmd_buf
+			 */
+			if (cmd_info->cmd_type == HINIC3_CMD_TYPE_FORCE_STOP) {
+				cmdq_clear_cmd_buf(cmd_info, hwdev);
+				clear_wqe_complete_bit(cmdq, wqe, ci);
+			} else {
+				cmdq_sync_cmd_handler(cmdq, wqe, ci);
+			}
+
+			break;
+		}
+	}
+}
+
+static int cmdq_params_valid(const struct hinic3_hwdev *hwdev, const struct hinic3_cmd_buf *buf_in)
+{
+	if (buf_in->size > HINIC3_CMDQ_BUF_SIZE) {
+		dev_err(hwdev->dev, "Invalid CMDQ buffer size: 0x%x\n", buf_in->size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int wait_cmdqs_enable(struct hinic3_cmdqs *cmdqs)
+{
+	unsigned long end;
+
+	end = jiffies + msecs_to_jiffies(WAIT_CMDQ_ENABLE_TIMEOUT);
+	do {
+		if (cmdqs->status & HINIC3_CMDQ_ENABLE)
+			return 0;
+	} while (time_before(jiffies, end) && cmdqs->hwdev->chip_present_flag &&
+		 !cmdqs->disable_flag);
+
+	cmdqs->disable_flag = 1;
+
+	return -EBUSY;
+}
+
+static void cmdq_set_completion(struct hinic3_cmdq_completion *complete,
+				struct hinic3_cmd_buf *buf_out)
+{
+	struct hinic3_sge *sge = &complete->resp.sge;
+
+	hinic3_set_sge(sge, buf_out->dma_addr, HINIC3_CMDQ_BUF_SIZE);
+}
+
+static struct hinic3_cmdq_wqe *cmdq_get_wqe(struct hinic3_wq *wq, u16 *pi)
+{
+	if (!hinic3_wq_free_wqebbs(wq))
+		return NULL;
+
+	return hinic3_wq_get_one_wqebb(wq, pi);
+}
+
+static void cmdq_set_lcmd_bufdesc(struct hinic3_cmdq_wqe_lcmd *wqe,
+				  struct hinic3_cmd_buf *buf_in)
+{
+	hinic3_set_sge(&wqe->buf_desc.sge, buf_in->dma_addr, buf_in->size);
+}
+
+static void cmdq_fill_db(struct hinic3_cmdq_db *db,
+			 enum hinic3_cmdq_type cmdq_type, u16 prod_idx)
+{
+	db->db_info = CMDQ_DB_INFO_SET(UPPER_8_BITS(prod_idx), HI_PROD_IDX);
+
+	db->db_head = CMDQ_DB_HEAD_SET(HINIC3_DB_CMDQ_TYPE, QUEUE_TYPE) |
+		      CMDQ_DB_HEAD_SET(cmdq_type, CMDQ_TYPE);
+}
+
+static void cmdq_set_db(struct hinic3_cmdq *cmdq,
+			enum hinic3_cmdq_type cmdq_type, u16 prod_idx)
+{
+	u8 __iomem *db_base = cmdq->hwdev->cmdqs->cmdqs_db_base;
+	struct hinic3_cmdq_db db;
+
+	cmdq_fill_db(&db, cmdq_type, prod_idx);
+
+	writeq(*((u64 *)&db), CMDQ_DB_ADDR(db_base, prod_idx));
+}
+
+static void cmdq_wqe_fill(struct hinic3_cmdq_wqe *hw_wqe,
+			  const struct hinic3_cmdq_wqe *shadow_wqe)
+{
+	const struct hinic3_cmdq_header *src = (struct hinic3_cmdq_header *)shadow_wqe;
+	struct hinic3_cmdq_header *dst = (struct hinic3_cmdq_header *)hw_wqe;
+	size_t len;
+
+	len = sizeof(struct hinic3_cmdq_wqe) - sizeof(struct hinic3_cmdq_header);
+	memcpy(dst + 1, src + 1, len);
+	/* Header should be written last */
+	wmb();
+	WRITE_ONCE(*dst, *src);
+}
+
+static void cmdq_prepare_wqe_ctrl(struct hinic3_cmdq_wqe *wqe, u8 wrapped,
+				  u8 mod, u8 cmd, u16 prod_idx,
+				  enum completion_format complete_format,
+				  enum data_format data_format,
+				  enum bufdesc_len buf_len)
+{
+	struct hinic3_cmdq_header *hdr = WQE_HEADER(wqe);
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd;
+	struct hinic3_cmdq_wqe_scmd *wqe_scmd;
+	u32 saved_data = hdr->saved_data;
+	enum ctrl_sect_len ctrl_len;
+	struct hinic3_ctrl *ctrl;
+
+	if (data_format == DATA_SGE) {
+		wqe_lcmd = &wqe->wqe_lcmd;
+
+		wqe_lcmd->status.status_info = 0;
+		ctrl = &wqe_lcmd->ctrl;
+		ctrl_len = CTRL_SECT_LEN;
+	} else {
+		wqe_scmd = &wqe->inline_wqe.wqe_scmd;
+
+		wqe_scmd->status.status_info = 0;
+		ctrl = &wqe_scmd->ctrl;
+		ctrl_len = CTRL_DIRECT_SECT_LEN;
+	}
+
+	ctrl->ctrl_info =
+		CMDQ_CTRL_SET(prod_idx, PI) |
+		CMDQ_CTRL_SET(cmd, CMD) |
+		CMDQ_CTRL_SET(mod, MOD);
+
+	hdr->header_info =
+		CMDQ_WQE_HDR_SET(buf_len, BUFDESC_LEN) |
+		CMDQ_WQE_HDR_SET(complete_format, COMPLETE_FMT) |
+		CMDQ_WQE_HDR_SET(data_format, DATA_FMT) |
+		CMDQ_WQE_HDR_SET(CEQ_SET, COMPLETE_REQ) |
+		CMDQ_WQE_HDR_SET(COMPLETE_LEN, COMPLETE_SECT_LEN) |
+		CMDQ_WQE_HDR_SET(ctrl_len, CTRL_LEN) |
+		CMDQ_WQE_HDR_SET(wrapped, HW_BUSY_BIT);
+
+	saved_data &= ~SAVED_DATA_ARM_MASK;
+	if (cmd == CMDQ_SET_ARM_CMD && mod == HINIC3_MOD_COMM)
+		saved_data |= SAVED_DATA_SET(1, ARM);
+	hdr->saved_data = saved_data;
+}
+
+static void cmdq_set_lcmd_wqe(struct hinic3_cmdq_wqe *wqe,
+			      enum cmdq_cmd_type cmd_type,
+			      struct hinic3_cmd_buf *buf_in,
+			      struct hinic3_cmd_buf *buf_out, u8 wrapped,
+			      u8 mod, u8 cmd, u16 prod_idx)
+{
+	enum completion_format complete_format = COMPLETE_DIRECT;
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd = &wqe->wqe_lcmd;
+
+	switch (cmd_type) {
+	case SYNC_CMD_DIRECT_RESP:
+		wqe_lcmd->completion.resp.direct.val = 0;
+		break;
+	case SYNC_CMD_SGE_RESP:
+		if (buf_out) {
+			complete_format = COMPLETE_SGE;
+			cmdq_set_completion(&wqe_lcmd->completion,
+					    buf_out);
+		}
+		break;
+	}
+
+	cmdq_prepare_wqe_ctrl(wqe, wrapped, mod, cmd, prod_idx, complete_format,
+			      DATA_SGE, BUFDESC_LCMD_LEN);
+
+	cmdq_set_lcmd_bufdesc(wqe_lcmd, buf_in);
+}
+
+static int hinic3_cmdq_sync_timeout_check(struct hinic3_cmdq *cmdq,
+					  struct hinic3_cmdq_wqe *wqe, u16 pi)
+{
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd;
+	struct hinic3_ctrl *ctrl;
+	u32 ctrl_info;
+
+	wqe_lcmd = &wqe->wqe_lcmd;
+	ctrl = &wqe_lcmd->ctrl;
+	ctrl_info = ctrl->ctrl_info;
+	if (!WQE_COMPLETED(ctrl_info)) {
+		dev_dbg(cmdq->hwdev->dev, "Cmdq sync command check busy bit not set\n");
+		return -EFAULT;
+	}
+
+	cmdq_update_cmd_status(cmdq, pi, wqe);
+
+	return 0;
+}
+
+static void clear_cmd_info(struct hinic3_cmdq_cmd_info *cmd_info,
+			   const struct hinic3_cmdq_cmd_info *saved_cmd_info)
+{
+	if (cmd_info->errcode == saved_cmd_info->errcode)
+		cmd_info->errcode = NULL;
+
+	if (cmd_info->done == saved_cmd_info->done)
+		cmd_info->done = NULL;
+
+	if (cmd_info->direct_resp == saved_cmd_info->direct_resp)
+		cmd_info->direct_resp = NULL;
+}
+
+static int cmdq_ceq_handler_status(struct hinic3_cmdq *cmdq,
+				   struct hinic3_cmdq_cmd_info *cmd_info,
+				   struct hinic3_cmdq_cmd_info *saved_cmd_info,
+				   u64 curr_msg_id, u16 curr_prod_idx,
+				   struct hinic3_cmdq_wqe *curr_wqe,
+				   u32 timeout)
+{
+	ulong end = jiffies + msecs_to_jiffies(timeout);
+	ulong timeo;
+	int err;
+
+	if (cmdq->hwdev->poll) {
+		while (time_before(jiffies, end)) {
+			hinic3_cmdq_ceq_handler(cmdq->hwdev, 0);
+			if (saved_cmd_info->done->done != 0)
+				return 0;
+			usleep_range(9, 10);
+		}
+	} else {
+		timeo = msecs_to_jiffies(timeout);
+		if (wait_for_completion_timeout(saved_cmd_info->done, timeo))
+			return 0;
+	}
+
+	spin_lock_bh(&cmdq->cmdq_lock);
+	if (cmd_info->cmpt_code == saved_cmd_info->cmpt_code)
+		cmd_info->cmpt_code = NULL;
+
+	if (*saved_cmd_info->cmpt_code == CMDQ_DIRECT_SYNC_CMPT_CODE) {
+		dev_dbg(cmdq->hwdev->dev, "Cmdq direct sync command has been completed\n");
+		spin_unlock_bh(&cmdq->cmdq_lock);
+		return 0;
+	}
+
+	if (curr_msg_id == cmd_info->cmdq_msg_id) {
+		err = hinic3_cmdq_sync_timeout_check(cmdq, curr_wqe,
+						     curr_prod_idx);
+		if (err)
+			cmd_info->cmd_type = HINIC3_CMD_TYPE_TIMEOUT;
+		else
+			cmd_info->cmd_type = HINIC3_CMD_TYPE_FAKE_TIMEOUT;
+	} else {
+		err = -ETIMEDOUT;
+		dev_err(cmdq->hwdev->dev, "Cmdq sync command current msg id mismatch cmd_info msg id\n");
+	}
+
+	clear_cmd_info(cmd_info, saved_cmd_info);
+	spin_unlock_bh(&cmdq->cmdq_lock);
+
+	if (!err)
+		return 0;
+
+	hinic3_dump_ceq_info(cmdq->hwdev);
+
+	return -ETIMEDOUT;
+}
+
+static int wait_cmdq_sync_cmd_completion(struct hinic3_cmdq *cmdq,
+					 struct hinic3_cmdq_cmd_info *cmd_info,
+					 struct hinic3_cmdq_cmd_info *saved_cmd_info,
+					 u64 curr_msg_id, u16 curr_prod_idx,
+					 struct hinic3_cmdq_wqe *curr_wqe, u32 timeout)
+{
+	return cmdq_ceq_handler_status(cmdq, cmd_info, saved_cmd_info,
+				       curr_msg_id, curr_prod_idx,
+				       curr_wqe, timeout);
+}
+
+static int cmdq_sync_cmd_direct_resp(struct hinic3_cmdq *cmdq, u8 mod, u8 cmd,
+				     struct hinic3_cmd_buf *buf_in, u64 *out_param)
+{
+	struct hinic3_cmdq_cmd_info *cmd_info, saved_cmd_info;
+	struct hinic3_cmdq_wqe *curr_wqe, wqe;
+	int cmpt_code = CMDQ_SEND_CMPT_CODE;
+	struct hinic3_wq *wq = &cmdq->wq;
+	u16 curr_prod_idx, next_prod_idx;
+	struct completion done;
+	u64 curr_msg_id;
+	int errcode;
+	u8 wrapped;
+	int err;
+
+	spin_lock_bh(&cmdq->cmdq_lock);
+	curr_wqe = cmdq_get_wqe(wq, &curr_prod_idx);
+	if (!curr_wqe) {
+		spin_unlock_bh(&cmdq->cmdq_lock);
+		return -EBUSY;
+	}
+
+	memset(&wqe, 0, sizeof(wqe));
+
+	wrapped = cmdq->wrapped;
+
+	next_prod_idx = curr_prod_idx + NUM_WQEBBS_FOR_CMDQ_WQE;
+	if (next_prod_idx >= wq->q_depth) {
+		cmdq->wrapped = (cmdq->wrapped == 0) ? 1 : 0;
+		next_prod_idx -= (u16)wq->q_depth;
+	}
+
+	cmd_info = &cmdq->cmd_infos[curr_prod_idx];
+
+	init_completion(&done);
+
+	cmd_info->cmd_type = HINIC3_CMD_TYPE_DIRECT_RESP;
+	cmd_info->done = &done;
+	cmd_info->errcode = &errcode;
+	cmd_info->direct_resp = out_param;
+	cmd_info->cmpt_code = &cmpt_code;
+	cmdq_set_cmd_buf(cmd_info, cmdq->hwdev, buf_in, NULL);
+
+	memcpy(&saved_cmd_info, cmd_info, sizeof(*cmd_info));
+
+	cmdq_set_lcmd_wqe(&wqe, SYNC_CMD_DIRECT_RESP, buf_in, NULL,
+			  wrapped, mod, cmd, curr_prod_idx);
+
+	cmdq_wqe_fill(curr_wqe, &wqe);
+
+	(cmd_info->cmdq_msg_id)++;
+	curr_msg_id = cmd_info->cmdq_msg_id;
+
+	cmdq_set_db(cmdq, HINIC3_CMDQ_SYNC, next_prod_idx);
+
+	spin_unlock_bh(&cmdq->cmdq_lock);
+
+	err = wait_cmdq_sync_cmd_completion(cmdq, cmd_info, &saved_cmd_info,
+					    curr_msg_id, curr_prod_idx,
+					    curr_wqe, CMDQ_CMD_TIMEOUT);
+	if (err) {
+		dev_err(cmdq->hwdev->dev, "Cmdq sync command timeout, mod: %u, cmd: %u, prod idx: 0x%x\n",
+			mod, cmd, curr_prod_idx);
+		err = -ETIMEDOUT;
+	}
+
+	if (cmpt_code == CMDQ_FORCE_STOP_CMPT_CODE) {
+		dev_dbg(cmdq->hwdev->dev, "Force stop cmdq cmd, mod: %u, cmd: %u\n", mod, cmd);
+		err = -EAGAIN;
+	}
+
+	smp_rmb(); /* read error code after completion */
+
+	return err ? err : errcode;
+}
+
+static int cmdq_sync_cmd_detail_resp(struct hinic3_cmdq *cmdq, u8 mod, u8 cmd,
+				     struct hinic3_cmd_buf *buf_in,
+				     struct hinic3_cmd_buf *buf_out, u64 *out_param)
+{
+	struct hinic3_cmdq_cmd_info *cmd_info, saved_cmd_info;
+	struct hinic3_cmdq_wqe *curr_wqe, wqe;
+	int cmpt_code = CMDQ_SEND_CMPT_CODE;
+	struct hinic3_wq *wq = &cmdq->wq;
+	u16 curr_prod_idx, next_prod_idx;
+	struct completion done;
+	u64 curr_msg_id;
+	int errcode;
+	u8 wrapped;
+	int err;
+
+	spin_lock_bh(&cmdq->cmdq_lock);
+	curr_wqe = cmdq_get_wqe(wq, &curr_prod_idx);
+	if (!curr_wqe) {
+		spin_unlock_bh(&cmdq->cmdq_lock);
+		return -EBUSY;
+	}
+
+	memset(&wqe, 0, sizeof(wqe));
+	wrapped = cmdq->wrapped;
+
+	next_prod_idx = curr_prod_idx + NUM_WQEBBS_FOR_CMDQ_WQE;
+	if (next_prod_idx >= wq->q_depth) {
+		cmdq->wrapped = (cmdq->wrapped == 0) ? 1 : 0;
+		next_prod_idx -= (u16)wq->q_depth;
+	}
+
+	cmd_info = &cmdq->cmd_infos[curr_prod_idx];
+
+	init_completion(&done);
+	cmd_info->cmd_type = HINIC3_CMD_TYPE_SGE_RESP;
+	cmd_info->done = &done;
+	cmd_info->errcode = &errcode;
+	cmd_info->direct_resp = out_param;
+	cmd_info->cmpt_code = &cmpt_code;
+	cmdq_set_cmd_buf(cmd_info, cmdq->hwdev, buf_in, buf_out);
+
+	memcpy(&saved_cmd_info, cmd_info, sizeof(*cmd_info));
+	cmdq_set_lcmd_wqe(&wqe, SYNC_CMD_SGE_RESP, buf_in, buf_out,
+			  wrapped, mod, cmd, curr_prod_idx);
+	cmdq_wqe_fill(curr_wqe, &wqe);
+	cmd_info->cmdq_msg_id++;
+	curr_msg_id = cmd_info->cmdq_msg_id;
+
+	cmdq_set_db(cmdq, cmdq->cmdq_type, next_prod_idx);
+	spin_unlock_bh(&cmdq->cmdq_lock);
+
+	err = wait_cmdq_sync_cmd_completion(cmdq, cmd_info, &saved_cmd_info,
+					    curr_msg_id, curr_prod_idx,
+					    curr_wqe, CMDQ_CMD_TIMEOUT);
+	if (err) {
+		dev_err(cmdq->hwdev->dev, "Cmdq sync command timeout, mod: %u, cmd: %u, prod idx: 0x%x\n",
+			mod, cmd, curr_prod_idx);
+		err = -ETIMEDOUT;
+	}
+
+	if (cmpt_code == CMDQ_FORCE_STOP_CMPT_CODE) {
+		dev_dbg(cmdq->hwdev->dev, "Force stop cmdq cmd, mod: %u, cmd: %u\n", mod, cmd);
+		err = -EAGAIN;
+	}
+
+	smp_rmb(); /* read error code after completion */
+
+	return err ? err : errcode;
+}
+
+int hinic3_cmd_buf_pair_init(struct hinic3_hwdev *hwdev, struct hinic3_cmd_buf_pair *pair)
+{
+	pair->in = hinic3_alloc_cmd_buf(hwdev);
+	if (!pair->in)
+		return -ENOMEM;
+	pair->out = hinic3_alloc_cmd_buf(hwdev);
+	if (pair->out)
+		return 0;
+	hinic3_free_cmd_buf(hwdev, pair->in);
+	return -ENOMEM;
+}
+
+void hinic3_cmd_buf_pair_uninit(struct hinic3_hwdev *hwdev, struct hinic3_cmd_buf_pair *pair)
+{
+	hinic3_free_cmd_buf(hwdev, pair->in);
+	hinic3_free_cmd_buf(hwdev, pair->out);
+}
+
+int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
+			    struct hinic3_cmd_buf *buf_in, u64 *out_param)
+{
+	struct hinic3_cmdqs *cmdqs;
+	int err;
+
+	err = cmdq_params_valid(hwdev, buf_in);
+	if (err) {
+		dev_err(hwdev->dev, "Invalid CMDQ parameters\n");
+		return err;
+	}
+
+	cmdqs = hwdev->cmdqs;
+	err = wait_cmdqs_enable(cmdqs);
+	if (err) {
+		dev_err(hwdev->dev, "Cmdq is disabled\n");
+		return err;
+	}
+
+	err = cmdq_sync_cmd_direct_resp(&cmdqs->cmdq[HINIC3_CMDQ_SYNC],
+					mod, cmd, buf_in, out_param);
+
+	if (!hwdev->chip_present_flag)
+		return -ETIMEDOUT;
+	else
+		return err;
+}
+
+int hinic3_cmdq_detail_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
+			    struct hinic3_cmd_buf *buf_in,
+			    struct hinic3_cmd_buf *buf_out, u64 *out_param)
+{
+	struct hinic3_cmdqs *cmdqs;
+	int err;
+
+	err = cmdq_params_valid(hwdev, buf_in);
+	if (err)
+		return err;
+
+	cmdqs = hwdev->cmdqs;
+
+	err = wait_cmdqs_enable(cmdqs);
+	if (err) {
+		dev_err(hwdev->dev, "Cmdq is disabled\n");
+		return err;
+	}
+
+	err = cmdq_sync_cmd_detail_resp(&cmdqs->cmdq[HINIC3_CMDQ_SYNC],
+					mod, cmd, buf_in, buf_out, out_param);
+	if (!hwdev->chip_present_flag)
+		return -ETIMEDOUT;
+	else
+		return err;
+}
+
+static void cmdq_init_queue_ctxt(struct hinic3_hwdev *hwdev, u8 cmdq_id,
+				 struct cmdq_ctxt_info *ctxt_info)
+{
+	const struct hinic3_cmdqs *cmdqs;
+	u64 cmdq_first_block_paddr, pfn;
+	const struct hinic3_wq *wq;
+
+	cmdqs = hwdev->cmdqs;
+	wq = &cmdqs->cmdq[cmdq_id].wq;
+	pfn = CMDQ_PFN(hinic3_wq_get_first_wqe_page_addr(wq));
+
+	ctxt_info->curr_wqe_page_pfn =
+		CMDQ_CTXT_SET(1, HW_BUSY_BIT) |
+		CMDQ_CTXT_SET(1, CEQ_EN)	|
+		CMDQ_CTXT_SET(1, CEQ_ARM)	|
+		CMDQ_CTXT_SET(HINIC3_CEQ_ID_CMDQ, EQ_ID) |
+		CMDQ_CTXT_SET(pfn, CURR_WQE_PAGE_PFN);
+
+	if (!WQ_IS_0_LEVEL_CLA(wq)) {
+		cmdq_first_block_paddr = cmdqs->wq_block_paddr;
+		pfn = CMDQ_PFN(cmdq_first_block_paddr);
+	}
+
+	ctxt_info->wq_block_pfn =
+		CMDQ_CTXT_SET(wq->cons_idx, CI) |
+		CMDQ_CTXT_SET(pfn, WQ_BLOCK_PFN);
+}
+
+static int init_cmdq(struct hinic3_cmdq *cmdq, struct hinic3_hwdev *hwdev,
+		     enum hinic3_cmdq_type q_type)
+{
+	int err;
+
+	cmdq->cmdq_type = q_type;
+	cmdq->wrapped = 1;
+	cmdq->hwdev = hwdev;
+
+	spin_lock_init(&cmdq->cmdq_lock);
+
+	cmdq->cmd_infos = kcalloc(cmdq->wq.q_depth, sizeof(*cmdq->cmd_infos),
+				  GFP_KERNEL);
+	if (!cmdq->cmd_infos) {
+		err = -ENOMEM;
+		return err;
+	}
+
+	return 0;
+}
+
+static void free_cmdq(struct hinic3_cmdq *cmdq)
+{
+	kfree(cmdq->cmd_infos);
+}
+
+static int hinic3_set_cmdq_ctxt(struct hinic3_hwdev *hwdev, u8 cmdq_id)
+{
+	struct comm_cmd_cmdq_ctxt cmdq_ctxt;
+	u32 out_size = sizeof(cmdq_ctxt);
+	int err;
+
+	memset(&cmdq_ctxt, 0, sizeof(cmdq_ctxt));
+	cmdq_init_queue_ctxt(hwdev, cmdq_id, &cmdq_ctxt.ctxt);
+	cmdq_ctxt.func_id = hinic3_global_func_id(hwdev);
+	cmdq_ctxt.cmdq_id = cmdq_id;
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM, COMM_MGMT_CMD_SET_CMDQ_CTXT,
+				      &cmdq_ctxt, sizeof(cmdq_ctxt),
+				      &cmdq_ctxt, &out_size, 0);
+	if (err || !out_size || cmdq_ctxt.head.status) {
+		dev_err(hwdev->dev, "Failed to set cmdq ctxt, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, cmdq_ctxt.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_cmdq_ctxts(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	u8 cmdq_type;
+	int err;
+
+	cmdq_type = HINIC3_CMDQ_SYNC;
+	for (; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		err = hinic3_set_cmdq_ctxt(hwdev, cmdq_type);
+		if (err)
+			return err;
+	}
+
+	cmdqs->status |= HINIC3_CMDQ_ENABLE;
+	cmdqs->disable_flag = 0;
+
+	return 0;
+}
+
+static int create_cmdq_wq(struct hinic3_hwdev *hwdev, struct hinic3_cmdqs *cmdqs)
+{
+	u8 type, cmdq_type;
+	int err;
+
+	cmdq_type = HINIC3_CMDQ_SYNC;
+	for (; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		err = hinic3_wq_create(hwdev, &cmdqs->cmdq[cmdq_type].wq,
+				       HINIC3_CMDQ_DEPTH, CMDQ_WQEBB_SIZE);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to create cmdq wq\n");
+			goto destroy_wq;
+		}
+	}
+
+	/* 1-level Chip Logical Address (CLA) must put all cmdq's wq page addr in one wq block */
+	if (!WQ_IS_0_LEVEL_CLA(&cmdqs->cmdq[HINIC3_CMDQ_SYNC].wq)) {
+		if (cmdqs->cmdq[HINIC3_CMDQ_SYNC].wq.qpages.num_pages >
+		    CMDQ_WQ_CLA_SIZE / sizeof(u64)) {
+			err = -EINVAL;
+			dev_err(hwdev->dev, "Cmdq number of wq pages exceeds limit: %lu\n",
+				CMDQ_WQ_CLA_SIZE / sizeof(u64));
+			goto destroy_wq;
+		}
+
+		cmdqs->wq_block_vaddr = dma_alloc_coherent(hwdev->dev,
+							   HINIC3_MIN_PAGE_SIZE,
+							   &cmdqs->wq_block_paddr,
+							   GFP_KERNEL);
+		if (!cmdqs->wq_block_vaddr) {
+			err = -ENOMEM;
+			goto destroy_wq;
+		}
+
+		type = HINIC3_CMDQ_SYNC;
+		for (; type < cmdqs->cmdq_num; type++)
+			memcpy((u8 *)cmdqs->wq_block_vaddr +
+			       CMDQ_WQ_CLA_SIZE * type,
+			       cmdqs->cmdq[type].wq.wq_block_vaddr,
+			       cmdqs->cmdq[type].wq.qpages.num_pages * sizeof(__be64));
+	}
+
+	return 0;
+
+destroy_wq:
+	type = HINIC3_CMDQ_SYNC;
+	for (; type < cmdq_type; type++)
+		hinic3_wq_destroy(hwdev, &cmdqs->cmdq[type].wq);
+
+	return err;
+}
+
+static void destroy_cmdq_wq(struct hinic3_hwdev *hwdev, struct hinic3_cmdqs *cmdqs)
+{
+	u8 cmdq_type;
+
+	if (cmdqs->wq_block_vaddr)
+		dma_free_coherent(hwdev->dev, HINIC3_MIN_PAGE_SIZE,
+				  cmdqs->wq_block_vaddr, cmdqs->wq_block_paddr);
+
+	cmdq_type = HINIC3_CMDQ_SYNC;
+	for (; cmdq_type < cmdqs->cmdq_num; cmdq_type++)
+		hinic3_wq_destroy(hwdev, &cmdqs->cmdq[cmdq_type].wq);
+}
+
+static int init_cmdqs(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs;
+
+	cmdqs = kzalloc(sizeof(*cmdqs), GFP_KERNEL);
+	if (!cmdqs)
+		return -ENOMEM;
+
+	hwdev->cmdqs = cmdqs;
+	cmdqs->hwdev = hwdev;
+	cmdqs->cmdq_num = hwdev->max_cmdq;
+
+	cmdqs->cmd_buf_pool = dma_pool_create("hinic3_cmdq", hwdev->dev,
+					      HINIC3_CMDQ_BUF_SIZE, HINIC3_CMDQ_BUF_SIZE, 0ULL);
+	if (!cmdqs->cmd_buf_pool) {
+		dev_err(hwdev->dev, "Failed to create cmdq buffer pool\n");
+		kfree(cmdqs);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void cmdq_flush_sync_cmd(struct hinic3_cmdq_cmd_info *cmd_info)
+{
+	if (cmd_info->cmd_type != HINIC3_CMD_TYPE_DIRECT_RESP &&
+	    cmd_info->cmd_type != HINIC3_CMD_TYPE_SGE_RESP)
+		return;
+
+	cmd_info->cmd_type = HINIC3_CMD_TYPE_FORCE_STOP;
+
+	if (cmd_info->cmpt_code &&
+	    *cmd_info->cmpt_code == CMDQ_SEND_CMPT_CODE)
+		*cmd_info->cmpt_code = CMDQ_FORCE_STOP_CMPT_CODE;
+
+	if (cmd_info->done) {
+		complete(cmd_info->done);
+		cmd_info->done = NULL;
+		cmd_info->cmpt_code = NULL;
+		cmd_info->direct_resp = NULL;
+		cmd_info->errcode = NULL;
+	}
+}
+
+static void hinic3_cmdq_flush_cmd(struct hinic3_hwdev *hwdev,
+				  struct hinic3_cmdq *cmdq)
+{
+	struct hinic3_cmdq_cmd_info *cmd_info;
+	u16 ci;
+
+	spin_lock_bh(&cmdq->cmdq_lock);
+
+	while (cmdq_read_wqe(&cmdq->wq, &ci)) {
+		hinic3_wq_put_wqebbs(&cmdq->wq, NUM_WQEBBS_FOR_CMDQ_WQE);
+		cmd_info = &cmdq->cmd_infos[ci];
+
+		if (cmd_info->cmd_type == HINIC3_CMD_TYPE_DIRECT_RESP ||
+		    cmd_info->cmd_type == HINIC3_CMD_TYPE_SGE_RESP)
+			cmdq_flush_sync_cmd(cmd_info);
+	}
+
+	spin_unlock_bh(&cmdq->cmdq_lock);
+}
+
+void hinic3_cmdq_flush_sync_cmd(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdq *cmdq;
+	u16 wqe_cnt, wqe_idx, i;
+	struct hinic3_wq *wq;
+
+	cmdq = &hwdev->cmdqs->cmdq[HINIC3_CMDQ_SYNC];
+
+	spin_lock_bh(&cmdq->cmdq_lock);
+
+	wq = &cmdq->wq;
+	wqe_cnt = hinic3_wq_get_used(wq);
+
+	for (i = 0; i < wqe_cnt; i++) {
+		wqe_idx = (wq->cons_idx + i) & wq->idx_mask;
+		cmdq_flush_sync_cmd(cmdq->cmd_infos + wqe_idx);
+	}
+
+	spin_unlock_bh(&cmdq->cmdq_lock);
+}
+
+static void cmdq_reset_all_cmd_buff(struct hinic3_cmdq *cmdq)
+{
+	u16 i;
+
+	for (i = 0; i < cmdq->wq.q_depth; i++)
+		cmdq_clear_cmd_buf(&cmdq->cmd_infos[i], cmdq->hwdev);
+}
+
+int hinic3_reinit_cmdq_ctxts(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	u8 cmdq_type;
+
+	cmdq_type = HINIC3_CMDQ_SYNC;
+	for (; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		hinic3_cmdq_flush_cmd(hwdev, &cmdqs->cmdq[cmdq_type]);
+		cmdq_reset_all_cmd_buff(&cmdqs->cmdq[cmdq_type]);
+		cmdqs->cmdq[cmdq_type].wrapped = 1;
+		hinic3_wq_reset(&cmdqs->cmdq[cmdq_type].wq);
+	}
+
+	return hinic3_set_cmdq_ctxts(hwdev);
+}
+
+int hinic3_cmdqs_init(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs;
+	void __iomem *db_base;
+	u8 type, cmdq_type;
+	int err;
+
+	err = init_cmdqs(hwdev);
+	if (err)
+		return err;
+
+	cmdqs = hwdev->cmdqs;
+	err = create_cmdq_wq(hwdev, cmdqs);
+	if (err)
+		goto err_create_wq;
+
+	err = hinic3_alloc_db_addr(hwdev, &db_base, NULL);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate doorbell address\n");
+		goto err_alloc_db;
+	}
+	cmdqs->cmdqs_db_base = db_base;
+
+	for (cmdq_type = HINIC3_CMDQ_SYNC; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		err = init_cmdq(&cmdqs->cmdq[cmdq_type], hwdev, cmdq_type);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to initialize cmdq type :%d\n", cmdq_type);
+			goto err_init_cmdq;
+		}
+	}
+
+	err = hinic3_set_cmdq_ctxts(hwdev);
+	if (err)
+		goto err_init_cmdq;
+
+	return 0;
+
+err_init_cmdq:
+	for (type = HINIC3_CMDQ_SYNC; type < cmdq_type; type++)
+		free_cmdq(&cmdqs->cmdq[type]);
+
+	hinic3_free_db_addr(hwdev, cmdqs->cmdqs_db_base, NULL);
+
+err_alloc_db:
+	destroy_cmdq_wq(hwdev, cmdqs);
+
+err_create_wq:
+	dma_pool_destroy(cmdqs->cmd_buf_pool);
+	kfree(cmdqs);
+
+	return err;
+}
+
+void hinic3_cmdqs_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	u8 cmdq_type = HINIC3_CMDQ_SYNC;
+
+	cmdqs->status &= ~HINIC3_CMDQ_ENABLE;
+
+	for (; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		hinic3_cmdq_flush_cmd(hwdev, &cmdqs->cmdq[cmdq_type]);
+		cmdq_reset_all_cmd_buff(&cmdqs->cmdq[cmdq_type]);
+		free_cmdq(&cmdqs->cmdq[cmdq_type]);
+	}
+
+	hinic3_free_db_addr(hwdev, cmdqs->cmdqs_db_base, NULL);
+	destroy_cmdq_wq(hwdev, cmdqs);
+
+	dma_pool_destroy(cmdqs->cmd_buf_pool);
+
+	kfree(cmdqs);
+}
+
+bool hinic3_cmdq_idle(struct hinic3_cmdq *cmdq)
+{
+	return hinic3_wq_is_empty(&cmdq->wq);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
new file mode 100644
index 000000000000..6ed19f375224
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_CMDQ_H
+#define HINIC3_CMDQ_H
+
+#include <linux/types.h>
+#include <linux/completion.h>
+#include <linux/spinlock.h>
+
+#include "hinic3_common.h"
+#include "hinic3_wq.h"
+
+struct hinic3_hwdev;
+
+#define HINIC3_CMDQ_DEPTH  4096
+
+struct hinic3_cmd_buf {
+	void       *buf;
+	dma_addr_t dma_addr;
+	u16        size;
+	atomic_t   ref_cnt;
+};
+
+struct hinic3_cmd_buf_pair {
+	struct hinic3_cmd_buf *in;
+	struct hinic3_cmd_buf *out;
+};
+
+enum hinic3_db_src_type {
+	HINIC3_DB_SRC_CMDQ_TYPE,
+	HINIC3_DB_SRC_L2NIC_SQ_TYPE,
+};
+
+enum hinic3_cmdq_db_type {
+	HINIC3_DB_SQ_RQ_TYPE,
+	HINIC3_DB_CMDQ_TYPE,
+};
+
+struct hinic3_cmdq_db {
+	u32 db_head;
+	u32 db_info;
+};
+
+/* hw defined cmdq wqe header */
+struct hinic3_cmdq_header {
+	u32 header_info;
+	u32 saved_data;
+};
+
+struct hinic3_lcmd_bufdesc {
+	struct hinic3_sge sge;
+	u64               rsvd2;
+	u64               rsvd3;
+};
+
+struct hinic3_status {
+	u32 status_info;
+};
+
+struct hinic3_ctrl {
+	u32 ctrl_info;
+};
+
+struct hinic3_direct_resp {
+	u64 val;
+	u64 rsvd;
+};
+
+struct hinic3_cmdq_completion {
+	union {
+		struct hinic3_sge         sge;
+		struct hinic3_direct_resp direct;
+	} resp;
+};
+
+struct hinic3_cmdq_wqe_scmd {
+	struct hinic3_cmdq_header     header;
+	u64                           rsvd3;
+	struct hinic3_status          status;
+	struct hinic3_ctrl            ctrl;
+	struct hinic3_cmdq_completion completion;
+	u32                           rsvd10[6];
+};
+
+struct hinic3_cmdq_wqe_lcmd {
+	struct hinic3_cmdq_header     header;
+	struct hinic3_status          status;
+	struct hinic3_ctrl            ctrl;
+	struct hinic3_cmdq_completion completion;
+	struct hinic3_lcmd_bufdesc    buf_desc;
+};
+
+struct hinic3_cmdq_inline_wqe {
+	struct hinic3_cmdq_wqe_scmd wqe_scmd;
+};
+
+struct hinic3_cmdq_wqe {
+	union {
+		struct hinic3_cmdq_inline_wqe inline_wqe;
+		struct hinic3_cmdq_wqe_lcmd   wqe_lcmd;
+	};
+};
+
+static_assert(sizeof(struct hinic3_cmdq_wqe) == 64);
+
+enum hinic3_cmdq_status {
+	HINIC3_CMDQ_ENABLE = BIT(0),
+};
+
+enum hinic3_cmdq_cmd_type {
+	HINIC3_CMD_TYPE_NONE,
+	HINIC3_CMD_TYPE_SET_ARM,
+	HINIC3_CMD_TYPE_DIRECT_RESP,
+	HINIC3_CMD_TYPE_SGE_RESP,
+	HINIC3_CMD_TYPE_FAKE_TIMEOUT,
+	HINIC3_CMD_TYPE_TIMEOUT,
+	HINIC3_CMD_TYPE_FORCE_STOP,
+};
+
+struct hinic3_cmdq_cmd_info {
+	enum hinic3_cmdq_cmd_type cmd_type;
+
+	struct completion         *done;
+	int                       *errcode;
+	/* completion code */
+	int                       *cmpt_code;
+	u64                       *direct_resp;
+	u64                       cmdq_msg_id;
+
+	struct hinic3_cmd_buf     *buf_in;
+	struct hinic3_cmd_buf     *buf_out;
+};
+
+struct hinic3_cmdq {
+	struct hinic3_wq            wq;
+	enum hinic3_cmdq_type       cmdq_type;
+	u8                          wrapped;
+	/* synchronize command submission with completions via event queue */
+	spinlock_t                  cmdq_lock;
+	struct hinic3_cmdq_cmd_info *cmd_infos;
+	struct hinic3_hwdev         *hwdev;
+};
+
+struct hinic3_cmdqs {
+	struct hinic3_hwdev *hwdev;
+	struct hinic3_cmdq  cmdq[HINIC3_MAX_CMDQ_TYPES];
+
+	struct dma_pool     *cmd_buf_pool;
+	/* doorbell area */
+	u8 __iomem          *cmdqs_db_base;
+
+	/* When command queue uses multiple memory pages (1-level CLA), this
+	 * block will hold aggregated indirection table for all command queues
+	 * of cmdqs. Not used for small cmdq (0-level CLA).
+	 */
+	dma_addr_t          wq_block_paddr;
+	void                *wq_block_vaddr;
+
+	u32                 status;
+	u32                 disable_flag;
+	u8                  cmdq_num;
+};
+
+int hinic3_cmdqs_init(struct hinic3_hwdev *hwdev);
+void hinic3_cmdqs_free(struct hinic3_hwdev *hwdev);
+
+struct hinic3_cmd_buf *hinic3_alloc_cmd_buf(struct hinic3_hwdev *hwdev);
+void hinic3_free_cmd_buf(struct hinic3_hwdev *hwdev, struct hinic3_cmd_buf *cmd_buf);
+void hinic3_cmdq_ceq_handler(struct hinic3_hwdev *hwdev, u32 ceqe_data);
+
+int hinic3_cmd_buf_pair_init(struct hinic3_hwdev *hwdev, struct hinic3_cmd_buf_pair *pair);
+void hinic3_cmd_buf_pair_uninit(struct hinic3_hwdev *hwdev, struct hinic3_cmd_buf_pair *pair);
+int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
+			    struct hinic3_cmd_buf *buf_in, u64 *out_param);
+int hinic3_cmdq_detail_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
+			    struct hinic3_cmd_buf *buf_in,
+			    struct hinic3_cmd_buf *buf_out, u64 *out_param);
+
+void hinic3_cmdq_flush_sync_cmd(struct hinic3_hwdev *hwdev);
+int hinic3_reinit_cmdq_ctxts(struct hinic3_hwdev *hwdev);
+bool hinic3_cmdq_idle(struct hinic3_cmdq *cmdq);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
new file mode 100644
index 000000000000..ae10e908d68e
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/io-mapping.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+
+#include "hinic3_common.h"
+#include "hinic3_queue_common.h"
+
+int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 align,
+				     gfp_t flag,
+				     struct hinic3_dma_addr_align *mem_align)
+{
+	dma_addr_t paddr, align_paddr;
+	void *vaddr, *align_vaddr;
+	u32 real_size = size;
+
+	vaddr = dma_alloc_coherent(dev, real_size, &paddr, flag);
+	if (!vaddr)
+		return -ENOMEM;
+
+	align_paddr = ALIGN(paddr, align);
+	if (align_paddr == paddr) {
+		align_vaddr = vaddr;
+		goto out;
+	}
+
+	dma_free_coherent(dev, real_size, vaddr, paddr);
+
+	/* realloc memory for align */
+	real_size = size + align;
+	vaddr = dma_alloc_coherent(dev, real_size, &paddr, flag);
+	if (!vaddr)
+		return -ENOMEM;
+
+	align_paddr = ALIGN(paddr, align);
+	align_vaddr = vaddr + (align_paddr - paddr);
+
+out:
+	mem_align->real_size = real_size;
+	mem_align->ori_vaddr = vaddr;
+	mem_align->ori_paddr = paddr;
+	mem_align->align_vaddr = align_vaddr;
+	mem_align->align_paddr = align_paddr;
+
+	return 0;
+}
+
+void hinic3_dma_free_coherent_align(struct device *dev,
+				    struct hinic3_dma_addr_align *mem_align)
+{
+	dma_free_coherent(dev, mem_align->real_size,
+			  mem_align->ori_vaddr, mem_align->ori_paddr);
+}
+
+int hinic3_wait_for_timeout(void *priv_data, wait_cpl_handler handler,
+			    u32 wait_total_ms, u32 wait_once_us)
+{
+	/* Take 9/10 * wait_once_us as the minimum sleep time of usleep_range */
+	u32 usleep_min = wait_once_us - wait_once_us / 10;
+	enum hinic3_wait_return ret;
+	unsigned long end;
+
+	end = jiffies + msecs_to_jiffies(wait_total_ms);
+	do {
+		ret = handler(priv_data);
+		if (ret == WAIT_PROCESS_CPL)
+			return 0;
+		else if (ret == WAIT_PROCESS_ERR)
+			return -EIO;
+
+		/* Sleep more than 20ms using msleep is accurate */
+		if (wait_once_us >= 20 * USEC_PER_MSEC)
+			msleep(wait_once_us / USEC_PER_MSEC);
+		else
+			usleep_range(usleep_min, wait_once_us);
+	} while (time_before(jiffies, end));
+
+	ret = handler(priv_data);
+	if (ret == WAIT_PROCESS_CPL)
+		return 0;
+	else if (ret == WAIT_PROCESS_ERR)
+		return -EIO;
+
+	return -ETIMEDOUT;
+}
+
+/* Data provided to/by cmdq is arranged in structs with little endian fields but
+ * every dword (32bits) should be swapped since HW swaps it again when it
+ * copies it from/to host memory. This is a mandatory swap regardless of the
+ * CPU endianness.
+ */
+void cmdq_buf_swab32(void *data, int len)
+{
+	int i, chunk_sz = sizeof(u32);
+	int data_len = len;
+	u32 *mem = data;
+
+	data_len = data_len / chunk_sz;
+
+	for (i = 0; i < data_len; i++)
+		mem[i] = swab32(mem[i]);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
new file mode 100644
index 000000000000..db2cf717b5f2
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_COMMON_H
+#define HINIC3_COMMON_H
+
+#include <linux/types.h>
+
+struct hinic3_hwdev;
+
+#define HINIC3_MIN_PAGE_SIZE  0x1000
+
+struct hinic3_dma_addr_align {
+	u32        real_size;
+
+	void       *ori_vaddr;
+	dma_addr_t ori_paddr;
+
+	void       *align_vaddr;
+	dma_addr_t align_paddr;
+};
+
+enum hinic3_wait_return {
+	WAIT_PROCESS_CPL     = 0,
+	WAIT_PROCESS_WAITING = 1,
+	WAIT_PROCESS_ERR     = 2,
+};
+
+struct hinic3_sge {
+	u32 hi_addr;
+	u32 lo_addr;
+	u32 len;
+	u32 rsvd;
+};
+
+static inline void hinic3_set_sge(struct hinic3_sge *sge, dma_addr_t addr,
+				  int len)
+{
+	sge->hi_addr = upper_32_bits(addr);
+	sge->lo_addr = lower_32_bits(addr);
+	sge->len = len;
+	sge->rsvd = 0;
+}
+
+int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 align,
+				     gfp_t flag,
+				     struct hinic3_dma_addr_align *mem_align);
+void hinic3_dma_free_coherent_align(struct device *dev,
+				    struct hinic3_dma_addr_align *mem_align);
+
+typedef enum hinic3_wait_return (*wait_cpl_handler)(void *priv_data);
+int hinic3_wait_for_timeout(void *priv_data, wait_cpl_handler handler,
+			    u32 wait_total_ms, u32 wait_once_us);
+
+void cmdq_buf_swab32(void *data, int len);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
new file mode 100644
index 000000000000..3ccd16f2038f
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+
+#ifndef HINIC3_CSR_H
+#define HINIC3_CSR_H
+
+#define HINIC3_CFG_REGS_FLAG                  0x40000000
+#define HINIC3_MGMT_REGS_FLAG                 0xC0000000
+#define HINIC3_REGS_FLAG_MAKS                 0x3FFFFFFF
+
+#define HINIC3_VF_CFG_REG_OFFSET              0x2000
+
+/* HW interface registers */
+#define HINIC3_CSR_FUNC_ATTR0_ADDR            (HINIC3_CFG_REGS_FLAG + 0x0)
+#define HINIC3_CSR_FUNC_ATTR1_ADDR            (HINIC3_CFG_REGS_FLAG + 0x4)
+#define HINIC3_CSR_FUNC_ATTR2_ADDR            (HINIC3_CFG_REGS_FLAG + 0x8)
+#define HINIC3_CSR_FUNC_ATTR3_ADDR            (HINIC3_CFG_REGS_FLAG + 0xC)
+#define HINIC3_CSR_FUNC_ATTR4_ADDR            (HINIC3_CFG_REGS_FLAG + 0x10)
+#define HINIC3_CSR_FUNC_ATTR5_ADDR            (HINIC3_CFG_REGS_FLAG + 0x14)
+#define HINIC3_CSR_FUNC_ATTR6_ADDR            (HINIC3_CFG_REGS_FLAG + 0x18)
+
+#define HINIC3_FUNC_CSR_MAILBOX_DATA_OFF      0x80
+#define HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF   (HINIC3_CFG_REGS_FLAG + 0x0100)
+#define HINIC3_FUNC_CSR_MAILBOX_INT_OFF       (HINIC3_CFG_REGS_FLAG + 0x0104)
+#define HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF  (HINIC3_CFG_REGS_FLAG + 0x0108)
+#define HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF  (HINIC3_CFG_REGS_FLAG + 0x010C)
+
+#define HINIC3_HOST_CSR_BASE_ADDR             (HINIC3_MGMT_REGS_FLAG + 0x6000)
+#define HINIC3_PPF_ELECTION_OFFSET            0x0
+#define HINIC3_CSR_PPF_ELECTION_ADDR  \
+	(HINIC3_HOST_CSR_BASE_ADDR + HINIC3_PPF_ELECTION_OFFSET)
+
+#define HINIC3_CSR_DMA_ATTR_TBL_ADDR          (HINIC3_CFG_REGS_FLAG + 0x380)
+#define HINIC3_CSR_DMA_ATTR_INDIR_IDX_ADDR    (HINIC3_CFG_REGS_FLAG + 0x390)
+
+/* MSI-X registers */
+#define HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR       (HINIC3_CFG_REGS_FLAG + 0x58)
+
+#define HINIC3_MSI_CLR_INDIR_RESEND_TIMER_CLR_MASK  BIT(0)
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_SET_MASK       BIT(1)
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_CLR_MASK       BIT(2)
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_SET_MASK      BIT(3)
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_CLR_MASK      BIT(4)
+#define HINIC3_MSI_CLR_INDIR_SIMPLE_INDIR_IDX_MASK  GENMASK(31, 22)
+#define HINIC3_MSI_CLR_INDIR_SET(val, member)  \
+	FIELD_PREP(HINIC3_MSI_CLR_INDIR_##member##_MASK, val)
+
+/* EQ registers */
+#define HINIC3_AEQ_INDIR_IDX_ADDR             (HINIC3_CFG_REGS_FLAG + 0x210)
+#define HINIC3_CEQ_INDIR_IDX_ADDR             (HINIC3_CFG_REGS_FLAG + 0x290)
+
+#define HINIC3_EQ_INDIR_IDX_ADDR(type)  \
+	((type == HINIC3_AEQ) ? HINIC3_AEQ_INDIR_IDX_ADDR : HINIC3_CEQ_INDIR_IDX_ADDR)
+
+#define HINIC3_AEQ_MTT_OFF_BASE_ADDR          (HINIC3_CFG_REGS_FLAG + 0x240)
+#define HINIC3_CEQ_MTT_OFF_BASE_ADDR          (HINIC3_CFG_REGS_FLAG + 0x2C0)
+
+#define HINIC3_CSR_EQ_PAGE_OFF_STRIDE         8
+
+#define HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_AEQ_MTT_OFF_BASE_ADDR + (pg_num) * HINIC3_CSR_EQ_PAGE_OFF_STRIDE)
+
+#define HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_AEQ_MTT_OFF_BASE_ADDR + (pg_num) * HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)
+
+#define HINIC3_CEQ_HI_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_CEQ_MTT_OFF_BASE_ADDR + (pg_num) * HINIC3_CSR_EQ_PAGE_OFF_STRIDE)
+
+#define HINIC3_CEQ_LO_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_CEQ_MTT_OFF_BASE_ADDR + (pg_num) * HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)
+
+#define HINIC3_CSR_AEQ_CTRL_0_ADDR            (HINIC3_CFG_REGS_FLAG + 0x200)
+#define HINIC3_CSR_AEQ_CTRL_1_ADDR            (HINIC3_CFG_REGS_FLAG + 0x204)
+#define HINIC3_CSR_AEQ_CONS_IDX_ADDR          (HINIC3_CFG_REGS_FLAG + 0x208)
+#define HINIC3_CSR_AEQ_PROD_IDX_ADDR          (HINIC3_CFG_REGS_FLAG + 0x20C)
+#define HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR   (HINIC3_CFG_REGS_FLAG + 0x50)
+
+#define HINIC3_CSR_CEQ_CONS_IDX_ADDR          (HINIC3_CFG_REGS_FLAG + 0x288)
+#define HINIC3_CSR_CEQ_PROD_IDX_ADDR          (HINIC3_CFG_REGS_FLAG + 0x28c)
+#define HINIC3_CSR_CEQ_CI_SIMPLE_INDIR_ADDR   (HINIC3_CFG_REGS_FLAG + 0x54)
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
new file mode 100644
index 000000000000..b534a6644ef9
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
@@ -0,0 +1,914 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+
+#include "hinic3_common.h"
+#include "hinic3_queue_common.h"
+#include "hinic3_csr.h"
+#include "hinic3_hwif.h"
+#include "hinic3_hw_intf.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_eqs.h"
+
+#define AEQ_CTRL_0_INTR_IDX_MASK      GENMASK(9, 0)
+#define AEQ_CTRL_0_DMA_ATTR_MASK      GENMASK(17, 12)
+#define AEQ_CTRL_0_PCI_INTF_IDX_MASK  GENMASK(22, 20)
+#define AEQ_CTRL_0_INTR_MODE_MASK     BIT(31)
+#define AEQ_CTRL_0_SET(val, member)  \
+	FIELD_PREP(AEQ_CTRL_0_##member##_MASK, val)
+
+#define AEQ_CTRL_1_LEN_MASK           GENMASK(20, 0)
+#define AEQ_CTRL_1_ELEM_SIZE_MASK     GENMASK(25, 24)
+#define AEQ_CTRL_1_PAGE_SIZE_MASK     GENMASK(31, 28)
+#define AEQ_CTRL_1_SET(val, member)  \
+	FIELD_PREP(AEQ_CTRL_1_##member##_MASK, val)
+
+#define CEQ_CTRL_0_INTR_IDX_MASK      GENMASK(9, 0)
+#define CEQ_CTRL_0_DMA_ATTR_MASK      GENMASK(17, 12)
+#define CEQ_CTRL_0_LIMIT_KICK_MASK    GENMASK(23, 20)
+#define CEQ_CTRL_0_PCI_INTF_IDX_MASK  GENMASK(25, 24)
+#define CEQ_CTRL_0_PAGE_SIZE_MASK     GENMASK(30, 27)
+#define CEQ_CTRL_0_INTR_MODE_MASK     BIT(31)
+#define CEQ_CTRL_0_SET(val, member)   \
+	FIELD_PREP(CEQ_CTRL_0_##member##_MASK, val)
+
+#define CEQ_CTRL_1_LEN_MASK           GENMASK(19, 0)
+#define CEQ_CTRL_1_SET(val, member)  \
+	FIELD_PREP(CEQ_CTRL_1_##member##_MASK, val)
+
+#define EQ_ELEM_DESC_TYPE_MASK        GENMASK(6, 0)
+#define EQ_ELEM_DESC_SRC_MASK         BIT(7)
+#define EQ_ELEM_DESC_SIZE_MASK        GENMASK(15, 8)
+#define EQ_ELEM_DESC_WRAPPED_MASK     BIT(31)
+#define EQ_ELEM_DESC_GET(val, member)  \
+	FIELD_GET(EQ_ELEM_DESC_##member##_MASK, val)
+
+#define EQ_CI_SIMPLE_INDIR_CI_MASK       GENMASK(20, 0)
+#define EQ_CI_SIMPLE_INDIR_ARMED_MASK    BIT(21)
+#define EQ_CI_SIMPLE_INDIR_AEQ_IDX_MASK  GENMASK(31, 30)
+#define EQ_CI_SIMPLE_INDIR_CEQ_IDX_MASK  GENMASK(31, 24)
+#define EQ_CI_SIMPLE_INDIR_SET(val, member)  \
+	FIELD_PREP(EQ_CI_SIMPLE_INDIR_##member##_MASK, val)
+
+#define EQ_CONS_IDX_REG_ADDR(eq)  \
+	(((eq)->type == HINIC3_AEQ) ?  \
+	 HINIC3_CSR_AEQ_CONS_IDX_ADDR : HINIC3_CSR_CEQ_CONS_IDX_ADDR)
+
+#define EQ_CI_SIMPLE_INDIR_REG_ADDR(eq)  \
+	(((eq)->type == HINIC3_AEQ) ?  \
+	 HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR :  \
+	 HINIC3_CSR_CEQ_CI_SIMPLE_INDIR_ADDR)
+
+#define EQ_PROD_IDX_REG_ADDR(eq)  \
+	(((eq)->type == HINIC3_AEQ) ?  \
+	 HINIC3_CSR_AEQ_PROD_IDX_ADDR : HINIC3_CSR_CEQ_PROD_IDX_ADDR)
+
+#define HINIC3_EQ_HI_PHYS_ADDR_REG(type, pg_num)  \
+	((u32)((type == HINIC3_AEQ) ?  \
+	       HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num) :  \
+	       HINIC3_CEQ_HI_PHYS_ADDR_REG(pg_num)))
+
+#define HINIC3_EQ_LO_PHYS_ADDR_REG(type, pg_num)  \
+	((u32)((type == HINIC3_AEQ) ?  \
+	       HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num) :  \
+	       HINIC3_CEQ_LO_PHYS_ADDR_REG(pg_num)))
+
+#define HINIC3_EQ_MAX_PAGES(eq)  \
+	((eq)->type == HINIC3_AEQ ?  \
+	 HINIC3_AEQ_MAX_PAGES : HINIC3_CEQ_MAX_PAGES)
+
+#define HINIC3_TASK_PROCESS_EQE_LIMIT  1024
+#define HINIC3_EQ_UPDATE_CI_STEP       64
+#define HINIC3_EQS_WQ_NAME             "hinic3_eqs"
+
+#define EQ_MSIX_RESEND_TIMER_CLEAR     1
+
+#define EQ_VALID_SHIFT    31
+#define EQ_WRAPPED(eq)    ((u32)(eq)->wrapped << EQ_VALID_SHIFT)
+
+#define EQ_WRAPPED_SHIFT  20
+#define EQ_CONS_IDX(eq)   \
+	((eq)->cons_idx | ((u32)(eq)->wrapped << EQ_WRAPPED_SHIFT))
+
+#define AEQ_DMA_ATTR_DEFAULT  0
+#define CEQ_DMA_ATTR_DEFAULT  0
+#define CEQ_LMT_KICK_DEFAULT  0
+
+#define CEQE_TYPE_MASK   GENMASK(25, 23)
+#define CEQE_TYPE(type)  FIELD_GET(CEQE_TYPE_MASK, type)
+
+#define CEQE_DATA_MASK   GENMASK(25, 0)
+#define CEQE_DATA(data)  ((data) & CEQE_DATA_MASK)
+
+static const struct hinic3_aeq_elem *get_curr_aeq_elem(const struct hinic3_eq *eq)
+{
+	return get_q_element(&eq->qpages, eq->cons_idx, NULL);
+}
+
+static const __be32 *get_curr_ceq_elem(const struct hinic3_eq *eq)
+{
+	return get_q_element(&eq->qpages, eq->cons_idx, NULL);
+}
+
+int hinic3_aeq_register_hw_cb(struct hinic3_hwdev *hwdev, enum hinic3_aeq_type event,
+			      hinic3_aeq_hwe_cb hwe_cb)
+{
+	struct hinic3_aeqs *aeqs;
+	unsigned long *cb_state;
+
+	aeqs = hwdev->aeqs;
+	cb_state = &aeqs->aeq_hw_cb_state[event];
+	aeqs->aeq_hwe_cb[event] = hwe_cb;
+	set_bit(HINIC3_AEQ_HW_CB_REG, cb_state);
+	return 0;
+}
+
+void hinic3_aeq_unregister_hw_cb(struct hinic3_hwdev *hwdev, enum hinic3_aeq_type event)
+{
+	struct hinic3_aeqs *aeqs;
+	unsigned long *cb_state;
+
+	aeqs = hwdev->aeqs;
+	cb_state = &aeqs->aeq_hw_cb_state[event];
+	clear_bit(HINIC3_AEQ_HW_CB_REG, cb_state);
+
+	while (test_bit(HINIC3_AEQ_HW_CB_RUNNING, cb_state))
+		usleep_range(EQ_USLEEP_LOW_BOUND, EQ_USLEEP_HIG_BOUND);
+
+	aeqs->aeq_hwe_cb[event] = NULL;
+}
+
+int hinic3_ceq_register_cb(struct hinic3_hwdev *hwdev, enum hinic3_ceq_event event,
+			   hinic3_ceq_event_cb callback)
+{
+	struct hinic3_ceqs *ceqs;
+
+	ceqs = hwdev->ceqs;
+	ceqs->ceq_cb[event] = callback;
+
+	set_bit(HINIC3_CEQ_CB_REG, &ceqs->ceq_cb_state[event]);
+
+	return 0;
+}
+
+void hinic3_ceq_unregister_cb(struct hinic3_hwdev *hwdev, enum hinic3_ceq_event event)
+{
+	struct hinic3_ceqs *ceqs;
+
+	ceqs = hwdev->ceqs;
+
+	clear_bit(HINIC3_CEQ_CB_REG, &ceqs->ceq_cb_state[event]);
+
+	while (test_bit(HINIC3_CEQ_CB_RUNNING, &ceqs->ceq_cb_state[event]))
+		usleep_range(EQ_USLEEP_LOW_BOUND, EQ_USLEEP_HIG_BOUND);
+
+	ceqs->ceq_cb[event] = NULL;
+}
+
+/* Set consumer index in the hw. */
+static void set_eq_cons_idx(struct hinic3_eq *eq, u32 arm_state)
+{
+	u32 addr = EQ_CI_SIMPLE_INDIR_REG_ADDR(eq);
+	u32 eq_wrap_ci, val;
+
+	eq_wrap_ci = EQ_CONS_IDX(eq);
+
+	/* if use poll mode only eq0 use int_arm mode */
+	if (eq->q_id != 0 && eq->hwdev->poll)
+		val = EQ_CI_SIMPLE_INDIR_SET(HINIC3_EQ_NOT_ARMED, ARMED);
+	else
+		val = EQ_CI_SIMPLE_INDIR_SET(arm_state, ARMED);
+	if (eq->type == HINIC3_AEQ) {
+		val = val |
+			EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
+			EQ_CI_SIMPLE_INDIR_SET(eq->q_id, AEQ_IDX);
+	} else {
+		val = val |
+			EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
+			EQ_CI_SIMPLE_INDIR_SET(eq->q_id, CEQ_IDX);
+	}
+
+	hinic3_hwif_write_reg(eq->hwdev->hwif, addr, val);
+}
+
+static void ceq_event_handler(struct hinic3_ceqs *ceqs, u32 ceqe)
+{
+	enum hinic3_ceq_event event = CEQE_TYPE(ceqe);
+	struct hinic3_hwdev *hwdev = ceqs->hwdev;
+	u32 ceqe_data = CEQE_DATA(ceqe);
+
+	if (event >= HINIC3_MAX_CEQ_EVENTS) {
+		dev_err(hwdev->dev, "Ceq unknown event:%d, ceqe date: 0x%x\n",
+			event, ceqe_data);
+		return;
+	}
+
+	set_bit(HINIC3_CEQ_CB_RUNNING, &ceqs->ceq_cb_state[event]);
+
+	if (ceqs->ceq_cb[event] &&
+	    test_bit(HINIC3_CEQ_CB_REG, &ceqs->ceq_cb_state[event]))
+		ceqs->ceq_cb[event](hwdev, ceqe_data);
+
+	clear_bit(HINIC3_CEQ_CB_RUNNING, &ceqs->ceq_cb_state[event]);
+}
+
+static struct hinic3_aeqs *aeq_to_aeqs(const struct hinic3_eq *eq)
+{
+	return container_of(eq, struct hinic3_aeqs, aeq[eq->q_id]);
+}
+
+static void aeq_elem_handler(struct hinic3_eq *eq, u32 aeqe_desc)
+{
+	struct hinic3_aeqs *aeqs = aeq_to_aeqs(eq);
+	const struct hinic3_aeq_elem *aeqe_pos;
+	u8 data[HINIC3_AEQE_DATA_SIZE], size;
+	enum hinic3_aeq_type event;
+	hinic3_aeq_hwe_cb hwe_cb;
+	unsigned long *cb_state;
+
+	aeqe_pos = get_curr_aeq_elem(eq);
+	event = EQ_ELEM_DESC_GET(aeqe_desc, TYPE);
+
+	if (EQ_ELEM_DESC_GET(aeqe_desc, SRC))
+		return;
+
+	if (event < HINIC3_MAX_AEQ_EVENTS) {
+		memcpy(data, aeqe_pos->aeqe_data, HINIC3_AEQE_DATA_SIZE);
+		cmdq_buf_swab32(data, HINIC3_AEQE_DATA_SIZE);
+		size = EQ_ELEM_DESC_GET(aeqe_desc, SIZE);
+		cb_state = &aeqs->aeq_hw_cb_state[event];
+		set_bit(HINIC3_AEQ_HW_CB_RUNNING, cb_state);
+		hwe_cb = aeqs->aeq_hwe_cb[event];
+		if (hwe_cb && test_bit(HINIC3_AEQ_HW_CB_REG, cb_state))
+			hwe_cb(aeqs->hwdev, data, size);
+		clear_bit(HINIC3_AEQ_HW_CB_RUNNING, cb_state);
+		return;
+	}
+	dev_warn(eq->hwdev->dev, "Unknown aeq hw event %d\n", event);
+}
+
+static int aeq_irq_handler(struct hinic3_eq *eq)
+{
+	const struct hinic3_aeq_elem *aeqe_pos;
+	u32 i, eqe_cnt = 0;
+	u32 aeqe_desc;
+
+	for (i = 0; i < HINIC3_TASK_PROCESS_EQE_LIMIT; i++) {
+		aeqe_pos = get_curr_aeq_elem(eq);
+		aeqe_desc = be32_to_cpu(aeqe_pos->desc);
+		/* HW updates wrapped bit, when it adds eq element event */
+		if (EQ_ELEM_DESC_GET(aeqe_desc, WRAPPED) == eq->wrapped)
+			return 0;
+
+		/* Prevent speculative reads from element */
+		dma_rmb();
+		aeq_elem_handler(eq, aeqe_desc);
+		eq->cons_idx++;
+		if (eq->cons_idx == eq->eq_len) {
+			eq->cons_idx = 0;
+			eq->wrapped = !eq->wrapped;
+		}
+
+		if (++eqe_cnt >= HINIC3_EQ_UPDATE_CI_STEP) {
+			eqe_cnt = 0;
+			set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);
+		}
+	}
+
+	return -EAGAIN;
+}
+
+static int ceq_irq_handler(struct hinic3_eq *eq)
+{
+	struct hinic3_ceqs *ceqs;
+	u32 ceqe, eqe_cnt = 0;
+	__be32 ceqe_raw;
+	u32 i;
+
+	ceqs = container_of(eq, struct hinic3_ceqs, ceq[eq->q_id]);
+	for (i = 0; i < HINIC3_TASK_PROCESS_EQE_LIMIT; i++) {
+		ceqe_raw = *get_curr_ceq_elem(eq);
+		ceqe = be32_to_cpu(ceqe_raw);
+
+		/* HW updates wrapped bit, when it adds eq element event */
+		if (EQ_ELEM_DESC_GET(ceqe, WRAPPED) == eq->wrapped)
+			return 0;
+
+		ceq_event_handler(ceqs, ceqe);
+
+		eq->cons_idx++;
+
+		if (eq->cons_idx == eq->eq_len) {
+			eq->cons_idx = 0;
+			eq->wrapped = !eq->wrapped;
+		}
+
+		if (++eqe_cnt >= HINIC3_EQ_UPDATE_CI_STEP) {
+			eqe_cnt = 0;
+			set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);
+		}
+	}
+
+	return -EAGAIN;
+}
+
+static void reschedule_eq_handler(struct hinic3_eq *eq)
+{
+	if (eq->type == HINIC3_AEQ) {
+		struct hinic3_aeqs *aeqs = aeq_to_aeqs(eq);
+
+		queue_work_on(WORK_CPU_UNBOUND, aeqs->workq, &eq->aeq_work);
+	} else {
+		tasklet_schedule(&eq->ceq_tasklet);
+	}
+}
+
+static int eq_irq_handler(struct hinic3_eq *eq)
+{
+	int err;
+
+	if (eq->type == HINIC3_AEQ)
+		err = aeq_irq_handler(eq);
+	else
+		err = ceq_irq_handler(eq);
+
+	set_eq_cons_idx(eq, err ? HINIC3_EQ_NOT_ARMED :
+			HINIC3_EQ_ARMED);
+
+	return err;
+}
+
+static void eq_irq_work(struct work_struct *work)
+{
+	struct hinic3_eq *eq = container_of(work, struct hinic3_eq, aeq_work);
+	int err;
+
+	err = eq_irq_handler(eq);
+	if (err)
+		reschedule_eq_handler(eq);
+}
+
+static void ceq_tasklet(ulong ceq_data)
+{
+	struct hinic3_eq *eq = (struct hinic3_eq *)ceq_data;
+	int err;
+
+	eq->soft_intr_jif = jiffies;
+
+	err = eq_irq_handler(eq);
+	if (err)
+		reschedule_eq_handler(eq);
+}
+
+static irqreturn_t aeq_interrupt(int irq, void *data)
+{
+	struct hinic3_eq *aeq = data;
+	struct hinic3_aeqs *aeqs = aeq_to_aeqs(aeq);
+	struct hinic3_hwdev *hwdev = aeq->hwdev;
+	struct workqueue_struct *workq;
+
+	/* clear resend timer cnt register */
+	workq = aeqs->workq;
+	hinic3_misx_intr_clear_resend_bit(hwdev, aeq->eq_irq.msix_entry_idx,
+					  EQ_MSIX_RESEND_TIMER_CLEAR);
+
+	queue_work_on(WORK_CPU_UNBOUND, workq, &aeq->aeq_work);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ceq_interrupt(int irq, void *data)
+{
+	struct hinic3_eq *ceq = data;
+
+	ceq->hard_intr_jif = jiffies;
+
+	/* clear resend timer counters */
+	hinic3_misx_intr_clear_resend_bit(ceq->hwdev,
+					  ceq->eq_irq.msix_entry_idx,
+					  EQ_MSIX_RESEND_TIMER_CLEAR);
+
+	tasklet_schedule(&ceq->ceq_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+static int hinic3_set_ceq_ctrl_reg(struct hinic3_hwdev *hwdev, u16 q_id,
+				   u32 ctrl0, u32 ctrl1)
+{
+	struct comm_cmd_ceq_ctrl_reg ceq_ctrl;
+	u32 out_size = sizeof(ceq_ctrl);
+	int err;
+
+	memset(&ceq_ctrl, 0, sizeof(ceq_ctrl));
+	ceq_ctrl.func_id = hinic3_global_func_id(hwdev);
+	ceq_ctrl.q_id = q_id;
+	ceq_ctrl.ctrl0 = ctrl0;
+	ceq_ctrl.ctrl1 = ctrl1;
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM, COMM_MGMT_CMD_SET_CEQ_CTRL_REG,
+				      &ceq_ctrl, sizeof(ceq_ctrl),
+				      &ceq_ctrl, &out_size, 0);
+	if (err || !out_size || ceq_ctrl.head.status) {
+		dev_err(hwdev->dev, "Failed to set ceq %u ctrl reg, err: %d status: 0x%x, out_size: 0x%x\n",
+			q_id, err, ceq_ctrl.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int set_eq_ctrls(struct hinic3_eq *eq)
+{
+	struct hinic3_hwif *hwif = eq->hwdev->hwif;
+	struct irq_info *eq_irq = &eq->eq_irq;
+	struct hinic3_queue_pages *qpages;
+	u8 pci_intf_idx, elem_size;
+	u32 mask, ctrl0, ctrl1;
+	u32 page_size_val;
+	int err;
+
+	qpages = &eq->qpages;
+	page_size_val = ilog2(qpages->page_size / HINIC3_MIN_PAGE_SIZE);
+	pci_intf_idx = hwif->attr.pci_intf_idx;
+
+	if (eq->type == HINIC3_AEQ) {
+		/* set ctrl0 using read-modify-write */
+		mask = AEQ_CTRL_0_INTR_IDX_MASK |
+		       AEQ_CTRL_0_DMA_ATTR_MASK |
+		       AEQ_CTRL_0_PCI_INTF_IDX_MASK |
+		       AEQ_CTRL_0_INTR_MODE_MASK;
+		ctrl0 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_AEQ_CTRL_0_ADDR);
+		ctrl0 = (ctrl0 & ~mask) |
+			AEQ_CTRL_0_SET(eq_irq->msix_entry_idx, INTR_IDX) |
+			AEQ_CTRL_0_SET(AEQ_DMA_ATTR_DEFAULT, DMA_ATTR) |
+			AEQ_CTRL_0_SET(pci_intf_idx, PCI_INTF_IDX) |
+			AEQ_CTRL_0_SET(HINIC3_INTR_MODE_ARMED, INTR_MODE);
+		hinic3_hwif_write_reg(hwif, HINIC3_CSR_AEQ_CTRL_0_ADDR, ctrl0);
+
+		/* HW expects log2(number of 32 byte units). */
+		elem_size = qpages->elem_size_shift - 5;
+		ctrl1 = AEQ_CTRL_1_SET(eq->eq_len, LEN) |
+			AEQ_CTRL_1_SET(elem_size, ELEM_SIZE) |
+			AEQ_CTRL_1_SET(page_size_val, PAGE_SIZE);
+		hinic3_hwif_write_reg(hwif, HINIC3_CSR_AEQ_CTRL_1_ADDR, ctrl1);
+	} else {
+		ctrl0 = CEQ_CTRL_0_SET(eq_irq->msix_entry_idx, INTR_IDX) |
+			CEQ_CTRL_0_SET(CEQ_DMA_ATTR_DEFAULT, DMA_ATTR) |
+			CEQ_CTRL_0_SET(CEQ_LMT_KICK_DEFAULT, LIMIT_KICK) |
+			CEQ_CTRL_0_SET(pci_intf_idx, PCI_INTF_IDX) |
+			CEQ_CTRL_0_SET(page_size_val, PAGE_SIZE) |
+			CEQ_CTRL_0_SET(HINIC3_INTR_MODE_ARMED, INTR_MODE);
+
+		ctrl1 = CEQ_CTRL_1_SET(eq->eq_len, LEN);
+
+		/* set ceq ctrl reg through mgmt cpu */
+		err = hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, ctrl0, ctrl1);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void ceq_elements_init(struct hinic3_eq *eq, u32 init_val)
+{
+	__be32 *ceqe;
+	u32 i;
+
+	for (i = 0; i < eq->eq_len; i++) {
+		ceqe = get_q_element(&eq->qpages, i, NULL);
+		*ceqe = cpu_to_be32(init_val);
+	}
+
+	wmb();    /* Write the init values */
+}
+
+static void aeq_elements_init(struct hinic3_eq *eq, u32 init_val)
+{
+	struct hinic3_aeq_elem *aeqe;
+	u32 i;
+
+	for (i = 0; i < eq->eq_len; i++) {
+		aeqe = get_q_element(&eq->qpages, i, NULL);
+		aeqe->desc = cpu_to_be32(init_val);
+	}
+
+	wmb();    /* Write the init values */
+}
+
+static void eq_elements_init(struct hinic3_eq *eq, u32 init_val)
+{
+	if (eq->type == HINIC3_AEQ)
+		aeq_elements_init(eq, init_val);
+	else
+		ceq_elements_init(eq, init_val);
+}
+
+static int alloc_eq_pages(struct hinic3_eq *eq)
+{
+	struct hinic3_hwif *hwif = eq->hwdev->hwif;
+	struct hinic3_queue_pages *qpages;
+	dma_addr_t page_paddr;
+	u32 reg, init_val;
+	u16 pg_idx;
+	int err;
+
+	qpages = &eq->qpages;
+	err = queue_pages_alloc(eq->hwdev, qpages, HINIC3_MIN_PAGE_SIZE);
+	if (err)
+		return err;
+
+	for (pg_idx = 0; pg_idx < qpages->num_pages; pg_idx++) {
+		page_paddr = qpages->pages[pg_idx].align_paddr;
+		reg = HINIC3_EQ_HI_PHYS_ADDR_REG(eq->type, pg_idx);
+		hinic3_hwif_write_reg(hwif, reg, upper_32_bits(page_paddr));
+		reg = HINIC3_EQ_LO_PHYS_ADDR_REG(eq->type, pg_idx);
+		hinic3_hwif_write_reg(hwif, reg, lower_32_bits(page_paddr));
+	}
+
+	init_val = EQ_WRAPPED(eq);
+	eq_elements_init(eq, init_val);
+	return 0;
+}
+
+static void eq_calc_page_size_and_num(struct hinic3_eq *eq, u32 elem_size)
+{
+	u32 max_pages, min_page_size, page_size, total_size;
+
+	/* No need for complicated arithmetics. All values must be power of 2.
+	 * Multiplications give power of 2 and divisions give power of 2 without
+	 * remainder.
+	 */
+
+	max_pages = HINIC3_EQ_MAX_PAGES(eq);
+	min_page_size = HINIC3_MIN_PAGE_SIZE;
+	total_size = eq->eq_len * elem_size;
+
+	if (total_size <= max_pages * min_page_size)
+		page_size = min_page_size;
+	else
+		page_size = total_size / max_pages;
+
+	queue_pages_init(&eq->qpages, eq->eq_len, page_size, elem_size);
+}
+
+static int request_eq_irq(struct hinic3_eq *eq, struct irq_info *entry)
+{
+	int err;
+
+	if (eq->type == HINIC3_AEQ)
+		INIT_WORK(&eq->aeq_work, eq_irq_work);
+	else
+		tasklet_init(&eq->ceq_tasklet, ceq_tasklet, (ulong)eq);
+
+	if (eq->type == HINIC3_AEQ) {
+		snprintf(eq->irq_name, sizeof(eq->irq_name),
+			 "hinic3_aeq%u@pci:%s", eq->q_id,
+			 pci_name(eq->hwdev->pdev));
+
+		err = request_irq(entry->irq_id, aeq_interrupt, 0UL,
+				  eq->irq_name, eq);
+	} else {
+		snprintf(eq->irq_name, sizeof(eq->irq_name),
+			 "hinic3_ceq%u@pci:%s", eq->q_id,
+			 pci_name(eq->hwdev->pdev));
+		err = request_irq(entry->irq_id, ceq_interrupt, 0UL,
+				  eq->irq_name, eq);
+	}
+
+	return err;
+}
+
+static void reset_eq(struct hinic3_eq *eq)
+{
+	/* clear eq_len to force eqe drop in hardware */
+	if (eq->type == HINIC3_AEQ)
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	else
+		hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, 0, 0);
+
+	hinic3_hwif_write_reg(eq->hwdev->hwif, EQ_PROD_IDX_REG_ADDR(eq), 0);
+}
+
+static int init_eq(struct hinic3_eq *eq, struct hinic3_hwdev *hwdev, u16 q_id,
+		   u32 q_len, enum hinic3_eq_type type, struct irq_info *entry)
+{
+	u32 elem_size;
+	int err;
+
+	eq->hwdev = hwdev;
+	eq->q_id = q_id;
+	eq->type = type;
+	eq->eq_len = q_len;
+
+	/* Indirect access should set q_id first */
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
+			      eq->q_id);
+
+	reset_eq(eq);
+
+	eq->cons_idx = 0;
+	eq->wrapped = 0;
+
+	elem_size = (type == HINIC3_AEQ) ? HINIC3_AEQE_SIZE : HINIC3_CEQE_SIZE;
+	eq_calc_page_size_and_num(eq, elem_size);
+
+	err = alloc_eq_pages(eq);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate pages for eq\n");
+		return err;
+	}
+
+	eq->eq_irq.msix_entry_idx = entry->msix_entry_idx;
+	eq->eq_irq.irq_id = entry->irq_id;
+
+	err = set_eq_ctrls(eq);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set ctrls for eq\n");
+		goto err_init_eq_ctrls;
+	}
+
+	set_eq_cons_idx(eq, HINIC3_EQ_ARMED);
+
+	err = request_eq_irq(eq, entry);
+	if (err) {
+		dev_err(hwdev->dev,
+			"Failed to request irq for the eq, err: %d\n", err);
+		goto err_req_irq;
+	}
+
+	hinic3_set_msix_state(hwdev, entry->msix_entry_idx,
+			      HINIC3_MSIX_DISABLE);
+
+	return 0;
+
+err_init_eq_ctrls:
+err_req_irq:
+	queue_pages_free(hwdev, &eq->qpages);
+	return err;
+}
+
+static void remove_eq(struct hinic3_eq *eq)
+{
+	struct irq_info *entry = &eq->eq_irq;
+
+	hinic3_set_msix_state(eq->hwdev, entry->msix_entry_idx,
+			      HINIC3_MSIX_DISABLE);
+	synchronize_irq(entry->irq_id);
+
+	free_irq(entry->irq_id, eq);
+
+	/* Indirect access should set q_id first */
+	hinic3_hwif_write_reg(eq->hwdev->hwif,
+			      HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
+			      eq->q_id);
+
+	if (eq->type == HINIC3_AEQ) {
+		cancel_work_sync(&eq->aeq_work);
+
+		/* clear eq_len to avoid hw access host memory */
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	} else {
+		tasklet_kill(&eq->ceq_tasklet);
+
+		hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, 0, 0);
+	}
+
+	/* update consumer index to avoid invalid interrupt */
+	eq->cons_idx = hinic3_hwif_read_reg(eq->hwdev->hwif,
+					    EQ_PROD_IDX_REG_ADDR(eq));
+	set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);
+
+	queue_pages_free(eq->hwdev, &eq->qpages);
+}
+
+int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
+		     struct irq_info *msix_entries)
+{
+	struct hinic3_aeqs *aeqs;
+	u16 i, q_id;
+	int err;
+
+	aeqs = kzalloc(sizeof(*aeqs), GFP_KERNEL);
+	if (!aeqs)
+		return -ENOMEM;
+
+	hwdev->aeqs = aeqs;
+	aeqs->hwdev = hwdev;
+	aeqs->num_aeqs = num_aeqs;
+	aeqs->workq = alloc_workqueue(HINIC3_EQS_WQ_NAME, WQ_MEM_RECLAIM,
+				      HINIC3_MAX_AEQS);
+	if (!aeqs->workq) {
+		dev_err(hwdev->dev, "Failed to initialize aeq workqueue\n");
+		err = -ENOMEM;
+		goto err_create_work;
+	}
+
+	for (q_id = 0; q_id < num_aeqs; q_id++) {
+		err = init_eq(&aeqs->aeq[q_id], hwdev, q_id, HINIC3_DEFAULT_AEQ_LEN,
+			      HINIC3_AEQ, &msix_entries[q_id]);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to init aeq %u\n",
+				q_id);
+			goto err_init_aeq;
+		}
+	}
+	for (q_id = 0; q_id < num_aeqs; q_id++)
+		hinic3_set_msix_state(hwdev, msix_entries[q_id].msix_entry_idx,
+				      HINIC3_MSIX_ENABLE);
+
+	return 0;
+
+err_init_aeq:
+	for (i = 0; i < q_id; i++)
+		remove_eq(&aeqs->aeq[i]);
+
+	destroy_workqueue(aeqs->workq);
+
+err_create_work:
+	kfree(aeqs);
+
+	return err;
+}
+
+void hinic3_aeqs_free(struct hinic3_hwdev *hwdev)
+{
+	enum hinic3_aeq_type aeq_event = HINIC3_HW_INTER_INT;
+	struct hinic3_aeqs *aeqs = hwdev->aeqs;
+	u16 q_id;
+
+	for (q_id = 0; q_id < aeqs->num_aeqs; q_id++)
+		remove_eq(&aeqs->aeq[q_id]);
+
+	for (; aeq_event < HINIC3_MAX_AEQ_EVENTS; aeq_event++)
+		hinic3_aeq_unregister_hw_cb(hwdev, aeq_event);
+
+	destroy_workqueue(aeqs->workq);
+
+	kfree(aeqs);
+}
+
+void hinic3_get_aeq_irqs(struct hinic3_hwdev *hwdev, struct irq_info *irqs,
+			 u16 *num_irqs)
+{
+	struct hinic3_aeqs *aeqs = hwdev->aeqs;
+	u16 q_id;
+
+	for (q_id = 0; q_id < aeqs->num_aeqs; q_id++) {
+		irqs[q_id].irq_id = aeqs->aeq[q_id].eq_irq.irq_id;
+		irqs[q_id].msix_entry_idx =
+			aeqs->aeq[q_id].eq_irq.msix_entry_idx;
+	}
+
+	*num_irqs = aeqs->num_aeqs;
+}
+
+void hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev)
+{
+	const struct hinic3_aeq_elem *aeqe_pos;
+	u32 addr, ci, pi, ctrl0, idx;
+	struct hinic3_eq *eq;
+	int q_id;
+
+	for (q_id = 0; q_id < hwdev->aeqs->num_aeqs; q_id++) {
+		eq = &hwdev->aeqs->aeq[q_id];
+		/* Indirect access should set q_id first */
+		hinic3_hwif_write_reg(eq->hwdev->hwif, HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
+				      eq->q_id);
+
+		addr = HINIC3_CSR_AEQ_CTRL_0_ADDR;
+
+		ctrl0 = hinic3_hwif_read_reg(hwdev->hwif, addr);
+
+		idx = hinic3_hwif_read_reg(hwdev->hwif, HINIC3_EQ_INDIR_IDX_ADDR(eq->type));
+
+		addr = EQ_CONS_IDX_REG_ADDR(eq);
+		ci = hinic3_hwif_read_reg(hwdev->hwif, addr);
+		addr = EQ_PROD_IDX_REG_ADDR(eq);
+		pi = hinic3_hwif_read_reg(hwdev->hwif, addr);
+		aeqe_pos = get_curr_aeq_elem(eq);
+		dev_err(hwdev->dev,
+			"Aeq id: %d, idx: %u, ctrl0: 0x%08x, ci: 0x%08x, pi: 0x%x, work_state: 0x%x, wrap: %u, desc: 0x%x swci:0x%x\n",
+			q_id, idx, ctrl0, ci, pi, work_busy(&eq->aeq_work),
+			eq->wrapped, be32_to_cpu(aeqe_pos->desc),  eq->cons_idx);
+	}
+}
+
+int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
+		     struct irq_info *msix_entries)
+{
+	struct hinic3_ceqs *ceqs;
+	u16 i, q_id;
+	int err;
+
+	ceqs = kzalloc(sizeof(*ceqs), GFP_KERNEL);
+	if (!ceqs)
+		return -ENOMEM;
+
+	hwdev->ceqs = ceqs;
+
+	ceqs->hwdev = hwdev;
+	ceqs->num_ceqs = num_ceqs;
+
+	for (q_id = 0; q_id < num_ceqs; q_id++) {
+		err = init_eq(&ceqs->ceq[q_id], hwdev, q_id, HINIC3_DEFAULT_CEQ_LEN,
+			      HINIC3_CEQ, &msix_entries[q_id]);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to init ceq %u\n",
+				q_id);
+			goto err_init_ceq;
+		}
+	}
+	for (q_id = 0; q_id < num_ceqs; q_id++)
+		hinic3_set_msix_state(hwdev, msix_entries[q_id].msix_entry_idx,
+				      HINIC3_MSIX_ENABLE);
+
+	for (i = 0; i < HINIC3_MAX_CEQ_EVENTS; i++)
+		ceqs->ceq_cb_state[i] = 0;
+
+	return 0;
+
+err_init_ceq:
+	for (i = 0; i < q_id; i++)
+		remove_eq(&ceqs->ceq[i]);
+
+	kfree(ceqs);
+
+	return err;
+}
+
+void hinic3_ceqs_free(struct hinic3_hwdev *hwdev)
+{
+	enum hinic3_ceq_event ceq_event = HINIC3_CMDQ;
+	struct hinic3_ceqs *ceqs = hwdev->ceqs;
+	u16 q_id;
+
+	for (q_id = 0; q_id < ceqs->num_ceqs; q_id++)
+		remove_eq(&ceqs->ceq[q_id]);
+
+	for (; ceq_event < HINIC3_MAX_CEQ_EVENTS; ceq_event++)
+		hinic3_ceq_unregister_cb(hwdev, ceq_event);
+
+	kfree(ceqs);
+}
+
+void hinic3_get_ceq_irqs(struct hinic3_hwdev *hwdev, struct irq_info *irqs,
+			 u16 *num_irqs)
+{
+	struct hinic3_ceqs *ceqs = hwdev->ceqs;
+	u16 q_id;
+
+	for (q_id = 0; q_id < ceqs->num_ceqs; q_id++) {
+		irqs[q_id].irq_id = ceqs->ceq[q_id].eq_irq.irq_id;
+		irqs[q_id].msix_entry_idx =
+			ceqs->ceq[q_id].eq_irq.msix_entry_idx;
+	}
+
+	*num_irqs = ceqs->num_ceqs;
+}
+
+void hinic3_dump_ceq_info(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_eq *eq;
+	u32 addr, ci, pi;
+	int q_id;
+
+	for (q_id = 0; q_id < hwdev->ceqs->num_ceqs; q_id++) {
+		eq = &hwdev->ceqs->ceq[q_id];
+		/* Indirect access should set q_id first */
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
+				      eq->q_id);
+
+		addr = EQ_CONS_IDX_REG_ADDR(eq);
+		ci = hinic3_hwif_read_reg(hwdev->hwif, addr);
+		addr = EQ_PROD_IDX_REG_ADDR(eq);
+		pi = hinic3_hwif_read_reg(hwdev->hwif, addr);
+		dev_err(hwdev->dev,
+			"Ceq id: %d, ci: 0x%08x, sw_ci: 0x%08x, pi: 0x%x, tasklet_state: 0x%lx, wrap: %u, ceqe: 0x%x\n",
+			q_id, ci, eq->cons_idx, pi,
+			eq->ceq_tasklet.state,
+			eq->wrapped, be32_to_cpu(*get_curr_ceq_elem(eq)));
+
+		dev_err(hwdev->dev, "Ceq last response hard interrupt time: %u\n",
+			jiffies_to_msecs(jiffies - eq->hard_intr_jif));
+		dev_err(hwdev->dev, "Ceq last response soft interrupt time: %u\n",
+			jiffies_to_msecs(jiffies - eq->soft_intr_jif));
+	}
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
new file mode 100644
index 000000000000..cd0cf08d0f0e
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_EQS_H
+#define HINIC3_EQS_H
+
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+
+#include "hinic3_queue_common.h"
+#include "hinic3_hw_cfg.h"
+
+struct hinic3_hwdev;
+
+#define HINIC3_MAX_AEQS              4
+#define HINIC3_MAX_CEQS              32
+
+#define HINIC3_AEQ_MAX_PAGES         4
+#define HINIC3_CEQ_MAX_PAGES         8
+
+#define HINIC3_AEQE_SIZE             64
+#define HINIC3_CEQE_SIZE             4
+
+#define HINIC3_AEQE_DESC_SIZE        4
+#define HINIC3_AEQE_DATA_SIZE        (HINIC3_AEQE_SIZE - HINIC3_AEQE_DESC_SIZE)
+
+#define HINIC3_DEFAULT_AEQ_LEN       0x10000
+#define HINIC3_DEFAULT_CEQ_LEN       0x10000
+
+#define HINIC3_CEQ_ID_CMDQ           0
+#define EQ_IRQ_NAME_LEN              64
+
+#define EQ_USLEEP_LOW_BOUND          900
+#define EQ_USLEEP_HIG_BOUND          1000
+
+enum hinic3_eq_type {
+	HINIC3_AEQ = 0,
+	HINIC3_CEQ = 1,
+};
+
+enum hinic3_eq_intr_mode {
+	HINIC3_INTR_MODE_ARMED  = 0,
+	HINIC3_INTR_MODE_ALWAYS = 1,
+};
+
+enum hinic3_eq_ci_arm_state {
+	HINIC3_EQ_NOT_ARMED = 0,
+	HINIC3_EQ_ARMED     = 1,
+};
+
+struct hinic3_eq {
+	struct hinic3_hwdev       *hwdev;
+	struct hinic3_queue_pages qpages;
+	u16                       q_id;
+	enum hinic3_eq_type       type;
+	u32                       eq_len;
+
+	u32                       cons_idx;
+	u8                        wrapped;
+
+	struct irq_info           eq_irq;
+	char                      irq_name[EQ_IRQ_NAME_LEN];
+
+	struct work_struct        aeq_work;
+	struct tasklet_struct     ceq_tasklet;
+
+	u64                       hard_intr_jif;
+	u64                       soft_intr_jif;
+};
+
+struct hinic3_aeq_elem {
+	u8     aeqe_data[HINIC3_AEQE_DATA_SIZE];
+	__be32 desc;
+};
+
+enum hinic3_aeq_cb_state {
+	HINIC3_AEQ_HW_CB_REG     = 0,
+	HINIC3_AEQ_HW_CB_RUNNING = 1,
+};
+
+enum hinic3_aeq_type {
+	HINIC3_HW_INTER_INT   = 0,
+	HINIC3_MBX_FROM_FUNC  = 1,
+	HINIC3_MSG_FROM_FW    = 2,
+	HINIC3_API_RSP        = 3,
+	HINIC3_API_CHAIN_STS  = 4,
+	HINIC3_MBX_SEND_RSLT  = 5,
+	HINIC3_MAX_AEQ_EVENTS = 6,
+};
+
+typedef void (*hinic3_aeq_hwe_cb)(struct hinic3_hwdev *hwdev, u8 *data, u8 size);
+
+struct hinic3_aeqs {
+	struct hinic3_hwdev     *hwdev;
+
+	hinic3_aeq_hwe_cb       aeq_hwe_cb[HINIC3_MAX_AEQ_EVENTS];
+	unsigned long           aeq_hw_cb_state[HINIC3_MAX_AEQ_EVENTS];
+
+	struct hinic3_eq        aeq[HINIC3_MAX_AEQS];
+	u16                     num_aeqs;
+	struct workqueue_struct *workq;
+};
+
+enum hinic3_ceq_cb_state {
+	HINIC3_CEQ_CB_REG     = 0,
+	HINIC3_CEQ_CB_RUNNING = 1,
+};
+
+enum hinic3_ceq_event {
+	HINIC3_NON_L2NIC_SCQ      = 0,
+	HINIC3_NON_L2NIC_ECQ      = 1,
+	HINIC3_NON_L2NIC_NO_CQ_EQ = 2,
+	HINIC3_CMDQ               = 3,
+	HINIC3_L2NIC_SQ           = 4,
+	HINIC3_L2NIC_RQ           = 5,
+	HINIC3_MAX_CEQ_EVENTS     = 6,
+};
+
+typedef void (*hinic3_ceq_event_cb)(struct hinic3_hwdev *hwdev, u32 ceqe_data);
+
+struct hinic3_ceqs {
+	struct hinic3_hwdev *hwdev;
+
+	hinic3_ceq_event_cb ceq_cb[HINIC3_MAX_CEQ_EVENTS];
+	unsigned long       ceq_cb_state[HINIC3_MAX_CEQ_EVENTS];
+
+	struct hinic3_eq    ceq[HINIC3_MAX_CEQS];
+	u16                 num_ceqs;
+};
+
+int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
+		     struct irq_info *msix_entries);
+void hinic3_aeqs_free(struct hinic3_hwdev *hwdev);
+void hinic3_get_aeq_irqs(struct hinic3_hwdev *hwdev, struct irq_info *irqs,
+			 u16 *num_irqs);
+int hinic3_aeq_register_hw_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_aeq_type event, hinic3_aeq_hwe_cb hwe_cb);
+void hinic3_aeq_unregister_hw_cb(struct hinic3_hwdev *hwdev, enum hinic3_aeq_type event);
+void hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev);
+
+int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
+		     struct irq_info *msix_entries);
+void hinic3_ceqs_free(struct hinic3_hwdev *hwdev);
+void hinic3_get_ceq_irqs(struct hinic3_hwdev *hwdev, struct irq_info *irqs,
+			 u16 *num_irqs);
+void hinic3_dump_ceq_info(struct hinic3_hwdev *hwdev);
+int hinic3_ceq_register_cb(struct hinic3_hwdev *hwdev, enum hinic3_ceq_event event,
+			   hinic3_ceq_event_cb callback);
+void hinic3_ceq_unregister_cb(struct hinic3_hwdev *hwdev, enum hinic3_ceq_event event);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
new file mode 100644
index 000000000000..6c9ab7a01cdd
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -0,0 +1,1340 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+
+#include "hinic3_lld.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_rss.h"
+
+#define HINIC3_MGMT_VERSION_MAX_LEN     32
+#define COALESCE_ALL_QUEUE              0xFFFF
+/* Coalesce time properties in milliseconds */
+#define COALESCE_PENDING_LIMIT_UNIT     8
+#define COALESCE_TIMER_CFG_UNIT         5
+#define COALESCE_MAX_PENDING_LIMIT      (255 * COALESCE_PENDING_LIMIT_UNIT)
+#define COALESCE_MAX_TIMER_CFG          (255 * COALESCE_TIMER_CFG_UNIT)
+
+static void hinic3_get_drvinfo(struct net_device *netdev,
+			       struct ethtool_drvinfo *info)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u8 mgmt_ver[HINIC3_MGMT_VERSION_MAX_LEN];
+	struct pci_dev *pdev = nic_dev->pdev;
+	int err;
+
+	strscpy(info->driver, HINIC3_NIC_DRV_NAME, sizeof(info->driver));
+	strscpy(info->bus_info, pci_name(pdev), sizeof(info->bus_info));
+
+	err = hinic3_get_mgmt_version(nic_dev->hwdev, mgmt_ver,
+				      HINIC3_MGMT_VERSION_MAX_LEN);
+	if (err) {
+		netdev_err(netdev, "Failed to get fw version\n");
+		return;
+	}
+
+	snprintf(info->fw_version, sizeof(info->fw_version), "%s", mgmt_ver);
+}
+
+static u32 hinic3_get_msglevel(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	return nic_dev->msg_enable;
+}
+
+static void hinic3_set_msglevel(struct net_device *netdev, u32 data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	nic_dev->msg_enable = data;
+
+	netdev_dbg(netdev, "Set message level: 0x%x\n", data);
+}
+
+static const u32 hinic3_mag_link_mode_ge[] = {
+	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+};
+
+static const u32 hinic3_mag_link_mode_10ge_base_r[] = {
+	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseR_FEC_BIT,
+	ETHTOOL_LINK_MODE_10000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT,
+};
+
+static const u32 hinic3_mag_link_mode_25ge_base_r[] = {
+	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
+};
+
+static const u32 hinic3_mag_link_mode_40ge_base_r4[] = {
+	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
+};
+
+static const u32 hinic3_mag_link_mode_50ge_base_r[] = {
+	ETHTOOL_LINK_MODE_50000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseCR_Full_BIT,
+};
+
+static const u32 hinic3_mag_link_mode_50ge_base_r2[] = {
+	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
+};
+
+static const u32 hinic3_mag_link_mode_100ge_base_r[] = {
+	ETHTOOL_LINK_MODE_100000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR_Full_BIT,
+};
+
+static const u32 hinic3_mag_link_mode_100ge_base_r2[] = {
+	ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
+};
+
+static const u32 hinic3_mag_link_mode_100ge_base_r4[] = {
+	ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
+};
+
+static const u32 hinic3_mag_link_mode_200ge_base_r2[] = {
+	ETHTOOL_LINK_MODE_200000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseCR2_Full_BIT,
+};
+
+static const u32 hinic3_mag_link_mode_200ge_base_r4[] = {
+	ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT,
+};
+
+struct hw2ethtool_link_mode {
+	const u32 *link_mode_bit_arr;
+	u32       arr_size;
+	u32       speed;
+};
+
+static const struct hw2ethtool_link_mode
+	hw2ethtool_link_mode_table[LINK_MODE_MAX_NUMBERS] = {
+	[LINK_MODE_GE] = {
+		.link_mode_bit_arr = hinic3_mag_link_mode_ge,
+		.arr_size          = ARRAY_SIZE(hinic3_mag_link_mode_ge),
+		.speed             = SPEED_1000,
+	},
+	[LINK_MODE_10GE_BASE_R] = {
+		.link_mode_bit_arr = hinic3_mag_link_mode_10ge_base_r,
+		.arr_size          = ARRAY_SIZE(hinic3_mag_link_mode_10ge_base_r),
+		.speed             = SPEED_10000,
+	},
+	[LINK_MODE_25GE_BASE_R] = {
+		.link_mode_bit_arr = hinic3_mag_link_mode_25ge_base_r,
+		.arr_size          = ARRAY_SIZE(hinic3_mag_link_mode_25ge_base_r),
+		.speed             = SPEED_25000,
+	},
+	[LINK_MODE_40GE_BASE_R4] = {
+		.link_mode_bit_arr = hinic3_mag_link_mode_40ge_base_r4,
+		.arr_size          = ARRAY_SIZE(hinic3_mag_link_mode_40ge_base_r4),
+		.speed             = SPEED_40000,
+	},
+	[LINK_MODE_50GE_BASE_R] = {
+		.link_mode_bit_arr = hinic3_mag_link_mode_50ge_base_r,
+		.arr_size          = ARRAY_SIZE(hinic3_mag_link_mode_50ge_base_r),
+		.speed             = SPEED_50000,
+	},
+	[LINK_MODE_50GE_BASE_R2] = {
+		.link_mode_bit_arr = hinic3_mag_link_mode_50ge_base_r2,
+		.arr_size          = ARRAY_SIZE(hinic3_mag_link_mode_50ge_base_r2),
+		.speed             = SPEED_50000,
+	},
+	[LINK_MODE_100GE_BASE_R] = {
+		.link_mode_bit_arr = hinic3_mag_link_mode_100ge_base_r,
+		.arr_size          = ARRAY_SIZE(hinic3_mag_link_mode_100ge_base_r),
+		.speed             = SPEED_100000,
+	},
+	[LINK_MODE_100GE_BASE_R2] = {
+		.link_mode_bit_arr = hinic3_mag_link_mode_100ge_base_r2,
+		.arr_size          = ARRAY_SIZE(hinic3_mag_link_mode_100ge_base_r2),
+		.speed             = SPEED_100000,
+	},
+	[LINK_MODE_100GE_BASE_R4] = {
+		.link_mode_bit_arr = hinic3_mag_link_mode_100ge_base_r4,
+		.arr_size          = ARRAY_SIZE(hinic3_mag_link_mode_100ge_base_r4),
+		.speed             = SPEED_100000,
+	},
+	[LINK_MODE_200GE_BASE_R2] = {
+		.link_mode_bit_arr = hinic3_mag_link_mode_200ge_base_r2,
+		.arr_size          = ARRAY_SIZE(hinic3_mag_link_mode_200ge_base_r2),
+		.speed             = SPEED_200000,
+	},
+	[LINK_MODE_200GE_BASE_R4] = {
+		.link_mode_bit_arr = hinic3_mag_link_mode_200ge_base_r4,
+		.arr_size          = ARRAY_SIZE(hinic3_mag_link_mode_200ge_base_r4),
+		.speed             = SPEED_200000,
+	},
+};
+
+#define GET_SUPPORTED_MODE     0
+#define GET_ADVERTISED_MODE    1
+
+struct cmd_link_settings {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
+
+	u32 speed;
+	u8  duplex;
+	u8  port;
+	u8  autoneg;
+};
+
+#define ETHTOOL_ADD_SUPPORTED_LINK_MODE(ecmd, mode) \
+	set_bit(ETHTOOL_LINK_##mode##_BIT, (ecmd)->supported)
+#define ETHTOOL_ADD_ADVERTISED_LINK_MODE(ecmd, mode) \
+	set_bit(ETHTOOL_LINK_##mode##_BIT, (ecmd)->advertising)
+
+static void ethtool_add_speed_link_mode(__ETHTOOL_DECLARE_LINK_MODE_MASK(bitmap), u32 mode)
+{
+	u32 i;
+
+	for (i = 0; i < hw2ethtool_link_mode_table[mode].arr_size; i++) {
+		if (hw2ethtool_link_mode_table[mode].link_mode_bit_arr[i] >=
+		    __ETHTOOL_LINK_MODE_MASK_NBITS)
+			continue;
+
+		set_bit(hw2ethtool_link_mode_table[mode].link_mode_bit_arr[i],
+			bitmap);
+	}
+}
+
+/* Related to enum mag_cmd_port_speed */
+static u32 hw_to_ethtool_speed[] = {
+	(u32)SPEED_UNKNOWN, SPEED_10,    SPEED_100,   SPEED_1000,   SPEED_10000,
+	SPEED_25000,        SPEED_40000, SPEED_50000, SPEED_100000, SPEED_200000
+};
+
+static void
+hinic3_add_ethtool_link_mode(struct cmd_link_settings *link_settings,
+			     u32 hw_link_mode, u32 name)
+{
+	u32 link_mode;
+
+	for (link_mode = 0; link_mode < LINK_MODE_MAX_NUMBERS; link_mode++) {
+		if (hw_link_mode & BIT(link_mode)) {
+			if (name == GET_SUPPORTED_MODE)
+				ethtool_add_speed_link_mode(link_settings->supported, link_mode);
+			else
+				ethtool_add_speed_link_mode(link_settings->advertising, link_mode);
+		}
+	}
+}
+
+static int hinic3_link_speed_set(struct net_device *netdev,
+				 struct cmd_link_settings *link_settings,
+				 struct nic_port_info *port_info)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	bool link_status_up;
+	int err;
+
+	if (port_info->supported_mode != LINK_MODE_UNKNOWN)
+		hinic3_add_ethtool_link_mode(link_settings,
+					     port_info->supported_mode,
+					     GET_SUPPORTED_MODE);
+	if (port_info->advertised_mode != LINK_MODE_UNKNOWN)
+		hinic3_add_ethtool_link_mode(link_settings,
+					     port_info->advertised_mode,
+					     GET_ADVERTISED_MODE);
+
+	err = hinic3_get_link_status(nic_dev->hwdev, &link_status_up);
+	if (!err && link_status_up) {
+		link_settings->speed =
+			port_info->speed < ARRAY_SIZE(hw_to_ethtool_speed) ?
+				hw_to_ethtool_speed[port_info->speed] :
+				(u32)SPEED_UNKNOWN;
+
+		link_settings->duplex = port_info->duplex;
+	} else {
+		link_settings->speed = (u32)SPEED_UNKNOWN;
+		link_settings->duplex = DUPLEX_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static void hinic3_link_port_type(struct cmd_link_settings *link_settings,
+				  u8 port_type)
+{
+	switch (port_type) {
+	case MAG_CMD_WIRE_TYPE_ELECTRIC:
+		ETHTOOL_ADD_SUPPORTED_LINK_MODE(link_settings, MODE_TP);
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_TP);
+		link_settings->port = PORT_TP;
+		break;
+
+	case MAG_CMD_WIRE_TYPE_AOC:
+	case MAG_CMD_WIRE_TYPE_MM:
+	case MAG_CMD_WIRE_TYPE_SM:
+		ETHTOOL_ADD_SUPPORTED_LINK_MODE(link_settings, MODE_FIBRE);
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_FIBRE);
+		link_settings->port = PORT_FIBRE;
+		break;
+
+	case MAG_CMD_WIRE_TYPE_COPPER:
+		ETHTOOL_ADD_SUPPORTED_LINK_MODE(link_settings, MODE_FIBRE);
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_FIBRE);
+		link_settings->port = PORT_DA;
+		break;
+
+	case MAG_CMD_WIRE_TYPE_BACKPLANE:
+		ETHTOOL_ADD_SUPPORTED_LINK_MODE(link_settings, MODE_Backplane);
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_Backplane);
+		link_settings->port = PORT_NONE;
+		break;
+
+	default:
+		link_settings->port = PORT_OTHER;
+		break;
+	}
+}
+
+static int get_link_pause_settings(struct net_device *netdev,
+				   struct cmd_link_settings *link_settings)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct nic_pause_config nic_pause;
+	int err;
+
+	err = hinic3_get_pause_info(nic_dev, &nic_pause);
+	if (err) {
+		netdev_err(netdev, "Failed to get pause param from hw\n");
+		return err;
+	}
+
+	ETHTOOL_ADD_SUPPORTED_LINK_MODE(link_settings, MODE_Pause);
+	if (nic_pause.rx_pause && nic_pause.tx_pause) {
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_Pause);
+	} else if (nic_pause.tx_pause) {
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_Asym_Pause);
+	} else if (nic_pause.rx_pause) {
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_Pause);
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_Asym_Pause);
+	}
+
+	return 0;
+}
+
+static int get_link_settings(struct net_device *netdev,
+			     struct cmd_link_settings *link_settings)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct nic_port_info port_info;
+	int err;
+
+	err = hinic3_get_port_info(nic_dev->hwdev, &port_info);
+	if (err) {
+		netdev_err(netdev, "Failed to get port info\n");
+		return err;
+	}
+
+	err = hinic3_link_speed_set(netdev, link_settings, &port_info);
+	if (err)
+		return err;
+
+	hinic3_link_port_type(link_settings, port_info.port_type);
+
+	link_settings->autoneg = port_info.autoneg_state == PORT_CFG_AN_ON ?
+					 AUTONEG_ENABLE :
+					 AUTONEG_DISABLE;
+	if (port_info.autoneg_cap)
+		ETHTOOL_ADD_SUPPORTED_LINK_MODE(link_settings, MODE_Autoneg);
+	if (port_info.autoneg_state == PORT_CFG_AN_ON)
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_Autoneg);
+
+	if (!HINIC3_IS_VF(nic_dev->hwdev))
+		err = get_link_pause_settings(netdev, link_settings);
+
+	return err;
+}
+
+static int hinic3_get_link_ksettings(struct net_device *netdev,
+				     struct ethtool_link_ksettings *link_settings)
+{
+	struct ethtool_link_settings *base = &link_settings->base;
+	struct cmd_link_settings settings = {};
+	int err;
+
+	ethtool_link_ksettings_zero_link_mode(link_settings, supported);
+	ethtool_link_ksettings_zero_link_mode(link_settings, advertising);
+
+	err = get_link_settings(netdev, &settings);
+	if (err)
+		return err;
+
+	bitmap_copy(link_settings->link_modes.supported, settings.supported,
+		    __ETHTOOL_LINK_MODE_MASK_NBITS);
+	bitmap_copy(link_settings->link_modes.advertising, settings.advertising,
+		    __ETHTOOL_LINK_MODE_MASK_NBITS);
+
+	base->autoneg = settings.autoneg;
+	base->speed = settings.speed;
+	base->duplex = settings.duplex;
+	base->port = settings.port;
+
+	return 0;
+}
+
+static void hinic3_get_ringparam(struct net_device *netdev,
+				 struct ethtool_ringparam *ring,
+				 struct kernel_ethtool_ringparam *kernel_ring,
+				 struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	ring->rx_max_pending = HINIC3_MAX_RX_QUEUE_DEPTH;
+	ring->tx_max_pending = HINIC3_MAX_TX_QUEUE_DEPTH;
+	ring->rx_pending = nic_dev->rxqs[0].q_depth;
+	ring->tx_pending = nic_dev->txqs[0].q_depth;
+}
+
+static void hinic3_update_qp_depth(struct net_device *netdev,
+				   u32 sq_depth, u32 rq_depth)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i;
+
+	nic_dev->q_params.sq_depth = sq_depth;
+	nic_dev->q_params.rq_depth = rq_depth;
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		nic_dev->txqs[i].q_depth = sq_depth;
+		nic_dev->txqs[i].q_mask = sq_depth - 1;
+		nic_dev->rxqs[i].q_depth = rq_depth;
+		nic_dev->rxqs[i].q_mask = rq_depth - 1;
+	}
+}
+
+static int check_ringparam_valid(struct net_device *netdev,
+				 const struct ethtool_ringparam *ring)
+{
+	if (ring->rx_jumbo_pending || ring->rx_mini_pending) {
+		netdev_err(netdev, "Unsupported rx_jumbo_pending/rx_mini_pending\n");
+		return -EINVAL;
+	}
+
+	if (ring->tx_pending > HINIC3_MAX_TX_QUEUE_DEPTH ||
+	    ring->tx_pending < HINIC3_MIN_QUEUE_DEPTH ||
+	    ring->rx_pending > HINIC3_MAX_RX_QUEUE_DEPTH ||
+	    ring->rx_pending < HINIC3_MIN_QUEUE_DEPTH) {
+		netdev_err(netdev,
+			   "Queue depth out of rang tx[%d-%d] rx[%d-%d]\n",
+			   HINIC3_MIN_QUEUE_DEPTH, HINIC3_MAX_TX_QUEUE_DEPTH,
+			   HINIC3_MIN_QUEUE_DEPTH, HINIC3_MAX_RX_QUEUE_DEPTH);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_ringparam(struct net_device *netdev,
+				struct ethtool_ringparam *ring,
+				struct kernel_ethtool_ringparam *kernel_ring,
+				struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_txrxq_params q_params;
+	u32 new_sq_depth, new_rq_depth;
+	int err;
+
+	err = check_ringparam_valid(netdev, ring);
+	if (err)
+		return err;
+
+	new_sq_depth = 1U << ilog2(ring->tx_pending);
+	new_rq_depth = 1U << ilog2(ring->rx_pending);
+	if (new_sq_depth == nic_dev->q_params.sq_depth &&
+	    new_rq_depth == nic_dev->q_params.rq_depth)
+		return 0;
+
+	netdev_dbg(netdev, "Change Tx/Rx ring depth from %u/%u to %u/%u\n",
+		   nic_dev->q_params.sq_depth, nic_dev->q_params.rq_depth,
+		   new_sq_depth, new_rq_depth);
+
+	if (!netif_running(netdev)) {
+		hinic3_update_qp_depth(netdev, new_sq_depth, new_rq_depth);
+	} else {
+		q_params = nic_dev->q_params;
+		q_params.sq_depth = new_sq_depth;
+		q_params.rq_depth = new_rq_depth;
+		q_params.txqs_res = NULL;
+		q_params.rxqs_res = NULL;
+		q_params.irq_cfg = NULL;
+
+		err = hinic3_change_channel_settings(netdev, &q_params, NULL);
+		if (err) {
+			netdev_err(netdev, "Failed to change channel settings\n");
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+struct hinic3_stats {
+	char name[ETH_GSTRING_LEN];
+	u32  size;
+	int  offset;
+};
+
+#define HINIC3_NETDEV_STAT(_stat_item) { \
+	.name   = #_stat_item, \
+	.size   = sizeof_field(struct rtnl_link_stats64, _stat_item), \
+	.offset = offsetof(struct rtnl_link_stats64, _stat_item) \
+}
+
+static const struct hinic3_stats hinic3_netdev_stats[] = {
+	HINIC3_NETDEV_STAT(rx_packets),
+	HINIC3_NETDEV_STAT(tx_packets),
+	HINIC3_NETDEV_STAT(rx_bytes),
+	HINIC3_NETDEV_STAT(tx_bytes),
+	HINIC3_NETDEV_STAT(rx_errors),
+	HINIC3_NETDEV_STAT(tx_errors),
+	HINIC3_NETDEV_STAT(rx_dropped),
+	HINIC3_NETDEV_STAT(tx_dropped),
+	HINIC3_NETDEV_STAT(multicast),
+	HINIC3_NETDEV_STAT(collisions),
+	HINIC3_NETDEV_STAT(rx_length_errors),
+	HINIC3_NETDEV_STAT(rx_over_errors),
+	HINIC3_NETDEV_STAT(rx_crc_errors),
+	HINIC3_NETDEV_STAT(rx_frame_errors),
+	HINIC3_NETDEV_STAT(rx_fifo_errors),
+	HINIC3_NETDEV_STAT(rx_missed_errors),
+	HINIC3_NETDEV_STAT(tx_aborted_errors),
+	HINIC3_NETDEV_STAT(tx_carrier_errors),
+	HINIC3_NETDEV_STAT(tx_fifo_errors),
+	HINIC3_NETDEV_STAT(tx_heartbeat_errors),
+};
+
+#define HINIC3_NIC_STAT(_stat_item) { \
+	.name   = #_stat_item, \
+	.size   = sizeof_field(struct hinic3_nic_stats, _stat_item), \
+	.offset = offsetof(struct hinic3_nic_stats, _stat_item) \
+}
+
+static struct hinic3_stats hinic3_nic_dev_stats[] = {
+	HINIC3_NIC_STAT(netdev_tx_timeout),
+};
+
+#define HINIC3_RXQ_STAT(_stat_item) { \
+	.name   = "rxq%d_"#_stat_item, \
+	.size   = sizeof_field(struct hinic3_rxq_stats, _stat_item), \
+	.offset = offsetof(struct hinic3_rxq_stats, _stat_item) \
+}
+
+#define HINIC3_TXQ_STAT(_stat_item) { \
+	.name   = "txq%d_"#_stat_item, \
+	.size   = sizeof_field(struct hinic3_txq_stats, _stat_item), \
+	.offset = offsetof(struct hinic3_txq_stats, _stat_item) \
+}
+
+static struct hinic3_stats hinic3_rx_queue_stats[] = {
+	HINIC3_RXQ_STAT(packets),
+	HINIC3_RXQ_STAT(bytes),
+	HINIC3_RXQ_STAT(errors),
+	HINIC3_RXQ_STAT(csum_errors),
+	HINIC3_RXQ_STAT(other_errors),
+	HINIC3_RXQ_STAT(dropped),
+	HINIC3_RXQ_STAT(rx_buf_empty),
+	HINIC3_RXQ_STAT(alloc_skb_err),
+	HINIC3_RXQ_STAT(alloc_rx_buf_err),
+	HINIC3_RXQ_STAT(restore_drop_sge),
+};
+
+static struct hinic3_stats hinic3_tx_queue_stats[] = {
+	HINIC3_TXQ_STAT(packets),
+	HINIC3_TXQ_STAT(bytes),
+	HINIC3_TXQ_STAT(busy),
+	HINIC3_TXQ_STAT(wake),
+	HINIC3_TXQ_STAT(dropped),
+	HINIC3_TXQ_STAT(skb_pad_err),
+	HINIC3_TXQ_STAT(frag_len_overflow),
+	HINIC3_TXQ_STAT(offload_cow_skb_err),
+	HINIC3_TXQ_STAT(map_frag_err),
+	HINIC3_TXQ_STAT(unknown_tunnel_pkt),
+	HINIC3_TXQ_STAT(frag_size_err),
+};
+
+#define HINIC3_FUNC_STAT(_stat_item) {	\
+	.name   = #_stat_item, \
+	.size   = sizeof_field(struct hinic3_vport_stats, _stat_item), \
+	.offset = offsetof(struct hinic3_vport_stats, _stat_item) \
+}
+
+static struct hinic3_stats hinic3_function_stats[] = {
+	HINIC3_FUNC_STAT(tx_unicast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_unicast_bytes_vport),
+	HINIC3_FUNC_STAT(tx_multicast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_multicast_bytes_vport),
+	HINIC3_FUNC_STAT(tx_broadcast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_broadcast_bytes_vport),
+
+	HINIC3_FUNC_STAT(rx_unicast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_unicast_bytes_vport),
+	HINIC3_FUNC_STAT(rx_multicast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_multicast_bytes_vport),
+	HINIC3_FUNC_STAT(rx_broadcast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_broadcast_bytes_vport),
+
+	HINIC3_FUNC_STAT(tx_discard_vport),
+	HINIC3_FUNC_STAT(rx_discard_vport),
+	HINIC3_FUNC_STAT(tx_err_vport),
+	HINIC3_FUNC_STAT(rx_err_vport),
+};
+
+#define HINIC3_PORT_STAT(_stat_item) { \
+	.name   = #_stat_item, \
+	.size   = sizeof_field(struct mag_cmd_port_stats, _stat_item), \
+	.offset = offsetof(struct mag_cmd_port_stats, _stat_item) \
+}
+
+static struct hinic3_stats hinic3_port_stats[] = {
+	HINIC3_PORT_STAT(mac_tx_fragment_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_undersize_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_undermin_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_64_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_65_127_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_128_255_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_256_511_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_512_1023_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1024_1518_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1519_2047_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_2048_4095_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_4096_8191_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_8192_9216_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_9217_12287_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_12288_16383_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1519_max_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1519_max_good_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_oversize_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_jabber_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_bad_oct_num),
+	HINIC3_PORT_STAT(mac_tx_good_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_good_oct_num),
+	HINIC3_PORT_STAT(mac_tx_total_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_total_oct_num),
+	HINIC3_PORT_STAT(mac_tx_uni_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_multi_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_broad_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pause_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri0_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri1_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri2_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri3_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri4_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri5_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri6_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri7_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_control_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_err_all_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_from_app_good_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_from_app_bad_pkt_num),
+
+	HINIC3_PORT_STAT(mac_rx_fragment_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_undersize_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_undermin_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_64_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_65_127_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_128_255_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_256_511_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_512_1023_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1024_1518_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1519_2047_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_2048_4095_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_4096_8191_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_8192_9216_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_9217_12287_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_12288_16383_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1519_max_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1519_max_good_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_oversize_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_jabber_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_bad_oct_num),
+	HINIC3_PORT_STAT(mac_rx_good_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_good_oct_num),
+	HINIC3_PORT_STAT(mac_rx_total_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_total_oct_num),
+	HINIC3_PORT_STAT(mac_rx_uni_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_multi_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_broad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pause_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri0_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri1_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri2_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri3_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri4_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri5_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri6_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri7_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_control_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_sym_err_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_fcs_err_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_send_app_good_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_send_app_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_unfilter_pkt_num),
+};
+
+static int hinic3_get_sset_count(struct net_device *netdev, int sset)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int count, q_num;
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		q_num = nic_dev->q_params.num_qps;
+		count = ARRAY_SIZE(hinic3_netdev_stats) +
+			ARRAY_SIZE(hinic3_nic_dev_stats) +
+			ARRAY_SIZE(hinic3_function_stats) +
+			(ARRAY_SIZE(hinic3_tx_queue_stats) +
+			 ARRAY_SIZE(hinic3_rx_queue_stats)) *
+				q_num;
+
+		if (!HINIC3_IS_VF(nic_dev->hwdev))
+			count += ARRAY_SIZE(hinic3_port_stats);
+
+		return count;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static u64 get_value_of_ptr(u32 size, const void *ptr)
+{
+	u64 ret = (size) == sizeof(u64) ? *(u64 *)(ptr) :
+		  (size) == sizeof(u32) ? *(u32 *)(ptr) :
+		  (size) == sizeof(u16) ? *(u16 *)(ptr) :
+					  *(u8 *)(ptr);
+	return ret;
+}
+
+static void get_drv_queue_stats(struct net_device *netdev, u64 *data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_txq_stats txq_stats;
+	struct hinic3_rxq_stats rxq_stats;
+	u16 i = 0, j, qid;
+	char *p;
+
+	for (qid = 0; qid < nic_dev->q_params.num_qps; qid++) {
+		if (!nic_dev->txqs)
+			break;
+
+		hinic3_txq_get_stats(&nic_dev->txqs[qid], &txq_stats);
+		for (j = 0; j < ARRAY_SIZE(hinic3_tx_queue_stats); j++, i++) {
+			p = (char *)(&txq_stats) +
+			    hinic3_tx_queue_stats[j].offset;
+			data[i] =
+				(hinic3_tx_queue_stats[j].size == sizeof(u64)) ?
+					*(u64 *)p :
+					*(u32 *)p;
+		}
+	}
+
+	for (qid = 0; qid < nic_dev->q_params.num_qps; qid++) {
+		if (!nic_dev->rxqs)
+			break;
+
+		hinic3_rxq_get_stats(&nic_dev->rxqs[qid], &rxq_stats);
+		for (j = 0; j < ARRAY_SIZE(hinic3_rx_queue_stats); j++, i++) {
+			p = (char *)(&rxq_stats) +
+			    hinic3_rx_queue_stats[j].offset;
+			data[i] =
+				(hinic3_rx_queue_stats[j].size == sizeof(u64)) ?
+					*(u64 *)p :
+					*(u32 *)p;
+		}
+	}
+}
+
+static u16 get_ethtool_port_stats(struct net_device *netdev, u64 *data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct mag_cmd_port_stats *port_stats;
+	u16 i = 0, j;
+	char *p;
+	int err;
+
+	port_stats = kzalloc(sizeof(*port_stats), GFP_KERNEL);
+	if (!port_stats) {
+		memset(&data[i], 0, ARRAY_SIZE(hinic3_port_stats) * sizeof(*data));
+		i += ARRAY_SIZE(hinic3_port_stats);
+		return i;
+	}
+
+	err = hinic3_get_phy_port_stats(nic_dev->hwdev, port_stats);
+	if (err)
+		netdev_err(netdev, "Failed to get port stats from fw\n");
+
+	for (j = 0; j < ARRAY_SIZE(hinic3_port_stats); j++, i++) {
+		p = (char *)(port_stats) + hinic3_port_stats[j].offset;
+		data[i] = (hinic3_port_stats[j].size == sizeof(u64)) ?
+				  *(u64 *)p :
+				  *(u32 *)p;
+	}
+
+	kfree(port_stats);
+
+	return i;
+}
+
+static void hinic3_get_ethtool_stats(struct net_device *netdev,
+				     struct ethtool_stats *stats, u64 *data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	const struct rtnl_link_stats64 *net_stats;
+	struct hinic3_vport_stats vport_stats;
+	struct hinic3_nic_stats *nic_stats;
+	struct rtnl_link_stats64 temp;
+	u16 i = 0, j;
+	char *p;
+	int err;
+
+	net_stats = dev_get_stats(netdev, &temp);
+	for (j = 0; j < ARRAY_SIZE(hinic3_netdev_stats); j++, i++) {
+		p = (char *)(net_stats) + hinic3_netdev_stats[j].offset;
+		data[i] = get_value_of_ptr(hinic3_netdev_stats[j].size, p);
+	}
+
+	nic_stats = &nic_dev->stats;
+	for (j = 0; j < ARRAY_SIZE(hinic3_nic_dev_stats); j++, i++) {
+		p = (char *)(nic_stats) + hinic3_nic_dev_stats[j].offset;
+		data[i] = get_value_of_ptr(hinic3_nic_dev_stats[j].size, p);
+	}
+
+	err = hinic3_get_vport_stats(nic_dev->hwdev,
+				     hinic3_global_func_id(nic_dev->hwdev),
+				     &vport_stats);
+	if (err)
+		netdev_err(netdev, "Failed to get function stats from fw\n");
+
+	for (j = 0; j < ARRAY_SIZE(hinic3_function_stats); j++, i++) {
+		p = (char *)(&vport_stats) + hinic3_function_stats[j].offset;
+		data[i] = get_value_of_ptr(hinic3_function_stats[j].size, p);
+	}
+
+	if (!HINIC3_IS_VF(nic_dev->hwdev))
+		i += get_ethtool_port_stats(netdev, data + i);
+
+	get_drv_queue_stats(netdev, data + i);
+}
+
+static u16 get_drv_dev_strings(char *p)
+{
+	u16 i, cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(hinic3_netdev_stats); i++) {
+		memcpy(p, hinic3_netdev_stats[i].name, ETH_GSTRING_LEN);
+		p += ETH_GSTRING_LEN;
+		cnt++;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(hinic3_nic_dev_stats); i++) {
+		memcpy(p, hinic3_nic_dev_stats[i].name, ETH_GSTRING_LEN);
+		p += ETH_GSTRING_LEN;
+		cnt++;
+	}
+
+	return cnt;
+}
+
+static u16 get_hw_stats_strings(struct net_device *netdev, char *p)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i, cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(hinic3_function_stats); i++) {
+		memcpy(p, hinic3_function_stats[i].name, ETH_GSTRING_LEN);
+		p += ETH_GSTRING_LEN;
+		cnt++;
+	}
+
+	if (!HINIC3_IS_VF(nic_dev->hwdev)) {
+		for (i = 0; i < ARRAY_SIZE(hinic3_port_stats); i++) {
+			memcpy(p, hinic3_port_stats[i].name, ETH_GSTRING_LEN);
+			p += ETH_GSTRING_LEN;
+			cnt++;
+		}
+	}
+
+	return cnt;
+}
+
+static u16 get_qp_stats_strings(const struct net_device *netdev, char *p)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i, j, cnt = 0;
+	int err;
+
+	for (i = 0; i < nic_dev->q_params.num_qps; i++) {
+		for (j = 0; j < ARRAY_SIZE(hinic3_tx_queue_stats); j++) {
+			err = sprintf(p, hinic3_tx_queue_stats[j].name, i);
+			if (err < 0)
+				netdev_err(netdev,
+					   "Failed to sprintf tx queue stats name, idx_qps: %u, idx_stats: %u\n",
+					   i, j);
+			p += ETH_GSTRING_LEN;
+			cnt++;
+		}
+	}
+
+	for (i = 0; i < nic_dev->q_params.num_qps; i++) {
+		for (j = 0; j < ARRAY_SIZE(hinic3_rx_queue_stats); j++) {
+			err = sprintf(p, hinic3_rx_queue_stats[j].name, i);
+			if (err < 0)
+				netdev_err(netdev,
+					   "Failed to sprintf rx queue stats name, idx_qps: %u, idx_stats: %u\n",
+					   i, j);
+			p += ETH_GSTRING_LEN;
+			cnt++;
+		}
+	}
+
+	return cnt;
+}
+
+static void hinic3_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+{
+	char *p = (char *)data;
+	u16 offset;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		offset = get_drv_dev_strings(p);
+		offset += get_hw_stats_strings(netdev,
+					       p + offset * ETH_GSTRING_LEN);
+		get_qp_stats_strings(netdev, p + offset * ETH_GSTRING_LEN);
+
+		return;
+	default:
+		netdev_err(netdev, "Invalid string set %u.\n", stringset);
+		return;
+	}
+}
+
+static int get_coalesce(struct net_device *netdev,
+			struct ethtool_coalesce *coal, u16 queue)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *interrupt_info;
+
+	if (queue == COALESCE_ALL_QUEUE) {
+		/* get tx/rx irq0 as default parameters */
+		interrupt_info = &nic_dev->intr_coalesce[0];
+	} else {
+		if (queue >= nic_dev->q_params.num_qps) {
+			netdev_err(netdev, "Invalid queue_id: %u\n", queue);
+			return -EINVAL;
+		}
+		interrupt_info = &nic_dev->intr_coalesce[queue];
+	}
+
+	coal->rx_coalesce_usecs = interrupt_info->coalesce_timer_cfg *
+			COALESCE_TIMER_CFG_UNIT;
+	coal->rx_max_coalesced_frames = interrupt_info->pending_limt *
+			COALESCE_PENDING_LIMIT_UNIT;
+
+	/* tx/rx use the same interrupt */
+	coal->tx_coalesce_usecs = coal->rx_coalesce_usecs;
+	coal->tx_max_coalesced_frames = coal->rx_max_coalesced_frames;
+	coal->use_adaptive_rx_coalesce = nic_dev->adaptive_rx_coal;
+
+	coal->pkt_rate_high = (u32)interrupt_info->pkt_rate_high;
+	coal->rx_coalesce_usecs_high = interrupt_info->rx_usecs_high *
+				       COALESCE_TIMER_CFG_UNIT;
+	coal->rx_max_coalesced_frames_high =
+					interrupt_info->rx_pending_limt_high *
+					COALESCE_PENDING_LIMIT_UNIT;
+
+	coal->pkt_rate_low = (u32)interrupt_info->pkt_rate_low;
+	coal->rx_coalesce_usecs_low = interrupt_info->rx_usecs_low *
+				      COALESCE_TIMER_CFG_UNIT;
+	coal->rx_max_coalesced_frames_low =
+					interrupt_info->rx_pending_limt_low *
+					COALESCE_PENDING_LIMIT_UNIT;
+
+	return 0;
+}
+
+static int set_queue_coalesce(struct net_device *netdev, u16 q_id,
+			      struct hinic3_intr_coal_info *coal)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *intr_coal;
+	struct interrupt_info info = {};
+	int err;
+
+	intr_coal = &nic_dev->intr_coalesce[q_id];
+	if (intr_coal->coalesce_timer_cfg != coal->coalesce_timer_cfg ||
+	    intr_coal->pending_limt != coal->pending_limt)
+		intr_coal->user_set_intr_coal_flag = 1;
+
+	intr_coal->coalesce_timer_cfg = coal->coalesce_timer_cfg;
+	intr_coal->pending_limt = coal->pending_limt;
+	intr_coal->pkt_rate_low = coal->pkt_rate_low;
+	intr_coal->rx_usecs_low = coal->rx_usecs_low;
+	intr_coal->rx_pending_limt_low = coal->rx_pending_limt_low;
+	intr_coal->pkt_rate_high = coal->pkt_rate_high;
+	intr_coal->rx_usecs_high = coal->rx_usecs_high;
+	intr_coal->rx_pending_limt_high = coal->rx_pending_limt_high;
+
+	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags) ||
+	    q_id >= nic_dev->q_params.num_qps || nic_dev->adaptive_rx_coal)
+		return 0;
+
+	info.msix_index = nic_dev->q_params.irq_cfg[q_id].msix_entry_idx;
+	info.lli_set = 0;
+	info.interrupt_coalesc_set = 1;
+	info.coalesc_timer_cfg = intr_coal->coalesce_timer_cfg;
+	info.pending_limt = intr_coal->pending_limt;
+	info.resend_timer_cfg = intr_coal->resend_timer_cfg;
+	nic_dev->rxqs[q_id].last_coalesc_timer_cfg =
+					intr_coal->coalesce_timer_cfg;
+	nic_dev->rxqs[q_id].last_pending_limt = intr_coal->pending_limt;
+	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
+	if (err)
+		netdev_warn(netdev, "Failed to set queue%u coalesce\n", q_id);
+
+	return err;
+}
+
+static int is_coalesce_exceed_limit(struct net_device *netdev,
+				    const struct ethtool_coalesce *coal)
+{
+	if (coal->rx_coalesce_usecs > COALESCE_MAX_TIMER_CFG) {
+		netdev_err(netdev, "rx_coalesce_usecs out of range %d-%d\n", 0,
+			   COALESCE_MAX_TIMER_CFG);
+		return -EOPNOTSUPP;
+	}
+
+	if (coal->rx_max_coalesced_frames > COALESCE_MAX_PENDING_LIMIT) {
+		netdev_err(netdev, "rx_max_coalesced_frames out of range %d-%d\n", 0,
+			   COALESCE_MAX_PENDING_LIMIT);
+		return -EOPNOTSUPP;
+	}
+
+	if (coal->rx_coalesce_usecs_low > COALESCE_MAX_TIMER_CFG) {
+		netdev_err(netdev, "rx_coalesce_usecs_low out of range %d-%d\n", 0,
+			   COALESCE_MAX_TIMER_CFG);
+		return -EOPNOTSUPP;
+	}
+
+	if (coal->rx_max_coalesced_frames_low > COALESCE_MAX_PENDING_LIMIT) {
+		netdev_err(netdev, "rx_max_coalesced_frames_low out of range %d-%d\n",
+			   0, COALESCE_MAX_PENDING_LIMIT);
+		return -EOPNOTSUPP;
+	}
+
+	if (coal->rx_coalesce_usecs_high > COALESCE_MAX_TIMER_CFG) {
+		netdev_err(netdev, "rx_coalesce_usecs_high out of range %d-%d\n", 0,
+			   COALESCE_MAX_TIMER_CFG);
+		return -EOPNOTSUPP;
+	}
+
+	if (coal->rx_max_coalesced_frames_high > COALESCE_MAX_PENDING_LIMIT) {
+		netdev_err(netdev, "rx_max_coalesced_frames_high out of range %d-%d\n",
+			   0, COALESCE_MAX_PENDING_LIMIT);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int is_coalesce_legal(struct net_device *netdev,
+			     const struct ethtool_coalesce *coal)
+{
+	struct ethtool_coalesce tmp_coal = {};
+	int err;
+
+	if (coal->rx_coalesce_usecs != coal->tx_coalesce_usecs) {
+		netdev_err(netdev, "tx-usecs must be equal to rx-usecs\n");
+		return -EINVAL;
+	}
+
+	if (coal->rx_max_coalesced_frames != coal->tx_max_coalesced_frames) {
+		netdev_err(netdev, "tx-frames must be equal to rx-frames\n");
+		return -EINVAL;
+	}
+
+	tmp_coal.cmd = coal->cmd;
+	tmp_coal.rx_coalesce_usecs = coal->rx_coalesce_usecs;
+	tmp_coal.rx_max_coalesced_frames = coal->rx_max_coalesced_frames;
+	tmp_coal.tx_coalesce_usecs = coal->tx_coalesce_usecs;
+	tmp_coal.tx_max_coalesced_frames = coal->tx_max_coalesced_frames;
+	tmp_coal.use_adaptive_rx_coalesce = coal->use_adaptive_rx_coalesce;
+
+	tmp_coal.pkt_rate_low = coal->pkt_rate_low;
+	tmp_coal.rx_coalesce_usecs_low = coal->rx_coalesce_usecs_low;
+	tmp_coal.rx_max_coalesced_frames_low =
+					coal->rx_max_coalesced_frames_low;
+
+	tmp_coal.pkt_rate_high = coal->pkt_rate_high;
+	tmp_coal.rx_coalesce_usecs_high = coal->rx_coalesce_usecs_high;
+	tmp_coal.rx_max_coalesced_frames_high =
+					coal->rx_max_coalesced_frames_high;
+
+	if (memcmp(coal, &tmp_coal, sizeof(struct ethtool_coalesce))) {
+		netdev_err(netdev, "Only support to change rx/tx-usecs and rx/tx-frames\n");
+		return -EOPNOTSUPP;
+	}
+
+	err = is_coalesce_exceed_limit(netdev, coal);
+	if (err)
+		return err;
+
+	if (coal->rx_coalesce_usecs_low / COALESCE_TIMER_CFG_UNIT >=
+	    coal->rx_coalesce_usecs_high / COALESCE_TIMER_CFG_UNIT) {
+		netdev_err(netdev, "invalid coalesce usec high %u, low %u, unit %d\n",
+			   coal->rx_coalesce_usecs_high,
+			   coal->rx_coalesce_usecs_low,
+			   COALESCE_TIMER_CFG_UNIT);
+		return -EINVAL;
+	}
+
+	if (coal->rx_max_coalesced_frames_low / COALESCE_PENDING_LIMIT_UNIT >=
+	    coal->rx_max_coalesced_frames_high / COALESCE_PENDING_LIMIT_UNIT) {
+		netdev_err(netdev, "invalid coalesce frame high %u, low %u, unit %d\n",
+			   coal->rx_max_coalesced_frames_high,
+			   coal->rx_max_coalesced_frames_low,
+			   COALESCE_PENDING_LIMIT_UNIT);
+		return -EOPNOTSUPP;
+	}
+
+	if (coal->pkt_rate_low >= coal->pkt_rate_high) {
+		netdev_err(netdev, "pkt_rate_high_%u must more than pkt_rate_low_%u\n",
+			   coal->pkt_rate_high,
+			   coal->pkt_rate_low);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static void check_coalesce_align(struct net_device *netdev,
+				 u32 item, u32 unit, const char *str)
+{
+	if (item % unit)
+		netdev_warn(netdev, "%s in %d units, change to %u\n",
+			    str, unit, item - item % unit);
+}
+
+#define CHECK_COALESCE_ALIGN(member, unit) \
+	check_coalesce_align(netdev, member, unit, #member)
+
+static void check_coalesce_changed(struct net_device *netdev,
+				   u32 item, u32 unit, u32 ori_val,
+				   const char *obj_str, const char *str)
+{
+	if ((item / unit) != ori_val)
+		netdev_dbg(netdev, "Change %s from %d to %u %s\n",
+			   str, ori_val * unit, item - item % unit, obj_str);
+}
+
+#define CHECK_COALESCE_CHANGED(member, unit, ori_val, obj_str) \
+	check_coalesce_changed(netdev, member, unit, ori_val, obj_str, #member)
+
+static void check_pkt_rate_changed(struct net_device *netdev,
+				   u32 item, u32 ori_val,
+				   const char *obj_str, const char *str)
+{
+	if (item != ori_val)
+		netdev_dbg(netdev, "Change %s from %d to %u %s\n", str, ori_val, item, obj_str);
+}
+
+#define CHECK_PKT_RATE_CHANGED(member, ori_val, obj_str) \
+	check_pkt_rate_changed(netdev, member, ori_val, obj_str, #member)
+
+static int set_hw_coal_param(struct net_device *netdev,
+			     struct hinic3_intr_coal_info *intr_coal, u16 queue)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i;
+
+	if (queue == COALESCE_ALL_QUEUE) {
+		for (i = 0; i < nic_dev->max_qps; i++)
+			set_queue_coalesce(netdev, i, intr_coal);
+	} else {
+		if (queue >= nic_dev->q_params.num_qps) {
+			netdev_err(netdev, "Invalid queue_id: %u\n", queue);
+			return -EINVAL;
+		}
+		set_queue_coalesce(netdev, queue, intr_coal);
+	}
+
+	return 0;
+}
+
+static int set_coalesce(struct net_device *netdev,
+			struct ethtool_coalesce *coal, u16 queue)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *ori_intr_coal;
+	struct hinic3_intr_coal_info intr_coal = {};
+	u32 last_adaptive_rx;
+	char obj_str[32];
+	int err;
+
+	err = is_coalesce_legal(netdev, coal);
+	if (err)
+		return err;
+
+	CHECK_COALESCE_ALIGN(coal->rx_coalesce_usecs, COALESCE_TIMER_CFG_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames,
+			     COALESCE_PENDING_LIMIT_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_coalesce_usecs_high,
+			     COALESCE_TIMER_CFG_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames_high,
+			     COALESCE_PENDING_LIMIT_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_coalesce_usecs_low,
+			     COALESCE_TIMER_CFG_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames_low,
+			     COALESCE_PENDING_LIMIT_UNIT);
+
+	if (queue == COALESCE_ALL_QUEUE) {
+		ori_intr_coal = &nic_dev->intr_coalesce[0];
+		snprintf(obj_str, sizeof(obj_str), "for netdev");
+	} else {
+		ori_intr_coal = &nic_dev->intr_coalesce[queue];
+		snprintf(obj_str, sizeof(obj_str), "for queue %u", queue);
+	}
+	CHECK_COALESCE_CHANGED(coal->rx_coalesce_usecs, COALESCE_TIMER_CFG_UNIT,
+			       ori_intr_coal->coalesce_timer_cfg, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames,
+			       COALESCE_PENDING_LIMIT_UNIT,
+			       ori_intr_coal->pending_limt, obj_str);
+	CHECK_PKT_RATE_CHANGED(coal->pkt_rate_high,
+			       ori_intr_coal->pkt_rate_high, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_coalesce_usecs_high,
+			       COALESCE_TIMER_CFG_UNIT,
+			       ori_intr_coal->rx_usecs_high, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames_high,
+			       COALESCE_PENDING_LIMIT_UNIT,
+			       ori_intr_coal->rx_pending_limt_high, obj_str);
+	CHECK_PKT_RATE_CHANGED(coal->pkt_rate_low,
+			       ori_intr_coal->pkt_rate_low, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_coalesce_usecs_low,
+			       COALESCE_TIMER_CFG_UNIT,
+			       ori_intr_coal->rx_usecs_low, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames_low,
+			       COALESCE_PENDING_LIMIT_UNIT,
+			       ori_intr_coal->rx_pending_limt_low, obj_str);
+
+	intr_coal.coalesce_timer_cfg =
+		(u8)(coal->rx_coalesce_usecs / COALESCE_TIMER_CFG_UNIT);
+	intr_coal.pending_limt = (u8)(coal->rx_max_coalesced_frames /
+				      COALESCE_PENDING_LIMIT_UNIT);
+
+	last_adaptive_rx = nic_dev->adaptive_rx_coal;
+	nic_dev->adaptive_rx_coal = coal->use_adaptive_rx_coalesce;
+
+	intr_coal.pkt_rate_high = coal->pkt_rate_high;
+	intr_coal.rx_usecs_high =
+		(u8)(coal->rx_coalesce_usecs_high / COALESCE_TIMER_CFG_UNIT);
+	intr_coal.rx_pending_limt_high =
+		(u8)(coal->rx_max_coalesced_frames_high /
+		     COALESCE_PENDING_LIMIT_UNIT);
+
+	intr_coal.pkt_rate_low = coal->pkt_rate_low;
+	intr_coal.rx_usecs_low =
+		(u8)(coal->rx_coalesce_usecs_low / COALESCE_TIMER_CFG_UNIT);
+	intr_coal.rx_pending_limt_low =
+		(u8)(coal->rx_max_coalesced_frames_low /
+		     COALESCE_PENDING_LIMIT_UNIT);
+
+	/* coalesce timer or pending set to zero will disable coalesce */
+	if (!nic_dev->adaptive_rx_coal &&
+	    (!intr_coal.coalesce_timer_cfg || !intr_coal.pending_limt))
+		netdev_warn(netdev, "Coalesce will be disabled\n");
+
+	/* ensure coalesce parameter will not be changed in auto moderation work */
+	if (HINIC3_CHANNEL_RES_VALID(nic_dev)) {
+		if (!nic_dev->adaptive_rx_coal)
+			cancel_delayed_work_sync(&nic_dev->moderation_task);
+		else if (!last_adaptive_rx)
+			queue_delayed_work(nic_dev->workq,
+					   &nic_dev->moderation_task,
+					   HINIC3_MODERATONE_DELAY);
+	}
+
+	return set_hw_coal_param(netdev, &intr_coal, queue);
+}
+
+static int hinic3_get_coalesce(struct net_device *netdev,
+			       struct ethtool_coalesce *coal,
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
+{
+	return get_coalesce(netdev, coal, COALESCE_ALL_QUEUE);
+}
+
+static int hinic3_set_coalesce(struct net_device *netdev,
+			       struct ethtool_coalesce *coal,
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
+{
+	return set_coalesce(netdev, coal, COALESCE_ALL_QUEUE);
+}
+
+static const struct ethtool_ops hinic3_ethtool_ops = {
+	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
+					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
+	.get_link_ksettings             = hinic3_get_link_ksettings,
+	.get_drvinfo                    = hinic3_get_drvinfo,
+	.get_msglevel                   = hinic3_get_msglevel,
+	.set_msglevel                   = hinic3_set_msglevel,
+	.get_link                       = ethtool_op_get_link,
+	.get_ringparam                  = hinic3_get_ringparam,
+	.set_ringparam                  = hinic3_set_ringparam,
+	.get_sset_count                 = hinic3_get_sset_count,
+	.get_ethtool_stats              = hinic3_get_ethtool_stats,
+	.get_strings                    = hinic3_get_strings,
+	.get_coalesce                   = hinic3_get_coalesce,
+	.set_coalesce                   = hinic3_set_coalesce,
+	.get_rxnfc                      = hinic3_get_rxnfc,
+	.set_rxnfc                      = hinic3_set_rxnfc,
+	.get_channels                   = hinic3_get_channels,
+	.set_channels                   = hinic3_set_channels,
+	.get_rxfh_indir_size            = hinic3_get_rxfh_indir_size,
+	.get_rxfh_key_size              = hinic3_get_rxfh_key_size,
+	.get_rxfh                       = hinic3_get_rxfh,
+	.set_rxfh                       = hinic3_set_rxfh,
+};
+
+void hinic3_set_ethtool_ops(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &hinic3_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_filter.c b/drivers/net/ethernet/huawei/hinic3/hinic3_filter.c
new file mode 100644
index 000000000000..c25cfa93de5c
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_filter.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include "hinic3_hwif.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_cfg.h"
+
+static int hinic3_uc_sync(struct net_device *netdev, u8 *addr)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	return hinic3_set_mac(nic_dev->hwdev, addr, 0, hinic3_global_func_id(nic_dev->hwdev));
+}
+
+static int hinic3_uc_unsync(struct net_device *netdev, u8 *addr)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	/* The addr is in use */
+	if (ether_addr_equal(addr, netdev->dev_addr))
+		return 0;
+
+	return hinic3_del_mac(nic_dev->hwdev, addr, 0, hinic3_global_func_id(nic_dev->hwdev));
+}
+
+void hinic3_clean_mac_list_filter(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *f;
+
+	list_for_each_entry_safe(f, ftmp, &nic_dev->uc_filter_list, list) {
+		if (f->state == HINIC3_MAC_HW_SYNCED)
+			hinic3_uc_unsync(netdev, f->addr);
+		list_del(&f->list);
+		kfree(f);
+	}
+
+	list_for_each_entry_safe(f, ftmp, &nic_dev->mc_filter_list, list) {
+		if (f->state == HINIC3_MAC_HW_SYNCED)
+			hinic3_uc_unsync(netdev, f->addr);
+		list_del(&f->list);
+		kfree(f);
+	}
+}
+
+static struct hinic3_mac_filter *hinic3_find_mac(const struct list_head *filter_list,
+						 u8 *addr)
+{
+	struct hinic3_mac_filter *f;
+
+	list_for_each_entry(f, filter_list, list) {
+		if (ether_addr_equal(addr, f->addr))
+			return f;
+	}
+	return NULL;
+}
+
+static struct hinic3_mac_filter *hinic3_add_filter(struct net_device *netdev,
+						   struct list_head *mac_filter_list,
+						   u8 *addr)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_mac_filter *f;
+
+	f = kzalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f)
+		goto out;
+
+	ether_addr_copy(f->addr, addr);
+
+	INIT_LIST_HEAD(&f->list);
+	list_add_tail(&f->list, mac_filter_list);
+
+	f->state = HINIC3_MAC_WAIT_HW_SYNC;
+	set_bit(HINIC3_MAC_FILTER_CHANGED, &nic_dev->flags);
+
+out:
+	return f;
+}
+
+static void hinic3_del_filter(struct net_device *netdev,
+			      struct hinic3_mac_filter *f)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	set_bit(HINIC3_MAC_FILTER_CHANGED, &nic_dev->flags);
+
+	if (f->state == HINIC3_MAC_WAIT_HW_SYNC) {
+		/* have not added to hw, delete it directly */
+		list_del(&f->list);
+		kfree(f);
+		return;
+	}
+
+	f->state = HINIC3_MAC_WAIT_HW_UNSYNC;
+}
+
+static struct hinic3_mac_filter *hinic3_mac_filter_entry_clone(const struct hinic3_mac_filter *src)
+{
+	struct hinic3_mac_filter *f;
+
+	f = kzalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f)
+		return NULL;
+
+	*f = *src;
+	INIT_LIST_HEAD(&f->list);
+
+	return f;
+}
+
+static void hinic3_undo_del_filter_entries(struct list_head *filter_list,
+					   const struct list_head *from)
+{
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *f;
+
+	list_for_each_entry_safe(f, ftmp, from, list) {
+		if (hinic3_find_mac(filter_list, f->addr))
+			continue;
+
+		if (f->state == HINIC3_MAC_HW_SYNCED)
+			f->state = HINIC3_MAC_WAIT_HW_UNSYNC;
+
+		list_move_tail(&f->list, filter_list);
+	}
+}
+
+static void hinic3_undo_add_filter_entries(struct list_head *filter_list,
+					   const struct list_head *from)
+{
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *tmp;
+	struct hinic3_mac_filter *f;
+
+	list_for_each_entry_safe(f, ftmp, from, list) {
+		tmp = hinic3_find_mac(filter_list, f->addr);
+		if (tmp && tmp->state == HINIC3_MAC_HW_SYNCED)
+			tmp->state = HINIC3_MAC_WAIT_HW_SYNC;
+	}
+}
+
+static void hinic3_cleanup_filter_list(const struct list_head *head)
+{
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *f;
+
+	list_for_each_entry_safe(f, ftmp, head, list) {
+		list_del(&f->list);
+		kfree(f);
+	}
+}
+
+static int hinic3_mac_filter_sync_hw(struct net_device *netdev,
+				     struct list_head *del_list,
+				     struct list_head *add_list)
+{
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *f;
+	int err, add_count = 0;
+
+	if (!list_empty(del_list)) {
+		list_for_each_entry_safe(f, ftmp, del_list, list) {
+			/* ignore errors when deleting mac */
+			hinic3_uc_unsync(netdev, f->addr);
+			list_del(&f->list);
+			kfree(f);
+		}
+	}
+
+	if (!list_empty(add_list)) {
+		list_for_each_entry_safe(f, ftmp, add_list, list) {
+			err = hinic3_uc_sync(netdev, f->addr);
+			if (err) {
+				netdev_err(netdev, "Failed to add mac\n");
+				return err;
+			}
+
+			add_count++;
+			list_del(&f->list);
+			kfree(f);
+		}
+	}
+
+	return add_count;
+}
+
+static int hinic3_mac_filter_sync(struct net_device *netdev,
+				  struct list_head *mac_filter_list, bool uc)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct list_head tmp_del_list, tmp_add_list;
+	struct hinic3_mac_filter *fclone;
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *f;
+	int err = 0, add_count;
+
+	INIT_LIST_HEAD(&tmp_del_list);
+	INIT_LIST_HEAD(&tmp_add_list);
+
+	list_for_each_entry_safe(f, ftmp, mac_filter_list, list) {
+		if (f->state != HINIC3_MAC_WAIT_HW_UNSYNC)
+			continue;
+
+		f->state = HINIC3_MAC_HW_UNSYNCED;
+		list_move_tail(&f->list, &tmp_del_list);
+	}
+
+	list_for_each_entry_safe(f, ftmp, mac_filter_list, list) {
+		if (f->state != HINIC3_MAC_WAIT_HW_SYNC)
+			continue;
+
+		fclone = hinic3_mac_filter_entry_clone(f);
+		if (!fclone) {
+			err = -ENOMEM;
+			break;
+		}
+
+		f->state = HINIC3_MAC_HW_SYNCED;
+		list_add_tail(&fclone->list, &tmp_add_list);
+	}
+
+	if (err) {
+		hinic3_undo_del_filter_entries(mac_filter_list, &tmp_del_list);
+		hinic3_undo_add_filter_entries(mac_filter_list, &tmp_add_list);
+		netdev_err(netdev, "Failed to clone mac_filter_entry\n");
+
+		hinic3_cleanup_filter_list(&tmp_del_list);
+		hinic3_cleanup_filter_list(&tmp_add_list);
+		return -ENOMEM;
+	}
+
+	add_count = hinic3_mac_filter_sync_hw(netdev, &tmp_del_list,
+					      &tmp_add_list);
+	if (list_empty(&tmp_add_list))
+		return add_count;
+
+	/* there were errors, delete all mac in hw */
+	hinic3_undo_add_filter_entries(mac_filter_list, &tmp_add_list);
+	/* VF does not support promiscuous mode, don't delete any other uc mac */
+	if (!HINIC3_IS_VF(nic_dev->hwdev) || !uc) {
+		list_for_each_entry_safe(f, ftmp, mac_filter_list, list) {
+			if (f->state != HINIC3_MAC_HW_SYNCED)
+				continue;
+
+			fclone = hinic3_mac_filter_entry_clone(f);
+			if (!fclone)
+				break;
+
+			f->state = HINIC3_MAC_WAIT_HW_SYNC;
+			list_add_tail(&fclone->list, &tmp_del_list);
+		}
+	}
+
+	hinic3_cleanup_filter_list(&tmp_add_list);
+	hinic3_mac_filter_sync_hw(netdev, &tmp_del_list, &tmp_add_list);
+
+	/* need to enter promiscuous/allmulti mode */
+	return -ENOMEM;
+}
+
+static void hinic3_mac_filter_sync_all(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int add_count;
+
+	if (test_bit(HINIC3_MAC_FILTER_CHANGED, &nic_dev->flags)) {
+		clear_bit(HINIC3_MAC_FILTER_CHANGED, &nic_dev->flags);
+		add_count = hinic3_mac_filter_sync(netdev, &nic_dev->uc_filter_list, true);
+		if (add_count < 0 && hinic3_test_support(nic_dev, NIC_F_PROMISC))
+			set_bit(HINIC3_PROMISC_FORCE_ON, &nic_dev->rx_mod_state);
+		else if (add_count)
+			clear_bit(HINIC3_PROMISC_FORCE_ON, &nic_dev->rx_mod_state);
+
+		add_count = hinic3_mac_filter_sync(netdev, &nic_dev->mc_filter_list, false);
+		if (add_count < 0 && hinic3_test_support(nic_dev, NIC_F_ALLMULTI))
+			set_bit(HINIC3_ALLMULTI_FORCE_ON, &nic_dev->rx_mod_state);
+		else if (add_count)
+			clear_bit(HINIC3_ALLMULTI_FORCE_ON, &nic_dev->rx_mod_state);
+	}
+}
+
+#define HINIC3_DEFAULT_RX_MODE \
+	(NIC_RX_MODE_UC | NIC_RX_MODE_MC | NIC_RX_MODE_BC)
+
+static void hinic3_update_mac_filter(struct net_device *netdev,
+				     const struct netdev_hw_addr_list *src_list,
+				     struct list_head *filter_list)
+{
+	struct hinic3_mac_filter *filter;
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *f;
+	struct netdev_hw_addr *ha;
+
+	/* add addr if not already in the filter list */
+	netif_addr_lock_bh(netdev);
+	netdev_hw_addr_list_for_each(ha, src_list) {
+		filter = hinic3_find_mac(filter_list, ha->addr);
+		if (!filter)
+			hinic3_add_filter(netdev, filter_list, ha->addr);
+		else if (filter->state == HINIC3_MAC_WAIT_HW_UNSYNC)
+			filter->state = HINIC3_MAC_HW_SYNCED;
+	}
+	netif_addr_unlock_bh(netdev);
+
+	/* delete addr if not in netdev list */
+	list_for_each_entry_safe(f, ftmp, filter_list, list) {
+		bool found = false;
+
+		netif_addr_lock_bh(netdev);
+		netdev_hw_addr_list_for_each(ha, src_list)
+			if (ether_addr_equal(ha->addr, f->addr)) {
+				found = true;
+				break;
+			}
+		netif_addr_unlock_bh(netdev);
+
+		if (found)
+			continue;
+
+		hinic3_del_filter(netdev, f);
+	}
+}
+
+static void update_mac_filter(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	if (test_and_clear_bit(HINIC3_UPDATE_MAC_FILTER, &nic_dev->flags)) {
+		hinic3_update_mac_filter(netdev, &netdev->uc,
+					 &nic_dev->uc_filter_list);
+		hinic3_update_mac_filter(netdev, &netdev->mc,
+					 &nic_dev->mc_filter_list);
+	}
+}
+
+static void sync_rx_mode_to_hw(struct net_device *netdev, int promisc_en,
+			       int allmulti_en)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u32 rx_mod = HINIC3_DEFAULT_RX_MODE;
+	int err;
+
+	rx_mod |= (promisc_en ? NIC_RX_MODE_PROMISC : 0);
+	rx_mod |= (allmulti_en ? NIC_RX_MODE_MC_ALL : 0);
+
+	if (promisc_en != test_bit(HINIC3_HW_PROMISC_ON, &nic_dev->rx_mod_state))
+		netdev_dbg(netdev, "%s promisc mode\n", promisc_en ? "Enter" : "Left");
+	if (allmulti_en !=
+	    test_bit(HINIC3_HW_ALLMULTI_ON, &nic_dev->rx_mod_state))
+		netdev_dbg(netdev, "%s all_multi mode\n", allmulti_en ? "Enter" : "Left");
+
+	err = hinic3_set_rx_mode(nic_dev->hwdev, rx_mod);
+	if (err) {
+		netdev_err(netdev, "Failed to set rx_mode\n");
+		return;
+	}
+
+	promisc_en ? set_bit(HINIC3_HW_PROMISC_ON, &nic_dev->rx_mod_state) :
+		clear_bit(HINIC3_HW_PROMISC_ON, &nic_dev->rx_mod_state);
+
+	allmulti_en ? set_bit(HINIC3_HW_ALLMULTI_ON, &nic_dev->rx_mod_state) :
+		clear_bit(HINIC3_HW_ALLMULTI_ON, &nic_dev->rx_mod_state);
+}
+
+void hinic3_set_rx_mode_work(struct work_struct *work)
+{
+	int promisc_en = 0, allmulti_en = 0;
+	struct hinic3_nic_dev *nic_dev;
+	struct net_device *netdev;
+
+	nic_dev = container_of(work, struct hinic3_nic_dev, rx_mode_work);
+	netdev = nic_dev->netdev;
+
+	update_mac_filter(netdev);
+
+	hinic3_mac_filter_sync_all(netdev);
+
+	if (hinic3_test_support(nic_dev, NIC_F_PROMISC))
+		promisc_en = !!(netdev->flags & IFF_PROMISC) ||
+			test_bit(HINIC3_PROMISC_FORCE_ON,
+				 &nic_dev->rx_mod_state);
+
+	if (hinic3_test_support(nic_dev, NIC_F_ALLMULTI))
+		allmulti_en = !!(netdev->flags & IFF_ALLMULTI) ||
+			test_bit(HINIC3_ALLMULTI_FORCE_ON,
+				 &nic_dev->rx_mod_state);
+
+	if (promisc_en !=
+	    test_bit(HINIC3_HW_PROMISC_ON, &nic_dev->rx_mod_state) ||
+	    allmulti_en !=
+	    test_bit(HINIC3_HW_ALLMULTI_ON, &nic_dev->rx_mod_state))
+		sync_rx_mode_to_hw(netdev, promisc_en, allmulti_en);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
new file mode 100644
index 000000000000..6bc3c5c781e7
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/semaphore.h>
+
+#include "hinic3_common.h"
+#include "hinic3_hw_intf.h"
+#include "hinic3_hwif.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_hw_cfg.h"
+
+enum {
+	CFG_FREE = 0,
+	CFG_BUSY = 1,
+};
+
+#define HINIC3_CFG_MAX_QP  256
+#define VECTOR_THRESHOLD   2
+
+#define CFG_SERVICE_MASK_NIC  (0x1 << SERVICE_T_NIC)
+#define IS_NIC_TYPE(hwdev) \
+	(((u32)(hwdev)->cfg_mgmt->svc_cap.chip_svc_type) & CFG_SERVICE_MASK_NIC)
+
+static void parse_pub_res_cap(struct hinic3_hwdev *hwdev,
+			      struct service_cap *cap,
+			      const struct cfg_cmd_dev_cap *dev_cap,
+			      enum func_type type)
+{
+	cap->port_id = dev_cap->port_id;
+
+	cap->chip_svc_type = dev_cap->svc_cap_en;
+
+	cap->cos_valid_bitmap = dev_cap->valid_cos_bitmap;
+	cap->port_cos_valid_bitmap = dev_cap->port_cos_valid_bitmap;
+
+	if (type != TYPE_VF)
+		cap->max_vf = dev_cap->max_vf;
+	else
+		cap->max_vf = 0;
+
+	dev_dbg(hwdev->dev, "Port_id: 0x%x, cos_bitmap: 0x%x, Max_vf: 0x%x\n",
+		cap->port_id, cap->cos_valid_bitmap, cap->max_vf);
+}
+
+static void parse_l2nic_res_cap(struct hinic3_hwdev *hwdev,
+				struct service_cap *cap,
+				const struct cfg_cmd_dev_cap *dev_cap,
+				enum func_type type)
+{
+	struct nic_service_cap *nic_cap = &cap->nic_cap;
+
+	nic_cap->max_sqs = dev_cap->nic_max_sq_id + 1;
+	nic_cap->max_rqs = dev_cap->nic_max_rq_id + 1;
+	nic_cap->default_num_queues = dev_cap->nic_default_num_queues;
+
+	dev_dbg(hwdev->dev, "L2nic resource capbility, max_sqs: 0x%x, max_rqs: 0x%x\n",
+		nic_cap->max_sqs, nic_cap->max_rqs);
+
+	/* Check parameters from firmware */
+	if (nic_cap->max_sqs > HINIC3_CFG_MAX_QP ||
+	    nic_cap->max_rqs > HINIC3_CFG_MAX_QP) {
+		dev_dbg(hwdev->dev, "Number of qp exceeds limit[1-%d]: sq: %u, rq: %u\n",
+			HINIC3_CFG_MAX_QP, nic_cap->max_sqs, nic_cap->max_rqs);
+		nic_cap->max_sqs = HINIC3_CFG_MAX_QP;
+		nic_cap->max_rqs = HINIC3_CFG_MAX_QP;
+	}
+}
+
+static void parse_dev_cap(struct hinic3_hwdev *hwdev,
+			  const struct cfg_cmd_dev_cap *dev_cap, enum func_type type)
+{
+	struct service_cap *cap = &hwdev->cfg_mgmt->svc_cap;
+
+	/* Public resource */
+	parse_pub_res_cap(hwdev, cap, dev_cap, type);
+
+	/* L2 NIC resource */
+	if (IS_NIC_TYPE(hwdev))
+		parse_l2nic_res_cap(hwdev, cap, dev_cap, type);
+}
+
+static int get_cap_from_fw(struct hinic3_hwdev *hwdev, enum func_type type)
+{
+	struct cfg_cmd_dev_cap dev_cap;
+	u32 out_len = sizeof(dev_cap);
+	int err;
+
+	memset(&dev_cap, 0, sizeof(dev_cap));
+	dev_cap.func_id = hinic3_global_func_id(hwdev);
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_CFGM, CFG_CMD_GET_DEV_CAP,
+				      &dev_cap, sizeof(dev_cap),
+				      &dev_cap, &out_len, 0);
+	if (err || dev_cap.head.status || !out_len) {
+		dev_err(hwdev->dev,
+			"Failed to get capability from FW, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, dev_cap.head.status, out_len);
+		return -EIO;
+	}
+
+	parse_dev_cap(hwdev, &dev_cap, type);
+
+	return 0;
+}
+
+static int hinic3_get_dev_cap(struct hinic3_hwdev *hwdev)
+{
+	enum func_type type = HINIC3_FUNC_TYPE(hwdev);
+	int err;
+
+	switch (type) {
+	case TYPE_PF:
+	case TYPE_VF:
+		err = get_cap_from_fw(hwdev, type);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to get PF capability\n");
+			return err;
+		}
+		break;
+	default:
+		dev_err(hwdev->dev, "Unsupported PCI Function type: %d\n",
+			type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void hinic3_init_ceq_info(struct hinic3_hwdev *hwdev)
+{
+	struct cfg_ceq_info *ceq_info = &hwdev->cfg_mgmt->ceq_info;
+
+	ceq_info->num_ceq = hwdev->hwif->attr.num_ceqs;
+	ceq_info->num_ceq_remain = ceq_info->num_ceq;
+}
+
+static int hinic3_init_cfg_ceq(struct hinic3_hwdev *hwdev)
+{
+	struct cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+	struct cfg_ceq *ceq;
+	u8 num_ceq, i;
+
+	hinic3_init_ceq_info(hwdev);
+	num_ceq = cfg_mgmt->ceq_info.num_ceq;
+
+	dev_dbg(hwdev->dev, "Cfg mgmt: ceqs=0x%x, remain=0x%x\n",
+		cfg_mgmt->ceq_info.num_ceq, cfg_mgmt->ceq_info.num_ceq_remain);
+
+	if (!num_ceq) {
+		dev_err(hwdev->dev, "Ceq num cfg in fw is zero\n");
+		return -EFAULT;
+	}
+
+	ceq = kcalloc(num_ceq, sizeof(*ceq), GFP_KERNEL);
+	if (!ceq)
+		return -ENOMEM;
+
+	for (i = 0; i < num_ceq; ++i) {
+		ceq[i].eqn = i;
+		ceq[i].free = CFG_FREE;
+		ceq[i].type = SERVICE_T_MAX;
+	}
+
+	cfg_mgmt->ceq_info.ceq = ceq;
+
+	return 0;
+}
+
+static int hinic3_init_irq_info(struct hinic3_hwdev *hwdev)
+{
+	struct cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+	struct hinic3_hwif *hwif = hwdev->hwif;
+	u16 intr_num = hwif->attr.num_irqs;
+	struct cfg_irq_info *irq_info;
+	u16 intr_needed;
+
+	if (!intr_num) {
+		dev_err(hwdev->dev, "Irq num cfg in fw is zero, msix_flex_en %d\n",
+			hwif->attr.msix_flex_en);
+		return -EFAULT;
+	}
+
+	intr_needed = hwif->attr.msix_flex_en ? (hwif->attr.num_aeqs +
+		      hwif->attr.num_ceqs + hwif->attr.num_sq) : intr_num;
+	if (intr_needed > intr_num) {
+		dev_warn(hwdev->dev, "Irq num cfg %d is less than the needed irq num %d msix_flex_en %d\n",
+			 intr_num, intr_needed, hwdev->hwif->attr.msix_flex_en);
+		intr_needed = intr_num;
+	}
+
+	irq_info = &cfg_mgmt->irq_info;
+	irq_info->alloc_info = kcalloc(intr_num, sizeof(*irq_info->alloc_info),
+				       GFP_KERNEL);
+	if (!irq_info->alloc_info)
+		return -ENOMEM;
+
+	irq_info->num_irq_hw = intr_needed;
+	if (HINIC3_FUNC_TYPE(hwdev) == TYPE_VF)
+		irq_info->interrupt_type = INTR_TYPE_MSIX;
+	else
+		irq_info->interrupt_type = 0;
+
+	mutex_init(&irq_info->irq_mutex);
+
+	return 0;
+}
+
+static int hinic3_init_irq_alloc_info(struct hinic3_hwdev *hwdev)
+{
+	struct cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+	struct cfg_irq_alloc_info *irq_alloc_info;
+	u16 nreq = cfg_mgmt->irq_info.num_irq_hw;
+	struct pci_dev *pdev = hwdev->pdev;
+	struct msix_entry *entry;
+	int actual_irq;
+	u16 i;
+
+	irq_alloc_info = cfg_mgmt->irq_info.alloc_info;
+
+	switch (cfg_mgmt->irq_info.interrupt_type) {
+	case INTR_TYPE_MSIX:
+		if (!nreq) {
+			dev_err(hwdev->dev, "Number of interrupts must not be zero\n");
+			return -EINVAL;
+		}
+		entry = kcalloc(nreq, sizeof(*entry), GFP_KERNEL);
+		if (!entry)
+			return -ENOMEM;
+
+		for (i = 0; i < nreq; i++)
+			entry[i].entry = i;
+
+		actual_irq = pci_enable_msix_range(pdev, entry,
+						   VECTOR_THRESHOLD, nreq);
+		if (actual_irq < 0) {
+			dev_err(hwdev->dev, "Alloc msix entries with threshold 2 failed. actual_irq: %d\n",
+				actual_irq);
+			kfree(entry);
+			return -ENOMEM;
+		}
+
+		nreq = (u16)actual_irq;
+		cfg_mgmt->irq_info.num_total = nreq;
+		cfg_mgmt->irq_info.num_irq_remain = nreq;
+
+		for (i = 0; i < nreq; ++i) {
+			irq_alloc_info[i].info.msix_entry_idx = entry[i].entry;
+			irq_alloc_info[i].info.irq_id = entry[i].vector;
+			irq_alloc_info[i].type = SERVICE_T_MAX;
+			irq_alloc_info[i].free = CFG_FREE;
+		}
+
+		kfree(entry);
+
+		break;
+
+	default:
+		dev_err(hwdev->dev, "Unsupported interrupt type %d\n",
+			cfg_mgmt->irq_info.interrupt_type);
+		break;
+	}
+
+	return 0;
+}
+
+int hinic3_init_cfg_mgmt(struct hinic3_hwdev *hwdev)
+{
+	struct cfg_mgmt_info *cfg_mgmt;
+	int err;
+
+	cfg_mgmt = kzalloc(sizeof(*cfg_mgmt), GFP_KERNEL);
+	if (!cfg_mgmt)
+		return -ENOMEM;
+
+	cfg_mgmt->hwdev = hwdev;
+	hwdev->cfg_mgmt = cfg_mgmt;
+
+	err = hinic3_init_cfg_ceq(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init cfg_ceq, err: %d\n",
+			err);
+		goto free_mgmt_mem;
+	}
+
+	err = hinic3_init_irq_info(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init cfg_irq_info, err: %d\n",
+			err);
+		goto free_eq_mem;
+	}
+
+	err = hinic3_init_irq_alloc_info(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init irq_alloc_info, err: %d\n",
+			err);
+		goto free_interrupt_mem;
+	}
+
+	return 0;
+
+free_interrupt_mem:
+	kfree(cfg_mgmt->irq_info.alloc_info);
+	cfg_mgmt->irq_info.alloc_info = NULL;
+
+free_eq_mem:
+	kfree(cfg_mgmt->ceq_info.ceq);
+	cfg_mgmt->ceq_info.ceq = NULL;
+
+free_mgmt_mem:
+	kfree(cfg_mgmt);
+	return err;
+}
+
+void hinic3_free_cfg_mgmt(struct hinic3_hwdev *hwdev)
+{
+	struct cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+
+	/* if the allocated resources were recycled */
+	if (cfg_mgmt->irq_info.num_irq_remain !=
+	    cfg_mgmt->irq_info.num_total ||
+	    cfg_mgmt->ceq_info.num_ceq_remain != cfg_mgmt->ceq_info.num_ceq)
+		dev_err(hwdev->dev, "Can't reclaim all irq and event queue\n");
+
+	switch (cfg_mgmt->irq_info.interrupt_type) {
+	case INTR_TYPE_MSIX:
+		pci_disable_msix(hwdev->pdev);
+		break;
+
+	case INTR_TYPE_MSI:
+		pci_disable_msi(hwdev->pdev);
+		break;
+
+	case INTR_TYPE_INT:
+	default:
+		break;
+	}
+
+	kfree(cfg_mgmt->irq_info.alloc_info);
+	cfg_mgmt->irq_info.alloc_info = NULL;
+
+	kfree(cfg_mgmt->ceq_info.ceq);
+	cfg_mgmt->ceq_info.ceq = NULL;
+	kfree(cfg_mgmt);
+}
+
+int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, enum hinic3_service_type type, u16 num,
+		      struct irq_info *irq_info_array, u16 *act_num)
+{
+	struct cfg_irq_alloc_info *alloc_info;
+	struct cfg_mgmt_info *cfg_mgmt;
+	struct cfg_irq_info *irq_info;
+	u16 num_new = num;
+	u16 free_num_irq;
+	int max_num_irq;
+	int i, j;
+
+	cfg_mgmt = hwdev->cfg_mgmt;
+	irq_info = &cfg_mgmt->irq_info;
+	alloc_info = irq_info->alloc_info;
+	max_num_irq = irq_info->num_total;
+	free_num_irq = irq_info->num_irq_remain;
+
+	mutex_lock(&irq_info->irq_mutex);
+
+	if (num > free_num_irq) {
+		if (free_num_irq == 0) {
+			dev_err(hwdev->dev, "no free irq resource in cfg mgmt.\n");
+			mutex_unlock(&irq_info->irq_mutex);
+			return -ENOMEM;
+		}
+
+		dev_warn(hwdev->dev, "only %u irq resource in cfg mgmt.\n", free_num_irq);
+		num_new = free_num_irq;
+	}
+
+	*act_num = 0;
+
+	for (i = 0; i < num_new; i++) {
+		for (j = 0; j < max_num_irq; j++) {
+			if (alloc_info[j].free == CFG_FREE) {
+				if (irq_info->num_irq_remain == 0) {
+					dev_err(hwdev->dev, "No free irq resource in cfg mgmt\n");
+					mutex_unlock(&irq_info->irq_mutex);
+					return -EINVAL;
+				}
+				alloc_info[j].type = type;
+				alloc_info[j].free = CFG_BUSY;
+
+				irq_info_array[i].msix_entry_idx =
+					alloc_info[j].info.msix_entry_idx;
+				irq_info_array[i].irq_id = alloc_info[j].info.irq_id;
+				(*act_num)++;
+				irq_info->num_irq_remain--;
+
+				break;
+			}
+		}
+	}
+
+	mutex_unlock(&irq_info->irq_mutex);
+	return 0;
+}
+
+void hinic3_free_irq(struct hinic3_hwdev *hwdev, enum hinic3_service_type type, u32 irq_id)
+{
+	struct cfg_irq_alloc_info *alloc_info;
+	struct cfg_mgmt_info *cfg_mgmt;
+	struct cfg_irq_info *irq_info;
+	int max_num_irq;
+	int i;
+
+	cfg_mgmt = hwdev->cfg_mgmt;
+	irq_info = &cfg_mgmt->irq_info;
+	alloc_info = irq_info->alloc_info;
+	max_num_irq = irq_info->num_total;
+
+	mutex_lock(&irq_info->irq_mutex);
+
+	for (i = 0; i < max_num_irq; i++) {
+		if (irq_id == alloc_info[i].info.irq_id &&
+		    type == alloc_info[i].type) {
+			if (alloc_info[i].free == CFG_BUSY) {
+				alloc_info[i].free = CFG_FREE;
+				irq_info->num_irq_remain++;
+				if (irq_info->num_irq_remain > max_num_irq) {
+					dev_err(hwdev->dev, "Find target,but over range\n");
+					mutex_unlock(&irq_info->irq_mutex);
+					return;
+				}
+				break;
+			}
+		}
+	}
+
+	if (i >= max_num_irq)
+		dev_warn(hwdev->dev, "Irq %u doesn't need to be freed\n", irq_id);
+
+	mutex_unlock(&irq_info->irq_mutex);
+}
+
+int init_capability(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = hinic3_get_dev_cap(hwdev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
+{
+	if (!IS_NIC_TYPE(hwdev))
+		return false;
+
+	return true;
+}
+
+u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev)
+{
+	return hwdev->cfg_mgmt->svc_cap.nic_cap.max_sqs;
+}
+
+u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev)
+{
+	return hwdev->cfg_mgmt->svc_cap.port_id;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
new file mode 100644
index 000000000000..51c64427b3d6
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_HW_CFG_H
+#define HINIC3_HW_CFG_H
+
+#include <linux/types.h>
+#include <linux/mutex.h>
+
+#include "hinic3_hw_intf.h"
+
+struct hinic3_hwdev;
+
+enum intr_type {
+	INTR_TYPE_MSIX,
+	INTR_TYPE_MSI,
+	INTR_TYPE_INT,
+	INTR_TYPE_NONE,
+};
+
+struct cfg_ceq {
+	enum hinic3_service_type type;
+	int                      eqn;
+	/* 1 - allocated, 0- freed */
+	int                      free;
+};
+
+struct cfg_ceq_info {
+	struct cfg_ceq *ceq;
+	u8             num_ceq;
+	u8             num_ceq_remain;
+};
+
+struct irq_info {
+	u16 msix_entry_idx;
+	/* provided by OS */
+	u32 irq_id;
+};
+
+struct cfg_irq_alloc_info {
+	enum hinic3_service_type type;
+	/* 1 - allocated, 0- freed */
+	int                      free;
+	struct irq_info          info;
+};
+
+struct cfg_irq_info {
+	struct cfg_irq_alloc_info *alloc_info;
+	enum intr_type            interrupt_type;
+	u16                       num_total;
+	u16                       num_irq_remain;
+	/* device max irq number */
+	u16                       num_irq_hw;
+
+	/* protect irq alloc and free */
+	struct mutex              irq_mutex;
+};
+
+struct nic_service_cap {
+	u16 max_sqs;
+	u16 max_rqs;
+	u16 default_num_queues;
+};
+
+/* device capability */
+struct service_cap {
+	/* HW supported service type, reference to service_bit_define */
+	u16                    chip_svc_type;
+	/* PF/VF's physical port */
+	u8                     port_id;
+
+	u8                     cos_valid_bitmap;
+	u8                     port_cos_valid_bitmap;
+	/* max number of VFs that PF supports */
+	u16                    max_vf;
+
+	/* NIC capability */
+	struct nic_service_cap nic_cap;
+};
+
+struct cfg_mgmt_info {
+	struct hinic3_hwdev *hwdev;
+	/* Completion event queue (ceq) */
+	struct cfg_ceq_info ceq_info;
+	/* interrupt queue (irq) */
+	struct cfg_irq_info irq_info;
+	struct service_cap  svc_cap;
+};
+
+int hinic3_init_cfg_mgmt(struct hinic3_hwdev *hwdev);
+void hinic3_free_cfg_mgmt(struct hinic3_hwdev *hwdev);
+
+int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, enum hinic3_service_type type, u16 num,
+		      struct irq_info *irq_info_array, u16 *act_num);
+void hinic3_free_irq(struct hinic3_hwdev *hwdev, enum hinic3_service_type type, u32 irq_id);
+
+int init_capability(struct hinic3_hwdev *hwdev);
+bool hinic3_support_nic(struct hinic3_hwdev *hwdev);
+u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev);
+u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
new file mode 100644
index 000000000000..7e8c41dd1daa
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -0,0 +1,632 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/msi.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/semaphore.h>
+#include <linux/interrupt.h>
+
+#include "hinic3_hwif.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_hw_intf.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_cmdq.h"
+#include "hinic3_hw_comm.h"
+
+static int comm_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd, const void *buf_in,
+				 u32 in_size, void *buf_out, u32 *out_size)
+{
+	return hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM, cmd, buf_in,
+				       in_size, buf_out, out_size, 0);
+}
+
+static int hinic3_get_interrupt_cfg(struct hinic3_hwdev *hwdev, struct interrupt_info *info)
+{
+	struct comm_cmd_msix_config msix_cfg;
+	u32 out_size = sizeof(msix_cfg);
+	int err;
+
+	memset(&msix_cfg, 0, sizeof(msix_cfg));
+	msix_cfg.func_id = hinic3_global_func_id(hwdev);
+	msix_cfg.msix_index = info->msix_index;
+	msix_cfg.opcode = MGMT_MSG_CMD_OP_GET;
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_CFG_MSIX_CTRL_REG,
+				    &msix_cfg, sizeof(msix_cfg), &msix_cfg,
+				    &out_size);
+	if (err || !out_size || msix_cfg.head.status) {
+		dev_err(hwdev->dev, "Failed to get interrupt config, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, msix_cfg.head.status, out_size);
+		return -EINVAL;
+	}
+
+	info->lli_credit_limit = msix_cfg.lli_credit_cnt;
+	info->lli_timer_cfg = msix_cfg.lli_timer_cnt;
+	info->pending_limt = msix_cfg.pending_cnt;
+	info->coalesc_timer_cfg = msix_cfg.coalesce_timer_cnt;
+	info->resend_timer_cfg = msix_cfg.resend_timer_cnt;
+
+	return 0;
+}
+
+int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev, struct interrupt_info *info)
+{
+	struct comm_cmd_msix_config msix_cfg;
+	u32 out_size = sizeof(msix_cfg);
+	int err;
+
+	memset(&msix_cfg, 0, sizeof(msix_cfg));
+	msix_cfg.func_id = hinic3_global_func_id(hwdev);
+	msix_cfg.msix_index = info->msix_index;
+	msix_cfg.opcode = MGMT_MSG_CMD_OP_SET;
+
+	msix_cfg.lli_credit_cnt = info->lli_credit_limit;
+	msix_cfg.lli_timer_cnt = info->lli_timer_cfg;
+	msix_cfg.pending_cnt = info->pending_limt;
+	msix_cfg.coalesce_timer_cnt = info->coalesc_timer_cfg;
+	msix_cfg.resend_timer_cnt = info->resend_timer_cfg;
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_CFG_MSIX_CTRL_REG,
+				    &msix_cfg, sizeof(msix_cfg), &msix_cfg,
+				    &out_size);
+	if (err || !out_size || msix_cfg.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set interrupt config, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, msix_cfg.head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int hinic3_set_interrupt_cfg(struct hinic3_hwdev *hwdev, struct interrupt_info info)
+{
+	struct interrupt_info temp_info;
+	int err;
+
+	temp_info.msix_index = info.msix_index;
+
+	err = hinic3_get_interrupt_cfg(hwdev, &temp_info);
+	if (err)
+		return -EINVAL;
+
+	if (!info.lli_set) {
+		info.lli_credit_limit = temp_info.lli_credit_limit;
+		info.lli_timer_cfg = temp_info.lli_timer_cfg;
+	}
+
+	if (!info.interrupt_coalesc_set) {
+		info.pending_limt = temp_info.pending_limt;
+		info.coalesc_timer_cfg = temp_info.coalesc_timer_cfg;
+		info.resend_timer_cfg = temp_info.resend_timer_cfg;
+	}
+
+	return hinic3_set_interrupt_cfg_direct(hwdev, &info);
+}
+
+int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
+{
+	struct comm_cmd_func_reset func_reset;
+	u32 out_size = sizeof(func_reset);
+	int err;
+
+	memset(&func_reset, 0, sizeof(func_reset));
+	func_reset.func_id = func_id;
+	func_reset.reset_flag = reset_flag;
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_FUNC_RESET,
+				    &func_reset, sizeof(func_reset),
+				    &func_reset, &out_size);
+	if (err || !out_size || func_reset.head.status) {
+		dev_err(hwdev->dev, "Failed to reset func resources, reset_flag 0x%llx, err: %d, status: 0x%x, out_size: 0x%x\n",
+			reset_flag, err, func_reset.head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int hinic3_comm_features_nego(struct hinic3_hwdev *hwdev, u8 opcode, u64 *s_feature,
+				     u16 size)
+{
+	struct comm_cmd_feature_nego feature_nego;
+	u32 out_size = sizeof(feature_nego);
+	int err;
+
+	if (!s_feature || size > COMM_MAX_FEATURE_QWORD)
+		return -EINVAL;
+
+	memset(&feature_nego, 0, sizeof(feature_nego));
+	feature_nego.func_id = hinic3_global_func_id(hwdev);
+	feature_nego.opcode = opcode;
+	if (opcode == MGMT_MSG_CMD_OP_SET)
+		memcpy(feature_nego.s_feature, s_feature, (size * sizeof(u64)));
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_FEATURE_NEGO,
+				    &feature_nego, sizeof(feature_nego),
+				    &feature_nego, &out_size);
+	if (err || !out_size || feature_nego.head.status) {
+		dev_err(hwdev->dev, "Failed to negotiate feature, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, feature_nego.head.status, out_size);
+		return -EINVAL;
+	}
+
+	if (opcode == MGMT_MSG_CMD_OP_GET)
+		memcpy(s_feature, feature_nego.s_feature, (size * sizeof(u64)));
+
+	return 0;
+}
+
+int hinic3_get_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature, u16 size)
+{
+	return hinic3_comm_features_nego(hwdev, MGMT_MSG_CMD_OP_GET, s_feature,
+					 size);
+}
+
+int hinic3_set_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature, u16 size)
+{
+	return hinic3_comm_features_nego(hwdev, MGMT_MSG_CMD_OP_SET, s_feature,
+					 size);
+}
+
+int hinic3_get_global_attr(struct hinic3_hwdev *hwdev, struct comm_global_attr *attr)
+{
+	struct comm_cmd_get_glb_attr get_attr;
+	u32 out_size = sizeof(get_attr);
+	int err;
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_GET_GLOBAL_ATTR,
+				    &get_attr, sizeof(get_attr), &get_attr,
+				    &out_size);
+	if (err || !out_size || get_attr.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get global attribute, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, get_attr.head.status, out_size);
+		return -EIO;
+	}
+
+	memcpy(attr, &get_attr.attr, sizeof(*attr));
+
+	return 0;
+}
+
+int hinic3_set_func_svc_used_state(struct hinic3_hwdev *hwdev, u16 svc_type, u8 state)
+{
+	struct comm_cmd_func_svc_used_state used_state;
+	u32 out_size = sizeof(used_state);
+	int err;
+
+	memset(&used_state, 0, sizeof(used_state));
+	used_state.func_id = hinic3_global_func_id(hwdev);
+	used_state.svc_type = svc_type;
+	used_state.used_state = state;
+
+	err = comm_msg_to_mgmt_sync(hwdev,
+				    COMM_MGMT_CMD_SET_FUNC_SVC_USED_STATE,
+				    &used_state, sizeof(used_state),
+				    &used_state, &out_size);
+	if (err || !out_size || used_state.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set func service used state, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, used_state.head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int hinic3_set_dma_attr_tbl(struct hinic3_hwdev *hwdev, u8 entry_idx, u8 st, u8 at, u8 ph,
+			    u8 no_snooping, u8 tph_en)
+{
+	struct comm_cmd_dma_attr_config dma_attr;
+	u32 out_size = sizeof(dma_attr);
+	int err;
+
+	memset(&dma_attr, 0, sizeof(dma_attr));
+	dma_attr.func_id = hinic3_global_func_id(hwdev);
+	dma_attr.entry_idx = entry_idx;
+	dma_attr.st = st;
+	dma_attr.at = at;
+	dma_attr.ph = ph;
+	dma_attr.no_snooping = no_snooping;
+	dma_attr.tph_en = tph_en;
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_SET_DMA_ATTR, &dma_attr, sizeof(dma_attr),
+				    &dma_attr, &out_size);
+	if (err || !out_size || dma_attr.head.status) {
+		dev_err(hwdev->dev, "Failed to set dma attr, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, dma_attr.head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int calc_wq_page_size_shift(u32 page_size, u8 *shift)
+{
+	u32 num_4k_pages, page_size_shift;
+
+	if (page_size < HINIC3_MIN_PAGE_SIZE || !is_power_of_2(page_size))
+		return -EINVAL;
+
+	num_4k_pages = page_size / HINIC3_MIN_PAGE_SIZE;
+	page_size_shift = ilog2(num_4k_pages);
+	if (page_size_shift > HINIC3_MAX_WQ_PAGE_SIZE_ORDER)
+		return -EINVAL;
+
+	*shift = page_size_shift;
+	return 0;
+}
+
+int hinic3_set_wq_page_size(struct hinic3_hwdev *hwdev, u16 func_idx, u32 page_size)
+{
+	struct comm_cmd_wq_page_size page_size_info;
+	u32 out_size = sizeof(page_size_info);
+	u8 shift;
+	int err;
+
+	err = calc_wq_page_size_shift(page_size, &shift);
+	if (err)
+		return err;
+
+	memset(&page_size_info, 0, sizeof(page_size_info));
+	page_size_info.func_id = func_idx;
+	page_size_info.page_size = shift;
+	page_size_info.opcode = MGMT_MSG_CMD_OP_SET;
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_CFG_PAGESIZE,
+				    &page_size_info, sizeof(page_size_info),
+				    &page_size_info, &out_size);
+	if (err || !out_size || page_size_info.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set wq page size, err: %d, status: 0x%x, out_size: 0x%0x\n",
+			err, page_size_info.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, u16 cmdq_depth)
+{
+	struct comm_cmd_root_ctxt root_ctxt;
+	u32 out_size = sizeof(root_ctxt);
+	int err;
+
+	memset(&root_ctxt, 0, sizeof(root_ctxt));
+	root_ctxt.func_id = hinic3_global_func_id(hwdev);
+
+	root_ctxt.set_cmdq_depth = 1;
+	root_ctxt.cmdq_depth = ilog2(cmdq_depth);
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_SET_VAT, &root_ctxt,
+				    sizeof(root_ctxt), &root_ctxt, &out_size);
+	if (err || !out_size || root_ctxt.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set cmdq depth, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, root_ctxt.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+#define HINIC3_FLR_TIMEOUT    1000
+
+static enum hinic3_wait_return check_flr_finish_handler(void *priv_data)
+{
+	struct hinic3_hwif *hwif = priv_data;
+	enum hinic3_pf_status status;
+
+	status = hinic3_get_pf_status(hwif);
+	if (status == HINIC3_PF_STATUS_FLR_FINISH_FLAG) {
+		hinic3_set_pf_status(hwif, HINIC3_PF_STATUS_ACTIVE_FLAG);
+		return WAIT_PROCESS_CPL;
+	}
+
+	return WAIT_PROCESS_WAITING;
+}
+
+static int wait_for_flr_finish(struct hinic3_hwif *hwif)
+{
+	return hinic3_wait_for_timeout(hwif, check_flr_finish_handler,
+				       HINIC3_FLR_TIMEOUT, 0xa * USEC_PER_MSEC);
+}
+
+#define HINIC3_WAIT_CMDQ_IDLE_TIMEOUT    5000
+
+static enum hinic3_wait_return check_cmdq_stop_handler(void *priv_data)
+{
+	struct hinic3_hwdev *hwdev = priv_data;
+	enum hinic3_cmdq_type cmdq_type;
+	struct hinic3_cmdqs *cmdqs;
+
+	/* Stop waiting when card unpresent */
+	if (!hwdev->chip_present_flag)
+		return WAIT_PROCESS_CPL;
+
+	cmdqs = hwdev->cmdqs;
+	cmdq_type = HINIC3_CMDQ_SYNC;
+	for (; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		if (!hinic3_cmdq_idle(&cmdqs->cmdq[cmdq_type]))
+			return WAIT_PROCESS_WAITING;
+	}
+
+	return WAIT_PROCESS_CPL;
+}
+
+static int wait_cmdq_stop(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	enum hinic3_cmdq_type cmdq_type;
+	int err;
+
+	if (!(cmdqs->status & HINIC3_CMDQ_ENABLE))
+		return 0;
+
+	cmdqs->status &= ~HINIC3_CMDQ_ENABLE;
+
+	err = hinic3_wait_for_timeout(hwdev, check_cmdq_stop_handler,
+				      HINIC3_WAIT_CMDQ_IDLE_TIMEOUT,
+				      USEC_PER_MSEC);
+	if (!err)
+		return 0;
+
+	cmdq_type = HINIC3_CMDQ_SYNC;
+	for (; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		if (!hinic3_cmdq_idle(&cmdqs->cmdq[cmdq_type]))
+			dev_err(hwdev->dev, "Cmdq %d is busy\n", cmdq_type);
+	}
+
+	cmdqs->status |= HINIC3_CMDQ_ENABLE;
+
+	return err;
+}
+
+static int hinic3_rx_tx_flush(struct hinic3_hwdev *hwdev)
+{
+	struct comm_cmd_clear_doorbell clear_db;
+	struct comm_cmd_clear_resource clr_res;
+	struct hinic3_hwif *hwif = hwdev->hwif;
+	u32 out_size = sizeof(clear_db);
+	int ret = 0;
+	int err;
+
+	if (HINIC3_FUNC_TYPE(hwdev) != TYPE_VF) {
+		/* wait for chip to stop I/O */
+		msleep(100);
+	}
+
+	err = wait_cmdq_stop(hwdev);
+	if (err) {
+		dev_warn(hwdev->dev, "CMDQ is still working, CMDQ timeout value is unreasonable\n");
+		ret = err;
+	}
+
+	hinic3_disable_doorbell(hwif);
+
+	memset(&clear_db, 0, sizeof(clear_db));
+	clear_db.func_id = hwif->attr.func_global_idx;
+
+	err = comm_msg_to_mgmt_sync(hwdev,  COMM_MGMT_CMD_FLUSH_DOORBELL,
+				    &clear_db, sizeof(clear_db),
+				    &clear_db, &out_size);
+	if (err || !out_size || clear_db.head.status) {
+		dev_warn(hwdev->dev, "Failed to flush doorbell, err: %d, status: 0x%x, out_size: 0x%x\n",
+			 err, clear_db.head.status, out_size);
+		if (err)
+			ret = err;
+		else
+			ret = -EFAULT;
+	}
+
+	if (HINIC3_FUNC_TYPE(hwdev) != TYPE_VF) {
+		hinic3_set_pf_status(hwif, HINIC3_PF_STATUS_FLR_START_FLAG);
+	} else {
+		/* wait for chip to stop I/O */
+		msleep(100);
+	}
+
+	memset(&clr_res, 0, sizeof(clr_res));
+	clr_res.func_id = hwif->attr.func_global_idx;
+
+	err = hinic3_msg_to_mgmt_no_ack(hwdev, HINIC3_MOD_COMM,
+					COMM_MGMT_CMD_START_FLUSH, &clr_res,
+					sizeof(clr_res));
+	if (err) {
+		dev_warn(hwdev->dev, "Failed to notice flush message, err: %d\n",
+			 err);
+		ret = err;
+	}
+
+	if (HINIC3_FUNC_TYPE(hwdev) != TYPE_VF) {
+		err = wait_for_flr_finish(hwif);
+		if (err) {
+			dev_warn(hwdev->dev, "Wait firmware FLR timeout\n");
+			ret = err;
+		}
+	}
+
+	hinic3_enable_doorbell(hwif);
+
+	err = hinic3_reinit_cmdq_ctxts(hwdev);
+	if (err) {
+		dev_warn(hwdev->dev, "Failed to reinit cmdq\n");
+		ret = err;
+	}
+
+	return ret;
+}
+
+int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev)
+{
+	if (hwdev->chip_present_flag == 0)
+		return 0;
+
+	return hinic3_rx_tx_flush(hwdev);
+}
+
+int hinic3_set_bdf_ctxt(struct hinic3_hwdev *hwdev, u8 bus, u8 device, u8 function)
+{
+	struct comm_cmd_bdf_info bdf_info;
+	u32 out_size = sizeof(bdf_info);
+	int err;
+
+	memset(&bdf_info, 0, sizeof(bdf_info));
+	bdf_info.function_idx = hinic3_global_func_id(hwdev);
+	bdf_info.bus = bus;
+	bdf_info.device = device;
+	bdf_info.function = function;
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_SEND_BDF_INFO,
+				    &bdf_info, sizeof(bdf_info),
+				    &bdf_info, &out_size);
+	if (err || !out_size || bdf_info.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set bdf info to fw, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, bdf_info.head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int hinic3_sync_time(struct hinic3_hwdev *hwdev, u64 time)
+{
+	struct comm_cmd_sync_time time_info;
+	u32 out_size = sizeof(time_info);
+	int err;
+
+	memset(&time_info, 0, sizeof(time_info));
+	time_info.mstime = time;
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_SYNC_TIME, &time_info,
+				    sizeof(time_info), &time_info, &out_size);
+	if (err || time_info.head.status || !out_size) {
+		dev_err(hwdev->dev,
+			"Failed to sync time to mgmt, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, time_info.head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int get_hw_rx_buf_size_idx(int rx_buf_sz, u16 *buf_sz_idx)
+{
+	/* Supported RX buffer sizes in bytes. Configured by array index. */
+	static const int supported_sizes[16] = {
+		[0] = 32,     [1] = 64,     [2] = 96,     [3] = 128,
+		[4] = 192,    [5] = 256,    [6] = 384,    [7] = 512,
+		[8] = 768,    [9] = 1024,   [10] = 1536,  [11] = 2048,
+		[12] = 3072,  [13] = 4096,  [14] = 8192,  [15] = 16384,
+	};
+	u16 idx;
+
+	/* Scan from biggest to smallest. Choose supported size that is equal or
+	 * smaller. For smaller value HW will under-utilize posted buffers. For
+	 * bigger value HW may overrun posted buffers.
+	 */
+	idx = ARRAY_SIZE(supported_sizes);
+	while (idx > 0) {
+		idx--;
+		if (supported_sizes[idx] <= rx_buf_sz) {
+			*buf_sz_idx = idx;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+int hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, u32 rq_depth, u32 sq_depth, int rx_buf_sz)
+{
+	struct comm_cmd_root_ctxt root_ctxt;
+	u32 out_size = sizeof(root_ctxt);
+	u16 buf_sz_idx;
+	int err;
+
+	err = get_hw_rx_buf_size_idx(rx_buf_sz, &buf_sz_idx);
+	if (err)
+		return err;
+
+	memset(&root_ctxt, 0, sizeof(root_ctxt));
+	root_ctxt.func_id = hinic3_global_func_id(hwdev);
+
+	root_ctxt.set_cmdq_depth = 0;
+	root_ctxt.cmdq_depth = 0;
+
+	root_ctxt.lro_en = 1;
+
+	root_ctxt.rq_depth  = ilog2(rq_depth);
+	root_ctxt.rx_buf_sz = buf_sz_idx;
+	root_ctxt.sq_depth  = ilog2(sq_depth);
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_SET_VAT,
+				    &root_ctxt, sizeof(root_ctxt),
+				    &root_ctxt, &out_size);
+	if (err || !out_size || root_ctxt.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set root context, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, root_ctxt.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_clean_root_ctxt(struct hinic3_hwdev *hwdev)
+{
+	struct comm_cmd_root_ctxt root_ctxt;
+	u32 out_size = sizeof(root_ctxt);
+	int err;
+
+	memset(&root_ctxt, 0, sizeof(root_ctxt));
+	root_ctxt.func_id = hinic3_global_func_id(hwdev);
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_SET_VAT,
+				    &root_ctxt, sizeof(root_ctxt),
+				    &root_ctxt, &out_size);
+	if (err || !out_size || root_ctxt.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set root context, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, root_ctxt.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int hinic3_get_fw_ver(struct hinic3_hwdev *hwdev, enum hinic3_fw_ver_type type,
+			     u8 *mgmt_ver, u8 version_size)
+{
+	struct comm_cmd_get_fw_version fw_ver;
+	u32 out_size = sizeof(fw_ver);
+	int err;
+
+	memset(&fw_ver, 0, sizeof(fw_ver));
+	fw_ver.fw_type = type;
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_GET_FW_VERSION,
+				    &fw_ver, sizeof(fw_ver), &fw_ver,
+				    &out_size);
+	if (err || !out_size || fw_ver.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get fw version, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, fw_ver.head.status, out_size);
+		return -EIO;
+	}
+
+	err = snprintf(mgmt_ver, version_size, "%s", fw_ver.ver);
+	if (err < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+int hinic3_get_mgmt_version(struct hinic3_hwdev *hwdev, u8 *mgmt_ver, u8 version_size)
+{
+	return hinic3_get_fw_ver(hwdev, HINIC3_FW_VER_TYPE_MPU, mgmt_ver,
+				 version_size);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
new file mode 100644
index 000000000000..729f525f3736
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_HW_COMM_H
+#define HINIC3_HW_COMM_H
+
+#include <linux/types.h>
+
+#include "hinic3_hw_intf.h"
+
+struct hinic3_hwdev;
+
+#define HINIC3_WQ_PAGE_SIZE_ORDER       8
+#define HINIC3_MAX_WQ_PAGE_SIZE_ORDER   20
+
+struct interrupt_info {
+	u32 lli_set;
+	u32 interrupt_coalesc_set;
+	u16 msix_index;
+	u8  lli_credit_limit;
+	u8  lli_timer_cfg;
+	u8  pending_limt;
+	u8  coalesc_timer_cfg;
+	u8  resend_timer_cfg;
+};
+
+int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
+				    struct interrupt_info *info);
+int hinic3_set_interrupt_cfg(struct hinic3_hwdev *hwdev, struct interrupt_info info);
+int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag);
+
+int hinic3_get_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature, u16 size);
+int hinic3_set_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature, u16 size);
+int hinic3_get_global_attr(struct hinic3_hwdev *hwdev, struct comm_global_attr *attr);
+int hinic3_set_func_svc_used_state(struct hinic3_hwdev *hwdev, u16 svc_type, u8 state);
+int hinic3_set_dma_attr_tbl(struct hinic3_hwdev *hwdev, u8 entry_idx, u8 st, u8 at, u8 ph,
+			    u8 no_snooping, u8 tph_en);
+
+int hinic3_set_wq_page_size(struct hinic3_hwdev *hwdev, u16 func_idx, u32 page_size);
+int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, u16 cmdq_depth);
+int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev);
+int hinic3_set_bdf_ctxt(struct hinic3_hwdev *hwdev, u8 bus, u8 device, u8 function);
+int hinic3_sync_time(struct hinic3_hwdev *hwdev, u64 time);
+
+int hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, u32 rq_depth, u32 sq_depth,
+			 int rx_buf_sz);
+int hinic3_clean_root_ctxt(struct hinic3_hwdev *hwdev);
+int hinic3_get_mgmt_version(struct hinic3_hwdev *hwdev, u8 *mgmt_ver, u8 version_size);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
new file mode 100644
index 000000000000..a969a1b82e49
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -0,0 +1,316 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_HW_INTF_H
+#define HINIC3_HW_INTF_H
+
+#include <linux/types.h>
+
+#define MGMT_MSG_CMD_OP_SET   1
+#define MGMT_MSG_CMD_OP_GET   0
+#define MGMT_CMD_UNSUPPORTED  0xFF
+
+struct mgmt_msg_head {
+	u8 status;
+	u8 version;
+	u8 rsvd0[6];
+};
+
+enum cfg_cmd {
+	CFG_CMD_GET_DEV_CAP = 0,
+};
+
+/* Device capabilities, defined by hw */
+struct cfg_cmd_dev_cap {
+	struct mgmt_msg_head head;
+
+	u16                  func_id;
+	u16                  rsvd1;
+
+	/* Public resources */
+	u8                   host_id;
+	u8                   ep_id;
+	u8                   er_id;
+	u8                   port_id;
+
+	u16                  host_total_func;
+	u8                   host_pf_num;
+	u8                   pf_id_start;
+	u16                  host_vf_num;
+	u16                  vf_id_start;
+	u8                   host_oq_id_mask_val;
+	u8                   timer_en;
+	u8                   host_valid_bitmap;
+	u8                   rsvd_host;
+
+	u16                  svc_cap_en;
+	u16                  max_vf;
+	u8                   flexq_en;
+	u8                   valid_cos_bitmap;
+	u8                   port_cos_valid_bitmap;
+	u8                   rsvd2[45];
+
+	/* l2nic */
+	u16                  nic_max_sq_id;
+	u16                  nic_max_rq_id;
+	u16                  nic_default_num_queues;
+
+	u8                   rsvd3[250];
+};
+
+enum hinic3_service_type {
+	SERVICE_T_NIC = 0,
+	SERVICE_T_MAX = 1,
+	/* Only used for interruption resource management, mark the request module */
+	SERVICE_T_INTF = (1 << 15),
+};
+
+/* CMDQ MODULE_TYPE */
+enum hinic3_mod_type {
+	/* HW communication module */
+	HINIC3_MOD_COMM   = 0,
+	/* L2NIC module */
+	HINIC3_MOD_L2NIC  = 1,
+	/* Configuration module */
+	HINIC3_MOD_CFGM   = 7,
+	HINIC3_MOD_HILINK = 14,
+	/* hardware max module id */
+	HINIC3_MOD_HW_MAX = 19,
+	HINIC3_MOD_MAX,
+};
+
+/* COMM Commands between Driver to fw */
+enum hinic3_mgmt_cmd {
+	/* Commands for clearing FLR and resources */
+	COMM_MGMT_CMD_FUNC_RESET              = 0,
+	COMM_MGMT_CMD_FEATURE_NEGO            = 1,
+	COMM_MGMT_CMD_FLUSH_DOORBELL          = 2,
+	COMM_MGMT_CMD_START_FLUSH             = 3,
+	COMM_MGMT_CMD_GET_GLOBAL_ATTR         = 5,
+	COMM_MGMT_CMD_SET_FUNC_SVC_USED_STATE = 7,
+
+	/* Driver Configuration Commands */
+	COMM_MGMT_CMD_SET_CMDQ_CTXT           = 20,
+	COMM_MGMT_CMD_SET_VAT                 = 21,
+	COMM_MGMT_CMD_CFG_PAGESIZE            = 22,
+	COMM_MGMT_CMD_CFG_MSIX_CTRL_REG       = 23,
+	COMM_MGMT_CMD_SET_CEQ_CTRL_REG        = 24,
+	COMM_MGMT_CMD_SET_DMA_ATTR            = 25,
+
+	/* Commands for obtaining information */
+	COMM_MGMT_CMD_GET_FW_VERSION          = 60,
+	COMM_MGMT_CMD_GET_BOARD_INFO          = 61,
+	COMM_MGMT_CMD_SYNC_TIME               = 62,
+	COMM_MGMT_CMD_SEND_BDF_INFO           = 64,
+
+	COMM_MGMT_CMD_SEND_API_ACK_BY_UP      = 245,
+
+	COMM_MGMT_CMD_MAX                     = 255,
+};
+
+struct comm_cmd_msix_config {
+	struct mgmt_msg_head head;
+
+	u16                  func_id;
+	u8                   opcode;
+	u8                   rsvd1;
+	u16                  msix_index;
+	u8                   pending_cnt;
+	u8                   coalesce_timer_cnt;
+	u8                   resend_timer_cnt;
+	u8                   lli_timer_cnt;
+	u8                   lli_credit_cnt;
+	u8                   rsvd2[5];
+};
+
+enum func_reset_flag {
+	RES_TYPE_FLUSH_BIT    = 0,
+	RES_TYPE_MQM,
+	RES_TYPE_SMF,
+	RES_TYPE_PF_BW_CFG,
+
+	RES_TYPE_COMM         = 10,
+	/* clear mbox and aeq, The RES_TYPE_COMM bit must be set */
+	RES_TYPE_COMM_MGMT_CH,
+	/* clear cmdq and ceq, The RES_TYPE_COMM bit must be set */
+	RES_TYPE_COMM_CMD_CH,
+	RES_TYPE_NIC,
+	RES_TYPE_MAX,
+};
+
+#define HINIC3_COMM_RES \
+	((1 << RES_TYPE_COMM) | (1 << RES_TYPE_COMM_CMD_CH) | \
+	 (1 << RES_TYPE_FLUSH_BIT) | (1 << RES_TYPE_MQM) | \
+	 (1 << RES_TYPE_SMF) | (1 << RES_TYPE_PF_BW_CFG))
+
+#define HINIC3_NIC_RES          BIT(RES_TYPE_NIC)
+
+struct comm_cmd_func_reset {
+	struct mgmt_msg_head head;
+
+	u16                  func_id;
+	u16                  rsvd1[3];
+	u64                  reset_flag;
+};
+
+#define COMM_MAX_FEATURE_QWORD  4
+struct comm_cmd_feature_nego {
+	struct mgmt_msg_head head;
+
+	u16                  func_id;
+	/* 1: set, 0: get */
+	u8                   opcode;
+	u8                   rsvd;
+	u64                  s_feature[COMM_MAX_FEATURE_QWORD];
+};
+
+enum hinic3_cmdq_type {
+	HINIC3_CMDQ_SYNC,
+	HINIC3_MAX_CMDQ_TYPES = 4
+};
+
+struct comm_global_attr {
+	u8  max_host_num;
+	u8  max_pf_num;
+	u16 vf_id_start;
+	/* for api cmd to mgmt cpu */
+	u8  mgmt_host_node_id;
+	u8  cmdq_num;
+	u8  rsvd1[34];
+};
+
+struct comm_cmd_get_glb_attr {
+	struct mgmt_msg_head    head;
+
+	struct comm_global_attr attr;
+};
+
+enum hinic3_svc_type {
+	SVC_T_COMM = 0,
+	SVC_T_NIC  = 1,
+};
+
+struct comm_cmd_func_svc_used_state {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u16                  svc_type;
+	u8                   used_state;
+	u8                   rsvd[35];
+};
+
+struct comm_cmd_dma_attr_config {
+	struct mgmt_msg_head head;
+
+	u16                  func_id;
+	u8                   entry_idx;
+	u8                   st;
+	u8                   at;
+	u8                   ph;
+	u8                   no_snooping;
+	u8                   tph_en;
+	u32                  resv1;
+};
+
+struct comm_cmd_ceq_ctrl_reg {
+	struct mgmt_msg_head head;
+
+	u16                  func_id;
+	u16                  q_id;
+	u32                  ctrl0;
+	u32                  ctrl1;
+	u32                  rsvd1;
+};
+
+struct comm_cmd_wq_page_size {
+	struct mgmt_msg_head head;
+
+	u16                  func_id;
+	u8                   opcode;
+	/* real_size=4KB*2^page_size, range(0~20) must be checked by driver */
+	u8                   page_size;
+
+	u32                  rsvd1;
+};
+
+struct comm_cmd_root_ctxt {
+	struct mgmt_msg_head head;
+
+	u16                  func_id;
+	u8                   set_cmdq_depth;
+	u8                   cmdq_depth;
+	u16                  rx_buf_sz;
+	u8                   lro_en;
+	u8                   rsvd1;
+	u16                  sq_depth;
+	u16                  rq_depth;
+	u64                  rsvd2;
+};
+
+struct cmdq_ctxt_info {
+	u64 curr_wqe_page_pfn;
+	u64 wq_block_pfn;
+};
+
+struct comm_cmd_cmdq_ctxt {
+	struct mgmt_msg_head  head;
+
+	u16                   func_id;
+	u8                    cmdq_id;
+	u8                    rsvd1[5];
+
+	struct cmdq_ctxt_info ctxt;
+};
+
+struct comm_cmd_clear_doorbell {
+	struct mgmt_msg_head head;
+
+	u16                  func_id;
+	u16                  rsvd1[3];
+};
+
+struct comm_cmd_clear_resource {
+	struct mgmt_msg_head head;
+
+	u16                  func_id;
+	u16                  rsvd1[3];
+};
+
+struct comm_cmd_sync_time {
+	struct mgmt_msg_head head;
+
+	u64                  mstime;
+	u64                  rsvd1;
+};
+
+struct comm_cmd_bdf_info {
+	struct mgmt_msg_head head;
+
+	u16                  function_idx;
+	u8                   rsvd1[2];
+	u8                   bus;
+	u8                   device;
+	u8                   function;
+	u8                   rsvd2[5];
+};
+
+enum hinic3_fw_ver_type {
+	HINIC3_FW_VER_TYPE_BOOT,
+	HINIC3_FW_VER_TYPE_MPU,
+	HINIC3_FW_VER_TYPE_NPU,
+	HINIC3_FW_VER_TYPE_SMU_L0,
+	HINIC3_FW_VER_TYPE_SMU_L1,
+	HINIC3_FW_VER_TYPE_CFG,
+};
+
+#define HINIC3_FW_VERSION_LEN           16
+#define HINIC3_FW_COMPILE_TIME_LEN      20
+struct comm_cmd_get_fw_version {
+	struct mgmt_msg_head head;
+
+	u16                  fw_type;
+	u16                  rsvd1;
+	u8                   ver[HINIC3_FW_VERSION_LEN];
+	u8                   time[HINIC3_FW_COMPILE_TIME_LEN];
+};
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
new file mode 100644
index 000000000000..c37e4fc08608
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -0,0 +1,736 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <linux/rtc.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <linux/semaphore.h>
+#include <linux/interrupt.h>
+#include <linux/vmalloc.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+
+#include "hinic3_csr.h"
+#include "hinic3_common.h"
+#include "hinic3_hwif.h"
+#include "hinic3_hw_cfg.h"
+#include "hinic3_eqs.h"
+#include "hinic3_mbox.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_cmdq.h"
+#include "hinic3_lld.h"
+#include "hinic3_hwdev.h"
+
+enum hinic3_pcie_nosnoop {
+	HINIC3_PCIE_SNOOP    = 0,
+	HINIC3_PCIE_NO_SNOOP = 1,
+};
+
+enum hinic3_pcie_tph {
+	HINIC3_PCIE_TPH_DISABLE = 0,
+	HINIC3_PCIE_TPH_ENABLE  = 1,
+};
+
+#define HINIC3_SYNFW_TIME_PERIOD  (60 * 60 * 1000)
+
+#define HINIC3_DMA_ATTR_INDIR_IDX_MASK          GENMASK(9, 0)
+#define HINIC3_DMA_ATTR_INDIR_IDX_SET(val, member)  \
+	FIELD_PREP(HINIC3_DMA_ATTR_INDIR_##member##_MASK, val)
+
+#define HINIC3_DMA_ATTR_ENTRY_ST_MASK           GENMASK(7, 0)
+#define HINIC3_DMA_ATTR_ENTRY_AT_MASK           GENMASK(9, 8)
+#define HINIC3_DMA_ATTR_ENTRY_PH_MASK           GENMASK(11, 10)
+#define HINIC3_DMA_ATTR_ENTRY_NO_SNOOPING_MASK  BIT(12)
+#define HINIC3_DMA_ATTR_ENTRY_TPH_EN_MASK       BIT(13)
+#define HINIC3_DMA_ATTR_ENTRY_SET(val, member)  \
+	FIELD_PREP(HINIC3_DMA_ATTR_ENTRY_##member##_MASK, val)
+
+#define HINIC3_PCIE_ST_DISABLE  0
+#define HINIC3_PCIE_AT_DISABLE  0
+#define HINIC3_PCIE_PH_DISABLE  0
+
+#define PCIE_MSIX_ATTR_ENTRY    0
+
+#define HINIC3_CHIP_PRESENT     1
+#define HINIC3_CHIP_ABSENT      0
+
+#define HINIC3_DEAULT_EQ_MSIX_PENDING_LIMIT      0
+#define HINIC3_DEAULT_EQ_MSIX_COALESC_TIMER_CFG  0xFF
+#define HINIC3_DEAULT_EQ_MSIX_RESEND_TIMER_CFG   7
+
+#define HINIC3_HWDEV_WQ_NAME    "hinic3_hardware"
+#define HINIC3_WQ_MAX_REQ       10
+
+enum hinic3_hwdev_init_state {
+	HINIC3_HWDEV_NONE_INITED = 0,
+	HINIC3_HWDEV_MGMT_INITED = 1,
+	HINIC3_HWDEV_MBOX_INITED = 2,
+	HINIC3_HWDEV_CMDQ_INITED = 3,
+};
+
+static int hinic3_comm_aeqs_init(struct hinic3_hwdev *hwdev)
+{
+	struct irq_info aeq_irqs[HINIC3_MAX_AEQS];
+	u16 num_aeqs, resp_num_irq, i;
+	int err;
+
+	num_aeqs = hwdev->hwif->attr.num_aeqs;
+	if (num_aeqs > HINIC3_MAX_AEQS) {
+		dev_warn(hwdev->dev, "Adjust aeq num to %d\n",
+			 HINIC3_MAX_AEQS);
+		num_aeqs = HINIC3_MAX_AEQS;
+	}
+	err = hinic3_alloc_irqs(hwdev, SERVICE_T_INTF, num_aeqs, aeq_irqs,
+				&resp_num_irq);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc aeq irqs, num_aeqs: %u\n",
+			num_aeqs);
+		return err;
+	}
+
+	if (resp_num_irq < num_aeqs) {
+		dev_warn(hwdev->dev, "Adjust aeq num to %u\n",
+			 resp_num_irq);
+		num_aeqs = resp_num_irq;
+	}
+
+	err = hinic3_aeqs_init(hwdev, num_aeqs, aeq_irqs);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init aeqs\n");
+		goto err_aeqs_init;
+	}
+
+	return 0;
+
+err_aeqs_init:
+	for (i = 0; i < num_aeqs; i++)
+		hinic3_free_irq(hwdev, SERVICE_T_INTF, aeq_irqs[i].irq_id);
+
+	return err;
+}
+
+static void hinic3_comm_aeqs_free(struct hinic3_hwdev *hwdev)
+{
+	struct irq_info aeq_irqs[HINIC3_MAX_AEQS];
+	u16 num_irqs, i;
+
+	hinic3_get_aeq_irqs(hwdev, aeq_irqs, &num_irqs);
+
+	hinic3_aeqs_free(hwdev);
+
+	for (i = 0; i < num_irqs; i++)
+		hinic3_free_irq(hwdev, SERVICE_T_INTF, aeq_irqs[i].irq_id);
+}
+
+static int hinic3_comm_ceqs_init(struct hinic3_hwdev *hwdev)
+{
+	struct irq_info ceq_irqs[HINIC3_MAX_CEQS];
+	u16 num_ceqs, resp_num_irq, i;
+	int err;
+
+	num_ceqs = hwdev->hwif->attr.num_ceqs;
+	if (num_ceqs > HINIC3_MAX_CEQS) {
+		dev_warn(hwdev->dev, "Adjust ceq num to %d\n",
+			 HINIC3_MAX_CEQS);
+		num_ceqs = HINIC3_MAX_CEQS;
+	}
+
+	err = hinic3_alloc_irqs(hwdev, SERVICE_T_INTF, num_ceqs, ceq_irqs,
+				&resp_num_irq);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc ceq irqs, num_ceqs: %u\n",
+			num_ceqs);
+		return err;
+	}
+
+	if (resp_num_irq < num_ceqs) {
+		dev_warn(hwdev->dev, "Adjust ceq num to %u\n",
+			 resp_num_irq);
+		num_ceqs = resp_num_irq;
+	}
+
+	err = hinic3_ceqs_init(hwdev, num_ceqs, ceq_irqs);
+	if (err) {
+		dev_err(hwdev->dev,
+			"Failed to init ceqs, err:%d\n", err);
+		goto err_ceqs_init;
+	}
+
+	return 0;
+
+err_ceqs_init:
+	for (i = 0; i < num_ceqs; i++)
+		hinic3_free_irq(hwdev, SERVICE_T_INTF, ceq_irqs[i].irq_id);
+
+	return err;
+}
+
+static void hinic3_comm_ceqs_free(struct hinic3_hwdev *hwdev)
+{
+	struct irq_info ceq_irqs[HINIC3_MAX_CEQS];
+	u16 num_irqs;
+	int i;
+
+	hinic3_get_ceq_irqs(hwdev, ceq_irqs, &num_irqs);
+
+	hinic3_ceqs_free(hwdev);
+
+	for (i = 0; i < num_irqs; i++)
+		hinic3_free_irq(hwdev, SERVICE_T_INTF, ceq_irqs[i].irq_id);
+}
+
+static int hinic3_comm_mbox_init(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = hinic3_init_mbox(hwdev);
+	if (err)
+		return err;
+
+	hinic3_aeq_register_hw_cb(hwdev, HINIC3_MBX_FROM_FUNC,
+				  hinic3_mbox_func_aeqe_handler);
+	hinic3_aeq_register_hw_cb(hwdev, HINIC3_MSG_FROM_FW,
+				  hinic3_mgmt_msg_aeqe_handler);
+
+	set_bit(HINIC3_HWDEV_MBOX_INITED, &hwdev->func_state);
+
+	return 0;
+}
+
+static void hinic3_comm_mbox_free(struct hinic3_hwdev *hwdev)
+{
+	spin_lock_bh(&hwdev->channel_lock);
+	clear_bit(HINIC3_HWDEV_MBOX_INITED, &hwdev->func_state);
+	spin_unlock_bh(&hwdev->channel_lock);
+
+	hinic3_aeq_unregister_hw_cb(hwdev, HINIC3_MBX_FROM_FUNC);
+	hinic3_aeq_unregister_hw_cb(hwdev, HINIC3_MSG_FROM_FW);
+
+	hinic3_free_mbox(hwdev);
+}
+
+static int init_aeqs_msix_attr(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_aeqs *aeqs = hwdev->aeqs;
+	struct interrupt_info info = {};
+	struct hinic3_eq *eq;
+	int q_id;
+	int err;
+
+	info.lli_set = 0;
+	info.interrupt_coalesc_set = 1;
+	info.pending_limt = HINIC3_DEAULT_EQ_MSIX_PENDING_LIMIT;
+	info.coalesc_timer_cfg = HINIC3_DEAULT_EQ_MSIX_COALESC_TIMER_CFG;
+	info.resend_timer_cfg = HINIC3_DEAULT_EQ_MSIX_RESEND_TIMER_CFG;
+
+	for (q_id = aeqs->num_aeqs - 1; q_id >= 0; q_id--) {
+		eq = &aeqs->aeq[q_id];
+		info.msix_index = eq->eq_irq.msix_entry_idx;
+		err = hinic3_set_interrupt_cfg_direct(hwdev, &info);
+		if (err) {
+			dev_err(hwdev->dev, "Set msix attr for aeq %d failed\n",
+				q_id);
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+static int init_ceqs_msix_attr(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_ceqs *ceqs = hwdev->ceqs;
+	struct interrupt_info info = {};
+	struct hinic3_eq *eq;
+	u16 q_id;
+	int err;
+
+	info.lli_set = 0;
+	info.interrupt_coalesc_set = 1;
+	info.pending_limt = HINIC3_DEAULT_EQ_MSIX_PENDING_LIMIT;
+	info.coalesc_timer_cfg = HINIC3_DEAULT_EQ_MSIX_COALESC_TIMER_CFG;
+	info.resend_timer_cfg = HINIC3_DEAULT_EQ_MSIX_RESEND_TIMER_CFG;
+
+	for (q_id = 0; q_id < ceqs->num_ceqs; q_id++) {
+		eq = &ceqs->ceq[q_id];
+		info.msix_index = eq->eq_irq.msix_entry_idx;
+		err = hinic3_set_interrupt_cfg(hwdev, info);
+		if (err) {
+			dev_err(hwdev->dev, "Set msix attr for ceq %u failed\n",
+				q_id);
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+static int hinic3_comm_pf_to_mgmt_init(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	if (HINIC3_IS_VF(hwdev))
+		return 0;
+
+	err = hinic3_pf_to_mgmt_init(hwdev);
+	if (err)
+		return err;
+
+	set_bit(HINIC3_HWDEV_MGMT_INITED, &hwdev->func_state);
+
+	return 0;
+}
+
+static void hinic3_comm_pf_to_mgmt_free(struct hinic3_hwdev *hwdev)
+{
+	if (HINIC3_IS_VF(hwdev))
+		return;
+
+	spin_lock_bh(&hwdev->channel_lock);
+	clear_bit(HINIC3_HWDEV_MGMT_INITED, &hwdev->func_state);
+	spin_unlock_bh(&hwdev->channel_lock);
+
+	hinic3_aeq_unregister_hw_cb(hwdev, HINIC3_MSG_FROM_FW);
+
+	hinic3_pf_to_mgmt_free(hwdev);
+}
+
+static int init_basic_mgmt_channel(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = hinic3_comm_aeqs_init(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init async event queues\n");
+		return err;
+	}
+
+	err = hinic3_comm_mbox_init(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init mailbox\n");
+		goto err_comm_mbox_init;
+	}
+
+	err = init_aeqs_msix_attr(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init aeqs msix attr\n");
+		goto err_aeqs_msix_attr_init;
+	}
+
+	return 0;
+
+err_aeqs_msix_attr_init:
+	hinic3_comm_mbox_free(hwdev);
+
+err_comm_mbox_init:
+	hinic3_comm_aeqs_free(hwdev);
+
+	return err;
+}
+
+static void free_base_mgmt_channel(struct hinic3_hwdev *hwdev)
+{
+	hinic3_comm_mbox_free(hwdev);
+	hinic3_comm_aeqs_free(hwdev);
+}
+
+static int dma_attr_table_init(struct hinic3_hwdev *hwdev)
+{
+	u32 addr, val, dst_attr;
+
+	/* Indirect access, set entry_idx first */
+	addr = HINIC3_CSR_DMA_ATTR_INDIR_IDX_ADDR;
+	val = hinic3_hwif_read_reg(hwdev->hwif, addr);
+	val &= ~HINIC3_DMA_ATTR_ENTRY_AT_MASK;
+	val |= HINIC3_DMA_ATTR_INDIR_IDX_SET(PCIE_MSIX_ATTR_ENTRY, IDX);
+	hinic3_hwif_write_reg(hwdev->hwif, addr, val);
+
+	addr = HINIC3_CSR_DMA_ATTR_TBL_ADDR;
+	val = hinic3_hwif_read_reg(hwdev->hwif, addr);
+
+	dst_attr = HINIC3_DMA_ATTR_ENTRY_SET(HINIC3_PCIE_ST_DISABLE, ST) |
+		   HINIC3_DMA_ATTR_ENTRY_SET(HINIC3_PCIE_AT_DISABLE, AT) |
+		   HINIC3_DMA_ATTR_ENTRY_SET(HINIC3_PCIE_PH_DISABLE, PH) |
+		   HINIC3_DMA_ATTR_ENTRY_SET(HINIC3_PCIE_SNOOP, NO_SNOOPING) |
+		   HINIC3_DMA_ATTR_ENTRY_SET(HINIC3_PCIE_TPH_DISABLE, TPH_EN);
+	if (val == dst_attr)
+		return 0;
+
+	return hinic3_set_dma_attr_tbl(hwdev, PCIE_MSIX_ATTR_ENTRY, HINIC3_PCIE_ST_DISABLE,
+				       HINIC3_PCIE_AT_DISABLE, HINIC3_PCIE_PH_DISABLE,
+				       HINIC3_PCIE_SNOOP, HINIC3_PCIE_TPH_DISABLE);
+}
+
+static int init_basic_attributes(struct hinic3_hwdev *hwdev)
+{
+	struct comm_global_attr glb_attr;
+	int err;
+
+	err = hinic3_func_reset(hwdev, hinic3_global_func_id(hwdev), HINIC3_COMM_RES);
+	if (err)
+		return err;
+
+	err = hinic3_get_comm_features(hwdev, hwdev->features,
+				       COMM_MAX_FEATURE_QWORD);
+	if (err)
+		return err;
+
+	dev_dbg(hwdev->dev, "Comm hw features: 0x%llx\n", hwdev->features[0]);
+
+	err = hinic3_get_global_attr(hwdev, &glb_attr);
+	if (err)
+		return err;
+
+	err = hinic3_set_func_svc_used_state(hwdev, SVC_T_COMM, 1);
+	if (err)
+		return err;
+
+	err = dma_attr_table_init(hwdev);
+	if (err)
+		return err;
+
+	hwdev->max_pf = glb_attr.max_pf_num;
+	hwdev->max_cmdq = min(glb_attr.cmdq_num, HINIC3_MAX_CMDQ_TYPES);
+	dev_dbg(hwdev->dev,
+		"global attribute: max_host: 0x%x, max_pf: 0x%x, vf_id_start: 0x%x, mgmt node id: 0x%x, cmdq_num: 0x%x\n",
+		glb_attr.max_host_num, glb_attr.max_pf_num,
+		glb_attr.vf_id_start, glb_attr.mgmt_host_node_id,
+		glb_attr.cmdq_num);
+
+	return 0;
+}
+
+static int hinic3_comm_cmdqs_init(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = hinic3_cmdqs_init(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init cmd queues\n");
+		return err;
+	}
+
+	hinic3_ceq_register_cb(hwdev, HINIC3_CMDQ, hinic3_cmdq_ceq_handler);
+
+	err = hinic3_set_cmdq_depth(hwdev, HINIC3_CMDQ_DEPTH);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set cmdq depth\n");
+		goto err_set_cmdq_depth;
+	}
+
+	set_bit(HINIC3_HWDEV_CMDQ_INITED, &hwdev->func_state);
+
+	return 0;
+
+err_set_cmdq_depth:
+	hinic3_cmdqs_free(hwdev);
+
+	return err;
+}
+
+static void hinic3_comm_cmdqs_free(struct hinic3_hwdev *hwdev)
+{
+	spin_lock_bh(&hwdev->channel_lock);
+	clear_bit(HINIC3_HWDEV_CMDQ_INITED, &hwdev->func_state);
+	spin_unlock_bh(&hwdev->channel_lock);
+
+	hinic3_ceq_unregister_cb(hwdev, HINIC3_CMDQ);
+	hinic3_cmdqs_free(hwdev);
+}
+
+static int init_cmdqs_channel(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = hinic3_comm_ceqs_init(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init completion event queues\n");
+		return err;
+	}
+
+	err = init_ceqs_msix_attr(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init ceqs msix attr\n");
+		goto err_init_ceq_msix;
+	}
+
+	hwdev->wq_page_size = HINIC3_MIN_PAGE_SIZE * (1U << HINIC3_WQ_PAGE_SIZE_ORDER);
+	err = hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
+				      hwdev->wq_page_size);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set wq page size\n");
+		goto err_init_wq_pg_size;
+	}
+
+	err = hinic3_comm_cmdqs_init(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init cmd queues\n");
+		goto err_cmdq_init;
+	}
+
+	return 0;
+
+err_cmdq_init:
+	if (HINIC3_FUNC_TYPE(hwdev) != TYPE_VF)
+		hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
+					HINIC3_MIN_PAGE_SIZE);
+err_init_wq_pg_size:
+err_init_ceq_msix:
+	hinic3_comm_ceqs_free(hwdev);
+
+	return err;
+}
+
+static void hinic3_free_cmdqs_channel(struct hinic3_hwdev *hwdev)
+{
+	hinic3_comm_cmdqs_free(hwdev);
+
+	if (HINIC3_FUNC_TYPE(hwdev) != TYPE_VF)
+		hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
+					HINIC3_MIN_PAGE_SIZE);
+
+	hinic3_comm_ceqs_free(hwdev);
+}
+
+static int hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = init_basic_mgmt_channel(hwdev);
+	if (err)
+		return err;
+
+	err = hinic3_comm_pf_to_mgmt_init(hwdev);
+	if (err)
+		goto err_pf_to_mgmt_init;
+
+	err = init_basic_attributes(hwdev);
+	if (err)
+		goto err_init_basic_attr;
+
+	err = init_cmdqs_channel(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init cmdq channel\n");
+		goto err_init_cmdqs_channel;
+	}
+
+	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_ACTIVE_FLAG);
+
+	return 0;
+
+err_init_cmdqs_channel:
+	hinic3_set_func_svc_used_state(hwdev, SVC_T_COMM, 0);
+
+err_init_basic_attr:
+	hinic3_comm_pf_to_mgmt_free(hwdev);
+
+err_pf_to_mgmt_init:
+	free_base_mgmt_channel(hwdev);
+
+	return err;
+}
+
+static void hinic3_uninit_comm_ch(struct hinic3_hwdev *hwdev)
+{
+	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_INIT);
+	hinic3_free_cmdqs_channel(hwdev);
+	hinic3_set_func_svc_used_state(hwdev, SVC_T_COMM, 0);
+	hinic3_comm_pf_to_mgmt_free(hwdev);
+	free_base_mgmt_channel(hwdev);
+}
+
+static void hinic3_auto_sync_time_work(struct work_struct *work)
+{
+	struct delayed_work *delay = to_delayed_work(work);
+	struct hinic3_hwdev *hwdev;
+
+	hwdev = container_of(delay, struct hinic3_hwdev, sync_time_task);
+	queue_delayed_work(hwdev->workq, &hwdev->sync_time_task,
+			   msecs_to_jiffies(HINIC3_SYNFW_TIME_PERIOD));
+}
+
+static int hinic3_init_ppf_work(struct hinic3_hwdev *hwdev)
+{
+	if (hinic3_ppf_idx(hwdev) != hinic3_global_func_id(hwdev))
+		return 0;
+
+	INIT_DELAYED_WORK(&hwdev->sync_time_task, hinic3_auto_sync_time_work);
+	queue_delayed_work(hwdev->workq, &hwdev->sync_time_task,
+			   msecs_to_jiffies(HINIC3_SYNFW_TIME_PERIOD));
+
+	return 0;
+}
+
+static void hinic3_free_ppf_work(struct hinic3_hwdev *hwdev)
+{
+	if (hinic3_ppf_idx(hwdev) != hinic3_global_func_id(hwdev))
+		return;
+
+	cancel_delayed_work_sync(&hwdev->sync_time_task);
+}
+
+static DEFINE_IDA(hinic3_adev_ida);
+
+static int hinic3_adev_idx_alloc(void)
+{
+	return ida_alloc(&hinic3_adev_ida, GFP_KERNEL);
+}
+
+static void hinic3_adev_idx_free(int id)
+{
+	ida_free(&hinic3_adev_ida, id);
+}
+
+static int init_hwdev(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+	struct hinic3_hwdev *hwdev;
+
+	hwdev = kzalloc(sizeof(*hwdev), GFP_KERNEL);
+	if (!hwdev)
+		return -ENOMEM;
+
+	pci_adapter->hwdev = hwdev;
+	hwdev->adapter = pci_adapter;
+	hwdev->pdev = pci_adapter->pdev;
+	hwdev->dev = &pci_adapter->pdev->dev;
+	hwdev->poll = false;
+	hwdev->probe_fault_level = pci_adapter->probe_fault_level;
+	hwdev->func_state = 0;
+	memset(hwdev->features, 0, sizeof(hwdev->features));
+	hwdev->dev_id = hinic3_adev_idx_alloc();
+
+	spin_lock_init(&hwdev->channel_lock);
+
+	return 0;
+}
+
+int hinic3_init_hwdev(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+	struct hinic3_hwdev *hwdev;
+	int err;
+
+	err = init_hwdev(pdev);
+	if (err)
+		return err;
+
+	hwdev = pci_adapter->hwdev;
+	err = hinic3_init_hwif(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init hwif\n");
+		goto err_init_hwif;
+	}
+	hwdev->chip_present_flag = HINIC3_CHIP_PRESENT;
+
+	hwdev->workq = alloc_workqueue(HINIC3_HWDEV_WQ_NAME, WQ_MEM_RECLAIM, HINIC3_WQ_MAX_REQ);
+	if (!hwdev->workq) {
+		dev_err(hwdev->dev, "Failed to alloc hardware workq\n");
+		goto err_alloc_workq;
+	}
+
+	err = hinic3_init_cfg_mgmt(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init config mgmt\n");
+		goto err_init_cfg_mgmt;
+	}
+
+	err = hinic3_init_comm_ch(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init communication channel\n");
+		goto err_init_comm_ch;
+	}
+
+	err = init_capability(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init capability\n");
+		goto err_init_cap;
+	}
+
+	hinic3_init_ppf_work(hwdev);
+
+	err = hinic3_set_comm_features(hwdev, hwdev->features, COMM_MAX_FEATURE_QWORD);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set comm features\n");
+		goto err_set_feature;
+	}
+
+	return 0;
+
+err_set_feature:
+	hinic3_free_ppf_work(hwdev);
+
+err_init_cap:
+	hinic3_uninit_comm_ch(hwdev);
+
+err_init_comm_ch:
+	hinic3_free_cfg_mgmt(hwdev);
+
+err_init_cfg_mgmt:
+	destroy_workqueue(hwdev->workq);
+
+err_alloc_workq:
+	hinic3_free_hwif(hwdev);
+
+err_init_hwif:
+	pci_adapter->probe_fault_level = hwdev->probe_fault_level;
+	pci_adapter->hwdev = NULL;
+	hinic3_adev_idx_free(hwdev->dev_id);
+	kfree(hwdev);
+
+	return -EFAULT;
+}
+
+void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
+{
+	u64 drv_features[COMM_MAX_FEATURE_QWORD];
+
+	memset(drv_features, 0, sizeof(drv_features));
+	hinic3_set_comm_features(hwdev, drv_features, COMM_MAX_FEATURE_QWORD);
+	hinic3_free_ppf_work(hwdev);
+	hinic3_func_rx_tx_flush(hwdev);
+	hinic3_uninit_comm_ch(hwdev);
+	hinic3_free_cfg_mgmt(hwdev);
+	destroy_workqueue(hwdev->workq);
+	hinic3_free_hwif(hwdev);
+	hinic3_adev_idx_free(hwdev->dev_id);
+	kfree(hwdev);
+}
+
+void hinic3_set_api_stop(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_recv_msg *recv_resp_msg;
+	struct hinic3_mbox *mbox;
+
+	hwdev->chip_present_flag = HINIC3_CHIP_ABSENT;
+	spin_lock_bh(&hwdev->channel_lock);
+	if (HINIC3_IS_PF(hwdev) &&
+	    test_bit(HINIC3_HWDEV_MGMT_INITED, &hwdev->func_state)) {
+		recv_resp_msg = &hwdev->pf_to_mgmt->recv_resp_msg_from_mgmt;
+		spin_lock_bh(&hwdev->pf_to_mgmt->sync_event_lock);
+		if (hwdev->pf_to_mgmt->event_flag == SEND_EVENT_START) {
+			complete(&recv_resp_msg->recv_done);
+			hwdev->pf_to_mgmt->event_flag = SEND_EVENT_TIMEOUT;
+		}
+		spin_unlock_bh(&hwdev->pf_to_mgmt->sync_event_lock);
+	}
+
+	if (test_bit(HINIC3_HWDEV_MBOX_INITED, &hwdev->func_state)) {
+		mbox = hwdev->mbox;
+		spin_lock(&mbox->mbox_lock);
+		if (mbox->event_flag == EVENT_START)
+			mbox->event_flag = EVENT_TIMEOUT;
+		spin_unlock(&mbox->mbox_lock);
+	}
+
+	if (test_bit(HINIC3_HWDEV_CMDQ_INITED, &hwdev->func_state))
+		hinic3_cmdq_flush_sync_cmd(hwdev);
+
+	spin_unlock_bh(&hwdev->channel_lock);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
new file mode 100644
index 000000000000..8ba3da891436
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_HWDEV_H
+#define HINIC3_HWDEV_H
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/auxiliary_bus.h>
+
+#include "hinic3_hwif.h"
+#include "hinic3_hw_cfg.h"
+#include "hinic3_hw_intf.h"
+
+struct hinic3_aeqs;
+struct hinic3_ceqs;
+struct hinic3_mbox;
+struct hinic3_msg_pf_to_mgmt;
+struct hinic3_cmdqs;
+
+enum hinic3_event_service_type {
+	EVENT_SRV_COMM = 0,
+#define SERVICE_EVENT_BASE    (EVENT_SRV_COMM + 1)
+	EVENT_SRV_NIC  = SERVICE_EVENT_BASE + SERVICE_T_NIC,
+};
+
+#define HINIC3_SRV_EVENT_TYPE(svc, type)    ((((u32)(svc)) << 16) | (type))
+
+enum hinic3_comm_event_type {
+	EVENT_COMM_PCIE_LINK_DOWN,
+	EVENT_COMM_HEART_LOST,
+	EVENT_COMM_FAULT,
+	EVENT_COMM_SRIOV_STATE_CHANGE,
+	EVENT_COMM_CARD_REMOVE,
+	EVENT_COMM_MGMT_WATCHDOG,
+};
+
+enum hinic3_fault_source_type {
+	HINIC3_FAULT_SRC_HW_PHY_FAULT = 9,
+	HINIC3_FAULT_SRC_TX_TIMEOUT   = 22,
+};
+
+/* driver-specific data of pci_dev */
+struct hinic3_pcidev {
+	struct pci_dev       *pdev;
+	struct pci_device_id id;
+	struct hinic3_hwdev  *hwdev;
+	/* Auxiliary devices */
+	struct hinic3_adev   *hadev[SERVICE_T_MAX];
+
+	void __iomem         *cfg_reg_base;
+	void __iomem         *intr_reg_base;
+	void __iomem         *mgmt_reg_base;
+	void __iomem         *db_base;
+	u64                  db_dwqe_len;
+	u64                  db_base_phy;
+
+	/* lock for attach/detach uld */
+	struct mutex         pdev_mutex;
+
+	unsigned long        state;
+	u16                  probe_fault_level;
+};
+
+struct hinic3_hwdev {
+	struct hinic3_pcidev           *adapter;
+	struct pci_dev                 *pdev;
+	struct device                  *dev;
+	int                            dev_id;
+
+	struct hinic3_hwif             *hwif;
+	struct cfg_mgmt_info           *cfg_mgmt;
+	struct hinic3_aeqs             *aeqs;
+	struct hinic3_ceqs             *ceqs;
+	struct hinic3_mbox             *mbox;
+	struct hinic3_msg_pf_to_mgmt   *pf_to_mgmt;
+	struct hinic3_cmdqs            *cmdqs;
+
+	struct delayed_work            sync_time_task;
+	struct workqueue_struct        *workq;
+	/* protect channel init and deinit */
+	spinlock_t                     channel_lock;
+
+	/* use polling mode or interrupt mode */
+	bool                           poll;
+	u64                            features[COMM_MAX_FEATURE_QWORD];
+	u32                            wq_page_size;
+	u8                             max_pf;
+	u8                             max_cmdq;
+
+	ulong                          func_state;
+	int                            chip_present_flag;
+	u16                            probe_fault_level;
+};
+
+struct hinic3_event_info {
+	/* enum hinic3_event_service_type */
+	u16 service;
+	u16 type;
+	u8  event_data[104];
+};
+
+struct hinic3_adev {
+	struct auxiliary_device  adev;
+	struct hinic3_hwdev      *hwdev;
+	enum hinic3_service_type svc_type;
+
+	void (*event)(struct auxiliary_device *adev,
+		      struct hinic3_event_info *event);
+};
+
+int hinic3_init_hwdev(struct pci_dev *pdev);
+void hinic3_free_hwdev(struct hinic3_hwdev *hwdev);
+
+void hinic3_set_api_stop(struct hinic3_hwdev *hwdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
new file mode 100644
index 000000000000..c4f01744c80c
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -0,0 +1,576 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+
+#include "hinic3_common.h"
+#include "hinic3_csr.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_hwif.h"
+
+#define HWIF_READY_TIMEOUT          10000
+#define DB_AND_OUTBOUND_EN_TIMEOUT  60000
+#define HINIC3_PCIE_LINK_DOWN       0xFFFFFFFF
+
+/* config BAR45 4MB, DB & DWQE both 2MB */
+#define HINIC3_DB_DWQE_SIZE  0x00400000
+
+/* db/dwqe page size: 4K */
+#define HINIC3_DB_PAGE_SIZE  0x00001000ULL
+#define HINIC3_DWQE_OFFSET   0x00000800ULL
+#define HINIC3_DB_MAX_AREAS  (HINIC3_DB_DWQE_SIZE / HINIC3_DB_PAGE_SIZE)
+
+#define MAX_MSIX_ENTRY       2048
+
+#define HINIC3_AF0_FUNC_GLOBAL_IDX_MASK  GENMASK(11, 0)
+#define HINIC3_AF0_P2P_IDX_MASK          GENMASK(16, 12)
+#define HINIC3_AF0_PCI_INTF_IDX_MASK     GENMASK(19, 17)
+#define HINIC3_AF0_FUNC_TYPE_MASK        BIT(28)
+#define HINIC3_AF0_GET(val, member) \
+	FIELD_GET(HINIC3_AF0_##member##_MASK, val)
+
+#define HINIC3_AF1_PPF_IDX_MASK           GENMASK(5, 0)
+#define HINIC3_AF1_AEQS_PER_FUNC_MASK     GENMASK(9, 8)
+#define HINIC3_AF1_MGMT_INIT_STATUS_MASK  BIT(30)
+#define HINIC3_AF1_GET(val, member) \
+	FIELD_GET(HINIC3_AF1_##member##_MASK, val)
+
+#define HINIC3_AF2_CEQS_PER_FUNC_MASK      GENMASK(8, 0)
+#define HINIC3_AF2_DMA_ATTR_PER_FUNC_MASK  GENMASK(11, 9)
+#define HINIC3_AF2_IRQS_PER_FUNC_MASK      GENMASK(26, 16)
+#define HINIC3_AF2_GET(val, member) \
+	FIELD_GET(HINIC3_AF2_##member##_MASK, val)
+
+#define HINIC3_AF3_GLOBAL_VF_ID_OF_PF_MASK  GENMASK(27, 16)
+#define HINIC3_AF3_GET(val, member) \
+	FIELD_GET(HINIC3_AF3_##member##_MASK, val)
+
+#define HINIC3_AF4_DOORBELL_CTRL_MASK  BIT(0)
+#define HINIC3_AF4_GET(val, member) \
+	FIELD_GET(HINIC3_AF4_##member##_MASK, val)
+#define HINIC3_AF4_SET(val, member) \
+	FIELD_PREP(HINIC3_AF4_##member##_MASK, val)
+
+#define HINIC3_AF5_OUTBOUND_CTRL_MASK  BIT(0)
+#define HINIC3_AF5_GET(val, member) \
+	FIELD_GET(HINIC3_AF5_##member##_MASK, val)
+
+#define HINIC3_AF6_PF_STATUS_MASK     GENMASK(15, 0)
+#define HINIC3_AF6_FUNC_MAX_SQ_MASK   GENMASK(31, 23)
+#define HINIC3_AF6_MSIX_FLEX_EN_MASK  BIT(22)
+#define HINIC3_AF6_SET(val, member) \
+	FIELD_PREP(HINIC3_AF6_##member##_MASK, val)
+#define HINIC3_AF6_GET(val, member) \
+	FIELD_GET(HINIC3_AF6_##member##_MASK, val)
+
+#define HINIC3_PPF_ELECTION_IDX_MASK  GENMASK(5, 0)
+#define HINIC3_PPF_ELECTION_SET(val, member) \
+	FIELD_PREP(HINIC3_PPF_ELECTION_##member##_MASK, val)
+#define HINIC3_PPF_ELECTION_GET(val, member) \
+	FIELD_GET(HINIC3_PPF_ELECTION_##member##_MASK, val)
+
+#define HINIC3_GET_REG_FLAG(reg)  ((reg) & (~(HINIC3_REGS_FLAG_MAKS)))
+#define HINIC3_GET_REG_ADDR(reg)  ((reg) & (HINIC3_REGS_FLAG_MAKS))
+
+static void __iomem *hinic3_reg_addr(struct hinic3_hwif *hwif, u32 reg)
+{
+	if (HINIC3_GET_REG_FLAG(reg) == HINIC3_MGMT_REGS_FLAG)
+		return hwif->mgmt_regs_base + HINIC3_GET_REG_ADDR(reg);
+	else
+		return hwif->cfg_regs_base + HINIC3_GET_REG_ADDR(reg);
+}
+
+u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg)
+{
+	void __iomem *addr = hinic3_reg_addr(hwif, reg);
+	__be32 raw_val;
+
+	raw_val = (__force __be32)readl(addr);
+	return be32_to_cpu(raw_val);
+}
+
+void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val)
+{
+	void __iomem *addr = hinic3_reg_addr(hwif, reg);
+	__be32 raw_val = cpu_to_be32(val);
+
+	writel((__force u32)raw_val, addr);
+}
+
+static u32 hinic3_get_mgmt_status(struct hinic3_hwdev *hwdev)
+{
+	u32 attr1;
+
+	attr1 = hinic3_hwif_read_reg(hwdev->hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
+	return !HINIC3_AF1_GET(attr1, MGMT_INIT_STATUS);
+}
+
+static enum hinic3_wait_return check_hwif_ready_handler(void *priv_data)
+{
+	u32 status;
+
+	status = hinic3_get_mgmt_status(priv_data);
+	if (status == HINIC3_PCIE_LINK_DOWN)
+		return WAIT_PROCESS_ERR;
+	else if (!status)
+		return WAIT_PROCESS_CPL;
+
+	return WAIT_PROCESS_WAITING;
+}
+
+static int wait_hwif_ready(struct hinic3_hwdev *hwdev)
+{
+	int ret;
+
+	ret = hinic3_wait_for_timeout(hwdev, check_hwif_ready_handler,
+				      HWIF_READY_TIMEOUT, USEC_PER_MSEC);
+	if (ret == -ETIMEDOUT) {
+		hwdev->probe_fault_level = FAULT_LEVEL_FATAL;
+		dev_err(hwdev->dev, "Wait for hwif timeout\n");
+	}
+
+	return ret;
+}
+
+/* Init attr struct from HW attr values. */
+static void init_hwif_attr(struct hinic3_func_attr *attr, u32 attr0, u32 attr1,
+			   u32 attr2, u32 attr3, u32 attr6)
+{
+	attr->func_global_idx = HINIC3_AF0_GET(attr0, FUNC_GLOBAL_IDX);
+	attr->port_to_port_idx = HINIC3_AF0_GET(attr0, P2P_IDX);
+	attr->pci_intf_idx = HINIC3_AF0_GET(attr0, PCI_INTF_IDX);
+	attr->func_type = HINIC3_AF0_GET(attr0, FUNC_TYPE);
+
+	attr->ppf_idx = HINIC3_AF1_GET(attr1, PPF_IDX);
+	attr->num_aeqs = BIT(HINIC3_AF1_GET(attr1, AEQS_PER_FUNC));
+	attr->num_ceqs = (u8)HINIC3_AF2_GET(attr2, CEQS_PER_FUNC);
+	attr->num_irqs = HINIC3_AF2_GET(attr2, IRQS_PER_FUNC);
+	if (attr->num_irqs > MAX_MSIX_ENTRY)
+		attr->num_irqs = MAX_MSIX_ENTRY;
+
+	attr->global_vf_id_of_pf = HINIC3_AF3_GET(attr3, GLOBAL_VF_ID_OF_PF);
+
+	attr->num_sq = HINIC3_AF6_GET(attr6, FUNC_MAX_SQ);
+	attr->msix_flex_en = HINIC3_AF6_GET(attr6, MSIX_FLEX_EN);
+}
+
+/* Get device attributes from HW. */
+static int get_hwif_attr(struct hinic3_hwdev *hwdev)
+{
+	u32 attr0, attr1, attr2, attr3, attr6;
+	struct hinic3_func_attr *attr;
+	struct hinic3_hwif *hwif;
+
+	hwif = hwdev->hwif;
+	attr0  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR0_ADDR);
+	if (attr0 == HINIC3_PCIE_LINK_DOWN)
+		return -EFAULT;
+
+	attr1  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
+	if (attr1 == HINIC3_PCIE_LINK_DOWN)
+		return -EFAULT;
+
+	attr2  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR2_ADDR);
+	if (attr2 == HINIC3_PCIE_LINK_DOWN)
+		return -EFAULT;
+
+	attr3  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR3_ADDR);
+	if (attr3 == HINIC3_PCIE_LINK_DOWN)
+		return -EFAULT;
+
+	attr6  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR);
+	if (attr6 == HINIC3_PCIE_LINK_DOWN)
+		return -EFAULT;
+
+	attr = &hwif->attr;
+	init_hwif_attr(attr, attr0, attr1, attr2, attr3, attr6);
+
+	if (attr->func_type != TYPE_VF && attr->func_type != TYPE_PF) {
+		dev_err(hwdev->dev, "unexpected func_type %u\n", attr->func_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum hinic3_doorbell_ctrl hinic3_get_doorbell_ctrl_status(struct hinic3_hwif *hwif)
+{
+	u32 attr4 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR4_ADDR);
+
+	return HINIC3_AF4_GET(attr4, DOORBELL_CTRL);
+}
+
+static enum hinic3_outbound_ctrl hinic3_get_outbound_ctrl_status(struct hinic3_hwif *hwif)
+{
+	u32 attr5 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR5_ADDR);
+
+	return HINIC3_AF5_GET(attr5, OUTBOUND_CTRL);
+}
+
+void hinic3_enable_doorbell(struct hinic3_hwif *hwif)
+{
+	u32 addr, attr4;
+
+	addr = HINIC3_CSR_FUNC_ATTR4_ADDR;
+	attr4 = hinic3_hwif_read_reg(hwif, addr);
+
+	attr4 &= ~HINIC3_AF4_DOORBELL_CTRL_MASK;
+	attr4 |= HINIC3_AF4_SET(ENABLE_DOORBELL, DOORBELL_CTRL);
+
+	hinic3_hwif_write_reg(hwif, addr, attr4);
+}
+
+void hinic3_disable_doorbell(struct hinic3_hwif *hwif)
+{
+	u32 addr, attr4;
+
+	addr = HINIC3_CSR_FUNC_ATTR4_ADDR;
+	attr4 = hinic3_hwif_read_reg(hwif, addr);
+
+	attr4 &= ~HINIC3_AF4_DOORBELL_CTRL_MASK;
+	attr4 |= HINIC3_AF4_SET(DISABLE_DOORBELL, DOORBELL_CTRL);
+
+	hinic3_hwif_write_reg(hwif, addr, attr4);
+}
+
+static void set_ppf(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_hwif *hwif = hwdev->hwif;
+	struct hinic3_func_attr *attr;
+	u32 addr, val;
+
+	if (HINIC3_IS_VF(hwdev))
+		return;
+
+	/* Read Modify Write */
+	attr = &hwif->attr;
+	addr = HINIC3_CSR_PPF_ELECTION_ADDR;
+	val = hinic3_hwif_read_reg(hwif, addr);
+	val &= ~HINIC3_PPF_ELECTION_IDX_MASK;
+	val |= HINIC3_PPF_ELECTION_SET(attr->func_global_idx, IDX);
+	hinic3_hwif_write_reg(hwif, addr, val);
+
+	/* Check PPF index */
+	val = hinic3_hwif_read_reg(hwif, addr);
+	attr->ppf_idx = HINIC3_PPF_ELECTION_GET(val, IDX);
+}
+
+static int init_hwif(struct hinic3_hwdev *hwdev, void __iomem *cfg_reg_base,
+		     void __iomem *intr_reg_base, void __iomem *mgmt_regs_base)
+{
+	struct hinic3_hwif *hwif;
+
+	hwif = kzalloc(sizeof(*hwif), GFP_KERNEL);
+	if (!hwif)
+		return -ENOMEM;
+
+	hwdev->hwif = hwif;
+
+	/* if function is VF, mgmt_regs_base will be NULL */
+	hwif->cfg_regs_base = mgmt_regs_base ? cfg_reg_base :
+		(u8 __iomem *)cfg_reg_base + HINIC3_VF_CFG_REG_OFFSET;
+
+	hwif->intr_regs_base = intr_reg_base;
+	hwif->mgmt_regs_base = mgmt_regs_base;
+
+	return 0;
+}
+
+static int db_area_idx_init(struct hinic3_hwif *hwif, u64 db_base_phy,
+			    u8 __iomem *db_base, u64 db_dwqe_len)
+{
+	struct hinic3_db_area *db_area = &hwif->db_area;
+	u32 db_max_areas;
+
+	hwif->db_base_phy = db_base_phy;
+	hwif->db_base = db_base;
+	hwif->db_dwqe_len = db_dwqe_len;
+
+	db_max_areas = (db_dwqe_len > HINIC3_DB_DWQE_SIZE) ?
+		      HINIC3_DB_MAX_AREAS :
+		      (u32)(db_dwqe_len / HINIC3_DB_PAGE_SIZE);
+	db_area->db_bitmap_array = bitmap_zalloc(db_max_areas, GFP_KERNEL);
+	if (!db_area->db_bitmap_array)
+		return -ENOMEM;
+
+	db_area->db_max_areas = db_max_areas;
+	spin_lock_init(&db_area->idx_lock);
+	return 0;
+}
+
+static void db_area_idx_free(struct hinic3_db_area *db_area)
+{
+	kfree(db_area->db_bitmap_array);
+}
+
+static int get_db_idx(struct hinic3_hwif *hwif, u32 *idx)
+{
+	struct hinic3_db_area *db_area = &hwif->db_area;
+	u32 pg_idx;
+
+	spin_lock(&db_area->idx_lock);
+	pg_idx = (u32)find_first_zero_bit(db_area->db_bitmap_array,
+					  db_area->db_max_areas);
+	if (pg_idx == db_area->db_max_areas) {
+		spin_unlock(&db_area->idx_lock);
+		return -ENOMEM;
+	}
+	set_bit(pg_idx, db_area->db_bitmap_array);
+	spin_unlock(&db_area->idx_lock);
+
+	*idx = pg_idx;
+
+	return 0;
+}
+
+static void free_db_idx(struct hinic3_hwif *hwif, u32 idx)
+{
+	struct hinic3_db_area *db_area = &hwif->db_area;
+
+	if (idx >= db_area->db_max_areas)
+		return;
+
+	spin_lock(&db_area->idx_lock);
+	clear_bit(idx, db_area->db_bitmap_array);
+
+	spin_unlock(&db_area->idx_lock);
+}
+
+void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const void __iomem *db_base,
+			 void __iomem *dwqe_base)
+{
+	struct hinic3_hwif *hwif;
+	uintptr_t distance;
+	u32 idx;
+
+	hwif = hwdev->hwif;
+	distance = (const char __iomem *)db_base - (const char __iomem *)hwif->db_base;
+	idx = distance / HINIC3_DB_PAGE_SIZE;
+
+	free_db_idx(hwif, idx);
+}
+
+int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
+			 void __iomem **dwqe_base)
+{
+	struct hinic3_hwif *hwif;
+	u8 __iomem *addr;
+	u32 idx;
+	int err;
+
+	hwif = hwdev->hwif;
+
+	err = get_db_idx(hwif, &idx);
+	if (err)
+		return -EFAULT;
+
+	addr = hwif->db_base + idx * HINIC3_DB_PAGE_SIZE;
+	*db_base = addr;
+
+	if (dwqe_base)
+		*dwqe_base = addr + HINIC3_DWQE_OFFSET;
+
+	return 0;
+}
+
+void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+			   enum hinic3_msix_state flag)
+{
+	struct hinic3_hwif *hwif;
+	u8 int_msk = 1;
+	u32 mask_bits;
+	u32 addr;
+
+	hwif = hwdev->hwif;
+
+	if (flag)
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(int_msk, INT_MSK_SET);
+	else
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(int_msk, INT_MSK_CLR);
+	mask_bits = mask_bits |
+		    HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX);
+
+	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
+	hinic3_hwif_write_reg(hwif, addr, mask_bits);
+}
+
+static void disable_all_msix(struct hinic3_hwdev *hwdev)
+{
+	u16 num_irqs = hwdev->hwif->attr.num_irqs;
+	u16 i;
+
+	for (i = 0; i < num_irqs; i++)
+		hinic3_set_msix_state(hwdev, i, HINIC3_MSIX_DISABLE);
+}
+
+void hinic3_misx_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				       u8 clear_resend_en)
+{
+	struct hinic3_hwif *hwif;
+	u32 msix_ctrl, addr;
+
+	hwif = hwdev->hwif;
+
+	msix_ctrl = HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX) |
+		    HINIC3_MSI_CLR_INDIR_SET(clear_resend_en, RESEND_TIMER_CLR);
+
+	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
+	hinic3_hwif_write_reg(hwif, addr, msix_ctrl);
+}
+
+void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				     enum hinic3_msix_auto_mask flag)
+{
+	struct hinic3_hwif *hwif;
+	u32 mask_bits;
+	u32 addr;
+
+	hwif = hwdev->hwif;
+
+	if (flag)
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(1, AUTO_MSK_SET);
+	else
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(1, AUTO_MSK_CLR);
+
+	mask_bits = mask_bits |
+		    HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX);
+
+	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
+	hinic3_hwif_write_reg(hwif, addr, mask_bits);
+}
+
+static enum hinic3_wait_return check_db_outbound_enable_handler(void *priv_data)
+{
+	enum hinic3_outbound_ctrl outbound_ctrl;
+	struct hinic3_hwif *hwif = priv_data;
+	enum hinic3_doorbell_ctrl db_ctrl;
+
+	db_ctrl = hinic3_get_doorbell_ctrl_status(hwif);
+	outbound_ctrl = hinic3_get_outbound_ctrl_status(hwif);
+	if (outbound_ctrl == ENABLE_OUTBOUND && db_ctrl == ENABLE_DOORBELL)
+		return WAIT_PROCESS_CPL;
+
+	return WAIT_PROCESS_WAITING;
+}
+
+static int wait_until_doorbell_and_outbound_enabled(struct hinic3_hwif *hwif)
+{
+	return hinic3_wait_for_timeout(hwif, check_db_outbound_enable_handler,
+				       DB_AND_OUTBOUND_EN_TIMEOUT,
+				       USEC_PER_MSEC);
+}
+
+void hinic3_set_pf_status(struct hinic3_hwif *hwif,
+			  enum hinic3_pf_status status)
+{
+	u32 attr6 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR);
+
+	attr6 &= ~HINIC3_AF6_PF_STATUS_MASK;
+	attr6 |= HINIC3_AF6_SET(status, PF_STATUS);
+
+	if (hwif->attr.func_type == TYPE_VF)
+		return;
+
+	hinic3_hwif_write_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR, attr6);
+}
+
+enum hinic3_pf_status hinic3_get_pf_status(struct hinic3_hwif *hwif)
+{
+	u32 attr6 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR);
+
+	return HINIC3_AF6_GET(attr6, PF_STATUS);
+}
+
+int hinic3_init_hwif(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_pcidev *pci_adapter = hwdev->adapter;
+	struct hinic3_hwif *hwif;
+	u32 attr1, attr4, attr5;
+	int err;
+
+	err = init_hwif(hwdev, pci_adapter->cfg_reg_base,
+			pci_adapter->intr_reg_base,
+			pci_adapter->mgmt_reg_base);
+	if (err)
+		return err;
+
+	hwif = hwdev->hwif;
+
+	err = db_area_idx_init(hwif, pci_adapter->db_base_phy,
+			       pci_adapter->db_base,
+			       pci_adapter->db_dwqe_len);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init db area.\n");
+		goto err_init_db_area;
+	}
+
+	err = wait_hwif_ready(hwdev);
+	if (err) {
+		attr1 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
+		dev_err(hwdev->dev, "Chip status is not ready, attr1:0x%x\n", attr1);
+		goto err_hwif_ready;
+	}
+
+	err = get_hwif_attr(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Get hwif attr failed\n");
+		goto err_hwif_ready;
+	}
+
+	err = wait_until_doorbell_and_outbound_enabled(hwif);
+	if (err) {
+		attr4 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR4_ADDR);
+		attr5 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR5_ADDR);
+		dev_err(hwdev->dev, "Hw doorbell/outbound is disabled, attr4 0x%x attr5 0x%x\n",
+			attr4, attr5);
+		goto err_hwif_ready;
+	}
+
+	set_ppf(hwdev);
+
+	disable_all_msix(hwdev);
+	/* disable mgmt cpu from reporting any event */
+	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_INIT);
+
+	dev_dbg(hwdev->dev, "global_func_idx: %u, func_type: %d, host_id: %u, ppf: %u\n",
+		hwif->attr.func_global_idx, hwif->attr.func_type, hwif->attr.pci_intf_idx,
+		hwif->attr.ppf_idx);
+
+	return 0;
+
+err_hwif_ready:
+	db_area_idx_free(&hwif->db_area);
+err_init_db_area:
+	kfree(hwif);
+
+	return err;
+}
+
+void hinic3_free_hwif(struct hinic3_hwdev *hwdev)
+{
+	db_area_idx_free(&hwdev->hwif->db_area);
+	kfree(hwdev->hwif);
+}
+
+u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)
+{
+	return hwdev->hwif->attr.func_global_idx;
+}
+
+u8 hinic3_pf_id_of_vf(struct hinic3_hwdev *hwdev)
+{
+	return hwdev->hwif->attr.port_to_port_idx;
+}
+
+u16 hinic3_glb_pf_vf_offset(struct hinic3_hwdev *hwdev)
+{
+	return hwdev->hwif->attr.global_vf_id_of_pf;
+}
+
+u8 hinic3_ppf_idx(struct hinic3_hwdev *hwdev)
+{
+	return hwdev->hwif->attr.ppf_idx;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
new file mode 100644
index 000000000000..5a1c22dd6849
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_HWIF_H
+#define HINIC3_HWIF_H
+
+#include "hinic3_common.h"
+
+struct hinic3_hwdev;
+
+enum func_type {
+	TYPE_PF = 0,
+	TYPE_VF = 1,
+};
+
+enum hinic3_fault_err_level {
+	FAULT_LEVEL_FATAL,
+	FAULT_LEVEL_SERIOUS_RESET,
+	FAULT_LEVEL_HOST,
+	FAULT_LEVEL_SERIOUS_FLR,
+	FAULT_LEVEL_GENERAL,
+	FAULT_LEVEL_SUGGESTION,
+	FAULT_LEVEL_MAX,
+};
+
+struct hinic3_db_area {
+	unsigned long *db_bitmap_array;
+	u32           db_max_areas;
+	/* protect doorbell area alloc and free */
+	spinlock_t    idx_lock;
+};
+
+struct hinic3_func_attr {
+	enum func_type func_type;
+	u16            func_global_idx;
+	u16            global_vf_id_of_pf;
+	/* max: 2 ^ 15 */
+	u16            num_irqs;
+	/* max: 2 ^ 8 */
+	u16            num_sq;
+	u8             port_to_port_idx;
+	u8             pci_intf_idx;
+	u8             ppf_idx;
+	/* max: 2 ^ 3 */
+	u8             num_aeqs;
+	/* max: 2 ^ 7 */
+	u8             num_ceqs;
+	u8             msix_flex_en;
+};
+
+static_assert(sizeof(struct hinic3_func_attr) == 20);
+
+struct hinic3_hwif {
+	u8 __iomem              *cfg_regs_base;
+	u8 __iomem              *intr_regs_base;
+	u8 __iomem              *mgmt_regs_base;
+	u64                     db_base_phy;
+	u64                     db_dwqe_len;
+	u8 __iomem              *db_base;
+	struct hinic3_db_area   db_area;
+	struct hinic3_func_attr attr;
+};
+
+enum hinic3_outbound_ctrl {
+	ENABLE_OUTBOUND  = 0x0,
+	DISABLE_OUTBOUND = 0x1,
+};
+
+enum hinic3_doorbell_ctrl {
+	ENABLE_DOORBELL  = 0x0,
+	DISABLE_DOORBELL = 0x1,
+};
+
+enum hinic3_pf_status {
+	HINIC3_PF_STATUS_INIT            = 0x0,
+	HINIC3_PF_STATUS_ACTIVE_FLAG     = 0x11,
+	HINIC3_PF_STATUS_FLR_START_FLAG  = 0x12,
+	HINIC3_PF_STATUS_FLR_FINISH_FLAG = 0x13,
+};
+
+enum hinic3_msix_state {
+	HINIC3_MSIX_ENABLE,
+	HINIC3_MSIX_DISABLE,
+};
+
+enum hinic3_msix_auto_mask {
+	HINIC3_CLR_MSIX_AUTO_MASK,
+	HINIC3_SET_MSIX_AUTO_MASK,
+};
+
+#define HINIC3_FUNC_TYPE(hwdev)  ((hwdev)->hwif->attr.func_type)
+#define HINIC3_IS_PF(hwdev)      (HINIC3_FUNC_TYPE(hwdev) == TYPE_PF)
+#define HINIC3_IS_VF(hwdev)      (HINIC3_FUNC_TYPE(hwdev) == TYPE_VF)
+
+u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg);
+void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val);
+
+void hinic3_disable_doorbell(struct hinic3_hwif *hwif);
+void hinic3_enable_doorbell(struct hinic3_hwif *hwif);
+
+int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
+			 void __iomem **dwqe_base);
+void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const void __iomem *db_base,
+			 void __iomem *dwqe_base);
+
+void hinic3_set_pf_status(struct hinic3_hwif *hwif,
+			  enum hinic3_pf_status status);
+enum hinic3_pf_status hinic3_get_pf_status(struct hinic3_hwif *hwif);
+
+int hinic3_init_hwif(struct hinic3_hwdev *hwdev);
+void hinic3_free_hwif(struct hinic3_hwdev *hwdev);
+
+void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+			   enum hinic3_msix_state flag);
+void hinic3_misx_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				       u8 clear_resend_en);
+void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				     enum hinic3_msix_auto_mask flag);
+
+u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev);
+u8 hinic3_pf_id_of_vf(struct hinic3_hwdev *hwdev);
+u16 hinic3_glb_pf_vf_offset(struct hinic3_hwdev *hwdev);
+u8 hinic3_ppf_idx(struct hinic3_hwdev *hwdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
new file mode 100644
index 000000000000..66866a40b686
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/debugfs.h>
+
+#include "hinic3_hw_comm.h"
+#include "hinic3_hwif.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_tx.h"
+#include "hinic3_rx.h"
+
+#define HINIC3_RX_RATE_THRESH  50000
+#define HINIC3_AVG_PKT_SMALL   256U
+#define HINIC3_LOWEST_LATENCY  3
+
+static int hinic3_poll(struct napi_struct *napi, int budget)
+{
+	struct hinic3_irq *irq_cfg =
+		container_of(napi, struct hinic3_irq, napi);
+	struct hinic3_nic_dev *nic_dev;
+	int tx_pkts, rx_pkts;
+
+	nic_dev = netdev_priv(irq_cfg->netdev);
+	rx_pkts = hinic3_rx_poll(irq_cfg->rxq, budget);
+
+	tx_pkts = hinic3_tx_poll(irq_cfg->txq, budget);
+	if (tx_pkts >= budget || rx_pkts >= budget)
+		return budget;
+
+	napi_complete(napi);
+
+	hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+			      HINIC3_MSIX_ENABLE);
+
+	return max(tx_pkts, rx_pkts);
+}
+
+static void qp_add_napi(struct hinic3_irq *irq_cfg)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(irq_cfg->netdev);
+
+	netif_napi_add(nic_dev->netdev, &irq_cfg->napi, hinic3_poll);
+	napi_enable(&irq_cfg->napi);
+}
+
+static void qp_del_napi(struct hinic3_irq *irq_cfg)
+{
+	napi_disable(&irq_cfg->napi);
+	netif_napi_del(&irq_cfg->napi);
+}
+
+static irqreturn_t qp_irq(int irq, void *data)
+{
+	struct hinic3_irq *irq_cfg = data;
+	struct hinic3_nic_dev *nic_dev;
+
+	nic_dev = netdev_priv(irq_cfg->netdev);
+	hinic3_misx_intr_clear_resend_bit(nic_dev->hwdev, irq_cfg->msix_entry_idx, 1);
+
+	napi_schedule(&irq_cfg->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int hinic3_request_irq(struct hinic3_irq *irq_cfg, u16 q_id)
+{
+	struct interrupt_info info = {};
+	struct hinic3_nic_dev *nic_dev;
+	struct net_device *netdev;
+	int err;
+
+	netdev = irq_cfg->netdev;
+	nic_dev = netdev_priv(netdev);
+	qp_add_napi(irq_cfg);
+
+	info.msix_index = irq_cfg->msix_entry_idx;
+	info.lli_set = 0;
+	info.interrupt_coalesc_set = 1;
+	info.pending_limt = nic_dev->intr_coalesce[q_id].pending_limt;
+	info.coalesc_timer_cfg =
+		nic_dev->intr_coalesce[q_id].coalesce_timer_cfg;
+	info.resend_timer_cfg = nic_dev->intr_coalesce[q_id].resend_timer_cfg;
+	nic_dev->rxqs[q_id].last_coalesc_timer_cfg =
+			nic_dev->intr_coalesce[q_id].coalesce_timer_cfg;
+	nic_dev->rxqs[q_id].last_pending_limt =
+			nic_dev->intr_coalesce[q_id].pending_limt;
+	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
+	if (err) {
+		netdev_err(netdev, "Failed to set RX interrupt coalescing attribute.\n");
+		qp_del_napi(irq_cfg);
+		return err;
+	}
+
+	err = request_irq(irq_cfg->irq_id, &qp_irq, 0, irq_cfg->irq_name, irq_cfg);
+	if (err) {
+		netdev_err(netdev, "Failed to request Rx irq\n");
+		qp_del_napi(irq_cfg);
+		return err;
+	}
+
+	irq_set_affinity_hint(irq_cfg->irq_id, &irq_cfg->affinity_mask);
+
+	return 0;
+}
+
+static void hinic3_release_irq(struct hinic3_irq *irq_cfg)
+{
+	irq_set_affinity_hint(irq_cfg->irq_id, NULL);
+	synchronize_irq(irq_cfg->irq_id);
+	free_irq(irq_cfg->irq_id, irq_cfg);
+	qp_del_napi(irq_cfg);
+}
+
+static int set_interrupt_moder(struct net_device *netdev, u16 q_id,
+			       u8 coalesc_timer_cfg, u8 pending_limt)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct interrupt_info info;
+	int err;
+
+	memset(&info, 0, sizeof(info));
+
+	if (coalesc_timer_cfg == nic_dev->rxqs[q_id].last_coalesc_timer_cfg &&
+	    pending_limt == nic_dev->rxqs[q_id].last_pending_limt)
+		return 0;
+
+	if (!HINIC3_CHANNEL_RES_VALID(nic_dev) ||
+	    q_id >= nic_dev->q_params.num_qps)
+		return 0;
+
+	info.lli_set = 0;
+	info.interrupt_coalesc_set = 1;
+	info.coalesc_timer_cfg = coalesc_timer_cfg;
+	info.pending_limt = pending_limt;
+	info.msix_index = nic_dev->q_params.irq_cfg[q_id].msix_entry_idx;
+	info.resend_timer_cfg =
+		nic_dev->intr_coalesce[q_id].resend_timer_cfg;
+
+	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
+	if (err) {
+		netdev_err(netdev, "Failed to modify moderation for Queue: %u\n", q_id);
+	} else {
+		nic_dev->rxqs[q_id].last_coalesc_timer_cfg = coalesc_timer_cfg;
+		nic_dev->rxqs[q_id].last_pending_limt = pending_limt;
+	}
+
+	return err;
+}
+
+static void calc_coal_para(struct hinic3_intr_coal_info *q_coal, u64 rx_rate,
+			   u8 *coalesc_timer_cfg, u8 *pending_limt)
+{
+	if (rx_rate < q_coal->pkt_rate_low) {
+		*coalesc_timer_cfg = q_coal->rx_usecs_low;
+		*pending_limt = q_coal->rx_pending_limt_low;
+	} else if (rx_rate > q_coal->pkt_rate_high) {
+		*coalesc_timer_cfg = q_coal->rx_usecs_high;
+		*pending_limt = q_coal->rx_pending_limt_high;
+	} else {
+		*coalesc_timer_cfg =
+			(u8)((rx_rate - q_coal->pkt_rate_low) *
+			     (q_coal->rx_usecs_high - q_coal->rx_usecs_low) /
+			     (q_coal->pkt_rate_high - q_coal->pkt_rate_low) +
+			     q_coal->rx_usecs_low);
+
+		*pending_limt =
+			(u8)((rx_rate - q_coal->pkt_rate_low) *
+			     (q_coal->rx_pending_limt_high - q_coal->rx_pending_limt_low) /
+			     (q_coal->pkt_rate_high - q_coal->pkt_rate_low) +
+			     q_coal->rx_pending_limt_low);
+	}
+}
+
+static void update_queue_coal(struct net_device *netdev, u16 qid,
+			      u64 rx_rate, u64 avg_pkt_size, u64 tx_rate)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *q_coal;
+	u8 coalesc_timer_cfg, pending_limt;
+
+	q_coal = &nic_dev->intr_coalesce[qid];
+
+	if (rx_rate > HINIC3_RX_RATE_THRESH && avg_pkt_size > HINIC3_AVG_PKT_SMALL) {
+		calc_coal_para(q_coal, rx_rate, &coalesc_timer_cfg, &pending_limt);
+	} else {
+		coalesc_timer_cfg = HINIC3_LOWEST_LATENCY;
+		pending_limt = q_coal->rx_pending_limt_low;
+	}
+
+	set_interrupt_moder(netdev, qid, coalesc_timer_cfg, pending_limt);
+}
+
+static void hinic3_auto_moderation_work(struct work_struct *work)
+{
+	u64 rx_packets, rx_bytes, rx_pkt_diff, rx_rate, avg_pkt_size;
+	u64 tx_packets, tx_bytes, tx_pkt_diff, tx_rate;
+	struct hinic3_nic_dev *nic_dev;
+	struct delayed_work *delay;
+	struct net_device *netdev;
+	unsigned long period;
+	u16 qid;
+
+	delay = to_delayed_work(work);
+	nic_dev = container_of(delay, struct hinic3_nic_dev, moderation_task);
+	period = (unsigned long)(jiffies - nic_dev->last_moder_jiffies);
+	netdev = nic_dev->netdev;
+	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags))
+		return;
+
+	queue_delayed_work(nic_dev->workq, &nic_dev->moderation_task,
+			   HINIC3_MODERATONE_DELAY);
+
+	if (!nic_dev->adaptive_rx_coal || !period)
+		return;
+
+	for (qid = 0; qid < nic_dev->q_params.num_qps; qid++) {
+		rx_packets = nic_dev->rxqs[qid].rxq_stats.packets;
+		rx_bytes = nic_dev->rxqs[qid].rxq_stats.bytes;
+		tx_packets = nic_dev->txqs[qid].txq_stats.packets;
+		tx_bytes = nic_dev->txqs[qid].txq_stats.bytes;
+
+		rx_pkt_diff =
+			rx_packets - nic_dev->rxqs[qid].last_moder_packets;
+		avg_pkt_size = rx_pkt_diff ?
+			((unsigned long)(rx_bytes -
+			 nic_dev->rxqs[qid].last_moder_bytes)) /
+			 rx_pkt_diff : 0;
+
+		rx_rate = rx_pkt_diff * HZ / period;
+		tx_pkt_diff =
+			tx_packets - nic_dev->txqs[qid].last_moder_packets;
+		tx_rate = tx_pkt_diff * HZ / period;
+
+		update_queue_coal(netdev, qid, rx_rate, avg_pkt_size,
+				  tx_rate);
+
+		nic_dev->rxqs[qid].last_moder_packets = rx_packets;
+		nic_dev->rxqs[qid].last_moder_bytes = rx_bytes;
+		nic_dev->txqs[qid].last_moder_packets = tx_packets;
+		nic_dev->txqs[qid].last_moder_bytes = tx_bytes;
+	}
+
+	nic_dev->last_moder_jiffies = jiffies;
+}
+
+int hinic3_qps_irq_init(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct pci_dev *pdev = nic_dev->pdev;
+	struct irq_info *qp_irq_info;
+	struct hinic3_irq *irq_cfg;
+	u32 local_cpu;
+	u16 q_id, i;
+	int err;
+
+	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
+		qp_irq_info = &nic_dev->qps_irq_info[q_id];
+		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
+
+		irq_cfg->irq_id = qp_irq_info->irq_id;
+		irq_cfg->msix_entry_idx = qp_irq_info->msix_entry_idx;
+		irq_cfg->netdev = netdev;
+		irq_cfg->txq = &nic_dev->txqs[q_id];
+		irq_cfg->rxq = &nic_dev->rxqs[q_id];
+		nic_dev->rxqs[q_id].irq_cfg = irq_cfg;
+
+		local_cpu = cpumask_local_spread(q_id, dev_to_node(&pdev->dev));
+		cpumask_set_cpu(local_cpu, &irq_cfg->affinity_mask);
+
+		snprintf(irq_cfg->irq_name, sizeof(irq_cfg->irq_name),
+			 "%s_qp%u", netdev->name, q_id);
+
+		err = hinic3_request_irq(irq_cfg, q_id);
+		if (err) {
+			netdev_err(netdev, "Failed to request Rx irq\n");
+			goto err_req_tx_irq;
+		}
+
+		hinic3_set_msix_auto_mask_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+						HINIC3_SET_MSIX_AUTO_MASK);
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx, HINIC3_MSIX_ENABLE);
+	}
+
+	INIT_DELAYED_WORK(&nic_dev->moderation_task, hinic3_auto_moderation_work);
+
+	return 0;
+
+err_req_tx_irq:
+	for (i = 0; i < q_id; i++) {
+		irq_cfg = &nic_dev->q_params.irq_cfg[i];
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx, HINIC3_MSIX_DISABLE);
+		hinic3_set_msix_auto_mask_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+						HINIC3_CLR_MSIX_AUTO_MASK);
+		hinic3_release_irq(irq_cfg);
+	}
+
+	return err;
+}
+
+void hinic3_qps_irq_deinit(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_irq *irq_cfg;
+	u16 q_id;
+
+	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
+		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+				      HINIC3_MSIX_DISABLE);
+		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
+						irq_cfg->msix_entry_idx,
+						HINIC3_CLR_MSIX_AUTO_MASK);
+		hinic3_release_irq(irq_cfg);
+	}
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
new file mode 100644
index 000000000000..1947620f2ba0
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <net/addrconf.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/io-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/inetdevice.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <linux/rtc.h>
+#include <linux/aer.h>
+#include <linux/debugfs.h>
+
+#include "hinic3_pci_id_tbl.h"
+#include "hinic3_common.h"
+#include "hinic3_hwif.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_hw_cfg.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_lld.h"
+
+#define HINIC3_VF_PCI_CFG_REG_BAR  0
+#define HINIC3_PF_PCI_CFG_REG_BAR  1
+#define HINIC3_PCI_INTR_REG_BAR    2
+/* Only PF has mgmt bar */
+#define HINIC3_PCI_MGMT_REG_BAR    3
+#define HINIC3_PCI_DB_BAR          4
+
+#define HINIC3_IS_VF_DEV(pdev)     ((pdev)->device == PCI_DEV_ID_HINIC3_VF)
+
+#define HINIC3_EVENT_PROCESS_TIMEOUT 10000
+
+static struct hinic3_adev_device {
+	const char *name;
+} hinic3_adev_devices[SERVICE_T_MAX] = {
+	[SERVICE_T_NIC] = {
+		.name = "nic",
+	},
+};
+
+static bool hinic3_adev_svc_supported(struct hinic3_hwdev *hwdev,
+				      enum hinic3_service_type svc_type)
+{
+	switch (svc_type) {
+	case SERVICE_T_NIC:
+		return hinic3_support_nic(hwdev);
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static void hinic3_comm_adev_release(struct device *dev)
+{
+	struct hinic3_adev *hadev = container_of(dev, struct hinic3_adev, adev.dev);
+
+	kfree(hadev);
+}
+
+static struct hinic3_adev *hinic3_add_one_adev(struct hinic3_hwdev *hwdev,
+					       enum hinic3_service_type svc_type)
+{
+	struct hinic3_adev *hadev;
+	const char *svc_name;
+	int ret;
+
+	hadev = kzalloc(sizeof(*hadev), GFP_KERNEL);
+	if (!hadev)
+		return NULL;
+
+	svc_name = hinic3_adev_devices[svc_type].name;
+	hadev->adev.name = svc_name;
+	hadev->adev.id = hwdev->dev_id;
+	hadev->adev.dev.parent = hwdev->dev;
+	hadev->adev.dev.release = hinic3_comm_adev_release;
+	hadev->svc_type = svc_type;
+	hadev->hwdev = hwdev;
+
+	ret = auxiliary_device_init(&hadev->adev);
+	if (ret) {
+		dev_err(hwdev->dev, "failed init adev %s %u\n",
+			svc_name, hwdev->dev_id);
+		kfree(hadev);
+		return NULL;
+	}
+
+	ret = auxiliary_device_add(&hadev->adev);
+	if (ret) {
+		dev_err(hwdev->dev, "failed to add adev %s %u\n",
+			svc_name, hwdev->dev_id);
+		auxiliary_device_uninit(&hadev->adev);
+		return NULL;
+	}
+
+	return hadev;
+}
+
+static void hinic3_del_one_adev(struct hinic3_hwdev *hwdev,
+				enum hinic3_service_type svc_type)
+{
+	struct hinic3_pcidev *pci_adapter = hwdev->adapter;
+	struct hinic3_adev *hadev;
+	bool timeout = true;
+	unsigned long end;
+
+	end = jiffies + msecs_to_jiffies(HINIC3_EVENT_PROCESS_TIMEOUT);
+	do {
+		if (!test_and_set_bit(svc_type, &pci_adapter->state)) {
+			timeout = false;
+			break;
+		}
+		usleep_range(900, 1000);
+	} while (time_before(jiffies, end));
+
+	if (timeout && !test_and_set_bit(svc_type, &pci_adapter->state))
+		timeout = false;
+
+	hadev = pci_adapter->hadev[svc_type];
+	auxiliary_device_delete(&hadev->adev);
+	auxiliary_device_uninit(&hadev->adev);
+	pci_adapter->hadev[svc_type] = NULL;
+	if (!timeout)
+		clear_bit(svc_type, &pci_adapter->state);
+}
+
+static int hinic3_attach_aux_devices(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_pcidev *pci_adapter = hwdev->adapter;
+	enum hinic3_service_type svc_type;
+
+	mutex_lock(&pci_adapter->pdev_mutex);
+
+	for (svc_type = 0; svc_type < SERVICE_T_MAX; svc_type++) {
+		if (!hinic3_adev_svc_supported(hwdev, svc_type))
+			continue;
+
+		pci_adapter->hadev[svc_type] = hinic3_add_one_adev(hwdev, svc_type);
+		if (!pci_adapter->hadev[svc_type])
+			goto err_add_one_adev;
+	}
+	mutex_unlock(&pci_adapter->pdev_mutex);
+	return 0;
+
+err_add_one_adev:
+	while (svc_type > 0) {
+		svc_type--;
+		if (pci_adapter->hadev[svc_type]) {
+			hinic3_del_one_adev(hwdev, svc_type);
+			pci_adapter->hadev[svc_type] = NULL;
+		}
+	}
+	mutex_unlock(&pci_adapter->pdev_mutex);
+	return -ENOMEM;
+}
+
+static void hinic3_detach_aux_devices(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_pcidev *pci_adapter = hwdev->adapter;
+	int i;
+
+	mutex_lock(&pci_adapter->pdev_mutex);
+	for (i = 0; i < ARRAY_SIZE(hinic3_adev_devices); i++) {
+		if (pci_adapter->hadev[i])
+			hinic3_del_one_adev(hwdev, i);
+	}
+	mutex_unlock(&pci_adapter->pdev_mutex);
+}
+
+struct hinic3_hwdev *adev_get_hwdev(struct auxiliary_device *adev)
+{
+	struct hinic3_adev *hadev;
+
+	hadev = container_of(adev, struct hinic3_adev, adev);
+	return hadev->hwdev;
+}
+
+int hinic3_adev_event_register(struct auxiliary_device *adev,
+			       void (*event_handler)(struct auxiliary_device *adev,
+						     struct hinic3_event_info *event))
+{
+	struct hinic3_adev *hadev;
+
+	hadev = container_of(adev, struct hinic3_adev, adev);
+	hadev->event = event_handler;
+	return 0;
+}
+
+static void hinic3_sync_time_to_fw(struct hinic3_pcidev *pdev_pri)
+{
+	struct timespec64 ts;
+	u64 tv_msec;
+	int err;
+
+	ktime_get_real_ts64(&ts);
+
+	tv_msec = (u64)(ts.tv_sec * MSEC_PER_SEC + ts.tv_nsec / NSEC_PER_MSEC);
+	err = hinic3_sync_time(pdev_pri->hwdev, tv_msec);
+	if (err) {
+		dev_err(&pdev_pri->pdev->dev,
+			"Synchronize UTC time to firmware failed, errno:%d.\n",
+			err);
+	}
+}
+
+static int mapping_bar(struct pci_dev *pdev,
+		       struct hinic3_pcidev *pci_adapter)
+{
+	int cfg_bar;
+
+	cfg_bar = HINIC3_IS_VF_DEV(pdev) ?
+			HINIC3_VF_PCI_CFG_REG_BAR : HINIC3_PF_PCI_CFG_REG_BAR;
+
+	pci_adapter->cfg_reg_base = pci_ioremap_bar(pdev, cfg_bar);
+	if (!pci_adapter->cfg_reg_base) {
+		dev_err(&pdev->dev, "Failed to map configuration regs\n");
+		return -ENOMEM;
+	}
+
+	pci_adapter->intr_reg_base = pci_ioremap_bar(pdev,
+						     HINIC3_PCI_INTR_REG_BAR);
+	if (!pci_adapter->intr_reg_base) {
+		dev_err(&pdev->dev, "Failed to map interrupt regs\n");
+		goto err_map_intr_bar;
+	}
+
+	if (!HINIC3_IS_VF_DEV(pdev)) {
+		pci_adapter->mgmt_reg_base =
+			pci_ioremap_bar(pdev, HINIC3_PCI_MGMT_REG_BAR);
+		if (!pci_adapter->mgmt_reg_base) {
+			dev_err(&pdev->dev, "Failed to map mgmt regs\n");
+			goto err_map_mgmt_bar;
+		}
+	}
+
+	pci_adapter->db_base_phy = pci_resource_start(pdev, HINIC3_PCI_DB_BAR);
+	pci_adapter->db_dwqe_len = pci_resource_len(pdev, HINIC3_PCI_DB_BAR);
+	pci_adapter->db_base = pci_ioremap_bar(pdev, HINIC3_PCI_DB_BAR);
+	if (!pci_adapter->db_base) {
+		dev_err(&pdev->dev, "Failed to map doorbell regs\n");
+		goto err_map_db;
+	}
+
+	return 0;
+
+err_map_db:
+	if (!HINIC3_IS_VF_DEV(pdev))
+		iounmap(pci_adapter->mgmt_reg_base);
+
+err_map_mgmt_bar:
+	iounmap(pci_adapter->intr_reg_base);
+
+err_map_intr_bar:
+	iounmap(pci_adapter->cfg_reg_base);
+
+	return -ENOMEM;
+}
+
+static void unmapping_bar(struct hinic3_pcidev *pci_adapter)
+{
+	iounmap(pci_adapter->db_base);
+	if (!HINIC3_IS_VF_DEV(pci_adapter->pdev))
+		iounmap(pci_adapter->mgmt_reg_base);
+
+	iounmap(pci_adapter->intr_reg_base);
+	iounmap(pci_adapter->cfg_reg_base);
+}
+
+static int hinic3_pci_init(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter;
+	int err;
+
+	pci_adapter = kzalloc(sizeof(*pci_adapter), GFP_KERNEL);
+	if (!pci_adapter)
+		return -ENOMEM;
+
+	pci_adapter->pdev = pdev;
+	mutex_init(&pci_adapter->pdev_mutex);
+
+	pci_set_drvdata(pdev, pci_adapter);
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to enable PCI device\n");
+		goto err_pci_enable;
+	}
+
+	err = pci_request_regions(pdev, HINIC3_NIC_DRV_NAME);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to request regions\n");
+		goto err_pci_regions;
+	}
+
+	pci_set_master(pdev);
+
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_warn(&pdev->dev, "Couldn't set 64-bit DMA mask\n");
+		/* try 32 bit DMA mask if 64 bit fails */
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (err) {
+			dev_err(&pdev->dev, "Failed to set DMA mask\n");
+			goto err_dma_mask;
+		}
+	}
+
+	return 0;
+
+err_dma_mask:
+	pci_clear_master(pdev);
+	pci_release_regions(pdev);
+
+err_pci_regions:
+	pci_disable_device(pdev);
+
+err_pci_enable:
+	pci_set_drvdata(pdev, NULL);
+	mutex_destroy(&pci_adapter->pdev_mutex);
+	kfree(pci_adapter);
+
+	return err;
+}
+
+static void hinic3_pci_deinit(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+
+	pci_clear_master(pdev);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+	mutex_destroy(&pci_adapter->pdev_mutex);
+	kfree(pci_adapter);
+}
+
+static int hinic3_func_init(struct pci_dev *pdev, struct hinic3_pcidev *pci_adapter)
+{
+	int err;
+
+	err = hinic3_init_hwdev(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to initialize hardware device\n");
+		return -EFAULT;
+	}
+
+	if (HINIC3_IS_PF(pci_adapter->hwdev))
+		hinic3_sync_time_to_fw(pci_adapter);
+
+	err = hinic3_attach_aux_devices(pci_adapter->hwdev);
+	if (err)
+		goto err_attatch_aux_devices;
+
+	return 0;
+
+err_attatch_aux_devices:
+	hinic3_free_hwdev(pci_adapter->hwdev);
+
+	return err;
+}
+
+static void hinic3_func_deinit(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+
+	/* disable mgmt reporting before flushing mgmt work-queue. */
+	hinic3_set_pf_status(pci_adapter->hwdev->hwif, HINIC3_PF_STATUS_INIT);
+	hinic3_flush_mgmt_workq(pci_adapter->hwdev);
+	hinic3_detach_aux_devices(pci_adapter->hwdev);
+	hinic3_free_hwdev(pci_adapter->hwdev);
+}
+
+static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
+{
+	struct pci_dev *pdev = pci_adapter->pdev;
+	int err;
+
+	err = mapping_bar(pdev, pci_adapter);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to map bar\n");
+		goto err_map_bar;
+	}
+
+	err = hinic3_func_init(pdev, pci_adapter);
+	if (err)
+		goto err_func_init;
+
+	if (HINIC3_IS_PF(pci_adapter->hwdev)) {
+		err = hinic3_set_bdf_ctxt(pci_adapter->hwdev, pdev->bus->number,
+					  PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+		if (err) {
+			dev_err(&pdev->dev, "Failed to set BDF info to fw\n");
+			goto err_set_bdf;
+		}
+	}
+
+	return 0;
+
+err_set_bdf:
+	hinic3_func_deinit(pdev);
+
+err_func_init:
+	unmapping_bar(pci_adapter);
+
+err_map_bar:
+	dev_err(&pdev->dev, "Pcie device probe function failed\n");
+	return err;
+}
+
+static int hinic3_remove_func(struct hinic3_pcidev *pci_adapter)
+{
+	struct pci_dev *pdev = pci_adapter->pdev;
+
+	hinic3_func_deinit(pdev);
+
+	unmapping_bar(pci_adapter);
+
+	return 0;
+}
+
+static int hinic3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	u16 probe_fault_level = FAULT_LEVEL_SERIOUS_FLR;
+	struct hinic3_pcidev *pci_adapter;
+	int err;
+
+	err = hinic3_pci_init(pdev);
+	if (err)
+		goto out;
+
+	pci_adapter = pci_get_drvdata(pdev);
+	pci_adapter->id = *id;
+	pci_adapter->probe_fault_level = probe_fault_level;
+
+	err = hinic3_probe_func(pci_adapter);
+	if (err)
+		goto err_hinic3_probe_func;
+
+	return 0;
+
+err_hinic3_probe_func:
+	probe_fault_level = pci_adapter->probe_fault_level;
+	hinic3_pci_deinit(pdev);
+
+out:
+	dev_err(&pdev->dev, "Pcie device probe failed\n");
+	return err;
+}
+
+static void hinic3_remove(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+
+	if (!pci_adapter)
+		return;
+
+	hinic3_remove_func(pci_adapter);
+
+	hinic3_pci_deinit(pdev);
+}
+
+static const struct pci_device_id hinic3_pci_table[] = {
+	{PCI_VDEVICE(HUAWEI, PCI_DEV_ID_HINIC3_PF), 0},
+	{PCI_VDEVICE(HUAWEI, PCI_DEV_ID_HINIC3_VF), 0},
+	{0, 0}
+
+};
+
+MODULE_DEVICE_TABLE(pci, hinic3_pci_table);
+
+static void hinic3_shutdown(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+
+	pci_disable_device(pdev);
+
+	if (pci_adapter)
+		hinic3_set_api_stop(pci_adapter->hwdev);
+}
+
+static struct pci_driver hinic3_driver = {
+	.name            = HINIC3_NIC_DRV_NAME,
+	.id_table        = hinic3_pci_table,
+	.probe           = hinic3_probe,
+	.remove          = hinic3_remove,
+	.shutdown        = hinic3_shutdown,
+	.sriov_configure = pci_sriov_configure_simple
+};
+
+int hinic3_lld_init(void)
+{
+	return pci_register_driver(&hinic3_driver);
+}
+
+void hinic3_lld_exit(void)
+{
+	pci_unregister_driver(&hinic3_driver);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.h b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.h
new file mode 100644
index 000000000000..00b8af5aa960
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_LLD_H
+#define HINIC3_LLD_H
+
+#include <linux/auxiliary_bus.h>
+#include "hinic3_hwdev.h"
+
+#define HINIC3_NIC_DRV_NAME "hinic3"
+
+int hinic3_lld_init(void);
+void hinic3_lld_exit(void);
+int hinic3_adev_event_register(struct auxiliary_device *adev,
+			       void (*event_handler)(struct auxiliary_device *adev,
+						     struct hinic3_event_info *event));
+struct hinic3_hwdev *adev_get_hwdev(struct auxiliary_device *adev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
new file mode 100644
index 000000000000..02ca074c34a2
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -0,0 +1,691 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/netdevice.h>
+#include <linux/if_vlan.h>
+#include <linux/auxiliary_bus.h>
+
+#include "hinic3_hw_cfg.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_lld.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_tx.h"
+#include "hinic3_rx.h"
+#include "hinic3_rss.h"
+
+#define HINIC3_NIC_DRV_DESC  "Intelligent Network Interface Card Driver"
+
+#define DEFAULT_MSG_ENABLE           (NETIF_MSG_DRV | NETIF_MSG_LINK)
+#define HINIC3_RX_BUFF_LEN           2048
+#define HINIC3_RX_BUFF_NUM_PER_PAGE  2
+#define HINIC3_LRO_REPLENISH_THLD    256
+#define HINIC3_NIC_DEV_WQ_NAME       "hinic3_nic_dev_wq"
+
+#define HINIC3_SQ_DEPTH              1024
+#define HINIC3_RQ_DEPTH              1024
+
+#define HINIC3_DEAULT_TXRX_MSIX_PENDING_LIMIT       2
+#define HINIC3_DEAULT_TXRX_MSIX_COALESC_TIMER_CFG   25
+#define HINIC3_DEAULT_TXRX_MSIX_RESEND_TIMER_CFG    7
+
+#define HINIC3_RX_RATE_LOW            200000
+#define HINIC3_RX_COAL_TIME_LOW       25
+#define HINIC3_RX_PENDING_LIMIT_LOW   2
+
+#define HINIC3_RX_RATE_HIGH           700000
+#define HINIC3_RX_COAL_TIME_HIGH      225
+#define HINIC3_RX_PENDING_LIMIT_HIGH  8
+
+#define HINIC3_WATCHDOG_TIMEOUT      5
+
+#define HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT  1
+#define HINIC3_VLAN_CLEAR_OFFLOAD \
+	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
+	 NETIF_F_SCTP_CRC | NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
+
+static int hinic3_netdev_event(struct notifier_block *notifier, unsigned long event, void *ptr);
+
+/* used for netdev notifier register/unregister */
+static DEFINE_MUTEX(hinic3_netdev_notifiers_mutex);
+static int hinic3_netdev_notifiers_ref_cnt;
+static struct notifier_block hinic3_netdev_notifier = {
+	.notifier_call = hinic3_netdev_event,
+};
+
+static u16 hinic3_get_vlan_depth(struct net_device *netdev)
+{
+	u16 vlan_depth = 0;
+
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+	while (is_vlan_dev(netdev)) {
+		netdev = vlan_dev_priv(netdev)->real_dev;
+		vlan_depth++;
+	}
+#endif
+	return vlan_depth;
+}
+
+static int hinic3_netdev_event(struct notifier_block *notifier, unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	u16 vlan_depth;
+
+	if (!is_vlan_dev(ndev))
+		return NOTIFY_DONE;
+
+	dev_hold(ndev);
+
+	switch (event) {
+	case NETDEV_REGISTER:
+		vlan_depth = hinic3_get_vlan_depth(ndev);
+		if (vlan_depth == HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT) {
+			ndev->vlan_features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
+		} else if (vlan_depth > HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT) {
+			ndev->hw_features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
+			ndev->features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
+		}
+
+		break;
+
+	default:
+		break;
+	};
+
+	dev_put(ndev);
+
+	return NOTIFY_DONE;
+}
+
+static void init_intr_coal_param(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *info;
+	u16 i;
+
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		info = &nic_dev->intr_coalesce[i];
+
+		info->pending_limt = HINIC3_DEAULT_TXRX_MSIX_PENDING_LIMIT;
+		info->coalesce_timer_cfg = HINIC3_DEAULT_TXRX_MSIX_COALESC_TIMER_CFG;
+
+		info->resend_timer_cfg = HINIC3_DEAULT_TXRX_MSIX_RESEND_TIMER_CFG;
+
+		info->pkt_rate_high = HINIC3_RX_RATE_HIGH;
+		info->rx_usecs_high = HINIC3_RX_COAL_TIME_HIGH;
+		info->rx_pending_limt_high = HINIC3_RX_PENDING_LIMIT_HIGH;
+
+		info->pkt_rate_low = HINIC3_RX_RATE_LOW;
+		info->rx_usecs_low = HINIC3_RX_COAL_TIME_LOW;
+		info->rx_pending_limt_low = HINIC3_RX_PENDING_LIMIT_LOW;
+	}
+}
+
+static int hinic3_init_intr_coalesce(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	u64 size;
+
+	size = sizeof(*nic_dev->intr_coalesce) * nic_dev->max_qps;
+	if (!size) {
+		dev_err(hwdev->dev, "Cannot allocate zero size intr coalesce\n");
+		return -EINVAL;
+	}
+	nic_dev->intr_coalesce = kzalloc(size, GFP_KERNEL);
+	if (!nic_dev->intr_coalesce)
+		return -ENOMEM;
+
+	init_intr_coal_param(netdev);
+
+	if (test_bit(HINIC3_INTR_ADAPT, &nic_dev->flags))
+		nic_dev->adaptive_rx_coal = 1;
+	else
+		nic_dev->adaptive_rx_coal = 0;
+
+	return 0;
+}
+
+static void hinic3_free_intr_coalesce(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	kfree(nic_dev->intr_coalesce);
+}
+
+static int hinic3_alloc_txrxqs(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	int err;
+
+	err = hinic3_alloc_txqs(netdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc txqs\n");
+		return err;
+	}
+
+	err = hinic3_alloc_rxqs(netdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc rxqs\n");
+		goto err_alloc_rxqs;
+	}
+
+	err = hinic3_init_intr_coalesce(netdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init_intr_coalesce\n");
+		goto err_init_intr;
+	}
+
+	return 0;
+
+err_init_intr:
+	hinic3_free_rxqs(netdev);
+
+err_alloc_rxqs:
+	hinic3_free_txqs(netdev);
+
+	return err;
+}
+
+static void hinic3_free_txrxqs(struct net_device *netdev)
+{
+	hinic3_free_intr_coalesce(netdev);
+	hinic3_free_rxqs(netdev);
+	hinic3_free_txqs(netdev);
+}
+
+static void hinic3_fault_event_report(struct hinic3_hwdev *hwdev, u16 src, u16 level)
+{
+	dev_info(hwdev->dev, "Fault event report, src: %u, level: %u\n", src, level);
+}
+
+static void hinic3_periodic_work_handler(struct work_struct *work)
+{
+	struct delayed_work *delay = to_delayed_work(work);
+	struct hinic3_nic_dev *nic_dev;
+
+	nic_dev = container_of(delay, struct hinic3_nic_dev, periodic_work);
+	if (test_and_clear_bit(EVENT_WORK_TX_TIMEOUT, &nic_dev->event_flag))
+		hinic3_fault_event_report(nic_dev->hwdev, HINIC3_FAULT_SRC_TX_TIMEOUT,
+					  FAULT_LEVEL_SERIOUS_FLR);
+
+	queue_delayed_work(nic_dev->workq, &nic_dev->periodic_work, HZ);
+}
+
+static int hinic3_init_nic_dev(struct net_device *netdev,
+			       struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct pci_dev *pdev = hwdev->pdev;
+	u32 page_num;
+
+	nic_dev->netdev = netdev;
+	SET_NETDEV_DEV(netdev, &pdev->dev);
+	nic_dev->hwdev = hwdev;
+	nic_dev->pdev = pdev;
+
+	nic_dev->msg_enable = DEFAULT_MSG_ENABLE;
+	nic_dev->rx_buff_len = HINIC3_RX_BUFF_LEN;
+	nic_dev->dma_rx_buff_size = HINIC3_RX_BUFF_NUM_PER_PAGE * nic_dev->rx_buff_len;
+	page_num = nic_dev->dma_rx_buff_size / HINIC3_MIN_PAGE_SIZE;
+	nic_dev->page_order = page_num > 0 ? ilog2(page_num) : 0;
+	nic_dev->lro_replenish_thld = HINIC3_LRO_REPLENISH_THLD;
+	nic_dev->vlan_bitmap = kzalloc(VLAN_BITMAP_SIZE(nic_dev), GFP_KERNEL);
+	if (!nic_dev->vlan_bitmap)
+		return -ENOMEM;
+	set_bit(HINIC3_INTR_ADAPT, &nic_dev->flags);
+	nic_dev->nic_cap = hwdev->cfg_mgmt->svc_cap.nic_cap;
+
+	nic_dev->workq = create_singlethread_workqueue(HINIC3_NIC_DEV_WQ_NAME);
+	if (!nic_dev->workq) {
+		dev_err(hwdev->dev, "Failed to initialize nic workqueue\n");
+		kfree(nic_dev->vlan_bitmap);
+		return -ENOMEM;
+	}
+
+	INIT_DELAYED_WORK(&nic_dev->periodic_work, hinic3_periodic_work_handler);
+
+	INIT_LIST_HEAD(&nic_dev->uc_filter_list);
+	INIT_LIST_HEAD(&nic_dev->mc_filter_list);
+	INIT_WORK(&nic_dev->rx_mode_work, hinic3_set_rx_mode_work);
+
+	return 0;
+}
+
+static void hinic3_free_nic_dev(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	destroy_workqueue(nic_dev->workq);
+	kfree(nic_dev->vlan_bitmap);
+}
+
+static int hinic3_sw_init(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	u8 mac_addr[ETH_ALEN];
+	int err;
+
+	sema_init(&nic_dev->port_state_sem, 1);
+
+	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
+	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
+
+	hinic3_try_to_enable_rss(netdev);
+
+	if (HINIC3_IS_VF(hwdev)) {
+		eth_hw_addr_random(netdev);
+	} else {
+		err = hinic3_get_default_mac(hwdev, mac_addr);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to get MAC address\n");
+			goto err_out;
+		}
+		eth_hw_addr_set(netdev, mac_addr);
+	}
+
+	err = hinic3_set_mac(hwdev, netdev->dev_addr, 0,
+			     hinic3_global_func_id(hwdev));
+	/* Failure to set MAC is not a fatal error for VF since its MAC may have
+	 * already been set by PF
+	 */
+	if (err && err != HINIC3_PF_SET_VF_ALREADY) {
+		dev_err(hwdev->dev, "Failed to set default MAC\n");
+		goto err_out;
+	}
+
+	netdev->min_mtu = HINIC3_MIN_MTU_SIZE;
+	netdev->max_mtu = HINIC3_MAX_JUMBO_FRAME_SIZE;
+
+	err = hinic3_alloc_txrxqs(netdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc qps\n");
+		goto err_alloc_qps;
+	}
+
+	return 0;
+
+err_alloc_qps:
+	hinic3_del_mac(hwdev, netdev->dev_addr, 0, hinic3_global_func_id(hwdev));
+
+err_out:
+	hinic3_clear_rss_config(netdev);
+
+	return err;
+}
+
+static void hinic3_sw_deinit(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	hinic3_free_txrxqs(netdev);
+
+	hinic3_clean_mac_list_filter(netdev);
+
+	hinic3_del_mac(nic_dev->hwdev, netdev->dev_addr, 0,
+		       hinic3_global_func_id(nic_dev->hwdev));
+
+	hinic3_clear_rss_config(netdev);
+}
+
+static void hinic3_assign_netdev_ops(struct net_device *netdev)
+{
+	hinic3_set_netdev_ops(netdev);
+	hinic3_set_ethtool_ops(netdev);
+
+	netdev->watchdog_timeo = HINIC3_WATCHDOG_TIMEOUT * HZ;
+}
+
+static void netdev_feature_init(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	netdev_features_t hw_features = 0;
+	netdev_features_t vlan_fts = 0;
+	netdev_features_t cso_fts = 0;
+	netdev_features_t tso_fts = 0;
+	netdev_features_t dft_fts;
+
+	dft_fts = NETIF_F_SG | NETIF_F_HIGHDMA;
+
+	if (hinic3_test_support(nic_dev, NIC_F_CSUM))
+		cso_fts |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM;
+	if (hinic3_test_support(nic_dev, NIC_F_SCTP_CRC))
+		cso_fts |= NETIF_F_SCTP_CRC;
+
+	if (hinic3_test_support(nic_dev, NIC_F_TSO))
+		tso_fts |= NETIF_F_TSO | NETIF_F_TSO6;
+
+	if (hinic3_test_support(nic_dev, NIC_F_RX_VLAN_STRIP | NIC_F_TX_VLAN_INSERT))
+		vlan_fts |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
+
+	if (hinic3_test_support(nic_dev, NIC_F_RX_VLAN_FILTER))
+		vlan_fts |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	if (hinic3_test_support(nic_dev, NIC_F_VXLAN_OFFLOAD))
+		tso_fts |= NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL_CSUM;
+
+	/* LRO is disabled by default, only set hw features */
+	if (hinic3_test_support(nic_dev, NIC_F_LRO))
+		hw_features |= NETIF_F_LRO;
+
+	netdev->features |= dft_fts | cso_fts | tso_fts | vlan_fts;
+	netdev->vlan_features |= dft_fts | cso_fts | tso_fts;
+	hw_features |= netdev->hw_features | netdev->features;
+	netdev->hw_features = hw_features;
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->hw_enc_features |= dft_fts;
+	if (hinic3_test_support(nic_dev, NIC_F_VXLAN_OFFLOAD))
+		netdev->hw_enc_features |= cso_fts | tso_fts | NETIF_F_TSO_ECN;
+}
+
+static int hinic3_set_default_hw_feature(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	int err;
+
+	err = hinic3_set_nic_feature_to_hw(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set nic features\n");
+		return err;
+	}
+
+	err = hinic3_set_hw_features(netdev);
+	if (err) {
+		hinic3_update_nic_feature(nic_dev, 0);
+		hinic3_set_nic_feature_to_hw(nic_dev);
+		return err;
+	}
+
+	return 0;
+}
+
+static void hinic3_register_notifier(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	mutex_lock(&hinic3_netdev_notifiers_mutex);
+	hinic3_netdev_notifiers_ref_cnt++;
+	if (hinic3_netdev_notifiers_ref_cnt == 1) {
+		err = register_netdevice_notifier(&hinic3_netdev_notifier);
+		if (err) {
+			dev_dbg(nic_dev->hwdev->dev,
+				"Register netdevice notifier failed, err: %d\n",
+				err);
+			hinic3_netdev_notifiers_ref_cnt--;
+		}
+	}
+	mutex_unlock(&hinic3_netdev_notifiers_mutex);
+}
+
+static void hinic3_unregister_notifier(void)
+{
+	mutex_lock(&hinic3_netdev_notifiers_mutex);
+	if (hinic3_netdev_notifiers_ref_cnt == 1)
+		unregister_netdevice_notifier(&hinic3_netdev_notifier);
+
+	if (hinic3_netdev_notifiers_ref_cnt)
+		hinic3_netdev_notifiers_ref_cnt--;
+	mutex_unlock(&hinic3_netdev_notifiers_mutex);
+}
+
+static void hinic3_link_status_change(struct net_device *netdev, bool link_status_up)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	if (!HINIC3_CHANNEL_RES_VALID(nic_dev))
+		return;
+
+	if (link_status_up) {
+		if (netif_carrier_ok(netdev))
+			return;
+
+		nic_dev->link_status_up = true;
+		netif_carrier_on(netdev);
+		netdev_dbg(netdev, "Link is up\n");
+	} else {
+		if (!netif_carrier_ok(netdev))
+			return;
+
+		nic_dev->link_status_up = false;
+		netif_carrier_off(netdev);
+		netdev_dbg(netdev, "Link is down\n");
+	}
+}
+
+static void hinic3_port_module_event_handler(struct net_device *netdev,
+					     struct hinic3_event_info *event)
+{
+	const char *g_hinic3_module_link_err[LINK_ERR_NUM] = { "Unrecognized module" };
+	struct hinic3_port_module_event *module_event;
+	enum port_module_event_type type;
+	enum link_err_type err_type;
+
+	module_event = (struct hinic3_port_module_event *)event->event_data;
+	type = module_event->type;
+	err_type = module_event->err_type;
+
+	switch (type) {
+	case HINIC3_PORT_MODULE_CABLE_PLUGGED:
+	case HINIC3_PORT_MODULE_CABLE_UNPLUGGED:
+		netdev_info(netdev, "Port module event: Cable %s\n",
+			    type == HINIC3_PORT_MODULE_CABLE_PLUGGED ? "plugged" : "unplugged");
+		break;
+	case HINIC3_PORT_MODULE_LINK_ERR:
+		if (err_type >= LINK_ERR_NUM) {
+			netdev_info(netdev, "Link failed, Unknown error type: 0x%x\n", err_type);
+		} else {
+			netdev_info(netdev, "Link failed, error type: 0x%x: %s\n",
+				    err_type, g_hinic3_module_link_err[err_type]);
+		}
+		break;
+	default:
+		netdev_err(netdev, "Unknown port module type %d\n", type);
+		break;
+	}
+}
+
+static void nic_event(struct auxiliary_device *adev, struct hinic3_event_info *event)
+{
+	struct hinic3_nic_dev *nic_dev = dev_get_drvdata(&adev->dev);
+	struct net_device *netdev;
+
+	netdev = nic_dev->netdev;
+
+	switch (HINIC3_SRV_EVENT_TYPE(event->service, event->type)) {
+	case HINIC3_SRV_EVENT_TYPE(EVENT_SRV_NIC, EVENT_NIC_LINK_UP):
+		hinic3_link_status_change(netdev, true);
+		break;
+	case HINIC3_SRV_EVENT_TYPE(EVENT_SRV_NIC, EVENT_NIC_PORT_MODULE_EVENT):
+		hinic3_port_module_event_handler(netdev, event);
+		break;
+	case HINIC3_SRV_EVENT_TYPE(EVENT_SRV_NIC, EVENT_NIC_LINK_DOWN):
+	case HINIC3_SRV_EVENT_TYPE(EVENT_SRV_COMM, EVENT_COMM_FAULT):
+	case HINIC3_SRV_EVENT_TYPE(EVENT_SRV_COMM, EVENT_COMM_PCIE_LINK_DOWN):
+	case HINIC3_SRV_EVENT_TYPE(EVENT_SRV_COMM, EVENT_COMM_HEART_LOST):
+	case HINIC3_SRV_EVENT_TYPE(EVENT_SRV_COMM, EVENT_COMM_MGMT_WATCHDOG):
+		hinic3_link_status_change(netdev, false);
+		break;
+	default:
+		break;
+	}
+}
+
+static int nic_probe(struct auxiliary_device *adev, const struct auxiliary_device_id *id)
+{
+	struct hinic3_hwdev *hwdev = adev_get_hwdev(adev);
+	struct pci_dev *pdev = hwdev->pdev;
+	struct hinic3_nic_dev *nic_dev;
+	struct net_device *netdev;
+	u16 max_qps, glb_func_id;
+	int err;
+
+	if (!hinic3_support_nic(hwdev)) {
+		dev_dbg(&adev->dev, "Hw doesn't support nic\n");
+		return 0;
+	}
+
+	err = hinic3_adev_event_register(adev, nic_event);
+	if (err) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	glb_func_id = hinic3_global_func_id(hwdev);
+	err = hinic3_func_reset(hwdev, glb_func_id, HINIC3_NIC_RES);
+	if (err) {
+		dev_err(&adev->dev, "Failed to reset function\n");
+		goto err_out;
+	}
+
+	max_qps = hinic3_func_max_qnum(hwdev);
+	netdev = alloc_etherdev_mq(sizeof(*nic_dev), max_qps);
+	if (!netdev) {
+		dev_err(&adev->dev, "Failed to allocate netdev\n");
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	nic_dev = netdev_priv(netdev);
+	err = hinic3_init_nic_dev(netdev, hwdev);
+	if (err)
+		goto err_setup_dev;
+
+	err = hinic3_init_nic_io(nic_dev);
+	if (err)
+		goto err_init_nic_io;
+
+	err = hinic3_sw_init(netdev);
+	if (err)
+		goto err_sw_init;
+
+	hinic3_assign_netdev_ops(netdev);
+
+	netdev_feature_init(netdev);
+	err = hinic3_set_default_hw_feature(netdev);
+	if (err)
+		goto err_set_features;
+
+	hinic3_register_notifier(netdev);
+
+	err = register_netdev(netdev);
+	if (err) {
+		err = -ENOMEM;
+		goto err_netdev;
+	}
+
+	queue_delayed_work(nic_dev->workq, &nic_dev->periodic_work, HZ);
+	netif_carrier_off(netdev);
+
+	dev_set_drvdata(&adev->dev, nic_dev);
+
+	return 0;
+
+err_netdev:
+	hinic3_unregister_notifier();
+	hinic3_update_nic_feature(nic_dev, 0);
+	hinic3_set_nic_feature_to_hw(nic_dev);
+
+err_set_features:
+	hinic3_sw_deinit(netdev);
+
+err_sw_init:
+	hinic3_free_nic_io(nic_dev);
+
+err_init_nic_io:
+	hinic3_free_nic_dev(netdev);
+
+err_setup_dev:
+	free_netdev(netdev);
+
+err_out:
+	dev_err(&pdev->dev, "NIC service probe failed\n");
+
+	return err;
+}
+
+static void nic_remove(struct auxiliary_device *adev)
+{
+	struct hinic3_nic_dev *nic_dev = dev_get_drvdata(&adev->dev);
+	struct net_device *netdev;
+
+	if (!hinic3_support_nic(nic_dev->hwdev))
+		return;
+
+	netdev = nic_dev->netdev;
+	unregister_netdev(netdev);
+	hinic3_unregister_notifier();
+
+	cancel_delayed_work_sync(&nic_dev->periodic_work);
+	cancel_work_sync(&nic_dev->rx_mode_work);
+	destroy_workqueue(nic_dev->workq);
+
+	hinic3_update_nic_feature(nic_dev, 0);
+	hinic3_set_nic_feature_to_hw(nic_dev);
+	hinic3_sw_deinit(netdev);
+
+	hinic3_free_nic_io(nic_dev);
+
+	kfree(nic_dev->vlan_bitmap);
+	free_netdev(netdev);
+}
+
+static const struct auxiliary_device_id nic_id_table[] = {
+	{
+		.name = HINIC3_NIC_DRV_NAME ".nic",
+	},
+	{},
+};
+
+static struct auxiliary_driver nic_driver = {
+	.probe    = nic_probe,
+	.remove   = nic_remove,
+	.suspend  = NULL,
+	.resume   = NULL,
+	.name     = "nic",
+	.id_table = nic_id_table,
+};
+
+static __init int hinic3_nic_lld_init(void)
+{
+	int err;
+
+	pr_info("%s: %s\n", HINIC3_NIC_DRV_NAME, HINIC3_NIC_DRV_DESC);
+
+	err = hinic3_lld_init();
+	if (err)
+		return err;
+
+	err = auxiliary_driver_register(&nic_driver);
+	if (err) {
+		hinic3_lld_exit();
+		return err;
+	}
+
+	return 0;
+}
+
+static __exit void hinic3_nic_lld_exit(void)
+{
+	auxiliary_driver_unregister(&nic_driver);
+
+	hinic3_lld_exit();
+}
+
+module_init(hinic3_nic_lld_init);
+module_exit(hinic3_nic_lld_exit);
+
+MODULE_AUTHOR("Huawei Technologies CO., Ltd");
+MODULE_DESCRIPTION(HINIC3_NIC_DRV_DESC);
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
new file mode 100644
index 000000000000..f7fefaca9bc8
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -0,0 +1,1054 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/semaphore.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include "hinic3_common.h"
+#include "hinic3_csr.h"
+#include "hinic3_hwif.h"
+#include "hinic3_eqs.h"
+#include "hinic3_mbox.h"
+
+#define HINIC3_MBOX_INT_DST_AEQN_MASK        GENMASK(11, 10)
+#define HINIC3_MBOX_INT_SRC_RESP_AEQN_MASK   GENMASK(13, 12)
+#define HINIC3_MBOX_INT_STAT_DMA_MASK        GENMASK(19, 14)
+/* TX size, expressed in 4 bytes units */
+#define HINIC3_MBOX_INT_TX_SIZE_MASK         GENMASK(24, 20)
+/* SO_RO == strong order, relaxed order */
+#define HINIC3_MBOX_INT_STAT_DMA_SO_RO_MASK  GENMASK(26, 25)
+#define HINIC3_MBOX_INT_WB_EN_MASK           BIT(28)
+#define HINIC3_MBOX_INT_SET(val, field)  \
+	FIELD_PREP(HINIC3_MBOX_INT_##field##_MASK, val)
+
+#define HINIC3_MBOX_CTRL_TRIGGER_AEQE_MASK   BIT(0)
+#define HINIC3_MBOX_CTRL_TX_STATUS_MASK      BIT(1)
+#define HINIC3_MBOX_CTRL_DST_FUNC_MASK       GENMASK(28, 16)
+#define HINIC3_MBOX_CTRL_SET(val, field)  \
+	FIELD_PREP(HINIC3_MBOX_CTRL_##field##_MASK, val)
+
+#define MBOX_MSG_POLLING_TIMEOUT  8000
+#define HINIC3_MBOX_COMP_TIME     40000U
+
+#define MBOX_MAX_BUF_SZ           2048U
+#define MBOX_HEADER_SZ            8
+#define HINIC3_MBOX_DATA_SIZE     (MBOX_MAX_BUF_SZ - MBOX_HEADER_SZ)
+
+/* MBOX size is 64B, 8B for mbox_header, 8B reserved */
+#define MBOX_SEG_LEN              48
+#define MBOX_SEG_LEN_ALIGN        4
+#define MBOX_WB_STATUS_LEN        16UL
+
+#define SEQ_ID_START_VAL          0
+#define SEQ_ID_MAX_VAL            42
+#define MBOX_LAST_SEG_MAX_LEN  \
+	(MBOX_MAX_BUF_SZ - SEQ_ID_MAX_VAL * MBOX_SEG_LEN)
+
+/* mbox write back status is 16B, only first 4B is used */
+#define MBOX_WB_STATUS_ERRCODE_MASK       0xFFFF
+#define MBOX_WB_STATUS_MASK               0xFF
+#define MBOX_WB_ERROR_CODE_MASK           0xFF00
+#define MBOX_WB_STATUS_FINISHED_SUCCESS   0xFF
+#define MBOX_WB_STATUS_NOT_FINISHED       0x00
+
+#define MBOX_STATUS_FINISHED(wb)  \
+	(((wb) & MBOX_WB_STATUS_MASK) != MBOX_WB_STATUS_NOT_FINISHED)
+#define MBOX_STATUS_SUCCESS(wb)  \
+	(((wb) & MBOX_WB_STATUS_MASK) == MBOX_WB_STATUS_FINISHED_SUCCESS)
+#define MBOX_STATUS_ERRCODE(wb)  \
+	((wb) & MBOX_WB_ERROR_CODE_MASK)
+
+#define MBOX_DMA_MSG_QUEUE_DEPTH    32
+#define MBOX_BODY_FROM_HDR(header)  ((u8 *)(header) + MBOX_HEADER_SZ)
+#define MBOX_AREA(hwif)  \
+	((hwif)->cfg_regs_base + HINIC3_FUNC_CSR_MAILBOX_DATA_OFF)
+
+#define MBOX_MQ_CI_OFFSET  \
+	(HINIC3_CFG_REGS_FLAG + HINIC3_FUNC_CSR_MAILBOX_DATA_OFF + \
+	 MBOX_HEADER_SZ + MBOX_SEG_LEN)
+
+#define MBOX_MQ_SYNC_CI_MASK   GENMASK(7, 0)
+#define MBOX_MQ_ASYNC_CI_MASK  GENMASK(15, 8)
+#define MBOX_MQ_CI_GET(val, field)  \
+	FIELD_GET(MBOX_MQ_##field##_CI_MASK, val)
+
+#define MBOX_MSG_ID_MASK       0xF
+#define MBOX_MSG_ID_INC(mbox)  (((mbox)->send_msg_id + 1) & MBOX_MSG_ID_MASK)
+
+enum mbox_dma_attribute {
+	NO_DMA_ATTRIBUTE = 0,
+};
+
+/* specifies the issue request for the message data.
+ * 0 - Tx request is done;
+ * 1 - Tx request is in process.
+ */
+enum hinic3_mbox_tx_status {
+	TX_NOT_DONE = 1,
+};
+
+enum mbox_ordering_type {
+	STRONG_ORDER = 0,
+};
+
+enum mbox_write_back_type {
+	WRITE_BACK = 1,
+};
+
+enum mbox_aeq_trig_type {
+	NOT_TRIGGER = 0,
+};
+
+static struct hinic3_msg_desc *get_mbox_msg_desc(struct hinic3_mbox *mbox,
+						 enum hinic3_msg_direction_type dir,
+						 u16 src_func_id)
+{
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+	struct hinic3_msg_channel *msg_ch;
+	u16 id;
+
+	if (src_func_id == HINIC3_MGMT_SRC_ID) {
+		msg_ch = &mbox->mgmt_msg;
+	} else if (HINIC3_IS_VF(hwdev)) {
+		/* message from pf */
+		msg_ch = mbox->func_msg;
+		if (src_func_id != hinic3_pf_id_of_vf(hwdev) || !msg_ch)
+			return NULL;
+	} else if (src_func_id > hinic3_glb_pf_vf_offset(hwdev)) {
+		/* message from vf */
+		id = (src_func_id - 1) - hinic3_glb_pf_vf_offset(hwdev);
+		if (id >= mbox->num_func_msg)
+			return NULL;
+
+		msg_ch = &mbox->func_msg[id];
+	} else {
+		return NULL;
+	}
+
+	return (dir == HINIC3_MSG_DIRECT_SEND) ?
+		&msg_ch->recv_msg : &msg_ch->resp_msg;
+}
+
+static void resp_mbox_handler(struct hinic3_mbox *mbox,
+			      const struct hinic3_msg_desc *msg_desc)
+{
+	spin_lock(&mbox->mbox_lock);
+	if (msg_desc->msg_info.msg_id == mbox->send_msg_id &&
+	    mbox->event_flag == EVENT_START)
+		mbox->event_flag = EVENT_SUCCESS;
+	else
+		dev_err(mbox->hwdev->dev,
+			"Mbox response timeout, current send msg id 0x%x, recv msg id 0x%x, status 0x%x\n",
+			mbox->send_msg_id, msg_desc->msg_info.msg_id,
+			msg_desc->msg_info.status);
+	spin_unlock(&mbox->mbox_lock);
+}
+
+static bool mbox_segment_valid(struct hinic3_mbox *mbox,
+			       struct hinic3_msg_desc *msg_desc,
+			       u64 mbox_header)
+{
+	u8 seq_id, seg_len, msg_id, mod;
+	u16 src_func_idx, cmd;
+
+	seq_id = HINIC3_MSG_HEADER_GET(mbox_header, SEQID);
+	seg_len = HINIC3_MSG_HEADER_GET(mbox_header, SEG_LEN);
+	msg_id = HINIC3_MSG_HEADER_GET(mbox_header, MSG_ID);
+	mod = HINIC3_MSG_HEADER_GET(mbox_header, MODULE);
+	cmd = HINIC3_MSG_HEADER_GET(mbox_header, CMD);
+	src_func_idx = HINIC3_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);
+
+	if (seq_id > SEQ_ID_MAX_VAL || seg_len > MBOX_SEG_LEN ||
+	    (seq_id == SEQ_ID_MAX_VAL && seg_len > MBOX_LAST_SEG_MAX_LEN))
+		goto err_seg;
+
+	if (seq_id == 0) {
+		msg_desc->seq_id = seq_id;
+		msg_desc->msg_info.msg_id = msg_id;
+		msg_desc->mod = mod;
+		msg_desc->cmd = cmd;
+	} else {
+		if (seq_id != msg_desc->seq_id + 1 || msg_id != msg_desc->msg_info.msg_id ||
+		    mod != msg_desc->mod || cmd != msg_desc->cmd)
+			goto err_seg;
+
+		msg_desc->seq_id = seq_id;
+	}
+
+	return true;
+
+err_seg:
+	dev_err(mbox->hwdev->dev,
+		"Mailbox segment check failed, src func id: 0x%x, front seg info: seq id: 0x%x, msg id: 0x%x, mod: 0x%x, cmd: 0x%x\n",
+		src_func_idx, msg_desc->seq_id, msg_desc->msg_info.msg_id,
+		msg_desc->mod, msg_desc->cmd);
+	dev_err(mbox->hwdev->dev,
+		"Current seg info: seg len: 0x%x, seq id: 0x%x, msg id: 0x%x, mod: 0x%x, cmd: 0x%x\n",
+		seg_len, seq_id, msg_id, mod, cmd);
+
+	return false;
+}
+
+static void recv_mbox_handler(struct hinic3_mbox *mbox,
+			      u64 *header, struct hinic3_msg_desc *msg_desc)
+{
+	void *mbox_body = MBOX_BODY_FROM_HDR(((void *)header));
+	u64 mbox_header = *header;
+	u8 seq_id, seg_len;
+	int pos;
+
+	if (!mbox_segment_valid(mbox, msg_desc, mbox_header)) {
+		msg_desc->seq_id = SEQ_ID_MAX_VAL;
+		return;
+	}
+
+	seq_id = HINIC3_MSG_HEADER_GET(mbox_header, SEQID);
+	seg_len = HINIC3_MSG_HEADER_GET(mbox_header, SEG_LEN);
+
+	pos = seq_id * MBOX_SEG_LEN;
+	memcpy((u8 *)msg_desc->msg + pos, mbox_body, seg_len);
+
+	if (!HINIC3_MSG_HEADER_GET(mbox_header, LAST))
+		return;
+
+	msg_desc->msg_len = HINIC3_MSG_HEADER_GET(mbox_header, MSG_LEN);
+	msg_desc->msg_info.status = HINIC3_MSG_HEADER_GET(mbox_header, STATUS);
+
+	if (HINIC3_MSG_HEADER_GET(mbox_header, DIRECTION) ==
+	    HINIC3_MSG_RESPONSE) {
+		resp_mbox_handler(mbox, msg_desc);
+		return;
+	}
+}
+
+void hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header, u8 size)
+{
+	u64 mbox_header = *((u64 *)header);
+	enum hinic3_msg_direction_type dir;
+	struct hinic3_mbox *mbox;
+	struct hinic3_msg_desc *msg_desc;
+	u16 src_func_id;
+
+	mbox = hwdev->mbox;
+
+	dir = HINIC3_MSG_HEADER_GET(mbox_header, DIRECTION);
+	src_func_id = HINIC3_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);
+
+	msg_desc = get_mbox_msg_desc(mbox, dir, src_func_id);
+	if (!msg_desc) {
+		dev_err(mbox->hwdev->dev,
+			"Mailbox source function id: %u is invalid for current function\n",
+			src_func_id);
+		return;
+	}
+
+	recv_mbox_handler(mbox, (u64 *)header, msg_desc);
+}
+
+static int init_mbox_dma_queue(struct hinic3_hwdev *hwdev, struct mbox_dma_queue *mq)
+{
+	u32 size;
+
+	mq->depth = MBOX_DMA_MSG_QUEUE_DEPTH;
+	mq->prod_idx = 0;
+	mq->cons_idx = 0;
+
+	size = mq->depth * MBOX_MAX_BUF_SZ;
+	mq->dma_buff_vaddr = dma_alloc_coherent(hwdev->dev, size, &mq->dma_buff_paddr,
+						GFP_KERNEL);
+	if (!mq->dma_buff_vaddr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void deinit_mbox_dma_queue(struct hinic3_hwdev *hwdev, struct mbox_dma_queue *mq)
+{
+	dma_free_coherent(hwdev->dev, mq->depth * MBOX_MAX_BUF_SZ,
+			  mq->dma_buff_vaddr, mq->dma_buff_paddr);
+}
+
+static int hinic3_init_mbox_dma_queue(struct hinic3_mbox *mbox)
+{
+	u32 val;
+	int err;
+
+	err = init_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
+	if (err)
+		return err;
+
+	err = init_mbox_dma_queue(mbox->hwdev, &mbox->async_msg_queue);
+	if (err) {
+		deinit_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
+		return err;
+	}
+
+	val = hinic3_hwif_read_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET);
+	val &= ~MBOX_MQ_SYNC_CI_MASK;
+	val &= ~MBOX_MQ_ASYNC_CI_MASK;
+	hinic3_hwif_write_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET, val);
+
+	return 0;
+}
+
+static void hinic3_deinit_mbox_dma_queue(struct hinic3_mbox *mbox)
+{
+	deinit_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
+	deinit_mbox_dma_queue(mbox->hwdev, &mbox->async_msg_queue);
+}
+
+static int alloc_mbox_msg_channel(struct hinic3_msg_channel *msg_ch)
+{
+	msg_ch->resp_msg.msg = kzalloc(MBOX_MAX_BUF_SZ, GFP_KERNEL);
+	if (!msg_ch->resp_msg.msg)
+		return -ENOMEM;
+
+	msg_ch->recv_msg.msg = kzalloc(MBOX_MAX_BUF_SZ, GFP_KERNEL);
+	if (!msg_ch->recv_msg.msg) {
+		kfree(msg_ch->resp_msg.msg);
+		return -ENOMEM;
+	}
+
+	msg_ch->resp_msg.seq_id = SEQ_ID_MAX_VAL;
+	msg_ch->recv_msg.seq_id = SEQ_ID_MAX_VAL;
+	atomic_set(&msg_ch->recv_msg_cnt, 0);
+
+	return 0;
+}
+
+static void free_mbox_msg_channel(struct hinic3_msg_channel *msg_ch)
+{
+	kfree(msg_ch->recv_msg.msg);
+	kfree(msg_ch->resp_msg.msg);
+}
+
+static int init_mgmt_msg_channel(struct hinic3_mbox *mbox)
+{
+	int err;
+
+	err = alloc_mbox_msg_channel(&mbox->mgmt_msg);
+	if (err) {
+		dev_err(mbox->hwdev->dev, "Failed to alloc mgmt message channel\n");
+		return err;
+	}
+
+	err = hinic3_init_mbox_dma_queue(mbox);
+	if (err) {
+		dev_err(mbox->hwdev->dev, "Failed to init mbox dma queue\n");
+		free_mbox_msg_channel(&mbox->mgmt_msg);
+	}
+
+	return err;
+}
+
+static void deinit_mgmt_msg_channel(struct hinic3_mbox *mbox)
+{
+	hinic3_deinit_mbox_dma_queue(mbox);
+	free_mbox_msg_channel(&mbox->mgmt_msg);
+}
+
+static int hinic3_init_func_mbox_msg_channel(struct hinic3_hwdev *hwdev, u16 num_func)
+{
+	struct hinic3_mbox *mbox;
+	u16 func_id, i;
+	int err;
+
+	mbox = hwdev->mbox;
+	if (mbox->func_msg)
+		return (mbox->num_func_msg == num_func) ? 0 : -EFAULT;
+
+	mbox->func_msg =
+		kcalloc(num_func, sizeof(*mbox->func_msg), GFP_KERNEL);
+	if (!mbox->func_msg)
+		return -ENOMEM;
+
+	for (func_id = 0; func_id < num_func; func_id++) {
+		err = alloc_mbox_msg_channel(&mbox->func_msg[func_id]);
+		if (err) {
+			dev_err(mbox->hwdev->dev,
+				"Failed to alloc func %u message channel\n",
+				func_id);
+			goto err_alloc_msg_ch;
+		}
+	}
+
+	mbox->num_func_msg = num_func;
+
+	return 0;
+
+err_alloc_msg_ch:
+	for (i = 0; i < func_id; i++)
+		free_mbox_msg_channel(&mbox->func_msg[i]);
+
+	kfree(mbox->func_msg);
+	mbox->func_msg = NULL;
+
+	return -ENOMEM;
+}
+
+static void hinic3_deinit_func_mbox_msg_channel(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_mbox *mbox = hwdev->mbox;
+	u16 i;
+
+	if (!mbox->func_msg)
+		return;
+
+	for (i = 0; i < mbox->num_func_msg; i++)
+		free_mbox_msg_channel(&mbox->func_msg[i]);
+
+	kfree(mbox->func_msg);
+	mbox->func_msg = NULL;
+}
+
+static void prepare_send_mbox(struct hinic3_mbox *mbox)
+{
+	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
+
+	send_mbox->data = MBOX_AREA(mbox->hwdev->hwif);
+}
+
+static int alloc_mbox_wb_status(struct hinic3_mbox *mbox)
+{
+	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+	u32 addr_h, addr_l;
+
+	send_mbox->wb_vaddr = dma_alloc_coherent(hwdev->dev,
+						 MBOX_WB_STATUS_LEN,
+						 &send_mbox->wb_paddr,
+						 GFP_KERNEL);
+	if (!send_mbox->wb_vaddr)
+		return -ENOMEM;
+
+	addr_h = upper_32_bits(send_mbox->wb_paddr);
+	addr_l = lower_32_bits(send_mbox->wb_paddr);
+
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF,
+			      addr_h);
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF,
+			      addr_l);
+
+	return 0;
+}
+
+static void free_mbox_wb_status(struct hinic3_mbox *mbox)
+{
+	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF,
+			      0);
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF,
+			      0);
+
+	dma_free_coherent(hwdev->dev, MBOX_WB_STATUS_LEN,
+			  send_mbox->wb_vaddr, send_mbox->wb_paddr);
+}
+
+static int hinic3_mbox_pre_init(struct hinic3_hwdev *hwdev,
+				struct hinic3_mbox **mbox)
+{
+	(*mbox) = kzalloc(sizeof(struct hinic3_mbox), GFP_KERNEL);
+	if (!(*mbox))
+		return -ENOMEM;
+
+	(*mbox)->hwdev = hwdev;
+	mutex_init(&(*mbox)->mbox_send_lock);
+	mutex_init(&(*mbox)->msg_send_lock);
+	spin_lock_init(&(*mbox)->mbox_lock);
+
+	(*mbox)->workq = create_singlethread_workqueue(HINIC3_MBOX_WQ_NAME);
+	if (!(*mbox)->workq) {
+		dev_err(hwdev->dev, "Failed to initialize MBOX workqueue\n");
+		kfree((*mbox));
+		return -ENOMEM;
+	}
+	hwdev->mbox = (*mbox);
+
+	return 0;
+}
+
+int hinic3_init_mbox(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_mbox *mbox;
+	int err;
+
+	err = hinic3_mbox_pre_init(hwdev, &mbox);
+	if (err)
+		return err;
+
+	err = init_mgmt_msg_channel(mbox);
+	if (err)
+		goto err_init_mgmt_msg_ch;
+
+	if (HINIC3_IS_VF(hwdev)) {
+		/* VF to PF mbox message channel */
+		err = hinic3_init_func_mbox_msg_channel(hwdev, 1);
+		if (err)
+			goto err_init_func_msg_ch;
+	}
+
+	err = alloc_mbox_wb_status(mbox);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc mbox write back status\n");
+		goto err_alloc_wb_status;
+	}
+
+	prepare_send_mbox(mbox);
+
+	return 0;
+
+err_alloc_wb_status:
+	if (HINIC3_IS_VF(hwdev))
+		hinic3_deinit_func_mbox_msg_channel(hwdev);
+
+err_init_func_msg_ch:
+	deinit_mgmt_msg_channel(mbox);
+
+err_init_mgmt_msg_ch:
+	destroy_workqueue(mbox->workq);
+	kfree(mbox);
+
+	return err;
+}
+
+void hinic3_free_mbox(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_mbox *mbox = hwdev->mbox;
+
+	/* destroy workqueue before freeing related mbox resources in case of
+	 * illegal resource access
+	 */
+	destroy_workqueue(mbox->workq);
+
+	free_mbox_wb_status(mbox);
+	hinic3_deinit_func_mbox_msg_channel(hwdev);
+	deinit_mgmt_msg_channel(mbox);
+	kfree(mbox);
+}
+
+#define MBOX_DMA_MSG_INIT_XOR_VAL    0x5a5a5a5a
+#define MBOX_XOR_DATA_ALIGN          4
+static u32 mbox_dma_msg_xor(u32 *data, u32 msg_len)
+{
+	u32 xor = MBOX_DMA_MSG_INIT_XOR_VAL;
+	u32 dw_len = msg_len / sizeof(u32);
+	u32 i;
+
+	for (i = 0; i < dw_len; i++)
+		xor ^= data[i];
+
+	return xor;
+}
+
+#define MQ_ID_MASK(mq, idx)    ((idx) & ((mq)->depth - 1))
+#define IS_MSG_QUEUE_FULL(mq) \
+	(MQ_ID_MASK(mq, (mq)->prod_idx + 1) == MQ_ID_MASK(mq, (mq)->cons_idx))
+
+static int mbox_prepare_dma_entry(struct hinic3_mbox *mbox, struct mbox_dma_queue *mq,
+				  struct mbox_dma_msg *dma_msg, const void *msg, u32 msg_len)
+{
+	u64 dma_addr, offset;
+	void *dma_vaddr;
+
+	if (IS_MSG_QUEUE_FULL(mq)) {
+		dev_err(mbox->hwdev->dev, "Mbox sync message queue is busy, pi: %u, ci: %u\n",
+			mq->prod_idx, MQ_ID_MASK(mq, mq->cons_idx));
+		return -EBUSY;
+	}
+
+	/* copy data to DMA buffer */
+	offset = mq->prod_idx * MBOX_MAX_BUF_SZ;
+	dma_vaddr = (u8 *)mq->dma_buff_vaddr + offset;
+	memcpy(dma_vaddr, msg, msg_len);
+	dma_addr = mq->dma_buff_paddr + offset;
+	dma_msg->dma_addr_high = upper_32_bits(dma_addr);
+	dma_msg->dma_addr_low = lower_32_bits(dma_addr);
+	dma_msg->msg_len = msg_len;
+	/* The firmware obtains message based on 4B alignment. */
+	dma_msg->xor = mbox_dma_msg_xor(dma_vaddr, ALIGN(msg_len, MBOX_XOR_DATA_ALIGN));
+
+	mq->prod_idx++;
+	mq->prod_idx = MQ_ID_MASK(mq, mq->prod_idx);
+
+	return 0;
+}
+
+static int mbox_prepare_dma_msg(struct hinic3_mbox *mbox, enum hinic3_msg_ack_type ack_type,
+				struct mbox_dma_msg *dma_msg, const void *msg, u32 msg_len)
+{
+	struct mbox_dma_queue *mq;
+	u32 val;
+
+	val = hinic3_hwif_read_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET);
+	if (ack_type == HINIC3_MSG_ACK) {
+		mq = &mbox->sync_msg_queue;
+		mq->cons_idx = MBOX_MQ_CI_GET(val, SYNC);
+	} else {
+		mq = &mbox->async_msg_queue;
+		mq->cons_idx = MBOX_MQ_CI_GET(val, ASYNC);
+	}
+
+	return mbox_prepare_dma_entry(mbox, mq, dma_msg, msg, msg_len);
+}
+
+static void clear_mbox_status(struct hinic3_send_mbox *mbox)
+{
+	__be64 *wb_status = mbox->wb_vaddr;
+
+	*wb_status = 0;
+	/* clear mailbox write back status */
+	wmb();
+}
+
+static void mbox_dword_write(const void *src, void __iomem *dst, u32 count)
+{
+	u32 __iomem *dst32 = dst;
+	const u32 *src32 = src;
+	u32 i;
+
+	/* Data written to mbox is arranged in structs with little endian fields
+	 * but when written to HW every dword (32bits) should be swapped since
+	 * the HW will swap it again. This is a mandatory swap regardless of the
+	 * CPU endianness.
+	 */
+	for (i = 0; i < count; i++)
+		__raw_writel(swab32(src32[i]), dst32 + i);
+}
+
+static void mbox_copy_header(struct hinic3_hwdev *hwdev,
+			     struct hinic3_send_mbox *mbox, u64 *header)
+{
+	mbox_dword_write(header, mbox->data, MBOX_HEADER_SZ / sizeof(u32));
+}
+
+static void mbox_copy_send_data(struct hinic3_hwdev *hwdev,
+				struct hinic3_send_mbox *mbox, void *seg,
+				u32 seg_len)
+{
+	u32 __iomem *dst = (u32 __iomem *)(mbox->data + MBOX_HEADER_SZ);
+	u32 count, leftover, last_dword;
+	const u32 *src = seg;
+
+	count = seg_len / sizeof(u32);
+	leftover = seg_len % sizeof(u32);
+	if (count > 0)
+		mbox_dword_write(src, dst, count);
+
+	if (leftover > 0) {
+		last_dword = 0;
+		memcpy(&last_dword, src + count, leftover);
+		mbox_dword_write(&last_dword, dst + count, 1);
+	}
+}
+
+static void write_mbox_msg_attr(struct hinic3_mbox *mbox,
+				u16 dst_func, u16 dst_aeqn, u32 seg_len)
+{
+	struct hinic3_hwif *hwif = mbox->hwdev->hwif;
+	u32 mbox_int, mbox_ctrl, tx_size;
+	u16 func = dst_func;
+
+	/* VF can send non-management messages only to PF. We set DST_FUNC field
+	 * to 0 since HW will ignore it anyway.
+	 */
+	if (HINIC3_IS_VF(mbox->hwdev) && dst_func != HINIC3_MGMT_SRC_ID)
+		func = 0;
+	tx_size = ALIGN(seg_len + MBOX_HEADER_SZ, MBOX_SEG_LEN_ALIGN) >> 2;
+
+	mbox_int = HINIC3_MBOX_INT_SET(dst_aeqn, DST_AEQN) |
+		   HINIC3_MBOX_INT_SET(NO_DMA_ATTRIBUTE, STAT_DMA) |
+		   HINIC3_MBOX_INT_SET(tx_size, TX_SIZE) |
+		   HINIC3_MBOX_INT_SET(STRONG_ORDER, STAT_DMA_SO_RO) |
+		   HINIC3_MBOX_INT_SET(WRITE_BACK, WB_EN);
+
+	mbox_ctrl = HINIC3_MBOX_CTRL_SET(TX_NOT_DONE, TX_STATUS) |
+		    HINIC3_MBOX_CTRL_SET(NOT_TRIGGER, TRIGGER_AEQE) |
+		    HINIC3_MBOX_CTRL_SET(func, DST_FUNC);
+
+	hinic3_hwif_write_reg(hwif, HINIC3_FUNC_CSR_MAILBOX_INT_OFF, mbox_int);
+	hinic3_hwif_write_reg(hwif, HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF, mbox_ctrl);
+}
+
+static void dump_mbox_reg(struct hinic3_hwdev *hwdev)
+{
+	u32 val;
+
+	val = hinic3_hwif_read_reg(hwdev->hwif,
+				   HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF);
+	dev_err(hwdev->dev, "Mailbox control reg: 0x%x\n", val);
+	val = hinic3_hwif_read_reg(hwdev->hwif,
+				   HINIC3_FUNC_CSR_MAILBOX_INT_OFF);
+	dev_err(hwdev->dev, "Mailbox interrupt offset: 0x%x\n", val);
+}
+
+static u16 get_mbox_status(const struct hinic3_send_mbox *mbox)
+{
+	__be64 *wb_status = mbox->wb_vaddr;
+	u64 wb_val;
+
+	wb_val = be64_to_cpu(*wb_status);
+
+	/* verify reading before check */
+	rmb();
+
+	return (u16)(wb_val & MBOX_WB_STATUS_ERRCODE_MASK);
+}
+
+static enum hinic3_wait_return check_mbox_wb_status(void *priv_data)
+{
+	struct hinic3_mbox *mbox = priv_data;
+	u16 wb_status;
+
+	if (!mbox->hwdev->chip_present_flag)
+		return WAIT_PROCESS_ERR;
+
+	wb_status = get_mbox_status(&mbox->send_mbox);
+
+	return MBOX_STATUS_FINISHED(wb_status) ?
+		WAIT_PROCESS_CPL : WAIT_PROCESS_WAITING;
+}
+
+static int send_mbox_seg(struct hinic3_mbox *mbox, u64 header,
+			 u16 dst_func, void *seg, u32 seg_len, void *msg_info)
+{
+	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+	u8 num_aeqs = hwdev->hwif->attr.num_aeqs;
+	enum hinic3_msg_direction_type dir;
+	u16 dst_aeqn, wb_status, errcode;
+	int err;
+
+	/* mbox to mgmt cpu, hardware doesn't care about dst aeq id */
+	if (num_aeqs > HINIC3_AEQ_FOR_MBOX) {
+		dir = HINIC3_MSG_HEADER_GET(header, DIRECTION);
+		dst_aeqn = (dir == HINIC3_MSG_DIRECT_SEND) ?
+			   HINIC3_AEQ_FOR_EVENT : HINIC3_AEQ_FOR_MBOX;
+	} else {
+		dst_aeqn = 0;
+	}
+
+	clear_mbox_status(send_mbox);
+	mbox_copy_header(hwdev, send_mbox, &header);
+	mbox_copy_send_data(hwdev, send_mbox, seg, seg_len);
+	write_mbox_msg_attr(mbox, dst_func, dst_aeqn, seg_len);
+
+	err = hinic3_wait_for_timeout(mbox, check_mbox_wb_status,
+				      MBOX_MSG_POLLING_TIMEOUT, USEC_PER_MSEC);
+	wb_status = get_mbox_status(send_mbox);
+	if (err) {
+		dev_err(hwdev->dev, "Send mailbox segment timeout, wb status: 0x%x\n",
+			wb_status);
+		dump_mbox_reg(hwdev);
+		return -ETIMEDOUT;
+	}
+
+	if (!MBOX_STATUS_SUCCESS(wb_status)) {
+		dev_err(hwdev->dev, "Send mailbox segment to function %u error, wb status: 0x%x\n",
+			dst_func, wb_status);
+		errcode = MBOX_STATUS_ERRCODE(wb_status);
+		return errcode ? errcode : -EFAULT;
+	}
+
+	return 0;
+}
+
+static int send_mbox_msg(struct hinic3_mbox *mbox, u8 mod, u16 cmd,
+			 const void *msg, u32 msg_len, u16 dst_func,
+			 enum hinic3_msg_direction_type direction,
+			 enum hinic3_msg_ack_type ack_type,
+			 struct mbox_msg_info *msg_info)
+{
+	enum hinic3_data_type data_type = HINIC3_DATA_INLINE;
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+	struct mbox_dma_msg dma_msg;
+	u32 seg_len = MBOX_SEG_LEN;
+	u64 header = 0;
+	u32 seq_id = 0;
+	u16 rsp_aeq_id;
+	u8 *msg_seg;
+	int err = 0;
+	u32 left;
+
+	if (hwdev->poll || hwdev->hwif->attr.num_aeqs >= 0x2)
+		rsp_aeq_id = HINIC3_AEQ_FOR_MBOX;
+	else
+		rsp_aeq_id = 0;
+
+	mutex_lock(&mbox->msg_send_lock);
+
+	if (IS_DMA_MBX_MSG(dst_func) && !SUPPORT_SEGMENT(hwdev->features[0])) {
+		err = mbox_prepare_dma_msg(mbox, ack_type, &dma_msg, msg, msg_len);
+		if (err)
+			goto err_send;
+
+		msg = &dma_msg;
+		msg_len = sizeof(dma_msg);
+		data_type = HINIC3_DATA_DMA;
+	}
+
+	msg_seg = (u8 *)msg;
+	left = msg_len;
+
+	header = HINIC3_MSG_HEADER_SET(msg_len, MSG_LEN) |
+		 HINIC3_MSG_HEADER_SET(mod, MODULE) |
+		 HINIC3_MSG_HEADER_SET(seg_len, SEG_LEN) |
+		 HINIC3_MSG_HEADER_SET(ack_type, NO_ACK) |
+		 HINIC3_MSG_HEADER_SET(data_type, DATA_TYPE) |
+		 HINIC3_MSG_HEADER_SET(SEQ_ID_START_VAL, SEQID) |
+		 HINIC3_MSG_HEADER_SET(NOT_LAST_SEGMENT, LAST) |
+		 HINIC3_MSG_HEADER_SET(direction, DIRECTION) |
+		 HINIC3_MSG_HEADER_SET(cmd, CMD) |
+		 /* The vf's offset to it's associated pf */
+		 HINIC3_MSG_HEADER_SET(msg_info->msg_id, MSG_ID) |
+		 HINIC3_MSG_HEADER_SET(rsp_aeq_id, AEQ_ID) |
+		 HINIC3_MSG_HEADER_SET(HINIC3_MSG_FROM_MBOX, SOURCE) |
+		 HINIC3_MSG_HEADER_SET(!!msg_info->status, STATUS);
+
+	while (!(HINIC3_MSG_HEADER_GET(header, LAST))) {
+		if (left <= MBOX_SEG_LEN) {
+			header &= ~HINIC3_MSG_HEADER_SEG_LEN_MASK;
+			header |= HINIC3_MSG_HEADER_SET(left, SEG_LEN);
+			header |= HINIC3_MSG_HEADER_SET(LAST_SEGMENT, LAST);
+
+			seg_len = left;
+		}
+
+		err = send_mbox_seg(mbox, header, dst_func, msg_seg,
+				    seg_len, msg_info);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to send mbox seg, seq_id=0x%llx\n",
+				HINIC3_MSG_HEADER_GET(header, SEQID));
+			goto err_send;
+		}
+
+		left -= MBOX_SEG_LEN;
+		msg_seg += MBOX_SEG_LEN;
+
+		seq_id++;
+		header &= ~HINIC3_MSG_HEADER_SEG_LEN_MASK;
+		header |= HINIC3_MSG_HEADER_SET(seq_id, SEQID);
+	}
+
+err_send:
+	mutex_unlock(&mbox->msg_send_lock);
+
+	return err;
+}
+
+static void set_mbox_to_func_event(struct hinic3_mbox *mbox,
+				   enum mbox_event_state event_flag)
+{
+	spin_lock(&mbox->mbox_lock);
+	mbox->event_flag = event_flag;
+	spin_unlock(&mbox->mbox_lock);
+}
+
+static enum hinic3_wait_return check_mbox_msg_finish(void *priv_data)
+{
+	struct hinic3_mbox *mbox = priv_data;
+
+	if (!mbox->hwdev->chip_present_flag)
+		return WAIT_PROCESS_ERR;
+
+	return (mbox->event_flag == EVENT_SUCCESS) ?
+		WAIT_PROCESS_CPL : WAIT_PROCESS_WAITING;
+}
+
+static int wait_mbox_msg_completion(struct hinic3_mbox *mbox,
+				    u32 timeout)
+{
+	u32 wait_time;
+	int err;
+
+	wait_time = (timeout != 0) ? timeout : HINIC3_MBOX_COMP_TIME;
+	err = hinic3_wait_for_timeout(mbox, check_mbox_msg_finish,
+				      wait_time, USEC_PER_MSEC);
+	if (err) {
+		set_mbox_to_func_event(mbox, EVENT_TIMEOUT);
+		return -ETIMEDOUT;
+	}
+
+	set_mbox_to_func_event(mbox, EVENT_END);
+
+	return 0;
+}
+
+static int send_mbox_msg_lock(struct hinic3_mbox *mbox)
+{
+	mutex_lock(&mbox->mbox_send_lock);
+	return 0;
+}
+
+static void send_mbox_msg_unlock(struct hinic3_mbox *mbox)
+{
+	mutex_unlock(&mbox->mbox_send_lock);
+}
+
+static int hinic3_mbox_to_func(struct hinic3_mbox *mbox, u8 mod, u16 cmd,
+			       u16 dst_func, const void *buf_in, u32 in_size, void *buf_out,
+			       u32 *out_size, u32 timeout)
+{
+	struct mbox_msg_info msg_info = {};
+	struct hinic3_msg_desc *msg_desc;
+	int err;
+
+	if (mbox->hwdev->chip_present_flag == 0)
+		return -EPERM;
+
+	/* expect response message */
+	msg_desc = get_mbox_msg_desc(mbox, HINIC3_MSG_RESPONSE,
+				     dst_func);
+	if (!msg_desc)
+		return -EFAULT;
+
+	err = send_mbox_msg_lock(mbox);
+	if (err)
+		return err;
+
+	msg_info.msg_id = MBOX_MSG_ID_INC(mbox);
+	mbox->send_msg_id = msg_info.msg_id;
+
+	set_mbox_to_func_event(mbox, EVENT_START);
+
+	err = send_mbox_msg(mbox, mod, cmd, buf_in, in_size, dst_func,
+			    HINIC3_MSG_DIRECT_SEND, HINIC3_MSG_ACK, &msg_info);
+	if (err) {
+		dev_err(mbox->hwdev->dev, "Send mailbox mod %u, cmd %u failed, msg_id: %u, err: %d\n",
+			mod, cmd, msg_info.msg_id, err);
+		set_mbox_to_func_event(mbox, EVENT_FAIL);
+		goto err_send;
+	}
+
+	if (wait_mbox_msg_completion(mbox, timeout)) {
+		dev_err(mbox->hwdev->dev,
+			"Send mbox msg timeout, msg_id: %u\n", msg_info.msg_id);
+		hinic3_dump_aeq_info(mbox->hwdev);
+		err = -ETIMEDOUT;
+		goto err_send;
+	}
+
+	if (mod != msg_desc->mod || cmd != msg_desc->cmd) {
+		dev_err(mbox->hwdev->dev,
+			"Invalid response mbox message, mod: 0x%x, cmd: 0x%x, expect mod: 0x%x, cmd: 0x%x\n",
+			msg_desc->mod, msg_desc->cmd, mod, cmd);
+		err = -EFAULT;
+		goto err_send;
+	}
+
+	if (msg_desc->msg_info.status) {
+		err = msg_desc->msg_info.status;
+		goto err_send;
+	}
+
+	if (buf_out && out_size) {
+		if (*out_size < msg_desc->msg_len) {
+			dev_err(mbox->hwdev->dev,
+				"Invalid response mbox message length: %u for mod %d cmd %u, should less than: %u\n",
+				msg_desc->msg_len, mod, cmd, *out_size);
+			err = -EFAULT;
+			goto err_send;
+		}
+
+		if (msg_desc->msg_len)
+			memcpy(buf_out, msg_desc->msg, msg_desc->msg_len);
+
+		*out_size = msg_desc->msg_len;
+	}
+
+err_send:
+	send_mbox_msg_unlock(mbox);
+
+	return err;
+}
+
+static int mbox_func_params_valid(struct hinic3_mbox *mbox,
+				  const void *buf_in, u32 in_size)
+{
+	if (!buf_in || !in_size)
+		return -EINVAL;
+
+	if (in_size > HINIC3_MBOX_DATA_SIZE) {
+		dev_err(mbox->hwdev->dev,
+			"Mbox msg len %u exceed limit: [1, %u]\n",
+			in_size, HINIC3_MBOX_DATA_SIZE);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_mbox_to_func_no_ack(struct hinic3_hwdev *hwdev, u16 func_idx,
+				      u8 mod, u16 cmd, const void *buf_in, u32 in_size)
+{
+	struct mbox_msg_info msg_info = {};
+	int err;
+
+	err = mbox_func_params_valid(hwdev->mbox, buf_in, in_size);
+	if (err)
+		return err;
+
+	err = send_mbox_msg_lock(hwdev->mbox);
+	if (err)
+		return err;
+
+	err = send_mbox_msg(hwdev->mbox, mod, cmd, buf_in, in_size,
+			    func_idx, HINIC3_MSG_DIRECT_SEND,
+			    HINIC3_MSG_NO_ACK, &msg_info);
+	if (err)
+		dev_err(hwdev->dev, "Send mailbox no ack failed\n");
+
+	send_mbox_msg_unlock(hwdev->mbox);
+
+	return err;
+}
+
+int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+			     const void *buf_in, u32 in_size, void *buf_out,
+			     u32 *out_size, u32 timeout)
+{
+	struct hinic3_mbox *mbox = hwdev->mbox;
+	int err;
+
+	err = mbox_func_params_valid(mbox, buf_in, in_size);
+	if (err)
+		return err;
+
+	if (mod == HINIC3_MOD_COMM && cmd == COMM_MGMT_CMD_SEND_API_ACK_BY_UP)
+		return 0;
+
+	return hinic3_mbox_to_func(mbox, mod, cmd, HINIC3_MGMT_SRC_ID,
+				   buf_in, in_size, buf_out, out_size, timeout);
+}
+
+void hinic3_response_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+				  const void *buf_in, u32 in_size, u16 msg_id)
+{
+	struct mbox_msg_info msg_info;
+
+	msg_info.msg_id = (u8)msg_id;
+	msg_info.status = 0;
+
+	send_mbox_msg(hwdev->mbox, mod, cmd, buf_in, in_size,
+		      HINIC3_MGMT_SRC_ID, HINIC3_MSG_RESPONSE,
+		      HINIC3_MSG_NO_ACK, &msg_info);
+}
+
+int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+				    const void *buf_in, u32 in_size)
+{
+	struct hinic3_mbox *mbox = hwdev->mbox;
+	int err;
+
+	err = mbox_func_params_valid(mbox, buf_in, in_size);
+	if (err)
+		return err;
+
+	return hinic3_mbox_to_func_no_ack(hwdev, HINIC3_MGMT_SRC_ID, mod, cmd,
+					  buf_in, in_size);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
new file mode 100644
index 000000000000..fde8ee9fd330
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_MBOX_H
+#define HINIC3_MBOX_H
+
+#include "hinic3_hwdev.h"
+
+#define HINIC3_MSG_HEADER_SRC_GLB_FUNC_IDX_MASK  GENMASK_ULL(12, 0)
+#define HINIC3_MSG_HEADER_STATUS_MASK            BIT_ULL(13)
+#define HINIC3_MSG_HEADER_SOURCE_MASK            BIT_ULL(15)
+#define HINIC3_MSG_HEADER_AEQ_ID_MASK            GENMASK_ULL(17, 16)
+#define HINIC3_MSG_HEADER_MSG_ID_MASK            GENMASK_ULL(21, 18)
+#define HINIC3_MSG_HEADER_CMD_MASK               GENMASK_ULL(31, 22)
+
+#define HINIC3_MSG_HEADER_MSG_LEN_MASK           GENMASK_ULL(42, 32)
+#define HINIC3_MSG_HEADER_MODULE_MASK            GENMASK_ULL(47, 43)
+#define HINIC3_MSG_HEADER_SEG_LEN_MASK           GENMASK_ULL(53, 48)
+#define HINIC3_MSG_HEADER_NO_ACK_MASK            BIT_ULL(54)
+#define HINIC3_MSG_HEADER_DATA_TYPE_MASK         BIT_ULL(55)
+#define HINIC3_MSG_HEADER_SEQID_MASK             GENMASK_ULL(61, 56)
+#define HINIC3_MSG_HEADER_LAST_MASK              BIT_ULL(62)
+#define HINIC3_MSG_HEADER_DIRECTION_MASK         BIT_ULL(63)
+
+#define HINIC3_MSG_HEADER_SET(val, member) \
+	FIELD_PREP(HINIC3_MSG_HEADER_##member##_MASK, val)
+
+#define HINIC3_MSG_HEADER_GET(val, member) \
+	FIELD_GET(HINIC3_MSG_HEADER_##member##_MASK, val)
+
+#define HINIC3_MGMT_SRC_ID        0x1FFF
+#define IS_DMA_MBX_MSG(dst_func)  ((dst_func) == HINIC3_MGMT_SRC_ID)
+#define COMM_F_MBOX_SEGMENT       BIT(3)
+#define SUPPORT_SEGMENT(feature)  ((feature) & COMM_F_MBOX_SEGMENT)
+
+enum hinic3_msg_direction_type {
+	HINIC3_MSG_DIRECT_SEND = 0,
+	HINIC3_MSG_RESPONSE    = 1,
+};
+
+enum hinic3_msg_segment_type {
+	NOT_LAST_SEGMENT = 0,
+	LAST_SEGMENT     = 1,
+};
+
+enum hinic3_msg_ack_type {
+	HINIC3_MSG_ACK    = 0,
+	HINIC3_MSG_NO_ACK = 1,
+};
+
+enum hinic3_data_type {
+	HINIC3_DATA_INLINE = 0,
+	HINIC3_DATA_DMA    = 1,
+};
+
+enum hinic3_msg_src_type {
+	HINIC3_MSG_FROM_MGMT = 0,
+	HINIC3_MSG_FROM_MBOX = 1,
+};
+
+enum hinic3_msg_aeq_type {
+	HINIC3_AEQ_FOR_EVENT = 0,
+	HINIC3_AEQ_FOR_MBOX  = 1,
+};
+
+#define HINIC3_MBOX_WQ_NAME  "hinic3_mbox"
+
+struct mbox_msg_info {
+	u8 msg_id;
+	u8 status;
+};
+
+struct hinic3_msg_desc {
+	void   *msg;
+	u16    msg_len;
+	u8     seq_id;
+	u8     mod;
+	u16    cmd;
+	struct mbox_msg_info msg_info;
+};
+
+struct hinic3_msg_channel {
+	struct   hinic3_msg_desc resp_msg;
+	struct   hinic3_msg_desc recv_msg;
+	atomic_t recv_msg_cnt;
+};
+
+struct hinic3_send_mbox {
+	u8 __iomem *data;
+	void       *wb_vaddr;
+	dma_addr_t wb_paddr;
+};
+
+enum mbox_event_state {
+	EVENT_START   = 0,
+	EVENT_FAIL    = 1,
+	EVENT_SUCCESS = 2,
+	EVENT_TIMEOUT = 3,
+	EVENT_END     = 4,
+};
+
+struct mbox_dma_msg {
+	u32 xor;
+	u32 dma_addr_high;
+	u32 dma_addr_low;
+	u32 msg_len;
+	u64 rsvd;
+};
+
+struct mbox_dma_queue {
+	void       *dma_buff_vaddr;
+	dma_addr_t dma_buff_paddr;
+
+	u16        depth;
+	u16        prod_idx;
+	u16        cons_idx;
+};
+
+struct hinic3_mbox {
+	struct hinic3_hwdev       *hwdev;
+
+	/* lock for send mbox message and ack message */
+	struct mutex              mbox_send_lock;
+	/* lock for send mbox message */
+	struct mutex              msg_send_lock;
+	struct hinic3_send_mbox   send_mbox;
+
+	struct mbox_dma_queue     sync_msg_queue;
+	struct mbox_dma_queue     async_msg_queue;
+
+	struct workqueue_struct   *workq;
+	/* driver and MGMT CPU */
+	struct hinic3_msg_channel mgmt_msg;
+	/* PF to VF or VF to PF */
+	struct hinic3_msg_channel *func_msg;
+	u16                       num_func_msg;
+
+	u8                        send_msg_id;
+	enum mbox_event_state     event_flag;
+	/* lock for mbox event flag */
+	spinlock_t                mbox_lock;
+};
+
+void hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header, u8 size);
+int hinic3_init_mbox(struct hinic3_hwdev *hwdev);
+void hinic3_free_mbox(struct hinic3_hwdev *hwdev);
+
+int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+			     const void *buf_in, u32 in_size, void *buf_out,
+			     u32 *out_size, u32 timeout);
+
+void hinic3_response_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+				  const void *buf_in, u32 in_size, u16 msg_id);
+
+int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+				    const void *buf_in, u32 in_size);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
new file mode 100644
index 000000000000..d2ea834ceb91
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/semaphore.h>
+#include <linux/delay.h>
+
+#include "hinic3_common.h"
+#include "hinic3_csr.h"
+#include "hinic3_hwif.h"
+#include "hinic3_eqs.h"
+#include "hinic3_mbox.h"
+#include "hinic3_mgmt.h"
+
+#define HINIC3_MSG_TO_MGMT_MAX_LEN    2016
+
+#define MAX_PF_MGMT_BUF_SIZE          2048UL
+#define MGMT_SEG_LEN_MAX              48
+#define ASYNC_MSG_FLAG                0x8
+
+/* Bogus sequence ID to prevent accidental match following partial message */
+#define MGMT_BOGUS_SEQ_ID             (MAX_PF_MGMT_BUF_SIZE / MGMT_SEG_LEN_MAX + 1)
+
+static void mgmt_resp_msg_handler(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,
+				  struct hinic3_recv_msg *recv_msg)
+{
+	struct device *dev = pf_to_mgmt->hwdev->dev;
+
+	/* Ignore async msg */
+	if (recv_msg->msg_id & ASYNC_MSG_FLAG)
+		return;
+
+	spin_lock(&pf_to_mgmt->sync_event_lock);
+	if (recv_msg->msg_id != pf_to_mgmt->sync_msg_id) {
+		dev_err(dev, "msg id mismatch, send msg id: 0x%x, recv msg id: 0x%x, event state: %d\n",
+			pf_to_mgmt->sync_msg_id, recv_msg->msg_id,
+			pf_to_mgmt->event_flag);
+	} else if (pf_to_mgmt->event_flag == SEND_EVENT_START) {
+		pf_to_mgmt->event_flag = SEND_EVENT_SUCCESS;
+		complete(&recv_msg->recv_done);
+	} else {
+		dev_err(dev, "Wait timeout, send msg id: 0x%x, recv msg id: 0x%x, event state: %d\n",
+			pf_to_mgmt->sync_msg_id, recv_msg->msg_id,
+			pf_to_mgmt->event_flag);
+	}
+	spin_unlock(&pf_to_mgmt->sync_event_lock);
+}
+
+static void recv_mgmt_msg_work_handler(struct work_struct *work)
+{
+	struct hinic3_mgmt_msg_handle_work *mgmt_work;
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
+	struct mgmt_msg_head *ack_cmd;
+
+	mgmt_work = container_of(work, struct hinic3_mgmt_msg_handle_work, work);
+
+	/* At the moment, we do not expect any meaningful messages but if the
+	 * sender expects an ACK we still need to provide one with "unsupported"
+	 * status.
+	 */
+	if (mgmt_work->async_mgmt_to_pf)
+		goto out;
+
+	pf_to_mgmt = mgmt_work->pf_to_mgmt;
+	ack_cmd = pf_to_mgmt->mgmt_ack_buf;
+	memset(ack_cmd, 0, sizeof(*ack_cmd));
+	ack_cmd->status = MGMT_CMD_UNSUPPORTED;
+
+	hinic3_response_mbox_to_mgmt(pf_to_mgmt->hwdev, mgmt_work->mod,
+				     mgmt_work->cmd, ack_cmd, sizeof(*ack_cmd),
+				     mgmt_work->msg_id);
+
+out:
+	kfree(mgmt_work->msg);
+	kfree(mgmt_work);
+}
+
+static int recv_msg_add_seg(struct hinic3_recv_msg *recv_msg,
+			    u64 msg_header, const void *seg_data,
+			    bool *is_complete)
+{
+	u8 seq_id, msg_id, seg_len, is_last;
+	char *msg_buff;
+	u32 offset;
+
+	seg_len = HINIC3_MSG_HEADER_GET(msg_header, SEG_LEN);
+	is_last = HINIC3_MSG_HEADER_GET(msg_header, LAST);
+	seq_id  = HINIC3_MSG_HEADER_GET(msg_header, SEQID);
+	msg_id = HINIC3_MSG_HEADER_GET(msg_header, MSG_ID);
+
+	if (seg_len > MGMT_SEG_LEN_MAX)
+		return -EINVAL;
+
+	/* All segments but last must be of maximal size */
+	if (seg_len != MGMT_SEG_LEN_MAX && !is_last)
+		return -EINVAL;
+
+	if (seq_id == 0) {
+		recv_msg->seq_id = seq_id;
+		recv_msg->msg_id = msg_id;
+	} else if (seq_id != recv_msg->seq_id + 1 || msg_id != recv_msg->msg_id) {
+		return -EINVAL;
+	}
+
+	offset = seq_id * MGMT_SEG_LEN_MAX;
+	if (offset + seg_len > MAX_PF_MGMT_BUF_SIZE)
+		return -EINVAL;
+
+	msg_buff = recv_msg->msg;
+	memcpy(msg_buff + offset, seg_data, seg_len);
+	recv_msg->msg_len = offset + seg_len;
+	recv_msg->seq_id = seq_id;
+	*is_complete = !!is_last;
+	return 0;
+}
+
+static void init_mgmt_msg_work(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,
+			       struct hinic3_recv_msg *recv_msg)
+{
+	struct hinic3_mgmt_msg_handle_work *mgmt_work;
+
+	mgmt_work = kzalloc(sizeof(*mgmt_work), GFP_KERNEL);
+	if (!mgmt_work)
+		return;
+
+	if (recv_msg->msg_len) {
+		mgmt_work->msg = kzalloc(recv_msg->msg_len, GFP_KERNEL);
+		if (!mgmt_work->msg) {
+			kfree(mgmt_work);
+			return;
+		}
+	}
+
+	mgmt_work->pf_to_mgmt = pf_to_mgmt;
+	mgmt_work->msg_len = recv_msg->msg_len;
+	memcpy(mgmt_work->msg, recv_msg->msg, recv_msg->msg_len);
+	mgmt_work->msg_id = recv_msg->msg_id;
+	mgmt_work->mod = recv_msg->mod;
+	mgmt_work->cmd = recv_msg->cmd;
+	mgmt_work->async_mgmt_to_pf = recv_msg->async_mgmt_to_pf;
+
+	INIT_WORK(&mgmt_work->work, recv_mgmt_msg_work_handler);
+	queue_work_on(WORK_CPU_UNBOUND, pf_to_mgmt->workq, &mgmt_work->work);
+}
+
+static void recv_mgmt_msg_handler(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,
+				  const u8 *header,
+				  struct hinic3_recv_msg *recv_msg)
+{
+	struct hinic3_hwdev *hwdev = pf_to_mgmt->hwdev;
+	const void *seg_data;
+	bool is_complete;
+	u64 msg_header;
+	u8 dir, msg_id;
+	int err;
+
+	msg_header = *(const u64 *)header;
+	dir = HINIC3_MSG_HEADER_GET(msg_header, DIRECTION);
+	msg_id = HINIC3_MSG_HEADER_GET(msg_header, MSG_ID);
+	/* Don't need to get anything from hw when cmd is async */
+	if (dir == HINIC3_MSG_RESPONSE && (msg_id & ASYNC_MSG_FLAG))
+		return;
+
+	seg_data = header + sizeof(msg_header);
+	err = recv_msg_add_seg(recv_msg, msg_header, seg_data, &is_complete);
+	if (err) {
+		dev_err(hwdev->dev, "invalid receive segment\n");
+		/* set seq_id to invalid seq_id */
+		recv_msg->seq_id = MGMT_BOGUS_SEQ_ID;
+		return;
+	}
+
+	if (!is_complete)
+		return;
+
+	recv_msg->cmd = HINIC3_MSG_HEADER_GET(msg_header, CMD);
+	recv_msg->mod = HINIC3_MSG_HEADER_GET(msg_header, MODULE);
+	recv_msg->async_mgmt_to_pf = HINIC3_MSG_HEADER_GET(msg_header, NO_ACK);
+	recv_msg->seq_id = MGMT_BOGUS_SEQ_ID;
+
+	if (dir == HINIC3_MSG_RESPONSE)
+		mgmt_resp_msg_handler(pf_to_mgmt, recv_msg);
+	else
+		init_mgmt_msg_work(pf_to_mgmt, recv_msg);
+}
+
+static int alloc_recv_msg(struct hinic3_recv_msg *recv_msg)
+{
+	recv_msg->seq_id = MGMT_BOGUS_SEQ_ID;
+
+	recv_msg->msg = kzalloc(MAX_PF_MGMT_BUF_SIZE, GFP_KERNEL);
+	if (!recv_msg->msg)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void free_recv_msg(struct hinic3_recv_msg *recv_msg)
+{
+	kfree(recv_msg->msg);
+}
+
+static int alloc_msg_buf(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt)
+{
+	struct device *dev = pf_to_mgmt->hwdev->dev;
+	int err;
+
+	err = alloc_recv_msg(&pf_to_mgmt->recv_msg_from_mgmt);
+	if (err) {
+		dev_err(dev, "Failed to allocate recv msg\n");
+		return err;
+	}
+
+	err = alloc_recv_msg(&pf_to_mgmt->recv_resp_msg_from_mgmt);
+	if (err) {
+		dev_err(dev, "Failed to allocate resp recv msg\n");
+		goto free_msg_from_mgmt;
+	}
+
+	pf_to_mgmt->mgmt_ack_buf = kzalloc(MAX_PF_MGMT_BUF_SIZE, GFP_KERNEL);
+	if (!pf_to_mgmt->mgmt_ack_buf) {
+		err = -ENOMEM;
+		goto free_resp_msg_from_mgmt;
+	}
+
+	return 0;
+
+free_resp_msg_from_mgmt:
+	free_recv_msg(&pf_to_mgmt->recv_resp_msg_from_mgmt);
+
+free_msg_from_mgmt:
+	free_recv_msg(&pf_to_mgmt->recv_msg_from_mgmt);
+	return err;
+}
+
+static void free_msg_buf(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt)
+{
+	kfree(pf_to_mgmt->mgmt_ack_buf);
+
+	free_recv_msg(&pf_to_mgmt->recv_resp_msg_from_mgmt);
+	free_recv_msg(&pf_to_mgmt->recv_msg_from_mgmt);
+}
+
+int hinic3_pf_to_mgmt_init(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
+	int err;
+
+	pf_to_mgmt = kzalloc(sizeof(*pf_to_mgmt), GFP_KERNEL);
+	if (!pf_to_mgmt)
+		return -ENOMEM;
+
+	hwdev->pf_to_mgmt = pf_to_mgmt;
+	pf_to_mgmt->hwdev = hwdev;
+	spin_lock_init(&pf_to_mgmt->sync_event_lock);
+	pf_to_mgmt->workq = create_singlethread_workqueue(HINIC3_MGMT_WQ_NAME);
+	if (!pf_to_mgmt->workq) {
+		dev_err(hwdev->dev, "Failed to initialize MGMT workqueue\n");
+		err = -ENOMEM;
+		goto err_create_mgmt_workq;
+	}
+
+	err = alloc_msg_buf(pf_to_mgmt);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate msg buffers\n");
+		goto err_alloc_msg_buf;
+	}
+
+	return 0;
+
+err_alloc_msg_buf:
+	destroy_workqueue(pf_to_mgmt->workq);
+
+err_create_mgmt_workq:
+	kfree(pf_to_mgmt);
+
+	return err;
+}
+
+void hinic3_pf_to_mgmt_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt = hwdev->pf_to_mgmt;
+
+	/* destroy workqueue before free related pf_to_mgmt resources in case of
+	 * illegal resource access
+	 */
+	destroy_workqueue(pf_to_mgmt->workq);
+
+	free_msg_buf(pf_to_mgmt);
+	kfree(pf_to_mgmt);
+}
+
+void hinic3_flush_mgmt_workq(struct hinic3_hwdev *hwdev)
+{
+	if (hwdev->aeqs)
+		flush_workqueue(hwdev->aeqs->workq);
+
+	if (HINIC3_IS_PF(hwdev) && hwdev->pf_to_mgmt)
+		flush_workqueue(hwdev->pf_to_mgmt->workq);
+}
+
+void hinic3_mgmt_msg_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header, u8 size)
+{
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
+	struct hinic3_recv_msg *recv_msg;
+	bool is_send_dir;
+
+	if ((HINIC3_MSG_HEADER_GET(*(u64 *)header, SOURCE) ==
+	     HINIC3_MSG_FROM_MBOX)) {
+		hinic3_mbox_func_aeqe_handler(hwdev, header, size);
+		return;
+	}
+
+	pf_to_mgmt = hwdev->pf_to_mgmt;
+	if (!pf_to_mgmt)
+		return;
+
+	is_send_dir = (HINIC3_MSG_HEADER_GET(*(u64 *)header, DIRECTION) ==
+		       HINIC3_MSG_DIRECT_SEND) ? true : false;
+
+	recv_msg = is_send_dir ? &pf_to_mgmt->recv_msg_from_mgmt :
+		   &pf_to_mgmt->recv_resp_msg_from_mgmt;
+
+	recv_mgmt_msg_handler(pf_to_mgmt, header, recv_msg);
+}
+
+int hinic3_get_chip_present_flag(const struct hinic3_hwdev *hwdev)
+{
+	return hwdev->chip_present_flag;
+}
+
+int hinic3_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd, const void *buf_in,
+			    u32 in_size, void *buf_out, u32 *out_size,
+			    u32 timeout)
+{
+	if (hinic3_get_chip_present_flag(hwdev) == 0)
+		return -EPERM;
+
+	return hinic3_send_mbox_to_mgmt(hwdev, mod, cmd, buf_in, in_size,
+					buf_out, out_size, timeout);
+}
+
+int hinic3_msg_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd, const void *buf_in,
+			      u32 in_size)
+{
+	if (hinic3_get_chip_present_flag(hwdev) == 0)
+		return -EPERM;
+
+	return hinic3_send_mbox_to_mgmt_no_ack(hwdev, mod, cmd, buf_in, in_size);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
new file mode 100644
index 000000000000..7106555ab176
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_MGMT_H
+#define HINIC3_MGMT_H
+
+#include <linux/types.h>
+#include <linux/completion.h>
+#include <linux/semaphore.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include "hinic3_hwif.h"
+#include "hinic3_hw_intf.h"
+
+#define HINIC3_MGMT_WQ_NAME    "hinic3_mgmt"
+
+struct hinic3_recv_msg {
+	/* Preallocated buffer of size MAX_PF_MGMT_BUF_SIZE that accumulates
+	 * receive message, segment-by-segment.
+	 */
+	void                 *msg;
+	/* Message id for which segments are accumulated. */
+	u8                   msg_id;
+	/* Sequence id of last received segment of current message. */
+	u8                   seq_id;
+	u16                  msg_len;
+	int                  async_mgmt_to_pf;
+	enum hinic3_mod_type mod;
+	u16                  cmd;
+	struct completion    recv_done;
+};
+
+enum comm_pf_to_mgmt_event_state {
+	SEND_EVENT_UNINIT = 0,
+	SEND_EVENT_START,
+	SEND_EVENT_SUCCESS,
+	SEND_EVENT_TIMEOUT,
+};
+
+struct hinic3_msg_pf_to_mgmt {
+	struct hinic3_hwdev              *hwdev;
+	struct workqueue_struct          *workq;
+	void                             *mgmt_ack_buf;
+	struct hinic3_recv_msg           recv_msg_from_mgmt;
+	struct hinic3_recv_msg           recv_resp_msg_from_mgmt;
+	u16                              async_msg_id;
+	u16                              sync_msg_id;
+	void                             *async_msg_cb_data[HINIC3_MOD_HW_MAX];
+	/* synchronizes message send with message receives via event queue */
+	spinlock_t                       sync_event_lock;
+	enum comm_pf_to_mgmt_event_state event_flag;
+};
+
+struct hinic3_mgmt_msg_handle_work {
+	struct work_struct           work;
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
+	void                         *msg;
+	u16                          msg_len;
+	enum hinic3_mod_type         mod;
+	u16                          cmd;
+	u16                          msg_id;
+	int                          async_mgmt_to_pf;
+};
+
+int hinic3_pf_to_mgmt_init(struct hinic3_hwdev *hwdev);
+void hinic3_pf_to_mgmt_free(struct hinic3_hwdev *hwdev);
+void hinic3_flush_mgmt_workq(struct hinic3_hwdev *hwdev);
+void hinic3_mgmt_msg_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header, u8 size);
+int hinic3_get_chip_present_flag(const struct hinic3_hwdev *hwdev);
+int hinic3_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd, const void *buf_in,
+			    u32 in_size, void *buf_out, u32 *out_size,
+			    u32 timeout);
+/* function may wait on mutex, not allowed to be used in interrupt context */
+int hinic3_msg_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd, const void *buf_in,
+			      u32 in_size);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
new file mode 100644
index 000000000000..a79eaaf77e06
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -0,0 +1,389 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC_MGMT_INTERFACE_H
+#define HINIC_MGMT_INTERFACE_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+#include <linux/if_ether.h>
+
+#define HINIC3_CMD_OP_SET  1
+#define HINIC3_CMD_OP_GET  0
+
+enum nic_feature_cap {
+	NIC_F_CSUM           = BIT(0),
+	NIC_F_SCTP_CRC       = BIT(1),
+	NIC_F_TSO            = BIT(2),
+	NIC_F_LRO            = BIT(3),
+	NIC_F_UFO            = BIT(4),
+	NIC_F_RSS            = BIT(5),
+	NIC_F_RX_VLAN_FILTER = BIT(6),
+	NIC_F_RX_VLAN_STRIP  = BIT(7),
+	NIC_F_TX_VLAN_INSERT = BIT(8),
+	NIC_F_VXLAN_OFFLOAD  = BIT(9),
+	NIC_F_FDIR           = BIT(11),
+	NIC_F_PROMISC        = BIT(12),
+	NIC_F_ALLMULTI       = BIT(13),
+	NIC_F_RATE_LIMIT     = BIT(16),
+};
+
+#define NIC_F_ALL_MASK           0x33bff
+#define NIC_DRV_DEFAULT_FEATURE  0x3f03f
+
+struct hinic3_mgmt_msg_head {
+	u8 status;
+	u8 version;
+	u8 rsvd0[6];
+};
+
+#define NIC_MAX_FEATURE_QWORD  4
+
+struct hinic3_cmd_feature_nego {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	/* 1: set, 0: get */
+	u8                          opcode;
+	u8                          rsvd;
+	u64                         s_feature[NIC_MAX_FEATURE_QWORD];
+};
+
+enum hinic3_func_tbl_cfg_bitmap {
+	FUNC_CFG_INIT        = 0,
+	FUNC_CFG_RX_BUF_SIZE = 1,
+	FUNC_CFG_MTU         = 2,
+};
+
+struct hinic3_func_tbl_cfg {
+	u16 rx_wqe_buf_size;
+	u16 mtu;
+	u32 rsvd[9];
+};
+
+struct hinic3_cmd_set_func_tbl {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u16                         rsvd;
+
+	u32                         cfg_bitmap;
+	struct hinic3_func_tbl_cfg  tbl_cfg;
+};
+
+struct hinic3_port_mac_set {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u16                         vlan_id;
+	u16                         rsvd1;
+	u8                          mac[ETH_ALEN];
+};
+
+struct hinic3_port_mac_update {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u16                         vlan_id;
+	u16                         rsvd1;
+	u8                          old_mac[ETH_ALEN];
+	u16                         rsvd2;
+	u8                          new_mac[ETH_ALEN];
+};
+
+struct hinic3_cmd_vlan_config {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u8                          opcode;
+	u8                          rsvd1;
+	u16                         vlan_id;
+	u16                         rsvd2;
+};
+
+struct hinic3_cmd_vlan_offload {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u8                          vlan_offload;
+	u8                          vd1[5];
+};
+
+/* set vlan filter */
+struct hinic3_cmd_set_vlan_filter {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u8                          resvd[2];
+	/* bit0:vlan filter en; bit1:broadcast_filter_en */
+	u32                         vlan_filter_ctrl;
+};
+
+struct hinic3_cmd_cons_idx_attr {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_idx;
+	u8                          dma_attr_off;
+	u8                          pending_limit;
+	u8                          coalescing_time;
+	u8                          intr_en;
+	u16                         intr_idx;
+	u32                         l2nic_sqn;
+	u32                         rsvd;
+	u64                         ci_addr;
+};
+
+struct hinic3_cmd_clear_qp_resource {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u16                         rsvd1;
+};
+
+struct hinic3_force_pkt_drop {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u8                          port;
+	u8                          rsvd1[3];
+};
+
+struct hinic3_vport_state {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u16                         rsvd1;
+	/* 0--disable, 1--enable */
+	u8                          state;
+	u8                          rsvd2[3];
+};
+
+/* *
+ * Definition of the NIC receiving mode
+ */
+#define NIC_RX_MODE_UC       0x01
+#define NIC_RX_MODE_MC       0x02
+#define NIC_RX_MODE_BC       0x04
+#define NIC_RX_MODE_MC_ALL   0x08
+#define NIC_RX_MODE_PROMISC  0x10
+
+struct hinic3_rx_mode_config {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u16                         rsvd1;
+	u32                         rx_mode;
+};
+
+/* IEEE 802.1Qaz std */
+#define NIC_DCB_COS_MAX      0x8
+#define NIC_DCB_MAX_PFC_NUM  0x4
+
+struct hinic3_cmd_set_dcb_state {
+	struct hinic3_mgmt_msg_head head;
+
+	u16                         func_id;
+	/* 0 - get dcb state, 1 - set dcb state */
+	u8                          op_code;
+	/* 0 - disable, 1 - enable dcb */
+	u8                          state;
+	/* 0 - disable, 1 - enable dcb */
+	u8                          port_state;
+	u8                          rsvd[7];
+};
+
+struct hinic3_cmd_pause_config {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u8                          port_id;
+	u8                          opcode;
+	u16                         rsvd1;
+	u8                          auto_neg;
+	u8                          rx_pause;
+	u8                          tx_pause;
+	u8                          rsvd2[5];
+};
+
+struct hinic3_port_stats_info {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u16                         rsvd1;
+};
+
+struct hinic3_vport_stats {
+	u64 tx_unicast_pkts_vport;
+	u64 tx_unicast_bytes_vport;
+	u64 tx_multicast_pkts_vport;
+	u64 tx_multicast_bytes_vport;
+	u64 tx_broadcast_pkts_vport;
+	u64 tx_broadcast_bytes_vport;
+
+	u64 rx_unicast_pkts_vport;
+	u64 rx_unicast_bytes_vport;
+	u64 rx_multicast_pkts_vport;
+	u64 rx_multicast_bytes_vport;
+	u64 rx_broadcast_pkts_vport;
+	u64 rx_broadcast_bytes_vport;
+
+	u64 tx_discard_vport;
+	u64 rx_discard_vport;
+	u64 tx_err_vport;
+	u64 rx_err_vport;
+};
+
+struct hinic3_cmd_vport_stats {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u32                         stats_size;
+	u32                         rsvd1;
+	struct hinic3_vport_stats   stats;
+	u64                         rsvd2[6];
+};
+
+struct hinic3_cmd_lro_config {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u8                          opcode;
+	u8                          rsvd1;
+	u8                          lro_ipv4_en;
+	u8                          lro_ipv6_en;
+	/* unit is 1K */
+	u8                          lro_max_pkt_len;
+	u8                          resv2[13];
+};
+
+struct hinic3_cmd_lro_timer {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	/* 1: set timer value, 0: get timer value */
+	u8                          opcode;
+	u8                          rsvd[3];
+	u32                         timer;
+};
+
+#define HINIC3_RSS_TYPE_VALID_MASK         BIT(23)
+#define HINIC3_RSS_TYPE_TCP_IPV6_EXT_MASK  BIT(24)
+#define HINIC3_RSS_TYPE_IPV6_EXT_MASK      BIT(25)
+#define HINIC3_RSS_TYPE_TCP_IPV6_MASK      BIT(26)
+#define HINIC3_RSS_TYPE_IPV6_MASK          BIT(27)
+#define HINIC3_RSS_TYPE_TCP_IPV4_MASK      BIT(28)
+#define HINIC3_RSS_TYPE_IPV4_MASK          BIT(29)
+#define HINIC3_RSS_TYPE_UDP_IPV6_MASK      BIT(30)
+#define HINIC3_RSS_TYPE_UDP_IPV4_MASK      BIT(31)
+#define HINIC3_RSS_TYPE_SET(val, member)  \
+	FIELD_PREP(HINIC3_RSS_TYPE_##member##_MASK, val)
+#define HINIC3_RSS_TYPE_GET(val, member)  \
+	FIELD_GET(HINIC3_RSS_TYPE_##member##_MASK, val)
+
+enum nic_rss_hash_type {
+	NIC_RSS_HASH_TYPE_XOR  = 0,
+	NIC_RSS_HASH_TYPE_TOEP = 1,
+
+	/* must be the last one */
+	NIC_RSS_HASH_TYPE_MAX
+};
+
+#define NIC_RSS_INDIR_SIZE  256
+#define NIC_RSS_KEY_SIZE    40
+
+struct hinic3_rss_context_table {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u16                         rsvd1;
+	u32                         context;
+};
+
+struct hinic3_cmd_rss_engine_type {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u8                          opcode;
+	u8                          hash_engine;
+	u8                          rsvd1[4];
+};
+
+struct hinic3_cmd_rss_hash_key {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u8                          opcode;
+	u8                          rsvd1;
+	u8                          key[NIC_RSS_KEY_SIZE];
+};
+
+struct hinic3_cmd_rss_config {
+	struct hinic3_mgmt_msg_head msg_head;
+
+	u16                         func_id;
+	u8                          rss_en;
+	u8                          rq_priority_number;
+	u8                          prio_tc[NIC_DCB_COS_MAX];
+	u16                         num_qps;
+	u16                         rsvd1;
+};
+
+/* Commands between NIC to fw */
+enum hinic3_nic_cmd {
+	/* FUNC CFG */
+	HINIC3_NIC_CMD_SET_FUNC_TBL              = 5,
+	HINIC3_NIC_CMD_SET_VPORT_ENABLE          = 6,
+	HINIC3_NIC_CMD_SET_RX_MODE               = 7,
+	HINIC3_NIC_CMD_SQ_CI_ATTR_SET            = 8,
+	HINIC3_NIC_CMD_GET_VPORT_STAT            = 9,
+	HINIC3_NIC_CMD_CLEAN_VPORT_STAT          = 10,
+	HINIC3_NIC_CMD_CLEAR_QP_RESOURCE         = 11,
+	HINIC3_NIC_CMD_CFG_FLEX_QUEUE            = 12,
+	/* LRO CFG */
+	HINIC3_NIC_CMD_CFG_RX_LRO                = 13,
+	HINIC3_NIC_CMD_CFG_LRO_TIMER             = 14,
+	HINIC3_NIC_CMD_FEATURE_NEGO              = 15,
+	HINIC3_NIC_CMD_CFG_LOCAL_LRO_STATE       = 16,
+
+	/* MAC & VLAN CFG */
+	HINIC3_NIC_CMD_GET_MAC                   = 20,
+	HINIC3_NIC_CMD_SET_MAC                   = 21,
+	HINIC3_NIC_CMD_DEL_MAC                   = 22,
+	HINIC3_NIC_CMD_UPDATE_MAC                = 23,
+	HINIC3_NIC_CMD_GET_ALL_DEFAULT_MAC       = 24,
+
+	HINIC3_NIC_CMD_CFG_FUNC_VLAN             = 25,
+	HINIC3_NIC_CMD_SET_VLAN_FILTER_EN        = 26,
+	HINIC3_NIC_CMD_SET_RX_VLAN_OFFLOAD       = 27,
+
+	HINIC3_NIC_CMD_RSS_CFG                   = 60,
+
+	HINIC3_NIC_CMD_GET_RSS_CTX_TBL           = 62,
+	HINIC3_NIC_CMD_CFG_RSS_HASH_KEY          = 63,
+	HINIC3_NIC_CMD_CFG_RSS_HASH_ENGINE       = 64,
+	HINIC3_NIC_CMD_SET_RSS_CTX_TBL_INTO_FUNC = 65,
+
+	HINIC3_NIC_CMD_SET_PORT_ENABLE           = 100,
+	HINIC3_NIC_CMD_CFG_PAUSE_INFO            = 101,
+	HINIC3_NIC_CMD_SET_PORT_CAR              = 102,
+	HINIC3_NIC_CMD_SET_ER_DROP_PKT           = 103,
+	HINIC3_NIC_CMD_VF_COS                    = 104,
+	HINIC3_NIC_CMD_SETUP_COS_MAPPING         = 105,
+	HINIC3_NIC_CMD_SET_ETS                   = 106,
+	HINIC3_NIC_CMD_SET_PFC                   = 107,
+	HINIC3_NIC_CMD_QOS_ETS                   = 108,
+	HINIC3_NIC_CMD_QOS_PFC                   = 109,
+	HINIC3_NIC_CMD_QOS_DCB_STATE             = 110,
+	HINIC3_NIC_CMD_QOS_PORT_CFG              = 111,
+	HINIC3_NIC_CMD_QOS_MAP_CFG               = 112,
+	HINIC3_NIC_CMD_FORCE_PKT_DROP            = 113,
+
+	HINIC3_NIC_CMD_MAX                       = 256,
+};
+
+/* NIC CMDQ MODE */
+enum hinic3_ucode_cmd {
+	HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX    = 0,
+	HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT = 1,
+	HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE = 4,
+	HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE = 6,
+	HINIC3_UCODE_CMD_MODIFY_VLAN_CTX     = 11,
+};
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
new file mode 100644
index 000000000000..cc95f0ee1385
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -0,0 +1,951 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+
+#include "hinic3_hw_cfg.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_rss.h"
+
+/* The unit is 1Kbyte */
+#define HINIC3_LRO_DEFAULT_COAL_PKT_SIZE  32
+#define HINIC3_LRO_DEFAULT_TIME_LIMIT     16
+
+#define VLAN_BITMAP_BYTE_SIZE(nic_dev)    (sizeof(*(nic_dev)->vlan_bitmap))
+#define VLAN_BITMAP_BITS_SIZE(nic_dev)    (VLAN_BITMAP_BYTE_SIZE(nic_dev) * 8)
+#define VID_LINE(nic_dev, vid)            ((vid) / VLAN_BITMAP_BITS_SIZE(nic_dev))
+#define VID_COL(nic_dev, vid)             ((vid) & (VLAN_BITMAP_BITS_SIZE(nic_dev) - 1))
+
+/* try to modify the number of irq to the target number,
+ * and return the actual number of irq.
+ */
+static u16 hinic3_qp_irq_change(struct net_device *netdev,
+				u16 dst_num_qp_irq)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 resp_irq_num, irq_num_gap, i;
+	struct irq_info *qps_irq_info;
+	u16 idx;
+	int err;
+
+	qps_irq_info = nic_dev->qps_irq_info;
+	if (dst_num_qp_irq > nic_dev->num_qp_irq) {
+		irq_num_gap = dst_num_qp_irq - nic_dev->num_qp_irq;
+		err = hinic3_alloc_irqs(nic_dev->hwdev, SERVICE_T_NIC,
+					irq_num_gap,
+					&qps_irq_info[nic_dev->num_qp_irq],
+					&resp_irq_num);
+		if (err) {
+			netdev_err(netdev, "Failed to alloc irqs\n");
+			return nic_dev->num_qp_irq;
+		}
+
+		nic_dev->num_qp_irq += resp_irq_num;
+	} else if (dst_num_qp_irq < nic_dev->num_qp_irq) {
+		irq_num_gap = nic_dev->num_qp_irq - dst_num_qp_irq;
+		for (i = 0; i < irq_num_gap; i++) {
+			idx = (nic_dev->num_qp_irq - i) - 1;
+			hinic3_free_irq(nic_dev->hwdev, SERVICE_T_NIC,
+					qps_irq_info[idx].irq_id);
+			qps_irq_info[idx].irq_id = 0;
+			qps_irq_info[idx].msix_entry_idx = 0;
+		}
+		nic_dev->num_qp_irq = dst_num_qp_irq;
+	}
+
+	return nic_dev->num_qp_irq;
+}
+
+static void hinic3_config_num_qps(struct net_device *netdev,
+				  struct hinic3_dyna_txrxq_params *q_params)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 alloc_num_irq, cur_num_irq;
+	u16 dst_num_irq;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags))
+		q_params->num_qps = 1;
+
+	if (nic_dev->num_qp_irq >= q_params->num_qps)
+		goto out;
+
+	cur_num_irq = nic_dev->num_qp_irq;
+
+	alloc_num_irq = hinic3_qp_irq_change(netdev, q_params->num_qps);
+	if (alloc_num_irq < q_params->num_qps) {
+		q_params->num_qps = alloc_num_irq;
+		netdev_warn(netdev, "Can not get enough irqs, adjust num_qps to %u\n",
+			    q_params->num_qps);
+
+		/* The current irq may be in use, we must keep it */
+		dst_num_irq = max_t(u16, cur_num_irq, q_params->num_qps);
+		hinic3_qp_irq_change(netdev, dst_num_irq);
+	}
+
+out:
+	netdev_dbg(netdev, "Finally num_qps: %u\n", q_params->num_qps);
+}
+
+static int hinic3_setup_num_qps(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u32 irq_size;
+
+	nic_dev->num_qp_irq = 0;
+
+	irq_size = sizeof(*nic_dev->qps_irq_info) * nic_dev->max_qps;
+	if (!irq_size) {
+		netdev_err(netdev, "Cannot allocate zero size entries\n");
+		return -EINVAL;
+	}
+	nic_dev->qps_irq_info = kzalloc(irq_size, GFP_KERNEL);
+	if (!nic_dev->qps_irq_info)
+		return -ENOMEM;
+
+	hinic3_config_num_qps(netdev, &nic_dev->q_params);
+
+	return 0;
+}
+
+static void hinic3_destroy_num_qps(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i;
+
+	for (i = 0; i < nic_dev->num_qp_irq; i++)
+		hinic3_free_irq(nic_dev->hwdev, SERVICE_T_NIC,
+				nic_dev->qps_irq_info[i].irq_id);
+
+	kfree(nic_dev->qps_irq_info);
+}
+
+static int hinic3_alloc_txrxq_resources(struct net_device *netdev,
+					struct hinic3_dyna_txrxq_params *q_params)
+{
+	u32 size;
+	int err;
+
+	size = sizeof(*q_params->txqs_res) * q_params->num_qps;
+	q_params->txqs_res = kzalloc(size, GFP_KERNEL);
+	if (!q_params->txqs_res)
+		return -ENOMEM;
+
+	size = sizeof(*q_params->rxqs_res) * q_params->num_qps;
+	q_params->rxqs_res = kzalloc(size, GFP_KERNEL);
+	if (!q_params->rxqs_res) {
+		err = -ENOMEM;
+		goto err_alloc_rxqs_res_arr;
+	}
+
+	size = sizeof(*q_params->irq_cfg) * q_params->num_qps;
+	q_params->irq_cfg = kzalloc(size, GFP_KERNEL);
+	if (!q_params->irq_cfg) {
+		err = -ENOMEM;
+		goto err_alloc_irq_cfg;
+	}
+
+	err = hinic3_alloc_txqs_res(netdev, q_params->num_qps,
+				    q_params->sq_depth, q_params->txqs_res);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc txqs resource\n");
+		goto err_alloc_txqs_res;
+	}
+
+	err = hinic3_alloc_rxqs_res(netdev, q_params->num_qps,
+				    q_params->rq_depth, q_params->rxqs_res);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc rxqs resource\n");
+		goto err_alloc_rxqs_res;
+	}
+
+	return 0;
+
+err_alloc_rxqs_res:
+	hinic3_free_txqs_res(netdev, q_params->num_qps, q_params->sq_depth,
+			     q_params->txqs_res);
+
+err_alloc_txqs_res:
+	kfree(q_params->irq_cfg);
+	q_params->irq_cfg = NULL;
+
+err_alloc_irq_cfg:
+	kfree(q_params->rxqs_res);
+	q_params->rxqs_res = NULL;
+
+err_alloc_rxqs_res_arr:
+	kfree(q_params->txqs_res);
+	q_params->txqs_res = NULL;
+
+	return err;
+}
+
+static void hinic3_free_txrxq_resources(struct net_device *netdev,
+					struct hinic3_dyna_txrxq_params *q_params)
+{
+	hinic3_free_rxqs_res(netdev, q_params->num_qps, q_params->rq_depth,
+			     q_params->rxqs_res);
+	hinic3_free_txqs_res(netdev, q_params->num_qps, q_params->sq_depth,
+			     q_params->txqs_res);
+
+	kfree(q_params->irq_cfg);
+	q_params->irq_cfg = NULL;
+
+	kfree(q_params->rxqs_res);
+	q_params->rxqs_res = NULL;
+
+	kfree(q_params->txqs_res);
+	q_params->txqs_res = NULL;
+}
+
+static int hinic3_configure_txrxqs(struct net_device *netdev,
+				   struct hinic3_dyna_txrxq_params *q_params)
+{
+	int err;
+
+	err = hinic3_configure_txqs(netdev, q_params->num_qps,
+				    q_params->sq_depth, q_params->txqs_res);
+	if (err) {
+		netdev_err(netdev, "Failed to configure txqs\n");
+		return err;
+	}
+
+	err = hinic3_configure_rxqs(netdev, q_params->num_qps,
+				    q_params->rq_depth, q_params->rxqs_res);
+	if (err) {
+		netdev_err(netdev, "Failed to configure rxqs\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int hinic3_configure(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	err = hinic3_set_port_mtu(netdev, (u16)netdev->mtu);
+	if (err) {
+		netdev_err(netdev, "Failed to set mtu\n");
+		return err;
+	}
+
+	/* Ensure DCB is disabled */
+	hinic3_sync_dcb_state(nic_dev->hwdev, 1, 0);
+
+	if (test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags)) {
+		err = hinic3_rss_init(netdev);
+		if (err) {
+			netdev_err(netdev, "Failed to init rss\n");
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+static void hinic3_remove_configure(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	if (test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags))
+		hinic3_rss_deinit(netdev);
+}
+
+static int hinic3_alloc_channel_resources(struct net_device *netdev,
+					  struct hinic3_dyna_qp_params *qp_params,
+					  struct hinic3_dyna_txrxq_params *trxq_params)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	qp_params->num_qps = trxq_params->num_qps;
+	qp_params->sq_depth = trxq_params->sq_depth;
+	qp_params->rq_depth = trxq_params->rq_depth;
+
+	err = hinic3_alloc_qps(nic_dev, qp_params);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc qps\n");
+		return err;
+	}
+
+	err = hinic3_alloc_txrxq_resources(netdev, trxq_params);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc txrxq resources\n");
+		hinic3_free_qps(nic_dev, qp_params);
+		return err;
+	}
+
+	return 0;
+}
+
+static void hinic3_free_channel_resources(struct net_device *netdev,
+					  struct hinic3_dyna_qp_params *qp_params,
+					  struct hinic3_dyna_txrxq_params *trxq_params)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	hinic3_free_txrxq_resources(netdev, trxq_params);
+	hinic3_free_qps(nic_dev, qp_params);
+}
+
+static int hinic3_open_channel(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	err = hinic3_init_qp_ctxts(nic_dev);
+	if (err) {
+		netdev_err(netdev, "Failed to init qps\n");
+		return err;
+	}
+
+	err = hinic3_configure_txrxqs(netdev, &nic_dev->q_params);
+	if (err) {
+		netdev_err(netdev, "Failed to configure txrxqs\n");
+		goto err_cfg_txrxqs;
+	}
+
+	err = hinic3_qps_irq_init(netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to init txrxq irq\n");
+		goto err_cfg_txrxqs;
+	}
+
+	err = hinic3_configure(netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to init txrxq irq\n");
+		goto err_configure;
+	}
+
+	return 0;
+
+err_configure:
+	hinic3_qps_irq_deinit(netdev);
+
+err_cfg_txrxqs:
+	hinic3_free_qp_ctxts(nic_dev);
+
+	return err;
+}
+
+static void hinic3_close_channel(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	hinic3_remove_configure(netdev);
+	hinic3_qps_irq_deinit(netdev);
+	hinic3_free_qp_ctxts(nic_dev);
+}
+
+static int hinic3_maybe_set_port_state(struct net_device *netdev, bool enable)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	down(&nic_dev->port_state_sem);
+	err = hinic3_set_port_enable(nic_dev->hwdev, enable);
+	up(&nic_dev->port_state_sem);
+
+	return err;
+}
+
+static void hinic3_print_link_message(struct net_device *netdev,
+				      bool link_status_up)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	if (nic_dev->link_status_up == link_status_up)
+		return;
+
+	nic_dev->link_status_up = link_status_up;
+
+	netdev_dbg(netdev, "Link is %s\n", (link_status_up ? "up" : "down"));
+}
+
+static int hinic3_vport_up(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	bool link_status_up;
+	u16 glb_func_id;
+	int err;
+
+	glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
+	err = hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, true);
+	if (err) {
+		netdev_err(netdev, "Failed to enable vport\n");
+		goto err_vport_enable;
+	}
+
+	err = hinic3_maybe_set_port_state(netdev, true);
+	if (err) {
+		netdev_err(netdev, "Failed to enable port\n");
+		goto err_port_enable;
+	}
+
+	netif_set_real_num_tx_queues(netdev, nic_dev->q_params.num_qps);
+	netif_set_real_num_rx_queues(netdev, nic_dev->q_params.num_qps);
+	netif_tx_wake_all_queues(netdev);
+
+	err = hinic3_get_link_status(nic_dev->hwdev, &link_status_up);
+	if (!err && link_status_up)
+		netif_carrier_on(netdev);
+
+	queue_delayed_work(nic_dev->workq, &nic_dev->moderation_task,
+			   HINIC3_MODERATONE_DELAY);
+
+	hinic3_print_link_message(netdev, link_status_up);
+
+	return 0;
+
+err_port_enable:
+	hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, false);
+
+err_vport_enable:
+	hinic3_flush_qps_res(nic_dev->hwdev);
+	/* wait to guarantee that no packets will be sent to host */
+	msleep(100);
+
+	return err;
+}
+
+static void hinic3_vport_down(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 glb_func_id;
+
+	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
+
+	cancel_delayed_work_sync(&nic_dev->moderation_task);
+
+	if (hinic3_get_chip_present_flag(nic_dev->hwdev)) {
+		hinic3_maybe_set_port_state(netdev, false);
+
+		glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
+		hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, false);
+
+		hinic3_flush_txqs(netdev);
+		/* wait to guarantee that no packets will be sent to host */
+		msleep(100);
+		hinic3_flush_qps_res(nic_dev->hwdev);
+	}
+}
+
+int hinic3_change_channel_settings(struct net_device *netdev,
+				   struct hinic3_dyna_txrxq_params *trxq_params,
+				   void (*reopen_handler)(struct net_device *netdev))
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_qp_params new_qp_params;
+	struct hinic3_dyna_qp_params cur_qp_params;
+	int err;
+
+	hinic3_config_num_qps(netdev, trxq_params);
+
+	err = hinic3_alloc_channel_resources(netdev, &new_qp_params,
+					     trxq_params);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc channel resources\n");
+		return err;
+	}
+
+	if (!test_and_set_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags)) {
+		hinic3_vport_down(netdev);
+		hinic3_close_channel(netdev);
+		hinic3_deinit_qps(nic_dev, &cur_qp_params);
+		hinic3_free_channel_resources(netdev, &cur_qp_params,
+					      &nic_dev->q_params);
+	}
+
+	if (nic_dev->num_qp_irq > trxq_params->num_qps)
+		hinic3_qp_irq_change(netdev, trxq_params->num_qps);
+	nic_dev->q_params = *trxq_params;
+
+	if (reopen_handler)
+		reopen_handler(netdev);
+
+	hinic3_init_qps(nic_dev, &new_qp_params);
+
+	err = hinic3_open_channel(netdev);
+	if (err)
+		goto err_open_channel;
+
+	err = hinic3_vport_up(netdev);
+	if (err)
+		goto err_vport_up;
+
+	clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags);
+
+	return 0;
+
+err_vport_up:
+	hinic3_close_channel(netdev);
+
+err_open_channel:
+	hinic3_deinit_qps(nic_dev, &new_qp_params);
+	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
+
+	return err;
+}
+
+static int hinic3_open(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_qp_params qp_params;
+	int err;
+
+	if (test_bit(HINIC3_INTF_UP, &nic_dev->flags)) {
+		netdev_dbg(netdev, "Netdev already open, do nothing\n");
+		return 0;
+	}
+
+	err = hinic3_init_nicio_res(nic_dev);
+	if (err) {
+		netdev_err(netdev, "Failed to init nicio resources\n");
+		return err;
+	}
+
+	err = hinic3_setup_num_qps(netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to setup num_qps\n");
+		goto err_setup_qps;
+	}
+
+	err = hinic3_alloc_channel_resources(netdev, &qp_params,
+					     &nic_dev->q_params);
+	if (err)
+		goto err_alloc_channel_res;
+
+	hinic3_init_qps(nic_dev, &qp_params);
+
+	err = hinic3_open_channel(netdev);
+	if (err)
+		goto err_open_channel;
+
+	err = hinic3_vport_up(netdev);
+	if (err)
+		goto err_vport_up;
+
+	set_bit(HINIC3_INTF_UP, &nic_dev->flags);
+
+	return 0;
+
+err_vport_up:
+	hinic3_close_channel(netdev);
+
+err_open_channel:
+	hinic3_deinit_qps(nic_dev, &qp_params);
+	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
+
+err_alloc_channel_res:
+	hinic3_destroy_num_qps(netdev);
+
+err_setup_qps:
+	hinic3_deinit_nicio_res(nic_dev);
+
+	return err;
+}
+
+static int hinic3_close(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_qp_params qp_params;
+
+	if (!test_and_clear_bit(HINIC3_INTF_UP, &nic_dev->flags)) {
+		netdev_dbg(netdev, "Netdev already close, do nothing\n");
+		return 0;
+	}
+
+	if (test_and_clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags))
+		goto out;
+
+	hinic3_vport_down(netdev);
+	hinic3_close_channel(netdev);
+	hinic3_deinit_qps(nic_dev, &qp_params);
+	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
+
+out:
+	hinic3_deinit_nicio_res(nic_dev);
+	hinic3_destroy_num_qps(netdev);
+
+	return 0;
+}
+
+#define SET_FEATURES_OP_STR(op)  ((op) ? "Enable" : "Disable")
+
+static int set_feature_rx_csum(struct net_device *netdev,
+			       netdev_features_t wanted_features,
+			       netdev_features_t features,
+			       netdev_features_t *failed_features)
+{
+	netdev_features_t changed = wanted_features ^ features;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+
+	if (changed & NETIF_F_RXCSUM)
+		dev_dbg(hwdev->dev, "%s rx csum success\n",
+			SET_FEATURES_OP_STR(wanted_features & NETIF_F_RXCSUM));
+
+	return 0;
+}
+
+static int set_feature_tso(struct net_device *netdev,
+			   netdev_features_t wanted_features,
+			   netdev_features_t features,
+			   netdev_features_t *failed_features)
+{
+	netdev_features_t changed = wanted_features ^ features;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+
+	if (changed & NETIF_F_TSO)
+		dev_dbg(hwdev->dev, "%s tso success\n",
+			SET_FEATURES_OP_STR(wanted_features & NETIF_F_TSO));
+
+	return 0;
+}
+
+static int set_feature_lro(struct net_device *netdev,
+			   netdev_features_t wanted_features,
+			   netdev_features_t features,
+			   netdev_features_t *failed_features)
+{
+	netdev_features_t changed = wanted_features ^ features;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	bool en = !!(wanted_features & NETIF_F_LRO);
+	int err;
+
+	if (!(changed & NETIF_F_LRO))
+		return 0;
+
+	err = hinic3_set_rx_lro_state(hwdev, en,
+				      HINIC3_LRO_DEFAULT_TIME_LIMIT,
+				      HINIC3_LRO_DEFAULT_COAL_PKT_SIZE);
+	if (err) {
+		dev_err(hwdev->dev, "%s lro failed\n", SET_FEATURES_OP_STR(en));
+		*failed_features |= NETIF_F_LRO;
+	}
+
+	return err;
+}
+
+static int set_feature_rx_cvlan(struct net_device *netdev,
+				netdev_features_t wanted_features,
+				netdev_features_t features,
+				netdev_features_t *failed_features)
+{
+	bool en = !!(wanted_features & NETIF_F_HW_VLAN_CTAG_RX);
+	netdev_features_t changed = wanted_features ^ features;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	int err;
+
+	if (!(changed & NETIF_F_HW_VLAN_CTAG_RX))
+		return 0;
+
+	err = hinic3_set_rx_vlan_offload(hwdev, en);
+	if (err) {
+		dev_err(hwdev->dev, "%s rxvlan failed\n", SET_FEATURES_OP_STR(en));
+		*failed_features |= NETIF_F_HW_VLAN_CTAG_RX;
+	}
+
+	return err;
+}
+
+static int set_feature_vlan_filter(struct net_device *netdev,
+				   netdev_features_t wanted_features,
+				   netdev_features_t features,
+				   netdev_features_t *failed_features)
+{
+	bool en = !!(wanted_features & NETIF_F_HW_VLAN_CTAG_FILTER);
+	netdev_features_t changed = wanted_features ^ features;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	int err;
+
+	if (!(changed & NETIF_F_HW_VLAN_CTAG_FILTER))
+		return 0;
+
+	err = hinic3_set_vlan_fliter(hwdev, en);
+	if (err) {
+		dev_err(hwdev->dev, "%s rx vlan filter failed\n", SET_FEATURES_OP_STR(en));
+		*failed_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	}
+
+	return err;
+}
+
+static int hinic3_set_features(struct net_device *netdev,
+			       netdev_features_t curr,
+			       netdev_features_t wanted)
+{
+	netdev_features_t failed = 0;
+	int err;
+
+	err = set_feature_rx_csum(netdev, wanted, curr, &failed);
+	err |= set_feature_tso(netdev, wanted, curr, &failed);
+	err |= set_feature_lro(netdev, wanted, curr, &failed);
+	err |= set_feature_rx_cvlan(netdev, wanted, curr, &failed);
+	err |= set_feature_vlan_filter(netdev, wanted, curr, &failed);
+	if (err) {
+		netdev->features = wanted ^ failed;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int hinic3_ndo_set_features(struct net_device *netdev,
+				   netdev_features_t features)
+{
+	return hinic3_set_features(netdev, netdev->features, features);
+}
+
+static netdev_features_t hinic3_fix_features(struct net_device *netdev,
+					     netdev_features_t features)
+{
+	netdev_features_t features_tmp = features;
+
+	/* If Rx checksum is disabled, then LRO should also be disabled */
+	if (!(features_tmp & NETIF_F_RXCSUM))
+		features_tmp &= ~NETIF_F_LRO;
+
+	return features_tmp;
+}
+
+int hinic3_set_hw_features(struct net_device *netdev)
+{
+	netdev_features_t wanted, curr;
+
+	wanted = netdev->features;
+	/* fake current features so all wanted are enabled */
+	curr = ~wanted;
+
+	return hinic3_set_features(netdev, curr, wanted);
+}
+
+static int hinic3_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	int err;
+
+	err = hinic3_set_port_mtu(netdev, new_mtu);
+	if (err) {
+		netdev_err(netdev, "Failed to change port mtu to %d\n", new_mtu);
+	} else {
+		netdev_dbg(netdev, "Change mtu from %u to %d\n", netdev->mtu, new_mtu);
+		WRITE_ONCE(netdev->mtu, new_mtu);
+	}
+
+	return err;
+}
+
+static int hinic3_set_mac_addr(struct net_device *netdev, void *addr)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct sockaddr *saddr = addr;
+	int err;
+
+	if (!is_valid_ether_addr(saddr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	if (ether_addr_equal(netdev->dev_addr, saddr->sa_data))
+		return 0;
+
+	err = hinic3_update_mac(nic_dev->hwdev, netdev->dev_addr,
+				saddr->sa_data, 0,
+				hinic3_global_func_id(nic_dev->hwdev));
+
+	if (err)
+		return err;
+
+	eth_hw_addr_set(netdev, saddr->sa_data);
+
+	return 0;
+}
+
+static int hinic3_vlan_rx_add_vid(struct net_device *netdev,
+				  __be16 proto, u16 vid)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	unsigned long *vlan_bitmap = nic_dev->vlan_bitmap;
+	u32 column, row;
+	u16 func_id;
+	int err;
+
+	column = VID_COL(nic_dev, vid);
+	row = VID_LINE(nic_dev, vid);
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+
+	err = hinic3_add_vlan(nic_dev->hwdev, vid, func_id);
+	if (err) {
+		netdev_err(netdev, "Failed to add vlan %u\n", vid);
+		goto end;
+	}
+
+	set_bit(column, &vlan_bitmap[row]);
+	netdev_dbg(netdev, "Add vlan %u\n", vid);
+
+end:
+	return err;
+}
+
+static int hinic3_vlan_rx_kill_vid(struct net_device *netdev,
+				   __be16 proto, u16 vid)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	unsigned long *vlan_bitmap = nic_dev->vlan_bitmap;
+	u32 column, row;
+	u16 func_id;
+	int err;
+
+	column  = VID_COL(nic_dev, vid);
+	row = VID_LINE(nic_dev, vid);
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+	err = hinic3_del_vlan(nic_dev->hwdev, vid, func_id);
+	if (err) {
+		netdev_err(netdev, "Failed to delete vlan\n");
+		goto end;
+	}
+
+	clear_bit(column, &vlan_bitmap[row]);
+	netdev_dbg(netdev, "Remove vlan %u\n", vid);
+
+end:
+	return err;
+}
+
+static void hinic3_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_io_queue *sq;
+	bool hw_err = false;
+	u16 sw_pi, hw_ci;
+	u8 q_id;
+
+	HINIC3_NIC_STATS_INC(nic_dev, netdev_tx_timeout);
+	netdev_err(netdev, "Tx timeout\n");
+
+	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
+		if (!netif_xmit_stopped(netdev_get_tx_queue(netdev, q_id)))
+			continue;
+
+		sq = nic_dev->txqs[q_id].sq;
+		sw_pi = hinic3_get_sq_local_pi(sq);
+		hw_ci = hinic3_get_sq_hw_ci(sq);
+		netdev_dbg(netdev,
+			   "txq%u: sw_pi: %u, hw_ci: %u, sw_ci: %u, napi->state: 0x%lx.\n",
+			   q_id, sw_pi, hw_ci, hinic3_get_sq_local_ci(sq),
+			   nic_dev->q_params.irq_cfg[q_id].napi.state);
+
+		if (sw_pi != hw_ci)
+			hw_err = true;
+	}
+
+	if (hw_err)
+		set_bit(EVENT_WORK_TX_TIMEOUT, &nic_dev->event_flag);
+}
+
+static void hinic3_get_stats64(struct net_device *netdev,
+			       struct rtnl_link_stats64 *stats)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u64 bytes, packets, dropped, errors;
+	struct hinic3_txq_stats *txq_stats;
+	struct hinic3_rxq_stats *rxq_stats;
+	struct hinic3_txq *txq;
+	struct hinic3_rxq *rxq;
+	unsigned int start;
+	int i;
+
+	bytes = 0;
+	packets = 0;
+	dropped = 0;
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		if (!nic_dev->txqs)
+			break;
+
+		txq = &nic_dev->txqs[i];
+		txq_stats = &txq->txq_stats;
+		do {
+			start = u64_stats_fetch_begin(&txq_stats->syncp);
+			bytes += txq_stats->bytes;
+			packets += txq_stats->packets;
+			dropped += txq_stats->dropped;
+		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
+	}
+	stats->tx_packets = packets;
+	stats->tx_bytes   = bytes;
+	stats->tx_dropped = dropped;
+
+	bytes = 0;
+	packets = 0;
+	errors = 0;
+	dropped = 0;
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		if (!nic_dev->rxqs)
+			break;
+
+		rxq = &nic_dev->rxqs[i];
+		rxq_stats = &rxq->rxq_stats;
+		do {
+			start = u64_stats_fetch_begin(&rxq_stats->syncp);
+			bytes += rxq_stats->bytes;
+			packets += rxq_stats->packets;
+			errors += rxq_stats->csum_errors +
+				rxq_stats->other_errors;
+			dropped += rxq_stats->dropped;
+		} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
+	}
+	stats->rx_packets = packets;
+	stats->rx_bytes   = bytes;
+	stats->rx_errors  = errors;
+	stats->rx_dropped = dropped;
+}
+
+static void hinic3_nic_set_rx_mode(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	if (netdev_uc_count(netdev) != nic_dev->netdev_uc_cnt ||
+	    netdev_mc_count(netdev) != nic_dev->netdev_mc_cnt) {
+		set_bit(HINIC3_UPDATE_MAC_FILTER, &nic_dev->flags);
+		nic_dev->netdev_uc_cnt = netdev_uc_count(netdev);
+		nic_dev->netdev_mc_cnt = netdev_mc_count(netdev);
+	}
+
+	queue_work(nic_dev->workq, &nic_dev->rx_mode_work);
+}
+
+static const struct net_device_ops hinic3_netdev_ops = {
+	.ndo_open             = hinic3_open,
+	.ndo_stop             = hinic3_close,
+	.ndo_set_features     = hinic3_ndo_set_features,
+	.ndo_fix_features     = hinic3_fix_features,
+	.ndo_change_mtu       = hinic3_change_mtu,
+	.ndo_set_mac_address  = hinic3_set_mac_addr,
+	.ndo_validate_addr    = eth_validate_addr,
+	.ndo_vlan_rx_add_vid  = hinic3_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = hinic3_vlan_rx_kill_vid,
+	.ndo_tx_timeout       = hinic3_tx_timeout,
+	.ndo_get_stats64      = hinic3_get_stats64,
+	.ndo_set_rx_mode      = hinic3_nic_set_rx_mode,
+	.ndo_start_xmit       = hinic3_xmit_frame,
+};
+
+void hinic3_set_netdev_ops(struct net_device *netdev)
+{
+	netdev->netdev_ops = &hinic3_netdev_ops;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
new file mode 100644
index 000000000000..7b1230212289
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -0,0 +1,808 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+
+#include "hinic3_hw_comm.h"
+#include "hinic3_hw_cfg.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_mgmt_interface.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_nic_cfg.h"
+
+#define HINIC3_CMD_OP_ADD  1
+#define HINIC3_CMD_OP_DEL  0
+
+int l2nic_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd,
+			   const void *buf_in, u32 in_size,
+			   void *buf_out, u32 *out_size)
+{
+	return hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, cmd, buf_in,
+				       in_size, buf_out, out_size, 0);
+}
+
+static int nic_feature_nego(struct hinic3_hwdev *hwdev, u8 opcode, u64 *s_feature, u16 size)
+{
+	struct hinic3_cmd_feature_nego feature_nego;
+	u32 out_size = sizeof(feature_nego);
+	int err;
+
+	if (size > NIC_MAX_FEATURE_QWORD)
+		return -EINVAL;
+
+	memset(&feature_nego, 0, sizeof(feature_nego));
+	feature_nego.func_id = hinic3_global_func_id(hwdev);
+	feature_nego.opcode = opcode;
+	if (opcode == HINIC3_CMD_OP_SET)
+		memcpy(feature_nego.s_feature, s_feature, size * sizeof(u64));
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_FEATURE_NEGO,
+				     &feature_nego, sizeof(feature_nego),
+				     &feature_nego, &out_size);
+	if (err || !out_size || feature_nego.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to negotiate nic feature, err:%d, status: 0x%x, out_size: 0x%x\n",
+			err, feature_nego.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	if (opcode == HINIC3_CMD_OP_GET)
+		memcpy(s_feature, feature_nego.s_feature, size * sizeof(u64));
+
+	return 0;
+}
+
+int hinic3_get_nic_feature_from_hw(struct hinic3_nic_dev *nic_dev)
+{
+	return nic_feature_nego(nic_dev->hwdev, HINIC3_CMD_OP_GET,
+				&nic_dev->nic_io->feature_cap, 1);
+}
+
+int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev)
+{
+	return nic_feature_nego(nic_dev->hwdev, HINIC3_CMD_OP_SET,
+				&nic_dev->nic_io->feature_cap, 1);
+}
+
+bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
+			 enum nic_feature_cap feature_bits)
+{
+	return (nic_dev->nic_io->feature_cap & feature_bits) == feature_bits;
+}
+
+void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature_cap)
+{
+	nic_dev->nic_io->feature_cap = feature_cap;
+}
+
+static int hinic3_set_rx_lro(struct hinic3_hwdev *hwdev, u8 ipv4_en, u8 ipv6_en,
+			     u8 lro_max_pkt_len)
+{
+	struct hinic3_cmd_lro_config lro_cfg;
+	u32 out_size = sizeof(lro_cfg);
+	int err;
+
+	memset(&lro_cfg, 0, sizeof(lro_cfg));
+	lro_cfg.func_id = hinic3_global_func_id(hwdev);
+	lro_cfg.opcode = HINIC3_CMD_OP_SET;
+	lro_cfg.lro_ipv4_en = ipv4_en;
+	lro_cfg.lro_ipv6_en = ipv6_en;
+	lro_cfg.lro_max_pkt_len = lro_max_pkt_len;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_CFG_RX_LRO,
+				     &lro_cfg, sizeof(lro_cfg),
+				     &lro_cfg, &out_size);
+	if (err || !out_size || lro_cfg.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set lro offload, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, lro_cfg.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_rx_lro_timer(struct hinic3_hwdev *hwdev, u32 timer_value)
+{
+	struct hinic3_cmd_lro_timer lro_timer;
+	u32 out_size = sizeof(lro_timer);
+	int err;
+
+	memset(&lro_timer, 0, sizeof(lro_timer));
+	lro_timer.opcode = HINIC3_CMD_OP_SET;
+	lro_timer.timer = timer_value;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_CFG_LRO_TIMER,
+				     &lro_timer, sizeof(lro_timer),
+				     &lro_timer, &out_size);
+	if (err || !out_size || lro_timer.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set lro timer, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, lro_timer.msg_head.status, out_size);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, u8 lro_en, u32 lro_timer,
+			    u8 lro_max_pkt_len)
+{
+	u8 ipv4_en, ipv6_en;
+	int err;
+
+	ipv4_en = lro_en ? 1 : 0;
+	ipv6_en = lro_en ? 1 : 0;
+
+	dev_dbg(hwdev->dev, "Set LRO max coalesce packet size to %uK\n", lro_max_pkt_len);
+
+	err = hinic3_set_rx_lro(hwdev, ipv4_en, ipv6_en, lro_max_pkt_len);
+	if (err)
+		return err;
+
+	/* we don't set LRO timer for VF */
+	if (HINIC3_IS_VF(hwdev))
+		return 0;
+
+	dev_dbg(hwdev->dev, "Set LRO timer to %u\n", lro_timer);
+
+	return hinic3_set_rx_lro_timer(hwdev, lro_timer);
+}
+
+int hinic3_set_rx_vlan_offload(struct hinic3_hwdev *hwdev, u8 en)
+{
+	struct hinic3_cmd_vlan_offload vlan_cfg;
+	u32 out_size = sizeof(vlan_cfg);
+	int err;
+
+	memset(&vlan_cfg, 0, sizeof(vlan_cfg));
+	vlan_cfg.func_id = hinic3_global_func_id(hwdev);
+	vlan_cfg.vlan_offload = en;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_RX_VLAN_OFFLOAD,
+				     &vlan_cfg, sizeof(vlan_cfg),
+				     &vlan_cfg, &out_size);
+	if (err || !out_size || vlan_cfg.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set rx vlan offload, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, vlan_cfg.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int hinic3_set_vlan_fliter(struct hinic3_hwdev *hwdev, u32 vlan_filter_ctrl)
+{
+	struct hinic3_cmd_set_vlan_filter vlan_filter;
+	u32 out_size = sizeof(vlan_filter);
+	int err;
+
+	memset(&vlan_filter, 0, sizeof(vlan_filter));
+	vlan_filter.func_id = hinic3_global_func_id(hwdev);
+	vlan_filter.vlan_filter_ctrl = vlan_filter_ctrl;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_VLAN_FILTER_EN,
+				     &vlan_filter, sizeof(vlan_filter),
+				     &vlan_filter, &out_size);
+	if (err || !out_size || vlan_filter.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set vlan filter, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, vlan_filter.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_function_table(struct hinic3_hwdev *hwdev, u32 cfg_bitmap,
+				     const struct hinic3_func_tbl_cfg *cfg)
+{
+	struct hinic3_cmd_set_func_tbl cmd_func_tbl;
+	u32 out_size = sizeof(cmd_func_tbl);
+	int err;
+
+	memset(&cmd_func_tbl, 0, sizeof(cmd_func_tbl));
+	cmd_func_tbl.func_id = hinic3_global_func_id(hwdev);
+	cmd_func_tbl.cfg_bitmap = cfg_bitmap;
+	cmd_func_tbl.tbl_cfg = *cfg;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev,
+				     HINIC3_NIC_CMD_SET_FUNC_TBL,
+				     &cmd_func_tbl, sizeof(cmd_func_tbl),
+				     &cmd_func_tbl, &out_size);
+	if (err || cmd_func_tbl.msg_head.status || !out_size) {
+		dev_err(hwdev->dev,
+			"Failed to set func table, bitmap: 0x%x, err: %d, status: 0x%x, out size: 0x%x\n",
+			cfg_bitmap, err, cmd_func_tbl.msg_head.status,
+			out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_init_function_table(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_func_tbl_cfg func_tbl_cfg;
+	u32 cfg_bitmap;
+
+	func_tbl_cfg.mtu = 0x3FFF; /* default, max mtu */
+	func_tbl_cfg.rx_wqe_buf_size = nic_io->rx_buff_len;
+
+	cfg_bitmap = BIT(FUNC_CFG_INIT) | BIT(FUNC_CFG_MTU) | BIT(FUNC_CFG_RX_BUF_SIZE);
+	return hinic3_set_function_table(nic_dev->hwdev, cfg_bitmap, &func_tbl_cfg);
+}
+
+int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_func_tbl_cfg func_tbl_cfg = {};
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+
+	if (new_mtu < HINIC3_MIN_MTU_SIZE) {
+		dev_err(hwdev->dev,
+			"Invalid mtu size: %ubytes, mtu size < %ubytes\n",
+			new_mtu, HINIC3_MIN_MTU_SIZE);
+		return -EINVAL;
+	}
+
+	if (new_mtu > HINIC3_MAX_JUMBO_FRAME_SIZE) {
+		dev_err(hwdev->dev, "Invalid mtu size: %ubytes, mtu size > %ubytes\n",
+			new_mtu, HINIC3_MAX_JUMBO_FRAME_SIZE);
+		return -EINVAL;
+	}
+
+	func_tbl_cfg.mtu = new_mtu;
+	return hinic3_set_function_table(hwdev, BIT(FUNC_CFG_MTU),
+					 &func_tbl_cfg);
+}
+
+#define PF_SET_VF_MAC(hwdev, status) \
+	(HINIC3_IS_VF(hwdev) && (status) == HINIC3_PF_SET_VF_ALREADY)
+
+static int hinic3_check_mac_info(struct hinic3_hwdev *hwdev, u8 status, u16 vlan_id)
+{
+	if ((status && status != HINIC3_MGMT_STATUS_EXIST) ||
+	    ((vlan_id & CHECK_IPSU_15BIT) &&
+	     status == HINIC3_MGMT_STATUS_EXIST)) {
+		if (PF_SET_VF_MAC(hwdev, status))
+			return 0;
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int hinic3_get_default_mac(struct hinic3_hwdev *hwdev, u8 *mac_addr)
+{
+	struct hinic3_port_mac_set mac_info;
+	u32 out_size = sizeof(mac_info);
+	int err;
+
+	memset(&mac_info, 0, sizeof(mac_info));
+	mac_info.func_id = hinic3_global_func_id(hwdev);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_GET_MAC,
+				     &mac_info, sizeof(mac_info),
+				     &mac_info, &out_size);
+	if (err || !out_size || mac_info.msg_head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get mac, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, mac_info.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	ether_addr_copy(mac_addr, mac_info.mac);
+
+	return 0;
+}
+
+#define HINIC_VLAN_ID_MASK  0x7FFF
+
+int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_id)
+{
+	struct hinic3_port_mac_set mac_info;
+	u32 out_size = sizeof(mac_info);
+	int err;
+
+	if ((vlan_id & HINIC_VLAN_ID_MASK) >= VLAN_N_VID) {
+		dev_err(hwdev->dev, "Invalid VLAN number: %d\n",
+			(vlan_id & HINIC_VLAN_ID_MASK));
+		return -EINVAL;
+	}
+
+	memset(&mac_info, 0, sizeof(mac_info));
+	mac_info.func_id = func_id;
+	mac_info.vlan_id = vlan_id;
+	ether_addr_copy(mac_info.mac, mac_addr);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_MAC,
+				     &mac_info, sizeof(mac_info),
+				     &mac_info, &out_size);
+	if (err || !out_size ||
+	    hinic3_check_mac_info(hwdev, mac_info.msg_head.status,
+				  mac_info.vlan_id)) {
+		dev_err(hwdev->dev,
+			"Failed to update MAC, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, mac_info.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	if (PF_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {
+		dev_warn(hwdev->dev, "PF has already set VF mac, Ignore set operation\n");
+		return HINIC3_PF_SET_VF_ALREADY;
+	}
+
+	if (mac_info.msg_head.status == HINIC3_MGMT_STATUS_EXIST) {
+		dev_warn(hwdev->dev, "MAC is repeated. Ignore update operation\n");
+		return 0;
+	}
+
+	return 0;
+}
+
+int hinic3_del_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_id)
+{
+	struct hinic3_port_mac_set mac_info;
+	u32 out_size = sizeof(mac_info);
+	int err;
+
+	if ((vlan_id & HINIC_VLAN_ID_MASK) >= VLAN_N_VID) {
+		dev_err(hwdev->dev, "Invalid VLAN number: %d\n",
+			(vlan_id & HINIC_VLAN_ID_MASK));
+		return -EINVAL;
+	}
+
+	memset(&mac_info, 0, sizeof(mac_info));
+	mac_info.func_id = func_id;
+	mac_info.vlan_id = vlan_id;
+	ether_addr_copy(mac_info.mac, mac_addr);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_DEL_MAC,
+				     &mac_info, sizeof(mac_info), &mac_info,
+				     &out_size);
+	if (err || !out_size ||
+	    (mac_info.msg_head.status && !PF_SET_VF_MAC(hwdev, mac_info.msg_head.status))) {
+		dev_err(hwdev->dev,
+			"Failed to delete MAC, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, mac_info.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	if (PF_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {
+		dev_warn(hwdev->dev, "PF has already set VF mac, Ignore delete operation.\n");
+		return HINIC3_PF_SET_VF_ALREADY;
+	}
+
+	return 0;
+}
+
+int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac, u8 *new_mac,
+		      u16 vlan_id, u16 func_id)
+{
+	struct hinic3_port_mac_update mac_info;
+	u32 out_size = sizeof(mac_info);
+	int err;
+
+	if ((vlan_id & HINIC_VLAN_ID_MASK) >= VLAN_N_VID) {
+		dev_err(hwdev->dev, "Invalid VLAN number: %d\n",
+			(vlan_id & HINIC_VLAN_ID_MASK));
+		return -EINVAL;
+	}
+
+	memset(&mac_info, 0, sizeof(mac_info));
+	mac_info.func_id = func_id;
+	mac_info.vlan_id = vlan_id;
+	ether_addr_copy(mac_info.old_mac, old_mac);
+	ether_addr_copy(mac_info.new_mac, new_mac);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_UPDATE_MAC,
+				     &mac_info, sizeof(mac_info),
+				     &mac_info, &out_size);
+	if (err || !out_size ||
+	    hinic3_check_mac_info(hwdev, mac_info.msg_head.status,
+				  mac_info.vlan_id)) {
+		dev_err(hwdev->dev,
+			"Failed to update MAC, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, mac_info.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	if (PF_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {
+		dev_warn(hwdev->dev, "PF has already set VF MAC. Ignore update operation\n");
+		return HINIC3_PF_SET_VF_ALREADY;
+	}
+
+	if (mac_info.msg_head.status == HINIC3_MGMT_STATUS_EXIST) {
+		dev_warn(hwdev->dev, "MAC is repeated. Ignore update operation\n");
+		return 0;
+	}
+
+	return 0;
+}
+
+int hinic3_set_ci_table(struct hinic3_hwdev *hwdev, struct hinic3_sq_attr *attr)
+{
+	struct hinic3_cmd_cons_idx_attr cons_idx_attr;
+	u32 out_size = sizeof(cons_idx_attr);
+	int err;
+
+	memset(&cons_idx_attr, 0, sizeof(cons_idx_attr));
+	cons_idx_attr.func_idx = hinic3_global_func_id(hwdev);
+	cons_idx_attr.dma_attr_off  = attr->dma_attr_off;
+	cons_idx_attr.pending_limit = attr->pending_limit;
+	cons_idx_attr.coalescing_time  = attr->coalescing_time;
+
+	if (attr->intr_en) {
+		cons_idx_attr.intr_en = attr->intr_en;
+		cons_idx_attr.intr_idx = attr->intr_idx;
+	}
+
+	cons_idx_attr.l2nic_sqn = attr->l2nic_sqn;
+	cons_idx_attr.ci_addr = attr->ci_dma_base;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SQ_CI_ATTR_SET,
+				     &cons_idx_attr, sizeof(cons_idx_attr),
+				     &cons_idx_attr, &out_size);
+	if (err || !out_size || cons_idx_attr.msg_head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set ci attribute table, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, cons_idx_attr.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_flush_qps_res(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmd_clear_qp_resource sq_res;
+	u32 out_size = sizeof(sq_res);
+	int err;
+
+	memset(&sq_res, 0, sizeof(sq_res));
+	sq_res.func_id = hinic3_global_func_id(hwdev);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_CLEAR_QP_RESOURCE,
+				     &sq_res, sizeof(sq_res), &sq_res,
+				     &out_size);
+	if (err || !out_size || sq_res.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to clear sq resources, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, sq_res.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_force_pkt_drop pkt_drop;
+	u32 out_size = sizeof(pkt_drop);
+	int err;
+
+	memset(&pkt_drop, 0, sizeof(pkt_drop));
+	pkt_drop.port = hinic3_physical_port_id(hwdev);
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_FORCE_PKT_DROP,
+				     &pkt_drop, sizeof(pkt_drop),
+				     &pkt_drop, &out_size);
+	if ((pkt_drop.msg_head.status != MGMT_CMD_UNSUPPORTED &&
+	     pkt_drop.msg_head.status) || err || !out_size) {
+		dev_err(hwdev->dev,
+			"Failed to set force tx packets drop, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, pkt_drop.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	return pkt_drop.msg_head.status;
+}
+
+int hinic3_set_rx_mode(struct hinic3_hwdev *hwdev, u32 enable)
+{
+	struct hinic3_rx_mode_config rx_mode_cfg;
+	u32 out_size = sizeof(rx_mode_cfg);
+	int err;
+
+	memset(&rx_mode_cfg, 0, sizeof(rx_mode_cfg));
+	rx_mode_cfg.func_id = hinic3_global_func_id(hwdev);
+	rx_mode_cfg.rx_mode = enable;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_RX_MODE,
+				     &rx_mode_cfg, sizeof(rx_mode_cfg),
+				     &rx_mode_cfg, &out_size);
+	if (err || !out_size || rx_mode_cfg.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set rx mode, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, rx_mode_cfg.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_config_vlan(struct hinic3_hwdev *hwdev, u8 opcode,
+			      u16 vlan_id, u16 func_id)
+{
+	struct hinic3_cmd_vlan_config vlan_info;
+	u32 out_size = sizeof(vlan_info);
+	int err;
+
+	memset(&vlan_info, 0, sizeof(vlan_info));
+	vlan_info.opcode = opcode;
+	vlan_info.func_id = func_id;
+	vlan_info.vlan_id = vlan_id;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev,
+				     HINIC3_NIC_CMD_CFG_FUNC_VLAN,
+				     &vlan_info, sizeof(vlan_info),
+				     &vlan_info, &out_size);
+	if (err || !out_size || vlan_info.msg_head.status) {
+		dev_err(hwdev->dev,
+			"Failed to %s vlan, err: %d, status: 0x%x, out size: 0x%x\n",
+			opcode == HINIC3_CMD_OP_ADD ? "add" : "delete",
+			err, vlan_info.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int hinic3_add_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id)
+{
+	return hinic3_config_vlan(hwdev, HINIC3_CMD_OP_ADD, vlan_id, func_id);
+}
+
+int hinic3_del_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id)
+{
+	return hinic3_config_vlan(hwdev, HINIC3_CMD_OP_DEL, vlan_id, func_id);
+}
+
+int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state)
+{
+	struct hinic3_cmd_set_dcb_state dcb_state;
+	u32 out_size = sizeof(dcb_state);
+	int err;
+
+	memset(&dcb_state, 0, sizeof(dcb_state));
+	dcb_state.op_code = op_code;
+	dcb_state.state = state;
+	dcb_state.func_id = hinic3_global_func_id(hwdev);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_QOS_DCB_STATE,
+				     &dcb_state, sizeof(dcb_state), &dcb_state, &out_size);
+	if (err || dcb_state.head.status || !out_size) {
+		dev_err(hwdev->dev,
+			"Failed to set dcb state, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, dcb_state.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_set_port_enable(struct hinic3_hwdev *hwdev, bool enable)
+{
+	struct mag_cmd_set_port_enable en_state;
+	u32 out_size = sizeof(en_state);
+	int err;
+
+	if (HINIC3_IS_VF(hwdev))
+		return 0;
+
+	memset(&en_state, 0, sizeof(en_state));
+	en_state.function_id = hinic3_global_func_id(hwdev);
+	en_state.state = enable ? MAG_CMD_TX_ENABLE | MAG_CMD_RX_ENABLE :
+				MAG_CMD_PORT_DISABLE;
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK, MAG_CMD_SET_PORT_ENABLE, &en_state,
+				      sizeof(en_state), &en_state, &out_size, 0);
+	if (err || !out_size || en_state.head.status) {
+		dev_err(hwdev->dev, "Failed to set port state, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, en_state.head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up)
+{
+	struct mag_cmd_get_link_status get_link;
+	u32 out_size = sizeof(get_link);
+	int err;
+
+	memset(&get_link, 0, sizeof(get_link));
+	get_link.port_id = hinic3_physical_port_id(hwdev);
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK, MAG_CMD_GET_LINK_STATUS, &get_link,
+				      sizeof(get_link), &get_link, &out_size, 0);
+	if (err || !out_size || get_link.head.status) {
+		dev_err(hwdev->dev, "Failed to get link state, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, get_link.head.status, out_size);
+		return -EIO;
+	}
+
+	*link_status_up = !!get_link.status;
+
+	return 0;
+}
+
+int hinic3_get_phy_port_stats(struct hinic3_hwdev *hwdev, struct mag_cmd_port_stats *stats)
+{
+	struct mag_cmd_port_stats_info stats_info;
+	struct mag_cmd_get_port_stat *port_stats;
+	u32 out_size = sizeof(*port_stats);
+	int err;
+
+	port_stats = kzalloc(sizeof(*port_stats), GFP_KERNEL);
+	if (!port_stats)
+		return -ENOMEM;
+
+	memset(&stats_info, 0, sizeof(stats_info));
+	stats_info.port_id = hinic3_physical_port_id(hwdev);
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK, MAG_CMD_GET_PORT_STAT,
+				      &stats_info, sizeof(stats_info),
+				      port_stats, &out_size, 0);
+	if (err || !out_size || port_stats->head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get port statistics, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, port_stats->head.status, out_size);
+		err = -EIO;
+		goto out;
+	}
+
+	memcpy(stats, &port_stats->counter, sizeof(*stats));
+
+out:
+	kfree(port_stats);
+
+	return err;
+}
+
+int hinic3_get_port_info(struct hinic3_hwdev *hwdev, struct nic_port_info *port_info)
+{
+	struct mag_cmd_get_port_info port_msg;
+	u32 out_size = sizeof(port_msg);
+	int err;
+
+	memset(&port_msg, 0, sizeof(port_msg));
+	port_msg.port_id = hinic3_physical_port_id(hwdev);
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK, MAG_CMD_GET_PORT_INFO, &port_msg,
+				      sizeof(port_msg), &port_msg, &out_size, 0);
+	if (err || !out_size || port_msg.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get port info, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, port_msg.head.status, out_size);
+		return -EIO;
+	}
+
+	port_info->autoneg_cap = port_msg.an_support;
+	port_info->autoneg_state = port_msg.an_en;
+	port_info->duplex = port_msg.duplex;
+	port_info->port_type = port_msg.wire_type;
+	port_info->speed = port_msg.speed;
+	port_info->fec = port_msg.fec;
+	port_info->supported_mode = port_msg.supported_mode;
+	port_info->advertised_mode = port_msg.advertised_mode;
+
+	return 0;
+}
+
+int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id, bool enable)
+{
+	struct hinic3_vport_state en_state;
+	u32 out_size = sizeof(en_state);
+	int err;
+
+	memset(&en_state, 0, sizeof(en_state));
+	en_state.func_id = func_id;
+	en_state.state = enable ? 1 : 0;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_VPORT_ENABLE,
+				     &en_state, sizeof(en_state),
+				     &en_state, &out_size);
+	if (err || !out_size || en_state.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set vport state, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, en_state.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#define UNSUPPORT_SET_PAUSE     0x10
+static int hinic3_cfg_hw_pause(struct hinic3_hwdev *hwdev, u8 opcode,
+			       struct nic_pause_config *nic_pause)
+{
+	struct hinic3_cmd_pause_config pause_info;
+	u32 out_size = sizeof(pause_info);
+	int err;
+
+	memset(&pause_info, 0, sizeof(pause_info));
+
+	pause_info.port_id = hinic3_physical_port_id(hwdev);
+	pause_info.opcode = opcode;
+	if (opcode == HINIC3_CMD_OP_SET) {
+		pause_info.auto_neg = nic_pause->auto_neg;
+		pause_info.rx_pause = nic_pause->rx_pause;
+		pause_info.tx_pause = nic_pause->tx_pause;
+	}
+
+	err = l2nic_msg_to_mgmt_sync(hwdev,
+				     HINIC3_NIC_CMD_CFG_PAUSE_INFO,
+				     &pause_info, sizeof(pause_info),
+				     &pause_info, &out_size);
+	if (err || !out_size || pause_info.msg_head.status) {
+		if (pause_info.msg_head.status == UNSUPPORT_SET_PAUSE) {
+			err = -EOPNOTSUPP;
+			dev_err(hwdev->dev, "Can not set pause when pfc is enabled\n");
+		} else {
+			err = -EFAULT;
+			dev_err(hwdev->dev, "Failed to %s pause info, err: %d, status: 0x%x, out size: 0x%x\n",
+				opcode == HINIC3_CMD_OP_SET ? "set" : "get",
+				err, pause_info.msg_head.status, out_size);
+		}
+		return err;
+	}
+
+	if (opcode == HINIC3_CMD_OP_GET) {
+		nic_pause->auto_neg = pause_info.auto_neg;
+		nic_pause->rx_pause = pause_info.rx_pause;
+		nic_pause->tx_pause = pause_info.tx_pause;
+	}
+
+	return 0;
+}
+
+int hinic3_get_pause_info(struct hinic3_nic_dev *nic_dev,
+			  struct nic_pause_config *nic_pause)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_nic_cfg *nic_cfg;
+	int err;
+
+	err = hinic3_cfg_hw_pause(nic_dev->hwdev, HINIC3_CMD_OP_GET, nic_pause);
+	if (err)
+		return err;
+
+	nic_cfg = &nic_io->nic_cfg;
+	if (nic_cfg->pause_set || !nic_pause->auto_neg) {
+		nic_pause->rx_pause = nic_cfg->nic_pause.rx_pause;
+		nic_pause->tx_pause = nic_cfg->nic_pause.tx_pause;
+	}
+
+	return 0;
+}
+
+int hinic3_get_vport_stats(struct hinic3_hwdev *hwdev, u16 func_id,
+			   struct hinic3_vport_stats *stats)
+{
+	struct hinic3_cmd_vport_stats vport_stats;
+	struct hinic3_port_stats_info stats_info;
+	u32 out_size = sizeof(vport_stats);
+	int err;
+
+	memset(&stats_info, 0, sizeof(stats_info));
+	memset(&vport_stats, 0, sizeof(vport_stats));
+	stats_info.func_id = func_id;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_GET_VPORT_STAT,
+				     &stats_info, sizeof(stats_info),
+				     &vport_stats, &out_size);
+	if (err || !out_size || vport_stats.msg_head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get function statistics, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, vport_stats.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	memcpy(stats, &vport_stats.stats, sizeof(*stats));
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
new file mode 100644
index 000000000000..4aaa618c0c02
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -0,0 +1,471 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_NIC_CFG_H
+#define HINIC3_NIC_CFG_H
+
+#include <linux/types.h>
+#include <linux/mutex.h>
+
+#include "hinic3_hwdev.h"
+#include "hinic3_mgmt_interface.h"
+
+struct hinic3_nic_dev;
+
+#define HINIC3_MIN_MTU_SIZE             256
+#define HINIC3_MAX_JUMBO_FRAME_SIZE     9600
+
+#define HINIC3_PF_SET_VF_ALREADY        0x4
+#define HINIC3_MGMT_STATUS_EXIST        0x6
+#define CHECK_IPSU_15BIT                0x8000
+
+enum hinic3_nic_event_type {
+	EVENT_NIC_LINK_DOWN,
+	EVENT_NIC_LINK_UP,
+	EVENT_NIC_PORT_MODULE_EVENT,
+	EVENT_NIC_DCB_STATE_CHANGE,
+};
+
+struct hinic3_sq_attr {
+	u8  dma_attr_off;
+	u8  pending_limit;
+	u8  coalescing_time;
+	u8  intr_en;
+	u16 intr_idx;
+	u32 l2nic_sqn;
+	u64 ci_dma_base;
+};
+
+enum mag_cmd {
+	SERDES_CMD_PROCESS             = 0,
+
+	MAG_CMD_SET_PORT_CFG           = 1,
+	MAG_CMD_SET_PORT_ADAPT         = 2,
+	MAG_CMD_CFG_LOOPBACK_MODE      = 3,
+
+	MAG_CMD_GET_PORT_ENABLE        = 5,
+	MAG_CMD_SET_PORT_ENABLE        = 6,
+	MAG_CMD_GET_LINK_STATUS        = 7,
+	MAG_CMD_SET_LINK_FOLLOW        = 8,
+	MAG_CMD_SET_PMA_ENABLE         = 9,
+	MAG_CMD_CFG_FEC_MODE           = 10,
+
+	/* reserved for future use */
+	MAG_CMD_CFG_AN_TYPE            = 12,
+	MAG_CMD_CFG_LINK_TIME          = 13,
+
+	MAG_CMD_SET_PANGEA_ADAPT       = 15,
+
+	/* bios link 30-49 */
+	MAG_CMD_CFG_BIOS_LINK_CFG      = 31,
+	MAG_CMD_RESTORE_LINK_CFG       = 32,
+	MAG_CMD_ACTIVATE_BIOS_LINK_CFG = 33,
+
+	/* LED */
+	MAG_CMD_SET_LED_CFG            = 50,
+
+	/* PHY, reserved for future use */
+	MAG_CMD_GET_PHY_INIT_STATUS    = 55,
+
+	MAG_CMD_GET_XSFP_INFO          = 60,
+	MAG_CMD_SET_XSFP_ENABLE        = 61,
+	MAG_CMD_GET_XSFP_PRESENT       = 62,
+	MAG_CMD_SET_XSFP_RW            = 63,
+	MAG_CMD_CFG_XSFP_TEMPERATURE   = 64,
+
+	MAG_CMD_WIRE_EVENT             = 100,
+	MAG_CMD_LINK_ERR_EVENT         = 101,
+
+	MAG_CMD_EVENT_PORT_INFO        = 150,
+	MAG_CMD_GET_PORT_STAT          = 151,
+	MAG_CMD_CLR_PORT_STAT          = 152,
+	MAG_CMD_GET_PORT_INFO          = 153,
+	MAG_CMD_GET_PCS_ERR_CNT        = 154,
+	MAG_CMD_GET_MAG_CNT            = 155,
+	MAG_CMD_DUMP_ANTRAIN_INFO      = 156,
+
+	MAG_CMD_MAX                    = 0xFF
+};
+
+enum mag_cmd_port_speed {
+	PORT_SPEED_NOT_SET = 0,
+	PORT_SPEED_10MB    = 1,
+	PORT_SPEED_100MB   = 2,
+	PORT_SPEED_1GB     = 3,
+	PORT_SPEED_10GB    = 4,
+	PORT_SPEED_25GB    = 5,
+	PORT_SPEED_40GB    = 6,
+	PORT_SPEED_50GB    = 7,
+	PORT_SPEED_100GB   = 8,
+	PORT_SPEED_200GB   = 9,
+	PORT_SPEED_UNKNOWN
+};
+
+enum mag_cmd_port_an {
+	PORT_AN_NOT_SET = 0,
+	PORT_CFG_AN_ON  = 1,
+	PORT_CFG_AN_OFF = 2
+};
+
+/* mag_cmd_set_port_cfg config bitmap */
+#define MAG_CMD_SET_SPEED      0x1
+#define MAG_CMD_SET_AUTONEG    0x2
+#define MAG_CMD_SET_FEC        0x4
+#define MAG_CMD_SET_LANES      0x8
+struct mag_cmd_set_port_cfg {
+	struct mgmt_msg_head head;
+
+	u8                   port_id;
+	u8                   rsvd0[3];
+
+	u32                  config_bitmap;
+	u8                   speed;
+	u8                   autoneg;
+	u8                   fec;
+	u8                   lanes;
+	u8                   rsvd1[20];
+};
+
+/* mag supported/advertised link mode bitmap */
+enum mag_cmd_link_mode {
+	LINK_MODE_GE            = 0,
+	LINK_MODE_10GE_BASE_R   = 1,
+	LINK_MODE_25GE_BASE_R   = 2,
+	LINK_MODE_40GE_BASE_R4  = 3,
+	LINK_MODE_50GE_BASE_R   = 4,
+	LINK_MODE_50GE_BASE_R2  = 5,
+	LINK_MODE_100GE_BASE_R  = 6,
+	LINK_MODE_100GE_BASE_R2 = 7,
+	LINK_MODE_100GE_BASE_R4 = 8,
+	LINK_MODE_200GE_BASE_R2 = 9,
+	LINK_MODE_200GE_BASE_R4 = 10,
+	LINK_MODE_MAX_NUMBERS,
+
+	LINK_MODE_UNKNOWN       = 0xFFFF
+};
+
+#define LINK_MODE_GE_BIT               0x1u
+#define LINK_MODE_10GE_BASE_R_BIT      0x2u
+#define LINK_MODE_25GE_BASE_R_BIT      0x4u
+#define LINK_MODE_40GE_BASE_R4_BIT     0x8u
+#define LINK_MODE_50GE_BASE_R_BIT      0x10u
+#define LINK_MODE_50GE_BASE_R2_BIT     0x20u
+#define LINK_MODE_100GE_BASE_R_BIT     0x40u
+#define LINK_MODE_100GE_BASE_R2_BIT    0x80u
+#define LINK_MODE_100GE_BASE_R4_BIT    0x100u
+#define LINK_MODE_200GE_BASE_R2_BIT    0x200u
+#define LINK_MODE_200GE_BASE_R4_BIT    0x400u
+
+#define CABLE_10GE_BASE_R_BIT   LINK_MODE_10GE_BASE_R_BIT
+#define CABLE_25GE_BASE_R_BIT   (LINK_MODE_25GE_BASE_R_BIT | LINK_MODE_10GE_BASE_R_BIT)
+#define CABLE_40GE_BASE_R4_BIT  LINK_MODE_40GE_BASE_R4_BIT
+#define CABLE_50GE_BASE_R_BIT \
+	(LINK_MODE_50GE_BASE_R_BIT | LINK_MODE_25GE_BASE_R_BIT | LINK_MODE_10GE_BASE_R_BIT)
+#define CABLE_50GE_BASE_R2_BIT  LINK_MODE_50GE_BASE_R2_BIT
+#define CABLE_100GE_BASE_R2_BIT (LINK_MODE_100GE_BASE_R2_BIT | LINK_MODE_50GE_BASE_R2_BIT)
+#define CABLE_100GE_BASE_R4_BIT (LINK_MODE_100GE_BASE_R4_BIT | LINK_MODE_40GE_BASE_R4_BIT)
+#define CABLE_200GE_BASE_R4_BIT \
+	(LINK_MODE_200GE_BASE_R4_BIT | LINK_MODE_100GE_BASE_R4_BIT | LINK_MODE_40GE_BASE_R4_BIT)
+
+struct mag_cmd_get_port_info {
+	struct mgmt_msg_head head;
+
+	u8                   port_id;
+	u8                   rsvd0[3];
+
+	u8                   wire_type;
+	u8                   an_support;
+	u8                   an_en;
+	u8                   duplex;
+
+	u8                   speed;
+	u8                   fec;
+	u8                   lanes;
+	u8                   rsvd1;
+
+	u32                  supported_mode;
+	u32                  advertised_mode;
+	u8                   rsvd2[8];
+};
+
+#define MAG_CMD_PORT_DISABLE    0x0
+#define MAG_CMD_TX_ENABLE       0x1
+#define MAG_CMD_RX_ENABLE       0x2
+/* the physical port is disabled only when all pf of the port are set to down,
+ * if any pf is enabled, the port is enabled
+ */
+struct mag_cmd_set_port_enable {
+	struct mgmt_msg_head head;
+
+	u16                  function_id;
+	u16                  rsvd0;
+
+	/* bitmap bit0:tx_en bit1:rx_en */
+	u8                   state;
+	u8                   rsvd1[3];
+};
+
+/* firmware also use this cmd report link event to driver */
+struct mag_cmd_get_link_status {
+	struct mgmt_msg_head head;
+
+	u8                   port_id;
+	/* 0:link down  1:link up */
+	u8                   status;
+	u8                   rsvd0[2];
+};
+
+/* xsfp wire type, refers to cmis protocol definition */
+enum mag_wire_type {
+	MAG_CMD_WIRE_TYPE_UNKNOWN   = 0x0,
+	MAG_CMD_WIRE_TYPE_MM        = 0x1,
+	MAG_CMD_WIRE_TYPE_SM        = 0x2,
+	MAG_CMD_WIRE_TYPE_COPPER    = 0x3,
+	MAG_CMD_WIRE_TYPE_ACC       = 0x4,
+	MAG_CMD_WIRE_TYPE_BASET     = 0x5,
+	MAG_CMD_WIRE_TYPE_AOC       = 0x40,
+	MAG_CMD_WIRE_TYPE_ELECTRIC  = 0x41,
+	MAG_CMD_WIRE_TYPE_BACKPLANE = 0x42
+};
+
+#define XSFP_INFO_MAX_SIZE    640
+struct mag_cmd_get_xsfp_info {
+	struct mgmt_msg_head head;
+
+	u8                   port_id;
+	u8                   wire_type;
+	u16                  out_len;
+	u32                  rsvd;
+	u8                   sfp_info[XSFP_INFO_MAX_SIZE];
+};
+
+#define MAG_CMD_XSFP_PRESENT    0x0
+#define MAG_CMD_XSFP_ABSENT     0x1
+struct mag_cmd_get_xsfp_present {
+	struct mgmt_msg_head head;
+
+	u8                   port_id;
+	/* 0:present, 1:absent */
+	u8                   abs_status;
+	u8                   rsvd[2];
+};
+
+struct mag_cmd_port_stats {
+	u64 mac_tx_fragment_pkt_num;
+	u64 mac_tx_undersize_pkt_num;
+	u64 mac_tx_undermin_pkt_num;
+	u64 mac_tx_64_oct_pkt_num;
+	u64 mac_tx_65_127_oct_pkt_num;
+	u64 mac_tx_128_255_oct_pkt_num;
+	u64 mac_tx_256_511_oct_pkt_num;
+	u64 mac_tx_512_1023_oct_pkt_num;
+	u64 mac_tx_1024_1518_oct_pkt_num;
+	u64 mac_tx_1519_2047_oct_pkt_num;
+	u64 mac_tx_2048_4095_oct_pkt_num;
+	u64 mac_tx_4096_8191_oct_pkt_num;
+	u64 mac_tx_8192_9216_oct_pkt_num;
+	u64 mac_tx_9217_12287_oct_pkt_num;
+	u64 mac_tx_12288_16383_oct_pkt_num;
+	u64 mac_tx_1519_max_bad_pkt_num;
+	u64 mac_tx_1519_max_good_pkt_num;
+	u64 mac_tx_oversize_pkt_num;
+	u64 mac_tx_jabber_pkt_num;
+	u64 mac_tx_bad_pkt_num;
+	u64 mac_tx_bad_oct_num;
+	u64 mac_tx_good_pkt_num;
+	u64 mac_tx_good_oct_num;
+	u64 mac_tx_total_pkt_num;
+	u64 mac_tx_total_oct_num;
+	u64 mac_tx_uni_pkt_num;
+	u64 mac_tx_multi_pkt_num;
+	u64 mac_tx_broad_pkt_num;
+	u64 mac_tx_pause_num;
+	u64 mac_tx_pfc_pkt_num;
+	u64 mac_tx_pfc_pri0_pkt_num;
+	u64 mac_tx_pfc_pri1_pkt_num;
+	u64 mac_tx_pfc_pri2_pkt_num;
+	u64 mac_tx_pfc_pri3_pkt_num;
+	u64 mac_tx_pfc_pri4_pkt_num;
+	u64 mac_tx_pfc_pri5_pkt_num;
+	u64 mac_tx_pfc_pri6_pkt_num;
+	u64 mac_tx_pfc_pri7_pkt_num;
+	u64 mac_tx_control_pkt_num;
+	u64 mac_tx_err_all_pkt_num;
+	u64 mac_tx_from_app_good_pkt_num;
+	u64 mac_tx_from_app_bad_pkt_num;
+
+	u64 mac_rx_fragment_pkt_num;
+	u64 mac_rx_undersize_pkt_num;
+	u64 mac_rx_undermin_pkt_num;
+	u64 mac_rx_64_oct_pkt_num;
+	u64 mac_rx_65_127_oct_pkt_num;
+	u64 mac_rx_128_255_oct_pkt_num;
+	u64 mac_rx_256_511_oct_pkt_num;
+	u64 mac_rx_512_1023_oct_pkt_num;
+	u64 mac_rx_1024_1518_oct_pkt_num;
+	u64 mac_rx_1519_2047_oct_pkt_num;
+	u64 mac_rx_2048_4095_oct_pkt_num;
+	u64 mac_rx_4096_8191_oct_pkt_num;
+	u64 mac_rx_8192_9216_oct_pkt_num;
+	u64 mac_rx_9217_12287_oct_pkt_num;
+	u64 mac_rx_12288_16383_oct_pkt_num;
+	u64 mac_rx_1519_max_bad_pkt_num;
+	u64 mac_rx_1519_max_good_pkt_num;
+	u64 mac_rx_oversize_pkt_num;
+	u64 mac_rx_jabber_pkt_num;
+	u64 mac_rx_bad_pkt_num;
+	u64 mac_rx_bad_oct_num;
+	u64 mac_rx_good_pkt_num;
+	u64 mac_rx_good_oct_num;
+	u64 mac_rx_total_pkt_num;
+	u64 mac_rx_total_oct_num;
+	u64 mac_rx_uni_pkt_num;
+	u64 mac_rx_multi_pkt_num;
+	u64 mac_rx_broad_pkt_num;
+	u64 mac_rx_pause_num;
+	u64 mac_rx_pfc_pkt_num;
+	u64 mac_rx_pfc_pri0_pkt_num;
+	u64 mac_rx_pfc_pri1_pkt_num;
+	u64 mac_rx_pfc_pri2_pkt_num;
+	u64 mac_rx_pfc_pri3_pkt_num;
+	u64 mac_rx_pfc_pri4_pkt_num;
+	u64 mac_rx_pfc_pri5_pkt_num;
+	u64 mac_rx_pfc_pri6_pkt_num;
+	u64 mac_rx_pfc_pri7_pkt_num;
+	u64 mac_rx_control_pkt_num;
+	u64 mac_rx_sym_err_pkt_num;
+	u64 mac_rx_fcs_err_pkt_num;
+	u64 mac_rx_send_app_good_pkt_num;
+	u64 mac_rx_send_app_bad_pkt_num;
+	u64 mac_rx_unfilter_pkt_num;
+};
+
+struct mag_cmd_port_stats_info {
+	struct mgmt_msg_head head;
+
+	u8                   port_id;
+	u8                   rsvd0[3];
+};
+
+struct mag_cmd_get_port_stat {
+	struct mgmt_msg_head      head;
+
+	struct mag_cmd_port_stats counter;
+	u64                       rsvd1[15];
+};
+
+/* xsfp plug event */
+struct mag_cmd_wire_event {
+	struct mgmt_msg_head head;
+
+	u8                   port_id;
+	/* 0:present, 1:absent */
+	u8                   status;
+	u8                   rsvd[2];
+};
+
+enum link_err_type {
+	LINK_ERR_MODULE_UNRECOGENIZED,
+	LINK_ERR_NUM,
+};
+
+enum port_module_event_type {
+	HINIC3_PORT_MODULE_CABLE_PLUGGED,
+	HINIC3_PORT_MODULE_CABLE_UNPLUGGED,
+	HINIC3_PORT_MODULE_LINK_ERR,
+	HINIC3_PORT_MODULE_MAX_EVENT,
+};
+
+struct hinic3_port_module_event {
+	enum port_module_event_type type;
+	enum link_err_type          err_type;
+};
+
+struct nic_port_info {
+	u8  port_type;
+	u8  autoneg_cap;
+	u8  autoneg_state;
+	u8  duplex;
+	u8  speed;
+	u8  fec;
+	u32 supported_mode;
+	u32 advertised_mode;
+};
+
+struct nic_pause_config {
+	u8 auto_neg;
+	u8 rx_pause;
+	u8 tx_pause;
+};
+
+struct hinic3_port_routine_cmd {
+	bool                            mpu_send_sfp_info;
+	bool                            mpu_send_sfp_abs;
+
+	struct mag_cmd_get_xsfp_info    std_sfp_info;
+	struct mag_cmd_get_xsfp_present abs;
+};
+
+struct hinic3_nic_cfg {
+	struct semaphore               cfg_lock;
+
+	/* Valid when pfc is disabled */
+	bool                           pause_set;
+	struct nic_pause_config        nic_pause;
+
+	u8                             pfc_en;
+	u8                             pfc_bitmap;
+
+	struct nic_port_info           port_info;
+
+	struct hinic3_port_routine_cmd rt_cmd;
+	/* used for copying sfp info */
+	struct mutex                   sfp_mutex;
+};
+
+int l2nic_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd,
+			   const void *buf_in, u32 in_size,
+			   void *buf_out, u32 *out_size);
+
+int hinic3_get_nic_feature_from_hw(struct hinic3_nic_dev *nic_dev);
+int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev);
+bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
+			 enum nic_feature_cap feature_bits);
+void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature_cap);
+
+int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, u8 lro_en,
+			    u32 lro_timer, u8 lro_max_pkt_len);
+int hinic3_set_rx_vlan_offload(struct hinic3_hwdev *hwdev, u8 en);
+int hinic3_set_vlan_fliter(struct hinic3_hwdev *hwdev, u32 vlan_filter_ctrl);
+
+int hinic3_init_function_table(struct hinic3_nic_dev *nic_dev);
+int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu);
+
+int hinic3_get_default_mac(struct hinic3_hwdev *hwdev, u8 *mac_addr);
+int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_id);
+int hinic3_del_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_id);
+int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac, u8 *new_mac, u16 vlan_id,
+		      u16 func_id);
+
+int hinic3_set_ci_table(struct hinic3_hwdev *hwdev, struct hinic3_sq_attr *attr);
+int hinic3_flush_qps_res(struct hinic3_hwdev *hwdev);
+int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev);
+int hinic3_set_rx_mode(struct hinic3_hwdev *hwdev, u32 enable);
+
+int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state);
+int hinic3_set_port_enable(struct hinic3_hwdev *hwdev, bool enable);
+int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up);
+int hinic3_get_port_info(struct hinic3_hwdev *hwdev, struct nic_port_info *port_info);
+int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id, bool enable);
+int hinic3_get_phy_port_stats(struct hinic3_hwdev *hwdev,
+			      struct mag_cmd_port_stats *stats);
+int hinic3_get_vport_stats(struct hinic3_hwdev *hwdev, u16 func_id,
+			   struct hinic3_vport_stats *stats);
+
+int hinic3_add_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id);
+int hinic3_del_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id);
+
+int hinic3_get_pause_info(struct hinic3_nic_dev *nic_dev,
+			  struct nic_pause_config *nic_pause);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
new file mode 100644
index 000000000000..25591e689323
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -0,0 +1,213 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_NIC_DEV_H
+#define HINIC3_NIC_DEV_H
+
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/semaphore.h>
+#include <linux/if_vlan.h>
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+
+#include "hinic3_hw_cfg.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_mgmt_interface.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_tx.h"
+#include "hinic3_rx.h"
+
+#define VLAN_BITMAP_BYTE_SIZE(nic_dev)  (sizeof(*(nic_dev)->vlan_bitmap))
+#define VLAN_BITMAP_SIZE(nic_dev) \
+	(VLAN_N_VID / VLAN_BITMAP_BYTE_SIZE(nic_dev))
+
+#define HINIC3_MODERATONE_DELAY  HZ
+
+enum hinic3_flags {
+	HINIC3_INTF_UP,
+	HINIC3_MAC_FILTER_CHANGED,
+	HINIC3_RSS_ENABLE,
+	HINIC3_INTR_ADAPT,
+	HINIC3_UPDATE_MAC_FILTER,
+	HINIC3_CHANGE_RES_INVALID,
+	HINIC3_RSS_DEFAULT_INDIR,
+};
+
+#define HINIC3_CHANNEL_RES_VALID(nic_dev) \
+	(test_bit(HINIC3_INTF_UP, &(nic_dev)->flags) && \
+	 !test_bit(HINIC3_CHANGE_RES_INVALID, &(nic_dev)->flags))
+
+enum hinic3_event_work_flags {
+	EVENT_WORK_TX_TIMEOUT,
+};
+
+#define HINIC3_NIC_STATS_INC(nic_dev, field) \
+do { \
+	u64_stats_update_begin(&(nic_dev)->stats.syncp); \
+	(nic_dev)->stats.field++; \
+	u64_stats_update_end(&(nic_dev)->stats.syncp); \
+} while (0)
+
+struct hinic3_nic_stats {
+	u64                   netdev_tx_timeout;
+
+	/* Subdivision statistics show in private tool */
+	u64                   tx_carrier_off_drop;
+	u64                   tx_invalid_qid;
+	struct u64_stats_sync syncp;
+};
+
+enum hinic3_rx_mode_state {
+	HINIC3_HW_PROMISC_ON,
+	HINIC3_HW_ALLMULTI_ON,
+	HINIC3_PROMISC_FORCE_ON,
+	HINIC3_ALLMULTI_FORCE_ON,
+};
+
+enum mac_filter_state {
+	HINIC3_MAC_WAIT_HW_SYNC,
+	HINIC3_MAC_HW_SYNCED,
+	HINIC3_MAC_WAIT_HW_UNSYNC,
+	HINIC3_MAC_HW_UNSYNCED,
+};
+
+struct hinic3_mac_filter {
+	struct list_head list;
+	u8               addr[ETH_ALEN];
+	unsigned long    state;
+};
+
+enum hinic3_rss_hash_type {
+	HINIC3_RSS_HASH_ENGINE_TYPE_XOR  = 0,
+	HINIC3_RSS_HASH_ENGINE_TYPE_TOEP = 1,
+};
+
+struct nic_rss_type {
+	u8 tcp_ipv6_ext;
+	u8 ipv6_ext;
+	u8 tcp_ipv6;
+	u8 ipv6;
+	u8 tcp_ipv4;
+	u8 ipv4;
+	u8 udp_ipv6;
+	u8 udp_ipv4;
+};
+
+struct nic_rss_indirect_tbl_set {
+	u32 rsvd[4];
+	u16 entry[NIC_RSS_INDIR_SIZE];
+};
+
+struct nic_rss_indirect_tbl_get {
+	u16 entry[NIC_RSS_INDIR_SIZE];
+};
+
+struct hinic3_rx_flow_rule {
+	struct list_head rules;
+	u32              tot_num_rules;
+};
+
+struct hinic3_irq {
+	struct net_device  *netdev;
+	u16                msix_entry_idx;
+	/* provided by OS */
+	u32                irq_id;
+
+	char               irq_name[IFNAMSIZ + 16];
+	struct napi_struct napi;
+	cpumask_t          affinity_mask;
+	struct hinic3_txq  *txq;
+	struct hinic3_rxq  *rxq;
+};
+
+struct hinic3_dyna_txrxq_params {
+	u16                        num_qps;
+	u32                        sq_depth;
+	u32                        rq_depth;
+
+	struct hinic3_dyna_txq_res *txqs_res;
+	struct hinic3_dyna_rxq_res *rxqs_res;
+	struct hinic3_irq          *irq_cfg;
+};
+
+struct hinic3_intr_coal_info {
+	u8  pending_limt;
+	u8  coalesce_timer_cfg;
+	u8  resend_timer_cfg;
+
+	u64 pkt_rate_low;
+	u8  rx_usecs_low;
+	u8  rx_pending_limt_low;
+	u64 pkt_rate_high;
+	u8  rx_usecs_high;
+	u8  rx_pending_limt_high;
+
+	u8  user_set_intr_coal_flag;
+};
+
+struct hinic3_nic_dev {
+	struct pci_dev                  *pdev;
+	struct net_device               *netdev;
+	struct hinic3_hwdev             *hwdev;
+	struct hinic3_nic_io            *nic_io;
+
+	u32                             msg_enable;
+	u16                             max_qps;
+	u32                             dma_rx_buff_size;
+	u16                             rx_buff_len;
+	u32                             page_order;
+	u32                             lro_replenish_thld;
+	unsigned long                   *vlan_bitmap;
+	unsigned long                   flags;
+	struct nic_service_cap          nic_cap;
+
+	struct hinic3_dyna_txrxq_params q_params;
+	struct hinic3_txq               *txqs;
+	struct hinic3_rxq               *rxqs;
+	struct hinic3_nic_stats         stats;
+
+	enum hinic3_rss_hash_type       rss_hash_type;
+	struct nic_rss_type             rss_type;
+	u8                              *rss_hkey;
+	u32                             *rss_indir;
+
+	u16                             num_qp_irq;
+	struct irq_info                 *qps_irq_info;
+
+	struct hinic3_intr_coal_info    *intr_coalesce;
+	u32                             adaptive_rx_coal;
+	unsigned long                   last_moder_jiffies;
+
+	struct workqueue_struct         *workq;
+	struct delayed_work             periodic_work;
+	struct delayed_work             moderation_task;
+	struct work_struct              rx_mode_work;
+	struct semaphore                port_state_sem;
+
+	struct list_head                uc_filter_list;
+	struct list_head                mc_filter_list;
+	unsigned long                   rx_mod_state;
+	int                             netdev_uc_cnt;
+	int                             netdev_mc_cnt;
+
+	/* flag bits defined by hinic3_event_work_flags */
+	unsigned long                   event_flag;
+	bool                            link_status_up;
+};
+
+void hinic3_set_netdev_ops(struct net_device *netdev);
+int hinic3_set_hw_features(struct net_device *netdev);
+int hinic3_change_channel_settings(struct net_device *netdev,
+				   struct hinic3_dyna_txrxq_params *trxq_params,
+				   void (*reopen_handler)(struct net_device *netdev));
+
+int hinic3_qps_irq_init(struct net_device *netdev);
+void hinic3_qps_irq_deinit(struct net_device *netdev);
+
+void hinic3_set_rx_mode_work(struct work_struct *work);
+void hinic3_clean_mac_list_filter(struct net_device *netdev);
+
+void hinic3_set_ethtool_ops(struct net_device *netdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
new file mode 100644
index 000000000000..691e489dab92
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
@@ -0,0 +1,897 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+
+#include "hinic3_hw_intf.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_cmdq.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_mgmt_interface.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_nic_io.h"
+
+#define HINIC3_DEAULT_TX_CI_PENDING_LIMIT    1
+#define HINIC3_DEAULT_TX_CI_COALESCING_TIME  1
+#define HINIC3_DEAULT_DROP_THD_ON            (0xFFFF)
+#define HINIC3_DEAULT_DROP_THD_OFF           0
+
+#define HINIC3_CI_Q_ADDR_SIZE                (64)
+
+#define CI_TABLE_SIZE(num_qps)  \
+	(ALIGN((num_qps) * HINIC3_CI_Q_ADDR_SIZE, HINIC3_MIN_PAGE_SIZE))
+
+#define HINIC3_CI_VADDR(base_addr, q_id)  \
+	((u8 *)(base_addr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)
+
+#define HINIC3_CI_PADDR(base_paddr, q_id)  \
+	((base_paddr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)
+
+#define SQ_WQ_PREFETCH_MAX        1
+#define SQ_WQ_PREFETCH_MIN        1
+#define SQ_WQ_PREFETCH_THRESHOLD  16
+
+#define RQ_WQ_PREFETCH_MAX        4
+#define RQ_WQ_PREFETCH_MIN        1
+#define RQ_WQ_PREFETCH_THRESHOLD  256
+
+/* (2048 - 8) / 64 */
+#define HINIC3_Q_CTXT_MAX         31
+
+enum hinic3_qp_ctxt_type {
+	HINIC3_QP_CTXT_TYPE_SQ = 0,
+	HINIC3_QP_CTXT_TYPE_RQ = 1,
+};
+
+struct hinic3_qp_ctxt_hdr {
+	u16 num_queues;
+	u16 queue_type;
+	u16 start_qid;
+	u16 rsvd;
+};
+
+struct hinic3_sq_ctxt {
+	u32 ci_pi;
+	u32 drop_mode_sp;
+	u32 wq_pfn_hi_owner;
+	u32 wq_pfn_lo;
+
+	u32 rsvd0;
+	u32 pkt_drop_thd;
+	u32 global_sq_id;
+	u32 vlan_ceq_attr;
+
+	u32 pref_cache;
+	u32 pref_ci_owner;
+	u32 pref_wq_pfn_hi_ci;
+	u32 pref_wq_pfn_lo;
+
+	u32 rsvd8;
+	u32 rsvd9;
+	u32 wq_block_pfn_hi;
+	u32 wq_block_pfn_lo;
+};
+
+struct hinic3_rq_ctxt {
+	u32 ci_pi;
+	u32 ceq_attr;
+	u32 wq_pfn_hi_type_owner;
+	u32 wq_pfn_lo;
+
+	u32 rsvd[3];
+	u32 cqe_sge_len;
+
+	u32 pref_cache;
+	u32 pref_ci_owner;
+	u32 pref_wq_pfn_hi_ci;
+	u32 pref_wq_pfn_lo;
+
+	u32 pi_paddr_hi;
+	u32 pi_paddr_lo;
+	u32 wq_block_pfn_hi;
+	u32 wq_block_pfn_lo;
+};
+
+struct hinic3_sq_ctxt_block {
+	struct hinic3_qp_ctxt_hdr cmdq_hdr;
+	struct hinic3_sq_ctxt     sq_ctxt[HINIC3_Q_CTXT_MAX];
+};
+
+struct hinic3_rq_ctxt_block {
+	struct hinic3_qp_ctxt_hdr cmdq_hdr;
+	struct hinic3_rq_ctxt     rq_ctxt[HINIC3_Q_CTXT_MAX];
+};
+
+struct hinic3_clean_queue_ctxt {
+	struct hinic3_qp_ctxt_hdr cmdq_hdr;
+	u32                       rsvd;
+};
+
+#define SQ_CTXT_SIZE(num_sqs)  \
+	((u16)(sizeof(struct hinic3_qp_ctxt_hdr) +  \
+	 (num_sqs) * sizeof(struct hinic3_sq_ctxt)))
+
+#define RQ_CTXT_SIZE(num_rqs)  \
+	((u16)(sizeof(struct hinic3_qp_ctxt_hdr) +  \
+	 (num_rqs) * sizeof(struct hinic3_rq_ctxt)))
+
+#define CI_IDX_HIGH_SHIFH    12
+#define CI_HIGN_IDX(val)     ((val) >> CI_IDX_HIGH_SHIFH)
+
+#define SQ_CTXT_PI_IDX_MASK                GENMASK(15, 0)
+#define SQ_CTXT_CI_IDX_MASK                GENMASK(31, 16)
+#define SQ_CTXT_CI_PI_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_##member##_MASK, val)
+
+#define SQ_CTXT_MODE_SP_FLAG_MASK          BIT(0)
+#define SQ_CTXT_MODE_PKT_DROP_MASK         BIT(1)
+#define SQ_CTXT_MODE_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_MODE_##member##_MASK, val)
+
+#define SQ_CTXT_WQ_PAGE_HI_PFN_MASK        GENMASK(19, 0)
+#define SQ_CTXT_WQ_PAGE_OWNER_MASK         BIT(23)
+#define SQ_CTXT_WQ_PAGE_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_WQ_PAGE_##member##_MASK, val)
+
+#define SQ_CTXT_PKT_DROP_THD_ON_MASK       GENMASK(15, 0)
+#define SQ_CTXT_PKT_DROP_THD_OFF_MASK      GENMASK(31, 16)
+#define SQ_CTXT_PKT_DROP_THD_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_PKT_DROP_##member##_MASK, val)
+
+#define SQ_CTXT_GLOBAL_SQ_ID_MASK          GENMASK(12, 0)
+#define SQ_CTXT_GLOBAL_QUEUE_ID_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_##member##_MASK, val)
+
+#define SQ_CTXT_VLAN_INSERT_MODE_MASK      GENMASK(20, 19)
+#define SQ_CTXT_VLAN_CEQ_EN_MASK           BIT(23)
+#define SQ_CTXT_VLAN_CEQ_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_VLAN_##member##_MASK, val)
+
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK  GENMASK(13, 0)
+#define SQ_CTXT_PREF_CACHE_MAX_MASK        GENMASK(24, 14)
+#define SQ_CTXT_PREF_CACHE_MIN_MASK        GENMASK(31, 25)
+
+#define SQ_CTXT_PREF_CI_HI_MASK            GENMASK(3, 0)
+#define SQ_CTXT_PREF_OWNER_MASK            BIT(4)
+
+#define SQ_CTXT_PREF_WQ_PFN_HI_MASK        GENMASK(19, 0)
+#define SQ_CTXT_PREF_CI_LOW_MASK           GENMASK(31, 20)
+#define SQ_CTXT_PREF_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_PREF_##member##_MASK, val)
+
+#define SQ_CTXT_WQ_BLOCK_PFN_HI_MASK       GENMASK(22, 0)
+#define SQ_CTXT_WQ_BLOCK_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_WQ_BLOCK_##member##_MASK, val)
+
+#define RQ_CTXT_PI_IDX_MASK                GENMASK(15, 0)
+#define RQ_CTXT_CI_IDX_MASK                GENMASK(31, 16)
+#define RQ_CTXT_CI_PI_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_##member##_MASK, val)
+
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK         GENMASK(30, 21)
+#define RQ_CTXT_CEQ_ATTR_EN_MASK           BIT(31)
+#define RQ_CTXT_CEQ_ATTR_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_CEQ_ATTR_##member##_MASK, val)
+
+#define RQ_CTXT_WQ_PAGE_HI_PFN_MASK        GENMASK(19, 0)
+#define RQ_CTXT_WQ_PAGE_WQE_TYPE_MASK      GENMASK(29, 28)
+#define RQ_CTXT_WQ_PAGE_OWNER_MASK         BIT(31)
+#define RQ_CTXT_WQ_PAGE_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_WQ_PAGE_##member##_MASK, val)
+
+#define RQ_CTXT_CQE_LEN_MASK               GENMASK(29, 28)
+#define RQ_CTXT_CQE_LEN_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_##member##_MASK, val)
+
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK  GENMASK(13, 0)
+#define RQ_CTXT_PREF_CACHE_MAX_MASK        GENMASK(24, 14)
+#define RQ_CTXT_PREF_CACHE_MIN_MASK        GENMASK(31, 25)
+
+#define RQ_CTXT_PREF_CI_HI_MASK            GENMASK(3, 0)
+#define RQ_CTXT_PREF_OWNER_MASK            BIT(4)
+
+#define RQ_CTXT_PREF_WQ_PFN_HI_MASK        GENMASK(19, 0)
+#define RQ_CTXT_PREF_CI_LOW_MASK           GENMASK(31, 20)
+#define RQ_CTXT_PREF_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_PREF_##member##_MASK, val)
+
+#define RQ_CTXT_WQ_BLOCK_PFN_HI_MASK       GENMASK(22, 0)
+#define RQ_CTXT_WQ_BLOCK_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_WQ_BLOCK_##member##_MASK, val)
+
+#define WQ_PAGE_PFN_SHIFT       12
+#define WQ_BLOCK_PFN_SHIFT      9
+#define WQ_PAGE_PFN(page_addr)  ((page_addr) >> WQ_PAGE_PFN_SHIFT)
+#define WQ_BLOCK_PFN(page_addr) ((page_addr) >> WQ_BLOCK_PFN_SHIFT)
+
+static int init_nic_io(struct hinic3_nic_io **nic_io)
+{
+	*nic_io = kzalloc(sizeof(**nic_io), GFP_KERNEL);
+	if (!(*nic_io))
+		return -ENOMEM;
+
+	sema_init(&((*nic_io)->nic_cfg.cfg_lock), 1);
+	mutex_init(&((*nic_io)->nic_cfg.sfp_mutex));
+
+	(*nic_io)->nic_cfg.rt_cmd.mpu_send_sfp_abs = false;
+	(*nic_io)->nic_cfg.rt_cmd.mpu_send_sfp_info = false;
+
+	return 0;
+}
+
+int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_nic_io *nic_io;
+	int err;
+
+	err = init_nic_io(&nic_io);
+	if (err)
+		return err;
+
+	nic_dev->nic_io = nic_io;
+
+	err = hinic3_set_func_svc_used_state(hwdev, SVC_T_NIC, 1);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set function svc used state\n");
+		goto err_set_used_state;
+	}
+
+	err = hinic3_init_function_table(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init function table\n");
+		goto err_out;
+	}
+
+	nic_io->rx_buff_len = nic_dev->rx_buff_len;
+
+	err = hinic3_get_nic_feature_from_hw(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to get nic features\n");
+		goto err_out;
+	}
+
+	nic_io->feature_cap &= NIC_F_ALL_MASK;
+	nic_io->feature_cap &= NIC_DRV_DEFAULT_FEATURE;
+	dev_dbg(hwdev->dev, "nic features: 0x%llx\n\n", nic_io->feature_cap);
+
+	return 0;
+
+err_out:
+	hinic3_set_func_svc_used_state(hwdev, SVC_T_NIC, 0);
+
+err_set_used_state:
+	nic_dev->nic_io = NULL;
+	kfree(nic_io);
+
+	return err;
+}
+
+void hinic3_free_nic_io(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+
+	hinic3_set_func_svc_used_state(nic_dev->hwdev, SVC_T_NIC, 0);
+	nic_dev->nic_io = NULL;
+	kfree(nic_io);
+}
+
+int hinic3_init_nicio_res(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	void __iomem *db_base;
+	int err;
+
+	nic_io->max_qps = hinic3_func_max_qnum(hwdev);
+
+	err = hinic3_alloc_db_addr(hwdev, &db_base, NULL);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate doorbell for sqs\n");
+		return -ENOMEM;
+	}
+	nic_io->sqs_db_addr = db_base;
+
+	err = hinic3_alloc_db_addr(hwdev, &db_base, NULL);
+	if (err) {
+		hinic3_free_db_addr(hwdev, nic_io->sqs_db_addr, NULL);
+		dev_err(hwdev->dev, "Failed to allocate doorbell for rqs\n");
+		return -ENOMEM;
+	}
+	nic_io->rqs_db_addr = db_base;
+
+	nic_io->ci_vaddr_base = dma_alloc_coherent(hwdev->dev,
+						   CI_TABLE_SIZE(nic_io->max_qps),
+						   &nic_io->ci_dma_base, GFP_KERNEL);
+	if (!nic_io->ci_vaddr_base) {
+		hinic3_free_db_addr(hwdev, nic_io->sqs_db_addr, NULL);
+		hinic3_free_db_addr(hwdev, nic_io->rqs_db_addr, NULL);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void hinic3_deinit_nicio_res(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+
+	dma_free_coherent(hwdev->dev,
+			  CI_TABLE_SIZE(nic_io->max_qps),
+			  nic_io->ci_vaddr_base, nic_io->ci_dma_base);
+
+	hinic3_free_db_addr(hwdev, nic_io->sqs_db_addr, NULL);
+	hinic3_free_db_addr(hwdev, nic_io->rqs_db_addr, NULL);
+}
+
+static int hinic3_create_sq(struct hinic3_hwdev *hwdev, struct hinic3_io_queue *sq,
+			    u16 q_id, u32 sq_depth, u16 sq_msix_idx)
+{
+	int err;
+
+	/* sq used & hardware request init 1 */
+	sq->owner = 1;
+
+	sq->q_id = q_id;
+	sq->msix_entry_idx = sq_msix_idx;
+
+	err = hinic3_wq_create(hwdev, &sq->wq, sq_depth,
+			       (u16)BIT(HINIC3_SQ_WQEBB_SHIFT));
+	if (err) {
+		dev_err(hwdev->dev, "Failed to create tx queue %u wq\n",
+			q_id);
+		return err;
+	}
+
+	return 0;
+}
+
+static int hinic3_create_rq(struct hinic3_hwdev *hwdev, struct hinic3_io_queue *rq,
+			    u16 q_id, u32 rq_depth, u16 rq_msix_idx)
+{
+	int err;
+
+	rq->q_id = q_id;
+	rq->msix_entry_idx = rq_msix_idx;
+
+	err = hinic3_wq_create(hwdev, &rq->wq, rq_depth,
+			       (u16)BIT(HINIC3_RQ_WQEBB_SHIFT + HINIC3_NORMAL_RQ_WQE));
+	if (err) {
+		dev_err(hwdev->dev, "Failed to create rx queue %u wq\n",
+			q_id);
+		return err;
+	}
+
+	return 0;
+}
+
+static int create_qp(struct hinic3_hwdev *hwdev, struct hinic3_io_queue *sq,
+		     struct hinic3_io_queue *rq, u16 q_id, u32 sq_depth,
+		     u32 rq_depth, u16 qp_msix_idx)
+{
+	int err;
+
+	err = hinic3_create_sq(hwdev, sq, q_id, sq_depth, qp_msix_idx);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to create sq, qid: %u\n",
+			q_id);
+		return err;
+	}
+
+	err = hinic3_create_rq(hwdev, rq, q_id, rq_depth, qp_msix_idx);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to create rq, qid: %u\n",
+			q_id);
+		goto err_create_rq;
+	}
+
+	return 0;
+
+err_create_rq:
+	hinic3_wq_destroy(hwdev, &sq->wq);
+
+	return err;
+}
+
+static void destroy_qp(struct hinic3_hwdev *hwdev, struct hinic3_io_queue *sq,
+		       struct hinic3_io_queue *rq)
+{
+	hinic3_wq_destroy(hwdev, &sq->wq);
+	hinic3_wq_destroy(hwdev, &rq->wq);
+}
+
+int hinic3_alloc_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params)
+{
+	struct irq_info *qps_msix_arry = nic_dev->qps_irq_info;
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_io_queue *sqs;
+	struct hinic3_io_queue *rqs;
+	u16 q_id, i;
+	int err;
+
+	if (qp_params->num_qps > nic_io->max_qps || !qp_params->num_qps)
+		return -EINVAL;
+
+	sqs = kcalloc(qp_params->num_qps, sizeof(*sqs), GFP_KERNEL);
+	if (!sqs) {
+		err = -ENOMEM;
+		goto err_alloc_sqs;
+	}
+
+	rqs = kcalloc(qp_params->num_qps, sizeof(*rqs), GFP_KERNEL);
+	if (!rqs) {
+		err = -ENOMEM;
+		goto err_alloc_rqs;
+	}
+
+	for (q_id = 0; q_id < qp_params->num_qps; q_id++) {
+		err = create_qp(hwdev, &sqs[q_id], &rqs[q_id], q_id, qp_params->sq_depth,
+				qp_params->rq_depth, qps_msix_arry[q_id].msix_entry_idx);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to allocate qp %u, err: %d\n", q_id, err);
+			goto err_create_qp;
+		}
+	}
+
+	qp_params->sqs = sqs;
+	qp_params->rqs = rqs;
+
+	return 0;
+
+err_create_qp:
+	for (i = 0; i < q_id; i++)
+		destroy_qp(hwdev, &sqs[i], &rqs[i]);
+
+	kfree(rqs);
+
+err_alloc_rqs:
+	kfree(sqs);
+
+err_alloc_sqs:
+
+	return err;
+}
+
+void hinic3_free_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params)
+{
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	u16 q_id;
+
+	for (q_id = 0; q_id < qp_params->num_qps; q_id++)
+		destroy_qp(hwdev, &qp_params->sqs[q_id], &qp_params->rqs[q_id]);
+
+	kfree(qp_params->sqs);
+	kfree(qp_params->rqs);
+}
+
+void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_io_queue *sqs = qp_params->sqs;
+	struct hinic3_io_queue *rqs = qp_params->rqs;
+	u16 q_id;
+
+	nic_io->num_qps = qp_params->num_qps;
+	nic_io->sq = qp_params->sqs;
+	nic_io->rq = qp_params->rqs;
+	for (q_id = 0; q_id < nic_io->num_qps; q_id++) {
+		sqs[q_id].cons_idx_addr =
+			(u16 *)HINIC3_CI_VADDR(nic_io->ci_vaddr_base, q_id);
+		/* clear ci value */
+		WRITE_ONCE(*sqs[q_id].cons_idx_addr, 0);
+
+		sqs[q_id].db_addr = nic_io->sqs_db_addr;
+		rqs[q_id].db_addr = nic_io->rqs_db_addr;
+	}
+}
+
+void hinic3_deinit_qps(struct hinic3_nic_dev *nic_dev,
+		       struct hinic3_dyna_qp_params *qp_params)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+
+	qp_params->sqs = nic_io->sq;
+	qp_params->rqs = nic_io->rq;
+	qp_params->num_qps = nic_io->num_qps;
+}
+
+static void hinic3_qp_prepare_cmdq_header(struct hinic3_qp_ctxt_hdr *qp_ctxt_hdr,
+					  enum hinic3_qp_ctxt_type ctxt_type,
+					  u16 num_queues, u16 q_id)
+{
+	qp_ctxt_hdr->queue_type = ctxt_type;
+	qp_ctxt_hdr->num_queues = num_queues;
+	qp_ctxt_hdr->start_qid = q_id;
+	qp_ctxt_hdr->rsvd = 0;
+
+	cmdq_buf_swab32(qp_ctxt_hdr, sizeof(*qp_ctxt_hdr));
+}
+
+static void hinic3_sq_prepare_ctxt(struct hinic3_io_queue *sq, u16 sq_id,
+				   struct hinic3_sq_ctxt *sq_ctxt)
+{
+	u64 wq_page_addr, wq_page_pfn, wq_block_pfn;
+	u32 wq_block_pfn_hi, wq_block_pfn_lo;
+	u32 wq_page_pfn_hi, wq_page_pfn_lo;
+	u16 pi_start, ci_start;
+
+	ci_start = hinic3_get_sq_local_ci(sq);
+	pi_start = hinic3_get_sq_local_pi(sq);
+
+	wq_page_addr = hinic3_wq_get_first_wqe_page_addr(&sq->wq);
+
+	wq_page_pfn = WQ_PAGE_PFN(wq_page_addr);
+	wq_page_pfn_hi = upper_32_bits(wq_page_pfn);
+	wq_page_pfn_lo = lower_32_bits(wq_page_pfn);
+
+	wq_block_pfn = WQ_BLOCK_PFN(sq->wq.wq_block_paddr);
+	wq_block_pfn_hi = upper_32_bits(wq_block_pfn);
+	wq_block_pfn_lo = lower_32_bits(wq_block_pfn);
+
+	sq_ctxt->ci_pi =
+		SQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |
+		SQ_CTXT_CI_PI_SET(pi_start, PI_IDX);
+
+	sq_ctxt->drop_mode_sp =
+		SQ_CTXT_MODE_SET(0, SP_FLAG) |
+		SQ_CTXT_MODE_SET(0, PKT_DROP);
+
+	sq_ctxt->wq_pfn_hi_owner =
+		SQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) |
+		SQ_CTXT_WQ_PAGE_SET(1, OWNER);
+
+	sq_ctxt->wq_pfn_lo = wq_page_pfn_lo;
+
+	sq_ctxt->pkt_drop_thd =
+		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_ON, THD_ON) |
+		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_OFF, THD_OFF);
+
+	sq_ctxt->global_sq_id =
+		SQ_CTXT_GLOBAL_QUEUE_ID_SET(sq_id, GLOBAL_SQ_ID);
+
+	/* enable insert c-vlan by default */
+	sq_ctxt->vlan_ceq_attr =
+		SQ_CTXT_VLAN_CEQ_SET(0, CEQ_EN) |
+		SQ_CTXT_VLAN_CEQ_SET(1, INSERT_MODE);
+
+	sq_ctxt->rsvd0 = 0;
+
+	sq_ctxt->pref_cache =
+		SQ_CTXT_PREF_SET(SQ_WQ_PREFETCH_MIN, CACHE_MIN) |
+		SQ_CTXT_PREF_SET(SQ_WQ_PREFETCH_MAX, CACHE_MAX) |
+		SQ_CTXT_PREF_SET(SQ_WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+
+	sq_ctxt->pref_ci_owner =
+		SQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |
+		SQ_CTXT_PREF_SET(1, OWNER);
+
+	sq_ctxt->pref_wq_pfn_hi_ci =
+		SQ_CTXT_PREF_SET(ci_start, CI_LOW) |
+		SQ_CTXT_PREF_SET(wq_page_pfn_hi, WQ_PFN_HI);
+
+	sq_ctxt->pref_wq_pfn_lo = wq_page_pfn_lo;
+
+	sq_ctxt->wq_block_pfn_hi =
+		SQ_CTXT_WQ_BLOCK_SET(wq_block_pfn_hi, PFN_HI);
+
+	sq_ctxt->wq_block_pfn_lo = wq_block_pfn_lo;
+
+	cmdq_buf_swab32(sq_ctxt, sizeof(*sq_ctxt));
+}
+
+static void hinic3_rq_prepare_ctxt_get_wq_info(struct hinic3_io_queue *rq,
+					       u32 *wq_page_pfn_hi, u32 *wq_page_pfn_lo,
+					       u32 *wq_block_pfn_hi, u32 *wq_block_pfn_lo)
+{
+	u64 wq_page_addr, wq_page_pfn, wq_block_pfn;
+
+	wq_page_addr = hinic3_wq_get_first_wqe_page_addr(&rq->wq);
+
+	wq_page_pfn = WQ_PAGE_PFN(wq_page_addr);
+	*wq_page_pfn_hi = upper_32_bits(wq_page_pfn);
+	*wq_page_pfn_lo = lower_32_bits(wq_page_pfn);
+
+	wq_block_pfn = WQ_BLOCK_PFN(rq->wq.wq_block_paddr);
+	*wq_block_pfn_hi = upper_32_bits(wq_block_pfn);
+	*wq_block_pfn_lo = lower_32_bits(wq_block_pfn);
+}
+
+static void hinic3_rq_prepare_ctxt(struct hinic3_io_queue *rq, struct hinic3_rq_ctxt *rq_ctxt)
+{
+	u32 wq_block_pfn_hi, wq_block_pfn_lo;
+	u32 wq_page_pfn_hi, wq_page_pfn_lo;
+	u16 pi_start, ci_start;
+
+	ci_start = (u16)((u32)(rq->wq.cons_idx & rq->wq.idx_mask) << HINIC3_NORMAL_RQ_WQE);
+	pi_start = (u16)((u32)(rq->wq.prod_idx & rq->wq.idx_mask) << HINIC3_NORMAL_RQ_WQE);
+
+	hinic3_rq_prepare_ctxt_get_wq_info(rq, &wq_page_pfn_hi, &wq_page_pfn_lo,
+					   &wq_block_pfn_hi, &wq_block_pfn_lo);
+
+	rq_ctxt->ci_pi =
+		RQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |
+		RQ_CTXT_CI_PI_SET(pi_start, PI_IDX);
+
+	rq_ctxt->ceq_attr =
+		RQ_CTXT_CEQ_ATTR_SET(0, EN) |
+		RQ_CTXT_CEQ_ATTR_SET(rq->msix_entry_idx, INTR);
+
+	rq_ctxt->wq_pfn_hi_type_owner =
+		RQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) |
+		RQ_CTXT_WQ_PAGE_SET(1, OWNER);
+
+	/* use 16Byte WQE */
+	rq_ctxt->wq_pfn_hi_type_owner |=
+		RQ_CTXT_WQ_PAGE_SET(2, WQE_TYPE);
+	rq_ctxt->cqe_sge_len = RQ_CTXT_CQE_LEN_SET(1, CQE_LEN);
+
+	rq_ctxt->wq_pfn_lo = wq_page_pfn_lo;
+
+	rq_ctxt->pref_cache =
+		RQ_CTXT_PREF_SET(RQ_WQ_PREFETCH_MIN, CACHE_MIN) |
+		RQ_CTXT_PREF_SET(RQ_WQ_PREFETCH_MAX, CACHE_MAX) |
+		RQ_CTXT_PREF_SET(RQ_WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+
+	rq_ctxt->pref_ci_owner =
+		RQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |
+		RQ_CTXT_PREF_SET(1, OWNER);
+
+	rq_ctxt->pref_wq_pfn_hi_ci =
+		RQ_CTXT_PREF_SET(wq_page_pfn_hi, WQ_PFN_HI) |
+		RQ_CTXT_PREF_SET(ci_start, CI_LOW);
+
+	rq_ctxt->pref_wq_pfn_lo = wq_page_pfn_lo;
+
+	rq_ctxt->wq_block_pfn_hi =
+		RQ_CTXT_WQ_BLOCK_SET(wq_block_pfn_hi, PFN_HI);
+
+	rq_ctxt->wq_block_pfn_lo = wq_block_pfn_lo;
+
+	cmdq_buf_swab32(rq_ctxt, sizeof(*rq_ctxt));
+}
+
+static int init_sq_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_sq_ctxt_block *sq_ctxt_block;
+	u16 q_id, curr_id, max_ctxts, i;
+	struct hinic3_sq_ctxt *sq_ctxt;
+	struct hinic3_cmd_buf *cmd_buf;
+	struct hinic3_io_queue *sq;
+	u64 out_param;
+	int err = 0;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
+		return -ENOMEM;
+	}
+
+	q_id = 0;
+	while (q_id < nic_io->num_qps) {
+		sq_ctxt_block = cmd_buf->buf;
+		sq_ctxt = sq_ctxt_block->sq_ctxt;
+
+		max_ctxts = (nic_io->num_qps - q_id) > HINIC3_Q_CTXT_MAX ?
+			     HINIC3_Q_CTXT_MAX : (nic_io->num_qps - q_id);
+
+		hinic3_qp_prepare_cmdq_header(&sq_ctxt_block->cmdq_hdr,
+					      HINIC3_QP_CTXT_TYPE_SQ, max_ctxts,
+					      q_id);
+
+		for (i = 0; i < max_ctxts; i++) {
+			curr_id = q_id + i;
+			sq = &nic_io->sq[curr_id];
+			hinic3_sq_prepare_ctxt(sq, curr_id, &sq_ctxt[i]);
+		}
+
+		cmd_buf->size = SQ_CTXT_SIZE(max_ctxts);
+		err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,
+					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,
+					      cmd_buf, &out_param);
+		if (err || out_param != 0) {
+			dev_err(hwdev->dev, "Failed to set SQ ctxts, err: %d, out_param: 0x%llx\n",
+				err, out_param);
+			err = -EFAULT;
+			break;
+		}
+
+		q_id += max_ctxts;
+	}
+
+	hinic3_free_cmd_buf(hwdev, cmd_buf);
+
+	return err;
+}
+
+static int init_rq_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_rq_ctxt_block *rq_ctxt_block;
+	u16 q_id, curr_id, max_ctxts, i;
+	struct hinic3_rq_ctxt *rq_ctxt;
+	struct hinic3_cmd_buf *cmd_buf;
+	struct hinic3_io_queue *rq;
+	u64 out_param;
+	int err = 0;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
+		return -ENOMEM;
+	}
+
+	q_id = 0;
+	while (q_id < nic_io->num_qps) {
+		rq_ctxt_block = cmd_buf->buf;
+		rq_ctxt = rq_ctxt_block->rq_ctxt;
+
+		max_ctxts = (nic_io->num_qps - q_id) > HINIC3_Q_CTXT_MAX ?
+				HINIC3_Q_CTXT_MAX : (nic_io->num_qps - q_id);
+
+		hinic3_qp_prepare_cmdq_header(&rq_ctxt_block->cmdq_hdr,
+					      HINIC3_QP_CTXT_TYPE_RQ, max_ctxts,
+					      q_id);
+
+		for (i = 0; i < max_ctxts; i++) {
+			curr_id = q_id + i;
+			rq = &nic_io->rq[curr_id];
+			hinic3_rq_prepare_ctxt(rq, &rq_ctxt[i]);
+		}
+
+		cmd_buf->size = RQ_CTXT_SIZE(max_ctxts);
+
+		err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,
+					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,
+					      cmd_buf, &out_param);
+		if (err || out_param != 0) {
+			dev_err(hwdev->dev, "Failed to set RQ ctxts, err: %d, out_param: 0x%llx\n",
+				err, out_param);
+			err = -EFAULT;
+			break;
+		}
+
+		q_id += max_ctxts;
+	}
+
+	hinic3_free_cmd_buf(hwdev, cmd_buf);
+
+	return err;
+}
+
+static int init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	int err;
+
+	err = init_sq_ctxts(nic_dev);
+	if (err)
+		return err;
+
+	err = init_rq_ctxts(nic_dev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,
+				    enum hinic3_qp_ctxt_type ctxt_type)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_clean_queue_ctxt *ctxt_block;
+	struct hinic3_cmd_buf *cmd_buf;
+	u64 out_param;
+	int err;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
+		return -ENOMEM;
+	}
+
+	ctxt_block = cmd_buf->buf;
+	ctxt_block->cmdq_hdr.num_queues = nic_io->max_qps;
+	ctxt_block->cmdq_hdr.queue_type = ctxt_type;
+	ctxt_block->cmdq_hdr.start_qid = 0;
+	ctxt_block->cmdq_hdr.rsvd = 0;
+	ctxt_block->rsvd = 0;
+
+	cmdq_buf_swab32(ctxt_block, sizeof(*ctxt_block));
+
+	cmd_buf->size = sizeof(*ctxt_block);
+
+	err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,
+				      HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT,
+				      cmd_buf, &out_param);
+	if ((err) || (out_param)) {
+		dev_err(hwdev->dev, "Failed to clean queue offload ctxts, err: %d,out_param: 0x%llx\n",
+			err, out_param);
+
+		err = -EFAULT;
+	}
+
+	hinic3_free_cmd_buf(hwdev, cmd_buf);
+
+	return err;
+}
+
+static int clean_qp_offload_ctxt(struct hinic3_nic_dev *nic_dev)
+{
+	/* clean LRO/TSO context space */
+	return (clean_queue_offload_ctxt(nic_dev, HINIC3_QP_CTXT_TYPE_SQ) ||
+		clean_queue_offload_ctxt(nic_dev, HINIC3_QP_CTXT_TYPE_RQ));
+}
+
+/* init qps ctxt and set sq ci attr and arm all sq */
+int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_sq_attr sq_attr;
+	u32 rq_depth;
+	u16 q_id;
+	int err;
+
+	err = init_qp_ctxts(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init QP ctxts\n");
+		return err;
+	}
+
+	/* clean LRO/TSO context space */
+	err = clean_qp_offload_ctxt(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to clean qp offload ctxts\n");
+		return err;
+	}
+
+	rq_depth = nic_io->rq[0].wq.q_depth << HINIC3_NORMAL_RQ_WQE;
+
+	err = hinic3_set_root_ctxt(hwdev, rq_depth, nic_io->sq[0].wq.q_depth,
+				   nic_io->rx_buff_len);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set root context\n");
+		return err;
+	}
+
+	for (q_id = 0; q_id < nic_io->num_qps; q_id++) {
+		sq_attr.ci_dma_base =
+			HINIC3_CI_PADDR(nic_io->ci_dma_base, q_id) >> 0x2;
+		sq_attr.pending_limit = HINIC3_DEAULT_TX_CI_PENDING_LIMIT;
+		sq_attr.coalescing_time = HINIC3_DEAULT_TX_CI_COALESCING_TIME;
+		sq_attr.intr_en = 1;
+		sq_attr.intr_idx = nic_io->sq[q_id].msix_entry_idx;
+		sq_attr.l2nic_sqn = q_id;
+		sq_attr.dma_attr_off = 0;
+		err = hinic3_set_ci_table(hwdev, &sq_attr);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to set ci table\n");
+			goto err_set_cons_idx_table;
+		}
+	}
+
+	return 0;
+
+err_set_cons_idx_table:
+	hinic3_clean_root_ctxt(hwdev);
+
+	return err;
+}
+
+void hinic3_free_qp_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	hinic3_clean_root_ctxt(nic_dev->hwdev);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
new file mode 100644
index 000000000000..08b4304dcfed
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_NIC_IO_H
+#define HINIC3_NIC_IO_H
+
+#include <linux/types.h>
+#include <linux/cache.h>
+#include <linux/io.h>
+#include <asm/barrier.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+
+#include "hinic3_wq.h"
+#include "hinic3_nic_cfg.h"
+
+struct hinic3_nic_dev;
+
+#define HINIC3_SQ_WQEBB_SHIFT      4
+#define HINIC3_RQ_WQEBB_SHIFT      3
+#define HINIC3_SQ_WQEBB_SIZE       BIT(HINIC3_SQ_WQEBB_SHIFT)
+#define HINIC3_CQE_SIZE_SHIFT      4
+
+#define HINIC3_MAX_TX_QUEUE_DEPTH  65536
+#define HINIC3_MAX_RX_QUEUE_DEPTH  16384
+#define HINIC3_MIN_QUEUE_DEPTH     128
+
+/* ******************** RQ_CTRL ******************** */
+enum hinic3_rq_wqe_type {
+	HINIC3_NORMAL_RQ_WQE = 1,
+};
+
+/* ******************** SQ_CTRL ******************** */
+#define TX_MSS_DEFAULT     0x3E00
+#define TX_MSS_MIN         0x50
+#define HINIC3_MAX_SQ_SGE  18
+
+struct hinic3_io_queue {
+	struct hinic3_wq  wq;
+	u8                owner;
+	u16               q_id;
+	u16               msix_entry_idx;
+	u8 __iomem        *db_addr;
+	u16               *cons_idx_addr;
+} ____cacheline_aligned;
+
+static inline u16 hinic3_get_sq_local_ci(const struct hinic3_io_queue *sq)
+{
+	const struct hinic3_wq *wq = &sq->wq;
+
+	return wq->cons_idx & wq->idx_mask;
+}
+
+static inline u16 hinic3_get_sq_local_pi(const struct hinic3_io_queue *sq)
+{
+	const struct hinic3_wq *wq = &sq->wq;
+
+	return wq->prod_idx & wq->idx_mask;
+}
+
+static inline u16 hinic3_get_sq_hw_ci(const struct hinic3_io_queue *sq)
+{
+	const struct hinic3_wq *wq = &sq->wq;
+
+	return READ_ONCE(*sq->cons_idx_addr) & wq->idx_mask;
+}
+
+/* ******************** DB INFO ******************** */
+#define DB_INFO_QID_MASK    GENMASK(12, 0)
+#define DB_INFO_CFLAG_MASK  BIT(23)
+#define DB_INFO_COS_MASK    GENMASK(26, 24)
+#define DB_INFO_TYPE_MASK   GENMASK(31, 27)
+#define DB_INFO_SET(val, member)  \
+	FIELD_PREP(DB_INFO_##member##_MASK, val)
+
+#define DB_PI_LOW_MASK   0xFFU
+#define DB_PI_HIGH_MASK  0xFFU
+#define DB_PI_HI_SHIFT   8
+#define DB_PI_LOW(pi)    ((pi) & DB_PI_LOW_MASK)
+#define DB_PI_HIGH(pi)   (((pi) >> DB_PI_HI_SHIFT) & DB_PI_HIGH_MASK)
+#define DB_ADDR(q, pi)   ((u64 __iomem *)((q)->db_addr) + DB_PI_LOW(pi))
+#define SRC_TYPE         1
+
+/* CFLAG_DATA_PATH */
+#define SQ_CFLAG_DP             0
+#define RQ_CFLAG_DP             1
+
+struct hinic3_nic_db {
+	u32 db_info;
+	u32 pi_hi;
+};
+
+static inline void hinic3_write_db(struct hinic3_io_queue *queue, int cos,
+				   u8 cflag, u16 pi)
+{
+	struct hinic3_nic_db db;
+
+	db.db_info = DB_INFO_SET(SRC_TYPE, TYPE) | DB_INFO_SET(cflag, CFLAG) |
+			DB_INFO_SET(cos, COS) | DB_INFO_SET(queue->q_id, QID);
+	db.pi_hi = DB_PI_HIGH(pi);
+
+	writeq(*((u64 *)&db), DB_ADDR(queue, pi));
+}
+
+struct hinic3_dyna_qp_params {
+	u16                    num_qps;
+	u32                    sq_depth;
+	u32                    rq_depth;
+
+	struct hinic3_io_queue *sqs;
+	struct hinic3_io_queue *rqs;
+};
+
+struct hinic3_nic_io {
+	struct hinic3_io_queue *sq;
+	struct hinic3_io_queue *rq;
+
+	u16                    num_qps;
+	u16                    max_qps;
+
+	/* Base address for consumer index of all tx queues. Each queue is
+	 * given a full cache line to hold its consumer index. HW updates
+	 * current consumer index as it consumes tx WQEs.
+	 */
+	void                   *ci_vaddr_base;
+	dma_addr_t             ci_dma_base;
+
+	u8 __iomem             *sqs_db_addr;
+	u8 __iomem             *rqs_db_addr;
+
+	struct hinic3_nic_cfg  nic_cfg;
+
+	u16                    rx_buff_len;
+	u64                    feature_cap;
+};
+
+int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev);
+void hinic3_free_nic_io(struct hinic3_nic_dev *nic_dev);
+
+int hinic3_init_nicio_res(struct hinic3_nic_dev *nic_dev);
+void hinic3_deinit_nicio_res(struct hinic3_nic_dev *nic_dev);
+
+int hinic3_alloc_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params);
+void hinic3_free_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params);
+void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params);
+void hinic3_deinit_qps(struct hinic3_nic_dev *nic_dev,
+		       struct hinic3_dyna_qp_params *qp_params);
+
+int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev);
+void hinic3_free_qp_ctxts(struct hinic3_nic_dev *nic_dev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h b/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
new file mode 100644
index 000000000000..0822094e7341
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_PCI_ID_TBL_H
+#define HINIC3_PCI_ID_TBL_H
+
+#define PCI_VENDOR_ID_HUAWEI    0x19e5
+#define PCI_DEV_ID_HINIC3_PF    0x0222
+#define PCI_DEV_ID_HINIC3_VF    0x375F
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.c b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.c
new file mode 100644
index 000000000000..4978a8c3d70c
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/slab.h>
+
+#include "hinic3_common.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_queue_common.h"
+
+void queue_pages_init(struct hinic3_queue_pages *qpages, u32 q_depth,
+		      u32 page_size, u32 elem_size)
+{
+	u32 elem_per_page;
+
+	elem_per_page = min(page_size / elem_size, q_depth);
+
+	qpages->pages = NULL;
+	qpages->page_size = page_size;
+	qpages->num_pages = max(q_depth / elem_per_page, 1);
+	qpages->elem_size_shift = ilog2(elem_size);
+	qpages->elem_per_pg_shift = ilog2(elem_per_page);
+}
+
+static void __queue_pages_free(struct hinic3_hwdev *hwdev,
+			       struct hinic3_queue_pages *qpages, u32 pg_cnt)
+{
+	while (pg_cnt > 0) {
+		pg_cnt--;
+		hinic3_dma_free_coherent_align(hwdev->dev,
+					       qpages->pages + pg_cnt);
+	}
+	kfree(qpages->pages);
+	qpages->pages = NULL;
+}
+
+void queue_pages_free(struct hinic3_hwdev *hwdev, struct hinic3_queue_pages *qpages)
+{
+	__queue_pages_free(hwdev, qpages, qpages->num_pages);
+}
+
+int queue_pages_alloc(struct hinic3_hwdev *hwdev, struct hinic3_queue_pages *qpages, u32 align)
+{
+	u32 pg_idx;
+	int err;
+
+	qpages->pages = kcalloc(qpages->num_pages, sizeof(qpages->pages[0]), GFP_KERNEL);
+	if (!qpages->pages)
+		return -ENOMEM;
+
+	if (align == 0)
+		align = qpages->page_size;
+
+	for (pg_idx = 0; pg_idx < qpages->num_pages; pg_idx++) {
+		err = hinic3_dma_zalloc_coherent_align(hwdev->dev,
+						       qpages->page_size,
+						       align,
+						       GFP_KERNEL,
+						       qpages->pages + pg_idx);
+		if (err) {
+			__queue_pages_free(hwdev, qpages, pg_idx);
+			return err;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
new file mode 100644
index 000000000000..1f3e22e5cd68
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_QUEUE_COMMON_H
+#define HINIC3_QUEUE_COMMON_H
+
+#include <linux/types.h>
+
+#include "hinic3_common.h"
+struct hinic3_hwdev;
+
+struct hinic3_queue_pages {
+	/* Array of DMA-able pages that actually holds the queue entries. */
+	struct hinic3_dma_addr_align  *pages;
+	/* Page size in bytes. */
+	u32                           page_size;
+	/* Number of pages, must be power of 2. */
+	u16                           num_pages;
+	u8                            elem_size_shift;
+	u8                            elem_per_pg_shift;
+};
+
+void queue_pages_init(struct hinic3_queue_pages *qpages, u32 q_depth,
+		      u32 page_size, u32 elem_size);
+int queue_pages_alloc(struct hinic3_hwdev *hwdev, struct hinic3_queue_pages *qpages, u32 align);
+void queue_pages_free(struct hinic3_hwdev *hwdev, struct hinic3_queue_pages *qpages);
+
+/* Get pointer to queue entry at the specified index. Index does not have to be
+ * masked to queue depth, only least significant bits will be used. Also
+ * provides remaining elements in same page (including the first one) in case
+ * caller needs multiple entries.
+ */
+static inline void *get_q_element(const struct hinic3_queue_pages *qpages,
+				  u32 idx, u32 *remaining_in_page)
+{
+	const struct hinic3_dma_addr_align *page;
+	u32 page_idx, elem_idx, elem_per_pg, ofs;
+	u8 shift;
+
+	shift = qpages->elem_per_pg_shift;
+	page_idx = (idx >> shift) & (qpages->num_pages - 1);
+	elem_per_pg = 1U << shift;
+	elem_idx = idx & (elem_per_pg - 1);
+	if (remaining_in_page)
+		*remaining_in_page = elem_per_pg - elem_idx;
+	ofs = elem_idx << qpages->elem_size_shift;
+	page = qpages->pages + page_idx;
+	return (char *)page->align_vaddr + ofs;
+}
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
new file mode 100644
index 000000000000..38ad8ba72000
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
@@ -0,0 +1,873 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+
+#include "hinic3_cmdq.h"
+#include "hinic3_mgmt_interface.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_rss.h"
+
+static void hinic3_fillout_indir_tbl(struct net_device *netdev, u32 *indir)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u32 i, num_qps;
+
+	num_qps = nic_dev->q_params.num_qps;
+	for (i = 0; i < NIC_RSS_INDIR_SIZE; i++)
+		indir[i] = i % num_qps;
+}
+
+static int hinic3_rss_cfg(struct hinic3_hwdev *hwdev, u8 rss_en, u16 num_qps)
+{
+	struct hinic3_cmd_rss_config rss_cfg;
+	u32 out_size = sizeof(rss_cfg);
+	int err;
+
+	memset(&rss_cfg, 0, sizeof(struct hinic3_cmd_rss_config));
+	rss_cfg.func_id = hinic3_global_func_id(hwdev);
+	rss_cfg.rss_en = rss_en;
+	rss_cfg.rq_priority_number = 0;
+	rss_cfg.num_qps = num_qps;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_RSS_CFG,
+				     &rss_cfg, sizeof(rss_cfg),
+				     &rss_cfg, &out_size);
+	if (err || !out_size || rss_cfg.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set rss cfg, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, rss_cfg.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void hinic3_init_rss_parameters(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	nic_dev->rss_hash_type = HINIC3_RSS_HASH_ENGINE_TYPE_XOR;
+	nic_dev->rss_type.tcp_ipv6_ext = 1;
+	nic_dev->rss_type.ipv6_ext = 1;
+	nic_dev->rss_type.tcp_ipv6 = 1;
+	nic_dev->rss_type.ipv6 = 1;
+	nic_dev->rss_type.tcp_ipv4 = 1;
+	nic_dev->rss_type.ipv4 = 1;
+	nic_dev->rss_type.udp_ipv6 = 1;
+	nic_dev->rss_type.udp_ipv4 = 1;
+}
+
+static void hinic3_set_default_rss_indir(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	set_bit(HINIC3_RSS_DEFAULT_INDIR, &nic_dev->flags);
+}
+
+static void hinic3_maybe_reconfig_rss_indir(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int i;
+
+	for (i = 0; i < NIC_RSS_INDIR_SIZE; i++) {
+		if (nic_dev->rss_indir[i] >= nic_dev->q_params.num_qps) {
+			hinic3_set_default_rss_indir(netdev);
+			break;
+		}
+	}
+}
+
+/* Get number of CPUs on same NUMA node of device. */
+static unsigned int dev_num_cpus(struct device *dev)
+{
+	unsigned int i, num_cpus, num_node_cpus;
+	int dev_node;
+
+	dev_node = dev_to_node(dev);
+	num_cpus = num_online_cpus();
+	num_node_cpus = 0;
+
+	for (i = 0; i < num_cpus; i++) {
+		if (cpu_to_node(i) == dev_node)
+			num_node_cpus++;
+	}
+
+	return num_node_cpus ? : num_cpus;
+}
+
+static void decide_num_qps(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	unsigned int dev_cpus, max_qps, num_qps;
+
+	dev_cpus = dev_num_cpus(&nic_dev->pdev->dev);
+	max_qps = min(dev_cpus, nic_dev->max_qps);
+	num_qps = nic_dev->nic_cap.default_num_queues;
+	if (num_qps == 0 || num_qps > max_qps)
+		num_qps = max_qps;
+
+	nic_dev->q_params.num_qps = num_qps;
+}
+
+static int alloc_rss_resource(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	static const u8 default_rss_key[NIC_RSS_KEY_SIZE] = {
+		0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
+		0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,
+		0xd0, 0xca, 0x2b, 0xcb, 0xae, 0x7b, 0x30, 0xb4,
+		0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,
+		0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa};
+
+	nic_dev->rss_hkey = kzalloc(NIC_RSS_KEY_SIZE, GFP_KERNEL);
+	if (!nic_dev->rss_hkey)
+		return -ENOMEM;
+
+	memcpy(nic_dev->rss_hkey, default_rss_key, NIC_RSS_KEY_SIZE);
+
+	nic_dev->rss_indir = kzalloc(sizeof(u32) * NIC_RSS_INDIR_SIZE, GFP_KERNEL);
+	if (!nic_dev->rss_indir) {
+		kfree(nic_dev->rss_hkey);
+		nic_dev->rss_hkey = NULL;
+		return -ENOMEM;
+	}
+
+	set_bit(HINIC3_RSS_DEFAULT_INDIR, &nic_dev->flags);
+
+	return 0;
+}
+
+static int hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev,
+				    const u32 *indir_table)
+{
+	struct nic_rss_indirect_tbl_set *indir_tbl;
+	struct hinic3_cmd_buf *cmd_buf;
+	u64 out_param;
+	int err;
+	u32 i;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
+		return -ENOMEM;
+	}
+
+	cmd_buf->size = sizeof(struct nic_rss_indirect_tbl_set);
+	indir_tbl = cmd_buf->buf;
+	memset(indir_tbl, 0, sizeof(*indir_tbl));
+
+	for (i = 0; i < NIC_RSS_INDIR_SIZE; i++)
+		indir_tbl->entry[i] = indir_table[i];
+
+	cmdq_buf_swab32(indir_tbl, sizeof(*indir_tbl));
+
+	err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,
+				      HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE,
+				      cmd_buf, &out_param);
+	if (err || out_param != 0) {
+		dev_err(hwdev->dev, "Failed to set rss indir table\n");
+		err = -EFAULT;
+	}
+
+	hinic3_free_cmd_buf(hwdev, cmd_buf);
+	return err;
+}
+
+static int hinic3_set_rss_type(struct hinic3_hwdev *hwdev,
+			       struct nic_rss_type rss_type)
+{
+	struct hinic3_rss_context_table ctx_tbl;
+	u32 out_size = sizeof(ctx_tbl);
+	u32 ctx;
+	int err;
+
+	memset(&ctx_tbl, 0, sizeof(ctx_tbl));
+	ctx_tbl.func_id = hinic3_global_func_id(hwdev);
+	ctx = HINIC3_RSS_TYPE_SET(1, VALID) |
+	      HINIC3_RSS_TYPE_SET(rss_type.ipv4, IPV4) |
+	      HINIC3_RSS_TYPE_SET(rss_type.ipv6, IPV6) |
+	      HINIC3_RSS_TYPE_SET(rss_type.ipv6_ext, IPV6_EXT) |
+	      HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv4, TCP_IPV4) |
+	      HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv6, TCP_IPV6) |
+	      HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv6_ext, TCP_IPV6_EXT) |
+	      HINIC3_RSS_TYPE_SET(rss_type.udp_ipv4, UDP_IPV4) |
+	      HINIC3_RSS_TYPE_SET(rss_type.udp_ipv6, UDP_IPV6);
+	ctx_tbl.context = ctx;
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_RSS_CTX_TBL_INTO_FUNC,
+				     &ctx_tbl, sizeof(ctx_tbl),
+				     &ctx_tbl, &out_size);
+
+	if (ctx_tbl.msg_head.status == MGMT_CMD_UNSUPPORTED) {
+		return MGMT_CMD_UNSUPPORTED;
+	} else if (err || !out_size || ctx_tbl.msg_head.status) {
+		dev_err(hwdev->dev, "mgmt Failed to set rss context offload, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, ctx_tbl.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_get_rss_type(struct hinic3_hwdev *hwdev,
+			       struct nic_rss_type *rss_type)
+{
+	struct hinic3_rss_context_table ctx_tbl;
+	u32 out_size = sizeof(ctx_tbl);
+	int err;
+
+	memset(&ctx_tbl, 0, sizeof(struct hinic3_rss_context_table));
+	ctx_tbl.func_id = hinic3_global_func_id(hwdev);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_GET_RSS_CTX_TBL,
+				     &ctx_tbl, sizeof(ctx_tbl),
+				     &ctx_tbl, &out_size);
+	if (err || !out_size || ctx_tbl.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to get hash type, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, ctx_tbl.msg_head.status, out_size);
+			return -EINVAL;
+	}
+
+	rss_type->ipv4         = HINIC3_RSS_TYPE_GET(ctx_tbl.context, IPV4);
+	rss_type->ipv6         = HINIC3_RSS_TYPE_GET(ctx_tbl.context, IPV6);
+	rss_type->ipv6_ext     = HINIC3_RSS_TYPE_GET(ctx_tbl.context, IPV6_EXT);
+	rss_type->tcp_ipv4     = HINIC3_RSS_TYPE_GET(ctx_tbl.context, TCP_IPV4);
+	rss_type->tcp_ipv6     = HINIC3_RSS_TYPE_GET(ctx_tbl.context, TCP_IPV6);
+	rss_type->tcp_ipv6_ext = HINIC3_RSS_TYPE_GET(ctx_tbl.context,
+						     TCP_IPV6_EXT);
+	rss_type->udp_ipv4     = HINIC3_RSS_TYPE_GET(ctx_tbl.context, UDP_IPV4);
+	rss_type->udp_ipv6     = HINIC3_RSS_TYPE_GET(ctx_tbl.context, UDP_IPV6);
+
+	return 0;
+}
+
+static int hinic3_rss_cfg_hash_type(struct hinic3_hwdev *hwdev, u8 opcode,
+				    enum hinic3_rss_hash_type *type)
+{
+	struct hinic3_cmd_rss_engine_type hash_type_cmd;
+	u32 out_size = sizeof(hash_type_cmd);
+	int err;
+
+	memset(&hash_type_cmd, 0, sizeof(struct hinic3_cmd_rss_engine_type));
+
+	hash_type_cmd.func_id = hinic3_global_func_id(hwdev);
+	hash_type_cmd.opcode = opcode;
+
+	if (opcode == HINIC3_CMD_OP_SET)
+		hash_type_cmd.hash_engine = *type;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev,
+				     HINIC3_NIC_CMD_CFG_RSS_HASH_ENGINE,
+				     &hash_type_cmd, sizeof(hash_type_cmd),
+				     &hash_type_cmd, &out_size);
+	if (err || !out_size || hash_type_cmd.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to %s hash engine, err: %d, status: 0x%x, out size: 0x%x\n",
+			opcode == HINIC3_CMD_OP_SET ? "set" : "get",
+			err, hash_type_cmd.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	if (opcode == HINIC3_CMD_OP_GET)
+		*type = hash_type_cmd.hash_engine;
+
+	return 0;
+}
+
+static int hinic3_rss_set_hash_type(struct hinic3_hwdev *hwdev,
+				    enum hinic3_rss_hash_type type)
+{
+	return hinic3_rss_cfg_hash_type(hwdev, HINIC3_CMD_OP_SET, &type);
+}
+
+static int hinic3_config_rss_hw_resource(struct net_device *netdev,
+					 u32 *indir_tbl)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, indir_tbl);
+	if (err)
+		return err;
+
+	err = hinic3_set_rss_type(nic_dev->hwdev, nic_dev->rss_type);
+	if (err)
+		return err;
+
+	return hinic3_rss_set_hash_type(nic_dev->hwdev, nic_dev->rss_hash_type);
+}
+
+static int hinic3_rss_cfg_hash_key(struct hinic3_hwdev *hwdev, u8 opcode,
+				   u8 *key)
+{
+	struct hinic3_cmd_rss_hash_key hash_key;
+	u32 out_size = sizeof(hash_key);
+	int err;
+
+	memset(&hash_key, 0, sizeof(struct hinic3_cmd_rss_hash_key));
+	hash_key.func_id = hinic3_global_func_id(hwdev);
+	hash_key.opcode = opcode;
+
+	if (opcode == HINIC3_CMD_OP_SET)
+		memcpy(hash_key.key, key, NIC_RSS_KEY_SIZE);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev,
+				     HINIC3_NIC_CMD_CFG_RSS_HASH_KEY,
+				     &hash_key, sizeof(hash_key),
+				     &hash_key, &out_size);
+	if (err || !out_size || hash_key.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to %s hash key, err: %d, status: 0x%x, out size: 0x%x\n",
+			opcode == HINIC3_CMD_OP_SET ? "set" : "get",
+			err, hash_key.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	if (opcode == HINIC3_CMD_OP_GET)
+		memcpy(key, hash_key.key, NIC_RSS_KEY_SIZE);
+
+	return 0;
+}
+
+static int hinic3_rss_set_hash_key(struct hinic3_hwdev *hwdev, const u8 *key)
+{
+	u8 hash_key[NIC_RSS_KEY_SIZE];
+
+	memcpy(hash_key, key, NIC_RSS_KEY_SIZE);
+	return hinic3_rss_cfg_hash_key(hwdev, HINIC3_CMD_OP_SET, hash_key);
+}
+
+static int hinic3_set_hw_rss_parameters(struct net_device *netdev, u8 rss_en)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	err = hinic3_rss_set_hash_key(nic_dev->hwdev, nic_dev->rss_hkey);
+	if (err)
+		return err;
+
+	hinic3_maybe_reconfig_rss_indir(netdev);
+
+	if (test_bit(HINIC3_RSS_DEFAULT_INDIR, &nic_dev->flags))
+		hinic3_fillout_indir_tbl(netdev, nic_dev->rss_indir);
+
+	err = hinic3_config_rss_hw_resource(netdev, nic_dev->rss_indir);
+	if (err)
+		return err;
+
+	err = hinic3_rss_cfg(nic_dev->hwdev, rss_en, nic_dev->q_params.num_qps);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int hinic3_rss_init(struct net_device *netdev)
+{
+	return hinic3_set_hw_rss_parameters(netdev, 1);
+}
+
+void hinic3_rss_deinit(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	hinic3_rss_cfg(nic_dev->hwdev, 0, 0);
+}
+
+void hinic3_clear_rss_config(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	kfree(nic_dev->rss_hkey);
+	nic_dev->rss_hkey = NULL;
+
+	kfree(nic_dev->rss_indir);
+	nic_dev->rss_indir = NULL;
+}
+
+void hinic3_try_to_enable_rss(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	int err;
+
+	nic_dev->max_qps = hinic3_func_max_qnum(hwdev);
+	if (nic_dev->max_qps <= 1 || !hinic3_test_support(nic_dev, NIC_F_RSS))
+		goto set_q_params;
+
+	err = alloc_rss_resource(netdev);
+	if (err) {
+		nic_dev->max_qps = 1;
+		goto set_q_params;
+	}
+
+	set_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
+	nic_dev->max_qps = hinic3_func_max_qnum(hwdev);
+
+	decide_num_qps(netdev);
+
+	hinic3_init_rss_parameters(netdev);
+	err = hinic3_set_hw_rss_parameters(netdev, 0);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set hardware rss parameters\n");
+
+		hinic3_clear_rss_config(netdev);
+		nic_dev->max_qps = 1;
+		goto set_q_params;
+	}
+	return;
+
+set_q_params:
+	clear_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
+	nic_dev->q_params.num_qps = nic_dev->max_qps;
+}
+
+static int set_l4_rss_hash_ops(const struct ethtool_rxnfc *cmd,
+			       struct nic_rss_type *rss_type)
+{
+	u8 rss_l4_en;
+
+	switch (cmd->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
+	case 0:
+		rss_l4_en = 0;
+		break;
+	case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
+		rss_l4_en = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (cmd->flow_type) {
+	case TCP_V4_FLOW:
+		rss_type->tcp_ipv4 = rss_l4_en;
+		break;
+	case TCP_V6_FLOW:
+		rss_type->tcp_ipv6 = rss_l4_en;
+		break;
+	case UDP_V4_FLOW:
+		rss_type->udp_ipv4 = rss_l4_en;
+		break;
+	case UDP_V6_FLOW:
+		rss_type->udp_ipv6 = rss_l4_en;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int update_rss_hash_opts(struct net_device *netdev,
+				struct ethtool_rxnfc *cmd,
+				struct nic_rss_type *rss_type)
+{
+	int err;
+
+	switch (cmd->flow_type) {
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
+		err = set_l4_rss_hash_ops(cmd, rss_type);
+		if (err)
+			return err;
+
+		break;
+	case IPV4_FLOW:
+		rss_type->ipv4 = 1;
+		break;
+	case IPV6_FLOW:
+		rss_type->ipv6 = 1;
+		break;
+	default:
+		netdev_err(netdev, "Unsupported flow type\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_rss_hash_opts(struct net_device *netdev, struct ethtool_rxnfc *cmd)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct nic_rss_type *rss_type = &nic_dev->rss_type;
+	int err;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags)) {
+		cmd->data = 0;
+		netdev_err(netdev, "RSS is disable, not support to set flow-hash\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* RSS only supports hashing of IP addresses and L4 ports */
+	if (cmd->data & ~(RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 |
+		RXH_L4_B_2_3))
+		return -EINVAL;
+
+	/* Both IP addresses must be part of the hash tuple */
+	if (!(cmd->data & RXH_IP_SRC) || !(cmd->data & RXH_IP_DST))
+		return -EINVAL;
+
+	err = hinic3_get_rss_type(nic_dev->hwdev, rss_type);
+	if (err) {
+		netdev_err(netdev, "Failed to get rss type\n");
+		return -EFAULT;
+	}
+
+	err = update_rss_hash_opts(netdev, cmd, rss_type);
+	if (err)
+		return err;
+
+	err = hinic3_set_rss_type(nic_dev->hwdev, *rss_type);
+	if (err) {
+		netdev_err(netdev, "Failed to set rss type\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static void convert_rss_type(u8 rss_opt, struct ethtool_rxnfc *cmd)
+{
+	if (rss_opt)
+		cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
+}
+
+static int hinic3_convert_rss_type(struct net_device *netdev,
+				   struct nic_rss_type *rss_type,
+				   struct ethtool_rxnfc *cmd)
+{
+	cmd->data = RXH_IP_SRC | RXH_IP_DST;
+	switch (cmd->flow_type) {
+	case TCP_V4_FLOW:
+		convert_rss_type(rss_type->tcp_ipv4, cmd);
+		break;
+	case TCP_V6_FLOW:
+		convert_rss_type(rss_type->tcp_ipv6, cmd);
+		break;
+	case UDP_V4_FLOW:
+		convert_rss_type(rss_type->udp_ipv4, cmd);
+		break;
+	case UDP_V6_FLOW:
+		convert_rss_type(rss_type->udp_ipv6, cmd);
+		break;
+	case IPV4_FLOW:
+	case IPV6_FLOW:
+		break;
+	default:
+		netdev_err(netdev, "Unsupported flow type\n");
+		cmd->data = 0;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_get_rss_hash_opts(struct net_device *netdev, struct ethtool_rxnfc *cmd)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct nic_rss_type rss_type;
+	int err;
+
+	cmd->data = 0;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags))
+		return 0;
+
+	err = hinic3_get_rss_type(nic_dev->hwdev, &rss_type);
+	if (err) {
+		netdev_err(netdev, "Failed to get rss type\n");
+		return err;
+	}
+
+	return hinic3_convert_rss_type(netdev, &rss_type, cmd);
+}
+
+int hinic3_get_rxnfc(struct net_device *netdev,
+		     struct ethtool_rxnfc *cmd, u32 *rule_locs)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err = 0;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_GRXRINGS:
+		cmd->data = nic_dev->q_params.num_qps;
+		break;
+	case ETHTOOL_GRXFH:
+		err = hinic3_get_rss_hash_opts(netdev, cmd);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+int hinic3_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
+{
+	int err;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_SRXFH:
+		err = hinic3_set_rss_hash_opts(netdev, cmd);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static u16 hinic3_max_channels(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u8 tcs = netdev_get_num_tc(netdev);
+
+	return tcs ? nic_dev->max_qps / tcs : nic_dev->max_qps;
+}
+
+static u16 hinic3_curr_channels(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		return nic_dev->q_params.num_qps ?
+				nic_dev->q_params.num_qps : 1;
+	else
+		return min_t(u16, hinic3_max_channels(netdev),
+			     nic_dev->q_params.num_qps);
+}
+
+void hinic3_get_channels(struct net_device *netdev,
+			 struct ethtool_channels *channels)
+{
+	channels->max_rx = 0;
+	channels->max_tx = 0;
+	channels->max_other = 0;
+	/* report maximum channels */
+	channels->max_combined = hinic3_max_channels(netdev);
+	channels->rx_count = 0;
+	channels->tx_count = 0;
+	channels->other_count = 0;
+	/* report flow director queues as maximum channels */
+	channels->combined_count = hinic3_curr_channels(netdev);
+}
+
+static int hinic3_validate_channel_parameter(struct net_device *netdev,
+					     const struct ethtool_channels *channels)
+{
+	u16 max_channel = hinic3_max_channels(netdev);
+	unsigned int count = channels->combined_count;
+
+	if (!count) {
+		netdev_err(netdev, "Unsupported combined_count=0\n");
+		return -EINVAL;
+	}
+
+	if (channels->tx_count || channels->rx_count || channels->other_count) {
+		netdev_err(netdev, "Setting rx/tx/other count not supported\n");
+		return -EINVAL;
+	}
+
+	if (count > max_channel) {
+		netdev_err(netdev, "Combined count %u exceed limit %u\n", count,
+			   max_channel);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void change_num_channel_reopen_handler(struct net_device *netdev)
+{
+	hinic3_set_default_rss_indir(netdev);
+}
+
+int hinic3_set_channels(struct net_device *netdev,
+			struct ethtool_channels *channels)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	unsigned int count = channels->combined_count;
+	struct hinic3_dyna_txrxq_params q_params;
+	int err;
+
+	if (hinic3_validate_channel_parameter(netdev, channels))
+		return -EINVAL;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags)) {
+		netdev_err(netdev, "This function doesn't support RSS, only support 1 queue pair\n");
+		return -EOPNOTSUPP;
+	}
+
+	netdev_dbg(netdev, "Set max combined queue number from %u to %u\n",
+		   nic_dev->q_params.num_qps, count);
+
+	if (netif_running(netdev)) {
+		q_params = nic_dev->q_params;
+		q_params.num_qps = (u16)count;
+		q_params.txqs_res = NULL;
+		q_params.rxqs_res = NULL;
+		q_params.irq_cfg = NULL;
+
+		err = hinic3_change_channel_settings(netdev, &q_params,
+						     change_num_channel_reopen_handler);
+		if (err) {
+			netdev_err(netdev, "Failed to change channel settings\n");
+			return -EFAULT;
+		}
+	} else {
+		/* Discard user configured rss */
+		hinic3_set_default_rss_indir(netdev);
+		nic_dev->q_params.num_qps = (u16)count;
+	}
+
+	return 0;
+}
+
+u32 hinic3_get_rxfh_indir_size(struct net_device *netdev)
+{
+	return NIC_RSS_INDIR_SIZE;
+}
+
+static int set_rss_rxfh(struct net_device *netdev, const u32 *indir,
+			const u8 *key)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	if (indir) {
+		err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, indir);
+		if (err) {
+			netdev_err(netdev, "Failed to set rss indir table\n");
+			return -EFAULT;
+		}
+		clear_bit(HINIC3_RSS_DEFAULT_INDIR, &nic_dev->flags);
+
+		memcpy(nic_dev->rss_indir, indir, sizeof(u32) * NIC_RSS_INDIR_SIZE);
+	}
+
+	if (key) {
+		err = hinic3_rss_set_hash_key(nic_dev->hwdev, key);
+		if (err) {
+			netdev_err(netdev, "Failed to set rss key\n");
+			return -EFAULT;
+		}
+
+		memcpy(nic_dev->rss_hkey, key, NIC_RSS_KEY_SIZE);
+	}
+
+	return 0;
+}
+
+u32 hinic3_get_rxfh_key_size(struct net_device *netdev)
+{
+	return NIC_RSS_KEY_SIZE;
+}
+
+static int hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev, u32 *indir_table)
+{
+	struct hinic3_cmd_buf_pair pair;
+	u16 *indir_tbl;
+	int err, i;
+
+	err = hinic3_cmd_buf_pair_init(hwdev, &pair);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate cmd_buf.\n");
+		return -ENOMEM;
+	}
+
+	err = hinic3_cmdq_detail_resp(hwdev, HINIC3_MOD_L2NIC,
+				      HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE,
+				      pair.in, pair.out, NULL);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to get rss indir table\n");
+		goto err_get_indir_tbl;
+	}
+
+	indir_tbl = ((struct nic_rss_indirect_tbl_get *)(pair.out->buf))->entry;
+	for (i = 0; i < NIC_RSS_INDIR_SIZE; i++)
+		indir_table[i] = *(indir_tbl + i);
+
+err_get_indir_tbl:
+	hinic3_cmd_buf_pair_uninit(hwdev, &pair);
+
+	return err;
+}
+
+int hinic3_get_rxfh(struct net_device *netdev,
+		    struct ethtool_rxfh_param *rxfh)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err = 0;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags)) {
+		netdev_err(netdev, "Rss is disabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	rxfh->hfunc =
+		nic_dev->rss_hash_type == HINIC3_RSS_HASH_ENGINE_TYPE_XOR ?
+		ETH_RSS_HASH_XOR : ETH_RSS_HASH_TOP;
+
+	if (rxfh->indir) {
+		err = hinic3_rss_get_indir_tbl(nic_dev->hwdev, rxfh->indir);
+		if (err)
+			return -EFAULT;
+	}
+
+	if (rxfh->key)
+		memcpy(rxfh->key, nic_dev->rss_hkey, NIC_RSS_KEY_SIZE);
+
+	return err;
+}
+
+static int update_hash_func_type(struct net_device *netdev, u8 hfunc)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	enum hinic3_rss_hash_type new_rss_hash_type;
+
+	switch (hfunc) {
+	case ETH_RSS_HASH_NO_CHANGE:
+		return 0;
+	case ETH_RSS_HASH_XOR:
+		new_rss_hash_type = HINIC3_RSS_HASH_ENGINE_TYPE_XOR;
+		break;
+	case ETH_RSS_HASH_TOP:
+		new_rss_hash_type = HINIC3_RSS_HASH_ENGINE_TYPE_TOEP;
+		break;
+	default:
+		netdev_err(netdev, "Unsupported hash func %u\n", hfunc);
+		return -EOPNOTSUPP;
+	}
+
+	if (new_rss_hash_type == nic_dev->rss_hash_type)
+		return 0;
+
+	nic_dev->rss_hash_type = new_rss_hash_type;
+	return hinic3_rss_set_hash_type(nic_dev->hwdev, nic_dev->rss_hash_type);
+}
+
+int hinic3_set_rxfh(struct net_device *netdev,
+		    struct ethtool_rxfh_param *rxfh,
+		    struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags)) {
+		netdev_err(netdev, "Not support to set rss parameters when rss is disable\n");
+		return -EOPNOTSUPP;
+	}
+
+	err = update_hash_func_type(netdev, rxfh->hfunc);
+	if (err)
+		return err;
+
+	err = set_rss_rxfh(netdev, rxfh->indir, rxfh->key);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
new file mode 100644
index 000000000000..ee631e3b03b7
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_RSS_H
+#define HINIC3_RSS_H
+
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+
+int hinic3_rss_init(struct net_device *netdev);
+void hinic3_rss_deinit(struct net_device *netdev);
+void hinic3_try_to_enable_rss(struct net_device *netdev);
+void hinic3_clear_rss_config(struct net_device *netdev);
+
+int hinic3_get_rxnfc(struct net_device *netdev,
+		     struct ethtool_rxnfc *cmd, u32 *rule_locs);
+int hinic3_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd);
+
+void hinic3_get_channels(struct net_device *netdev,
+			 struct ethtool_channels *channels);
+int hinic3_set_channels(struct net_device *netdev,
+			struct ethtool_channels *channels);
+
+u32 hinic3_get_rxfh_indir_size(struct net_device *netdev);
+u32 hinic3_get_rxfh_key_size(struct net_device *netdev);
+
+int hinic3_get_rxfh(struct net_device *netdev,
+		    struct ethtool_rxfh_param *rxfh);
+int hinic3_set_rxfh(struct net_device *netdev,
+		    struct ethtool_rxfh_param *rxfh,
+		    struct netlink_ext_ack *extack);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
new file mode 100644
index 000000000000..0b153995a2ea
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -0,0 +1,735 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/skbuff.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/u64_stats_sync.h>
+
+#include "hinic3_nic_dev.h"
+#include "hinic3_rx.h"
+
+#define HINIC3_RX_HDR_SIZE              256
+#define HINIC3_RX_BUFFER_WRITE          16
+
+#define HINIC3_RX_TCP_PKT               0x3
+#define HINIC3_RX_UDP_PKT               0x4
+#define HINIC3_RX_SCTP_PKT              0x7
+
+#define HINIC3_RX_IPV4_PKT              0
+#define HINIC3_RX_IPV6_PKT              1
+#define HINIC3_RX_INVALID_IP_TYPE       2
+
+#define HINIC3_RX_PKT_FORMAT_NON_TUNNEL 0
+#define HINIC3_RX_PKT_FORMAT_VXLAN      1
+
+#define RXQ_STATS_INC(rxq, field) \
+do { \
+	u64_stats_update_begin(&(rxq)->rxq_stats.syncp); \
+	(rxq)->rxq_stats.field++; \
+	u64_stats_update_end(&(rxq)->rxq_stats.syncp); \
+} while (0)
+
+static void hinic3_rxq_clean_stats(struct hinic3_rxq_stats *rxq_stats)
+{
+	u64_stats_update_begin(&rxq_stats->syncp);
+	rxq_stats->bytes = 0;
+	rxq_stats->packets = 0;
+	rxq_stats->errors = 0;
+	rxq_stats->csum_errors = 0;
+	rxq_stats->other_errors = 0;
+	rxq_stats->dropped = 0;
+	rxq_stats->rx_buf_empty = 0;
+
+	rxq_stats->alloc_skb_err = 0;
+	rxq_stats->alloc_rx_buf_err = 0;
+	rxq_stats->restore_drop_sge = 0;
+	u64_stats_update_end(&rxq_stats->syncp);
+}
+
+static void rxq_stats_init(struct hinic3_rxq *rxq)
+{
+	struct hinic3_rxq_stats *rxq_stats = &rxq->rxq_stats;
+
+	u64_stats_init(&rxq_stats->syncp);
+	hinic3_rxq_clean_stats(rxq_stats);
+}
+
+int hinic3_alloc_rxqs(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct pci_dev *pdev = nic_dev->pdev;
+	u16 num_rxqs = nic_dev->max_qps;
+	struct hinic3_rxq *rxq;
+	u64 rxq_size;
+	u16 q_id;
+
+	rxq_size = num_rxqs * sizeof(*nic_dev->rxqs);
+	if (!rxq_size) {
+		dev_err(hwdev->dev, "Cannot allocate zero size rxqs\n");
+		return -EINVAL;
+	}
+
+	nic_dev->rxqs = kzalloc(rxq_size, GFP_KERNEL);
+	if (!nic_dev->rxqs)
+		return -ENOMEM;
+
+	for (q_id = 0; q_id < num_rxqs; q_id++) {
+		rxq = &nic_dev->rxqs[q_id];
+		rxq->netdev = netdev;
+		rxq->dev = &pdev->dev;
+		rxq->q_id = q_id;
+		rxq->buf_len = nic_dev->rx_buff_len;
+		rxq->rx_buff_shift = ilog2(nic_dev->rx_buff_len);
+		rxq->dma_rx_buff_size = nic_dev->dma_rx_buff_size;
+		rxq->q_depth = nic_dev->q_params.rq_depth;
+		rxq->q_mask = nic_dev->q_params.rq_depth - 1;
+
+		rxq_stats_init(rxq);
+	}
+
+	return 0;
+}
+
+void hinic3_free_rxqs(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	kfree(nic_dev->rxqs);
+}
+
+static int rx_alloc_mapped_page(struct net_device *netdev, struct hinic3_rx_info *rx_info)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	dma_addr_t dma = rx_info->buf_dma_addr;
+	struct pci_dev *pdev = nic_dev->pdev;
+	struct page *page = rx_info->page;
+
+	if (likely(dma))
+		return 0;
+
+	page = alloc_pages_node(NUMA_NO_NODE, GFP_ATOMIC | __GFP_COMP,
+				nic_dev->page_order);
+	if (unlikely(!page))
+		return -ENOMEM;
+
+	dma = dma_map_page(&pdev->dev, page, 0, nic_dev->dma_rx_buff_size,
+			   DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(&pdev->dev, dma))) {
+		__free_pages(page, nic_dev->page_order);
+		return -ENOMEM;
+	}
+
+	rx_info->page = page;
+	rx_info->buf_dma_addr = dma;
+	rx_info->page_offset = 0;
+
+	return 0;
+}
+
+/* Associate fixed completion element to every wqe in the rq. Every rq wqe will
+ * always post completion to the same place.
+ */
+static void rq_associate_cqes(struct hinic3_rxq *rxq)
+{
+	struct hinic3_queue_pages *qpages;
+	struct hinic3_rq_wqe *rq_wqe;
+	dma_addr_t cqe_dma;
+	int cqe_len;
+	u32 i;
+
+	/* unit of cqe length is 16B */
+	cqe_len = sizeof(struct hinic3_rq_cqe) >> HINIC3_CQE_SIZE_SHIFT;
+	qpages = &rxq->rq->wq.qpages;
+
+	for (i = 0; i < rxq->q_depth; i++) {
+		rq_wqe = get_q_element(qpages, i, NULL);
+		cqe_dma = rxq->cqe_start_paddr + i * sizeof(struct hinic3_rq_cqe);
+		rq_wqe->cqe_hi_addr = upper_32_bits(cqe_dma);
+		rq_wqe->cqe_lo_addr = lower_32_bits(cqe_dma);
+	}
+}
+
+static void rq_wqe_buff_set(struct hinic3_io_queue *rq, uint32_t wqe_idx,
+			    dma_addr_t dma_addr, u16 len)
+{
+	struct hinic3_rq_wqe *rq_wqe;
+
+	rq_wqe = get_q_element(&rq->wq.qpages, wqe_idx, NULL);
+	rq_wqe->buf_hi_addr = upper_32_bits(dma_addr);
+	rq_wqe->buf_lo_addr = lower_32_bits(dma_addr);
+}
+
+static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
+{
+	struct net_device *netdev = rxq->netdev;
+	u32 i, free_wqebbs = rxq->delta - 1;
+	struct hinic3_nic_dev *nic_dev;
+	struct hinic3_rx_info *rx_info;
+	dma_addr_t dma_addr;
+	int err;
+
+	nic_dev = netdev_priv(netdev);
+	for (i = 0; i < free_wqebbs; i++) {
+		rx_info = &rxq->rx_info[rxq->next_to_update];
+
+		err = rx_alloc_mapped_page(netdev, rx_info);
+		if (unlikely(err)) {
+			RXQ_STATS_INC(rxq, alloc_rx_buf_err);
+			break;
+		}
+
+		dma_addr = rx_info->buf_dma_addr + rx_info->page_offset;
+		rq_wqe_buff_set(rxq->rq, rxq->next_to_update, dma_addr,
+				nic_dev->rx_buff_len);
+		rxq->next_to_update = (u16)((rxq->next_to_update + 1) & rxq->q_mask);
+	}
+
+	if (likely(i)) {
+		hinic3_write_db(rxq->rq, rxq->q_id & 3, RQ_CFLAG_DP,
+				rxq->next_to_update << HINIC3_NORMAL_RQ_WQE);
+		rxq->delta -= i;
+		rxq->next_to_alloc = rxq->next_to_update;
+	} else if (free_wqebbs == rxq->q_depth - 1) {
+		RXQ_STATS_INC(rxq, rx_buf_empty);
+	}
+
+	return i;
+}
+
+static u32 hinic3_rx_alloc_buffers(struct net_device *netdev, u32 rq_depth,
+				   struct hinic3_rx_info *rx_info_arr)
+{
+	u32 free_wqebbs = rq_depth - 1;
+	u32 idx;
+	int err;
+
+	for (idx = 0; idx < free_wqebbs; idx++) {
+		err = rx_alloc_mapped_page(netdev, &rx_info_arr[idx]);
+		if (err)
+			break;
+	}
+
+	return idx;
+}
+
+static void hinic3_rx_free_buffers(struct net_device *netdev, u32 q_depth,
+				   struct hinic3_rx_info *rx_info_arr)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_rx_info *rx_info;
+	u32 i;
+
+	/* Free all the Rx ring sk_buffs */
+	for (i = 0; i < q_depth; i++) {
+		rx_info = &rx_info_arr[i];
+
+		if (rx_info->buf_dma_addr) {
+			dma_unmap_page(&nic_dev->pdev->dev,
+				       rx_info->buf_dma_addr,
+				       nic_dev->dma_rx_buff_size,
+				       DMA_FROM_DEVICE);
+			rx_info->buf_dma_addr = 0;
+		}
+
+		if (rx_info->page) {
+			__free_pages(rx_info->page, nic_dev->page_order);
+			rx_info->page = NULL;
+		}
+	}
+}
+
+static void hinic3_reuse_rx_page(struct hinic3_rxq *rxq,
+				 struct hinic3_rx_info *old_rx_info)
+{
+	struct hinic3_rx_info *new_rx_info;
+	u16 nta = rxq->next_to_alloc;
+
+	new_rx_info = &rxq->rx_info[nta];
+
+	/* update, and store next to alloc */
+	nta++;
+	rxq->next_to_alloc = (nta < rxq->q_depth) ? nta : 0;
+
+	new_rx_info->page = old_rx_info->page;
+	new_rx_info->page_offset = old_rx_info->page_offset;
+	new_rx_info->buf_dma_addr = old_rx_info->buf_dma_addr;
+
+	/* sync the buffer for use by the device */
+	dma_sync_single_range_for_device(rxq->dev, new_rx_info->buf_dma_addr,
+					 new_rx_info->page_offset,
+					 rxq->buf_len,
+					 DMA_FROM_DEVICE);
+}
+
+static void hinic3_add_rx_frag(struct hinic3_rxq *rxq,
+			       struct hinic3_rx_info *rx_info,
+			       struct sk_buff *skb, u32 size)
+{
+	struct page *page;
+	u8 *va;
+
+	page = rx_info->page;
+	va = (u8 *)page_address(page) + rx_info->page_offset;
+	prefetch(va);
+
+	dma_sync_single_range_for_cpu(rxq->dev,
+				      rx_info->buf_dma_addr,
+				      rx_info->page_offset,
+				      rxq->buf_len,
+				      DMA_FROM_DEVICE);
+
+	if (size <= HINIC3_RX_HDR_SIZE && !skb_is_nonlinear(skb)) {
+		memcpy(__skb_put(skb, size), va,
+		       ALIGN(size, sizeof(long)));
+
+		/* page is not reserved, we can reuse buffer as-is */
+		if (likely(page_to_nid(page) == numa_node_id()))
+			goto reuse_rx_page;
+
+		/* this page cannot be reused so discard it */
+		put_page(page);
+		goto err_reuse_buffer;
+	}
+
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
+			rx_info->page_offset, size, rxq->buf_len);
+
+	/* avoid re-using remote pages */
+	if (unlikely(page_to_nid(page) != numa_node_id()))
+		goto err_reuse_buffer;
+
+	/* if we are the only owner of the page we can reuse it */
+	if (unlikely(page_count(page) != 1))
+		goto err_reuse_buffer;
+
+	/* flip page offset to other buffer */
+	rx_info->page_offset ^= rxq->buf_len;
+	get_page(page);
+
+reuse_rx_page:
+	hinic3_reuse_rx_page(rxq, rx_info);
+	return;
+
+err_reuse_buffer:
+	/* we are not reusing the buffer so unmap it */
+	dma_unmap_page(rxq->dev, rx_info->buf_dma_addr, rxq->dma_rx_buff_size, DMA_FROM_DEVICE);
+}
+
+static void packaging_skb(struct hinic3_rxq *rxq, struct sk_buff *skb,
+			  u32 sge_num, u32 pkt_len)
+{
+	struct hinic3_rx_info *rx_info;
+	u32 temp_pkt_len = pkt_len;
+	u32 temp_sge_num = sge_num;
+	u8 frag_num = 0;
+	u32 sw_ci;
+	u32 size;
+
+	sw_ci = rxq->cons_idx & rxq->q_mask;
+	while (temp_sge_num) {
+		rx_info = &rxq->rx_info[sw_ci];
+		sw_ci = (sw_ci + 1) & rxq->q_mask;
+		if (unlikely(temp_pkt_len > rxq->buf_len)) {
+			size = rxq->buf_len;
+			temp_pkt_len -= rxq->buf_len;
+		} else {
+			size = temp_pkt_len;
+		}
+
+		hinic3_add_rx_frag(rxq, rx_info, skb, size);
+
+		/* clear contents of buffer_info */
+		rx_info->buf_dma_addr = 0;
+		rx_info->page = NULL;
+		temp_sge_num--;
+		frag_num++;
+	}
+}
+
+static u32 hinic3_get_sge_num(struct hinic3_rxq *rxq, u32 pkt_len)
+{
+	u32 sge_num;
+
+	sge_num = pkt_len >> rxq->rx_buff_shift;
+	sge_num += (pkt_len & (rxq->buf_len - 1)) ? 1 : 0;
+
+	return sge_num;
+}
+
+static struct sk_buff *hinic3_fetch_rx_buffer(struct hinic3_rxq *rxq,
+					      u32 pkt_len)
+{
+	struct net_device *netdev = rxq->netdev;
+	struct sk_buff *skb;
+	u32 sge_num;
+
+	skb = netdev_alloc_skb_ip_align(netdev, HINIC3_RX_HDR_SIZE);
+	if (unlikely(!skb))
+		return NULL;
+
+	sge_num = hinic3_get_sge_num(rxq, pkt_len);
+
+	prefetchw(skb->data);
+	packaging_skb(rxq, skb, sge_num, pkt_len);
+
+	rxq->cons_idx += sge_num;
+	rxq->delta += sge_num;
+
+	return skb;
+}
+
+static void hinic3_pull_tail(struct sk_buff *skb)
+{
+	skb_frag_t *frag = &skb_shinfo(skb)->frags[0];
+	unsigned int pull_len;
+	unsigned char *va;
+
+	va = skb_frag_address(frag);
+
+	/* we need the header to contain the greater of either ETH_HLEN or
+	 * 60 bytes if the skb->len is less than 60 for skb_pad.
+	 */
+	pull_len = eth_get_headlen(skb->dev, va, HINIC3_RX_HDR_SIZE);
+
+	/* align pull length to size of long to optimize memcpy performance */
+	skb_copy_to_linear_data(skb, va, ALIGN(pull_len, sizeof(long)));
+
+	/* update all of the pointers */
+	skb_frag_size_sub(frag, pull_len);
+	skb_frag_off_add(frag, pull_len);
+
+	skb->data_len -= pull_len;
+	skb->tail += pull_len;
+}
+
+static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,
+			   u32 status, struct sk_buff *skb)
+{
+	u32 pkt_fmt = HINIC3_GET_RX_TUNNEL_PKT_FORMAT(offload_type);
+	u32 pkt_type = HINIC3_GET_RX_PKT_TYPE(offload_type);
+	u32 ip_type = HINIC3_GET_RX_IP_TYPE(offload_type);
+	struct net_device *netdev = rxq->netdev;
+
+	u32 csum_err;
+
+	csum_err = HINIC3_GET_RX_CSUM_ERR(status);
+	if (unlikely(csum_err == HINIC3_RX_CSUM_IPSU_OTHER_ERR))
+		rxq->rxq_stats.other_errors++;
+
+	if (!(netdev->features & NETIF_F_RXCSUM))
+		return;
+
+	if (unlikely(csum_err)) {
+		/* pkt type is recognized by HW, and csum is wrong */
+		if (!(csum_err & (HINIC3_RX_CSUM_HW_CHECK_NONE |
+				  HINIC3_RX_CSUM_IPSU_OTHER_ERR)))
+			rxq->rxq_stats.csum_errors++;
+		skb->ip_summed = CHECKSUM_NONE;
+		return;
+	}
+
+	if (ip_type == HINIC3_RX_INVALID_IP_TYPE ||
+	    !(pkt_fmt == HINIC3_RX_PKT_FORMAT_NON_TUNNEL ||
+	      pkt_fmt == HINIC3_RX_PKT_FORMAT_VXLAN)) {
+		skb->ip_summed = CHECKSUM_NONE;
+		return;
+	}
+
+	switch (pkt_type) {
+	case HINIC3_RX_TCP_PKT:
+	case HINIC3_RX_UDP_PKT:
+	case HINIC3_RX_SCTP_PKT:
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		break;
+	default:
+		skb->ip_summed = CHECKSUM_NONE;
+		break;
+	}
+}
+
+static void hinic3_rx_gro(struct hinic3_rxq *rxq, u32 offload_type,
+			  struct sk_buff *skb)
+{
+	struct net_device *netdev = rxq->netdev;
+	bool l2_tunnel;
+
+	if (!(netdev->features & NETIF_F_GRO))
+		return;
+
+	l2_tunnel =
+		HINIC3_GET_RX_TUNNEL_PKT_FORMAT(offload_type) ==
+		HINIC3_RX_PKT_FORMAT_VXLAN ? 1 : 0;
+	if (l2_tunnel && skb->ip_summed == CHECKSUM_UNNECESSARY) {
+		/* If we checked the outer header let the stack know */
+		skb->csum_level = 1;
+	}
+}
+
+static void hinic3_lro_set_gso_params(struct sk_buff *skb, u16 num_lro)
+{
+	struct ethhdr *eth = (struct ethhdr *)(skb->data);
+	__be16 proto;
+
+	proto = __vlan_get_protocol(skb, eth->h_proto, NULL);
+
+	skb_shinfo(skb)->gso_size = (u16)DIV_ROUND_UP((skb->len - skb_headlen(skb)), num_lro);
+	skb_shinfo(skb)->gso_type = (proto == htons(ETH_P_IP)) ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+	skb_shinfo(skb)->gso_segs = num_lro;
+}
+
+static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_cqe,
+			u32 pkt_len, u32 vlan_len, u32 status)
+{
+	struct net_device *netdev = rxq->netdev;
+	struct hinic3_nic_dev *nic_dev;
+	struct sk_buff *skb;
+	u32 offload_type;
+	u16 num_lro;
+
+	nic_dev = netdev_priv(netdev);
+
+	skb = hinic3_fetch_rx_buffer(rxq, pkt_len);
+	if (unlikely(!skb)) {
+		RXQ_STATS_INC(rxq, alloc_skb_err);
+		return -ENOMEM;
+	}
+
+	/* place header in linear portion of buffer */
+	if (skb_is_nonlinear(skb))
+		hinic3_pull_tail(skb);
+
+	offload_type = rx_cqe->offload_type;
+	hinic3_rx_csum(rxq, offload_type, status, skb);
+	hinic3_rx_gro(rxq, offload_type, skb);
+
+	if ((netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
+	    HINIC3_GET_RX_VLAN_OFFLOAD_EN(offload_type)) {
+		u16 vid = HINIC3_GET_RX_VLAN_TAG(vlan_len);
+
+		/* if the packet is a vlan pkt, the vid may be 0 */
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+	}
+
+	num_lro = HINIC3_GET_RX_NUM_LRO(status);
+	if (num_lro)
+		hinic3_lro_set_gso_params(skb, num_lro);
+
+	skb_record_rx_queue(skb, rxq->q_id);
+	skb->protocol = eth_type_trans(skb, netdev);
+
+	if (skb_has_frag_list(skb)) {
+		napi_gro_flush(&rxq->irq_cfg->napi, false);
+		netif_receive_skb(skb);
+	} else {
+		napi_gro_receive(&rxq->irq_cfg->napi, skb);
+	}
+
+	return 0;
+}
+
+int hinic3_alloc_rxqs_res(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res)
+{
+	u64 cqe_mem_size = sizeof(struct hinic3_rq_cqe) * rq_depth;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_rxq_res *rqres;
+	u32 pkt_idx;
+	int idx, i;
+	u64 size;
+
+	for (idx = 0; idx < num_rq; idx++) {
+		rqres = &rxqs_res[idx];
+		size = sizeof(*rqres->rx_info) * rq_depth;
+		rqres->rx_info = kzalloc(size, GFP_KERNEL);
+		if (!rqres->rx_info)
+			goto err_out;
+
+		rqres->cqe_start_vaddr = dma_alloc_coherent(&nic_dev->pdev->dev, cqe_mem_size,
+							    &rqres->cqe_start_paddr,
+							    GFP_KERNEL);
+		if (!rqres->cqe_start_vaddr) {
+			kfree(rqres->rx_info);
+			goto err_out;
+		}
+
+		pkt_idx = hinic3_rx_alloc_buffers(netdev, rq_depth, rqres->rx_info);
+		if (!pkt_idx) {
+			dma_free_coherent(&nic_dev->pdev->dev, cqe_mem_size,
+					  rqres->cqe_start_vaddr,
+					  rqres->cqe_start_paddr);
+			kfree(rqres->rx_info);
+			netdev_err(netdev, "Failed to alloc rxq%d rx buffers\n", idx);
+			goto err_out;
+		}
+		rqres->next_to_alloc = (u16)pkt_idx;
+	}
+	return 0;
+
+err_out:
+	for (i = 0; i < idx; i++) {
+		rqres = &rxqs_res[i];
+
+		hinic3_rx_free_buffers(netdev, rq_depth, rqres->rx_info);
+		dma_free_coherent(&nic_dev->pdev->dev, cqe_mem_size,
+				  rqres->cqe_start_vaddr,
+				  rqres->cqe_start_paddr);
+		kfree(rqres->rx_info);
+	}
+
+	return -ENOMEM;
+}
+
+void hinic3_free_rxqs_res(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res)
+{
+	u64 cqe_mem_size = sizeof(struct hinic3_rq_cqe) * rq_depth;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_rxq_res *rqres;
+	int idx;
+
+	for (idx = 0; idx < num_rq; idx++) {
+		rqres = &rxqs_res[idx];
+
+		hinic3_rx_free_buffers(netdev, rq_depth, rqres->rx_info);
+		dma_free_coherent(&nic_dev->pdev->dev, cqe_mem_size,
+				  rqres->cqe_start_vaddr,
+				  rqres->cqe_start_paddr);
+		kfree(rqres->rx_info);
+	}
+}
+
+int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_rxq_res *rqres;
+	struct irq_info *msix_entry;
+	struct hinic3_rxq *rxq;
+	u16 q_id;
+	u32 pkts;
+
+	for (q_id = 0; q_id < num_rq; q_id++) {
+		rxq = &nic_dev->rxqs[q_id];
+		rqres = &rxqs_res[q_id];
+		msix_entry = &nic_dev->qps_irq_info[q_id];
+
+		rxq->irq_id = msix_entry->irq_id;
+		rxq->msix_entry_idx = msix_entry->msix_entry_idx;
+		rxq->next_to_update = 0;
+		rxq->next_to_alloc = rqres->next_to_alloc;
+		rxq->q_depth = rq_depth;
+		rxq->delta = rxq->q_depth;
+		rxq->q_mask = rxq->q_depth - 1;
+		rxq->cons_idx = 0;
+
+		rxq->last_sw_pi =  rxq->q_depth - 1;
+		rxq->last_sw_ci = 0;
+		rxq->last_hw_ci = 0;
+		rxq->rx_check_err_cnt = 0;
+		rxq->rxq_print_times = 0;
+		rxq->last_packets = 0;
+		rxq->restore_buf_num = 0;
+
+		rxq->cqe_arr = rqres->cqe_start_vaddr;
+		rxq->cqe_start_paddr = rqres->cqe_start_paddr;
+		rxq->rx_info = rqres->rx_info;
+
+		rxq->rq = &nic_dev->nic_io->rq[rxq->q_id];
+
+		rq_associate_cqes(rxq);
+
+		pkts = hinic3_rx_fill_buffers(rxq);
+		if (!pkts) {
+			netdev_err(netdev, "Failed to fill Rx buffer\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+void hinic3_rxq_get_stats(struct hinic3_rxq *rxq,
+			  struct hinic3_rxq_stats *stats)
+{
+	struct hinic3_rxq_stats *rxq_stats = &rxq->rxq_stats;
+	unsigned int start;
+
+	u64_stats_update_begin(&stats->syncp);
+	do {
+		start = u64_stats_fetch_begin(&rxq_stats->syncp);
+		stats->bytes = rxq_stats->bytes;
+		stats->packets = rxq_stats->packets;
+		stats->errors = rxq_stats->csum_errors +
+				rxq_stats->other_errors;
+		stats->csum_errors = rxq_stats->csum_errors;
+		stats->other_errors = rxq_stats->other_errors;
+		stats->dropped = rxq_stats->dropped;
+		stats->rx_buf_empty = rxq_stats->rx_buf_empty;
+	} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
+	u64_stats_update_end(&stats->syncp);
+}
+
+#define LRO_PKT_HDR_LEN_IPV4    66
+#define LRO_PKT_HDR_LEN_IPV6    86
+#define LRO_PKT_HDR_LEN(cqe) \
+	(HINIC3_GET_RX_IP_TYPE((cqe)->offload_type) == \
+	 HINIC3_RX_IPV6_PKT ? LRO_PKT_HDR_LEN_IPV6 : LRO_PKT_HDR_LEN_IPV4)
+
+int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(rxq->netdev);
+	u32 sw_ci, status, pkt_len, vlan_len;
+	struct hinic3_rq_cqe *rx_cqe;
+	u64 rx_bytes = 0;
+	u32 num_wqe = 0;
+	int nr_pkts = 0;
+	u16 num_lro;
+
+	while (likely(nr_pkts < budget)) {
+		sw_ci = rxq->cons_idx & rxq->q_mask;
+		rx_cqe = rxq->cqe_arr + sw_ci;
+		status = rx_cqe->status;
+		if (!HINIC3_GET_RX_DONE(status))
+			break;
+
+		/* make sure we read rx_done before packet length */
+		rmb();
+
+		vlan_len = rx_cqe->vlan_len;
+		pkt_len = HINIC3_GET_RX_PKT_LEN(vlan_len);
+		if (recv_one_pkt(rxq, rx_cqe, pkt_len, vlan_len, status))
+			break;
+
+		rx_bytes += pkt_len;
+		nr_pkts++;
+
+		num_lro = HINIC3_GET_RX_NUM_LRO(status);
+		if (num_lro) {
+			rx_bytes += ((num_lro - 1) * LRO_PKT_HDR_LEN(rx_cqe));
+			num_wqe += hinic3_get_sge_num(rxq, pkt_len);
+		}
+
+		rx_cqe->status = 0;
+
+		if (num_wqe >= nic_dev->lro_replenish_thld)
+			break;
+	}
+
+	if (rxq->delta >= HINIC3_RX_BUFFER_WRITE)
+		hinic3_rx_fill_buffers(rxq);
+
+	u64_stats_update_begin(&rxq->rxq_stats.syncp);
+	rxq->rxq_stats.packets += (u64)nr_pkts;
+	rxq->rxq_stats.bytes += rx_bytes;
+	u64_stats_update_end(&rxq->rxq_stats.syncp);
+	return nr_pkts;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
new file mode 100644
index 000000000000..cd6b84cc407e
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_RX_H
+#define HINIC3_RX_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/netdevice.h>
+#include <linux/u64_stats_sync.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+
+#include "hinic3_nic_io.h"
+#include "hinic3_nic_dev.h"
+
+/* rx cqe checksum err */
+#define HINIC3_RX_CSUM_IP_CSUM_ERR      BIT(0)
+#define HINIC3_RX_CSUM_TCP_CSUM_ERR     BIT(1)
+#define HINIC3_RX_CSUM_UDP_CSUM_ERR     BIT(2)
+#define HINIC3_RX_CSUM_IGMP_CSUM_ERR    BIT(3)
+#define HINIC3_RX_CSUM_ICMPV4_CSUM_ERR  BIT(4)
+#define HINIC3_RX_CSUM_ICMPV6_CSUM_ERR  BIT(5)
+#define HINIC3_RX_CSUM_SCTP_CRC_ERR     BIT(6)
+#define HINIC3_RX_CSUM_HW_CHECK_NONE    BIT(7)
+#define HINIC3_RX_CSUM_IPSU_OTHER_ERR   BIT(8)
+
+#define HINIC3_HEADER_DATA_UNIT         2
+
+#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_MASK           GENMASK(4, 0)
+#define RQ_CQE_OFFOLAD_TYPE_IP_TYPE_MASK            GENMASK(6, 5)
+#define RQ_CQE_OFFOLAD_TYPE_TUNNEL_PKT_FORMAT_MASK  GENMASK(11, 8)
+#define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_MASK            BIT(21)
+#define RQ_CQE_OFFOLAD_TYPE_GET(val, member) \
+	FIELD_GET(RQ_CQE_OFFOLAD_TYPE_##member##_MASK, val)
+
+#define HINIC3_GET_RX_PKT_TYPE(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_TYPE)
+#define HINIC3_GET_RX_IP_TYPE(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, IP_TYPE)
+#define HINIC3_GET_RX_TUNNEL_PKT_FORMAT(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, TUNNEL_PKT_FORMAT)
+#define HINIC3_GET_RX_VLAN_OFFLOAD_EN(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, VLAN_EN)
+
+#define RQ_CQE_SGE_VLAN_MASK  GENMASK(15, 0)
+#define RQ_CQE_SGE_LEN_MASK   GENMASK(31, 16)
+#define RQ_CQE_SGE_GET(val, member) \
+	FIELD_GET(RQ_CQE_SGE_##member##_MASK, val)
+
+#define HINIC3_GET_RX_VLAN_TAG(vlan_len)  RQ_CQE_SGE_GET(vlan_len, VLAN)
+#define HINIC3_GET_RX_PKT_LEN(vlan_len)   RQ_CQE_SGE_GET(vlan_len, LEN)
+
+#define RQ_CQE_STATUS_CSUM_ERR_MASK  GENMASK(15, 0)
+#define RQ_CQE_STATUS_NUM_LRO_MASK   GENMASK(23, 16)
+#define RQ_CQE_STATUS_RXDONE_MASK    BIT(31)
+#define RQ_CQE_STATUS_GET(val, member) \
+	FIELD_GET(RQ_CQE_STATUS_##member##_MASK, val)
+
+#define HINIC3_GET_RX_CSUM_ERR(status)  RQ_CQE_STATUS_GET(status, CSUM_ERR)
+#define HINIC3_GET_RX_DONE(status)      RQ_CQE_STATUS_GET(status, RXDONE)
+#define HINIC3_GET_RX_NUM_LRO(status)   RQ_CQE_STATUS_GET(status, NUM_LRO)
+
+struct hinic3_rxq_stats {
+	u64                   packets;
+	u64                   bytes;
+	u64                   errors;
+	u64                   csum_errors;
+	u64                   other_errors;
+	u64                   dropped;
+	u64                   rx_buf_empty;
+	u64                   alloc_skb_err;
+	u64                   alloc_rx_buf_err;
+	u64                   restore_drop_sge;
+	struct u64_stats_sync syncp;
+};
+
+/* RX Completion information that is provided by HW for a specific RX WQE */
+struct hinic3_rq_cqe {
+	u32 status;
+	u32 vlan_len;
+	u32 offload_type;
+	u32 rsvd3;
+	u32 rsvd4;
+	u32 rsvd5;
+	u32 rsvd6;
+	u32 pkt_info;
+};
+
+struct hinic3_rq_wqe {
+	u32 buf_hi_addr;
+	u32 buf_lo_addr;
+	u32 cqe_hi_addr;
+	u32 cqe_lo_addr;
+};
+
+struct hinic3_rx_info {
+	dma_addr_t  buf_dma_addr;
+	struct page *page;
+	u32         page_offset;
+};
+
+struct hinic3_rxq {
+	struct net_device       *netdev;
+
+	u16                     q_id;
+	u32                     q_depth;
+	u32                     q_mask;
+
+	u16                     buf_len;
+	u32                     rx_buff_shift;
+	u32                     dma_rx_buff_size;
+
+	struct hinic3_rxq_stats rxq_stats;
+	u32                     cons_idx;
+	u32                     delta;
+
+	u32                     irq_id;
+	u16                     msix_entry_idx;
+
+	/* cqe_arr and rx_info are arrays of rq_depth elements. Each element is
+	 * statically associated (by index) to a specific rq_wqe.
+	 */
+	struct hinic3_rq_cqe   *cqe_arr;
+	struct hinic3_rx_info  *rx_info;
+
+	struct hinic3_io_queue *rq;
+
+	struct hinic3_irq      *irq_cfg;
+	u16                    next_to_alloc;
+	u16                    next_to_update;
+	struct device          *dev; /* device for DMA mapping */
+
+	dma_addr_t             cqe_start_paddr;
+
+	u64                    last_moder_packets;
+	u64                    last_moder_bytes;
+	u8                     last_coalesc_timer_cfg;
+	u8                     last_pending_limt;
+	u16                    restore_buf_num;
+
+	u32                    last_sw_pi;
+	u32                    last_sw_ci;
+
+	u16                    last_hw_ci;
+	u8                     rx_check_err_cnt;
+	u8                     rxq_print_times;
+	u32                    restore_pi;
+
+	u64                    last_packets;
+} ____cacheline_aligned;
+
+struct hinic3_dyna_rxq_res {
+	u16                   next_to_alloc;
+	struct hinic3_rx_info *rx_info;
+	dma_addr_t            cqe_start_paddr;
+	void                  *cqe_start_vaddr;
+};
+
+int hinic3_alloc_rxqs(struct net_device *netdev);
+void hinic3_free_rxqs(struct net_device *netdev);
+
+int hinic3_alloc_rxqs_res(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
+void hinic3_free_rxqs_res(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
+int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
+
+void hinic3_rxq_get_stats(struct hinic3_rxq *rxq,
+			  struct hinic3_rxq_stats *stats);
+int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
new file mode 100644
index 000000000000..41c5eb870e2b
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -0,0 +1,881 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/skbuff.h>
+#include <linux/u64_stats_sync.h>
+
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_tx.h"
+
+#define MAX_PAYLOAD_OFFSET         221
+#define MIN_SKB_LEN                32
+
+#define TXQ_STATS_INC(txq, field) \
+do { \
+	u64_stats_update_begin(&(txq)->txq_stats.syncp); \
+	(txq)->txq_stats.field++; \
+	u64_stats_update_end(&(txq)->txq_stats.syncp); \
+} while (0)
+
+static void hinic3_txq_clean_stats(struct hinic3_txq_stats *txq_stats)
+{
+	u64_stats_update_begin(&txq_stats->syncp);
+	txq_stats->bytes = 0;
+	txq_stats->packets = 0;
+	txq_stats->busy = 0;
+	txq_stats->wake = 0;
+	txq_stats->dropped = 0;
+
+	txq_stats->skb_pad_err = 0;
+	txq_stats->frag_len_overflow = 0;
+	txq_stats->offload_cow_skb_err = 0;
+	txq_stats->map_frag_err = 0;
+	txq_stats->unknown_tunnel_pkt = 0;
+	txq_stats->frag_size_err = 0;
+	u64_stats_update_end(&txq_stats->syncp);
+}
+
+static void txq_stats_init(struct hinic3_txq *txq)
+{
+	struct hinic3_txq_stats *txq_stats = &txq->txq_stats;
+
+	u64_stats_init(&txq_stats->syncp);
+	hinic3_txq_clean_stats(txq_stats);
+}
+
+int hinic3_alloc_txqs(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	u16 q_id, num_txqs = nic_dev->max_qps;
+	struct pci_dev *pdev = nic_dev->pdev;
+	struct hinic3_txq *txq;
+	u64 txq_size;
+
+	txq_size = num_txqs * sizeof(*nic_dev->txqs);
+	if (!txq_size) {
+		dev_err(hwdev->dev, "Cannot allocate zero size txqs\n");
+		return -EINVAL;
+	}
+
+	nic_dev->txqs = kzalloc(txq_size, GFP_KERNEL);
+	if (!nic_dev->txqs)
+		return -ENOMEM;
+
+	for (q_id = 0; q_id < num_txqs; q_id++) {
+		txq = &nic_dev->txqs[q_id];
+		txq->netdev = netdev;
+		txq->q_id = q_id;
+		txq->q_depth = nic_dev->q_params.sq_depth;
+		txq->q_mask = nic_dev->q_params.sq_depth - 1;
+		txq->dev = &pdev->dev;
+
+		txq_stats_init(txq);
+	}
+
+	return 0;
+}
+
+void hinic3_free_txqs(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	kfree(nic_dev->txqs);
+}
+
+static void hinic3_set_buf_desc(struct hinic3_sq_bufdesc *buf_descs,
+				dma_addr_t addr, u32 len)
+{
+	buf_descs->hi_addr = upper_32_bits(addr);
+	buf_descs->lo_addr = lower_32_bits(addr);
+	buf_descs->len  = len;
+}
+
+static int tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
+		      struct hinic3_txq *txq,
+		      struct hinic3_tx_info *tx_info,
+		      struct hinic3_sq_wqe_combo *wqe_combo)
+{
+	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->ctrl_bd0;
+	struct hinic3_sq_bufdesc *buf_desc = wqe_combo->bds_head;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dma_info *dma_info = tx_info->dma_info;
+	struct pci_dev *pdev = nic_dev->pdev;
+	skb_frag_t *frag;
+	u32 j, i;
+	int err;
+
+	dma_info[0].dma = dma_map_single(&pdev->dev, skb->data, skb_headlen(skb), DMA_TO_DEVICE);
+	if (dma_mapping_error(&pdev->dev, dma_info[0].dma)) {
+		TXQ_STATS_INC(txq, map_frag_err);
+		return -EFAULT;
+	}
+
+	dma_info[0].len = skb_headlen(skb);
+
+	wqe_desc->hi_addr = upper_32_bits(dma_info[0].dma);
+	wqe_desc->lo_addr = lower_32_bits(dma_info[0].dma);
+
+	wqe_desc->ctrl_len = dma_info[0].len;
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags;) {
+		frag = &(skb_shinfo(skb)->frags[i]);
+		if (unlikely(i == wqe_combo->first_bds_num))
+			buf_desc = wqe_combo->bds_sec2;
+
+		i++;
+		dma_info[i].dma = skb_frag_dma_map(&pdev->dev, frag, 0,
+						   skb_frag_size(frag),
+						   DMA_TO_DEVICE);
+		if (dma_mapping_error(&pdev->dev, dma_info[i].dma)) {
+			TXQ_STATS_INC(txq, map_frag_err);
+			i--;
+			err = -EFAULT;
+			goto err_frag_map;
+		}
+		dma_info[i].len = skb_frag_size(frag);
+
+		hinic3_set_buf_desc(buf_desc, dma_info[i].dma,
+				    dma_info[i].len);
+		buf_desc++;
+	}
+
+	return 0;
+
+err_frag_map:
+	for (j = 0; j < i;) {
+		j++;
+		dma_unmap_page(&pdev->dev, dma_info[j].dma,
+			       dma_info[j].len, DMA_TO_DEVICE);
+	}
+	dma_unmap_single(&pdev->dev, dma_info[0].dma, dma_info[0].len,
+			 DMA_TO_DEVICE);
+	return err;
+}
+
+static void tx_unmap_skb(struct net_device *netdev,
+			 struct sk_buff *skb,
+			 struct hinic3_dma_info *dma_info)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct pci_dev *pdev = nic_dev->pdev;
+	int i;
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags;) {
+		i++;
+		dma_unmap_page(&pdev->dev,
+			       dma_info[i].dma,
+			       dma_info[i].len, DMA_TO_DEVICE);
+	}
+
+	dma_unmap_single(&pdev->dev, dma_info[0].dma,
+			 dma_info[0].len, DMA_TO_DEVICE);
+}
+
+static void tx_free_skb(struct net_device *netdev,
+			struct hinic3_tx_info *tx_info)
+{
+	tx_unmap_skb(netdev, tx_info->skb, tx_info->dma_info);
+	dev_kfree_skb_any(tx_info->skb);
+	tx_info->skb = NULL;
+}
+
+static void free_all_tx_skbs(struct net_device *netdev, u32 sq_depth,
+			     struct hinic3_tx_info *tx_info_arr)
+{
+	struct hinic3_tx_info *tx_info;
+	u32 idx;
+
+	for (idx = 0; idx < sq_depth; idx++) {
+		tx_info = &tx_info_arr[idx];
+		if (tx_info->skb)
+			tx_free_skb(netdev, tx_info);
+	}
+}
+
+union hinic3_l4 {
+	struct tcphdr *tcp;
+	struct udphdr *udp;
+	unsigned char *hdr;
+};
+
+enum sq_l3_type {
+	UNKNOWN_L3TYPE               = 0,
+	IPV6_PKT                     = 1,
+	IPV4_PKT_NO_CHKSUM_OFFLOAD   = 2,
+	IPV4_PKT_WITH_CHKSUM_OFFLOAD = 3,
+};
+
+enum sq_l4offload_type {
+	OFFLOAD_DISABLE     = 0,
+	TCP_OFFLOAD_ENABLE  = 1,
+	SCTP_OFFLOAD_ENABLE = 2,
+	UDP_OFFLOAD_ENABLE  = 3,
+};
+
+/* initialize l4 offset and offload */
+static void get_inner_l4_info(struct sk_buff *skb, union hinic3_l4 *l4,
+			      u8 l4_proto, u32 *offset,
+			      enum sq_l4offload_type *l4_offload)
+{
+	switch (l4_proto) {
+	case IPPROTO_TCP:
+		*l4_offload = TCP_OFFLOAD_ENABLE;
+		/* To be same with TSO, payload offset begins from payload */
+		*offset = (l4->tcp->doff << TCP_HDR_DATA_OFF_UNIT_SHIFT) +
+			   TRANSPORT_OFFSET(l4->hdr, skb);
+		break;
+
+	case IPPROTO_UDP:
+		*l4_offload = UDP_OFFLOAD_ENABLE;
+		*offset = TRANSPORT_OFFSET(l4->hdr, skb);
+		break;
+	default:
+		*l4_offload = OFFLOAD_DISABLE;
+		*offset = 0;
+	}
+}
+
+static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
+			  struct sk_buff *skb)
+{
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return 0;
+
+	if (skb->encapsulation) {
+		union hinic3_ip ip;
+		u8 l4_proto;
+
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);
+
+		ip.hdr = skb_network_header(skb);
+		if (ip.v4->version == 4) {
+			l4_proto = ip.v4->protocol;
+		} else if (ip.v4->version == 6) {
+			union hinic3_l4 l4;
+			unsigned char *exthdr;
+			__be16 frag_off;
+
+			exthdr = ip.hdr + sizeof(*ip.v6);
+			l4_proto = ip.v6->nexthdr;
+			l4.hdr = skb_transport_header(skb);
+			if (l4.hdr != exthdr)
+				ipv6_skip_exthdr(skb, exthdr - skb->data,
+						 &l4_proto, &frag_off);
+		} else {
+			l4_proto = IPPROTO_RAW;
+		}
+
+		if (l4_proto != IPPROTO_UDP ||
+		    ((struct udphdr *)skb_transport_header(skb))->dest != VXLAN_OFFLOAD_PORT_LE) {
+			TXQ_STATS_INC(txq, unknown_tunnel_pkt);
+			/* Unsupported tunnel packet, disable csum offload */
+			skb_checksum_help(skb);
+			return 0;
+		}
+	}
+
+	task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L4_EN);
+
+	return 1;
+}
+
+static void get_inner_l3_l4_type(struct sk_buff *skb, union hinic3_ip *ip,
+				 union hinic3_l4 *l4,
+				 enum sq_l3_type *l3_type, u8 *l4_proto)
+{
+	unsigned char *exthdr;
+	__be16 frag_off;
+
+	if (ip->v4->version == 4) {
+		*l3_type = IPV4_PKT_WITH_CHKSUM_OFFLOAD;
+		*l4_proto = ip->v4->protocol;
+	} else if (ip->v4->version == 6) {
+		*l3_type = IPV6_PKT;
+		exthdr = ip->hdr + sizeof(*ip->v6);
+		*l4_proto = ip->v6->nexthdr;
+		if (exthdr != l4->hdr) {
+			ipv6_skip_exthdr(skb, exthdr - skb->data,
+					 l4_proto, &frag_off);
+		}
+	} else {
+		*l3_type = UNKNOWN_L3TYPE;
+		*l4_proto = 0;
+	}
+}
+
+static void hinic3_set_tso_info(struct hinic3_sq_task *task, u32 *queue_info,
+				enum sq_l4offload_type l4_offload,
+				u32 offset, u32 mss)
+{
+	if (l4_offload == TCP_OFFLOAD_ENABLE) {
+		*queue_info |= SQ_CTRL_QUEUE_INFO_SET(1U, TSO);
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L4_EN);
+	} else if (l4_offload == UDP_OFFLOAD_ENABLE) {
+		*queue_info |= SQ_CTRL_QUEUE_INFO_SET(1U, UFO);
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L4_EN);
+	}
+
+	/* enable L3 calculation */
+	task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L3_EN);
+
+	*queue_info |= SQ_CTRL_QUEUE_INFO_SET(offset >> 1, PLDOFF);
+
+	/* set MSS value */
+	*queue_info &= ~SQ_CTRL_QUEUE_INFO_MSS_MASK;
+	*queue_info |= SQ_CTRL_QUEUE_INFO_SET(mss, MSS);
+}
+
+static int hinic3_tso(struct hinic3_sq_task *task, u32 *queue_info,
+		      struct sk_buff *skb)
+{
+	enum sq_l4offload_type l4_offload;
+	enum sq_l3_type l3_type;
+	union hinic3_ip ip;
+	union hinic3_l4 l4;
+	u8 l4_proto;
+	u32 offset;
+	int err;
+
+	if (!skb_is_gso(skb))
+		return 0;
+
+	err = skb_cow_head(skb, 0);
+	if (err < 0)
+		return err;
+
+	if (skb->encapsulation) {
+		u32 gso_type = skb_shinfo(skb)->gso_type;
+		/* L3 checksum is always enabled */
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, OUT_L3_EN);
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);
+
+		l4.hdr = skb_transport_header(skb);
+		ip.hdr = skb_network_header(skb);
+
+		if (gso_type & SKB_GSO_UDP_TUNNEL_CSUM) {
+			l4.udp->check = ~csum_magic(&ip, IPPROTO_UDP);
+			task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, OUT_L4_EN);
+		}
+
+		ip.hdr = skb_inner_network_header(skb);
+		l4.hdr = skb_inner_transport_header(skb);
+	} else {
+		ip.hdr = skb_network_header(skb);
+		l4.hdr = skb_transport_header(skb);
+	}
+
+	get_inner_l3_l4_type(skb, &ip, &l4, &l3_type, &l4_proto);
+
+	if (l4_proto == IPPROTO_TCP)
+		l4.tcp->check = ~csum_magic(&ip, IPPROTO_TCP);
+
+	get_inner_l4_info(skb, &l4, l4_proto, &offset, &l4_offload);
+
+	hinic3_set_tso_info(task, queue_info, l4_offload, offset,
+			    skb_shinfo(skb)->gso_size);
+
+	return 1;
+}
+
+static void hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task,
+				       u16 vlan_tag, u8 vlan_tpid)
+{
+	/* vlan_tpid: 0=select TPID0 in IPSU, 1=select TPID1 in IPSU
+	 * 2=select TPID2 in IPSU, 3=select TPID3 in IPSU,
+	 * 4=select TPID4 in IPSU
+	 */
+	task->vlan_offload = SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |
+			     SQ_TASK_INFO3_SET(vlan_tpid, VLAN_TPID) |
+			     SQ_TASK_INFO3_SET(1U, VLAN_TAG_VALID);
+}
+
+static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
+			     u32 *queue_info, struct hinic3_txq *txq)
+{
+	u32 offload = 0;
+	int tso_cs_en;
+
+	task->pkt_info0 = 0;
+	task->ip_identify = 0;
+	task->rsvd = 0;
+	task->vlan_offload = 0;
+
+	tso_cs_en = hinic3_tso(task, queue_info, skb);
+	if (tso_cs_en < 0) {
+		offload = TX_OFFLOAD_INVALID;
+		return offload;
+	} else if (tso_cs_en) {
+		offload |= TX_OFFLOAD_TSO;
+	} else {
+		tso_cs_en = hinic3_tx_csum(txq, task, skb);
+		if (tso_cs_en)
+			offload |= TX_OFFLOAD_CSUM;
+	}
+
+#define VLAN_INSERT_MODE_MAX 5
+	if (unlikely(skb_vlan_tag_present(skb))) {
+		/* select vlan insert mode by qid, default 802.1Q Tag type */
+		hinic3_set_vlan_tx_offload(task, skb_vlan_tag_get(skb),
+					   txq->q_id % VLAN_INSERT_MODE_MAX);
+		offload |= TX_OFFLOAD_VLAN;
+	}
+
+	if (unlikely(SQ_CTRL_QUEUE_INFO_GET(*queue_info, PLDOFF) >
+		     MAX_PAYLOAD_OFFSET)) {
+		offload = TX_OFFLOAD_INVALID;
+		return offload;
+	}
+
+	return offload;
+}
+
+static void get_pkt_stats(struct hinic3_txq *txq, struct sk_buff *skb)
+{
+	u32 hdr_len, tx_bytes;
+	unsigned short pkts;
+
+	if (skb_is_gso(skb)) {
+		hdr_len = (skb_shinfo(skb)->gso_segs - 1) * skb_tcp_all_headers(skb);
+		tx_bytes = skb->len + hdr_len;
+		pkts = skb_shinfo(skb)->gso_segs;
+	} else {
+		tx_bytes = skb->len > ETH_ZLEN ? skb->len : ETH_ZLEN;
+		pkts = 1;
+	}
+
+	u64_stats_update_begin(&txq->txq_stats.syncp);
+	txq->txq_stats.bytes += tx_bytes;
+	txq->txq_stats.packets += pkts;
+	u64_stats_update_end(&txq->txq_stats.syncp);
+}
+
+static int hinic3_maybe_stop_tx(struct hinic3_txq *txq, u16 wqebb_cnt)
+{
+	if (likely(hinic3_wq_free_wqebbs(&txq->sq->wq) >= wqebb_cnt))
+		return 0;
+
+	/* We need to check again in a case another CPU has just
+	 * made room available.
+	 */
+	netif_stop_subqueue(txq->netdev, txq->q_id);
+
+	if (likely(hinic3_wq_free_wqebbs(&txq->sq->wq) < wqebb_cnt))
+		return -EBUSY;
+
+	netif_start_subqueue(txq->netdev, txq->q_id);
+
+	return 0;
+}
+
+static u16 hinic3_get_and_update_sq_owner(struct hinic3_io_queue *sq,
+					  u16 curr_pi, u16 wqebb_cnt)
+{
+	u16 owner = sq->owner;
+
+	if (unlikely(curr_pi + wqebb_cnt >= sq->wq.q_depth))
+		sq->owner = !sq->owner;
+
+	return owner;
+}
+
+static u16 hinic3_set_wqe_combo(struct hinic3_txq *txq,
+				struct hinic3_sq_wqe_combo *wqe_combo,
+				u32 offload, u16 num_sge, u16 *curr_pi)
+{
+	struct hinic3_sq_bufdesc *second_part_wqebbs_addr;
+	u16 first_part_wqebbs_num, tmp_pi;
+	struct hinic3_sq_bufdesc *wqe;
+
+	wqe_combo->ctrl_bd0 = hinic3_wq_get_one_wqebb(&txq->sq->wq, curr_pi);
+	if (!offload && num_sge == 1) {
+		wqe_combo->wqe_type = SQ_WQE_COMPACT_TYPE;
+		return hinic3_get_and_update_sq_owner(txq->sq, *curr_pi, 1);
+	}
+
+	wqe_combo->wqe_type = SQ_WQE_EXTENDED_TYPE;
+
+	if (offload) {
+		wqe_combo->task = hinic3_wq_get_one_wqebb(&txq->sq->wq, &tmp_pi);
+		wqe_combo->task_type = SQ_WQE_TASKSECT_16BYTES;
+	} else {
+		wqe_combo->task_type = SQ_WQE_TASKSECT_46BITS;
+	}
+
+	if (num_sge > 1) {
+		/* first wqebb contain bd0, and bd size is equal to sq wqebb
+		 * size, so we use (num_sge - 1) as wanted weqbb_cnt
+		 */
+		hinic3_wq_get_multi_wqebbs(&txq->sq->wq, num_sge - 1, &tmp_pi,
+					   &wqe,
+					   &second_part_wqebbs_addr,
+					   &first_part_wqebbs_num);
+		wqe_combo->bds_head = wqe;
+		wqe_combo->bds_sec2 = second_part_wqebbs_addr;
+		wqe_combo->first_bds_num = first_part_wqebbs_num;
+	}
+
+	return hinic3_get_and_update_sq_owner(txq->sq, *curr_pi,
+					      num_sge + (u16)!!offload);
+}
+
+static void hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,
+				   u32 queue_info, int nr_descs, u16 owner)
+{
+	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->ctrl_bd0;
+
+	if (wqe_combo->wqe_type == SQ_WQE_COMPACT_TYPE) {
+		wqe_desc->ctrl_len |=
+		    SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
+		    SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
+		    SQ_CTRL_SET(owner, OWNER);
+
+		/* compact wqe queue_info will transfer to chip */
+		wqe_desc->queue_info = 0;
+		return;
+	}
+
+	wqe_desc->ctrl_len |= SQ_CTRL_SET(nr_descs, BUFDESC_NUM) |
+			      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |
+			      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
+			      SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
+			      SQ_CTRL_SET(owner, OWNER);
+
+	wqe_desc->queue_info = queue_info;
+	wqe_desc->queue_info |= SQ_CTRL_QUEUE_INFO_SET(1U, UC);
+
+	if (!SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS)) {
+		wqe_desc->queue_info |=
+		    SQ_CTRL_QUEUE_INFO_SET(TX_MSS_DEFAULT, MSS);
+	} else if (SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS) <
+		   TX_MSS_MIN) {
+		/* mss should not be less than 80 */
+		wqe_desc->queue_info &= ~SQ_CTRL_QUEUE_INFO_MSS_MASK;
+		wqe_desc->queue_info |= SQ_CTRL_QUEUE_INFO_SET(TX_MSS_MIN, MSS);
+	}
+}
+
+static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
+				       struct net_device *netdev,
+				       struct hinic3_txq *txq)
+{
+	struct hinic3_sq_wqe_combo wqe_combo = {};
+	struct hinic3_tx_info *tx_info;
+	u32 offload, queue_info = 0;
+	struct hinic3_sq_task task;
+	u16 wqebb_cnt, num_sge;
+	u16 saved_wq_prod_idx;
+	u16 owner, pi = 0;
+	u8 saved_sq_owner;
+	int err;
+
+	if (unlikely(skb->len < MIN_SKB_LEN)) {
+		if (skb_pad(skb, MIN_SKB_LEN - skb->len)) {
+			TXQ_STATS_INC(txq, skb_pad_err);
+			goto err_tx_skb_pad;
+		}
+
+		skb->len = MIN_SKB_LEN;
+	}
+
+	num_sge = skb_shinfo(skb)->nr_frags + 1;
+	/* assume normal wqe format + 1 wqebb for task info */
+	wqebb_cnt = num_sge + 1;
+	if (unlikely(hinic3_maybe_stop_tx(txq, wqebb_cnt))) {
+		TXQ_STATS_INC(txq, busy);
+		return NETDEV_TX_BUSY;
+	}
+
+	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);
+	if (unlikely(offload == TX_OFFLOAD_INVALID)) {
+		TXQ_STATS_INC(txq, offload_cow_skb_err);
+		goto tx_drop_pkts;
+	} else if (!offload) {
+		wqebb_cnt -= 1;
+		if (unlikely(num_sge == 1 && skb->len > COMPACET_WQ_SKB_MAX_LEN))
+			goto tx_drop_pkts;
+	}
+
+	saved_wq_prod_idx = txq->sq->wq.prod_idx;
+	saved_sq_owner = txq->sq->owner;
+
+	owner = hinic3_set_wqe_combo(txq, &wqe_combo, offload, num_sge, &pi);
+	if (offload)
+		*wqe_combo.task = task;
+
+	tx_info = &txq->tx_info[pi];
+	tx_info->skb = skb;
+	tx_info->wqebb_cnt = wqebb_cnt;
+
+	err = tx_map_skb(netdev, skb, txq, tx_info, &wqe_combo);
+	if (err) {
+		/* Rollback work queue to reclaim the wqebb we did not use */
+		txq->sq->wq.prod_idx = saved_wq_prod_idx;
+		txq->sq->owner = saved_sq_owner;
+		goto tx_drop_pkts;
+	}
+
+	get_pkt_stats(txq, skb);
+	hinic3_prepare_sq_ctrl(&wqe_combo, queue_info, num_sge, owner);
+	hinic3_write_db(txq->sq, 0, SQ_CFLAG_DP,
+			hinic3_get_sq_local_pi(txq->sq));
+
+	return NETDEV_TX_OK;
+
+tx_drop_pkts:
+	dev_kfree_skb_any(skb);
+
+err_tx_skb_pad:
+	TXQ_STATS_INC(txq, dropped);
+
+	return NETDEV_TX_OK;
+}
+
+netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 q_id = skb_get_queue_mapping(skb);
+	struct hinic3_txq *txq;
+
+	if (unlikely(!netif_carrier_ok(netdev))) {
+		dev_kfree_skb_any(skb);
+		HINIC3_NIC_STATS_INC(nic_dev, tx_carrier_off_drop);
+		return NETDEV_TX_OK;
+	}
+
+	if (unlikely(q_id >= nic_dev->q_params.num_qps)) {
+		txq = &nic_dev->txqs[0];
+		HINIC3_NIC_STATS_INC(nic_dev, tx_invalid_qid);
+		goto tx_drop_pkts;
+	}
+	txq = &nic_dev->txqs[q_id];
+
+	return hinic3_send_one_skb(skb, netdev, txq);
+
+tx_drop_pkts:
+	dev_kfree_skb_any(skb);
+	u64_stats_update_begin(&txq->txq_stats.syncp);
+	txq->txq_stats.dropped++;
+	u64_stats_update_end(&txq->txq_stats.syncp);
+
+	return NETDEV_TX_OK;
+}
+
+static bool is_hw_complete_sq_process(struct hinic3_io_queue *sq)
+{
+	u16 sw_pi, hw_ci;
+
+	sw_pi = hinic3_get_sq_local_pi(sq);
+	hw_ci = hinic3_get_sq_hw_ci(sq);
+
+	return sw_pi == hw_ci;
+}
+
+#define HINIC3_FLUSH_QUEUE_TIMEOUT	1000
+static int hinic3_stop_sq(struct hinic3_txq *txq)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(txq->netdev);
+	unsigned long timeout;
+	int err;
+
+	timeout = msecs_to_jiffies(HINIC3_FLUSH_QUEUE_TIMEOUT) + jiffies;
+	do {
+		if (is_hw_complete_sq_process(txq->sq))
+			return 0;
+
+		usleep_range(900, 1000);
+	} while (time_before(jiffies, timeout));
+
+	/* force hardware to drop packets */
+	timeout = msecs_to_jiffies(HINIC3_FLUSH_QUEUE_TIMEOUT) + jiffies;
+	do {
+		if (is_hw_complete_sq_process(txq->sq))
+			return 0;
+
+		err = hinic3_force_drop_tx_pkt(nic_dev->hwdev);
+		if (err)
+			break;
+
+		usleep_range(9900, 10000);
+	} while (time_before(jiffies, timeout));
+
+	if (is_hw_complete_sq_process(txq->sq))
+		return 0;
+
+	return -EFAULT;
+}
+
+/* packet transmission should be stopped before calling this function */
+int hinic3_flush_txqs(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 qid;
+	int err;
+
+	for (qid = 0; qid < nic_dev->q_params.num_qps; qid++) {
+		err = hinic3_stop_sq(&nic_dev->txqs[qid]);
+		if (err)
+			netdev_err(netdev, "Failed to stop sq%u\n", qid);
+	}
+
+	return 0;
+}
+
+#define HINIC3_BDS_PER_SQ_WQEBB \
+	(HINIC3_SQ_WQEBB_SIZE / sizeof(struct hinic3_sq_bufdesc))
+
+int hinic3_alloc_txqs_res(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res)
+{
+	struct hinic3_dyna_txq_res *tqres;
+	int idx, i;
+	u64 size;
+
+	for (idx = 0; idx < num_sq; idx++) {
+		tqres = &txqs_res[idx];
+
+		size = sizeof(*tqres->tx_info) * sq_depth;
+		tqres->tx_info = kzalloc(size, GFP_KERNEL);
+		if (!tqres->tx_info)
+			goto err_out;
+
+		size = sizeof(*tqres->bds) *
+			(sq_depth * HINIC3_BDS_PER_SQ_WQEBB +
+			 HINIC3_MAX_SQ_SGE);
+		tqres->bds = kzalloc(size, GFP_KERNEL);
+		if (!tqres->bds) {
+			kfree(tqres->tx_info);
+			goto err_out;
+		}
+	}
+
+	return 0;
+
+err_out:
+	for (i = 0; i < idx; i++) {
+		tqres = &txqs_res[i];
+
+		kfree(tqres->bds);
+		kfree(tqres->tx_info);
+	}
+
+	return -ENOMEM;
+}
+
+void hinic3_free_txqs_res(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res)
+{
+	struct hinic3_dyna_txq_res *tqres;
+	int idx;
+
+	for (idx = 0; idx < num_sq; idx++) {
+		tqres = &txqs_res[idx];
+
+		free_all_tx_skbs(netdev, sq_depth, tqres->tx_info);
+		kfree(tqres->bds);
+		kfree(tqres->tx_info);
+	}
+}
+
+int hinic3_configure_txqs(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_txq_res *tqres;
+	struct hinic3_txq *txq;
+	u16 q_id;
+	u32 idx;
+
+	for (q_id = 0; q_id < num_sq; q_id++) {
+		txq = &nic_dev->txqs[q_id];
+		tqres = &txqs_res[q_id];
+
+		txq->q_depth = sq_depth;
+		txq->q_mask = sq_depth - 1;
+
+		txq->tx_info = tqres->tx_info;
+		for (idx = 0; idx < sq_depth; idx++)
+			txq->tx_info[idx].dma_info =
+				&tqres->bds[idx * HINIC3_BDS_PER_SQ_WQEBB];
+
+		txq->sq = &nic_dev->nic_io->sq[q_id];
+	}
+
+	return 0;
+}
+
+void hinic3_txq_get_stats(struct hinic3_txq *txq,
+			  struct hinic3_txq_stats *stats)
+{
+	struct hinic3_txq_stats *txq_stats = &txq->txq_stats;
+	unsigned int start;
+
+	u64_stats_update_begin(&stats->syncp);
+	do {
+		start = u64_stats_fetch_begin(&txq_stats->syncp);
+		stats->bytes = txq_stats->bytes;
+		stats->packets = txq_stats->packets;
+		stats->busy = txq_stats->busy;
+		stats->wake = txq_stats->wake;
+		stats->dropped = txq_stats->dropped;
+	} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
+	u64_stats_update_end(&stats->syncp);
+}
+
+int hinic3_tx_poll(struct hinic3_txq *txq, int budget)
+{
+	struct net_device *netdev = txq->netdev;
+	u16 hw_ci, sw_ci, q_id = txq->sq->q_id;
+	struct hinic3_nic_dev *nic_dev;
+	struct hinic3_tx_info *tx_info;
+	u16 wqebb_cnt = 0;
+	int pkts = 0;
+	u64 wake = 0;
+
+	nic_dev = netdev_priv(netdev);
+	hw_ci = hinic3_get_sq_hw_ci(txq->sq);
+	dma_rmb();
+	sw_ci = hinic3_get_sq_local_ci(txq->sq);
+
+	do {
+		tx_info = &txq->tx_info[sw_ci];
+
+		/* Did all wqebb of this wqe complete? */
+		if (hw_ci == sw_ci ||
+		    ((hw_ci - sw_ci) & txq->q_mask) < tx_info->wqebb_cnt)
+			break;
+
+		sw_ci = (sw_ci + tx_info->wqebb_cnt) & (u16)txq->q_mask;
+		prefetch(&txq->tx_info[sw_ci]);
+
+		wqebb_cnt += tx_info->wqebb_cnt;
+		pkts++;
+
+		tx_free_skb(netdev, tx_info);
+	} while (likely(pkts < budget));
+
+	hinic3_wq_put_wqebbs(&txq->sq->wq, wqebb_cnt);
+
+	if (unlikely(__netif_subqueue_stopped(netdev, q_id) &&
+		     hinic3_wq_free_wqebbs(&txq->sq->wq) >= 1 &&
+		     test_bit(HINIC3_INTF_UP, &nic_dev->flags))) {
+		struct netdev_queue *netdev_txq =
+				netdev_get_tx_queue(netdev, q_id);
+
+		__netif_tx_lock(netdev_txq, smp_processor_id());
+		/* avoid re-waking subqueue with xmit_frame */
+		if (__netif_subqueue_stopped(netdev, q_id)) {
+			netif_wake_subqueue(netdev, q_id);
+			wake++;
+		}
+		__netif_tx_unlock(netdev_txq);
+	}
+
+	u64_stats_update_begin(&txq->txq_stats.syncp);
+	txq->txq_stats.wake += wake;
+	u64_stats_update_end(&txq->txq_stats.syncp);
+
+	return pkts;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
new file mode 100644
index 000000000000..9f3f933d605b
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_TX_H
+#define HINIC3_TX_H
+
+#include <net/ipv6.h>
+#include <net/checksum.h>
+#include <net/ip6_checksum.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+
+#include "hinic3_nic_io.h"
+
+#define VXLAN_OFFLOAD_PORT_LE           cpu_to_be16(4789)
+
+#define COMPACET_WQ_SKB_MAX_LEN         16383
+
+#define IP_HDR_IHL_UNIT_SHIFT           2
+#define TCP_HDR_DATA_OFF_UNIT_SHIFT     2
+#define TCP_HDR_DOFF_UNIT               2
+#define TRANSPORT_OFFSET(l4_hdr, skb)   ((u32)((l4_hdr) - (skb)->data))
+
+enum tx_offload_type {
+	TX_OFFLOAD_TSO     = BIT(0),
+	TX_OFFLOAD_CSUM    = BIT(1),
+	TX_OFFLOAD_VLAN    = BIT(2),
+	TX_OFFLOAD_INVALID = BIT(3),
+	TX_OFFLOAD_ESP     = BIT(4),
+};
+
+enum sq_wqe_data_format {
+	SQ_NORMAL_WQE = 0,
+};
+
+enum sq_wqe_ec_type {
+	SQ_WQE_COMPACT_TYPE  = 0,
+	SQ_WQE_EXTENDED_TYPE = 1,
+};
+
+enum sq_wqe_tasksect_len_type {
+	SQ_WQE_TASKSECT_46BITS  = 0,
+	SQ_WQE_TASKSECT_16BYTES = 1,
+};
+
+#define SQ_CTRL_BUFDESC_NUM_MASK   GENMASK(26, 19)
+#define SQ_CTRL_TASKSECT_LEN_MASK  BIT(27)
+#define SQ_CTRL_DATA_FORMAT_MASK   BIT(28)
+#define SQ_CTRL_EXTENDED_MASK      BIT(30)
+#define SQ_CTRL_OWNER_MASK         BIT(31)
+#define SQ_CTRL_SET(val, member) \
+	FIELD_PREP(SQ_CTRL_##member##_MASK, val)
+
+#define SQ_CTRL_QUEUE_INFO_PLDOFF_MASK  GENMASK(9, 2)
+#define SQ_CTRL_QUEUE_INFO_UFO_MASK     BIT(10)
+#define SQ_CTRL_QUEUE_INFO_TSO_MASK     BIT(11)
+#define SQ_CTRL_QUEUE_INFO_MSS_MASK     GENMASK(26, 13)
+#define SQ_CTRL_QUEUE_INFO_UC_MASK      BIT(28)
+
+#define SQ_CTRL_QUEUE_INFO_SET(val, member) \
+	FIELD_PREP(SQ_CTRL_QUEUE_INFO_##member##_MASK, val)
+#define SQ_CTRL_QUEUE_INFO_GET(val, member) \
+	FIELD_GET(SQ_CTRL_QUEUE_INFO_##member##_MASK, val)
+
+#define SQ_TASK_INFO0_TUNNEL_FLAG_MASK  BIT(19)
+#define SQ_TASK_INFO0_INNER_L4_EN_MASK  BIT(24)
+#define SQ_TASK_INFO0_INNER_L3_EN_MASK  BIT(25)
+#define SQ_TASK_INFO0_OUT_L4_EN_MASK    BIT(27)
+#define SQ_TASK_INFO0_OUT_L3_EN_MASK    BIT(28)
+#define SQ_TASK_INFO0_SET(val, member) \
+	FIELD_PREP(SQ_TASK_INFO0_##member##_MASK, val)
+
+#define SQ_TASK_INFO3_VLAN_TAG_MASK        GENMASK(15, 0)
+#define SQ_TASK_INFO3_VLAN_TPID_MASK       GENMASK(18, 16)
+#define SQ_TASK_INFO3_VLAN_TAG_VALID_MASK  BIT(19)
+#define SQ_TASK_INFO3_SET(val, member) \
+	FIELD_PREP(SQ_TASK_INFO3_##member##_MASK, val)
+
+struct hinic3_sq_wqe_desc {
+	u32 ctrl_len;
+	u32 queue_info;
+	u32 hi_addr;
+	u32 lo_addr;
+};
+
+struct hinic3_sq_task {
+	u32 pkt_info0;
+	u32 ip_identify;
+	u32 rsvd;
+	u32 vlan_offload;
+};
+
+struct hinic3_sq_wqe_combo {
+	struct hinic3_sq_wqe_desc *ctrl_bd0;
+	struct hinic3_sq_task     *task;
+	struct hinic3_sq_bufdesc  *bds_head;
+	struct hinic3_sq_bufdesc  *bds_sec2;
+	u16                       first_bds_num;
+	u32                       wqe_type;
+	u32                       task_type;
+};
+
+union hinic3_ip {
+	struct iphdr   *v4;
+	struct ipv6hdr *v6;
+	unsigned char  *hdr;
+};
+
+struct hinic3_txq_stats {
+	u64                   packets;
+	u64                   bytes;
+	u64                   busy;
+	u64                   wake;
+	u64                   dropped;
+	u64                   skb_pad_err;
+	u64                   frag_len_overflow;
+	u64                   offload_cow_skb_err;
+	u64                   map_frag_err;
+	u64                   unknown_tunnel_pkt;
+	u64                   frag_size_err;
+	struct u64_stats_sync syncp;
+};
+
+struct hinic3_dma_info {
+	dma_addr_t dma;
+	u32        len;
+};
+
+struct hinic3_tx_info {
+	struct sk_buff         *skb;
+
+	u16                    wqebb_cnt;
+
+	struct hinic3_dma_info *dma_info;
+};
+
+struct hinic3_txq {
+	struct net_device       *netdev;
+	struct device           *dev;
+
+	u16                     q_id;
+	u32                     q_mask;
+	u32                     q_depth;
+	u32                     rsvd2;
+
+	struct hinic3_tx_info   *tx_info;
+	struct hinic3_io_queue  *sq;
+
+	struct hinic3_txq_stats txq_stats;
+	u64                     last_moder_packets;
+	u64                     last_moder_bytes;
+} ____cacheline_aligned;
+
+struct hinic3_dyna_txq_res {
+	struct hinic3_tx_info  *tx_info;
+	struct hinic3_dma_info *bds;
+};
+
+int hinic3_alloc_txqs(struct net_device *netdev);
+void hinic3_free_txqs(struct net_device *netdev);
+
+int hinic3_alloc_txqs_res(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res);
+void hinic3_free_txqs_res(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res);
+int hinic3_configure_txqs(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res);
+
+static inline __sum16 csum_magic(union hinic3_ip *ip, unsigned short proto)
+{
+	return (ip->v4->version == 4) ?
+		csum_tcpudp_magic(ip->v4->saddr, ip->v4->daddr, 0, proto, 0) :
+		csum_ipv6_magic(&ip->v6->saddr, &ip->v6->daddr, 0, proto, 0);
+}
+
+netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
+void hinic3_txq_get_stats(struct hinic3_txq *txq,
+			  struct hinic3_txq_stats *stats);
+int hinic3_tx_poll(struct hinic3_txq *txq, int budget);
+int hinic3_flush_txqs(struct net_device *netdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
new file mode 100644
index 000000000000..03c5ac2c903a
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "hinic3_queue_common.h"
+#include "hinic3_wq.h"
+
+#define WQ_MIN_DEPTH            64
+#define WQ_MAX_DEPTH            65536
+#define WQ_PAGE_ADDR_SIZE       sizeof(u64)
+#define WQ_MAX_NUM_PAGES        (HINIC3_MIN_PAGE_SIZE / WQ_PAGE_ADDR_SIZE)
+
+static int wq_init_wq_block(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
+{
+	struct hinic3_queue_pages *qpages = &wq->qpages;
+	int i;
+
+	if (WQ_IS_0_LEVEL_CLA(wq)) {
+		wq->wq_block_paddr = qpages->pages[0].align_paddr;
+		wq->wq_block_vaddr = qpages->pages[0].align_vaddr;
+
+		return 0;
+	}
+
+	if (wq->qpages.num_pages > WQ_MAX_NUM_PAGES) {
+		dev_err(hwdev->dev, "wq num_pages exceed limit: %lu\n",
+			WQ_MAX_NUM_PAGES);
+		return -EFAULT;
+	}
+
+	wq->wq_block_vaddr = dma_alloc_coherent(hwdev->dev,
+						HINIC3_MIN_PAGE_SIZE,
+						&wq->wq_block_paddr,
+						GFP_KERNEL);
+	if (!wq->wq_block_vaddr)
+		return -ENOMEM;
+
+	for (i = 0; i < qpages->num_pages; i++)
+		wq->wq_block_vaddr[i] = cpu_to_be64(qpages->pages[i].align_paddr);
+
+	return 0;
+}
+
+static int wq_alloc_pages(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
+{
+	int err;
+
+	err = queue_pages_alloc(hwdev, &wq->qpages, 0);
+	if (err)
+		return err;
+
+	err = wq_init_wq_block(hwdev, wq);
+	if (err) {
+		queue_pages_free(hwdev, &wq->qpages);
+		return err;
+	}
+
+	return 0;
+}
+
+static void wq_free_pages(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
+{
+	if (!WQ_IS_0_LEVEL_CLA(wq))
+		dma_free_coherent(hwdev->dev,
+				  HINIC3_MIN_PAGE_SIZE,
+				  wq->wq_block_vaddr,
+				  wq->wq_block_paddr);
+
+	queue_pages_free(hwdev, &wq->qpages);
+}
+
+int hinic3_wq_create(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq, u32 q_depth,
+		     u16 wqebb_size)
+{
+	u32 wq_page_size;
+
+	if (q_depth < WQ_MIN_DEPTH || q_depth > WQ_MAX_DEPTH ||
+	    !is_power_of_2(q_depth) || !is_power_of_2(wqebb_size)) {
+		dev_err(hwdev->dev, "Wq q_depth %u or wqebb_size %u is invalid\n",
+			q_depth, wqebb_size);
+		return -EINVAL;
+	}
+
+	wq_page_size = ALIGN(hwdev->wq_page_size, HINIC3_MIN_PAGE_SIZE);
+
+	memset(wq, 0, sizeof(*wq));
+	wq->q_depth = q_depth;
+	wq->idx_mask = (u16)(q_depth - 1);
+
+	queue_pages_init(&wq->qpages, q_depth, wq_page_size, wqebb_size);
+	return wq_alloc_pages(hwdev, wq);
+}
+
+void hinic3_wq_destroy(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
+{
+	if (!wq)
+		return;
+
+	wq_free_pages(hwdev, wq);
+}
+
+void hinic3_wq_reset(struct hinic3_wq *wq)
+{
+	struct hinic3_queue_pages *qpages = &wq->qpages;
+	u16 pg_idx;
+
+	wq->cons_idx = 0;
+	wq->prod_idx = 0;
+
+	for (pg_idx = 0; pg_idx < qpages->num_pages; pg_idx++)
+		memset(qpages->pages[pg_idx].align_vaddr, 0, qpages->page_size);
+}
+
+void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,
+				u16 num_wqebbs, u16 *prod_idx,
+				struct hinic3_sq_bufdesc **first_wqebb,
+				struct hinic3_sq_bufdesc **second_part_wqebbs_addr,
+				u16 *first_part_wqebbs_num)
+{
+	u32 idx, remaining;
+
+	idx = wq->prod_idx & wq->idx_mask;
+	wq->prod_idx += num_wqebbs;
+	*prod_idx = idx;
+	*first_wqebb = get_q_element(&wq->qpages, idx, &remaining);
+	if (likely(remaining >= num_wqebbs)) {
+		*first_part_wqebbs_num = num_wqebbs;
+		*second_part_wqebbs_addr = NULL;
+	} else {
+		*first_part_wqebbs_num = remaining;
+		idx += remaining;
+		*second_part_wqebbs_addr = get_q_element(&wq->qpages, idx, NULL);
+	}
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
new file mode 100644
index 000000000000..a57d4bd7f16a
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_WQ_H
+#define HINIC3_WQ_H
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/cache.h>
+
+#include "hinic3_hwdev.h"
+#include "hinic3_queue_common.h"
+
+struct hinic3_sq_bufdesc {
+	/* 31-bits Length, L2NIC only uses length[17:0] */
+	u32 len;
+	u32 rsvd;
+	u32 hi_addr;
+	u32 lo_addr;
+};
+
+/* Work queue is used to submit elements (tx, rx, cmd) to hw.
+ * Driver is the producer that advances prod_idx. cons_idx is advanced when
+ * HW reports completions of previously submitted elements.
+ */
+struct hinic3_wq {
+	struct hinic3_queue_pages qpages;
+	/* Unmasked producer/consumer indices that are advanced to natural
+	 * integer overflow regardless of queue depth.
+	 */
+	u16                       cons_idx;
+	u16                       prod_idx;
+
+	u32                       q_depth;
+	u16                       idx_mask;
+
+	/* Work Queue (logical WQEBB array) is mapped to hw via Chip Logical
+	 * Address (CLA) using 1 of 2 levels:
+	 *     level 0 - direct mapping of single wq page
+	 *     level 1 - indirect mapping of multiple pages via additional page
+	 *               table.
+	 * When wq uses level 1, wq_block will hold the allocated indirection
+	 * table.
+	 */
+	dma_addr_t                wq_block_paddr;
+	__be64                    *wq_block_vaddr;
+} ____cacheline_aligned;
+
+#define WQ_IS_0_LEVEL_CLA(wq) \
+	((wq)->qpages.num_pages == 1)
+
+/* Get number of elements in work queue that are in-use. */
+static inline u16 hinic3_wq_get_used(const struct hinic3_wq *wq)
+{
+	return wq->prod_idx - wq->cons_idx;
+}
+
+static inline u16 hinic3_wq_free_wqebbs(struct hinic3_wq *wq)
+{
+	/* Don't allow queue to become completely full, report (free - 1). */
+	return wq->q_depth - hinic3_wq_get_used(wq) - 1;
+}
+
+static inline bool hinic3_wq_is_empty(struct hinic3_wq *wq)
+{
+	return !hinic3_wq_get_used(wq);
+}
+
+static inline void *hinic3_wq_get_one_wqebb(struct hinic3_wq *wq, u16 *pi)
+{
+	*pi = wq->prod_idx & wq->idx_mask;
+	wq->prod_idx++;
+	return get_q_element(&wq->qpages, *pi, NULL);
+}
+
+static inline void hinic3_wq_put_wqebbs(struct hinic3_wq *wq, u16 num_wqebbs)
+{
+	wq->cons_idx += num_wqebbs;
+}
+
+static inline u64 hinic3_wq_get_first_wqe_page_addr(const struct hinic3_wq *wq)
+{
+	return wq->qpages.pages[0].align_paddr;
+}
+
+int hinic3_wq_create(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq, u32 q_depth,
+		     u16 wqebb_size);
+void hinic3_wq_destroy(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq);
+void hinic3_wq_reset(struct hinic3_wq *wq);
+void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,
+				u16 num_wqebbs, u16 *prod_idx,
+				struct hinic3_sq_bufdesc **first_wqebb,
+				struct hinic3_sq_bufdesc **second_part_wqebbs_addr,
+				u16 *first_part_wqebbs_num);
+
+#endif
-- 
2.45.2


