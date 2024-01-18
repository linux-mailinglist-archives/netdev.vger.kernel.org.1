Return-Path: <netdev+bounces-64125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA4B831347
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 08:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E71B22BEA
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 07:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9DDC15B;
	Thu, 18 Jan 2024 07:42:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09AEBE47
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563760; cv=none; b=CQDKmSBZtaaEj4IiOPKFTaAJ4xKZIa6ZsuUn0I0kXe2wXIVF1sEsXxPa1z9E3DqmI1OuJ1VqGWgejsbBNBZjulOZTEf6pAQOVbVIABefnRMBhrYSmE2UOQtP3I4RkWmCAaqTwhR0AP1i4QUiWpYRaPmGyD9e6hE8eEHvfeGt22I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563760; c=relaxed/simple;
	bh=dcJb5cwJ25x7oKX1vxurkgg2NrzhhV02OPGc+afU+Sk=;
	h=X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-FEAT:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID; b=kRq6dJ08SA20m+IY/BM8ccj8O5xd/S9swwtl7SWJnKjoWWOEumPJzESd0L5H979cAo+kncEIizpJ8YLu1XBZU0wlli8RyhvMLZJ71rIwl62z6QFsu4ukv9UHkWCLhDn53kVu9UnJibR9rg4rLCPSTU5TQulYgTCzm9JWYg8tvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp76t1705563641t3zig3uv
X-QQ-Originating-IP: YvLO6BaJEoqxiu52bww9WDz1cRfegeA2bQWZdVpWZak=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.144.96])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jan 2024 15:40:40 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: ILHsT53NKPi3zZTetKxCtXAA3bcUE45+zQcbifnEBYIU3X60ynqd/HAtGfraY
	2DlWU14wr8cQUikjgPGYSqYdZYla+3A8TbXX1Kpe7QoQB0/XkkdMouJT6DTX5yaj5oVU0OE
	lniUCJhxq2OcAeRl4Z9RrlZIj+47+lKdXnyPMKNW2Rye+QNby1bj7zL+xEjmc+urMNsU2ag
	+l+O8F2mxKjLgOvqsM6TCBOwqkna2w/p6xXwCwqBEw8Y2REBte5PVHExRCU6Hrh44hPpsBQ
	bKH1ZTKf/7ti0dhejoH0dBYnXkEcUxnNaxHenBYY9MZCaDsv7ao8BzvIBhjye4ZJlUy/Kv2
	31PVPASAGOtqTfkOI4M5Alynf6eOYp3g942qMdbn57+fCBTYXlzrsAuleWG4H2SeMmRIe00
	8zhnX6zuVyk=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14112885474200510144
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [RFC PATCH net-next v2 1/2] net: txgbe: move interrupt codes to a separate file
Date: Thu, 18 Jan 2024 15:40:28 +0800
Message-Id: <20240118074029.23564-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240118074029.23564-1-jiawenwu@trustnetic.com>
References: <20240118074029.23564-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

In order to change the interrupt response structure, there will be a
lot of code added next. Move these interrupt codes to a new file, to
make the codes cleaner.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/Makefile   |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 137 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |   5 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 128 +---------------
 4 files changed, 144 insertions(+), 127 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h

diff --git a/drivers/net/ethernet/wangxun/txgbe/Makefile b/drivers/net/ethernet/wangxun/txgbe/Makefile
index 7507f762edfe..42718875277c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/Makefile
+++ b/drivers/net/ethernet/wangxun/txgbe/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_TXGBE) += txgbe.o
 txgbe-objs := txgbe_main.o \
               txgbe_hw.o \
               txgbe_phy.o \
+              txgbe_irq.o \
               txgbe_ethtool.o
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
new file mode 100644
index 000000000000..d26ee4cb1767
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/pci.h>
+
+#include "../libwx/wx_type.h"
+#include "../libwx/wx_lib.h"
+#include "../libwx/wx_hw.h"
+#include "txgbe_type.h"
+#include "txgbe_irq.h"
+
+/**
+ * txgbe_irq_enable - Enable default interrupt generation settings
+ * @wx: pointer to private structure
+ * @queues: enable irqs for queues
+ **/
+void txgbe_irq_enable(struct wx *wx, bool queues)
+{
+	wr32(wx, WX_PX_MISC_IEN, TXGBE_PX_MISC_IEN_MASK);
+
+	/* unmask interrupt */
+	wx_intr_enable(wx, TXGBE_INTR_MISC);
+	if (queues)
+		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
+}
+
+/**
+ * txgbe_intr - msi/legacy mode Interrupt Handler
+ * @irq: interrupt number
+ * @data: pointer to a network interface device structure
+ **/
+static irqreturn_t txgbe_intr(int __always_unused irq, void *data)
+{
+	struct wx_q_vector *q_vector;
+	struct wx *wx  = data;
+	struct pci_dev *pdev;
+	u32 eicr;
+
+	q_vector = wx->q_vector[0];
+	pdev = wx->pdev;
+
+	eicr = wx_misc_isb(wx, WX_ISB_VEC0);
+	if (!eicr) {
+		/* shared interrupt alert!
+		 * the interrupt that we masked before the ICR read.
+		 */
+		if (netif_running(wx->netdev))
+			txgbe_irq_enable(wx, true);
+		return IRQ_NONE;        /* Not our interrupt */
+	}
+	wx->isb_mem[WX_ISB_VEC0] = 0;
+	if (!(pdev->msi_enabled))
+		wr32(wx, WX_PX_INTA, 1);
+
+	wx->isb_mem[WX_ISB_MISC] = 0;
+	/* would disable interrupts here but it is auto disabled */
+	napi_schedule_irqoff(&q_vector->napi);
+
+	/* re-enable link(maybe) and non-queue interrupts, no flush.
+	 * txgbe_poll will re-enable the queue interrupts
+	 */
+	if (netif_running(wx->netdev))
+		txgbe_irq_enable(wx, false);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * txgbe_request_msix_irqs - Initialize MSI-X interrupts
+ * @wx: board private structure
+ *
+ * Allocate MSI-X vectors and request interrupts from the kernel.
+ **/
+static int txgbe_request_msix_irqs(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	int vector, err;
+
+	for (vector = 0; vector < wx->num_q_vectors; vector++) {
+		struct wx_q_vector *q_vector = wx->q_vector[vector];
+		struct msix_entry *entry = &wx->msix_q_entries[vector];
+
+		if (q_vector->tx.ring && q_vector->rx.ring)
+			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
+				 "%s-TxRx-%d", netdev->name, entry->entry);
+		else
+			/* skip this unused q_vector */
+			continue;
+
+		err = request_irq(entry->vector, wx_msix_clean_rings, 0,
+				  q_vector->name, q_vector);
+		if (err) {
+			wx_err(wx, "request_irq failed for MSIX interrupt %s Error: %d\n",
+			       q_vector->name, err);
+			goto free_queue_irqs;
+		}
+	}
+
+	return 0;
+
+free_queue_irqs:
+	while (vector) {
+		vector--;
+		free_irq(wx->msix_q_entries[vector].vector,
+			 wx->q_vector[vector]);
+	}
+	wx_reset_interrupt_capability(wx);
+	return err;
+}
+
+/**
+ * txgbe_request_irq - initialize interrupts
+ * @wx: board private structure
+ *
+ * Attempt to configure interrupts using the best available
+ * capabilities of the hardware and kernel.
+ **/
+int txgbe_request_irq(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	struct pci_dev *pdev = wx->pdev;
+	int err;
+
+	if (pdev->msix_enabled)
+		err = txgbe_request_msix_irqs(wx);
+	else if (pdev->msi_enabled)
+		err = request_irq(wx->pdev->irq, &txgbe_intr, 0,
+				  netdev->name, wx);
+	else
+		err = request_irq(wx->pdev->irq, &txgbe_intr, IRQF_SHARED,
+				  netdev->name, wx);
+
+	if (err)
+		wx_err(wx, "request_irq failed, Error %d\n", err);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
new file mode 100644
index 000000000000..02c536421f7d
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+
+void txgbe_irq_enable(struct wx *wx, bool queues);
+int txgbe_request_irq(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 3b151c410a5c..8cf8c0d016df 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -17,6 +17,7 @@
 #include "txgbe_type.h"
 #include "txgbe_hw.h"
 #include "txgbe_phy.h"
+#include "txgbe_irq.h"
 #include "txgbe_ethtool.h"
 
 char txgbe_driver_name[] = "txgbe";
@@ -76,133 +77,6 @@ static int txgbe_enumerate_functions(struct wx *wx)
 	return physfns;
 }
 
-/**
- * txgbe_irq_enable - Enable default interrupt generation settings
- * @wx: pointer to private structure
- * @queues: enable irqs for queues
- **/
-static void txgbe_irq_enable(struct wx *wx, bool queues)
-{
-	wr32(wx, WX_PX_MISC_IEN, TXGBE_PX_MISC_IEN_MASK);
-
-	/* unmask interrupt */
-	wx_intr_enable(wx, TXGBE_INTR_MISC);
-	if (queues)
-		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
-}
-
-/**
- * txgbe_intr - msi/legacy mode Interrupt Handler
- * @irq: interrupt number
- * @data: pointer to a network interface device structure
- **/
-static irqreturn_t txgbe_intr(int __always_unused irq, void *data)
-{
-	struct wx_q_vector *q_vector;
-	struct wx *wx  = data;
-	struct pci_dev *pdev;
-	u32 eicr;
-
-	q_vector = wx->q_vector[0];
-	pdev = wx->pdev;
-
-	eicr = wx_misc_isb(wx, WX_ISB_VEC0);
-	if (!eicr) {
-		/* shared interrupt alert!
-		 * the interrupt that we masked before the ICR read.
-		 */
-		if (netif_running(wx->netdev))
-			txgbe_irq_enable(wx, true);
-		return IRQ_NONE;        /* Not our interrupt */
-	}
-	wx->isb_mem[WX_ISB_VEC0] = 0;
-	if (!(pdev->msi_enabled))
-		wr32(wx, WX_PX_INTA, 1);
-
-	wx->isb_mem[WX_ISB_MISC] = 0;
-	/* would disable interrupts here but it is auto disabled */
-	napi_schedule_irqoff(&q_vector->napi);
-
-	/* re-enable link(maybe) and non-queue interrupts, no flush.
-	 * txgbe_poll will re-enable the queue interrupts
-	 */
-	if (netif_running(wx->netdev))
-		txgbe_irq_enable(wx, false);
-
-	return IRQ_HANDLED;
-}
-
-/**
- * txgbe_request_msix_irqs - Initialize MSI-X interrupts
- * @wx: board private structure
- *
- * Allocate MSI-X vectors and request interrupts from the kernel.
- **/
-static int txgbe_request_msix_irqs(struct wx *wx)
-{
-	struct net_device *netdev = wx->netdev;
-	int vector, err;
-
-	for (vector = 0; vector < wx->num_q_vectors; vector++) {
-		struct wx_q_vector *q_vector = wx->q_vector[vector];
-		struct msix_entry *entry = &wx->msix_q_entries[vector];
-
-		if (q_vector->tx.ring && q_vector->rx.ring)
-			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
-				 "%s-TxRx-%d", netdev->name, entry->entry);
-		else
-			/* skip this unused q_vector */
-			continue;
-
-		err = request_irq(entry->vector, wx_msix_clean_rings, 0,
-				  q_vector->name, q_vector);
-		if (err) {
-			wx_err(wx, "request_irq failed for MSIX interrupt %s Error: %d\n",
-			       q_vector->name, err);
-			goto free_queue_irqs;
-		}
-	}
-
-	return 0;
-
-free_queue_irqs:
-	while (vector) {
-		vector--;
-		free_irq(wx->msix_q_entries[vector].vector,
-			 wx->q_vector[vector]);
-	}
-	wx_reset_interrupt_capability(wx);
-	return err;
-}
-
-/**
- * txgbe_request_irq - initialize interrupts
- * @wx: board private structure
- *
- * Attempt to configure interrupts using the best available
- * capabilities of the hardware and kernel.
- **/
-static int txgbe_request_irq(struct wx *wx)
-{
-	struct net_device *netdev = wx->netdev;
-	struct pci_dev *pdev = wx->pdev;
-	int err;
-
-	if (pdev->msix_enabled)
-		err = txgbe_request_msix_irqs(wx);
-	else if (pdev->msi_enabled)
-		err = request_irq(wx->pdev->irq, &txgbe_intr, 0,
-				  netdev->name, wx);
-	else
-		err = request_irq(wx->pdev->irq, &txgbe_intr, IRQF_SHARED,
-				  netdev->name, wx);
-
-	if (err)
-		wx_err(wx, "request_irq failed, Error %d\n", err);
-
-	return err;
-}
-
 static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
-- 
2.27.0


