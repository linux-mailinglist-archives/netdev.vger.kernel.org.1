Return-Path: <netdev+bounces-23858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5879F76DE02
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D943281F8B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5A163D4;
	Thu,  3 Aug 2023 02:22:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9933539E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:22:17 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2178.outbound.protection.outlook.com [40.92.62.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9563A92
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWkjjVNUPjfLuKLexPs7My7PK+M9KRnWLHuMo7XhCetqyGoZOe/Vals8libk3ckLvWkOzHmAaF6pXN+ypUhimuIGBmvdKJVvmJikvLLUtZQ1x8GoGXJOXtNSA0Kj8cbP6z9dSxPz3bYZxXVjUNPQog2A4Q/HdxdvnrQMVP9ypKX05b44NebSrnjU0uEmWXnd/brd5DgRNd/cwD2QNOpqKjP7+3O9Por934rq6apNjYA5Ljda0M3iGhVPN/IuR8zWhGkJ+rHNKFNVd6aRXxViURk/pjxurwrqjFFiuSqplFOqStyIW7qLI+lz3Y2Gwi6uj5QVob+ojqDmngXKlGZrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx7W7gV05c0CkHJVqCBd6PDymHgtnNoz2IelrxUM6mM=;
 b=Nbh91aXTSEYbYDC4lKvhJcqjGjymwpr1AMNLdJeLmbzutjNP/eb9CVrRqtjsh//PVzUEPcnLzneCLB9oBkZGvyWHT3NftBuuooK7klxAnhLR6x1RrkbEDJL2kiAXMWU9zmY42z/quFQvPFb5y/9rDfcDipTEQb/B8HyPhv0c4YjzqtRxLwlyGug/YMFgoDi0tadWxHEu+EMgcaR47UkeO3SHnbslfs0dZJjdWRKNKy2OOYbwCtyr4UeBWa0JVBLEdY3vhkyBcc0NYR0pxr5MGVKtvgobj74whf0ChT5qXEsLKFFhocrfeG2IvxwrVBHILHfAkNYr8c0aT3CIC7QBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx7W7gV05c0CkHJVqCBd6PDymHgtnNoz2IelrxUM6mM=;
 b=tVwzfg6hFN+/isi5ZDSLrEhlsw2akHWEiJEOW0JM+kxAbkvQ/C76+oUFPYqpMI0rTftD0dQ64JzaL3GDRl6OocZR2fNqGLc+uXSJOOixPwmRB9AS9lXpijAM2apVBb2VzfYeYxIQ4+bfseYgqNLqP+/MSJa55idNuwRdtUb4P9uO5txuP81Mo46MGMh+fPf3gMKOc7/AlUAzP7ELcT9noDRDCzeTVLMrdrP+dXEFQX8+04bHcAwrLbj2O9PL9cLT1OJG4+DWUi/4R8sRp1GHkZOS6bIHNL+uS3WiOxOE/LgITmt9kWj4SRyec/qzsRGCS/by04lnCOObEQBRzAp+MA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB2245.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 02:21:59 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 02:21:59 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	johannes@sipsolutions.net,
	ryazanov.s.a@gmail.com,
	loic.poulain@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	edumazet@google.com,
	pabeni@redhat.com,
	chandrashekar.devegowda@intel.com,
	m.chetan.kumar@linux.intel.com,
	linuxwwan@intel.com,
	linuxwwan_5g@intel.com,
	soumya.prakash.mishra@intel.com,
	jesse.brandeburg@intel.com,
	danielwinkler@google.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next 3/6] net: wwan: t7xx: Implements devlink ops of firmware flashing
Date: Thu,  3 Aug 2023 10:18:09 +0800
Message-ID:
 <MEYP282MB2697937841838C688E1237FDBB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803021812.6126-1-songjinjian@hotmail.com>
References: <20230803021812.6126-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Kj/eBdg6onORajWT1xNfSP4rcYIucOTH]
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230803021812.6126-4-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB2245:EE_
X-MS-Office365-Filtering-Correlation-Id: 68199ecd-b3cb-4ebe-a55c-08db93c869e7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IrpzRgAq9VhYyf/JtcJATlUdhN/JQ3Cg4qq+uxinwiOSmnzSxc3Si0uSWxG3gekRwpg9gtZ4XuXnv9qu7uUZkwgr5s0C8B/sn+baST3OVQqjv6pSzY3aGgX+5UfVFJBdg/qwBbOoJMiicffBt4N5dn65CsunLY86GUi1xAk+NGjc1LXEeMh5wYVZ4IQr7+4ge4U7Q9LMpRz9JaIjWg13LWQ7tNjXKUzrOWwQr/AP38bjN75+jJkvO/mQrcdCwXLfY/Vp9ZLJjk88PrB+lvyhMDXknINCTgGf/nSCDNblrB7fEobcZEFy92VdiS/2VwIlStmnXzCNSiLAPL9CrRngczU+qw6h8/vqS6zUa978mCZjLoaODpwz9yyL3J6GsH3AIrwWeor8d53Dbt/7KY9tnOEbWPXS89FvB082tEheXZZQHTFWGLVWumQEjJUdi4YrH+v9quY9KtS749PhlCWehCWooQwzzkqhFTelqeMYOMpHmCc6UZer9NChWmzklmMx0DsaOzsIjz6Cu6EDMWRRaAtWUY/1/xxCiUMhAJPEcg0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5fafIzsObg4TMGvT74W5XkLVHsD6fACb13DAJAt/+IVv1BUq356KymYGWAdM?=
 =?us-ascii?Q?xUNnSttKTEuYex4SZZXZxp3FJ4qf3szI9nssxpeWvhyuW5u3kYVfYc5yf7m1?=
 =?us-ascii?Q?glw+yL3ImOswuwgRneHhBe370jq2tJc/x748rWcF6q5rWNIolVIw5rYSbvPt?=
 =?us-ascii?Q?oHxHJQ3duJTFCrDEWnEZPFvzRKZ1mAkqAVqd1YUENfd8R86TbrKyQVwxmAjK?=
 =?us-ascii?Q?J4PcEFYzXLLgm8Vo6sSvnMlqKpTU22bKtYmRjk7WWbr9FLpeKVDLxPn87+MV?=
 =?us-ascii?Q?LRUF/LN36EB6vO4rZ0+XUHCx39+9BWsH2ZYE/7cIP/A6Wr7ALC40kxIKnZon?=
 =?us-ascii?Q?VP7WgE9bErth1tbwzRSOi9HZ/Kbu+o00P8xUbEHyB0awv+tLbW8pJlkoleuf?=
 =?us-ascii?Q?+U21P9h/EGeUlEAhzvObUj5nfPcaP6+Lregs5928g7JGAOyvA9M+wPI8iwOM?=
 =?us-ascii?Q?gTpiTrHTNX39+i3PwuxI6hIFAcp3g462JhewEYHdSwHkNPaLy4SY+6nm0YWx?=
 =?us-ascii?Q?Zym46n4U8JMey+Y5C7iABMF4AfKRqq0HtqeVZlWncfvVofKU+GrJTVpgqcV8?=
 =?us-ascii?Q?3CSXtjB4izNH+KwGwkPZAHBPcNF3Iw8IB5fxJfzQTWbBMF87A7NRZNu7JoxK?=
 =?us-ascii?Q?NCDXda6AONly2Q52jhWx8bxO+pLf7XBcjoZIsilFLRGQlp4Q6ZCT8yi0WH+M?=
 =?us-ascii?Q?7k7jBvbBVQTOpWDH2PH7Z9cyJDC1znZkdFKwCLZU/yNHr7tKX2LUmKMkPQsO?=
 =?us-ascii?Q?rJY0uCGOJ3hPydoxXoQWc4FYOM7vXg24Qhz9U6G7gp3+Rxcz/f4evNe8xgSE?=
 =?us-ascii?Q?T76MHPSVTx1FgQPk2RYlChUXxUEYbahtUYeHPiSpdUM9QvnLYk3nQNzb5cfl?=
 =?us-ascii?Q?S9KsAnay7u/8ozMqP9j7bKUItLJVUJKM8nwlohSMtKU25O+2KdSYEHTvKBSc?=
 =?us-ascii?Q?HS0MGg6ziFiZdMHdGC7agIiYlv6sM1FZ3nk2gPvChtUFaoBY1AICig4dL9Zd?=
 =?us-ascii?Q?/mkfKG8j/1Z06Fe8FtsfOcNDXoqw4H2mlNspxN8rKXyau3J1JBSxXwCxfXY+?=
 =?us-ascii?Q?a563HwVJsGXOvKMl25PrFE05/pk+Rd0kD08HmjMTNYbBID421ldgJuH+/qIc?=
 =?us-ascii?Q?hkFCVDXTVA7BKKHiS5cRB5TK986f1Mdv5YStqa2dMhkVGSgHFyHaJ+RoBl9+?=
 =?us-ascii?Q?hPS1vpCe9Sw5PUavIwazLc/+Eh8/jfVZQAnpt0KeiK5QbPvu6IuUzvwtnQE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 68199ecd-b3cb-4ebe-a55c-08db93c869e7
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:21:59.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB2245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jinjian Song <jinjian.song@fibocom.com>

Adds support for t7xx wwan device firmware flashing using devlink.

On user space application issuing command for firmware update the driver
sends fastboot flash command & firmware to program NAND.

In flashing procedure the fastboot command & response are exchanged between
driver and device.

Below is the devlink command usage for firmware flashing

$devlink dev flash pci/$BDF file ABC.img component ABC

Note: ABC.img is the firmware to be programmed to "ABC" partition.

Base on the v5 patch version of follow series:
'net: wwan: t7xx: fw flashing & coredump support'
(https://patchwork.kernel.org/project/netdevbpf/patch/fc8bbb0b66a5ff3a489ea9857d79b374508090ef.1674307425.git.m.chetan.kumar@linux.intel.com/)

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 drivers/net/wwan/t7xx/Makefile             |   3 +-
 drivers/net/wwan/t7xx/t7xx_pci.c           |   2 +
 drivers/net/wwan/t7xx/t7xx_port.h          |   2 +
 drivers/net/wwan/t7xx/t7xx_port_devlink.c  | 325 ++++++++++++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_devlink.h  |  16 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c    |  12 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    |   1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c     |  22 +-
 drivers/net/wwan/t7xx/t7xx_reg.h           |   6 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.c |  42 ++-
 10 files changed, 400 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wwan/t7xx/Makefile b/drivers/net/wwan/t7xx/Makefile
index bb28e03eea68..1f98e28011fd 100644
--- a/drivers/net/wwan/t7xx/Makefile
+++ b/drivers/net/wwan/t7xx/Makefile
@@ -16,7 +16,8 @@ mtk_t7xx-y:=	t7xx_pci.o \
 		t7xx_hif_dpmaif_rx.o  \
 		t7xx_dpmaif.o \
 		t7xx_netdev.o \
-		t7xx_port_devlink.o
+		t7xx_port_devlink.o \
+		t7xx_port_ap_msg.o
 
 mtk_t7xx-$(CONFIG_WWAN_DEBUGFS) += \
 		t7xx_port_trace.o \
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 831819267989..5e9b954f39ce 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -766,6 +766,8 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	}
 
 	pci_free_irq_vectors(t7xx_dev->pdev);
+
+	t7xx_devlink_unregister(t7xx_dev);
 }
 
 static const struct pci_device_id t7xx_pci_table[] = {
diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
index 09acb1ef144d..dfa7ad2a9796 100644
--- a/drivers/net/wwan/t7xx/t7xx_port.h
+++ b/drivers/net/wwan/t7xx/t7xx_port.h
@@ -42,6 +42,8 @@ enum port_ch {
 	/* to AP */
 	PORT_CH_AP_CONTROL_RX = 0x1000,
 	PORT_CH_AP_CONTROL_TX = 0x1001,
+	PORT_CH_AP_MSG_RX = 0x101E,
+	PORT_CH_AP_MSG_TX = 0x101F,
 
 	/* to MD */
 	PORT_CH_CONTROL_RX = 0x2000,
diff --git a/drivers/net/wwan/t7xx/t7xx_port_devlink.c b/drivers/net/wwan/t7xx/t7xx_port_devlink.c
index 9c09464b28ee..f10804a2c0d7 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_devlink.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_devlink.c
@@ -6,12 +6,216 @@
 #include <linux/vmalloc.h>
 
 #include "t7xx_port_proxy.h"
+#include "t7xx_port_ap_msg.h"
 #include "t7xx_port_devlink.h"
 
+static int t7xx_devlink_port_read(struct t7xx_port *port, char *buf, size_t count)
+{
+	struct sk_buff *skb;
+	int read_len;
+
+	spin_lock_irq(&port->rx_wq.lock);
+	if (skb_queue_empty(&port->rx_skb_list)) {
+		int ret = wait_event_interruptible_locked_irq(port->rx_wq,
+							      !skb_queue_empty(&port->rx_skb_list));
+		if (ret == -ERESTARTSYS) {
+			spin_unlock_irq(&port->rx_wq.lock);
+			return ret;
+		}
+	}
+	skb = skb_dequeue(&port->rx_skb_list);
+	spin_unlock_irq(&port->rx_wq.lock);
+
+	read_len = min_t(size_t, count, skb->len);
+	memcpy(buf, skb->data, read_len);
+
+	if (read_len < skb->len) {
+		skb_pull(skb, read_len);
+		skb_queue_head(&port->rx_skb_list, skb);
+	} else {
+		consume_skb(skb);
+	}
+
+	return read_len;
+}
+
+static int t7xx_devlink_port_write(struct t7xx_port *port, const char *buf, size_t count)
+{
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+	size_t actual = count, offset = 0;
+	int txq_mtu;
+
+	txq_mtu = t7xx_get_port_mtu(port);
+	if (txq_mtu < 0)
+		return -EINVAL;
+
+	while (actual) {
+		int len = min_t(size_t, actual, txq_mtu);
+		struct sk_buff *skb;
+		int ret;
+
+		skb = __dev_alloc_skb(len, GFP_KERNEL);
+		if (!skb)
+			return -ENOMEM;
+
+		skb_put_data(skb, buf + offset, len);
+		ret = t7xx_port_send_raw_skb(port, skb);
+		if (ret) {
+			dev_err(port->dev, "write error on %s, size: %d, ret: %d\n",
+				port_conf->name, len, ret);
+			dev_kfree_skb(skb);
+			return ret;
+		}
+
+		offset += len;
+		actual -= len;
+	}
+
+	return count;
+}
+
+static int t7xx_devlink_fb_handle_response(struct t7xx_port *port, char *data)
+{
+	char status[T7XX_FB_RESPONSE_SIZE + 1];
+	int ret = 0, index;
+
+	for (index = 0; index < T7XX_FB_RESP_COUNT; index++) {
+		int read_bytes = t7xx_devlink_port_read(port, status, T7XX_FB_RESPONSE_SIZE);
+
+		if (read_bytes < 0) {
+			dev_err(port->dev, "status read interrupted\n");
+			ret = read_bytes;
+			break;
+		}
+
+		status[read_bytes] = '\0';
+		dev_dbg(port->dev, "raw response from device: %s\n", status);
+		if (!strncmp(status, T7XX_FB_RESP_INFO, strlen(T7XX_FB_RESP_INFO))) {
+			break;
+		} else if (!strncmp(status, T7XX_FB_RESP_OKAY, strlen(T7XX_FB_RESP_OKAY))) {
+			break;
+		} else if (!strncmp(status, T7XX_FB_RESP_FAIL, strlen(T7XX_FB_RESP_FAIL))) {
+			ret = -EPROTO;
+			break;
+		} else if (!strncmp(status, T7XX_FB_RESP_DATA, strlen(T7XX_FB_RESP_DATA))) {
+			if (data)
+				snprintf(data, T7XX_FB_RESPONSE_SIZE, "%s",
+					 status + strlen(T7XX_FB_RESP_DATA));
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int t7xx_devlink_fb_raw_command(char *cmd, struct t7xx_port *port, char *data)
+{
+	int ret, cmd_size = strlen(cmd);
+
+	if (cmd_size > T7XX_FB_COMMAND_SIZE) {
+		dev_err(port->dev, "command length %d is long\n", cmd_size);
+		return -EINVAL;
+	}
+
+	if (cmd_size != t7xx_devlink_port_write(port, cmd, cmd_size)) {
+		dev_err(port->dev, "raw command = %s write failed\n", cmd);
+		return -EIO;
+	}
+
+	dev_dbg(port->dev, "raw command = %s written to the device\n", cmd);
+	ret = t7xx_devlink_fb_handle_response(port, data);
+	if (ret)
+		dev_err(port->dev, "raw command = %s response FAILURE:%d\n", cmd, ret);
+
+	return ret;
+}
+
+static int t7xx_devlink_fb_download_command(struct t7xx_port *port, size_t size)
+{
+	char download_command[T7XX_FB_COMMAND_SIZE];
+
+	snprintf(download_command, sizeof(download_command), "%s:%08zx",
+		 T7XX_FB_CMD_DOWNLOAD, size);
+	return t7xx_devlink_fb_raw_command(download_command, port, NULL);
+}
+
+static int t7xx_devlink_fb_download(struct t7xx_port *port, const u8 *buf, size_t size)
+{
+	int ret;
+
+	if (!size)
+		return -EINVAL;
+
+	ret = t7xx_devlink_fb_download_command(port, size);
+	if (ret)
+		return ret;
+
+	ret = t7xx_devlink_port_write(port, buf, size);
+	if (ret < 0)
+		return ret;
+
+	return t7xx_devlink_fb_handle_response(port, NULL);
+}
+
+static int t7xx_devlink_fb_flash(struct t7xx_port *port, const char *cmd)
+{
+	char flash_command[T7XX_FB_COMMAND_SIZE];
+
+	snprintf(flash_command, sizeof(flash_command), "%s:%s", T7XX_FB_CMD_FLASH, cmd);
+	return t7xx_devlink_fb_raw_command(flash_command, port, NULL);
+}
+
+static int t7xx_devlink_fb_flash_partition(struct t7xx_port *port, const char *partition,
+					   const u8 *buf, size_t size)
+{
+	int ret;
+
+	ret = t7xx_devlink_fb_download(port, buf, size);
+	if (ret < 0)
+		return ret;
+
+	return t7xx_devlink_fb_flash(port, partition);
+}
+
 static int t7xx_devlink_flash_update(struct devlink *devlink,
 				     struct devlink_flash_update_params *params,
 				     struct netlink_ext_ack *extack)
 {
+	struct t7xx_devlink *dl = devlink_priv(devlink);
+	const char *component = params->component;
+	const struct firmware *fw = params->fw;
+	struct t7xx_port *port;
+	char flash_status[32];
+	int ret;
+
+	if (dl->mode != T7XX_FB_DL_MODE) {
+		dev_err(&dl->t7xx_dev->pdev->dev, "Modem is not in fastboot download mode!\n");
+		ret = -EPERM;
+		goto err_out;
+	}
+
+	if (dl->status != T7XX_DEVLINK_IDLE) {
+		dev_err(&dl->t7xx_dev->pdev->dev, "Modem is busy!\n");
+		ret = -EBUSY;
+		goto err_out;
+	}
+
+	if (!component || !fw->data) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	set_bit(T7XX_FLASH_STATUS, &dl->status);
+	port = dl->port;
+	dev_dbg(port->dev, "flash partition name:%s binary size:%zu\n", component, fw->size);
+	ret = t7xx_devlink_fb_flash_partition(port, component, fw->data, fw->size);
+
+	sprintf(flash_status, "%s %s", "flashing", !ret ? "success" : "failure");
+	devlink_flash_update_status_notify(devlink, flash_status, params->component, 0, 0);
+	clear_bit(T7XX_FLASH_STATUS, &dl->status);
+
+err_out:
+	return ret;
 	return 0;
 }
 
@@ -41,7 +245,19 @@ static int t7xx_devlink_reload_down(struct devlink *devlink, bool netns_change,
 				    enum devlink_reload_limit limit,
 				    struct netlink_ext_ack *extack)
 {
-	return 0;
+	struct t7xx_devlink *dl = devlink_priv(devlink);
+
+	switch (action) {
+	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
+		return 0;
+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
+		if (!dl->mode)
+			return -EPERM;
+		return t7xx_devlink_fb_raw_command(T7XX_FB_CMD_REBOOT, dl->port, NULL);
+	default:
+		/* Unsupported action should not get to this function */
+		return -EOPNOTSUPP;
+	}
 }
 
 static int t7xx_devlink_reload_up(struct devlink *devlink,
@@ -50,13 +266,114 @@ static int t7xx_devlink_reload_up(struct devlink *devlink,
 				  u32 *actions_performed,
 				  struct netlink_ext_ack *extack)
 {
-	return 0;
+	*actions_performed = BIT(action);
+	switch (action) {
+	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
+		return 0;
+	default:
+		/* Unsupported action should not get to this function */
+		return -EOPNOTSUPP;
+	}
+}
+
+static int t7xx_devlink_get_part_ver_fb_mode(struct t7xx_port *port, const char *cmd, char *data)
+{
+	char req_command[T7XX_FB_COMMAND_SIZE];
+
+	snprintf(req_command, sizeof(req_command), "%s:%s", T7XX_FB_CMD_GET_VER, cmd);
+	return t7xx_devlink_fb_raw_command(req_command, port, data);
+}
+
+static int t7xx_devlink_get_part_ver_norm_mode(struct t7xx_port *port, const char *cmd, char *data)
+{
+	char req_command[T7XX_FB_COMMAND_SIZE];
+	int len;
+
+	len = snprintf(req_command, sizeof(req_command), "%s:%s", T7XX_FB_CMD_GET_VER, cmd);
+	t7xx_port_ap_msg_tx(port, req_command, len);
+
+	return t7xx_devlink_fb_handle_response(port, data);
 }
 
 static int t7xx_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 				 struct netlink_ext_ack *extack)
 {
-	return 0;
+	struct t7xx_devlink *dl = devlink_priv(devlink);
+	char *part_name, *ver, *part_no, *data;
+	int ret, total_part, i, ver_len;
+	struct t7xx_port *port;
+
+	port = dl->port;
+	port->port_conf->ops->enable_chl(port);
+
+	if (dl->status != T7XX_DEVLINK_IDLE) {
+		dev_err(&dl->t7xx_dev->pdev->dev, "Modem is busy!\n");
+		return -EBUSY;
+	}
+
+	data = kzalloc(T7XX_FB_RESPONSE_SIZE, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	set_bit(T7XX_GET_INFO, &dl->status);
+	if (dl->mode == T7XX_FB_DL_MODE)
+		ret = t7xx_devlink_get_part_ver_fb_mode(port, "", data);
+	else
+		ret = t7xx_devlink_get_part_ver_norm_mode(port, "", data);
+
+	if (ret < 0)
+		goto err_clear_bit;
+
+	part_no = strsep(&data, ",");
+	if (kstrtoint(part_no, 16, &total_part)) {
+		dev_err(&dl->t7xx_dev->pdev->dev, "kstrtoint error!\n");
+		ret = -EINVAL;
+		goto err_clear_bit;
+	}
+
+	for (i = 0; i < total_part; i++) {
+		part_name = strsep(&data, ",");
+		ver = strsep(&data, ",");
+		ver_len = strlen(ver);
+		if (ver[ver_len - 2] == 0x5C && ver[ver_len - 1] == 0x6E)
+			ver[ver_len - 4] = '\0';
+		ret = devlink_info_version_running_put_ext(req, part_name, ver,
+							   DEVLINK_INFO_VERSION_TYPE_COMPONENT);
+	}
+
+err_clear_bit:
+	clear_bit(T7XX_GET_INFO, &dl->status);
+	kfree(data);
+	return ret;
+}
+
+struct devlink_info_req {
+	struct sk_buff *msg;
+	void (*version_cb)(const char *version_name,
+			   enum devlink_info_version_type version_type,
+			   void *version_cb_priv);
+	void *version_cb_priv;
+};
+
+struct devlink_flash_component_lookup_ctx {
+	const char *lookup_name;
+	bool lookup_name_found;
+};
+
+static int t7xx_devlink_info_get_loopback(struct devlink *devlink, struct devlink_info_req *req,
+					  struct netlink_ext_ack *extack)
+{
+	struct devlink_flash_component_lookup_ctx *lookup_ctx = req->version_cb_priv;
+	int ret;
+
+	if (!req)
+		return t7xx_devlink_info_get(devlink, req, extack);
+
+	ret = devlink_info_version_running_put_ext(req, lookup_ctx->lookup_name,
+						   "1.0", DEVLINK_INFO_VERSION_TYPE_COMPONENT);
+
+	return ret;
 }
 
 /* Call back function for devlink ops */
@@ -65,7 +382,7 @@ static const struct devlink_ops devlink_flash_ops = {
 	.flash_update = t7xx_devlink_flash_update,
 	.reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
 			  BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE),
-	.info_get = t7xx_devlink_info_get,
+	.info_get = t7xx_devlink_info_get_loopback,
 	.reload_down = t7xx_devlink_reload_down,
 	.reload_up = t7xx_devlink_reload_up,
 };
diff --git a/drivers/net/wwan/t7xx/t7xx_port_devlink.h b/drivers/net/wwan/t7xx/t7xx_port_devlink.h
index 12e5a63203af..92f0993e7205 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_devlink.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_devlink.h
@@ -10,9 +10,25 @@
 #include <linux/string.h>
 
 #define T7XX_MAX_QUEUE_LENGTH 32
+#define T7XX_FB_COMMAND_SIZE  64
+#define T7XX_FB_RESPONSE_SIZE 512
+#define T7XX_FB_RESP_COUNT    30
+
+#define T7XX_FLASH_STATUS   0
+#define T7XX_GET_INFO       3
 
 #define T7XX_DEVLINK_IDLE   0
 #define T7XX_NORMAL_MODE    0
+#define T7XX_FB_DL_MODE     1
+
+#define T7XX_FB_CMD_DOWNLOAD     "download"
+#define T7XX_FB_CMD_FLASH        "flash"
+#define T7XX_FB_CMD_REBOOT       "reboot"
+#define T7XX_FB_RESP_OKAY        "OKAY"
+#define T7XX_FB_RESP_FAIL        "FAIL"
+#define T7XX_FB_RESP_DATA        "DATA"
+#define T7XX_FB_RESP_INFO        "INFO"
+#define T7XX_FB_CMD_GET_VER      "get_version"
 
 struct t7xx_devlink {
 	struct t7xx_pci_dev *t7xx_dev;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index f185a7fb0265..9e22f751bb2e 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -40,6 +40,7 @@
 #define Q_IDX_CTRL			0
 #define Q_IDX_MBIM			2
 #define Q_IDX_AT_CMD			5
+#define Q_IDX_AP_MSG			2
 
 #define INVALID_SEQ_NUM			GENMASK(15, 0)
 
@@ -97,7 +98,18 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 		.path_id = CLDMA_ID_AP,
 		.ops = &ctl_port_ops,
 		.name = "t7xx_ap_ctrl",
+	}, {
+		.tx_ch = PORT_CH_AP_MSG_TX,
+		.rx_ch = PORT_CH_AP_MSG_RX,
+		.txq_index = Q_IDX_AP_MSG,
+		.rxq_index = Q_IDX_AP_MSG,
+		.txq_exp_index = Q_IDX_AP_MSG,
+		.rxq_exp_index = Q_IDX_AP_MSG,
+		.path_id = CLDMA_ID_AP,
+		.ops = &ap_msg_port_ops,
+		.name = "ap_msg",
 	},
+
 };
 
 static struct t7xx_port_conf t7xx_early_port_conf[] = {
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index c4cd1078ee92..030576a55623 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -94,6 +94,7 @@ struct ctrl_msg_header {
 extern struct port_ops wwan_sub_port_ops;
 extern struct port_ops ctl_port_ops;
 extern struct port_ops devlink_port_ops;
+extern struct port_ops ap_msg_port_ops;
 
 #ifdef CONFIG_WWAN_DEBUGFS
 extern struct port_ops t7xx_trace_port_ops;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index ddc20ddfa734..b4e2926f33f6 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -131,24 +131,6 @@ static int t7xx_port_wwan_recv_skb(struct t7xx_port *port, struct sk_buff *skb)
 	return 0;
 }
 
-static int t7xx_port_wwan_enable_chl(struct t7xx_port *port)
-{
-	spin_lock(&port->port_update_lock);
-	port->chan_enable = true;
-	spin_unlock(&port->port_update_lock);
-
-	return 0;
-}
-
-static int t7xx_port_wwan_disable_chl(struct t7xx_port *port)
-{
-	spin_lock(&port->port_update_lock);
-	port->chan_enable = false;
-	spin_unlock(&port->port_update_lock);
-
-	return 0;
-}
-
 static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int state)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
@@ -173,7 +155,7 @@ struct port_ops wwan_sub_port_ops = {
 	.init = t7xx_port_wwan_init,
 	.recv_skb = t7xx_port_wwan_recv_skb,
 	.uninit = t7xx_port_wwan_uninit,
-	.enable_chl = t7xx_port_wwan_enable_chl,
-	.disable_chl = t7xx_port_wwan_disable_chl,
+	.enable_chl = t7xx_port_enable_chl,
+	.disable_chl = t7xx_port_disable_chl,
 	.md_state_notify = t7xx_port_wwan_md_state_notify,
 };
diff --git a/drivers/net/wwan/t7xx/t7xx_reg.h b/drivers/net/wwan/t7xx/t7xx_reg.h
index 3b665c6116fe..b106c988321a 100644
--- a/drivers/net/wwan/t7xx/t7xx_reg.h
+++ b/drivers/net/wwan/t7xx/t7xx_reg.h
@@ -101,10 +101,16 @@ enum t7xx_pm_resume_state {
 	PM_RESUME_REG_STATE_L2_EXP,
 };
 
+enum host_event_e {
+	HOST_EVENT_INIT = 0,
+	FASTBOOT_DL_NOTIFY = 0x3,
+};
+
 #define T7XX_PCIE_MISC_DEV_STATUS		0x0d1c
 #define MISC_RESET_TYPE_FLDR			BIT(27)
 #define MISC_RESET_TYPE_PLDR			BIT(26)
 #define MISC_LK_EVENT_MASK			GENMASK(11, 8)
+#define HOST_EVENT_MASK			GENMASK(31, 28)
 
 enum lk_event_id {
 	LK_EVENT_NORMAL = 0,
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 9c51e332e7c5..a6147f2324a6 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -37,6 +37,7 @@
 #include "t7xx_modem_ops.h"
 #include "t7xx_pci.h"
 #include "t7xx_pcie_mac.h"
+#include "t7xx_port_devlink.h"
 #include "t7xx_port_proxy.h"
 #include "t7xx_reg.h"
 #include "t7xx_state_monitor.h"
@@ -206,11 +207,22 @@ static void fsm_routine_exception(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comm
 		fsm_finish_command(ctl, cmd, 0);
 }
 
+static void t7xx_host_event_notify(struct t7xx_modem *md, unsigned int event_id)
+{
+	u32 value;
+
+	value = ioread32(IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+	value &= ~HOST_EVENT_MASK;
+	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
+	iowrite32(value, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+}
+
 static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int status)
 {
 	struct t7xx_modem *md = ctl->md;
 	struct cldma_ctrl *md_ctrl;
 	enum lk_event_id lk_event;
+	struct t7xx_port *port;
 	struct device *dev;
 
 	dev = &md->t7xx_dev->pdev->dev;
@@ -221,10 +233,19 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 		break;
 
 	case LK_EVENT_CREATE_PD_PORT:
+	case LK_EVENT_CREATE_POST_DL_PORT:
 		md_ctrl = md->md_ctrl[CLDMA_ID_AP];
 		t7xx_cldma_hif_hw_init(md_ctrl);
 		t7xx_cldma_stop(md_ctrl);
 		t7xx_cldma_switch_cfg(md_ctrl, CLDMA_DEDICATED_Q_CFG);
+		port = ctl->md->t7xx_dev->dl->port;
+		if (WARN_ON(!port))
+			return;
+
+		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
+			md->t7xx_dev->dl->mode = T7XX_FB_DL_MODE;
+
+		port->port_conf->ops->enable_chl(port);
 		t7xx_cldma_start(md_ctrl);
 		break;
 
@@ -258,7 +279,9 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
 	struct cldma_ctrl *md_ctrl;
 	int err;
 
-	if (ctl->curr_state == FSM_STATE_STOPPED || ctl->curr_state == FSM_STATE_STOPPING) {
+	if (ctl->curr_state == FSM_STATE_STOPPED ||
+	    ctl->curr_state == FSM_STATE_STOPPING ||
+	    ctl->md->rgu_irq_asserted) {
 		fsm_finish_command(ctl, cmd, -EINVAL);
 		return;
 	}
@@ -270,11 +293,18 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_TO_STOP);
 	t7xx_cldma_stop(md_ctrl);
 
-	if (!ctl->md->rgu_irq_asserted) {
-		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
-		/* Wait for the DRM disable to take effect */
-		msleep(FSM_DRM_DISABLE_DELAY_MS);
-
+	if (t7xx_devlink_param_get_fastboot(t7xx_dev->dl->ctx))
+		t7xx_host_event_notify(ctl->md, FASTBOOT_DL_NOTIFY);
+
+	t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
+	/* Wait for the DRM disable to take effect */
+	msleep(FSM_DRM_DISABLE_DELAY_MS);
+	if (t7xx_devlink_param_get_fastboot(t7xx_dev->dl->ctx)) {
+		/* Do not try fldr because device will always wait for
+		 * MHCCIF bit 13 in fastboot download flow.
+		 */
+		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
+	} else {
 		err = t7xx_acpi_fldr_func(t7xx_dev);
 		if (err)
 			t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
-- 
2.34.1


