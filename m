Return-Path: <netdev+bounces-30020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A3A785A53
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBA7281314
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279EC2C7;
	Wed, 23 Aug 2023 14:22:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D28AC2C3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:22:38 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2159.outbound.protection.outlook.com [40.92.62.159])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73012E52
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzwu3qYBj9M26m1fzFkqJ8As63clNKDCt4E5EsKNnzPyRWOxzfYQkSY7bUVgWYz7R4xmPPJb0cx80/b1ZeOp+4+XIIbnf7FC6rxYeyLynZQMydHQHVuY14AYxjtyeCFcQTxCAFEiuJRNydeZF8a1rvo7JnEdUUYIxd5xHvqOzLrYP3VlCYUCYknfQZITlM5pQrfr1j6pHdpHbBBHByXZZ4u9+lJ3VcAX9NqorhPn8xIjCvK8NeLzDrzfyKCIwXElMFe4pDAvDrd1Gx0dmJUOXuSkMd/LpsMTv4XCt60VrumLLb/b1hblTcx44NX6kBMP+2dsvKOzNak3tHfoHsderw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL+jZ4iKsl6Ap0QTdwE2qmYx+OUHi00Zyc8k4SU9i0M=;
 b=QzKN+C66YPunGqIcPpz0tsNPNSGkqnNbbkTP+QyJ1w31Vtvo9ROKr681lV4VvLbtZgxB73UTDay7ygQPFOUcDjEYhZC33+gyUNbqVYkius2wfmeygvl+wVM9bZLO2VzJQ+sU4F1b7oYQbsjdcBdef2eZ1uCNrRC2mD2cmJaloSJ9LvHyrZBfDjxIKOzwHgqWNz4AB8HCk6jS/nbgOzbJaZ/tuqjIKMb4kAyGb8kMVymxSbBrYjXRBpIPIYv/izHdIT1bRhZyCVqd0+QCNpz+CK6YVxlxHCEglQKWtZyb3MWeYIatl2MjLCLR6wC4A2ucpX7MjDIMleLDo6Efk3Dxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL+jZ4iKsl6Ap0QTdwE2qmYx+OUHi00Zyc8k4SU9i0M=;
 b=SLf6H2izN/EHiR1RY8vM+GFXf1BWc3xv3bzzMKyOQ+LEKJPjGrruPYZi2fmsmI9DPg7EjQDFyKoQuKr27DvteXPZG5bNlJ/VZ7vvRPltjAYQdySr9ppkiFddScN1bVN/OYYFEJLMTJxoIufpJx8l5ekeqlL2DDTLCqBMntQ9aouKaox2L1uQytCJtOp2rOgCW3+SM1u0ibJ6GjDIIErtP9qdEZjn+uRCqnT2CZdGFoZ0RoybanngzkuWzW7YoJwnLHykqygj+Aotn5x0D2nqJ76Q9gEZpQ5daTXDEP7600iWcF0n5K6HyjU2C4xN3tsUiTEsMncZVTmUeHUu/xhNZQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY6P282MB3375.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 14:22:28 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:22:28 +0000
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
Subject: [net-next v2 2/5] net: wwan: t7xx: Register with devlink and implement firmware flashing
Date: Wed, 23 Aug 2023 22:21:26 +0800
Message-ID:
 <MEYP282MB2697FC845FE12CEF33C5E9F3BB1CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823142129.20566-1-songjinjian@hotmail.com>
References: <20230823142129.20566-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [phkUeCAIPws4M04EY1L7iSs5V4MIdqMz]
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230823142129.20566-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY6P282MB3375:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4a94a6-2c25-4f0f-5d8a-08dba3e46133
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CzOHVVzXeQ5tskyp2z5nnAxydCUNpLjTT4p3Po5yJ9hdf6ntQQVgZMh0JTHeqCB0e4KIZ4c1l4m2QIriXEl2KfzQuwtV0B9frcC56ukpY6f2/cd1E/DJdnUj2TsEcwKIPdtdyvc1uA4BjfEJfoZTQ5rQ/7szgwMD2yZ347y0Nno4eFVmGvBfr7qSeNCvO+oBgvB4bKHiEiO7EVp7WGRUhJydotML0+glzFE92CVPWmSBEH9CxJVAV7dSBKBwXvpDn/MAEL7SuuD1EU49kRAYZqB+pOdijCirr9JnTko+v5iP8AkkovMoCeVeTp613sv2vN9UHU9C1HRcnW1+qEuGhdqFLEg8DAXaJrsrrCxyD/Z79YPo8UfZBambQoAXOcyp+pUG30ehW0zXiyJyVFfvVDvy6PBc24MhNY+SaXVIQQ1AzAeeduAwQ16TECiUNJrZqdmyABkOm2Muon5Q/2v7U5JkrQ7Fo7Dxj829lBzrTYhRd6g4YXadOLRWlSuFi0qDpcppeh8BhFo+MecCFG7dr0M6VXRvwlM+NsmUqU+0jL/aPp48WphCr0d6NJq09Xge
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KHVgnsNW5a7lo9SyV0BgDCxl4tJn3r+SjJ2zD+pOGh9TNtaNllBDj2foFQNp?=
 =?us-ascii?Q?dkdgyxU6OiAL0aNe3Vfg+JWbEtiPtIk9w8AQ1LzNpdeak630HimC3Q1giOhm?=
 =?us-ascii?Q?EiZmSrDcpcnoX2X20lQyXEyKRG2viw+Mg5yj0BUA+82scv4x1XpXNs7JfZq1?=
 =?us-ascii?Q?wIMF7VEzRDvnlDVP/ixsucLswYhTXwMzbcLuz+qpq4KJWZMdTeFZ6BxuoggQ?=
 =?us-ascii?Q?/4ZsjzVCqqTi8IsVBENEIDgNipRH07G8c4KZoqhOAfmUquWKx0g8tTnwD8Km?=
 =?us-ascii?Q?ME0ppvHBMkdOL7GKFJg2QB3GQ8VWf2CGgyZqEH+TVhAItcDmZMl0eR4kW/L7?=
 =?us-ascii?Q?+P/lK/aWgAKx5IajeHJOB7Gb4AqVuQj5NgAxydmMeuvSG2EZ0VwuXKT2CH6b?=
 =?us-ascii?Q?/JSJTk4bu7YRzSLsfwBowGXBnDra4uRWW9gVbux7eN8IpGq720CEJ/EraPtI?=
 =?us-ascii?Q?S1C/BDSU7JktwSXjF7aqYLsiNFwUZuYP8pc47y6Y0u2bg0MFctEDUJiyiIa2?=
 =?us-ascii?Q?uRjYB/G/QpyZIv66SU16j6Oy9E1oYCmtzygo7s2TvzHKne3onyTIvi1Qh9qm?=
 =?us-ascii?Q?sPQKcpcRtWzXxjuE86IA3R2ZydmBIYMuhpptEF/GS9FPHR2WmUCMQCFLeJ2q?=
 =?us-ascii?Q?WsX7qTVGpPyZDawQvlke7IJZFcW/R8fKEvugbTkfLAH9hbrOWdq2lC7b4nxD?=
 =?us-ascii?Q?TPt9F3y3gqfhbc17TLzgt0Zp3YzZo5k+g9Gd0H/88UdLDCJQM6aKn23pEBSk?=
 =?us-ascii?Q?/o6WYjXGkHaJQGHzbrA3Fo0KdDd6V7xeg0Jd+4C78e/y+CV45RINa2fpOxDA?=
 =?us-ascii?Q?TPcYIGNeiZHcIS2vOpAGWGS0zMW8UZTziMsEnvH6vxhhyfmm/2mH+1Qgws9L?=
 =?us-ascii?Q?bQjRIjJXTLvl/jmJjSsPfZnwW9qvWKehwHPERGd18O3BIxRovCZ140kogJrn?=
 =?us-ascii?Q?7RYu0HWXVfmbsAZrFoP/DfsHC+Dv/mCzKDxmeQh+FU+8twRkoqB+uvZ9jWMG?=
 =?us-ascii?Q?NCRK13r/ei4MNi2mDarJKKPsFWEwa4xPxl/oHfufI/rH7i7cfMHF7upBPiij?=
 =?us-ascii?Q?363NOcg2pS79qOoa9iw443D5QMqh7aaywXywQ6ns9U+Xp6YVPqHet5RxW8PI?=
 =?us-ascii?Q?fcu531ToMIp2PDMZ8ITrvnZVeZzMULfl/ukJf6zb7u9K6gdJ3HlItF0gqxHg?=
 =?us-ascii?Q?m+HQxPwlea3LSOG50t49RDkhsPrWRcV3zm60Wwu+u13CqcuXN85jf6TY8TQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4a94a6-2c25-4f0f-5d8a-08dba3e46133
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:22:28.5084
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

Adds support for t7xx wwan device firmware flashing using devlink.

On early detection of wwan device in fastboot mode driver sets up CLDMA0 HW
tx/rx queues for raw data transfer and then registers to devlink framework.

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
v2:
 * modify functions and struct name from devlink to flash_dump
 * delete stub funtions
 * delete devlink_flash_update_status_notify
 * delete devlink_info_get_loopbak 
---
 drivers/net/wwan/Kconfig                     |   1 +
 drivers/net/wwan/t7xx/Makefile               |   4 +-
 drivers/net/wwan/t7xx/t7xx_pci.c             |  17 +-
 drivers/net/wwan/t7xx/t7xx_pci.h             |   2 +
 drivers/net/wwan/t7xx/t7xx_port.h            |   2 +
 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c     |  78 ++++
 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h     |  11 +
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.c | 427 +++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.h |  45 ++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c      |  32 ++
 drivers/net/wwan/t7xx/t7xx_port_proxy.h      |   4 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c       |  22 +-
 drivers/net/wwan/t7xx/t7xx_reg.h             |   6 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.c   |  42 +-
 14 files changed, 663 insertions(+), 30 deletions(-)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_flash_dump.h

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
index 2652cd00504e..e5785bae64d5 100644
--- a/drivers/net/wwan/t7xx/Makefile
+++ b/drivers/net/wwan/t7xx/Makefile
@@ -15,7 +15,9 @@ mtk_t7xx-y:=	t7xx_pci.o \
 		t7xx_hif_dpmaif_tx.o \
 		t7xx_hif_dpmaif_rx.o  \
 		t7xx_dpmaif.o \
-		t7xx_netdev.o
+		t7xx_netdev.o \
+		t7xx_port_flash_dump.o \
+		t7xx_port_ap_msg.o
 
 mtk_t7xx-$(CONFIG_WWAN_DEBUGFS) += \
 		t7xx_port_trace.o \
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 91256e005b84..845d1555f134 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -39,6 +39,7 @@
 #include "t7xx_modem_ops.h"
 #include "t7xx_pci.h"
 #include "t7xx_pcie_mac.h"
+#include "t7xx_port_flash_dump.h"
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
@@ -757,6 +766,8 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	}
 
 	pci_free_irq_vectors(t7xx_dev->pdev);
+
+	t7xx_devlink_unregister(t7xx_dev);
 }
 
 static const struct pci_device_id t7xx_pci_table[] = {
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index f08f1ab74469..28f22a2dc493 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -59,6 +59,7 @@ typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
  * @md_pm_lock: protects PCIe sleep lock
  * @sleep_disable_count: PCIe L1.2 lock counter
  * @sleep_lock_acquire: indicates that sleep has been disabled
+ * @flash_dump: devlink struct
  */
 struct t7xx_pci_dev {
 	t7xx_intr_callback	intr_handler[EXT_INT_NUM];
@@ -82,6 +83,7 @@ struct t7xx_pci_dev {
 #ifdef CONFIG_WWAN_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	struct t7xx_flash_dump	*flash_dump;
 };
 
 enum t7xx_pm_id {
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
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ap_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
new file mode 100644
index 000000000000..46f311a38fbb
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#include "t7xx_port.h"
+#include "t7xx_port_proxy.h"
+#include "t7xx_port_flash_dump.h"
+#include "t7xx_state_monitor.h"
+#include "t7xx_port_ap_msg.h"
+
+int t7xx_port_ap_msg_tx(struct t7xx_port *port, char *buff, size_t len)
+{
+	const struct t7xx_port_conf *port_conf;
+	size_t offset, chunk_len = 0, txq_mtu;
+	struct t7xx_fsm_ctl *ctl;
+	struct sk_buff *skb_ccci;
+	enum md_state md_state;
+	int ret;
+
+	if (!len || !port->chan_enable)
+		return -EINVAL;
+
+	port_conf = port->port_conf;
+	ctl = port->t7xx_dev->md->fsm_ctl;
+	md_state = t7xx_fsm_get_md_state(ctl);
+	if (md_state == MD_STATE_WAITING_FOR_HS1 || md_state == MD_STATE_WAITING_FOR_HS2) {
+		dev_warn(port->dev, "Cannot write to %s port when md_state=%d\n",
+			 port_conf->name, md_state);
+		return -ENODEV;
+	}
+
+	txq_mtu = t7xx_get_port_mtu(port);
+	for (offset = 0; offset < len; offset += chunk_len) {
+		chunk_len = min(len - offset, txq_mtu - sizeof(struct ccci_header));
+		skb_ccci = t7xx_port_alloc_skb(chunk_len);
+		if (!skb_ccci)
+			return -ENOMEM;
+
+		skb_put_data(skb_ccci, buff + offset, chunk_len);
+		ret = t7xx_port_send_skb(port, skb_ccci, 0, 0);
+		if (ret) {
+			dev_kfree_skb_any(skb_ccci);
+			dev_err(port->dev, "Write error on %s port, %d\n",
+				port_conf->name, ret);
+			return ret;
+		}
+	}
+
+	return len;
+}
+
+static int t7xx_port_ap_msg_init(struct t7xx_port *port)
+{
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+
+	port->rx_length_th = T7XX_MAX_QUEUE_LENGTH;
+	flash_dump->status = T7XX_DEVLINK_IDLE;
+	flash_dump->port = port;
+
+	return 0;
+}
+
+static void t7xx_port_ap_msg_uninit(struct t7xx_port *port)
+{
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+
+	flash_dump->mode = T7XX_NORMAL_MODE;
+	skb_queue_purge(&port->rx_skb_list);
+}
+
+struct port_ops ap_msg_port_ops = {
+	.init = &t7xx_port_ap_msg_init,
+	.recv_skb = &t7xx_port_enqueue_skb,
+	.uninit = &t7xx_port_ap_msg_uninit,
+	.enable_chl = &t7xx_port_enable_chl,
+	.disable_chl = &t7xx_port_disable_chl,
+};
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ap_msg.h b/drivers/net/wwan/t7xx/t7xx_port_ap_msg.h
new file mode 100644
index 000000000000..4838d87d86cf
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_ap_msg.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#ifndef __T7XX_PORT_AP_MSG_H__
+#define __T7XX_PORT_AP_MSG_H__
+
+int t7xx_port_ap_msg_tx(struct t7xx_port *port, char *buff, size_t len);
+
+#endif /* __T7XX_PORT_AP_MSG_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
new file mode 100644
index 000000000000..1129ef793798
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#include <linux/vmalloc.h>
+
+#include "t7xx_port_proxy.h"
+#include "t7xx_port_ap_msg.h"
+#include "t7xx_port_flash_dump.h"
+
+static int t7xx_flash_dump_port_read(struct t7xx_port *port, char *buf, size_t count)
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
+static int t7xx_flash_dump_port_write(struct t7xx_port *port, const char *buf, size_t count)
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
+static int t7xx_flash_dump_fb_handle_response(struct t7xx_port *port, char *data)
+{
+	char status[T7XX_FB_RESPONSE_SIZE + 1];
+	int ret = 0, index;
+
+	for (index = 0; index < T7XX_FB_RESP_COUNT; index++) {
+		int read_bytes = t7xx_flash_dump_port_read(port, status, T7XX_FB_RESPONSE_SIZE);
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
+static int t7xx_flash_dump_fb_raw_command(char *cmd, struct t7xx_port *port, char *data)
+{
+	int ret, cmd_size = strlen(cmd);
+
+	if (cmd_size > T7XX_FB_COMMAND_SIZE) {
+		dev_err(port->dev, "command length %d is long\n", cmd_size);
+		return -EINVAL;
+	}
+
+	if (cmd_size != t7xx_flash_dump_port_write(port, cmd, cmd_size)) {
+		dev_err(port->dev, "raw command = %s write failed\n", cmd);
+		return -EIO;
+	}
+
+	dev_dbg(port->dev, "raw command = %s written to the device\n", cmd);
+	ret = t7xx_flash_dump_fb_handle_response(port, data);
+	if (ret)
+		dev_err(port->dev, "raw command = %s response FAILURE:%d\n", cmd, ret);
+
+	return ret;
+}
+
+static int t7xx_flash_dump_fb_download_command(struct t7xx_port *port, size_t size)
+{
+	char download_command[T7XX_FB_COMMAND_SIZE];
+
+	snprintf(download_command, sizeof(download_command), "%s:%08zx",
+		 T7XX_FB_CMD_DOWNLOAD, size);
+	return t7xx_flash_dump_fb_raw_command(download_command, port, NULL);
+}
+
+static int t7xx_flash_dump_fb_download(struct t7xx_port *port, const u8 *buf, size_t size)
+{
+	int ret;
+
+	if (!size)
+		return -EINVAL;
+
+	ret = t7xx_flash_dump_fb_download_command(port, size);
+	if (ret)
+		return ret;
+
+	ret = t7xx_flash_dump_port_write(port, buf, size);
+	if (ret < 0)
+		return ret;
+
+	return t7xx_flash_dump_fb_handle_response(port, NULL);
+}
+
+static int t7xx_flash_dump_fb_flash(struct t7xx_port *port, const char *cmd)
+{
+	char flash_command[T7XX_FB_COMMAND_SIZE];
+
+	snprintf(flash_command, sizeof(flash_command), "%s:%s", T7XX_FB_CMD_FLASH, cmd);
+	return t7xx_flash_dump_fb_raw_command(flash_command, port, NULL);
+}
+
+static int t7xx_flash_dump_fb_flash_partition(struct t7xx_port *port, const char *partition,
+					      const u8 *buf, size_t size)
+{
+	int ret;
+
+	ret = t7xx_flash_dump_fb_download(port, buf, size);
+	if (ret < 0)
+		return ret;
+
+	return t7xx_flash_dump_fb_flash(port, partition);
+}
+
+static int t7xx_devlink_flash_update(struct devlink *devlink,
+				     struct devlink_flash_update_params *params,
+				     struct netlink_ext_ack *extack)
+{
+	struct t7xx_flash_dump *flash_dump = devlink_priv(devlink);
+	const char *component = params->component;
+	const struct firmware *fw = params->fw;
+	struct t7xx_port *port;
+	int ret;
+
+	if (flash_dump->mode != T7XX_FB_DL_MODE) {
+		dev_err(&flash_dump->t7xx_dev->pdev->dev, "Modem is not in fastboot download mode!\n");
+		ret = -EPERM;
+		goto err_out;
+	}
+
+	if (flash_dump->status != T7XX_DEVLINK_IDLE) {
+		dev_err(&flash_dump->t7xx_dev->pdev->dev, "Modem is busy!\n");
+		ret = -EBUSY;
+		goto err_out;
+	}
+
+	if (!component || !fw->data) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	set_bit(T7XX_FLASH_STATUS, &flash_dump->status);
+	port = flash_dump->port;
+	dev_dbg(port->dev, "flash partition name:%s binary size:%zu\n", component, fw->size);
+	ret = t7xx_flash_dump_fb_flash_partition(port, component, fw->data, fw->size);
+	clear_bit(T7XX_FLASH_STATUS, &flash_dump->status);
+
+err_out:
+	return ret;
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
+	struct t7xx_flash_dump *flash_dump = devlink_priv(devlink);
+
+	switch (action) {
+	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
+		return 0;
+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
+		if (!flash_dump->mode)
+			return -EPERM;
+		return t7xx_flash_dump_fb_raw_command(T7XX_FB_CMD_REBOOT, flash_dump->port, NULL);
+	default:
+		/* Unsupported action should not get to this function */
+		return -EOPNOTSUPP;
+	}
+}
+
+static int t7xx_devlink_reload_up(struct devlink *devlink,
+				  enum devlink_reload_action action,
+				  enum devlink_reload_limit limit,
+				  u32 *actions_performed,
+				  struct netlink_ext_ack *extack)
+{
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
+static int t7xx_flash_dump_get_part_ver_fb_mode(struct t7xx_port *port, const char *cmd, char *data)
+{
+	char req_command[T7XX_FB_COMMAND_SIZE];
+
+	snprintf(req_command, sizeof(req_command), "%s:%s", T7XX_FB_CMD_GET_VER, cmd);
+	return t7xx_flash_dump_fb_raw_command(req_command, port, data);
+}
+
+static int t7xx_flash_dump_get_part_ver_norm_mode(struct t7xx_port *port, const char *cmd,
+						  char *data)
+{
+	char req_command[T7XX_FB_COMMAND_SIZE];
+	int len;
+
+	len = snprintf(req_command, sizeof(req_command), "%s:%s", T7XX_FB_CMD_GET_VER, cmd);
+	t7xx_port_ap_msg_tx(port, req_command, len);
+
+	return t7xx_flash_dump_fb_handle_response(port, data);
+}
+
+static int t7xx_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
+				 struct netlink_ext_ack *extack)
+{
+	struct t7xx_flash_dump *flash_dump = devlink_priv(devlink);
+	char *part_name, *ver, *part_no, *data;
+	int ret, total_part, i, ver_len;
+	struct t7xx_port *port;
+
+	port = flash_dump->port;
+	port->port_conf->ops->enable_chl(port);
+
+	if (flash_dump->status != T7XX_DEVLINK_IDLE) {
+		dev_err(&flash_dump->t7xx_dev->pdev->dev, "Modem is busy!\n");
+		return -EBUSY;
+	}
+
+	data = kzalloc(T7XX_FB_RESPONSE_SIZE, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	set_bit(T7XX_GET_INFO, &flash_dump->status);
+	if (flash_dump->mode == T7XX_FB_DL_MODE)
+		ret = t7xx_flash_dump_get_part_ver_fb_mode(port, "", data);
+	else
+		ret = t7xx_flash_dump_get_part_ver_norm_mode(port, "", data);
+
+	if (ret < 0)
+		goto err_clear_bit;
+
+	part_no = strsep(&data, ",");
+	if (kstrtoint(part_no, 16, &total_part)) {
+		dev_err(&flash_dump->t7xx_dev->pdev->dev, "kstrtoint error!\n");
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
+	clear_bit(T7XX_GET_INFO, &flash_dump->status);
+	kfree(data);
+	return ret;
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
+	dl_ctx = devlink_alloc(&devlink_flash_ops, sizeof(struct t7xx_flash_dump),
+			       &t7xx_dev->pdev->dev);
+	if (!dl_ctx)
+		return -ENOMEM;
+
+	t7xx_dev->flash_dump = devlink_priv(dl_ctx);
+	t7xx_dev->flash_dump->ctx = dl_ctx;
+	t7xx_dev->flash_dump->t7xx_dev = t7xx_dev;
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
+	struct devlink *dl_ctx = t7xx_dev->flash_dump->ctx;
+
+	devl_lock(dl_ctx);
+	devl_unregister(dl_ctx);
+	devl_params_unregister(dl_ctx, t7xx_devlink_params, ARRAY_SIZE(t7xx_devlink_params));
+	devl_unlock(dl_ctx);
+	devlink_free(dl_ctx);
+}
+
+/**
+ * t7xx_port_flash_dump_init - Initialize devlink to t7xx driver
+ * @port: Pointer to port structure
+ *
+ * Returns: 0 on success and error values on failure
+ */
+static int t7xx_port_flash_dump_init(struct t7xx_port *port)
+{
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+
+	port->rx_length_th = T7XX_MAX_QUEUE_LENGTH;
+
+	flash_dump->mode = T7XX_NORMAL_MODE;
+	flash_dump->status = T7XX_DEVLINK_IDLE;
+	flash_dump->port = port;
+
+	return 0;
+}
+
+static void t7xx_port_flash_dump_uninit(struct t7xx_port *port)
+{
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+
+	flash_dump->mode = T7XX_NORMAL_MODE;
+
+	skb_queue_purge(&port->rx_skb_list);
+}
+
+struct port_ops flash_dump_port_ops = {
+	.init = &t7xx_port_flash_dump_init,
+	.recv_skb = &t7xx_port_enqueue_skb,
+	.uninit = &t7xx_port_flash_dump_uninit,
+	.enable_chl = &t7xx_port_enable_chl,
+	.disable_chl = &t7xx_port_disable_chl,
+};
diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
new file mode 100644
index 000000000000..7614c01dcb2c
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#ifndef __T7XX_PORT_FLASH_DUMP_H__
+#define __T7XX_PORT_FLASH_DUMP_H__
+
+#include <net/devlink.h>
+#include <linux/string.h>
+
+#define T7XX_MAX_QUEUE_LENGTH 32
+#define T7XX_FB_COMMAND_SIZE  64
+#define T7XX_FB_RESPONSE_SIZE 512
+#define T7XX_FB_RESP_COUNT    30
+
+#define T7XX_FLASH_STATUS   0
+#define T7XX_GET_INFO       3
+
+#define T7XX_DEVLINK_IDLE   0
+#define T7XX_NORMAL_MODE    0
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
+
+struct t7xx_flash_dump {
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
+#endif /*__T7XX_PORT_FLASH_DUMP_H__*/
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index bdfeb10e0c51..11b88c41fc03 100644
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
@@ -109,6 +121,8 @@ static struct t7xx_port_conf t7xx_early_port_conf[] = {
 		.txq_exp_index = CLDMA_Q_IDX_DUMP,
 		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
 		.path_id = CLDMA_ID_AP,
+		.ops = &flash_dump_port_ops,
+		.name = "flash_dump",
 	},
 };
 
@@ -325,6 +339,24 @@ int t7xx_port_send_skb(struct t7xx_port *port, struct sk_buff *skb, unsigned int
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
index 7f5706811445..42f1ebf402d8 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -93,6 +93,8 @@ struct ctrl_msg_header {
 /* Port operations mapping */
 extern struct port_ops wwan_sub_port_ops;
 extern struct port_ops ctl_port_ops;
+extern struct port_ops flash_dump_port_ops;
+extern struct port_ops ap_msg_port_ops;
 
 #ifdef CONFIG_WWAN_DEBUGFS
 extern struct port_ops t7xx_trace_port_ops;
@@ -108,5 +110,7 @@ int t7xx_port_proxy_chl_enable_disable(struct port_proxy *port_prox, unsigned in
 void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id);
 int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb);
 int t7xx_port_proxy_recv_skb_from_dedicated_queue(struct cldma_queue *queue, struct sk_buff *skb);
+int t7xx_port_enable_chl(struct t7xx_port *port);
+int t7xx_port_disable_chl(struct t7xx_port *port);
 
 #endif /* __T7XX_PORT_PROXY_H__ */
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
index 9c51e332e7c5..24f79e981fd9 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -37,6 +37,7 @@
 #include "t7xx_modem_ops.h"
 #include "t7xx_pci.h"
 #include "t7xx_pcie_mac.h"
+#include "t7xx_port_flash_dump.h"
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
+		port = ctl->md->t7xx_dev->flash_dump->port;
+		if (WARN_ON(!port))
+			return;
+
+		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
+			md->t7xx_dev->flash_dump->mode = T7XX_FB_DL_MODE;
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
+	if (t7xx_devlink_param_get_fastboot(t7xx_dev->flash_dump->ctx))
+		t7xx_host_event_notify(ctl->md, FASTBOOT_DL_NOTIFY);
+
+	t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
+	/* Wait for the DRM disable to take effect */
+	msleep(FSM_DRM_DISABLE_DELAY_MS);
+	if (t7xx_devlink_param_get_fastboot(t7xx_dev->flash_dump->ctx)) {
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


