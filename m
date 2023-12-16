Return-Path: <netdev+bounces-58283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE32815B7C
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1BA282F7A
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 19:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D98D328BA;
	Sat, 16 Dec 2023 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLuYdSsw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC6321BC
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so191844566b.1
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 11:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702756692; x=1703361492; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/ZdRuXPFKlbgdyJ4e4HKq/pyNVI1CBaNxKT/o6OFfI=;
        b=JLuYdSswKpYMwfE//zJPW6WAeOhQJnGIRnY6962NVETCsm2Fn1S7CWeUciK5K5HVNE
         o3gkwb0jcGQMd8Romm6mTdlcwNC7kV5VlnYE0S0mx5oM6O4KIRFHPQwdPO2uCSGEVjO5
         LtW2srOOk0d+N6XqiEFvDle2amsCkz3gsaTBB56nD6oGjzB5Z222iGtWDbyBm3YvrzMF
         2JNIRFqKGfGpoWYbX5OhGCV2xmITjSDcGXwBwjRMatgjnNUQf4x0UifScJx3gB8h1pOj
         dpq6uaUIL9wavUZPV4MCinvJ29qiipCYLqPQqEKeK4k+G4TmRdVdyOjhmUZ+3tGzd7yu
         6ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702756692; x=1703361492;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/ZdRuXPFKlbgdyJ4e4HKq/pyNVI1CBaNxKT/o6OFfI=;
        b=CtublzP+VBFb5F/U5R4rFehGTwwCOPJLGF1ZaGgfv/hUCibcgBnOqDCzlncdNNDYt9
         wzRbOPq/h2cdmsylEbGiLVm9FiHcVUa2lAbAEIgB4oZ3YqzwC2QHwoXc8oG94/PbTCX5
         usdqjaKPeTp70AGKPrkh5WXOPkw0aGxOUlmfDLjFSG7c1ICA4gvBzRdXUDoET3NPfjyP
         AEydOLK2PjzyMdSw9NEp1fAOxqgrrACe7DFL39oNcAMj8KVCwi7W5Lm8qUWC57Dh0h0c
         wZJmncEbrK097MrJJ1yTQrR/ZmMhZTbHiF9ldhPOsnXuE9fL/rxwwMp1tUeBu51s1vNh
         sIVQ==
X-Gm-Message-State: AOJu0Yyqo3ZWBX3tMF9/ZJff4eCWbsytPUeP0fujFmTjzB97hMIptVFc
	FtNzs74WtWuaIDRCR4TyA+an7gZjq3w=
X-Google-Smtp-Source: AGHT+IFMTUmYyckqFv49UgIWSwn+QivuY2Llip/CKkQXbZxxzvx6ZgmwGZQhaLjlXH2EVNS1OKNNog==
X-Received: by 2002:a17:906:106:b0:a19:562d:5a20 with SMTP id 6-20020a170906010600b00a19562d5a20mr7884955eje.28.1702756691373;
        Sat, 16 Dec 2023 11:58:11 -0800 (PST)
Received: from ?IPV6:2a01:c23:bcb9:f800:bce0:dd9c:e9fe:4f11? (dynamic-2a01-0c23-bcb9-f800-bce0-dd9c-e9fe-4f11.c23.pool.telefonica.de. [2a01:c23:bcb9:f800:bce0:dd9c:e9fe:4f11])
        by smtp.googlemail.com with ESMTPSA id jw23-20020a17090776b700b00a23365f1290sm301939ejc.218.2023.12.16.11.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 11:58:10 -0800 (PST)
Message-ID: <6639e1bc-9b8a-4f59-9614-3c1c3cae8be2@gmail.com>
Date: Sat, 16 Dec 2023 20:58:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] r8169: add support for LED's on RTL8168/RTL8101
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This adds support for the LED's on most chip versions. Excluded are
the old non-PCIe versions and RTL8125. RTL8125 has a different LED
register layout, support for it will follow later.

LED's can be controlled from userspace using the netdev LED trigger.

Tested on RTL8168h.

Note: The driver can't know which LED's are actually physically
wired. Therefore not every LED device may represent a physically
available LED.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- changed LED naming scheme to predictable name: enxxx-y::lan
---
 drivers/net/ethernet/realtek/Makefile     |   3 +
 drivers/net/ethernet/realtek/r8169.h      |   7 +
 drivers/net/ethernet/realtek/r8169_leds.c | 157 ++++++++++++++++++++++
 drivers/net/ethernet/realtek/r8169_main.c |  65 +++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/r8169_leds.c

diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
index 2e1d78b10..adff9ebfb 100644
--- a/drivers/net/ethernet/realtek/Makefile
+++ b/drivers/net/ethernet/realtek/Makefile
@@ -7,4 +7,7 @@ obj-$(CONFIG_8139CP) += 8139cp.o
 obj-$(CONFIG_8139TOO) += 8139too.o
 obj-$(CONFIG_ATP) += atp.o
 r8169-objs += r8169_main.o r8169_firmware.o r8169_phy_config.o
+ifdef CONFIG_LEDS_TRIGGER_NETDEV
+r8169-objs += r8169_leds.o
+endif
 obj-$(CONFIG_R8169) += r8169.o
diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 55ef8251f..81567fcf3 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -8,6 +8,7 @@
  * See MAINTAINERS file for support contact information.
  */
 
+#include <linux/netdevice.h>
 #include <linux/types.h>
 #include <linux/phy.h>
 
@@ -77,3 +78,9 @@ u16 rtl8168h_2_get_adc_bias_ioffset(struct rtl8169_private *tp);
 u8 rtl8168d_efuse_read(struct rtl8169_private *tp, int reg_addr);
 void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 			 enum mac_version ver);
+
+void r8169_get_led_name(struct rtl8169_private *tp, int idx,
+			char *buf, int buf_len);
+int rtl8168_get_led_mode(struct rtl8169_private *tp);
+int rtl8168_led_mod_ctrl(struct rtl8169_private *tp, u16 mask, u16 val);
+void rtl8168_init_leds(struct net_device *ndev);
diff --git a/drivers/net/ethernet/realtek/r8169_leds.c b/drivers/net/ethernet/realtek/r8169_leds.c
new file mode 100644
index 000000000..007d077ed
--- /dev/null
+++ b/drivers/net/ethernet/realtek/r8169_leds.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* r8169_leds.c: Realtek 8169/8168/8101/8125 ethernet driver.
+ *
+ * Copyright (c) 2023 Heiner Kallweit <hkallweit1@gmail.com>
+ *
+ * See MAINTAINERS file for support contact information.
+ */
+
+#include <linux/leds.h>
+#include <linux/netdevice.h>
+#include <uapi/linux/uleds.h>
+
+#include "r8169.h"
+
+#define RTL8168_LED_CTRL_OPTION2	BIT(15)
+#define RTL8168_LED_CTRL_ACT		BIT(3)
+#define RTL8168_LED_CTRL_LINK_1000	BIT(2)
+#define RTL8168_LED_CTRL_LINK_100	BIT(1)
+#define RTL8168_LED_CTRL_LINK_10	BIT(0)
+
+#define RTL8168_NUM_LEDS		3
+
+#define RTL8168_SUPPORTED_MODES \
+	(BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK_100) | \
+	 BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_RX) | \
+	 BIT(TRIGGER_NETDEV_TX))
+
+struct r8169_led_classdev {
+	struct led_classdev led;
+	struct net_device *ndev;
+	int index;
+};
+
+#define lcdev_to_r8169_ldev(lcdev) container_of(lcdev, struct r8169_led_classdev, led)
+
+static int rtl8168_led_hw_control_is_supported(struct led_classdev *led_cdev,
+					       unsigned long flags)
+{
+	struct r8169_led_classdev *ldev = lcdev_to_r8169_ldev(led_cdev);
+	struct rtl8169_private *tp = netdev_priv(ldev->ndev);
+	int shift = ldev->index * 4;
+	bool rx, tx;
+
+	if (flags & ~RTL8168_SUPPORTED_MODES)
+		goto nosupp;
+
+	rx = flags & BIT(TRIGGER_NETDEV_RX);
+	tx = flags & BIT(TRIGGER_NETDEV_TX);
+	if (rx != tx)
+		goto nosupp;
+
+	return 0;
+
+nosupp:
+	/* Switch LED off to indicate that mode isn't supported */
+	rtl8168_led_mod_ctrl(tp, 0x000f << shift, 0);
+	return -EOPNOTSUPP;
+}
+
+static int rtl8168_led_hw_control_set(struct led_classdev *led_cdev,
+				      unsigned long flags)
+{
+	struct r8169_led_classdev *ldev = lcdev_to_r8169_ldev(led_cdev);
+	struct rtl8169_private *tp = netdev_priv(ldev->ndev);
+	int shift = ldev->index * 4;
+	u16 mode = 0;
+
+	if (flags & BIT(TRIGGER_NETDEV_LINK_10))
+		mode |= RTL8168_LED_CTRL_LINK_10;
+	if (flags & BIT(TRIGGER_NETDEV_LINK_100))
+		mode |= RTL8168_LED_CTRL_LINK_100;
+	if (flags & BIT(TRIGGER_NETDEV_LINK_1000))
+		mode |= RTL8168_LED_CTRL_LINK_1000;
+	if (flags & BIT(TRIGGER_NETDEV_TX))
+		mode |= RTL8168_LED_CTRL_ACT;
+
+	return rtl8168_led_mod_ctrl(tp, 0x000f << shift, mode << shift);
+}
+
+static int rtl8168_led_hw_control_get(struct led_classdev *led_cdev,
+				      unsigned long *flags)
+{
+	struct r8169_led_classdev *ldev = lcdev_to_r8169_ldev(led_cdev);
+	struct rtl8169_private *tp = netdev_priv(ldev->ndev);
+	int shift = ldev->index * 4;
+	int mode;
+
+	mode = rtl8168_get_led_mode(tp);
+	if (mode < 0)
+		return mode;
+
+	if (mode & RTL8168_LED_CTRL_OPTION2) {
+		rtl8168_led_mod_ctrl(tp, RTL8168_LED_CTRL_OPTION2, 0);
+		netdev_notice(ldev->ndev, "Deactivating unsupported Option2 LED mode\n");
+	}
+
+	mode = (mode >> shift) & 0x000f;
+
+	if (mode & RTL8168_LED_CTRL_ACT)
+		*flags |= BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX);
+
+	if (mode & RTL8168_LED_CTRL_LINK_10)
+		*flags |= BIT(TRIGGER_NETDEV_LINK_10);
+	if (mode & RTL8168_LED_CTRL_LINK_100)
+		*flags |= BIT(TRIGGER_NETDEV_LINK_100);
+	if (mode & RTL8168_LED_CTRL_LINK_1000)
+		*flags |= BIT(TRIGGER_NETDEV_LINK_1000);
+
+	return 0;
+}
+
+static struct device *
+	r8169_led_hw_control_get_device(struct led_classdev *led_cdev)
+{
+	struct r8169_led_classdev *ldev = lcdev_to_r8169_ldev(led_cdev);
+
+	return &ldev->ndev->dev;
+}
+
+static void rtl8168_setup_ldev(struct r8169_led_classdev *ldev,
+			       struct net_device *ndev, int index)
+{
+	struct rtl8169_private *tp = netdev_priv(ndev);
+	struct led_classdev *led_cdev = &ldev->led;
+	char led_name[LED_MAX_NAME_SIZE];
+
+	ldev->ndev = ndev;
+	ldev->index = index;
+
+	r8169_get_led_name(tp, index, led_name, LED_MAX_NAME_SIZE);
+	led_cdev->name = led_name;
+	led_cdev->default_trigger = "netdev";
+	led_cdev->hw_control_trigger = "netdev";
+	led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
+	led_cdev->hw_control_is_supported = rtl8168_led_hw_control_is_supported;
+	led_cdev->hw_control_set = rtl8168_led_hw_control_set;
+	led_cdev->hw_control_get = rtl8168_led_hw_control_get;
+	led_cdev->hw_control_get_device = r8169_led_hw_control_get_device;
+
+	/* ignore errors */
+	devm_led_classdev_register(&ndev->dev, led_cdev);
+}
+
+void rtl8168_init_leds(struct net_device *ndev)
+{
+	/* bind resource mgmt to netdev */
+	struct device *dev = &ndev->dev;
+	struct r8169_led_classdev *leds;
+	int i;
+
+	leds = devm_kcalloc(dev, RTL8168_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
+	if (!leds)
+		return;
+
+	for (i = 0; i < RTL8168_NUM_LEDS; i++)
+		rtl8168_setup_ldev(leds + i, ndev, i);
+}
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c07f82ca9..c6492096a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -285,6 +285,7 @@ enum rtl8168_8101_registers {
 };
 
 enum rtl8168_registers {
+	LED_CTRL		= 0x18,
 	LED_FREQ		= 0x1a,
 	EEE_LED			= 0x1b,
 	ERIDR			= 0x70,
@@ -616,6 +617,7 @@ struct rtl8169_private {
 
 	raw_spinlock_t config25_lock;
 	raw_spinlock_t mac_ocp_lock;
+	struct mutex led_lock;	/* serialize LED ctrl RMW access */
 
 	raw_spinlock_t cfg9346_usage_lock;
 	int cfg9346_usage_count;
@@ -788,6 +790,62 @@ static const struct rtl_cond name = {			\
 							\
 static bool name ## _check(struct rtl8169_private *tp)
 
+int rtl8168_led_mod_ctrl(struct rtl8169_private *tp, u16 mask, u16 val)
+{
+	struct device *dev = tp_to_dev(tp);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&tp->led_lock);
+	RTL_W16(tp, LED_CTRL, (RTL_R16(tp, LED_CTRL) & ~mask) | val);
+	mutex_unlock(&tp->led_lock);
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+int rtl8168_get_led_mode(struct rtl8169_private *tp)
+{
+	struct device *dev = tp_to_dev(tp);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = RTL_R16(tp, LED_CTRL);
+
+	pm_runtime_put_sync(dev);
+
+	return ret;
+}
+
+void r8169_get_led_name(struct rtl8169_private *tp, int idx,
+			char *buf, int buf_len)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	char pdom[8], pfun[8];
+	int domain;
+
+	domain = pci_domain_nr(pdev->bus);
+	if (domain)
+		snprintf(pdom, sizeof(pdom), "P%d", domain);
+	else
+		pdom[0] = '\0';
+
+	if (pdev->multifunction)
+		snprintf(pfun, sizeof(pfun), "f%d", PCI_FUNC(pdev->devfn));
+	else
+		pfun[0] = '\0';
+
+	snprintf(buf, buf_len, "en%sp%ds%d%s-%d::lan", pdom, pdev->bus->number,
+		 PCI_SLOT(pdev->devfn), pfun, idx);
+}
+
 static void r8168fp_adjust_ocp_cmd(struct rtl8169_private *tp, u32 *cmd, int type)
 {
 	/* based on RTL8168FP_OOBMAC_BASE in vendor driver */
@@ -5141,6 +5199,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	raw_spin_lock_init(&tp->cfg9346_usage_lock);
 	raw_spin_lock_init(&tp->config25_lock);
 	raw_spin_lock_init(&tp->mac_ocp_lock);
+	mutex_init(&tp->led_lock);
 
 	dev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
 						   struct pcpu_sw_netstats);
@@ -5297,6 +5356,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
+#if IS_REACHABLE(CONFIG_LEDS_CLASS) && IS_ENABLED(CONFIG_LEDS_TRIGGER_NETDEV)
+	if (tp->mac_version > RTL_GIGA_MAC_VER_06 &&
+	    tp->mac_version < RTL_GIGA_MAC_VER_61)
+		rtl8168_init_leds(dev);
+#endif
+
 	netdev_info(dev, "%s, %pM, XID %03x, IRQ %d\n",
 		    rtl_chip_infos[chipset].name, dev->dev_addr, xid, tp->irq);
 
-- 
2.43.0


