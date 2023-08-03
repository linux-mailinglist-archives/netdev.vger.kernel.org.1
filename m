Return-Path: <netdev+bounces-23856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4540176DDF3
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE3C281ABB
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24BD4C6A;
	Thu,  3 Aug 2023 02:21:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8EC7F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:21:15 +0000 (UTC)
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2168.outbound.protection.outlook.com [40.92.63.168])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC1EA1
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz/uPDWQ0mEHp1uIaAxkFC7inEXXJ9NcCrfmiMQv4kfDAbWnYxlzGryH8jWswfttbafJAjAbhEG+Ai9FMvDwN48YcHvOSzgA97j6NZNEi26GMRuM0L7QhZdwtCnQbCz/UXAGAJPdlD1zFQ+GP9d8u86hr0GOKnMnbIRlm3tmtnd2i1MlJbzOePuWAMpGf+AH5Zo+NN0dPokcFnUC05D5ey9bPaLKs6CmZ/bi9pwQBmUHsbQ6VbUVQPm2SSAcuUr2BgXqN1oH8yCO1UXlIf1Fw2xuhbqQObqt0g2qWaKxlXEQwu+l9zSOfjOpNsUDldOCNDRV/uHXgEWr1gTrJNNRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZazRXdh152RD5zqBFgOdO/FWKqM90fusVtgDnqzAtU=;
 b=Gl3p3RTox48WTRlauEoMCxpT/IXdY3+ezhtLlFDMeax3RCzlh4vwbZQ9F3fbsQXZKDzMkTpo0l00S7xsrdlA8PfTuDidQDcOm9UZUfy8AA4M4z/L8ffXndVs1iyzbEYy7PfWPJem4zHElgm5ksa5LIUqIpQTPRMELVp/YyI9QvEoDYf4HBbrCbGmiqnqp9IbPbV0eu1lFYdAIy/0pOUG6+JvXKkhMv0AKpmsjAVOdCBwlPi5Kkb98djF2vr9S7r2jqiIO03LI9VMCxY2IAApaLin27wZi3vCJkLg6znuP7RHSTRDT6p8uwX665oMGufgW28FzNCzh0uCIkmD2eFzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZazRXdh152RD5zqBFgOdO/FWKqM90fusVtgDnqzAtU=;
 b=MzLboRNevl1r+XSzGuAQTf//336Jnqn5VdHJ7uQ76AQm3cIfkL939dU9CSYah+ptvSjTsKqSRPH3zOJOorsPriEmfPim56u329AmG15QT+7mJCc/LigT2Kyl9mWgZSOsnTLQcVu5fVacVP/dOFyGJstWLkXeLWSbjUHpMZMD2cbsxNhHKj8HaL3kuqe6W8hj4h98Z37iLfvWz46bcTni3WToxjQfNNgDv05gOG20cidXvRh5CLi1WLtCm3UcbfgFhHc5PfqUYiZskAkgxtmHT8JZ5XytPcDIQra2cg1OVmG5ZcdVl7skgyj33jgOw83ttrxvpsFvMn9jNAkXqwNMzg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB2245.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 02:21:06 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 02:21:06 +0000
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
Subject: [net-next 2/6] net: wwan: t7xx: Driver registers with Devlink framework
Date: Thu,  3 Aug 2023 10:18:08 +0800
Message-ID:
 <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803021812.6126-1-songjinjian@hotmail.com>
References: <20230803021812.6126-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [to98/Ddlb9jhnRACbxjzq3Py1+PgM3Oy]
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230803021812.6126-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB2245:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e733246-0f5c-425a-fff7-08db93c84a77
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hCjw7fQDH9wdOn1bnx2OKgUTeY7QJHVr3JPHUrHeZoSgvxaAQyY2gDdsUIcZAGz1oaD8iH0Cz/AFNvijJne7MIqoF+DSglJdDT/CrNLBso60dB6mZl7LW+bXV3hES2lgYUs2A7uILb133U2iyGt8UA4oXb1f9k7u+JfPC9QRYIPZxTIcp73iDy8p4yfjFiT3pTXNNgmxl+CvOyF0LjJzCV4wKuwYhv3AxGbNUjF5zrEJz7bEj9mVKReFyK+PeGyi9/ia2LbZD2L81csODkkyJvDD+zOzb6DINceBWdH7GQtlOTHBcjK18KtM0t6CRO5bIlb/42br1d33Bjh/OBx+/IcNbjtwbvXumML+49y910oGs0P+pMNjsba92aCj3Ge7xZkgbmLOT524yGPQUB1QXONV/MV/4+IFtPLy+z0Le3mJC8fg/D+8O2iuKPW353hIZGUd4/oeb1qRopDaoCty/76f+/B0Wp0jHwwyQHS302MkuXgOKZiG9PAWRzB/mD91TB5u5YwbcBmiasyvVGMBlVX0LeslztiCiC2WdyvgLRg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/GfPXmIv0T7NFMC1FcTO5cuVtaeW7P5TXhjSdRU/xYnQLNuKc7bLyUmuZ0tO?=
 =?us-ascii?Q?G/j5xa55nJZL7+GMDmB1172eqGLGDATUb+TbIi9ilCW6e3K6Qaa+tFxofgpu?=
 =?us-ascii?Q?anz5ckqKDwx9aRa8OJgrtSKEzhW9c8k1kRnOTfHxwQYcnNlklCmkZ8VurAdO?=
 =?us-ascii?Q?Nj+HJIUHKIM/fFQV0f86I0HFbcqk9vn8Kpz6AHIHemS6YJg4Fb3l3NaoRgmr?=
 =?us-ascii?Q?dSTCpiqRg1ALSuQUu4fvLvFfJVCNVUC72j9YsRwKl16Z7F0rmcWx/6qUdaSn?=
 =?us-ascii?Q?oh+iK4ZMKn2n4uWdWtbEAE6XtFJG69GoitNrQSdFIm2RHRTZVyGdxT6DoVbi?=
 =?us-ascii?Q?tiuk9YA5LkHTLWvRU6edGDExifmYpQT9WHUcYibDDt81cBdlIHhdHSsU5kfQ?=
 =?us-ascii?Q?X0ysDDKeZQqIZGBX5arLuxcbGYTzejYLtBAJNTrvNVMOPB3wASP51s73jqw4?=
 =?us-ascii?Q?DQIS7H2NbRBSNbei/AdKORBcHRZDNxC5b+UFbJljOspqIL2nzZeOaCpwp6IK?=
 =?us-ascii?Q?vyngVNA5yziXKLzzD2n1LGmC0TK+uugEZT6CvLQh0ez/K4pccL5sPd9ZKzJX?=
 =?us-ascii?Q?bYbK7LRvABSO1oJU/qsrtxG7yArllodoa5h1FZqnmGNk60sLiRw6it+x2JYH?=
 =?us-ascii?Q?5LyGJm5R6H4BRPlt4cMdZPWKVZ+dnDO/4bBlPloE3iSuC/OuaMo2MaA8qN9A?=
 =?us-ascii?Q?N438a5P2tb747I1mvScWSeg+OG5dfGipTiPWSC0vJBMcsVKnypOQ5ONbLqQP?=
 =?us-ascii?Q?r8vaNNkHKMJ7QpHhuiVDg2pbD1TR8mdjAnRfPzsxsNrzMRDNUvAQsH/0Jcz4?=
 =?us-ascii?Q?pb3Us17KMse4yXQtSeoAqSlqy4LYciEh0QcdvaT3RX+krm9POPekidICEoGj?=
 =?us-ascii?Q?mJqyGoXoF2GrEAVacZqs4doh4FGfuYOjpZ4r9aUpFB2xMv3271cSRIt9BUUw?=
 =?us-ascii?Q?oTHJA8nuL32MSEwm/bLcEj98+fp0ye8NVotvAIaGiE3dDT7Ad4WrigFnWFEX?=
 =?us-ascii?Q?b42SpxfM3zBao6B7R/bDD+aQpkh1a6Leym8mJ2FwOhe+EpB0unstLUfKgYwZ?=
 =?us-ascii?Q?cbx0nW+lttXhlml8Vrj5mj/bHKvEbyul+s+IjJqFpa11lLgSZ80ZSnD9U1qa?=
 =?us-ascii?Q?JnPsegQVoqz0IZkRgq+FbdFovFcZFuxVBPrThbLmO5WaaV5zWqC5ZcgzumYb?=
 =?us-ascii?Q?86z4W1RwiGVxgwwEOZsVllA04p4S2M6tnQ3tN3ZuRS2WwQa9b06CT+c25B4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e733246-0f5c-425a-fff7-08db93c84a77
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:21:06.1534
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

On early detection of wwan device in fastboot mode driver sets up CLDMA0 HW
tx/rx queues for raw data transfer and then registers to devlink framework.

Base on the v5 patch version of follow series:
'net: wwan: t7xx: fw flashing & coredump support'
(https://patchwork.kernel.org/project/netdevbpf/patch/fc8bbb0b66a5ff3a489ea9857d79b374508090ef.1674307425.git.m.chetan.kumar@linux.intel.com/)

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 drivers/net/wwan/Kconfig                  |   1 +
 drivers/net/wwan/t7xx/Makefile            |   3 +-
 drivers/net/wwan/t7xx/t7xx_pci.c          |  15 ++-
 drivers/net/wwan/t7xx/t7xx_pci.h          |   2 +
 drivers/net/wwan/t7xx/t7xx_port_devlink.c | 149 ++++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_devlink.h |  29 +++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c   |  20 +++
 drivers/net/wwan/t7xx/t7xx_port_proxy.h   |   3 +
 8 files changed, 218 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_devlink.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_devlink.h

diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
index 410b0245114e..dd7a9883c1ff 100644
--- a/drivers/net/wwan/Kconfig
+++ b/drivers/net/wwan/Kconfig
@@ -108,6 +108,7 @@ config IOSM
 config MTK_T7XX
 	tristate "MediaTek PCIe 5G WWAN modem T7xx device"
 	depends on PCI
+	select NET_DEVLINK
 	select RELAY if WWAN_DEBUGFS
 	help
 	  Enables MediaTek PCIe based 5G WWAN modem (T7xx series) device.
diff --git a/drivers/net/wwan/t7xx/Makefile b/drivers/net/wwan/t7xx/Makefile
index 2652cd00504e..bb28e03eea68 100644
--- a/drivers/net/wwan/t7xx/Makefile
+++ b/drivers/net/wwan/t7xx/Makefile
@@ -15,7 +15,8 @@ mtk_t7xx-y:=	t7xx_pci.o \
 		t7xx_hif_dpmaif_tx.o \
 		t7xx_hif_dpmaif_rx.o  \
 		t7xx_dpmaif.o \
-		t7xx_netdev.o
+		t7xx_netdev.o \
+		t7xx_port_devlink.o
 
 mtk_t7xx-$(CONFIG_WWAN_DEBUGFS) += \
 		t7xx_port_trace.o \
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 91256e005b84..831819267989 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -39,6 +39,7 @@
 #include "t7xx_modem_ops.h"
 #include "t7xx_pci.h"
 #include "t7xx_pcie_mac.h"
+#include "t7xx_port_devlink.h"
 #include "t7xx_reg.h"
 #include "t7xx_state_monitor.h"
 
@@ -108,7 +109,7 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, PM_AUTOSUSPEND_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
-	return t7xx_wait_pm_config(t7xx_dev);
+	return 0;
 }
 
 void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
@@ -723,22 +724,30 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	t7xx_pci_infracfg_ao_calc(t7xx_dev);
 	t7xx_mhccif_init(t7xx_dev);
 
-	ret = t7xx_md_init(t7xx_dev);
+	ret = t7xx_devlink_register(t7xx_dev);
 	if (ret)
 		return ret;
 
+	ret = t7xx_md_init(t7xx_dev);
+	if (ret)
+		goto err_devlink_unregister;
+
 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
 
 	ret = t7xx_interrupt_init(t7xx_dev);
 	if (ret) {
 		t7xx_md_exit(t7xx_dev);
-		return ret;
+		goto err_devlink_unregister;
 	}
 
 	t7xx_pcie_mac_set_int(t7xx_dev, MHCCIF_INT);
 	t7xx_pcie_mac_interrupts_en(t7xx_dev);
 
 	return 0;
+
+err_devlink_unregister:
+	t7xx_devlink_unregister(t7xx_dev);
+	return ret;
 }
 
 static void t7xx_pci_remove(struct pci_dev *pdev)
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index f08f1ab74469..6777581cd540 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -59,6 +59,7 @@ typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
  * @md_pm_lock: protects PCIe sleep lock
  * @sleep_disable_count: PCIe L1.2 lock counter
  * @sleep_lock_acquire: indicates that sleep has been disabled
+ * @dl: devlink struct
  */
 struct t7xx_pci_dev {
 	t7xx_intr_callback	intr_handler[EXT_INT_NUM];
@@ -82,6 +83,7 @@ struct t7xx_pci_dev {
 #ifdef CONFIG_WWAN_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	struct t7xx_devlink	*dl;
 };
 
 enum t7xx_pm_id {
diff --git a/drivers/net/wwan/t7xx/t7xx_port_devlink.c b/drivers/net/wwan/t7xx/t7xx_port_devlink.c
new file mode 100644
index 000000000000..9c09464b28ee
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_devlink.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#include <linux/vmalloc.h>
+
+#include "t7xx_port_proxy.h"
+#include "t7xx_port_devlink.h"
+
+static int t7xx_devlink_flash_update(struct devlink *devlink,
+				     struct devlink_flash_update_params *params,
+				     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+enum t7xx_devlink_param_id {
+	T7XX_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	T7XX_DEVLINK_PARAM_ID_FASTBOOT,
+};
+
+static const struct devlink_param t7xx_devlink_params[] = {
+	DEVLINK_PARAM_DRIVER(T7XX_DEVLINK_PARAM_ID_FASTBOOT,
+			     "fastboot", DEVLINK_PARAM_TYPE_BOOL,
+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
+			     NULL, NULL, NULL),
+};
+
+bool t7xx_devlink_param_get_fastboot(struct devlink *devlink)
+{
+	union devlink_param_value saved_value;
+
+	devl_param_driverinit_value_get(devlink, T7XX_DEVLINK_PARAM_ID_FASTBOOT,
+					&saved_value);
+	return saved_value.vbool;
+}
+
+static int t7xx_devlink_reload_down(struct devlink *devlink, bool netns_change,
+				    enum devlink_reload_action action,
+				    enum devlink_reload_limit limit,
+				    struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int t7xx_devlink_reload_up(struct devlink *devlink,
+				  enum devlink_reload_action action,
+				  enum devlink_reload_limit limit,
+				  u32 *actions_performed,
+				  struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int t7xx_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
+				 struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+/* Call back function for devlink ops */
+static const struct devlink_ops devlink_flash_ops = {
+	.supported_flash_update_params = DEVLINK_SUPPORT_FLASH_UPDATE_OVERWRITE_MASK,
+	.flash_update = t7xx_devlink_flash_update,
+	.reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
+			  BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE),
+	.info_get = t7xx_devlink_info_get,
+	.reload_down = t7xx_devlink_reload_down,
+	.reload_up = t7xx_devlink_reload_up,
+};
+
+int t7xx_devlink_register(struct t7xx_pci_dev *t7xx_dev)
+{
+	union devlink_param_value value;
+	struct devlink *dl_ctx;
+
+	dl_ctx = devlink_alloc(&devlink_flash_ops, sizeof(struct t7xx_devlink),
+			       &t7xx_dev->pdev->dev);
+	if (!dl_ctx)
+		return -ENOMEM;
+
+	t7xx_dev->dl = devlink_priv(dl_ctx);
+	t7xx_dev->dl->ctx = dl_ctx;
+	t7xx_dev->dl->t7xx_dev = t7xx_dev;
+
+	devl_lock(dl_ctx);
+	devl_params_register(dl_ctx, t7xx_devlink_params, ARRAY_SIZE(t7xx_devlink_params));
+	value.vbool = false;
+	devl_param_driverinit_value_set(dl_ctx, T7XX_DEVLINK_PARAM_ID_FASTBOOT, value);
+	devl_register(dl_ctx);
+	devl_unlock(dl_ctx);
+
+	return 0;
+}
+
+void t7xx_devlink_unregister(struct t7xx_pci_dev *t7xx_dev)
+{
+	struct devlink *dl_ctx = t7xx_dev->dl->ctx;
+
+	devl_lock(dl_ctx);
+	devl_unregister(dl_ctx);
+	devl_params_unregister(dl_ctx, t7xx_devlink_params, ARRAY_SIZE(t7xx_devlink_params));
+	devl_unlock(dl_ctx);
+	devlink_free(dl_ctx);
+}
+
+/**
+ * t7xx_devlink_init - Initialize devlink to t7xx driver
+ * @port: Pointer to port structure
+ *
+ * Returns: 0 on success and error values on failure
+ */
+static int t7xx_devlink_init(struct t7xx_port *port)
+{
+	struct t7xx_devlink *dl = port->t7xx_dev->dl;
+
+	port->rx_length_th = T7XX_MAX_QUEUE_LENGTH;
+
+	dl->mode = T7XX_NORMAL_MODE;
+	dl->status = T7XX_DEVLINK_IDLE;
+	dl->port = port;
+
+	return 0;
+}
+
+static void t7xx_devlink_uninit(struct t7xx_port *port)
+{
+	struct t7xx_devlink *dl = port->t7xx_dev->dl;
+
+	dl->mode = T7XX_NORMAL_MODE;
+
+	skb_queue_purge(&port->rx_skb_list);
+}
+
+static int t7xx_devlink_enable_chl(struct t7xx_port *port)
+{
+	t7xx_port_enable_chl(port);
+
+	return 0;
+}
+
+struct port_ops devlink_port_ops = {
+	.init = &t7xx_devlink_init,
+	.recv_skb = &t7xx_port_enqueue_skb,
+	.uninit = &t7xx_devlink_uninit,
+	.enable_chl = &t7xx_devlink_enable_chl,
+	.disable_chl = &t7xx_port_disable_chl,
+};
diff --git a/drivers/net/wwan/t7xx/t7xx_port_devlink.h b/drivers/net/wwan/t7xx/t7xx_port_devlink.h
new file mode 100644
index 000000000000..12e5a63203af
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_devlink.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#ifndef __T7XX_PORT_DEVLINK_H__
+#define __T7XX_PORT_DEVLINK_H__
+
+#include <net/devlink.h>
+#include <linux/string.h>
+
+#define T7XX_MAX_QUEUE_LENGTH 32
+
+#define T7XX_DEVLINK_IDLE   0
+#define T7XX_NORMAL_MODE    0
+
+struct t7xx_devlink {
+	struct t7xx_pci_dev *t7xx_dev;
+	struct t7xx_port *port;
+	struct devlink *ctx;
+	unsigned long status;
+	u8 mode;
+};
+
+bool t7xx_devlink_param_get_fastboot(struct devlink *devlink);
+int t7xx_devlink_register(struct t7xx_pci_dev *t7xx_dev);
+void t7xx_devlink_unregister(struct t7xx_pci_dev *t7xx_dev);
+
+#endif /*__T7XX_PORT_DEVLINK_H__*/
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index bdfeb10e0c51..f185a7fb0265 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -109,6 +109,8 @@ static struct t7xx_port_conf t7xx_early_port_conf[] = {
 		.txq_exp_index = CLDMA_Q_IDX_DUMP,
 		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
 		.path_id = CLDMA_ID_AP,
+		.ops = &devlink_port_ops,
+		.name = "devlink",
 	},
 };
 
@@ -325,6 +327,24 @@ int t7xx_port_send_skb(struct t7xx_port *port, struct sk_buff *skb, unsigned int
 	return t7xx_port_send_ccci_skb(port, skb, pkt_header, ex_msg);
 }
 
+int t7xx_port_enable_chl(struct t7xx_port *port)
+{
+	spin_lock(&port->port_update_lock);
+	port->chan_enable = true;
+	spin_unlock(&port->port_update_lock);
+
+	return 0;
+}
+
+int t7xx_port_disable_chl(struct t7xx_port *port)
+{
+	spin_lock(&port->port_update_lock);
+	port->chan_enable = false;
+	spin_unlock(&port->port_update_lock);
+
+	return 0;
+}
+
 static void t7xx_proxy_setup_ch_mapping(struct port_proxy *port_prox)
 {
 	struct t7xx_port *port;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index 7f5706811445..c4cd1078ee92 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -93,6 +93,7 @@ struct ctrl_msg_header {
 /* Port operations mapping */
 extern struct port_ops wwan_sub_port_ops;
 extern struct port_ops ctl_port_ops;
+extern struct port_ops devlink_port_ops;
 
 #ifdef CONFIG_WWAN_DEBUGFS
 extern struct port_ops t7xx_trace_port_ops;
@@ -108,5 +109,7 @@ int t7xx_port_proxy_chl_enable_disable(struct port_proxy *port_prox, unsigned in
 void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id);
 int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb);
 int t7xx_port_proxy_recv_skb_from_dedicated_queue(struct cldma_queue *queue, struct sk_buff *skb);
+int t7xx_port_enable_chl(struct t7xx_port *port);
+int t7xx_port_disable_chl(struct t7xx_port *port);
 
 #endif /* __T7XX_PORT_PROXY_H__ */
-- 
2.34.1


