Return-Path: <netdev+bounces-23960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9DC76E504
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241B1282090
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAC015AE0;
	Thu,  3 Aug 2023 09:53:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11867E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:53:06 +0000 (UTC)
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4C2E2
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:53:03 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso11277921fa.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691056381; x=1691661181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Mq26ldOW3AFRew4vfV6UwcpHSRrrycepBNY7DcTe1I=;
        b=mG1i42VYZh5sRFdKfROve9FWGxj9Ubj6E23sjvmn61ZE6x4F0I7hvILzmoqukDIe+z
         TQbT8fv2pTCgPb9dmKmkKmIFGsUfjg6xuCCcl8lF2aAR4UOqYlrtrEmAW9O85iEOT4eA
         IhaZaiDoGy4rkfGYdplE4Vxbv2nnQNWW1B5f0GBifeBBoi9D/vrcYu+ZnWRp4MvK3qqM
         aSaPEdUwoHllefZ76YXz+S+XAM9MEqcY7BoYa40+UQdICXd/PdKHC3n79BSDA1DW7Iub
         pTVABHTRiFcHsdSC80nlaTeb3Nw4yjFoVn3mfs3wzTWHwmdf0wmyYAiQ6f3dXxvzQH1h
         eHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691056381; x=1691661181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Mq26ldOW3AFRew4vfV6UwcpHSRrrycepBNY7DcTe1I=;
        b=TFBK6k48L7VbmhYmI9bYv8Z4Fz5RHgPTh1C4LPKlTbqIRr5/w3f5Pqt6/4VGSqK6vR
         hHxWRIdTspCSxVVe0Ny3FpoLOU5EqyGYnKfSsmgH0pNNKcTj7rp8iQs+Nb4FWinDIXz0
         X+dPFanTw2ox6fj/e9Iuv6gExXEhxeh1Txexd9p50s0kWD1Dxh/iKDmzsF/yRPwV0Njz
         T6uY8WiGI+chp0s3lBgS2rbBmoLlFjvn9jiqoHpT2G7OvM21VwBoFpAiMA0L0UmnxNUW
         eCpGRJCmlXQVKu3OsR44ch4ySB92gviJQolno6dDfC3iel09BvQ4u5k8wuJ+MTaYlmDs
         CAzA==
X-Gm-Message-State: ABy/qLZu90ucZem5HiSd7nq7EoEGM4BYHVNIjqVifgYV2d8gW5ZTwSLW
	hZQQPAjKZSq5qZtegAN6LoB5ZQ==
X-Google-Smtp-Source: APBJJlGmP1jeoSE/jWYRt7DhMUcirr+xb334S4Qz2tuNYUw6jnY5ue2uSCzc5dGL9bQNcPPBJgxo0g==
X-Received: by 2002:a2e:9183:0:b0:2b9:dd96:5346 with SMTP id f3-20020a2e9183000000b002b9dd965346mr6485096ljg.50.1691056381413;
        Thu, 03 Aug 2023 02:53:01 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id y6-20020a1709064b0600b00991bba473e2sm10249897eju.85.2023.08.03.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:53:00 -0700 (PDT)
Date: Thu, 3 Aug 2023 11:52:59 +0200
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
Subject: Re: [net-next 3/6] net: wwan: t7xx: Implements devlink ops of
 firmware flashing
Message-ID: <ZMt4+6rnbZE9Ejao@nanopsycho>
References: <20230803021812.6126-1-songjinjian@hotmail.com>
 <MEYP282MB2697937841838C688E1237FDBB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB2697937841838C688E1237FDBB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 03, 2023 at 04:18:09AM CEST, songjinjian@hotmail.com wrote:
>From: Jinjian Song <jinjian.song@fibocom.com>
>
>Adds support for t7xx wwan device firmware flashing using devlink.
>
>On user space application issuing command for firmware update the driver
>sends fastboot flash command & firmware to program NAND.
>
>In flashing procedure the fastboot command & response are exchanged between
>driver and device.
>
>Below is the devlink command usage for firmware flashing
>
>$devlink dev flash pci/$BDF file ABC.img component ABC
>
>Note: ABC.img is the firmware to be programmed to "ABC" partition.
>
>Base on the v5 patch version of follow series:
>'net: wwan: t7xx: fw flashing & coredump support'
>(https://patchwork.kernel.org/project/netdevbpf/patch/fc8bbb0b66a5ff3a489ea9857d79b374508090ef.1674307425.git.m.chetan.kumar@linux.intel.com/)
>
>Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>

Overall, this patch/patchset is very ugly and does some wrong or
questionable things that make my head hurt. Ugh.


>---
> drivers/net/wwan/t7xx/Makefile             |   3 +-
> drivers/net/wwan/t7xx/t7xx_pci.c           |   2 +
> drivers/net/wwan/t7xx/t7xx_port.h          |   2 +
> drivers/net/wwan/t7xx/t7xx_port_devlink.c  | 325 ++++++++++++++++++++-
> drivers/net/wwan/t7xx/t7xx_port_devlink.h  |  16 +
> drivers/net/wwan/t7xx/t7xx_port_proxy.c    |  12 +
> drivers/net/wwan/t7xx/t7xx_port_proxy.h    |   1 +
> drivers/net/wwan/t7xx/t7xx_port_wwan.c     |  22 +-
> drivers/net/wwan/t7xx/t7xx_reg.h           |   6 +
> drivers/net/wwan/t7xx/t7xx_state_monitor.c |  42 ++-
> 10 files changed, 400 insertions(+), 31 deletions(-)
>
>diff --git a/drivers/net/wwan/t7xx/Makefile b/drivers/net/wwan/t7xx/Makefile
>index bb28e03eea68..1f98e28011fd 100644
>--- a/drivers/net/wwan/t7xx/Makefile
>+++ b/drivers/net/wwan/t7xx/Makefile
>@@ -16,7 +16,8 @@ mtk_t7xx-y:=	t7xx_pci.o \
> 		t7xx_hif_dpmaif_rx.o  \
> 		t7xx_dpmaif.o \
> 		t7xx_netdev.o \
>-		t7xx_port_devlink.o
>+		t7xx_port_devlink.o \
>+		t7xx_port_ap_msg.o
> 
> mtk_t7xx-$(CONFIG_WWAN_DEBUGFS) += \
> 		t7xx_port_trace.o \
>diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
>index 831819267989..5e9b954f39ce 100644
>--- a/drivers/net/wwan/t7xx/t7xx_pci.c
>+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
>@@ -766,6 +766,8 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
> 	}
> 
> 	pci_free_irq_vectors(t7xx_dev->pdev);
>+
>+	t7xx_devlink_unregister(t7xx_dev);
> }
> 
> static const struct pci_device_id t7xx_pci_table[] = {
>diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
>index 09acb1ef144d..dfa7ad2a9796 100644
>--- a/drivers/net/wwan/t7xx/t7xx_port.h
>+++ b/drivers/net/wwan/t7xx/t7xx_port.h
>@@ -42,6 +42,8 @@ enum port_ch {
> 	/* to AP */
> 	PORT_CH_AP_CONTROL_RX = 0x1000,
> 	PORT_CH_AP_CONTROL_TX = 0x1001,
>+	PORT_CH_AP_MSG_RX = 0x101E,
>+	PORT_CH_AP_MSG_TX = 0x101F,
> 
> 	/* to MD */
> 	PORT_CH_CONTROL_RX = 0x2000,
>diff --git a/drivers/net/wwan/t7xx/t7xx_port_devlink.c b/drivers/net/wwan/t7xx/t7xx_port_devlink.c
>index 9c09464b28ee..f10804a2c0d7 100644
>--- a/drivers/net/wwan/t7xx/t7xx_port_devlink.c
>+++ b/drivers/net/wwan/t7xx/t7xx_port_devlink.c
>@@ -6,12 +6,216 @@
> #include <linux/vmalloc.h>
> 
> #include "t7xx_port_proxy.h"
>+#include "t7xx_port_ap_msg.h"
> #include "t7xx_port_devlink.h"
> 
>+static int t7xx_devlink_port_read(struct t7xx_port *port, char *buf, size_t count)

You have "devlink" in lot of the function and struct field names. Does
not make sense to me as for example this function does not have anything
to do with devlink. Could you please rename them all?


>+{
>+	struct sk_buff *skb;
>+	int read_len;
>+
>+	spin_lock_irq(&port->rx_wq.lock);
>+	if (skb_queue_empty(&port->rx_skb_list)) {
>+		int ret = wait_event_interruptible_locked_irq(port->rx_wq,
>+							      !skb_queue_empty(&port->rx_skb_list));
>+		if (ret == -ERESTARTSYS) {
>+			spin_unlock_irq(&port->rx_wq.lock);
>+			return ret;
>+		}
>+	}
>+	skb = skb_dequeue(&port->rx_skb_list);
>+	spin_unlock_irq(&port->rx_wq.lock);
>+
>+	read_len = min_t(size_t, count, skb->len);
>+	memcpy(buf, skb->data, read_len);
>+
>+	if (read_len < skb->len) {
>+		skb_pull(skb, read_len);
>+		skb_queue_head(&port->rx_skb_list, skb);
>+	} else {
>+		consume_skb(skb);
>+	}
>+
>+	return read_len;
>+}
>+
>+static int t7xx_devlink_port_write(struct t7xx_port *port, const char *buf, size_t count)
>+{
>+	const struct t7xx_port_conf *port_conf = port->port_conf;
>+	size_t actual = count, offset = 0;
>+	int txq_mtu;
>+
>+	txq_mtu = t7xx_get_port_mtu(port);
>+	if (txq_mtu < 0)
>+		return -EINVAL;
>+
>+	while (actual) {
>+		int len = min_t(size_t, actual, txq_mtu);
>+		struct sk_buff *skb;
>+		int ret;
>+
>+		skb = __dev_alloc_skb(len, GFP_KERNEL);
>+		if (!skb)
>+			return -ENOMEM;
>+
>+		skb_put_data(skb, buf + offset, len);
>+		ret = t7xx_port_send_raw_skb(port, skb);
>+		if (ret) {
>+			dev_err(port->dev, "write error on %s, size: %d, ret: %d\n",
>+				port_conf->name, len, ret);
>+			dev_kfree_skb(skb);
>+			return ret;
>+		}
>+
>+		offset += len;
>+		actual -= len;
>+	}
>+
>+	return count;
>+}
>+
>+static int t7xx_devlink_fb_handle_response(struct t7xx_port *port, char *data)
>+{
>+	char status[T7XX_FB_RESPONSE_SIZE + 1];
>+	int ret = 0, index;
>+
>+	for (index = 0; index < T7XX_FB_RESP_COUNT; index++) {
>+		int read_bytes = t7xx_devlink_port_read(port, status, T7XX_FB_RESPONSE_SIZE);
>+
>+		if (read_bytes < 0) {
>+			dev_err(port->dev, "status read interrupted\n");
>+			ret = read_bytes;
>+			break;
>+		}
>+
>+		status[read_bytes] = '\0';
>+		dev_dbg(port->dev, "raw response from device: %s\n", status);
>+		if (!strncmp(status, T7XX_FB_RESP_INFO, strlen(T7XX_FB_RESP_INFO))) {
>+			break;
>+		} else if (!strncmp(status, T7XX_FB_RESP_OKAY, strlen(T7XX_FB_RESP_OKAY))) {
>+			break;
>+		} else if (!strncmp(status, T7XX_FB_RESP_FAIL, strlen(T7XX_FB_RESP_FAIL))) {
>+			ret = -EPROTO;
>+			break;
>+		} else if (!strncmp(status, T7XX_FB_RESP_DATA, strlen(T7XX_FB_RESP_DATA))) {
>+			if (data)
>+				snprintf(data, T7XX_FB_RESPONSE_SIZE, "%s",
>+					 status + strlen(T7XX_FB_RESP_DATA));
>+			break;
>+		}
>+	}
>+
>+	return ret;
>+}
>+
>+static int t7xx_devlink_fb_raw_command(char *cmd, struct t7xx_port *port, char *data)
>+{
>+	int ret, cmd_size = strlen(cmd);
>+
>+	if (cmd_size > T7XX_FB_COMMAND_SIZE) {
>+		dev_err(port->dev, "command length %d is long\n", cmd_size);
>+		return -EINVAL;
>+	}
>+
>+	if (cmd_size != t7xx_devlink_port_write(port, cmd, cmd_size)) {
>+		dev_err(port->dev, "raw command = %s write failed\n", cmd);
>+		return -EIO;
>+	}
>+
>+	dev_dbg(port->dev, "raw command = %s written to the device\n", cmd);
>+	ret = t7xx_devlink_fb_handle_response(port, data);
>+	if (ret)
>+		dev_err(port->dev, "raw command = %s response FAILURE:%d\n", cmd, ret);
>+
>+	return ret;
>+}
>+
>+static int t7xx_devlink_fb_download_command(struct t7xx_port *port, size_t size)
>+{
>+	char download_command[T7XX_FB_COMMAND_SIZE];
>+
>+	snprintf(download_command, sizeof(download_command), "%s:%08zx",
>+		 T7XX_FB_CMD_DOWNLOAD, size);
>+	return t7xx_devlink_fb_raw_command(download_command, port, NULL);
>+}
>+
>+static int t7xx_devlink_fb_download(struct t7xx_port *port, const u8 *buf, size_t size)
>+{
>+	int ret;
>+
>+	if (!size)
>+		return -EINVAL;
>+
>+	ret = t7xx_devlink_fb_download_command(port, size);
>+	if (ret)
>+		return ret;
>+
>+	ret = t7xx_devlink_port_write(port, buf, size);
>+	if (ret < 0)
>+		return ret;
>+
>+	return t7xx_devlink_fb_handle_response(port, NULL);
>+}
>+
>+static int t7xx_devlink_fb_flash(struct t7xx_port *port, const char *cmd)
>+{
>+	char flash_command[T7XX_FB_COMMAND_SIZE];
>+
>+	snprintf(flash_command, sizeof(flash_command), "%s:%s", T7XX_FB_CMD_FLASH, cmd);
>+	return t7xx_devlink_fb_raw_command(flash_command, port, NULL);
>+}
>+
>+static int t7xx_devlink_fb_flash_partition(struct t7xx_port *port, const char *partition,
>+					   const u8 *buf, size_t size)
>+{
>+	int ret;
>+
>+	ret = t7xx_devlink_fb_download(port, buf, size);
>+	if (ret < 0)
>+		return ret;
>+
>+	return t7xx_devlink_fb_flash(port, partition);
>+}
>+
> static int t7xx_devlink_flash_update(struct devlink *devlink,
> 				     struct devlink_flash_update_params *params,
> 				     struct netlink_ext_ack *extack)
> {
>+	struct t7xx_devlink *dl = devlink_priv(devlink);
>+	const char *component = params->component;
>+	const struct firmware *fw = params->fw;
>+	struct t7xx_port *port;
>+	char flash_status[32];
>+	int ret;
>+
>+	if (dl->mode != T7XX_FB_DL_MODE) {
>+		dev_err(&dl->t7xx_dev->pdev->dev, "Modem is not in fastboot download mode!\n");
>+		ret = -EPERM;
>+		goto err_out;
>+	}
>+
>+	if (dl->status != T7XX_DEVLINK_IDLE) {
>+		dev_err(&dl->t7xx_dev->pdev->dev, "Modem is busy!\n");
>+		ret = -EBUSY;
>+		goto err_out;
>+	}
>+
>+	if (!component || !fw->data) {
>+		ret = -EINVAL;
>+		goto err_out;
>+	}
>+
>+	set_bit(T7XX_FLASH_STATUS, &dl->status);
>+	port = dl->port;
>+	dev_dbg(port->dev, "flash partition name:%s binary size:%zu\n", component, fw->size);
>+	ret = t7xx_devlink_fb_flash_partition(port, component, fw->data, fw->size);
>+
>+	sprintf(flash_status, "%s %s", "flashing", !ret ? "success" : "failure");

Don't put return status in to the flash_status. Function returns error
value which is propagated to the user.

In fact, in your case, usage of devlink_flash_update_status_notify()
does not make much sense as you don't have multiple flash stages.


>+	devlink_flash_update_status_notify(devlink, flash_status, params->component, 0, 0);
>+	clear_bit(T7XX_FLASH_STATUS, &dl->status);
>+
>+err_out:
>+	return ret;
> 	return 0;
> }
> 
>@@ -41,7 +245,19 @@ static int t7xx_devlink_reload_down(struct devlink *devlink, bool netns_change,
> 				    enum devlink_reload_limit limit,
> 				    struct netlink_ext_ack *extack)
> {
>-	return 0;
>+	struct t7xx_devlink *dl = devlink_priv(devlink);
>+
>+	switch (action) {
>+	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
>+		return 0;
>+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>+		if (!dl->mode)
>+			return -EPERM;
>+		return t7xx_devlink_fb_raw_command(T7XX_FB_CMD_REBOOT, dl->port, NULL);
>+	default:
>+		/* Unsupported action should not get to this function */
>+		return -EOPNOTSUPP;
>+	}
> }
> 
> static int t7xx_devlink_reload_up(struct devlink *devlink,
>@@ -50,13 +266,114 @@ static int t7xx_devlink_reload_up(struct devlink *devlink,
> 				  u32 *actions_performed,
> 				  struct netlink_ext_ack *extack)
> {
>-	return 0;
>+	*actions_performed = BIT(action);
>+	switch (action) {
>+	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:

Your driver reinit does not do anything. Please remove it from supported
actions.


>+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>+		return 0;
>+	default:
>+		/* Unsupported action should not get to this function */
>+		return -EOPNOTSUPP;
>+	}
>+}
>+
>+static int t7xx_devlink_get_part_ver_fb_mode(struct t7xx_port *port, const char *cmd, char *data)
>+{
>+	char req_command[T7XX_FB_COMMAND_SIZE];
>+
>+	snprintf(req_command, sizeof(req_command), "%s:%s", T7XX_FB_CMD_GET_VER, cmd);
>+	return t7xx_devlink_fb_raw_command(req_command, port, data);
>+}
>+
>+static int t7xx_devlink_get_part_ver_norm_mode(struct t7xx_port *port, const char *cmd, char *data)
>+{
>+	char req_command[T7XX_FB_COMMAND_SIZE];
>+	int len;
>+
>+	len = snprintf(req_command, sizeof(req_command), "%s:%s", T7XX_FB_CMD_GET_VER, cmd);
>+	t7xx_port_ap_msg_tx(port, req_command, len);
>+
>+	return t7xx_devlink_fb_handle_response(port, data);
> }
> 
> static int t7xx_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
> 				 struct netlink_ext_ack *extack)
> {
>-	return 0;
>+	struct t7xx_devlink *dl = devlink_priv(devlink);
>+	char *part_name, *ver, *part_no, *data;
>+	int ret, total_part, i, ver_len;
>+	struct t7xx_port *port;
>+
>+	port = dl->port;
>+	port->port_conf->ops->enable_chl(port);
>+
>+	if (dl->status != T7XX_DEVLINK_IDLE) {
>+		dev_err(&dl->t7xx_dev->pdev->dev, "Modem is busy!\n");
>+		return -EBUSY;
>+	}
>+
>+	data = kzalloc(T7XX_FB_RESPONSE_SIZE, GFP_KERNEL);
>+	if (!data)
>+		return -ENOMEM;
>+
>+	set_bit(T7XX_GET_INFO, &dl->status);
>+	if (dl->mode == T7XX_FB_DL_MODE)
>+		ret = t7xx_devlink_get_part_ver_fb_mode(port, "", data);
>+	else
>+		ret = t7xx_devlink_get_part_ver_norm_mode(port, "", data);
>+
>+	if (ret < 0)
>+		goto err_clear_bit;
>+
>+	part_no = strsep(&data, ",");
>+	if (kstrtoint(part_no, 16, &total_part)) {
>+		dev_err(&dl->t7xx_dev->pdev->dev, "kstrtoint error!\n");
>+		ret = -EINVAL;
>+		goto err_clear_bit;
>+	}
>+
>+	for (i = 0; i < total_part; i++) {
>+		part_name = strsep(&data, ",");
>+		ver = strsep(&data, ",");
>+		ver_len = strlen(ver);
>+		if (ver[ver_len - 2] == 0x5C && ver[ver_len - 1] == 0x6E)
>+			ver[ver_len - 4] = '\0';
>+		ret = devlink_info_version_running_put_ext(req, part_name, ver,
>+							   DEVLINK_INFO_VERSION_TYPE_COMPONENT);
>+	}
>+
>+err_clear_bit:
>+	clear_bit(T7XX_GET_INFO, &dl->status);
>+	kfree(data);
>+	return ret;
>+}
>+
>+struct devlink_info_req {
>+	struct sk_buff *msg;
>+	void (*version_cb)(const char *version_name,
>+			   enum devlink_info_version_type version_type,
>+			   void *version_cb_priv);
>+	void *version_cb_priv;
>+};

Ah! No. Remove this. If you need to touch internal of the struct, this
is definitelly not the way to do it.


>+
>+struct devlink_flash_component_lookup_ctx {
>+	const char *lookup_name;
>+	bool lookup_name_found;
>+};

Same here.

>+
>+static int t7xx_devlink_info_get_loopback(struct devlink *devlink, struct devlink_info_req *req,
>+					  struct netlink_ext_ack *extack)
>+{
>+	struct devlink_flash_component_lookup_ctx *lookup_ctx = req->version_cb_priv;
>+	int ret;
>+
>+	if (!req)
>+		return t7xx_devlink_info_get(devlink, req, extack);
>+
>+	ret = devlink_info_version_running_put_ext(req, lookup_ctx->lookup_name,

It actually took me a while why you are doing this. You try to overcome
the limitation for drivers to expose version for all components that are
valid for flashing. That is not nice

Please don't do things like this!

Expose the versions for all valid components, or don't flash them.


>+						   "1.0", DEVLINK_INFO_VERSION_TYPE_COMPONENT);
>+
>+	return ret;
> }
> 
> /* Call back function for devlink ops */
>@@ -65,7 +382,7 @@ static const struct devlink_ops devlink_flash_ops = {
> 	.flash_update = t7xx_devlink_flash_update,
> 	.reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
> 			  BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE),
>-	.info_get = t7xx_devlink_info_get,
>+	.info_get = t7xx_devlink_info_get_loopback,
> 	.reload_down = t7xx_devlink_reload_down,
> 	.reload_up = t7xx_devlink_reload_up,
> };
>diff --git a/drivers/net/wwan/t7xx/t7xx_port_devlink.h b/drivers/net/wwan/t7xx/t7xx_port_devlink.h
>index 12e5a63203af..92f0993e7205 100644
>--- a/drivers/net/wwan/t7xx/t7xx_port_devlink.h
>+++ b/drivers/net/wwan/t7xx/t7xx_port_devlink.h
>@@ -10,9 +10,25 @@
> #include <linux/string.h>
> 
> #define T7XX_MAX_QUEUE_LENGTH 32
>+#define T7XX_FB_COMMAND_SIZE  64
>+#define T7XX_FB_RESPONSE_SIZE 512
>+#define T7XX_FB_RESP_COUNT    30
>+
>+#define T7XX_FLASH_STATUS   0
>+#define T7XX_GET_INFO       3
> 
> #define T7XX_DEVLINK_IDLE   0
> #define T7XX_NORMAL_MODE    0
>+#define T7XX_FB_DL_MODE     1
>+
>+#define T7XX_FB_CMD_DOWNLOAD     "download"
>+#define T7XX_FB_CMD_FLASH        "flash"
>+#define T7XX_FB_CMD_REBOOT       "reboot"
>+#define T7XX_FB_RESP_OKAY        "OKAY"
>+#define T7XX_FB_RESP_FAIL        "FAIL"
>+#define T7XX_FB_RESP_DATA        "DATA"
>+#define T7XX_FB_RESP_INFO        "INFO"
>+#define T7XX_FB_CMD_GET_VER      "get_version"
> 
> struct t7xx_devlink {
> 	struct t7xx_pci_dev *t7xx_dev;
>diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
>index f185a7fb0265..9e22f751bb2e 100644
>--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
>+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
>@@ -40,6 +40,7 @@
> #define Q_IDX_CTRL			0
> #define Q_IDX_MBIM			2
> #define Q_IDX_AT_CMD			5
>+#define Q_IDX_AP_MSG			2
> 
> #define INVALID_SEQ_NUM			GENMASK(15, 0)
> 
>@@ -97,7 +98,18 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
> 		.path_id = CLDMA_ID_AP,
> 		.ops = &ctl_port_ops,
> 		.name = "t7xx_ap_ctrl",
>+	}, {
>+		.tx_ch = PORT_CH_AP_MSG_TX,
>+		.rx_ch = PORT_CH_AP_MSG_RX,
>+		.txq_index = Q_IDX_AP_MSG,
>+		.rxq_index = Q_IDX_AP_MSG,
>+		.txq_exp_index = Q_IDX_AP_MSG,
>+		.rxq_exp_index = Q_IDX_AP_MSG,
>+		.path_id = CLDMA_ID_AP,
>+		.ops = &ap_msg_port_ops,
>+		.name = "ap_msg",
> 	},
>+
> };
> 
> static struct t7xx_port_conf t7xx_early_port_conf[] = {
>diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
>index c4cd1078ee92..030576a55623 100644
>--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
>+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
>@@ -94,6 +94,7 @@ struct ctrl_msg_header {
> extern struct port_ops wwan_sub_port_ops;
> extern struct port_ops ctl_port_ops;
> extern struct port_ops devlink_port_ops;
>+extern struct port_ops ap_msg_port_ops;
> 
> #ifdef CONFIG_WWAN_DEBUGFS
> extern struct port_ops t7xx_trace_port_ops;
>diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
>index ddc20ddfa734..b4e2926f33f6 100644
>--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
>+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
>@@ -131,24 +131,6 @@ static int t7xx_port_wwan_recv_skb(struct t7xx_port *port, struct sk_buff *skb)
> 	return 0;
> }
> 
>-static int t7xx_port_wwan_enable_chl(struct t7xx_port *port)
>-{
>-	spin_lock(&port->port_update_lock);
>-	port->chan_enable = true;
>-	spin_unlock(&port->port_update_lock);
>-
>-	return 0;
>-}
>-
>-static int t7xx_port_wwan_disable_chl(struct t7xx_port *port)
>-{
>-	spin_lock(&port->port_update_lock);
>-	port->chan_enable = false;
>-	spin_unlock(&port->port_update_lock);
>-
>-	return 0;
>-}
>-
> static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int state)
> {
> 	const struct t7xx_port_conf *port_conf = port->port_conf;
>@@ -173,7 +155,7 @@ struct port_ops wwan_sub_port_ops = {
> 	.init = t7xx_port_wwan_init,
> 	.recv_skb = t7xx_port_wwan_recv_skb,
> 	.uninit = t7xx_port_wwan_uninit,
>-	.enable_chl = t7xx_port_wwan_enable_chl,
>-	.disable_chl = t7xx_port_wwan_disable_chl,
>+	.enable_chl = t7xx_port_enable_chl,
>+	.disable_chl = t7xx_port_disable_chl,
> 	.md_state_notify = t7xx_port_wwan_md_state_notify,
> };
>diff --git a/drivers/net/wwan/t7xx/t7xx_reg.h b/drivers/net/wwan/t7xx/t7xx_reg.h
>index 3b665c6116fe..b106c988321a 100644
>--- a/drivers/net/wwan/t7xx/t7xx_reg.h
>+++ b/drivers/net/wwan/t7xx/t7xx_reg.h
>@@ -101,10 +101,16 @@ enum t7xx_pm_resume_state {
> 	PM_RESUME_REG_STATE_L2_EXP,
> };
> 
>+enum host_event_e {
>+	HOST_EVENT_INIT = 0,
>+	FASTBOOT_DL_NOTIFY = 0x3,
>+};
>+
> #define T7XX_PCIE_MISC_DEV_STATUS		0x0d1c
> #define MISC_RESET_TYPE_FLDR			BIT(27)
> #define MISC_RESET_TYPE_PLDR			BIT(26)
> #define MISC_LK_EVENT_MASK			GENMASK(11, 8)
>+#define HOST_EVENT_MASK			GENMASK(31, 28)
> 
> enum lk_event_id {
> 	LK_EVENT_NORMAL = 0,
>diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
>index 9c51e332e7c5..a6147f2324a6 100644
>--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
>+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
>@@ -37,6 +37,7 @@
> #include "t7xx_modem_ops.h"
> #include "t7xx_pci.h"
> #include "t7xx_pcie_mac.h"
>+#include "t7xx_port_devlink.h"
> #include "t7xx_port_proxy.h"
> #include "t7xx_reg.h"
> #include "t7xx_state_monitor.h"
>@@ -206,11 +207,22 @@ static void fsm_routine_exception(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comm
> 		fsm_finish_command(ctl, cmd, 0);
> }
> 
>+static void t7xx_host_event_notify(struct t7xx_modem *md, unsigned int event_id)
>+{
>+	u32 value;
>+
>+	value = ioread32(IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
>+	value &= ~HOST_EVENT_MASK;
>+	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
>+	iowrite32(value, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
>+}
>+
> static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int status)
> {
> 	struct t7xx_modem *md = ctl->md;
> 	struct cldma_ctrl *md_ctrl;
> 	enum lk_event_id lk_event;
>+	struct t7xx_port *port;
> 	struct device *dev;
> 
> 	dev = &md->t7xx_dev->pdev->dev;
>@@ -221,10 +233,19 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
> 		break;
> 
> 	case LK_EVENT_CREATE_PD_PORT:
>+	case LK_EVENT_CREATE_POST_DL_PORT:
> 		md_ctrl = md->md_ctrl[CLDMA_ID_AP];
> 		t7xx_cldma_hif_hw_init(md_ctrl);
> 		t7xx_cldma_stop(md_ctrl);
> 		t7xx_cldma_switch_cfg(md_ctrl, CLDMA_DEDICATED_Q_CFG);
>+		port = ctl->md->t7xx_dev->dl->port;
>+		if (WARN_ON(!port))
>+			return;
>+
>+		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
>+			md->t7xx_dev->dl->mode = T7XX_FB_DL_MODE;
>+
>+		port->port_conf->ops->enable_chl(port);
> 		t7xx_cldma_start(md_ctrl);
> 		break;
> 
>@@ -258,7 +279,9 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
> 	struct cldma_ctrl *md_ctrl;
> 	int err;
> 
>-	if (ctl->curr_state == FSM_STATE_STOPPED || ctl->curr_state == FSM_STATE_STOPPING) {
>+	if (ctl->curr_state == FSM_STATE_STOPPED ||
>+	    ctl->curr_state == FSM_STATE_STOPPING ||
>+	    ctl->md->rgu_irq_asserted) {
> 		fsm_finish_command(ctl, cmd, -EINVAL);
> 		return;
> 	}
>@@ -270,11 +293,18 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
> 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_TO_STOP);
> 	t7xx_cldma_stop(md_ctrl);
> 
>-	if (!ctl->md->rgu_irq_asserted) {
>-		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
>-		/* Wait for the DRM disable to take effect */
>-		msleep(FSM_DRM_DISABLE_DELAY_MS);
>-
>+	if (t7xx_devlink_param_get_fastboot(t7xx_dev->dl->ctx))
>+		t7xx_host_event_notify(ctl->md, FASTBOOT_DL_NOTIFY);
>+
>+	t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
>+	/* Wait for the DRM disable to take effect */
>+	msleep(FSM_DRM_DISABLE_DELAY_MS);
>+	if (t7xx_devlink_param_get_fastboot(t7xx_dev->dl->ctx)) {
>+		/* Do not try fldr because device will always wait for
>+		 * MHCCIF bit 13 in fastboot download flow.
>+		 */
>+		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
>+	} else {
> 		err = t7xx_acpi_fldr_func(t7xx_dev);
> 		if (err)
> 			t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
>-- 
>2.34.1
>
>

