Return-Path: <netdev+bounces-24797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD9D771B8F
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 09:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907B41C20950
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 07:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6505248;
	Mon,  7 Aug 2023 07:35:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F45523A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 07:35:35 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22610A2
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 00:35:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-31759e6a4a1so3048253f8f.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 00:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691393732; x=1691998532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VU+AQnLyFrpDVg6niJml7kEcIBVVBF6NVrFwGBnRxJk=;
        b=KRfEK8b+4GIhTs0PXIDC/S3rKOJFw1QPxjH/rXAYcWX1qqPoumVCl1xtjqwdAbQVGW
         7RiCuOjIkKauo3BjUPLkJwteGuufE3K0ON2sazkdXCQt0vBqbmJCJbj8fgTdCowW2Fsx
         Lh7GeUIGJGy99MrGaBomuWHR22ModkUo4tS/S3V/sBlFbBcRk4tUqKM3LE9+eZW6JpxR
         okFmcunBg6/b/m46QWJoefjK/1YNrTNWhW+j9+Qx98XF8MxHLDSiflcOY7X3XozEn7fk
         kKqmkG/3iOaYjpUKrji/dv5GrlHUxGLO5nZNy0EbfhmnjbA3jQDpEGa9MTd52sotgyT+
         f2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691393732; x=1691998532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU+AQnLyFrpDVg6niJml7kEcIBVVBF6NVrFwGBnRxJk=;
        b=Zz/xfCXw+XyhQ7krUbKgrxadxS70lI4/Ka6J/RDUSaV88Lmj6B31yJSzUZYYnTte3j
         vbbA8PWCAe6kcJFeuFC2Zt5ohiK+kq2AiwAbdYM8xi+b9R5ynYCYzuWQ7yQisIgsHkHv
         D1k/6ZiiZ6//Srv3TcuwbUaO1R/e7rdbZt0383YW4q6S1ZIGidcuFRyIZzYWIaLSG9CL
         XJagUytgxEVQhsrumnMpMKwqZ4l6EVuT/QE6mM1n1QJcB6YVKqt04RtD1xb1LUuTxSvR
         8m/OD8v6QFxAJrxUPLqe1OHmfKHlHGtXC8ioyiCiAGBGS/icCUowjUaBBOwnt1Z2ESrw
         C5gA==
X-Gm-Message-State: AOJu0YwdrMF62aRLlgd/hUTxjssf3pAKCWVPbiAnFZImIAfG75oSFZbQ
	LyPSyqHCNSk6TPs1arYbLudOwA==
X-Google-Smtp-Source: AGHT+IGA0A2doioIVpDowWt2YDc0IVmGq7bP+nE/XKOTQ4nw+Kyr+ozwIzO/aY11myuSwcUulv2sOQ==
X-Received: by 2002:adf:e5d0:0:b0:314:10d8:b482 with SMTP id a16-20020adfe5d0000000b0031410d8b482mr4631935wrn.65.1691393732628;
        Mon, 07 Aug 2023 00:35:32 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id t6-20020a5d6a46000000b003142e438e8csm9596253wrw.26.2023.08.07.00.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 00:35:31 -0700 (PDT)
Date: Mon, 7 Aug 2023 09:35:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com, davem@davemloft.net, edumazet@google.com,
	haijun.liu@mediatek.com, ilpo.jarvinen@linux.intel.com,
	jesse.brandeburg@intel.com, jinjian.song@fibocom.com,
	johannes@sipsolutions.net, kuba@kernel.org, linuxwwan@intel.com,
	linuxwwan_5g@intel.com, loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com, netdev@vger.kernel.org,
	pabeni@redhat.com, ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com, soumya.prakash.mishra@intel.com
Subject: Re: [net-next 3/6] net: wwan: t7xx: Implements devlink ops of
 firmware flashing
Message-ID: <ZNCew+BPDITsZdY1@nanopsycho>
References: <20230803021812.6126-1-songjinjian@hotmail.com>
 <MEYP282MB2697937841838C688E1237FDBB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
 <MEYP282MB269742CBB438E43607FA3BC4BB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB269742CBB438E43607FA3BC4BB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sat, Aug 05, 2023 at 02:05:35PM CEST, songjinjian@hotmail.com wrote:
>Thu, Aug 03, 2023 at 04:18:09AM CEST, songjinjian@hotmail.com wrote:
>>>From: Jinjian Song <jinjian.song@fibocom.com>
>>>
>>>Adds support for t7xx wwan device firmware flashing using devlink.
>>>
>>>On user space application issuing command for firmware update the driver
>>>sends fastboot flash command & firmware to program NAND.
>>>
>>>In flashing procedure the fastboot command & response are exchanged between
>>>driver and device.
>>>
>>>Below is the devlink command usage for firmware flashing
>>>
>>>$devlink dev flash pci/$BDF file ABC.img component ABC
>>>
>>>Note: ABC.img is the firmware to be programmed to "ABC" partition.
>>>
>>>Base on the v5 patch version of follow series:
>>>'net: wwan: t7xx: fw flashing & coredump support'
>>>(https://patchwork.kernel.org/project/netdevbpf/patch/fc8bbb0b66a5ff3a489ea9857d79b374508090ef.1674307425.git.m.chetan.kumar@linux.intel.com/)
>>>
>>>Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>>
>>Overall, this patch/patchset is very ugly and does some wrong or
>>questionable things that make my head hurt. Ugh.
>
>Thanks for your review, this is my first time to do this and when I git send-email,
>my email account locked so the patchset break at 3/6 and I resend the remaining 3 patches again.
>
>I will reorganize and prepare v2 version, sorry for that.
>
>>> #include "t7xx_port_devlink.h"
>>> 
>>>+static int t7xx_devlink_port_read(struct t7xx_port *port, char *buf, size_t count)
>>
>>You have "devlink" in lot of the function and struct field names. Does
>>not make sense to me as for example this function does not have anything
>>to do with devlink. Could you please rename them all?
>
>Thanks for your review, I think I can rename them all to flash_dump port read, this functions used
>to send or recieve data(firmware/coredump/command) with modem
>
>>>+	set_bit(T7XX_FLASH_STATUS, &dl->status);
>>>+	port = dl->port;
>>>+	dev_dbg(port->dev, "flash partition name:%s binary size:%zu\n", component, fw->size);
>>>+	ret = t7xx_devlink_fb_flash_partition(port, component, fw->data, fw->size);
>>>+
>>>+	sprintf(flash_status, "%s %s", "flashing", !ret ? "success" : "failure");
>>
>>Don't put return status in to the flash_status. Function returns error
>>value which is propagated to the user.
>>
>>In fact, in your case, usage of devlink_flash_update_status_notify()
>>does not make much sense as you don't have multiple flash stages.
>
>Thanks for your review, yes 'success' and 'failure', Function can returns error I will remove 
>status notify and flash_status
> 
>>>+	devlink_flash_update_status_notify(devlink, flash_status, params->component, 0, 0);
>>>+	clear_bit(T7XX_FLASH_STATUS, &dl->status);
>>>+
>>>+err_out:
>>>+	return ret;
>>> 	return 0;
>>> }
>
>>> static int t7xx_devlink_reload_up(struct devlink *devlink,
>>>@@ -50,13 +266,114 @@ static int t7xx_devlink_reload_up(struct devlink *devlink,
>>> 				  u32 *actions_performed,
>>> 				  struct netlink_ext_ack *extack)
>>> {
>>>-	return 0;
>>>+	*actions_performed = BIT(action);
>>>+	switch (action) {
>>>+	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
>>
>>Your driver reinit does not do anything. Please remove it from supported
>>actions.
>
>I want to register reinit action and fastboot param with it, so it work like follow:
>1.devlink param set fastboot 1 driver_reinit
>2.devlink driver_reinit
>3.use space command remove driver, then driver remove function get the fastboot param 
>true, then send message to modem to let modem reboot to fastboot download mode.

What do you mean by this? I don't follow. What's "command remove
driver"?


>4.use space command rescan device, driver probe and export flash port.

Again, what's "command rescan device" ?

Could you perhaps rather use command line examples?


>5.devlink flash firmware image.
>
>if don't suggest use devlink param fastboot driver_reinit, I think set 
>fastboot flag during this action, but Intel colleague Kumar have drop that way in the old 
>v2 patch version.
>https://patchwork.kernel.org/project/netdevbpf/patch/20230105154300.198873-1-m.chetan.kumar@linux.intel.com/ 
>
>>>+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>>>+		return 0;
>>>+	default:
>>>+		/* Unsupported action should not get to this function */
>>>+		return -EOPNOTSUPP;
>>>+	}
>>>+}
>
>>>+struct devlink_info_req {
>>>+	struct sk_buff *msg;
>>>+	void (*version_cb)(const char *version_name,
>>>+			   enum devlink_info_version_type version_type,
>>>+			   void *version_cb_priv);
>>>+	void *version_cb_priv;
>>>+};
>>
>>Ah! No. Remove this. If you need to touch internal of the struct, this
>>is definitelly not the way to do it.
>
>Thanks for your review, got it.
>
>>>+
>>>+struct devlink_flash_component_lookup_ctx {
>>>+	const char *lookup_name;
>>>+	bool lookup_name_found;
>>>+};
>>
>>Same here.
>
>Thanks for your review, got it.
>
>>>+
>>>+static int t7xx_devlink_info_get_loopback(struct devlink *devlink, struct devlink_info_req *req,
>>>+					  struct netlink_ext_ack *extack)
>>>+{
>>>+	struct devlink_flash_component_lookup_ctx *lookup_ctx = req->version_cb_priv;
>>>+	int ret;
>>>+
>>>+	if (!req)
>>>+		return t7xx_devlink_info_get(devlink, req, extack);
>>>+
>>>+	ret = devlink_info_version_running_put_ext(req, lookup_ctx->lookup_name,
>>
>>It actually took me a while why you are doing this. You try to overcome
>>the limitation for drivers to expose version for all components that are
>>valid for flashing. That is not nice
>>
>>Please don't do things like this!
>>
>>Expose the versions for all valid components, or don't flash them.
>
>For the old modem firmware, it don't support the info_get function, so add the logic here to 
>compatible with old modem firmware update during devlink flash.

No! Don't do this. I don't care about your firmware. We enforce info_get
and flash component parity, obey it. Either provide the version info for
all components you want to flash with proper versions, or don't
implement the flash.


>
>>>+						   "1.0", DEVLINK_INFO_VERSION_TYPE_COMPONENT);
>>>+
>>>+	return ret;
>>> }
>>> 

