Return-Path: <netdev+bounces-63253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84AC82BF88
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 13:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A6E287995
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2256A015;
	Fri, 12 Jan 2024 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="UwvsMD5e"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2148.outbound.protection.outlook.com [40.92.63.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA167E9E
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbezOllxtsfQXIVyUrXP0mLVneQA/tPnPzQXaPxPu8oe4Fz7a2nWy/ZOrkh1amUvTJ/Mvzq44dX9u6K3u3rFHIwrigeFuDZKORe3ksZ40c74qmtgbf+a4o2hUhzntZHoWt8TLuR8vIaJdjaD/DIydm6Bx4MvAmwuAcf1mdes6FmZHuGY+008bXpkNTB5Jg4esAbL3Z4iCIE5fYzP//fIkwx1VTeupopCihSu8lZWog2tDaLOUbHWD8Ce6/PwxFcM7+BEHd9WOxejMrhTZYnf3tk23O8xDkAJvKTYUKuLW5ZFERlio4II4zyAvmnAhhpY/ZqXTO6vuFjFNZ4+IVie1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABce2jaRv2tFIyTr80JQEJhuwNlJcFnumypfDXRfBEU=;
 b=AVBysnuxYyl3+PIIV1QgJ6LT7wrh2zBbg3JxHCfBp4BhID0z+aopfV1aGexYO33Ip8arAPVYbpIAYhPauJa4DVQ1hRamDvoTRP1w/kLgx3/lF3I1cImpmW+BKBKTRNRzPrGKy+YVFG1URZuXSR9ttt5PAQens9p4TOrnuhXOrbpOago+u8W2nrDtqPgWQ5sS6rZhgKZgMPyFWAQZMytz868RZuwgJzezigQLvI4xSTIXKU0UQ6+OyvTG8VTAx8snCB4YVSGwW53qbQDRPHDSR/EvWPvxC1FGJhbgvsLWzTVB4sgngV8a2g3VENHD282qwSS0QVrYQ6fKEehiI8iFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABce2jaRv2tFIyTr80JQEJhuwNlJcFnumypfDXRfBEU=;
 b=UwvsMD5efN9JxUTEeDpCj9aNDZlbTBn6319Ib6cYv+R0QqWNdBDNE4vaw1A16ZWZaxOsHrQmLpgdPaOR2dPw60IFLVpHnQfCu4SWHOtvjyK68vI2cQyPt8D3MoJzrFOaosBGdLWsRpovDcnYRTYQ/o0IxX4CfKeKzr7Ms4iP4KGGXXKPPSs7pugINv+c3MlxA5wuUEpQNJMxIva7OtJZA0Bom8WM1uN6HLSRWpCAjjOX7hN0rxnTXiMbpqPimGdQPNj/82LwbfrSgkN+ewlZ7LeK4AP+Z9dGEnUDFmGfWuENdOkEzKIzxslmKsUcu/NRHObo/H/os2YX02qw4oPj8g==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY4P282MB4175.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 12:00:48 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd%5]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 12:00:48 +0000
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
Subject: [net-next v4 2/4] net: wwan: t7xx: Add sysfs attribute for device state machine
Date: Fri, 12 Jan 2024 20:00:12 +0800
Message-ID:
 <MEYP282MB2697F742D8CD3ADC1BFD3E44BB6F2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112120014.3917-1-songjinjian@hotmail.com>
References: <20240112120014.3917-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [q41KRGjhi45B/t/X4gLXenqb10gp5J6I]
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240112120014.3917-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY4P282MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: fb95a1e1-fc33-4df2-a869-08dc13661dba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tfxhcXlVeF18mUjZKQR8pClW7sKGO5ognw/nbmC1agI15Pjs7E9lkGOngwHFo+17bU6dc2ccuQjDzx4mZylcUksWiHuZ9VWFsifUO4K1XdhheitftZxt2+YB9XgbgJxLWCqkVOzJeSR03WuyOmA7mVNjYuDNx0JHDEClpnPpTdOGKxSt0ttUJn9TNfR8gaThCbuFOB4Ru8UAsJsoQHuue3FPtgkhebrHFohhz5UhW/ikdrgtUxF6UVmYCRQizVjrXfexF4gp9MZJoASmCGiDZMd0GuaIqkMqqMK+uWmE/ew712R3Bpz3W4KZo97EAml9y+zYv3Wb4pjgNMEKmuviF3xXjqOV2tZ0mojp0ZlZKmPjwKyy00z+m4MxrZXuvUrfRqTtyTZdilv+zw05myBL0IirRww3hdH1SAZaDb/xyZ1JV5/D3ROMO02Yn2uGumnAwyN7Y1E7UJLgkeYAWlG0qtUzeqHSZDINf9m4KxesJzOsU9ndyQ+mNDF7hmle9BITkR1bawvpmTHUp5VV7vf2bsOzyI4k+mNnH1+cPS97wwfGEGknINQLaoPQtg6oLCbg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WeRLKpHfN+bgbCsPpYcHgxeS+ZaOgGTgZFakShIDIoA7HbfuGpaEGELVq+Nc?=
 =?us-ascii?Q?06BIfSEEoJAFxT4abQp1u/pEZstmoKxNKk7511aXh/sHlnaxVZfNpS6/NRgy?=
 =?us-ascii?Q?2AvuNPcxwsyagybH5l+NxXMeFU2onngKQiZ63nytBe1KIw4rQtFcJFFigtp5?=
 =?us-ascii?Q?vd81LalZ8AQBt29Rq1S7VjDggDZcJr3MzDlp0LoX1j8CbVu788cCpoI5JIrY?=
 =?us-ascii?Q?z0cPFcAIMDsTdVlq7JT+airfBawIKKWzyU/k1K5j9QQOCYx/OjsZiXVqWRUn?=
 =?us-ascii?Q?2mJVPlD5rhqQHi/sAGEJZrCh2kcb7rOaxmxfp9tjC/lwOIUxMcFma4hCLfMz?=
 =?us-ascii?Q?viD8f94MFOi826AhK09JEeFF0kCz2815mCXKfF6fPrLC7kiYsbGWhDFNfcQd?=
 =?us-ascii?Q?9X0LAucHdaW7mYq2jXqpUP3lQBfxd81RHsbFVW0WCKze/94RCfZ/Wi/7RSrk?=
 =?us-ascii?Q?uW+ExYEckpmhl98/lFcn6pGZtQZShPBsyY9UcNoa3HWEMdJEIl7X6QCzhzES?=
 =?us-ascii?Q?ePy554yLgnK9BGpVBeqbMdzs4YEoD3RG4fdmbPsfTf1UsPmwbnw96naOpOQY?=
 =?us-ascii?Q?DpJrbostCKydtq8JrUW8W5oP5TpJy+7hABPKANONvLpvekNIxIBiHoOFCbTR?=
 =?us-ascii?Q?stqZw5PgJBnynRuZh8BMA69Y+ud8yal+eJbwV4nXyxRUPzNdKw/GZ7/MLNW/?=
 =?us-ascii?Q?lpC7wt2imP0d6ZS+Ve6tpefznYUs432JrX8VX+i9v9C3V+V7cCShmwXezAEU?=
 =?us-ascii?Q?4VyAtxRw7Pcn15HH33jg5wSDhNJdz4iRrpXMYZquN97PXtnTQi2j96P4mw6i?=
 =?us-ascii?Q?Xlf6kfChd/cEEk/Ps5Adn4sQNvkrwEa3DaciCW192EcOOtWAMUa4dMyn6G8+?=
 =?us-ascii?Q?7T2O1bejg3gDWHSk3g2x/xCKH6H+aN9yAyjj5otX2LpvXVBDTBaZ6aLPCne+?=
 =?us-ascii?Q?/BjpEKTUFAb/ZtdtAL5RHXQKDBGFcFNBKYrQe57T5itxSEnVphPltywgb5EX?=
 =?us-ascii?Q?yqIIKUbVRMUgZi5c/YSJXqiUJROcPbif43De9d3fkiLZWRD1U0EWBnVqzgSk?=
 =?us-ascii?Q?sm2t+7bpcmiwOq7Uro6zdsqlWwR6+XqikqR2R2GmFDegAVWEBk9AM3N4BoOB?=
 =?us-ascii?Q?wHW5aI06aNRjnzo/Nn/rNkSXkOGfyBobMBE1gOLwLJvoKybYcqxpCblR82LF?=
 =?us-ascii?Q?mlrg3vVOvpnrw7flsdLElxkZpLMxCl5EYkGNFRYjl/gRktZjtMv/VaI51VQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fb95a1e1-fc33-4df2-a869-08dc13661dba
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 12:00:48.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB4175

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for userspace to get/set the device mode,
e.g., reset/ready/fastboot mode.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v4:
 * narrow down the set of accepted values in t7xx_mode_store() 
 * change mode type atomic to u32 with READ_ONCE()/WRITE_ONCE()
 * delete 'T7XX_MODEM' prefix and using sysfs_emit in t7xx_mode_show()
 * add description of sysfs t7xx_mode in document t7xx.rst 
v3:
 * no change
v2:
 * optimizing using goto label in t7xx_pci_probe
---
 .../networking/device_drivers/wwan/t7xx.rst   | 28 ++++++
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |  1 +
 drivers/net/wwan/t7xx/t7xx_pci.c              | 94 ++++++++++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.h              | 14 ++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    |  1 +
 5 files changed, 133 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index dd5b731957ca..d13624a52d8b 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -39,6 +39,34 @@ command and receive response:
 
 - open the AT control channel using a UART tool or a special user tool
 
+Sysfs
+=====
+The driver provides sysfs interfaces to userspace.
+
+t7xx_mode
+---------
+The sysfs interface provides userspace with access to the device mode, this interface
+supports read and write operations.
+
+Device mode:
+
+- ``UNKNOW`` represents that device in unknown status
+- ``READY`` represents that device in ready status
+- ``RESET`` represents that device in reset status
+- ``FASTBOOT_DL_SWITCHING`` represents that device in fastboot switching status
+- ``FASTBOOT_DL_MODE`` represents that device in fastboot download status
+- ``FASTBOOT_DL_DUMP_MODE`` represents that device in fastboot dump status
+
+Read from userspace to get the current device mode.
+
+::
+  $ cat /sys/bus/pci/devices/${bdf}/t7xx_mode
+
+Write from userspace to set the device mode.
+
+::
+  $ echo FASTBOOT_DL_SWITCHING > /sys/bus/pci/devices/${bdf}/t7xx_mode
+
 Management application development
 ==================================
 The driver and userspace interfaces are described below. The MBIM protocol is
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 24e7d491468e..8e3d4644dd19 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -192,6 +192,7 @@ static irqreturn_t t7xx_rgu_isr_thread(int irq, void *data)
 {
 	struct t7xx_pci_dev *t7xx_dev = data;
 
+	t7xx_mode_update(t7xx_dev, T7XX_RESET);
 	msleep(RGU_RESET_DELAY_MS);
 	t7xx_reset_device_via_pmic(t7xx_dev);
 	return IRQ_HANDLED;
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 91256e005b84..bfe884243dd1 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -52,6 +52,77 @@
 #define PM_RESOURCE_POLL_TIMEOUT_US	10000
 #define PM_RESOURCE_POLL_STEP_US	100
 
+static const char * const mode_names[] = {
+	[T7XX_UNKNOWN] = "UNKNOWN",
+	[T7XX_READY] = "READY",
+	[T7XX_RESET] = "RESET",
+	[T7XX_FASTBOOT_DL_SWITCHING] = "FASTBOOT_DL_SWITCHING",
+	[T7XX_FASTBOOT_DL_MODE] = "FASTBOOT_DL_MODE",
+	[T7XX_FASTBOOT_DUMP_MODE] = "FASTBOOT_DUMP_MODE",
+};
+
+static_assert(ARRAY_SIZE(mode_names) == T7XX_MODE_LAST);
+
+static ssize_t t7xx_mode_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int index = 0;
+	struct pci_dev *pdev;
+	struct t7xx_pci_dev *t7xx_dev;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	index = sysfs_match_string(mode_names, buf);
+	if (index == T7XX_FASTBOOT_DL_SWITCHING)
+		WRITE_ONCE(t7xx_dev->mode, T7XX_FASTBOOT_DL_SWITCHING);
+
+	return count;
+};
+
+static ssize_t t7xx_mode_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	enum t7xx_mode mode = T7XX_UNKNOWN;
+	struct pci_dev *pdev;
+	struct t7xx_pci_dev *t7xx_dev;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	mode = READ_ONCE(t7xx_dev->mode);
+	if (mode < T7XX_MODE_LAST)
+		return sysfs_emit(buf, "%s\n", mode_names[mode]);
+
+	return sysfs_emit(buf, "%s\n", mode_names[T7XX_UNKNOWN]);
+}
+
+static DEVICE_ATTR_RW(t7xx_mode);
+
+static struct attribute *t7xx_mode_attr[] = {
+	&dev_attr_t7xx_mode.attr,
+	NULL
+};
+
+static const struct attribute_group t7xx_mode_attribute_group = {
+	.attrs = t7xx_mode_attr,
+};
+
+void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode)
+{
+	if (!t7xx_dev)
+		return;
+
+	WRITE_ONCE(t7xx_dev->mode, mode);
+	sysfs_notify(&t7xx_dev->pdev->dev.kobj, NULL, "t7xx_mode");
+}
+
 enum t7xx_pm_state {
 	MTK_PM_EXCEPTION,
 	MTK_PM_INIT,		/* Device initialized, but handshake not completed */
@@ -729,16 +800,28 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
 
+	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
+				 &t7xx_mode_attribute_group);
+	if (ret)
+		goto err_md_exit;
+
 	ret = t7xx_interrupt_init(t7xx_dev);
-	if (ret) {
-		t7xx_md_exit(t7xx_dev);
-		return ret;
-	}
+	if (ret)
+		goto err_remove_group;
+
 
 	t7xx_pcie_mac_set_int(t7xx_dev, MHCCIF_INT);
 	t7xx_pcie_mac_interrupts_en(t7xx_dev);
 
 	return 0;
+
+err_remove_group:
+	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
+			   &t7xx_mode_attribute_group);
+
+err_md_exit:
+	t7xx_md_exit(t7xx_dev);
+	return ret;
 }
 
 static void t7xx_pci_remove(struct pci_dev *pdev)
@@ -747,6 +830,9 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	int i;
 
 	t7xx_dev = pci_get_drvdata(pdev);
+
+	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
+			   &t7xx_mode_attribute_group);
 	t7xx_md_exit(t7xx_dev);
 
 	for (i = 0; i < EXT_INT_NUM; i++) {
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index f08f1ab74469..0abba7e6f8aa 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -43,6 +43,16 @@ struct t7xx_addr_base {
 
 typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
 
+enum t7xx_mode {
+	T7XX_UNKNOWN,
+	T7XX_READY,
+	T7XX_RESET,
+	T7XX_FASTBOOT_DL_SWITCHING,
+	T7XX_FASTBOOT_DL_MODE,
+	T7XX_FASTBOOT_DUMP_MODE,
+	T7XX_MODE_LAST, /* must always be last */
+};
+
 /* struct t7xx_pci_dev - MTK device context structure
  * @intr_handler: array of handler function for request_threaded_irq
  * @intr_thread: array of thread_fn for request_threaded_irq
@@ -59,6 +69,7 @@ typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
  * @md_pm_lock: protects PCIe sleep lock
  * @sleep_disable_count: PCIe L1.2 lock counter
  * @sleep_lock_acquire: indicates that sleep has been disabled
+ * @mode: indicates the device mode
  */
 struct t7xx_pci_dev {
 	t7xx_intr_callback	intr_handler[EXT_INT_NUM];
@@ -82,6 +93,7 @@ struct t7xx_pci_dev {
 #ifdef CONFIG_WWAN_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	u32			mode;
 };
 
 enum t7xx_pm_id {
@@ -120,5 +132,5 @@ int t7xx_pci_pm_entity_register(struct t7xx_pci_dev *t7xx_dev, struct md_pm_enti
 int t7xx_pci_pm_entity_unregister(struct t7xx_pci_dev *t7xx_dev, struct md_pm_entity *pm_entity);
 void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_pci_pm_exp_detected(struct t7xx_pci_dev *t7xx_dev);
-
+void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode);
 #endif /* __T7XX_PCI_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 0bc97430211b..c5d46f45fa62 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -272,6 +272,7 @@ static void fsm_routine_ready(struct t7xx_fsm_ctl *ctl)
 
 	ctl->curr_state = FSM_STATE_READY;
 	t7xx_fsm_broadcast_ready_state(ctl);
+	t7xx_mode_update(md->t7xx_dev, T7XX_READY);
 	t7xx_md_event_notify(md, FSM_READY);
 }
 
-- 
2.34.1


