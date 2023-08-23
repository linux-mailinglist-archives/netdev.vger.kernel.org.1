Return-Path: <netdev+bounces-30022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D73785A5E
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0572728133C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24A4C2C6;
	Wed, 23 Aug 2023 14:22:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB81C2C3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:22:45 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2185.outbound.protection.outlook.com [40.92.62.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CD3E5A
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU7cGl6petLHJ4QV86u8ORTUhApy7lvL5mvXkdDzrqam5UTWuk/xrsqR7JjWm/pOHndJpHErMhOVN7W6NIBvV+Zi93G4yvkDE18EpdV1LpYa/ipZU5MUPYFz3BHOf08STmUN2wnNDfq06ly5R+qZW2oP2kmh6pRIqgM/AKaXBoQVB7ujH9zM+piFLoN77bA1EWB0mQyQcX5ASsYoBySzmeKgu+FaPnSJO+iM4TsSdFi5tCPIDEf5ecw4ayJT8aGNqH0LEnZszTZNwlSo1k4+ohdd5OeV9idMl08zbakJZgx9Gn7tl2wZVENQyFNFlMzskvJJiYKvh+BPs644D2FZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfsOBF9TR9YHRHF+oRDr01gZ3/bN4VHTCPMYHnTS3kg=;
 b=XU2LTo215BNHjSBvLPMOJ5vHjMxgVZ0D4nBLrNQ8rxGOim7j2qwmQTcZMsidI8NZ1LHxSE6HPtgDFKXZ0btV2/Hgwoz7Mf7gJ/uk/Vznhi5qTnvnXrOJ8OLmeYRfhZ4oxrqO1aDl2ffuewCDo8NvRsg7d0iZMij1sAG/iELYyL5PEMJOTZpOjYzmVSXqHW1rmPEoQZXT4QkS3zw3hjPJ5g4AMEf8X/ZijfHEuvjBexSgCSYmbTzXOgXIr92hpCUfw2b1kZdbZOv7ixP+SVQa+F/xvcAsxm8gL9uujl2kHLKoYBRfJTeAza1lAkhfGmKUwty/AOwy62CfMD+LUR5doA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfsOBF9TR9YHRHF+oRDr01gZ3/bN4VHTCPMYHnTS3kg=;
 b=jNoqrecmc8HmEgjtyLvnrrlnWWMZAvSHY6IMNWPhIosQfMdcphSpjgTD81qV2O+Lw3yeQcMSqRg1ewgjCmreJlItbJNToJqkCn1IxUiYkmua9limKdXtCHFBg24ozXtBIgl3//zRNFp7aEpPvQSRAQGLceCpufUUhHVtwip/DfssRxB7JdC099To6ePJCVNgLq8hYjg4zJ1XfCJLyUaYWZ4oLZKK1cDMXOC82Kutv82MHXiE5dNhP32xF7w/BIqU9i67vhny27LQysSVhHYhsL2TVLIN/T8XorW+mkD+er0ZXRdkTEhPnB+AfU4fijlvhwyqstx3XSb9SW7BKj3g2w==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY6P282MB3375.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 14:22:36 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:22:36 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	ilpo.jarvinen@linux.intel.com,
	jesse.brandeburg@intel.com,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linuxwwan@intel.com,
	linuxwwan_5g@intel.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	soumya.prakash.mishra@intel.com,
	nmarupaka@google.com,
	vsankar@lenovo.com
Subject: [net-next v2 4/5] net: wwan: t7xx: Adds sysfs attribute of modem event
Date: Wed, 23 Aug 2023 22:21:28 +0800
Message-ID:
 <MEYP282MB2697E2CF8EA7A5D6CFF30535BB1CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823142129.20566-1-songjinjian@hotmail.com>
References: <20230823142129.20566-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [i/w5AwPn1EV54+zOVyVvZjcqXFRPrM8n]
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230823142129.20566-5-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY6P282MB3375:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8a850f-9c21-46b1-70fb-08dba3e46614
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d/aahX0weEZ1e3NRcmpVn1AS8LxApWcMP6PECdpTclB4oNrehDC4WslhB/Oh0wNIoxgMgQxoonb8QF21JgcYAWH06H/CrhPiwjKMdIWFzW6KcVpuN41qMBguFqkyeRdn/dI/IFQ3ZhVfxBYjNoHasjHeGn9EYmg38sqmc4rrBoyqkmbzNgbfL1pFFAdIL6/0awQNRk5tSPGPRVrwCxk0t4rPg4FE/FeP2tzJRXiViFPZLItLQAQJOYSosag3nGoWw1ug8ZHMDnkAF8XXNswAaqlZoqS9NkwQOZBzt1+QZ5dQ4axDREV04RrTIXSIb+llZu4Wkgt9RXcIlIoamSt6UNZEv6fPyoLmBCJ7/rDtcQ+qUVH0r3vch8Js50dZYypQpPoOupnlDeCfWHoWhL8lkzKHUEuTNGZXrLpb0uXjKFp7/C6RAfM0kkLMdqDDxBKkFEjAh/KrnTN15752aUeOe6cgZjOj+fyi0I8rLIk534xL/14fk7F9pSywLSco51GhFfy6ouLeQdZRU72FhVpr5RugFg+Q3Z0n4LhpeDQ8HS8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l4rWDf07HA41ocXrYkq9xczuQf/HXjpiQTkw4/CW1v3lsiJuEpPXL8vrzfyL?=
 =?us-ascii?Q?26SOpIf8QW9ZWB9ZCizcUgAN79Z9BlGnFCEICf4w/Wjl59GjsEs3VuMftUUM?=
 =?us-ascii?Q?lNyUHMSGZuP6jrOxGuFWvtF9y5RayHKYVt2dsKjlIuLplsjQ65nhSOIg7gr8?=
 =?us-ascii?Q?VM9mnBoaX8BWCQyjNXHcwWJ9SJXui5gKQeDLiq8xyib6eZ/J9GUzZTgzg8/8?=
 =?us-ascii?Q?HW/Yz/C2gXfMq5i1CVSBJbSg1L/sZuiARxjwgFspgXZMWh2hb2wsFhIN98/7?=
 =?us-ascii?Q?zn5BUkPJBIcG31rvR2P9Ie/oTs2/iBcYm/NSr8e4ZiVWq4KuoRhT9xmRC+Qx?=
 =?us-ascii?Q?rZwGjzpjG3RRaefRwGRGFM9es9ml+sFFbuyKbkgwKvgmtR1x7HSKo+X2LHsG?=
 =?us-ascii?Q?PCS5eAl1Qm0+OAlMYLZV1JR2nLEs28uWa5vig2TeaYzgrkXCrascMPneTjcX?=
 =?us-ascii?Q?OCZ/y87ZoC/eeFv0IVu/EJRylLHnvadXOyVGABW5tAef9q2S4yB9M0XngXAM?=
 =?us-ascii?Q?qf3338f+cU261/KN0JqKQzuym3yFaxKB27Y4MSLHtwT6YrI0g0J5/DHUqxOX?=
 =?us-ascii?Q?b0Fdq3qjOTFU3ek3FZuEMHcrvLoCfOY3HWpH+o0ERrYRXRYssTb53wRgj6xZ?=
 =?us-ascii?Q?rzcAZSpsVb+U3AJeO+wNTKvMWcOjBrmlHaYiPvGgLJUZxzDbtqn0ajHIXyk8?=
 =?us-ascii?Q?1o9zYlHRSEeSA8D7eXFo81/po+grRKLDkNa3gWRZT3QSnaGFCJP+pr1tAnHR?=
 =?us-ascii?Q?+g4LiAjdGzyxhmp/Vult/zO2Q80hUeIgG3KHOcgb/E0yBv/if5wswaqjYIVB?=
 =?us-ascii?Q?UGGcCMuLSoe0QPFI2rc91GNuBMh73+K7cxqkwfNyn8jOdqpy92cWWbtJRwjR?=
 =?us-ascii?Q?oMItYRy4CTEEfB0l67wHPqtlGN9MKA9TC98srSCoQVzWeS7moTmQ69ulmrbh?=
 =?us-ascii?Q?Esih59oavZyVb+HzgyOSIwDFBQCUgdFpyovfri+O+a9x2YKny8caUaR/y1mg?=
 =?us-ascii?Q?FKjzNeOa00B10PQASnCwM2oJO5kcIqqQZEJA5jayhyaQuVECz+89WNQplP+w?=
 =?us-ascii?Q?q3uq9DE9gEjXyDqAGMNNGLkv4vyxTUMtJp+zcEc3BWaOGt+O6wVhDE55TMRb?=
 =?us-ascii?Q?9qUy8wUdj7Pog1Wnx6QruoqCGS0gN1oQxiv0/WJwkcsou1SCZe9NIWro2gG3?=
 =?us-ascii?Q?z7OTqzV5WLWBPFz6Kp4Vtbfb23S/LoCumyqfPhi6YM5sC9lXgzxV0GmFV5A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8a850f-9c21-46b1-70fb-08dba3e46614
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:22:36.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3375
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jinjian Song <jinjian.song@fibocom.com>

Adds support for t7xx wwan device firmware flashing & coredump collection
using devlink.

Provides sysfs attribute on user space to query the event from modem
about flashing/coredump/reset.

Base on the v5 patch version of follow series:
'net: wwan: t7xx: fw flashing & coredump support'
(https://patchwork.kernel.org/project/netdevbpf/patch/fc8bbb0b66a5ff3a489ea9857d79b374508090ef.1674307425.git.m.chetan.kumar@linux.intel.com/)

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v2:
 * rename struct name from devlink to flash_dump
---
 drivers/net/wwan/t7xx/t7xx_modem_ops.c       |  1 +
 drivers/net/wwan/t7xx/t7xx_pci.c             | 62 ++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.h             | 17 ++++++
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.c | 14 +++++
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.h |  1 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.c   |  7 +++
 6 files changed, 102 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index cbd65aa48721..4de75874f1b5 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -192,6 +192,7 @@ static irqreturn_t t7xx_rgu_isr_thread(int irq, void *data)
 {
 	struct t7xx_pci_dev *t7xx_dev = data;
 
+	atomic_set(&t7xx_dev->event, T7XX_RESET);
 	msleep(RGU_RESET_DELAY_MS);
 	t7xx_reset_device_via_pmic(t7xx_dev);
 	return IRQ_HANDLED;
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 845d1555f134..e5579e04f82d 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2021, MediaTek Inc.
  * Copyright (c) 2021-2022, Intel Corporation.
+ * Copyright (c) 2023, Fibocom Wireless Inc.
  *
  * Authors:
  *  Haijun Liu <haijun.liu@mediatek.com>
@@ -14,6 +15,7 @@
  *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
  *  Eliot Lee <eliot.lee@intel.com>
  *  Moises Veleta <moises.veleta@intel.com>
+ *  Jinjian Song <jinjian.song@fibocom.com>
  */
 
 #include <linux/atomic.h>
@@ -60,6 +62,57 @@ enum t7xx_pm_state {
 	MTK_PM_RESUMED,
 };
 
+static ssize_t t7xx_event_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	enum t7xx_event event = T7XX_UNKNOWN;
+	struct pci_dev *pdev;
+	struct t7xx_pci_dev *t7xx_dev;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	event = atomic_read(&t7xx_dev->event);
+	if (event == T7XX_READY) {
+		return sprintf(buf, "T7XX_MODEM_READY\n");
+	} else if (event == T7XX_RESET) {
+		return sprintf(buf, "T7XX_RESET\n");
+	} else if (event == T7XX_FASTBOOT_DL_MODE) {
+		return sprintf(buf, "T7XX_MODEM_FASTBOOT_DL_MODE\n");
+	} else if (event == T7XX_FLASH_SUCCESS) {
+		return sprintf(buf, "T7XX_FLASHING_SUCCESS\n");
+	} else if (event == T7XX_FLASH_FAILURE) {
+		return sprintf(buf, "T7XX_FLASHING_FAILURE\n");
+	} else if (event == T7XX_FASTBOOT_DUMP_MODE) {
+		return sprintf(buf, "T7XX_MODEM_FASTBOOT_DUMP_MODE\n");
+	} else if (event == T7XX_MRDUMP_READY) {
+		return sprintf(buf, "T7XX_MRDUMP_READY size:%zu\n",
+			       t7xx_dev->flash_dump->regions[T7XX_MRDUMP_INDEX].info->dump_size);
+	} else if (event == T7XX_LKDUMP_READY) {
+		return sprintf(buf, "T7XX_LKDUMP_READY size:%zu\n",
+			       t7xx_dev->flash_dump->regions[T7XX_LKDUMP_INDEX].info->dump_size);
+	} else if (event == T7XX_MRDUMP_DISCARD) {
+		return sprintf(buf, "T7XX_MRDUMP_DISCARDED\n");
+	} else if (event == T7XX_LKDUMP_DISCARD) {
+		return sprintf(buf, "T7XX_LKDUMP_DISCARDED\n");
+	}
+
+	return sprintf(buf, "T7XX_UNKNOWN\n");
+}
+
+static DEVICE_ATTR_RO(t7xx_event);
+
+static struct attribute *t7xx_event_attr[] = {
+	&dev_attr_t7xx_event.attr,
+	NULL
+};
+
+static const struct attribute_group t7xx_event_attribute_group = {
+	.attrs = t7xx_event_attr,
+};
+
 static void t7xx_dev_set_sleep_capability(struct t7xx_pci_dev *t7xx_dev, bool enable)
 {
 	void __iomem *ctrl_reg = IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_CTRL;
@@ -734,8 +787,17 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
 
+	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
+				 &t7xx_event_attribute_group);
+	if (ret) {
+		t7xx_md_exit(t7xx_dev);
+		goto err_devlink_unregister;
+	}
+
 	ret = t7xx_interrupt_init(t7xx_dev);
 	if (ret) {
+		sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
+				   &t7xx_event_attribute_group);
 		t7xx_md_exit(t7xx_dev);
 		goto err_devlink_unregister;
 	}
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index 28f22a2dc493..b7c78a9530f3 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -2,6 +2,7 @@
  *
  * Copyright (c) 2021, MediaTek Inc.
  * Copyright (c) 2021-2022, Intel Corporation.
+ * Copyright (c) 2023, Fibocom Wireless Inc.
  *
  * Authors:
  *  Haijun Liu <haijun.liu@mediatek.com>
@@ -12,6 +13,7 @@
  *  Amir Hanania <amir.hanania@intel.com>
  *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
  *  Moises Veleta <moises.veleta@intel.com>
+ *  Jinjian Song <jinjian.song@fibocom.com>
  */
 
 #ifndef __T7XX_PCI_H__
@@ -84,6 +86,7 @@ struct t7xx_pci_dev {
 	struct dentry		*debugfs_dir;
 #endif
 	struct t7xx_flash_dump	*flash_dump;
+	atomic_t		event;
 };
 
 enum t7xx_pm_id {
@@ -115,6 +118,20 @@ struct md_pm_entity {
 	void			*entity_param;
 };
 
+enum t7xx_event {
+	T7XX_UNKNOWN,
+	T7XX_READY,
+	T7XX_RESET,
+	T7XX_FASTBOOT_DL_MODE,
+	T7XX_FLASH_SUCCESS,
+	T7XX_FLASH_FAILURE,
+	T7XX_FASTBOOT_DUMP_MODE,
+	T7XX_MRDUMP_READY,
+	T7XX_LKDUMP_READY,
+	T7XX_MRDUMP_DISCARD,
+	T7XX_LKDUMP_DISCARD,
+};
+
 void t7xx_pci_disable_sleep(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_pci_enable_sleep(struct t7xx_pci_dev *t7xx_dev);
 int t7xx_pci_sleep_disable_complete(struct t7xx_pci_dev *t7xx_dev);
diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
index b8ef3b7d7430..0a0f2847aa3f 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
@@ -201,11 +201,14 @@ static int t7xx_flash_dump_fb_get_core(struct t7xx_port *port)
 			continue;
 		} else if (!strcmp(mcmd, T7XX_FB_RESP_MRDUMP_DONE)) {
 			dev_dbg(port->dev, "%s! size:%zd\n", T7XX_FB_RESP_MRDUMP_DONE, offset_dlen);
+			flash_dump->regions[T7XX_MRDUMP_INDEX].info->dump_size = offset_dlen;
+			atomic_set(&port->t7xx_dev->event, T7XX_MRDUMP_READY);
 			clear_bit(T7XX_MRDUMP_STATUS, &flash_dump->status);
 			return 0;
 		}
 		dev_err(port->dev, "getcore protocol error (read len %05d, response %s)\n",
 			clen, mcmd);
+		atomic_set(&port->t7xx_dev->event, T7XX_MRDUMP_DISCARD);
 		ret = -EPROTO;
 		goto free_mem;
 	}
@@ -248,6 +251,7 @@ static int t7xx_flash_dump_fb_dump_log(struct t7xx_port *port)
 	if (datasize > lkdump_region->info->size) {
 		dev_err(port->dev, "lkdump size is more than %dKB. Discarded!\n",
 			T7XX_LKDUMP_SIZE / 1024);
+		atomic_set(&port->t7xx_dev->event, T7XX_LKDUMP_DISCARD);
 		ret = -EFBIG;
 		goto err_clear_bit;
 	}
@@ -272,6 +276,8 @@ static int t7xx_flash_dump_fb_dump_log(struct t7xx_port *port)
 	}
 
 	dev_dbg(port->dev, "LKDUMP DONE! size:%zd\n", offset);
+	lkdump_region->info->dump_size = offset;
+	atomic_set(&port->t7xx_dev->event, T7XX_LKDUMP_READY);
 	clear_bit(T7XX_LKDUMP_STATUS, &flash_dump->status);
 	return t7xx_flash_dump_fb_handle_response(port, NULL);
 
@@ -361,6 +367,10 @@ static int t7xx_devlink_flash_update(struct devlink *devlink,
 	clear_bit(T7XX_FLASH_STATUS, &flash_dump->status);
 
 err_out:
+	if (ret)
+		atomic_set(&port->t7xx_dev->event, T7XX_FLASH_FAILURE);
+	else
+		atomic_set(&port->t7xx_dev->event, T7XX_FLASH_SUCCESS);
 	return ret;
 }
 
@@ -411,9 +421,13 @@ static int t7xx_devlink_reload_up(struct devlink *devlink,
 				  u32 *actions_performed,
 				  struct netlink_ext_ack *extack)
 {
+	struct t7xx_flash_dump *flash_dump = devlink_priv(devlink);
+
 	*actions_performed = BIT(action);
 	switch (action) {
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
+		atomic_set(&flash_dump->t7xx_dev->event, T7XX_RESET);
+		return 0;
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
 		return 0;
 	default:
diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
index 90758baa7854..057bb36216ca 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
@@ -57,6 +57,7 @@ enum t7xx_regions {
 struct t7xx_dump_region_info {
 	const char *name;
 	size_t size;
+	size_t dump_size;
 };
 
 struct t7xx_dump_region {
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 86cdb0d572d4..ab35342a2d16 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -249,6 +249,12 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 
 		port->port_conf->ops->enable_chl(port);
 		t7xx_cldma_start(md_ctrl);
+
+		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
+			atomic_set(&md->t7xx_dev->event, T7XX_FASTBOOT_DL_MODE);
+		else
+			atomic_set(&md->t7xx_dev->event, T7XX_FASTBOOT_DUMP_MODE);
+
 		break;
 
 	default:
@@ -332,6 +338,7 @@ static void fsm_routine_ready(struct t7xx_fsm_ctl *ctl)
 
 	ctl->curr_state = FSM_STATE_READY;
 	t7xx_fsm_broadcast_ready_state(ctl);
+	atomic_set(&md->t7xx_dev->event, T7XX_READY);
 	t7xx_md_event_notify(md, FSM_READY);
 }
 
-- 
2.34.1


