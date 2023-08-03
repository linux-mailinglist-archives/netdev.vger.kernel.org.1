Return-Path: <netdev+bounces-23953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5165C76E46A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05206281DDC
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3C6156C6;
	Thu,  3 Aug 2023 09:32:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FF7E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:32:06 +0000 (UTC)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B93EE
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:32:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so1253408e87.3
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691055121; x=1691659921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUoMriOsN5eXOwtkkcj8Kl/7F/lT8E1W3OpYMBNWPjo=;
        b=4DJjRlpQmRMK8NjNPJPKM0wXQZXgMfvrV7ro8OE2AfBHq5ZM8SjnShl8lLJq9Fk7k/
         k7rlcONz1+AufUY0Lg+CzeGMwOvPutdhAQvfO0xsO5kLTyA2mBKrupoXJYl5/2l/c8OL
         OtoDd6toR+9eHnyGcmu4EfU/d/RJS3c/7JawczSyEndOe4clSSBFMcE4ZFbqb9olAI5K
         b/Z07QBjxyF0EC16IuhyoQbAuGJRXbjPsx1BTkPD3FXzBNx24490U6Ny7ZW0tzCNCpCo
         nnFjjzozrru0x3ukuEfvuNpXLa9DHn7xqbl7iB5bBGENwFwNgMV7KPFCF/ZvfPVELmY6
         fTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055121; x=1691659921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUoMriOsN5eXOwtkkcj8Kl/7F/lT8E1W3OpYMBNWPjo=;
        b=VPibbC6VolguiMGTttFtD5MYI1h9aNB6PGsXP2z3KZds2D/z4YTlY9VdvKV4n4DI16
         EMclie3I31ounIh2l1ASHvp16ZAsGulS9Z7rbXa9PmKhMCxih47QBpF59tQ1lIpA+Bkk
         eoKL48cz+H4StawWAUU0763wPljzbKrKvj3/9oCPumnENvUdv5E/3nv+YY+SaqVPUHPd
         LY56rWfviYK3tNvqy8j/U0fXyb9FozBcgoFVhrRE22xrrf8sa78YDZ9tsEkkTmY5cCCu
         XeNrr6lcIAgqXsy3d4XZT92T5LHIejcmsRcgGBb4h184kf+OwLglZBxlfVUfq5n7cTYp
         YX0Q==
X-Gm-Message-State: ABy/qLbqLU46OyFd57YOS34PFiicoEy4kcbEfu1Y0HRk4pEH3txzOFLG
	xTjTeOJrIG+zIoXGBo9japXqUw==
X-Google-Smtp-Source: APBJJlH9/XLrTzZnqzoH9UZ1AwKjtYr7qUqFMIBllwM6tzGCFhk1vYhqcw+g64j0cOab/5JGrKt8QA==
X-Received: by 2002:a2e:3c0d:0:b0:2b6:e292:85ab with SMTP id j13-20020a2e3c0d000000b002b6e29285abmr7425632lja.25.1691055121227;
        Thu, 03 Aug 2023 02:32:01 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d608a000000b0030ae499da59sm21410941wrt.111.2023.08.03.02.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:32:00 -0700 (PDT)
Date: Thu, 3 Aug 2023 11:31:59 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	johannes@sipsolutions.net, ryazanov.s.a@gmail.com,
	loic.poulain@linaro.org, ilpo.jarvinen@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	edumazet@google.com, pabeni@redhat.com,
	chandrashekar.devegowda@intel.com, m.chetan.kumar@linux.intel.com,
	linuxwwan@intel.com, linuxwwan_5g@intel.com,
	soumya.prakash.mishra@intel.com, jesse.brandeburg@intel.com,
	danielwinkler@google.com, Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next 2/6] net: wwan: t7xx: Driver registers with Devlink
 framework
Message-ID: <ZMt0D+T/FqQhhO4v@nanopsycho>
References: <20230803021812.6126-1-songjinjian@hotmail.com>
 <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ehu, Aug 03, 2023 at 04:18:08AM CEST, songjinjian@hotmail.com wrote:
>From: Jinjian Song <jinjian.song@fibocom.com>
>
>Adds support for t7xx wwan device firmware flashing using devlink.
>
>On early detection of wwan device in fastboot mode driver sets up CLDMA0 HW
>tx/rx queues for raw data transfer and then registers to devlink framework.
>
>Base on the v5 patch version of follow series:
>'net: wwan: t7xx: fw flashing & coredump support'
>(https://patchwork.kernel.org/project/netdevbpf/patch/fc8bbb0b66a5ff3a489ea9857d79b374508090ef.1674307425.git.m.chetan.kumar@linux.intel.com/)
>
>Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>---
> drivers/net/wwan/Kconfig                  |   1 +
> drivers/net/wwan/t7xx/Makefile            |   3 +-
> drivers/net/wwan/t7xx/t7xx_pci.c          |  15 ++-
> drivers/net/wwan/t7xx/t7xx_pci.h          |   2 +
> drivers/net/wwan/t7xx/t7xx_port_devlink.c | 149 ++++++++++++++++++++++
> drivers/net/wwan/t7xx/t7xx_port_devlink.h |  29 +++++
> drivers/net/wwan/t7xx/t7xx_port_proxy.c   |  20 +++
> drivers/net/wwan/t7xx/t7xx_port_proxy.h   |   3 +
> 8 files changed, 218 insertions(+), 4 deletions(-)
> create mode 100644 drivers/net/wwan/t7xx/t7xx_port_devlink.c
> create mode 100644 drivers/net/wwan/t7xx/t7xx_port_devlink.h
>
>diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
>index 410b0245114e..dd7a9883c1ff 100644
>--- a/drivers/net/wwan/Kconfig
>+++ b/drivers/net/wwan/Kconfig
>@@ -108,6 +108,7 @@ config IOSM
> config MTK_T7XX
> 	tristate "MediaTek PCIe 5G WWAN modem T7xx device"
> 	depends on PCI
>+	select NET_DEVLINK
> 	select RELAY if WWAN_DEBUGFS
> 	help
> 	  Enables MediaTek PCIe based 5G WWAN modem (T7xx series) device.
>diff --git a/drivers/net/wwan/t7xx/Makefile b/drivers/net/wwan/t7xx/Makefile
>index 2652cd00504e..bb28e03eea68 100644
>--- a/drivers/net/wwan/t7xx/Makefile
>+++ b/drivers/net/wwan/t7xx/Makefile
>@@ -15,7 +15,8 @@ mtk_t7xx-y:=	t7xx_pci.o \
> 		t7xx_hif_dpmaif_tx.o \
> 		t7xx_hif_dpmaif_rx.o  \
> 		t7xx_dpmaif.o \
>-		t7xx_netdev.o
>+		t7xx_netdev.o \
>+		t7xx_port_devlink.o
> 
> mtk_t7xx-$(CONFIG_WWAN_DEBUGFS) += \
> 		t7xx_port_trace.o \
>diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
>index 91256e005b84..831819267989 100644
>--- a/drivers/net/wwan/t7xx/t7xx_pci.c
>+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
>@@ -39,6 +39,7 @@
> #include "t7xx_modem_ops.h"
> #include "t7xx_pci.h"
> #include "t7xx_pcie_mac.h"
>+#include "t7xx_port_devlink.h"
> #include "t7xx_reg.h"
> #include "t7xx_state_monitor.h"
> 
>@@ -108,7 +109,7 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
> 	pm_runtime_set_autosuspend_delay(&pdev->dev, PM_AUTOSUSPEND_MS);
> 	pm_runtime_use_autosuspend(&pdev->dev);
> 
>-	return t7xx_wait_pm_config(t7xx_dev);
>+	return 0;
> }
> 
> void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
>@@ -723,22 +724,30 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	t7xx_pci_infracfg_ao_calc(t7xx_dev);
> 	t7xx_mhccif_init(t7xx_dev);
> 
>-	ret = t7xx_md_init(t7xx_dev);
>+	ret = t7xx_devlink_register(t7xx_dev);
> 	if (ret)
> 		return ret;
> 
>+	ret = t7xx_md_init(t7xx_dev);
>+	if (ret)
>+		goto err_devlink_unregister;
>+
> 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
> 
> 	ret = t7xx_interrupt_init(t7xx_dev);
> 	if (ret) {
> 		t7xx_md_exit(t7xx_dev);
>-		return ret;
>+		goto err_devlink_unregister;
> 	}
> 
> 	t7xx_pcie_mac_set_int(t7xx_dev, MHCCIF_INT);
> 	t7xx_pcie_mac_interrupts_en(t7xx_dev);
> 
> 	return 0;
>+
>+err_devlink_unregister:
>+	t7xx_devlink_unregister(t7xx_dev);
>+	return ret;
> }
> 
> static void t7xx_pci_remove(struct pci_dev *pdev)
>diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
>index f08f1ab74469..6777581cd540 100644
>--- a/drivers/net/wwan/t7xx/t7xx_pci.h
>+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
>@@ -59,6 +59,7 @@ typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
>  * @md_pm_lock: protects PCIe sleep lock
>  * @sleep_disable_count: PCIe L1.2 lock counter
>  * @sleep_lock_acquire: indicates that sleep has been disabled
>+ * @dl: devlink struct
>  */
> struct t7xx_pci_dev {
> 	t7xx_intr_callback	intr_handler[EXT_INT_NUM];
>@@ -82,6 +83,7 @@ struct t7xx_pci_dev {
> #ifdef CONFIG_WWAN_DEBUGFS
> 	struct dentry		*debugfs_dir;
> #endif
>+	struct t7xx_devlink	*dl;
> };
> 
> enum t7xx_pm_id {
>diff --git a/drivers/net/wwan/t7xx/t7xx_port_devlink.c b/drivers/net/wwan/t7xx/t7xx_port_devlink.c
>new file mode 100644
>index 000000000000..9c09464b28ee
>--- /dev/null
>+++ b/drivers/net/wwan/t7xx/t7xx_port_devlink.c
>@@ -0,0 +1,149 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
>+ * Copyright (c) 2022-2023, Intel Corporation.
>+ */
>+
>+#include <linux/vmalloc.h>
>+
>+#include "t7xx_port_proxy.h"
>+#include "t7xx_port_devlink.h"
>+
>+static int t7xx_devlink_flash_update(struct devlink *devlink,
>+				     struct devlink_flash_update_params *params,
>+				     struct netlink_ext_ack *extack)
>+{
>+	return 0;
>+}
>+
>+enum t7xx_devlink_param_id {
>+	T7XX_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>+	T7XX_DEVLINK_PARAM_ID_FASTBOOT,
>+};
>+
>+static const struct devlink_param t7xx_devlink_params[] = {
>+	DEVLINK_PARAM_DRIVER(T7XX_DEVLINK_PARAM_ID_FASTBOOT,
>+			     "fastboot", DEVLINK_PARAM_TYPE_BOOL,
>+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>+			     NULL, NULL, NULL),
>+};

Please have the param introduction in a separate file.

Just to mention it right here, this param smells very oddly to me.


>+
>+bool t7xx_devlink_param_get_fastboot(struct devlink *devlink)
>+{
>+	union devlink_param_value saved_value;
>+
>+	devl_param_driverinit_value_get(devlink, T7XX_DEVLINK_PARAM_ID_FASTBOOT,
>+					&saved_value);
>+	return saved_value.vbool;
>+}
>+
>+static int t7xx_devlink_reload_down(struct devlink *devlink, bool netns_change,
>+				    enum devlink_reload_action action,
>+				    enum devlink_reload_limit limit,
>+				    struct netlink_ext_ack *extack)
>+{
>+	return 0;
>+}
>+
>+static int t7xx_devlink_reload_up(struct devlink *devlink,
>+				  enum devlink_reload_action action,
>+				  enum devlink_reload_limit limit,
>+				  u32 *actions_performed,
>+				  struct netlink_ext_ack *extack)
>+{
>+	return 0;
>+}
>+
>+static int t7xx_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
>+				 struct netlink_ext_ack *extack)
>+{
>+	return 0;
>+}

Don't put the stub functions here. Introduce them when you need them.


>+
>+/* Call back function for devlink ops */
>+static const struct devlink_ops devlink_flash_ops = {
>+	.supported_flash_update_params = DEVLINK_SUPPORT_FLASH_UPDATE_OVERWRITE_MASK,
>+	.flash_update = t7xx_devlink_flash_update,
>+	.reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
>+			  BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE),
>+	.info_get = t7xx_devlink_info_get,
>+	.reload_down = t7xx_devlink_reload_down,
>+	.reload_up = t7xx_devlink_reload_up,
>+};
>+
>+int t7xx_devlink_register(struct t7xx_pci_dev *t7xx_dev)
>+{
>+	union devlink_param_value value;
>+	struct devlink *dl_ctx;
>+
>+	dl_ctx = devlink_alloc(&devlink_flash_ops, sizeof(struct t7xx_devlink),
>+			       &t7xx_dev->pdev->dev);
>+	if (!dl_ctx)
>+		return -ENOMEM;
>+
>+	t7xx_dev->dl = devlink_priv(dl_ctx);
>+	t7xx_dev->dl->ctx = dl_ctx;
>+	t7xx_dev->dl->t7xx_dev = t7xx_dev;
>+
>+	devl_lock(dl_ctx);
>+	devl_params_register(dl_ctx, t7xx_devlink_params, ARRAY_SIZE(t7xx_devlink_params));
>+	value.vbool = false;
>+	devl_param_driverinit_value_set(dl_ctx, T7XX_DEVLINK_PARAM_ID_FASTBOOT, value);
>+	devl_register(dl_ctx);
>+	devl_unlock(dl_ctx);
>+
>+	return 0;
>+}
>+
>+void t7xx_devlink_unregister(struct t7xx_pci_dev *t7xx_dev)
>+{
>+	struct devlink *dl_ctx = t7xx_dev->dl->ctx;
>+
>+	devl_lock(dl_ctx);
>+	devl_unregister(dl_ctx);
>+	devl_params_unregister(dl_ctx, t7xx_devlink_params, ARRAY_SIZE(t7xx_devlink_params));
>+	devl_unlock(dl_ctx);
>+	devlink_free(dl_ctx);
>+}
>+
>+/**
>+ * t7xx_devlink_init - Initialize devlink to t7xx driver
>+ * @port: Pointer to port structure
>+ *
>+ * Returns: 0 on success and error values on failure
>+ */
>+static int t7xx_devlink_init(struct t7xx_port *port)
>+{
>+	struct t7xx_devlink *dl = port->t7xx_dev->dl;
>+
>+	port->rx_length_th = T7XX_MAX_QUEUE_LENGTH;
>+
>+	dl->mode = T7XX_NORMAL_MODE;
>+	dl->status = T7XX_DEVLINK_IDLE;

? What is this supposed to mean? Looks quite wrong.


>+	dl->port = port;
>+
>+	return 0;
>+}
>+
>+static void t7xx_devlink_uninit(struct t7xx_port *port)
>+{
>+	struct t7xx_devlink *dl = port->t7xx_dev->dl;
>+
>+	dl->mode = T7XX_NORMAL_MODE;
>+
>+	skb_queue_purge(&port->rx_skb_list);
>+}
>+
>+static int t7xx_devlink_enable_chl(struct t7xx_port *port)
>+{
>+	t7xx_port_enable_chl(port);
>+
>+	return 0;
>+}
>+
>+struct port_ops devlink_port_ops = {

Could you reneame this to me less confusing? Looks like this should be
related to devlink_port, but actually it is not.

Could you please describe what exatly is the "port" entity for your
driver? What it represents?


>+	.init = &t7xx_devlink_init,
>+	.recv_skb = &t7xx_port_enqueue_skb,
>+	.uninit = &t7xx_devlink_uninit,
>+	.enable_chl = &t7xx_devlink_enable_chl,
>+	.disable_chl = &t7xx_port_disable_chl,
>+};
>diff --git a/drivers/net/wwan/t7xx/t7xx_port_devlink.h b/drivers/net/wwan/t7xx/t7xx_port_devlink.h
>new file mode 100644
>index 000000000000..12e5a63203af
>--- /dev/null
>+++ b/drivers/net/wwan/t7xx/t7xx_port_devlink.h
>@@ -0,0 +1,29 @@
>+/* SPDX-License-Identifier: GPL-2.0-only
>+ *
>+ * Copyright (c) 2022-2023, Intel Corporation.
>+ */
>+
>+#ifndef __T7XX_PORT_DEVLINK_H__
>+#define __T7XX_PORT_DEVLINK_H__
>+
>+#include <net/devlink.h>
>+#include <linux/string.h>
>+
>+#define T7XX_MAX_QUEUE_LENGTH 32
>+
>+#define T7XX_DEVLINK_IDLE   0
>+#define T7XX_NORMAL_MODE    0
>+
>+struct t7xx_devlink {
>+	struct t7xx_pci_dev *t7xx_dev;
>+	struct t7xx_port *port;
>+	struct devlink *ctx;
>+	unsigned long status;
>+	u8 mode;
>+};
>+
>+bool t7xx_devlink_param_get_fastboot(struct devlink *devlink);
>+int t7xx_devlink_register(struct t7xx_pci_dev *t7xx_dev);
>+void t7xx_devlink_unregister(struct t7xx_pci_dev *t7xx_dev);
>+
>+#endif /*__T7XX_PORT_DEVLINK_H__*/
>diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
>index bdfeb10e0c51..f185a7fb0265 100644
>--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
>+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
>@@ -109,6 +109,8 @@ static struct t7xx_port_conf t7xx_early_port_conf[] = {
> 		.txq_exp_index = CLDMA_Q_IDX_DUMP,
> 		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
> 		.path_id = CLDMA_ID_AP,
>+		.ops = &devlink_port_ops,
>+		.name = "devlink",
> 	},
> };
> 
>@@ -325,6 +327,24 @@ int t7xx_port_send_skb(struct t7xx_port *port, struct sk_buff *skb, unsigned int
> 	return t7xx_port_send_ccci_skb(port, skb, pkt_header, ex_msg);
> }
> 
>+int t7xx_port_enable_chl(struct t7xx_port *port)
>+{
>+	spin_lock(&port->port_update_lock);
>+	port->chan_enable = true;
>+	spin_unlock(&port->port_update_lock);
>+
>+	return 0;
>+}
>+
>+int t7xx_port_disable_chl(struct t7xx_port *port)
>+{
>+	spin_lock(&port->port_update_lock);
>+	port->chan_enable = false;
>+	spin_unlock(&port->port_update_lock);
>+
>+	return 0;
>+}
>+
> static void t7xx_proxy_setup_ch_mapping(struct port_proxy *port_prox)
> {
> 	struct t7xx_port *port;
>diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
>index 7f5706811445..c4cd1078ee92 100644
>--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
>+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
>@@ -93,6 +93,7 @@ struct ctrl_msg_header {
> /* Port operations mapping */
> extern struct port_ops wwan_sub_port_ops;
> extern struct port_ops ctl_port_ops;
>+extern struct port_ops devlink_port_ops;
> 
> #ifdef CONFIG_WWAN_DEBUGFS
> extern struct port_ops t7xx_trace_port_ops;
>@@ -108,5 +109,7 @@ int t7xx_port_proxy_chl_enable_disable(struct port_proxy *port_prox, unsigned in
> void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id);
> int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb);
> int t7xx_port_proxy_recv_skb_from_dedicated_queue(struct cldma_queue *queue, struct sk_buff *skb);
>+int t7xx_port_enable_chl(struct t7xx_port *port);
>+int t7xx_port_disable_chl(struct t7xx_port *port);
> 
> #endif /* __T7XX_PORT_PROXY_H__ */
>-- 
>2.34.1
>
>

