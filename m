Return-Path: <netdev+bounces-23871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB376DEA3
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74E51C21408
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1803E7474;
	Thu,  3 Aug 2023 02:58:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051AD8475
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:58:56 +0000 (UTC)
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2141.outbound.protection.outlook.com [40.92.63.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF45139
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS6UdJyyhf8mGJBOz6PCYsUF8Oki7aiE7Oz340qnrBi+RDqpChSquPZrwaT0yG3YT7NoRqNVthOd22CWaVERAT53LG/viw2ChXjEtByrKKzwSe225QIiCcli4+sUWk4iWXUskdIYkoMdVTOvVzd1oHov+50EHtQpwBNum+i36fSoQCvqoUAVNEIS7gZR1FIm9b1vOms2JCS7ImuRDfEon0aC+dVRO/F+lHdwHtjDCzXXnPdzI1mjZbjFi5rcK0svloAfx6TjwUTZ3wc+ckzW7hIDL8O817gKkFu30/vzsjk0dUn+v47tahamHklZZMBmUtH1xKuXAAcaX+X/ZGuLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07O5d5GfwqZ3LC1XdbdDCYcNLN8JLw41NrQzUCcEqJ8=;
 b=nX79AZAAGNRhMFJQW6hVVx2R7g/KeIcmwh64hCB1C94uq58iM3wor0JbeCOafD8w+/vY2Q9VFswxjbgSFOlnS7HJfww4/JsDDk8V7AHLXVJOlxyC9PM4UxPtExt7K4unJU6qtQ8+VzOXXiQxNVuV6iOdIWZ3PRMXQScZtLqtKq/86b+1gAJfCSQtuYe0JLdjgslFdNA0xI/EpPNGNRXhOQIKpIFqzm1N849356ko5mIGKahAD1hWR4OX5gXb4XK7OntERFqVE4oAW8wEG+y1E5USPosuACjMinihKgKFDgTq+Rh67WUQ9wj4aiHwbpxzNVKY98a7UY/y2V7HfSHJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07O5d5GfwqZ3LC1XdbdDCYcNLN8JLw41NrQzUCcEqJ8=;
 b=ka2JOu8ztcBIMwqq3kN4cspumetizsEz2pS0eBf7MxTGhq+2H6wAIOzzdMVjg75X+/WObY83Azgx8Uw2JoPlXdG/65/hS11i2BeIOMO+NxekbEqlXOwribOTDNDl6T+Wt7MiZpsbc+5LY6Qb602ZKBHT8toCk7ttHi+7alJ9D78ScV+psbsW9x/+eXwbAX5MrFsxTwEBbq5sZJFWAs4A+u8oEUBy5hbCC23tc4fkkuLOl8YwBCdInGca+ljT4flRan4v+sFRONlwgX7WdOkX/fmqTTubq86B9t3F8JBjdF+VHL7WQ2CvIBiwH7F9b2PnVlA5O2tyAtvSqIOaBWtCNw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:156::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 02:58:46 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 02:58:46 +0000
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
Subject: [net-next 5/6] net: wwan: t7xx: Adds sysfs attribute of modem event
Date: Thu,  3 Aug 2023 10:58:01 +0800
Message-ID:
 <MEYP282MB2697CCD2C2C4CD0F5CB6146FBB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803025802.3534-1-songjinjian@hotmail.com>
References: <20230803025802.3534-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [aZZN4681DT6BEXPsr6E6DeFir2GnN4Qv]
X-ClientProxiedBy: TYAPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:404::23)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230803025802.3534-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SYBP282MB2963:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c2b2a5-3e44-43f8-710c-08db93cd8de4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IXK85OGQGhn8FPhcWQW4FNTSx3UhiJDJ8FD3Cap7LuWqfzpdaqjZ5dWb+NUxh38QQH1o33D29S8k6h2Zci+rSlKPin2IgEGKOsFK3G66BFn3aQ3D/VK0lEWOnf3O9wM9ka9SZ73imJuUb0I5C0n0AxWMpPoAYLd2XGEzxRXzTO6VeA9dXe5KkwRgXh3zOX5eJWLuBC47uwH4RuaLXlhdD4zxvbKQuJYtQ1w4vvgbQEB6rBbEnsaZKnplfKuAv4HgDP6jQOF3nJfBo4lHCq9hQbJVeWAS9fSNWGFTT4Ip0GCH3s4n08simtnnihciYnLWcDc0DCmIB2FSEOY19l5iVvyxgqwMqRA0lHJ6vdOFK4W/Ce8rxNq986BTzKNQML7bkGpphfCuFrHlgP7IcShL5OF/jFr2aj5KcWiOqEZtCcVnaUS02Ur5cNro3VvNoRGMWErmyed7Ah0ZtbO4n2r/3wWtPL2LzXtDz9TQ79kB95DTFo5jaxGilKaHXQ91/tLj0SUKcAGHTmTzmUazONyZ+J33TvhKXmrjkBXa0ctrqhY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CSMDls9ILPqp+rTxYBQFHoZyf3RNYKM3QBHLlAcjxqalPn8GzanwdSKmPSvl?=
 =?us-ascii?Q?oqo1u+Iqe5eIH7MTQVKpY8XTVTJXcXlS0K05rVERxrXRErvj8QCuZECOSHuO?=
 =?us-ascii?Q?hkKhW9AuERF96AjjCU3cRXZSKRgS6zMKes2owLl0qOItpm6gIt7V0Mf+KBMx?=
 =?us-ascii?Q?UmpcD9T8QUeIoLOJhCq8A6pG+fZ0iJENW9shFdwrTR/snprpn6IFoxdIcZxV?=
 =?us-ascii?Q?w+nqJJft7cL7R7sqosfcq6mrAkjBL2xIHmf4RvCgRC5UMPiFSSZPWZCD+V35?=
 =?us-ascii?Q?WLrBM+pblmGxM4R1VThkiT9jtFHmOo+PcSBhoGTM/lFCyetkE70RMOeE4QEX?=
 =?us-ascii?Q?PVG7MsoQZbNq6VCep4gDC6VAxZIE/GvquxteTmtjvhETAJ4SLHdXAzCVvO3e?=
 =?us-ascii?Q?T3I4DFjg5Mt0MdLvBk1XwBxCcSvmV9FfAgjY1gCrrpwkW2GkV2MPeVVXWHl0?=
 =?us-ascii?Q?tbd7fhNwFG2akptZ5G/Vw2YLQDXc+cMOspnDTbN3tbVzKdjjMOsh+OCh3gDA?=
 =?us-ascii?Q?piUESiC3iVXnfcjgGBe3X1dn9YWj1xD/b0G0AZIKmO7E9Jj351vX55TCY+jV?=
 =?us-ascii?Q?1ahhoCBGXHS0HzPPfAuPwzJGtoKVlu7PCVkJUA4TTeGu5i9TpiA+8JtQtFIt?=
 =?us-ascii?Q?rfjswJH79Hm2Ysab6UfQntL1rNOYcOLLowVINYRlKkQZlYQjhQ+TY7EcG+PE?=
 =?us-ascii?Q?MmOPsQz8RRbserqjp45x0QOcyjpiaM4WOHHz4o846kqZtdRjJ05DfLe9zLf4?=
 =?us-ascii?Q?jnVnZY0RAYmbho8cOVezRgaTD2dqLzRvSt7uerjaFUiLZUZxF6XqjSZICjJm?=
 =?us-ascii?Q?qyPhaJFb0RvZPQPtxmxk2cDx7ofHF9r+TLzCKkF+f66ngKqXy9rJ83KzgpaW?=
 =?us-ascii?Q?GhBmDReyRYBLCnR+7l/u1DMU16z1hcfrFCfGblhN9tNfWlJMikYJSuSpPv4Y?=
 =?us-ascii?Q?yAwD3X8HKmb1Jbty/tOzCaZ29WipIEdy24j7V9B8lP7rl2wd2QHi9ZMV+5/9?=
 =?us-ascii?Q?HvHqSZh45xBIQDUmBsu3DB1t3isByshWDmDH5TnxtyseEgaLN669mls06KR9?=
 =?us-ascii?Q?cKJ1PgA2ElVJ6t6tSYTPChaegn5UKVP+KoiKzCxoZhkHxD5Kf3YSqi09nleN?=
 =?us-ascii?Q?dZ8zH5mobRD2Ejx3t70mXYCwMaqaGelRb+qNE46bWgBRtqmGcQsZm7F21d6N?=
 =?us-ascii?Q?ezYwSCBQqr/cOQ7Ib+/vEY+0CUlhpO6nBfygKGxnqAbDRMZ8lJ8horHHfNY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c2b2a5-3e44-43f8-710c-08db93cd8de4
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:58:46.4934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB2963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     |  1 +
 drivers/net/wwan/t7xx/t7xx_pci.c           | 62 ++++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.h           | 17 ++++++
 drivers/net/wwan/t7xx/t7xx_port_devlink.c  | 14 +++++
 drivers/net/wwan/t7xx/t7xx_port_devlink.h  |  1 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.c |  7 +++
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
index 5e9b954f39ce..f1723c02376e 100644
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
+			       t7xx_dev->dl->regions[T7XX_MRDUMP_INDEX].info->dump_size);
+	} else if (event == T7XX_LKDUMP_READY) {
+		return sprintf(buf, "T7XX_LKDUMP_READY size:%zu\n",
+			       t7xx_dev->dl->regions[T7XX_LKDUMP_INDEX].info->dump_size);
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
index 6777581cd540..0d82f9e99243 100644
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
 	struct t7xx_devlink	*dl;
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
diff --git a/drivers/net/wwan/t7xx/t7xx_port_devlink.c b/drivers/net/wwan/t7xx/t7xx_port_devlink.c
index 0949809aa219..5d2c81a29ab5 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_devlink.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_devlink.c
@@ -246,11 +246,14 @@ static int t7xx_devlink_fb_get_core(struct t7xx_port *port)
 			continue;
 		} else if (!strcmp(mcmd, T7XX_FB_RESP_MRDUMP_DONE)) {
 			dev_dbg(port->dev, "%s! size:%zd\n", T7XX_FB_RESP_MRDUMP_DONE, offset_dlen);
+			dl->regions[T7XX_MRDUMP_INDEX].info->dump_size = offset_dlen;
+			atomic_set(&port->t7xx_dev->event, T7XX_MRDUMP_READY);
 			clear_bit(T7XX_MRDUMP_STATUS, &dl->status);
 			return 0;
 		}
 		dev_err(port->dev, "getcore protocol error (read len %05d, response %s)\n",
 			clen, mcmd);
+		atomic_set(&port->t7xx_dev->event, T7XX_MRDUMP_DISCARD);
 		ret = -EPROTO;
 		goto free_mem;
 	}
@@ -293,6 +296,7 @@ static int t7xx_devlink_fb_dump_log(struct t7xx_port *port)
 	if (datasize > lkdump_region->info->size) {
 		dev_err(port->dev, "lkdump size is more than %dKB. Discarded!\n",
 			T7XX_LKDUMP_SIZE / 1024);
+		atomic_set(&port->t7xx_dev->event, T7XX_LKDUMP_DISCARD);
 		ret = -EFBIG;
 		goto err_clear_bit;
 	}
@@ -317,6 +321,8 @@ static int t7xx_devlink_fb_dump_log(struct t7xx_port *port)
 	}
 
 	dev_dbg(port->dev, "LKDUMP DONE! size:%zd\n", offset);
+	lkdump_region->info->dump_size = offset;
+	atomic_set(&port->t7xx_dev->event, T7XX_LKDUMP_READY);
 	clear_bit(T7XX_LKDUMP_STATUS, &dl->status);
 	return t7xx_devlink_fb_handle_response(port, NULL);
 
@@ -360,6 +366,10 @@ static int t7xx_devlink_flash_update(struct devlink *devlink,
 
 	sprintf(flash_status, "%s %s", "flashing", !ret ? "success" : "failure");
 	devlink_flash_update_status_notify(devlink, flash_status, params->component, 0, 0);
+	if (ret)
+		atomic_set(&port->t7xx_dev->event, T7XX_FLASH_FAILURE);
+	else
+		atomic_set(&port->t7xx_dev->event, T7XX_FLASH_SUCCESS);
 	clear_bit(T7XX_FLASH_STATUS, &dl->status);
 
 err_out:
@@ -414,9 +424,13 @@ static int t7xx_devlink_reload_up(struct devlink *devlink,
 				  u32 *actions_performed,
 				  struct netlink_ext_ack *extack)
 {
+	struct t7xx_devlink *dl = devlink_priv(devlink);
+
 	*actions_performed = BIT(action);
 	switch (action) {
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
+		atomic_set(&dl->t7xx_dev->event, T7XX_RESET);
+		return 0;
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
 		return 0;
 	default:
diff --git a/drivers/net/wwan/t7xx/t7xx_port_devlink.h b/drivers/net/wwan/t7xx/t7xx_port_devlink.h
index e01845b4f2aa..f5442a7f3431 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_devlink.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_devlink.h
@@ -57,6 +57,7 @@ enum t7xx_regions {
 struct t7xx_devlink_region_info {
 	const char *name;
 	size_t size;
+	size_t dump_size;
 };
 
 struct t7xx_devlink_region {
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 500dadaddb30..db76bc6fe660 100644
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


