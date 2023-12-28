Return-Path: <netdev+bounces-60456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED09F81F66D
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CF228267A
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B868E63CD;
	Thu, 28 Dec 2023 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="WiF6C/pT"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2165.outbound.protection.outlook.com [40.92.63.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E163AB
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIyu5uuI+M9X0yk5leR8jBFdXfajz4S2f0gUbac6CIJErl3ssktma39r9bt+sk3uOP7bD59Rh+1GPOW4B4NsqjeMMOUI/yrnD5rpadidn9wwC2gLrvQf9iswoBCcURiebcBlhO0H8Zt1ZoCFm6/hzU01yJF4yuP2JdlkJwSYL0DqFce2avS3zDYizaNnZSdSvU6E5dUH2S3iA1r9YocdyFJtUz+TJ96xq53jum2n3/RhJa2aCdHX502kY6xGT5GRyCqUOZy74yIa56ESehXplwFzK1+ZXganQsHiklx8+ZBlhS5B7cKqgdnRTQTPwb5cmiKDsI86/2YeDexT9Wxsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5IN8epXCcQaefeNQhnpWKDmDag38i4PDW9MGOJYyWQ=;
 b=bmffPGo/V03SotIVJnDUwyBQPAYOO9icE0J8JpvlWK2A8FLE/pbJuB8KPo35pnBhSqXF76ci8T9iqiYiO8/bqUo4LKjWKIx0cscS/q0A3I85Q/xh7/FfwfefZb45+c2q/nrxmJ13/Vv4ZKYZ00PhlpaW6L8hiKx0uORu9xFjWvta05NfgIW22pRq37NdoS7UKfGikgbEuySJ9wNGd3KlFq855d9y9L+XhY4LY6skt0cODazqWtSivIZQO3K3vHrfl6jHW5o52xcR0sj/VwapUqsXkfGVXlYUCVUNSHZ3CzsS3ZrEs6IJhzij4ydlV1v4cUYZ3dvQQSnqsmo8eU9MZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5IN8epXCcQaefeNQhnpWKDmDag38i4PDW9MGOJYyWQ=;
 b=WiF6C/pT1mO9GbSbN6qFfG/VueKcPZ0rlmRSsIOQB/YfWzTn7kR6xUd1dGv+nORP+nyGpllDBZR0f80MDWchopUhtVCejyAbGaUxfb4gPFGqoC5/6gR58DtroahtraNMeCqrBAYltVHXTonMudxvNrWQBEXSncpkC9Umx49H6PtSiC2rqH46oAvM3UINyTSEAjo202HrO/EYDrtDSeCZWw/+t/sZBBbAxiMiyb7QsDUSL86mQEmtSs9SXxySzFl+UJvnOXG1aUKW6qdvIu5QoCG8lGphnMGOBwHJDQYqpbCKmnSWjgSESx+QlPO9fbxxTrMq3BwRUsPOwx1UG0bMng==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY4P282MB1497.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 09:44:57 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd%4]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:44:57 +0000
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
Subject: [net-next v3 2/3] net: wwan: t7xx: Add sysfs attribute for device state machine
Date: Thu, 28 Dec 2023 17:44:10 +0800
Message-ID:
 <MEYP282MB2697CEBA4B69B0230089AA51BB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228094411.13224-1-songjinjian@hotmail.com>
References: <20231228094411.13224-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [HOKVK+Fkm4zqpnXWYZDq2JiZxAU3xhOZ]
X-ClientProxiedBy: TYCP301CA0040.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::12) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20231228094411.13224-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY4P282MB1497:EE_
X-MS-Office365-Filtering-Correlation-Id: dae98fc9-1f12-4043-a625-08dc0789a70c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OlRyxdnFYqJK5CjrTf4Nm9G3kiSq49/FqW545t+XQuWVvxBj/lKnPw2W201Bza6c3NQvyfdcF4Mw0rONPle3cq9en7cVaN99e5lHUwgBNKWxksBBtcao4UwkG0WuQA0iQYnpO+z0t5JegM6u6jy4tyYwBfOwv9ebanG74y0br8FGRUfBiIIRJL/kKwzCD87hBpBqmpEdNDki6IVZdThtKsZMm4DMDkFvGkSDyV5vDKMyg3ssjHc7nYiOYaUgZS655ChYK1WeH8FFoa2/8UTKXpnjdiMJ36GdbIZrCkY+4XJQXKIUPE34OziptYlBwPu4xZmHzo2DMMBfusT/Rrti6EGKFCamKq8DpN+6ffLMg3u5/mJAc1/7gIcnDAqUF7OUbGRFpdQIYJ681MVYT0d1CSDELeiGuBSc+CVmgXjT4ohGnTCmI6OPRzxmotRNsGrwBlOYA7UPI2YxeSLaH3jBoHN0rF0fFjNNtBpqeD9ozVGJTznKeRCCmh10LKbOfdWxSdvN4bdVQc18NrS6fDT0uRfzk6Fl46v6WM7CLUYDQUADK3nn2t/X2fDq1eW30q26
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IqVLU0KmS1kfyz3POL2WctBEKVMWI8XWkDiE8WD9eunCkKpoCFXpCw8/x2aW?=
 =?us-ascii?Q?aQEjohpoljrGnt0t2p31WbFPsMglAMJDwEYqaqNuNuDaMJKDPP3Hdczrk3KA?=
 =?us-ascii?Q?HJ1A9e0f76kHAtWwJXu7uKvlxJ9vHe17/hjIOxPpe8bNchhEmcLhiGvVeXCM?=
 =?us-ascii?Q?4spcrIiO2OgJYzmCmB6YbYIxMUG/soDe3sgk++1ZKc6YAkKqisdOCw2T0TNc?=
 =?us-ascii?Q?v5o9K1PoDuwhL2OJTZAYvLLFWnRo8tUHbFqpLwWLQqVv13pUV9O+tc/TuuLz?=
 =?us-ascii?Q?BSKlXYQ0i1C+in57+QnCMAztwr4CCO19mtLgLnKw6TIY8vOjmvm7yqzZ+Uyb?=
 =?us-ascii?Q?COp8x7w/qdy/h4B044z2ycDH6hDs0k7SFGZeZF2C/1TSX7NL+PSaSQ3aS6tp?=
 =?us-ascii?Q?/1Yj0sDdpZEuEH854+nEOb0uopIojx3/GTWu+GPATzNyIKi3vlCW3MP655Ng?=
 =?us-ascii?Q?ebc6Ds+R+o4Y1wV9ZB625H+faJSCppcuhwhFYbYzKplCHPQlPe7LUwEydQ/f?=
 =?us-ascii?Q?78aXdD/MOgKs8zvEBRPVotTkFANCyQLbe5bjuEDaaKLQMlJg6mrlssXrM9qY?=
 =?us-ascii?Q?kzkriTcQQ94q9xtRbn6bdfCTDzVQe27pN+IQLCIaid+GVgjVaaETUumK8uY0?=
 =?us-ascii?Q?0ReqF8Skc6tEo5GAq0rUjPf8pFzFkphHNF40pGKu4sSBtqfy/Xf84ekBc2aA?=
 =?us-ascii?Q?5SAHABy9cOFb3y4FVSYuBsGRXAxqjOa2gEL1gyZjjnbUa1eJLCJPrZZNf9wK?=
 =?us-ascii?Q?mDokGKb2MRRXLLSSPzXJJJL37FhtJIBJ/HcWT6LCd6GDO3euQBQAMAigBlb+?=
 =?us-ascii?Q?e13BxK5eu39oxw7VbQ16Z9fyCcdc7BVp+rA32xIoPMyg3kDw6fLQSDKKz5Q+?=
 =?us-ascii?Q?1B9N4R3VZdOIjCUvv1zxgURPtix2qUeKcGxVGaaaHIXY/qg4QWwwPqb7d9/m?=
 =?us-ascii?Q?9fjE4vK71mVi4uXb5Y4/mtTeWmfML6UKtrm3/NGJnJ8N98b63UvJo2f+mHn6?=
 =?us-ascii?Q?R9XXoo6gDlnAh1oLbt8MYexfLqqilcmN5f7K1Cgs8AF2Hz1vpw0iOtGC9Iqu?=
 =?us-ascii?Q?p3b+qxbsoXuFBP5tVFZJpxuBnGpgNa3AA55NvBEV27eQZFKe0BFxNBUohzY+?=
 =?us-ascii?Q?k6gWuGKjx3SFrDEDNerDI3M7fpJwBwgf/TIWWoSV5Pm0cq2au0in3QhRUCuM?=
 =?us-ascii?Q?GNsH5MWhmYXwsQw40MjUTcSWvWN1j7cC61+4tcfLng5am4uj4HzI5Gn47i0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dae98fc9-1f12-4043-a625-08dc0789a70c
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:44:57.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1497

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for userspace to get the device mode,
e.g., reset/ready/fastboot mode.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v3:
 * no change 
v2:
 * optimizing using goto label in t7xx_pci_probe
---
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     |  1 +
 drivers/net/wwan/t7xx/t7xx_pci.c           | 85 +++++++++++++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.h           | 11 +++
 drivers/net/wwan/t7xx/t7xx_state_monitor.c |  1 +
 4 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 24e7d491468e..ae4578905a8d 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -192,6 +192,7 @@ static irqreturn_t t7xx_rgu_isr_thread(int irq, void *data)
 {
 	struct t7xx_pci_dev *t7xx_dev = data;
 
+	atomic_set(&t7xx_dev->mode, T7XX_RESET);
 	msleep(RGU_RESET_DELAY_MS);
 	t7xx_reset_device_via_pmic(t7xx_dev);
 	return IRQ_HANDLED;
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 91256e005b84..d5f6a8638aba 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -52,6 +52,68 @@
 #define PM_RESOURCE_POLL_TIMEOUT_US	10000
 #define PM_RESOURCE_POLL_STEP_US	100
 
+static ssize_t t7xx_mode_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct pci_dev *pdev;
+	struct t7xx_pci_dev *t7xx_dev;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	atomic_set(&t7xx_dev->mode, T7XX_FASTBOOT_DL_SWITCHING);
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
+	mode = atomic_read(&t7xx_dev->mode);
+	switch (mode) {
+	case T7XX_READY:
+		return sprintf(buf, "T7XX_MODEM_READY\n");
+
+	case T7XX_RESET:
+		return sprintf(buf, "T7XX_MODEM_RESET\n");
+
+	case T7XX_FASTBOOT_DL_SWITCHING:
+		return sprintf(buf, "T7XX_MODEM_FASTBOOT_DL_SWITCHING\n");
+
+	case T7XX_FASTBOOT_DL_MODE:
+		return sprintf(buf, "T7XX_MODEM_FASTBOOT_DL_MODE\n");
+
+	case T7XX_FASTBOOT_DUMP_MODE:
+		return sprintf(buf, "T7XX_MODEM_FASTBOOT_DUMP_MODE\n");
+
+	default:
+		return sprintf(buf, "T7XX_UNKNOWN\n");
+	}
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
 enum t7xx_pm_state {
 	MTK_PM_EXCEPTION,
 	MTK_PM_INIT,		/* Device initialized, but handshake not completed */
@@ -729,16 +791,28 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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
@@ -747,6 +821,9 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	int i;
 
 	t7xx_dev = pci_get_drvdata(pdev);
+
+	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
+			   &t7xx_mode_attribute_group);
 	t7xx_md_exit(t7xx_dev);
 
 	for (i = 0; i < EXT_INT_NUM; i++) {
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index f08f1ab74469..fcd44e2d0a46 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -43,6 +43,15 @@ struct t7xx_addr_base {
 
 typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
 
+enum t7xx_mode {
+	T7XX_UNKNOWN,
+	T7XX_READY,
+	T7XX_RESET,
+	T7XX_FASTBOOT_DL_SWITCHING,
+	T7XX_FASTBOOT_DL_MODE,
+	T7XX_FASTBOOT_DUMP_MODE
+};
+
 /* struct t7xx_pci_dev - MTK device context structure
  * @intr_handler: array of handler function for request_threaded_irq
  * @intr_thread: array of thread_fn for request_threaded_irq
@@ -59,6 +68,7 @@ typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
  * @md_pm_lock: protects PCIe sleep lock
  * @sleep_disable_count: PCIe L1.2 lock counter
  * @sleep_lock_acquire: indicates that sleep has been disabled
+ * @mode: indicates the device mode
  */
 struct t7xx_pci_dev {
 	t7xx_intr_callback	intr_handler[EXT_INT_NUM];
@@ -82,6 +92,7 @@ struct t7xx_pci_dev {
 #ifdef CONFIG_WWAN_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	atomic_t		mode;
 };
 
 enum t7xx_pm_id {
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 0bc97430211b..23f54226aba0 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -272,6 +272,7 @@ static void fsm_routine_ready(struct t7xx_fsm_ctl *ctl)
 
 	ctl->curr_state = FSM_STATE_READY;
 	t7xx_fsm_broadcast_ready_state(ctl);
+	atomic_set(&md->t7xx_dev->mode, T7XX_READY);
 	t7xx_md_event_notify(md, FSM_READY);
 }
 
-- 
2.34.1


