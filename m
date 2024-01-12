Return-Path: <netdev+bounces-63255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A940282BF8A
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 13:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDC31F247B4
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D9B6A01B;
	Fri, 12 Jan 2024 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="OQ+mXdUb"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2143.outbound.protection.outlook.com [40.92.63.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B412F6A026
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4Z0nk/6C9V5F6cFFYRqNNqpkDT27W0rKwzugzKH6EFcRrrrG0aYuFXcQrh8XlqlwHxjAg8DFU6hK9WmkbXYGYg3zvAtXXKJFbsT1h6vIBlRdHR39ONHmGkoleaVD/wa+xiBT4CUx1wHZSHEsaeoEfEIS2mHt+dk7MkvBDMIEFa6RQdmhfTww6FNH8u8CN/vzHosRwwN8SzZbI0GWAAv8/HBaNb+Fnw8iixl7cF9W3bUh85xsTw++xgP6TMfFBREh6H30kHBS/CFHvqQ8jgdgalBPjfCPw7doi6sA2ZIkBSluedIjaBB1x4DoQY1eyJAKbkNjwZEnkKP1hzvkgvniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOctQQVADG0r16ax3yEJRcH3vRoPIRQC5VqX44YgILY=;
 b=ndnDhfRtJ5QkjTqzZ8duiUzkOQOIwpuuu4hXtfs1vFqK2P3dFDegcnMZNlFkaia8/39FLQkMs/H4/pUzf8Yio3Cd2YJTU4FUFMfYx5fd7O6Suv9DoeBPaaCV2N5tlXq7VudbOxTOpAj4CoWMxGgFigxGrOxvkJolZLARQEO3JEX1yx1zp5V3KHWUNf6u72T9x6EkgQVdiTUgl4vCqQfpTShCAam7GipOH/+Oxjaof7lioVZnfP9F+A2JbVP11JGMBn0b+jRaGX4VDt1p3JKuN7McK2NSKOp09YUmtJyWtGQ5rpW7vmnd5PiiK7KMNgI+39LmlPRCLdwo8ZYCK8C2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOctQQVADG0r16ax3yEJRcH3vRoPIRQC5VqX44YgILY=;
 b=OQ+mXdUb8uberOChuw05fHHYs9c5Xb0ZiNvWOvw93dpJEXlJ1QXrOf2PR49quzmelVwhLnz/sBZ9Ogqt2BKRB34xPZeKdmWtOP6fgjnxL1w4egeOU2IMJwq7GhN5sXVBzPYugFVa0SpCJ6BL6hYTLUPCSu7QonHVcPg5FH3XysoP7FhK9TUpTbYZnfY/S2mLpNDUgRdHp2cNF/W8Ze+dxGDa7SfNjffI889SwUfqlINaDRcHOYkbRSRC0IESgxUQ6LNO+SRPxSKFt26NaCam0uuMo+kQ5FJKwmPd0ZjBAaMhE7C+kpaMrTKxAcrnpfo2RYR12zmaYIZqjShH+WdoEQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY4P282MB4175.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 12:00:58 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd%5]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 12:00:58 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v4 4/4] net: wwan: t7xx: Add fastboot WWAN port
Date: Fri, 12 Jan 2024 20:00:14 +0800
Message-ID:
 <MEYP282MB26975EE162B2A63903FD1C02BB6F2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112120014.3917-1-songjinjian@hotmail.com>
References: <20240112120014.3917-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [w8LRCAVz6R+TEphwsIgaJ2ZNgp2t7MIX]
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240112120014.3917-5-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY4P282MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fd4528-0b92-4f34-ba94-08dc13662347
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NZiptsankY5owk7m6T8AtStdBdFd2MJUunFRDgXvw1mCiU49MIsLEh5s46CP4OMLYYz9/gJyFgeTi7sfCZ3Pgt1c954/KGdr5zyI/qB5nYGe+Rif5qrHhb0+kVR+9FrsvazF70XpA172GvmgvZTQoli/0lWXVBj+lPLg2tQw1l0AX1Wvo6X+zbcxjSLaBh1MsIHLMebmQXTD0oZuS1VIhJqFi/Opvn0izQ0wvDxc7CJTZ8wh7QQYEUX426cwjg7F1XHOTtn+yExoXDV4TPlJRep0Lmk1jRRvDqG/cArQpboeCg6Th+OnRcYzxTxIyMgY4j/wTkJ+kaCnsguPhAyDj0QYL3/klvlqUfpaJ7Bt7RlJQoWxU9W8vQzeoFuPErCYpc/DhCpsyzhAm9efNDKFh9xqXmmIGv/NIkRa5+xn76GhHp3ewNSZZfUlvJOTdGgvAfVzhflYenVwPzbe0fJpkoRFX1JawbRjSWXvnPlVjdch7DGZHhb/p0ULkNx0IWCSrhurOdlMW/ryJfHR4aolisoWH3r3/uq3EufVilStow7h4rbDsaAOoPKyfvIYJE37
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eH+XantVdP9vFE5igX23ScYXKQjbEtkGUA1JXYnembIKBCMIgSk5zTe+38lE?=
 =?us-ascii?Q?uW9VaA6iffxkVRN/iyXADYe5Nt/WQ2Jmmp9qtsbF1IL2ZfibFhMeTUIVKeh5?=
 =?us-ascii?Q?ZBgNAgj4LGFmFMLTdLJGtvtuMuI9aVoOZQkratsJTR0fc/kb2kk+GAkBnNg8?=
 =?us-ascii?Q?SONEcfxJBd2pEWwmQJMik8AvZTWKOkSIDCcJLVyS8G+5O7GB2Qc2nxMdTjUq?=
 =?us-ascii?Q?e1pcuFYL1q3Df5kg41cTUh9inG776A/a/qM92QagdvCLiumyeYiKT4djqMKg?=
 =?us-ascii?Q?JBbQiq6h0cj/uMLtY/i2KdbvWBrtjNkr2JVh/6UIUciowkTRyM10TygrIMUL?=
 =?us-ascii?Q?ViZmBUtixL2788qdcEEBazNcpM7UEsBJ1C8PgAIPenD/bv1bbDMxSTaI6r7u?=
 =?us-ascii?Q?lMskDgBTDDGNZrDLFz9LdQDcPwzsAoT3oYzrT9/bLg+YxYbCqHvsdZMbAB4x?=
 =?us-ascii?Q?APrmhhaVvAlDL+vaGUdrz1Hv9SsAHyuvNr/ulN1Yn9ge/KoPLs3t0xB0VUHU?=
 =?us-ascii?Q?6AtKEbiEM0oNWjkFrBdMT2wNUSH67IUCEghB8LpOhnSpvG8MrPwFjTkfYuHm?=
 =?us-ascii?Q?IVn/Xb+w3pJGWMRD/VmpRbeGB7tui5PsxYf/mB8hVjdMFUIng56R956tBixz?=
 =?us-ascii?Q?FKiwQ4opE/j2I4lHtLjxzsJoyjMC7k7PdIELzM0c8HGG3ZaRI0mS67GiKxr2?=
 =?us-ascii?Q?ZGU9V7+Bw1ateNTzmHie5xpxectE2rzjQfXDAqTHXxqFCJOGnnBoU9+zYr3R?=
 =?us-ascii?Q?wfPB9m4CZhjYHPVvxeLEb1KIzlY2PYp7J5OZGBXdTxS0Smtgi8K5EAkCH0ed?=
 =?us-ascii?Q?KodpoIwAGz1rnRT2mBCyO3BEp/Pi2Wlzd1pSdu2X/6o0qR7Eg8XTlSXjqRBj?=
 =?us-ascii?Q?17e8lbCYqEQzBukHsR8MUpT8JRz34B/tND4s1O8LopXEm0V3vutsfCiGY9Oa?=
 =?us-ascii?Q?B1f/FImTtmT4yu8yYmq9xdo1lOkCLp5VqROdr5EiM9kInDBKqTJgCOygQfi5?=
 =?us-ascii?Q?4KKh6ZusRz2ac/cL6MY6mlK8//wZmucJHMn/2RuidB3Os2cHe6wY3VtcaFO/?=
 =?us-ascii?Q?/yA22ZA0o0hoi4t+zntHOqQSqI/tFObmlqKyosa5ykC8vRQ+D77e6BBdGoxp?=
 =?us-ascii?Q?GAhB7caU1ZSXgSldDKwYIgMslxqrHviLWoDo/NeCC8J+M/LAKFkgVvxOiblG?=
 =?us-ascii?Q?cez60tIWczNG42oQPZ0rcgtjNTZClDdUs836tCGkD0z8wmrizzgh0+nqDEQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fd4528-0b92-4f34-ba94-08dc13662347
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 12:00:58.1964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB4175

From: Jinjian Song <jinjian.song@fibocom.com>

On early detection of wwan device in fastboot mode, driver sets
up CLDMA0 HW tx/rx queues for raw data transfer and then create
fastboot port to userspace.

Application can use this port to flash firmware and collect
core dump by fastboot protocol commands.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v4:
 * change function prefix to t7xx_port_fastboot 
 * change the name 'FASTBOOT' to fastboot in struct t7xx_early_port_conf 
v3:
 * no change
v2:
 * no change
---
 .../networking/device_drivers/wwan/t7xx.rst   |  14 ++
 drivers/net/wwan/t7xx/Makefile                |   1 +
 drivers/net/wwan/t7xx/t7xx_port_fastboot.c    | 155 ++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       |   3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |   2 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    |   4 +
 6 files changed, 179 insertions(+)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_fastboot.c

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index d13624a52d8b..7257ede90152 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -125,6 +125,20 @@ The driver exposes an AT port by implementing AT WWAN Port.
 The userspace end of the control port is a /dev/wwan0at0 character
 device. Application shall use this interface to issue AT commands.
 
+fastboot port userspace ABI
+---------------------------
+
+/dev/wwan0fastboot0 character device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver exposes a fastboot protocol interface by implementing
+fastboot WWAN Port. The userspace end of the fastboot channel pipe is a
+/dev/wwan0fastboot0 character device. Application shall use this interface for
+fastboot protocol communication.
+
+Please note that driver needs to be reloaded to export /dev/wwan0fastboot0
+port, because device needs a cold reset after enter ``FASTBOOT_DL_SWITCHING``
+mode.
+
 The MediaTek's T700 modem supports the 3GPP TS 27.007 [4] specification.
 
 References
diff --git a/drivers/net/wwan/t7xx/Makefile b/drivers/net/wwan/t7xx/Makefile
index 2652cd00504e..ddf03efe388a 100644
--- a/drivers/net/wwan/t7xx/Makefile
+++ b/drivers/net/wwan/t7xx/Makefile
@@ -11,6 +11,7 @@ mtk_t7xx-y:=	t7xx_pci.o \
 		t7xx_port_proxy.o  \
 		t7xx_port_ctrl_msg.o \
 		t7xx_port_wwan.o \
+		t7xx_port_fastboot.o \
 		t7xx_hif_dpmaif.o  \
 		t7xx_hif_dpmaif_tx.o \
 		t7xx_hif_dpmaif_rx.o  \
diff --git a/drivers/net/wwan/t7xx/t7xx_port_fastboot.c b/drivers/net/wwan/t7xx/t7xx_port_fastboot.c
new file mode 100644
index 000000000000..880931af3433
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_fastboot.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Fibocom Wireless Inc.
+ *
+ * Authors:
+ *  Jinjian Song <jinjian.song@fibocom.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/minmax.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/wwan.h>
+
+#include "t7xx_port.h"
+#include "t7xx_port_proxy.h"
+#include "t7xx_state_monitor.h"
+
+static int t7xx_port_fastboot_start(struct wwan_port *port)
+{
+	struct t7xx_port *port_mtk = wwan_port_get_drvdata(port);
+
+	if (atomic_read(&port_mtk->usage_cnt))
+		return -EBUSY;
+
+	atomic_inc(&port_mtk->usage_cnt);
+	return 0;
+}
+
+static void t7xx_port_fastboot_stop(struct wwan_port *port)
+{
+	struct t7xx_port *port_mtk = wwan_port_get_drvdata(port);
+
+	atomic_dec(&port_mtk->usage_cnt);
+}
+
+static int t7xx_port_fastboot_tx(struct wwan_port *port, struct sk_buff *skb)
+{
+	struct t7xx_port *port_private = wwan_port_get_drvdata(port);
+	struct sk_buff *cur = skb, *cloned;
+	size_t actual, len, offset = 0;
+	int ret;
+	int txq_mtu;
+
+	if (!port_private->chan_enable)
+		return -EINVAL;
+
+	txq_mtu = t7xx_get_port_mtu(port_private);
+	if (txq_mtu < 0)
+		return -EINVAL;
+
+	actual = cur->len;
+	while (actual) {
+		len = min_t(size_t, actual, txq_mtu);
+		cloned = __dev_alloc_skb(len, GFP_KERNEL);
+		if (!cloned)
+			return -ENOMEM;
+
+		skb_put_data(cloned, cur->data + offset, len);
+
+		ret = t7xx_port_send_raw_skb(port_private, cloned);
+		if (ret) {
+			dev_kfree_skb(cloned);
+			dev_err(port_private->dev, "Write error on fastboot port, %d\n", ret);
+			break;
+		}
+		offset += len;
+		actual -= len;
+	}
+
+	dev_kfree_skb(skb);
+	return 0;
+}
+
+static const struct wwan_port_ops wwan_ops = {
+	.start = t7xx_port_fastboot_start,
+	.stop = t7xx_port_fastboot_stop,
+	.tx = t7xx_port_fastboot_tx,
+};
+
+static int t7xx_port_fastboot_init(struct t7xx_port *port)
+{
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+	unsigned int header_len = sizeof(struct ccci_header), mtu;
+	struct wwan_port_caps caps;
+
+	port->rx_length_th = RX_QUEUE_MAXLEN;
+
+	if (!port->wwan.wwan_port) {
+		mtu = t7xx_get_port_mtu(port);
+		caps.frag_len = mtu - header_len;
+		caps.headroom_len = header_len;
+		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
+							&wwan_ops, &caps, port);
+		if (IS_ERR(port->wwan.wwan_port))
+			dev_err(port->dev, "Unable to create WWWAN port %s", port_conf->name);
+	}
+
+	return 0;
+}
+
+static void t7xx_port_fastboot_uninit(struct t7xx_port *port)
+{
+	if (!port->wwan.wwan_port)
+		return;
+
+	port->rx_length_th = 0;
+	wwan_remove_port(port->wwan.wwan_port);
+	port->wwan.wwan_port = NULL;
+}
+
+static int t7xx_port_fastboot_recv_skb(struct t7xx_port *port, struct sk_buff *skb)
+{
+	if (!atomic_read(&port->usage_cnt) || !port->chan_enable) {
+		const struct t7xx_port_conf *port_conf = port->port_conf;
+
+		dev_kfree_skb_any(skb);
+		dev_err_ratelimited(port->dev, "Port %s is not opened, drop packets\n",
+				    port_conf->name);
+		/* Dropping skb, caller should not access skb.*/
+		return 0;
+	}
+
+	wwan_port_rx(port->wwan.wwan_port, skb);
+
+	return 0;
+}
+
+static int t7xx_port_fastboot_enable_chl(struct t7xx_port *port)
+{
+	spin_lock(&port->port_update_lock);
+	port->chan_enable = true;
+	spin_unlock(&port->port_update_lock);
+
+	return 0;
+}
+
+static int t7xx_port_fastboot_disable_chl(struct t7xx_port *port)
+{
+	spin_lock(&port->port_update_lock);
+	port->chan_enable = false;
+	spin_unlock(&port->port_update_lock);
+
+	return 0;
+}
+
+struct port_ops fastboot_port_ops = {
+	.init = t7xx_port_fastboot_init,
+	.recv_skb = t7xx_port_fastboot_recv_skb,
+	.uninit = t7xx_port_fastboot_uninit,
+	.enable_chl = t7xx_port_fastboot_enable_chl,
+	.disable_chl = t7xx_port_fastboot_disable_chl,
+};
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index e53a152faee4..7200d2d210fc 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -112,6 +112,9 @@ static const struct t7xx_port_conf t7xx_early_port_conf[] = {
 		.txq_exp_index = CLDMA_Q_IDX_DUMP,
 		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
 		.path_id = CLDMA_ID_AP,
+		.ops = &fastboot_port_ops,
+		.name = "fastboot",
+		.port_type = WWAN_PORT_FASTBOOT,
 	},
 };
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index 7f5706811445..0f40b4884dc0 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -98,6 +98,8 @@ extern struct port_ops ctl_port_ops;
 extern struct port_ops t7xx_trace_port_ops;
 #endif
 
+extern struct port_ops fastboot_port_ops;
+
 void t7xx_port_proxy_reset(struct port_proxy *port_prox);
 void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
 int t7xx_port_proxy_init(struct t7xx_modem *md);
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 3f5e8759705c..7cec51666f42 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -229,6 +229,7 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 	struct cldma_ctrl *md_ctrl;
 	enum lk_event_id lk_event;
 	struct device *dev;
+	struct t7xx_port *port;
 
 	dev = &md->t7xx_dev->pdev->dev;
 	lk_event = FIELD_GET(MISC_LK_EVENT_MASK, status);
@@ -244,6 +245,9 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 		t7xx_cldma_stop(md_ctrl);
 		t7xx_cldma_switch_cfg(md_ctrl, CLDMA_DEDICATED_Q_CFG);
 
+		port = &ctl->md->port_prox->ports[0];
+		port->port_conf->ops->enable_chl(port);
+
 		t7xx_cldma_start(md_ctrl);
 
 		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
-- 
2.34.1


