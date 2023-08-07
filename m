Return-Path: <netdev+bounces-24953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57857724CF
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18D51C20B5B
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82984101D4;
	Mon,  7 Aug 2023 12:58:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754F9DDB8
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:58:39 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A101BC
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 05:58:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe5c0e5747so5552885e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691413113; x=1692017913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvacMVpAsU0PJ38BwBv52IDwW/AO4HfrNL9EzEYyK4A=;
        b=vwk5lrDpHxcBerPC5N4M/ELdQ2tEBOVsoi2J0eCPJr9kZplRFm4O0A6S1jcphYWJYm
         bLeIC+h93FMyBy1dSsSBwux0iSbkXFk6bJ4lugPafYM9ErAldmHk7r+LZGJh/Om+rAPW
         3/pTFzg43TStFj1sZ1YEOlUmpJIlCNTLM9fMCxV3npuEQjfKAX/3UhOiYFpaH6/Zjbxq
         NrituDwLbxgKVmff5IX+6RBEjENN6nuTcIAdGO4CGwiGRSmWFmTCHp3J8gB1Qj7R8JCD
         fXkds9DCX9EseT4JdC0gFUnTZdOaWArCsCKIB5bCCi7aEodjyUsHbv0aqYz1WkNWuWUO
         Im4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413113; x=1692017913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvacMVpAsU0PJ38BwBv52IDwW/AO4HfrNL9EzEYyK4A=;
        b=KoGVPD7sUfe2wePftsXbsDomC8Fv81jiR4liw2dpKS3p7+QdGgQQD8CPj8KUPQLT8Q
         EEYNhi4UsmO84KsyA4MtI1W2zNXVFyWak3aoGOUvEqHtOtEypzpjMPltwmSG5jry/JNd
         hP5DEBG3cFSRcQPoUNaAFvLL8Stb9+OEZpquUeG5F15KcmOVNy+36T1J+uUZpyGviRLH
         X0M7xDbn8ejWdA2wUXFx/y4sUqRj2LVvDlRyaSOBA0hlZs+n3ct6G7P97WxO65npHHT1
         24zgSluXOuqY/GYIDlxCcrqFA0TVHU3iH2zH/4lPcDPNOCBs4VDO5rMBpXbSADHIvPiB
         Ugaw==
X-Gm-Message-State: AOJu0YxtyYlnDMEOxowAz282eLOPHCk1kmdnxKF3vOD2263PaI38r7Kq
	IaiZXKESJS1Lz6HbTKnh7VIyWQ==
X-Google-Smtp-Source: AGHT+IFW1vQksXlahNSa4nnlcdnGOsIRUlhZxipyWvj+litSr2gHu6keq8IYKhhOeMVdDKciFxLEXw==
X-Received: by 2002:a05:600c:210e:b0:3fe:215e:44a0 with SMTP id u14-20020a05600c210e00b003fe215e44a0mr5335248wml.18.1691413113247;
        Mon, 07 Aug 2023 05:58:33 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcd11000000b003fc00212c1esm10593722wmj.28.2023.08.07.05.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:58:32 -0700 (PDT)
Date: Mon, 7 Aug 2023 14:58:31 +0200
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
Subject: Re: [net-next 2/6] net: wwan: t7xx: Driver registers with Devlink
 framework
Message-ID: <ZNDqd3oee/nLuSO+@nanopsycho>
References: <20230803021812.6126-1-songjinjian@hotmail.com>
 <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
 <MEYP282MB26973DD342BDD69914C06FCFBB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
 <ME3P282MB270324EC4CEEB864D04ECDB2BB0CA@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME3P282MB270324EC4CEEB864D04ECDB2BB0CA@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Aug 07, 2023 at 02:44:00PM CEST, songjinjian@hotmail.com wrote:
>Sat, Aug 05, 2023 at 02:12:13PM CEST, songjinjian@hotmail.com wrote:
>>>Thu, Aug 03, 2023 at 04:18:08AM CEST, songjinjian@hotmail.com wrote:
>>>
>>>[...]
>>>
>>>>>+static const struct devlink_param t7xx_devlink_params[] = {
>>>>>+	DEVLINK_PARAM_DRIVER(T7XX_DEVLINK_PARAM_ID_FASTBOOT,
>>>>>+			     "fastboot", DEVLINK_PARAM_TYPE_BOOL,
>>>>>+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>>>>>+			     NULL, NULL, NULL),
>>>>
>>>>driver init params is there so the user could configure driver instance
>>>>and then hit devlink reload in order to reinitialize with the new param
>>>>values. In your case, it is a device command. Does not make any sense to
>>>>have it as param.
>>>>
>>>>NAK
>>>
>>>Thanks for your review, so drop this param and set this param insider driver when driver_reinit,
>>>is that fine?
>>
>>I don't understand the question, sorry.
>
>Thanks for your review, I mean if I don't define fastboot param like devlink_param above, I will

Could you not thank me in every reply, please?


>define a global bool variable in driver, then when devlink ... driver_reinit, set this variable to true.

That would be very wrong. Driver reinit should just reload the driver,
recreate the entities created. should not be trigger to change
behaviour.


>
>like:
>   t7xx_devlink { 
>       ....
>       bool reset_to_fastboot;
>   }
>
>
>   t7xx_devlink_reload_down () {
>       ...
>       case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
>           t7xx_devlink.reset_to_fastboot = true;
>       ...
>   }
>
>   other functions use this variable:
>
>   if (t7xx_devlink.reset_to_fastboot) {
>        iowrite(reg, "reset to fastboot");
>   }
>
>Intel colleague has change to the way of devlink_param, so I hope to keep this.
>
>>

