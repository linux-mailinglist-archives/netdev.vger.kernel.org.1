Return-Path: <netdev+bounces-24954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D20607724D7
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9F92811A1
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA0F101F9;
	Mon,  7 Aug 2023 13:01:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D38DDC3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:01:58 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67771BC
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 06:01:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso26618925e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691413316; x=1692018116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=StiE7xk9Iyvw67BC1BxxLT5EK0XLr9AZHA2c89vumaY=;
        b=fHukGWSYB77UHnRjJBnqfAEsXbgPdXQfH1mOjlSdbxrXnbstOSjzIoMbkizN1TiQYJ
         NlLHKVxV5eUvZj+f0BHy7AYqJMq+W2/M7N74Lyn+N9ZGxlUGkTrjWrIAZ44Nsym5Vi79
         wv61weOrL3tvGO4nxbIdIGqmkcZuLT8ALkKjE2ZZNqEy+XvV9ZzTeGkHocVyQFZucMAa
         Ha4DM/Ri+SB9hnI4Hk7yAK163R4y8uR+DZ2oSaA3QYk4VZhhqFMqLEStWniDW+MVXyTk
         B7m9VPMEgm2oNb0+Ds8y84yZMheTuqbLs+pFCsw7fGFgbRVSeOrFq4xos+z3yiVk414G
         9sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413316; x=1692018116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StiE7xk9Iyvw67BC1BxxLT5EK0XLr9AZHA2c89vumaY=;
        b=GOWV9iRVViKuSmRkE1Tkqd9JX4urpxXY4SYm7y0VrAUooM11B86XyXbytR8QFwK//a
         iYsV84I1ONVDvknLpzlVX6uJN315nxuC7r4Pm271rlY2oXIHeExPX+fli+I7VKhXawBy
         YBXpQ7ihLAvZKOYUxBH0/7tY9tAf6p1C3oloLCd0jeOLO/U43spgaZ7sAZzwp3xx8BDz
         Y3uX44jgrEmOIT3K7B1284mJ25yQFadlzTomAxmvedk92clxk17uV9uCKL93oKGfr7Vx
         +qZ/X2I0/CkZyPuqCk5Oue0AVldOPFk2cZsNkTDWmQV/LRmW1aEcIGu+yX7XTGurWJYn
         fB3g==
X-Gm-Message-State: AOJu0YyQs6JrnxIoyRHcnWr49TseBgXEcnavsdA9y2zzo7k0yY9+ynHI
	ZGK04PXciHoU8O9xdFaT85IxiQ==
X-Google-Smtp-Source: AGHT+IGnDgvf0hNkxvxEiZiMvxaYW1PrxL0CnsF3ak59N4Bn5JhP5Tn0VZ5OkarpeoPSEtbmzEHzDw==
X-Received: by 2002:a7b:c8c2:0:b0:3fe:4cbc:c34c with SMTP id f2-20020a7bc8c2000000b003fe4cbcc34cmr6075711wml.24.1691413316068;
        Mon, 07 Aug 2023 06:01:56 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id u5-20020a7bc045000000b003fe1cdbc33dsm15026141wmc.9.2023.08.07.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:01:55 -0700 (PDT)
Date: Mon, 7 Aug 2023 15:01:54 +0200
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
Message-ID: <ZNDrQpikNYBTgb60@nanopsycho>
References: <20230803021812.6126-1-songjinjian@hotmail.com>
 <MEYP282MB2697937841838C688E1237FDBB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
 <MEYP282MB269742CBB438E43607FA3BC4BB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
 <MEYP282MB2697E81E8FEC49757A385A5FBB0CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB2697E81E8FEC49757A385A5FBB0CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Aug 07, 2023 at 02:26:53PM CEST, songjinjian@hotmail.com wrote:
>Thansk for your review.
>Witch command: echo 1 > /sys/bus/pci/devices/${bdf}/remove, then driver will run the
>.remove ops, during this steps, driver get the fastboot param then send command to 
>device let device reset to fastboot download mode.

Ugh.


>
>>
>>
>>>4.use space command rescan device, driver probe and export flash port.
>>
>>Again, what's "command rescan device" ?
>>
>>Could you perhaps rather use command line examples?
>
>Thansk for your review.
>With the command: echo 1 > /sys/bus/pci/rescan, then driver will run the .probe options
>then driver will follow the fastboot download process to export the download ports.

That is certainly incorrect. No configuration or operation with the
device instance should require to unbind&bind the device on the bus.


>
>>
>>>5.devlink flash firmware image.
>>>
>>>if don't suggest use devlink param fastboot driver_reinit, I think set 
>>>fastboot flag during this action, but Intel colleague Kumar have drop that way in the old 
>>>v2 patch version.
>>>https://patchwork.kernel.org/project/netdevbpf/patch/20230105154300.198873-1-m.chetan.kumar@linux.intel.com/ 
>>>
>>>>+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>>>>+		return 0;
>>>>+	default:
>>>>+		/* Unsupported action should not get to this function */
>>>>+		return -EOPNOTSUPP;
>>>>+	}
>>>>+}
>>
>>>>>+static int t7xx_devlink_info_get_loopback(struct devlink *devlink, struct devlink_info_req *req,
>>>>>+					  struct netlink_ext_ack *extack)
>>>>>+{
>>>>>+	struct devlink_flash_component_lookup_ctx *lookup_ctx = req->version_cb_priv;
>>>>>+	int ret;
>>>>>+
>>>>>+	if (!req)
>>>>>+		return t7xx_devlink_info_get(devlink, req, extack);
>>>>>+
>>>>>+	ret = devlink_info_version_running_put_ext(req, lookup_ctx->lookup_name,
>>>>
>>>>It actually took me a while why you are doing this. You try to overcome
>>>>the limitation for drivers to expose version for all components that are
>>>>valid for flashing. That is not nice
>>>>
>>>>Please don't do things like this!
>>>>
>>>>Expose the versions for all valid components, or don't flash them.
>>>
>>>For the old modem firmware, it don't support the info_get function, so add the logic here to 
>>>compatible with old modem firmware update during devlink flash.
>>
>>No! Don't do this. I don't care about your firmware. We enforce info_get
>>and flash component parity, obey it. Either provide the version info for
>>all components you want to flash with proper versions, or don't
>>implement the flash.
>
>Thanks for your review, I will delete the info_get_loopback function.
>
>>
>>
>>>
>>>>>+						   "1.0", DEVLINK_INFO_VERSION_TYPE_COMPONENT);
>>>>>+
>>>>>+	return ret;
>>>>> }
>>>>> 
>

