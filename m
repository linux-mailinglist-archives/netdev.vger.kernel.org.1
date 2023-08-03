Return-Path: <netdev+bounces-23866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A005A76DE5F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8191C213F6
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148CD4C71;
	Thu,  3 Aug 2023 02:41:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0341B46A7
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:41:04 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2181.outbound.protection.outlook.com [40.92.62.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F152AB2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZcc/2/tLlWwckWFnvVq69C6LmfFVifOXI0Am0gHWQBr1RIXKxicUxR/LLb+Te3S+05PjuWTb9TUR1XAv3oGurbY+cbpltyf8ftmBGSiq2X9Rgqvt2ppl93XK2de2EnZevfmbL3J/oVWw32g23MJTDhxuMAxowVKuzeD8LynB/dIo7CUk6ywE9YQu+vKXa4MJc2s4KztHlaH7Yr9N8lfTSG0kgSNU68oxEUDfjncWBdXu55lR476qbijExkcLsJ2iGFWpvTbUS/UOCg1BEv3207JkLtuMovXAGnsTufDe0Zn6bObtYx5Kyt1T5+0cRmnEgLkeyaBJrMJJcfhnc/e/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07O5d5GfwqZ3LC1XdbdDCYcNLN8JLw41NrQzUCcEqJ8=;
 b=g/R+zh1OcEhoIe6P+iE710PKf9tAxPpVEGxVGXp1UrOhyTUZcBc1dxoW6+FAj0ZN61oYCt/0naCt+Xa+q3UjkL4YiZPNQZm5+RqXBxaNvl/7CYzXtvb0TWjelHDY1g5Dam2HxQFn0rJMDbwVtg21e0XN+At22zDHP3t9Ge+LasofB7r1V2kNXFx8P3U6LR7VTnuXI6hRE1b9/kTJsAdVWeCs+dwdGu9avr79jRz8NGIjFjoP2s6B3xPRYYy7qrU7GbxfpmfzmWor1EmAvJ1g6aVbhgcGPn5CmV0YUtR+aRIAjfKceqp+8IHCdMEb/SN6fClFZrwAflubdu2SDxRMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07O5d5GfwqZ3LC1XdbdDCYcNLN8JLw41NrQzUCcEqJ8=;
 b=QxmrN4sv4L9Ma4c5d7tdMyXVeLKD8rXTcaLTVM4kPf55jymPYCpkpxCWMkH3ucFVQzKWMtGvZVwCeCH5d9tGUr1W77zJoZBmYZNBwXbxdPqRfR4VWl7YThF6o/78bIMOAR6V9rK7PJLEFHWp+E/87X6dS9McbGYrx5CX2lFizXAZ6OFqceHET1nSro/K7POZkRbXWKN5139x0zRxVtaBCImQSRpF+9I5kviN08x9hpjTm876QaC1xREmFYq04nOVn+uSuD55Cg0weJRtjr3LmCNAb1jVWtskMtgtae53Yd9ugyPtpQnQzir/vLE+hQjqfDVZKczFusb0qJiodRGHnw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB3585.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:186::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 02:40:55 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 02:40:55 +0000
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
Date: Thu,  3 Aug 2023 10:40:33 +0800
Message-ID:
 <MEYP282MB2697AD3C4BBABEA8E6F94284BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [DENDRDkLl1+gg54x4RoChMAXFI+IUa4w]
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230803024033.3465-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB3585:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a75bb37-71a6-45eb-a877-08db93cb0f2d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C0Ky4fSFS5ppbxihwmU8IGISynrC1bOUlb+krPjALvokRQ0758Hj1RM+kazvZTVuspQfzb7ax4H9WY1/Ku0JGGPfbaxYWHw5VVh1gf+Ka4HMnVeSi3qJYWttggnDHpgVlKP70jUNLSyyAGtcGF67tIbjKFUfJEMxqfNU+4163EyjuhCx1pr9Q0ENRf7u/1Li/LCIIUiLX80GLFw+CLlzRwgGzoPSpaOOOYUMRNsgmJVV1WYj66p1f+W8Wn+pzY+64eiGDw+1N+2wrTd5C27Y10m3S9nurzXG0QN7K32S6ryfJT1/nIcGdtovdCZ+yT0xSxiuwljQcnv6/xAZA4+QyGmlxYyqNsnrBXfVu0Zi0eD5KUxzPd+KkUBfi7SrJ4ByrpW2En4mUuGRmQh85MQ2etHfsC7i8ON9Ps06I0xkd7EsvSRbz9AeBsB601U8gF3hEFdcDALgbmOitRtZurdlkpie/KXiiJASCahHbUGrp41J8ZTF/U9Kk6huGukzCyTrMmbWa+b1qpIY6I7k7RIfZZN8bVsrSTW6F15YwGPKnyU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y0lZ7sgXBHpKYkVxUlwpYGtpJQ32Cy5S0cwDq+0KGoC0+jLKYBhZalT8EEMf?=
 =?us-ascii?Q?6SnhzrtcvBwsCXTNNaFQ/Ze/v5BBFxPoCTKBIXf+0Hw+u7nQTxzg2xKKgBb8?=
 =?us-ascii?Q?oCEcl8+vDu8uNstQ4i2nnfdhe2XH9DUJHsMkUWSUrrDfyXrxnc88k9mAYU/a?=
 =?us-ascii?Q?nm/CI+lJ88TntxunOgrkvV/tlgBv6dTg6qieBRdV3ZXNgGcLjW5VpiTozNrS?=
 =?us-ascii?Q?bs4WIykmXk49+43NI/8K+gsuPlVaA3B+Tiltr/vBxyoWkEpOcWzP6GaAeEii?=
 =?us-ascii?Q?8U82AB7IZ+juzvZoECgBmn0uQYZsKoeX/SZV07ZGPy6M5lEAmLtivjKEkvf4?=
 =?us-ascii?Q?RkdlAA8RQ7GsNmSlCGT9KwcHg+3i/NelC/6JG/wJdDhLGsygz7UNdY+ArNSY?=
 =?us-ascii?Q?vBDSvyvtZBMdLzvmP7F7ydixA9HMvyDFczIjKomxIMuZkXBG105Qrhh7HzLQ?=
 =?us-ascii?Q?sqX1iew2XeJjAlfefZQ2+7Fi98SXsgFGGD3iCTeGc8tgZj1aJPsVfYi30f7c?=
 =?us-ascii?Q?ytKF3LAbLuK9xkp+h6nq/cKOZ13YKiR5bRl1hXrwq8MvWjVSTjFUYcKItH1X?=
 =?us-ascii?Q?cTrtbcfeuNhk57T4O/rbGbPePjraybFnof2NN/HXwycUmfg1ma/if8MNix9w?=
 =?us-ascii?Q?2fmmvMB2nw0dWzwS7XckccktIXa3/SS8ZSUtZ9G15on2Uc3wZmjjuBKb7X2m?=
 =?us-ascii?Q?ABtFk0ZyQQHQZy3gVVe024KB8V+BLKvp6bfnTmBCibDUJZCb3OQ+LEscY04w?=
 =?us-ascii?Q?vv4vfdUZaVMWDpmgisA6wGZbTi6BpVOJLl4JJKSuS8V0bHRgXEKScCxVM1Tc?=
 =?us-ascii?Q?Co0MoWA5xJe3LWAm/vAUtSJm8LnFXIj3DUjAJoiuqZHZHEVAHPqTanJGaBVs?=
 =?us-ascii?Q?azpCFDBeYe2V+643qK2b0lKx5TbnpOHpkugy3+bA85De6+UONU8X4TEUzCDc?=
 =?us-ascii?Q?gm3rIiao/H5uGLbdGY8x019TVr8SILcGdHCLjdym9hVpFUgJqpLWPFTG5ewb?=
 =?us-ascii?Q?XesTHCvUWCw6XpXtBQVHreAuofE6yNpEzvsTZvno3KXWhKP6irRFwIxoEHA1?=
 =?us-ascii?Q?a2doGRiDrBLHC7/ofQjHI2ghMQO/2dy/pRxQQElQ/a92v3WmleSHeXe6Af0T?=
 =?us-ascii?Q?aip0aK9CxGK6i7y7coXQtZWtpaKlWnFAu5RvGxLu9YEtUKfM+FGgVwXtcsJ6?=
 =?us-ascii?Q?A098YmjsfI6hcb5pMmnDGaSEaJJVlLSFBUjwsdeibqYtkB8ZTi9GybNn85I?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a75bb37-71a6-45eb-a877-08db93cb0f2d
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:40:55.1519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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


