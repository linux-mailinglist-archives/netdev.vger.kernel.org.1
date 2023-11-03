Return-Path: <netdev+bounces-45884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272A17E019B
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 11:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84E0281E51
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C272D62A;
	Fri,  3 Nov 2023 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="edFM2OZ3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F4185F
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 10:40:08 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51112D4F
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 03:40:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40859c46447so12291955e9.1
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699008004; x=1699612804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy+FX8zGhNkWXszFiiW9K509Gia4V97/gsM6LXZa8JM=;
        b=edFM2OZ3tAJzFgKae8lvg7aWbFPJuuDUoSEnDY0EjwuhB1muh5sSTAoZlZdUa+065o
         xS3NH26jZXyHyhUuYlA69BqLtK1a1/RcrRuWBb7BfoYAkOR6VgVwFb9QwYTv26huASZG
         ywsmMnwKCWtPTo8gHySTSYSg/ylKkLlBz5W2Oh46vcRZVaZwXhJaFcZ3H2SDgYOrh/rX
         cfN5xwxwy5Tm1kcqGiGcV8VvM+SClzctsG8kcsKOUDZIHNu7ICAJKYWZ5Ek5sFNyNz9+
         84L09sPhPDF87aFLWiJ2P0mET2ddJEQqUhLi53P711OI2Y1AIZVAGmC7Q0AuZZTm1E9x
         gJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699008004; x=1699612804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vy+FX8zGhNkWXszFiiW9K509Gia4V97/gsM6LXZa8JM=;
        b=gx/Q4qVYeRiV58mobf/5y6EPA+N7mpLLO7UhJidEH4y2qufMJPtMFiO/Y9W07sWKq1
         hAhjf8Wqt4aC4R/84D52AeFOuUTvK9vF0MbfvYTMQga9smIb1/UpayMpqNcDJKFzKNSS
         hgHC63sRIbunvK0+Wjfr2/bVLoS4dAJqBc6XaC/JRP6c5tiLw577jF2W3iUEmFjrGQmU
         s6e6GpH0OraUSydncEuA5MztOrKVnyOK7GSuSeyi94i9iW9EHK5e6SZ8zF+d2844ngpU
         iknG5DNgZ1KirfM6LHK1zJL2exAp61d3g2G2KaBFHKcH5dh3FAgCKa8s2lCnfoXCsHHt
         3vWQ==
X-Gm-Message-State: AOJu0YypbZj1jPe70JauJvd6IIdaNdWZ71uH2rfS+1R6HSfS1pEwhHvr
	G/3Iey7p81z/pp1IlvtnS7YY1w==
X-Google-Smtp-Source: AGHT+IEgzh0g0qg04M6eJLpsBi4oCP5l5Qi0W2jfjVOStWT5hplVwwv9A9Wz77tyfwsKH/NEVbfitQ==
X-Received: by 2002:a05:600c:1d95:b0:409:375:5a44 with SMTP id p21-20020a05600c1d9500b0040903755a44mr17399496wms.24.1699008003596;
        Fri, 03 Nov 2023 03:40:03 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id az25-20020a05600c601900b004095874f6d3sm2090103wmb.28.2023.11.03.03.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 03:40:02 -0700 (PDT)
Date: Fri, 3 Nov 2023 11:40:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: Jinjian Song <songjinjian@hotmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
	chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nmarupaka@google.com,
	vsankar@lenovo.com, danielwinkler@google.com
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Message-ID: <ZUTOAd0bGVHsTKDv@nanopsycho>
References: <ME3P282MB270323F98B97A1A98A50F8F7BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
 <ZQF+PHTYDZRX1gql@nanopsycho>
 <CAMZdPi-qZ3JjZmEAtEmJETNzKd+k6UcLnLkM0MZoSZ1hKaOXuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZdPi-qZ3JjZmEAtEmJETNzKd+k6UcLnLkM0MZoSZ1hKaOXuA@mail.gmail.com>

Thu, Sep 21, 2023 at 11:36:26AM CEST, loic.poulain@linaro.org wrote:
>On Wed, 13 Sept 2023 at 11:17, Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Sep 12, 2023 at 11:48:40AM CEST, songjinjian@hotmail.com wrote:
>> >Adds support for t7xx wwan device firmware flashing & coredump collection
>> >using devlink.
>>
>> I don't believe that use of devlink is correct here. It seems like a
>> misfit. IIUC, what you need is to communicate with the modem. Basically
>> a communication channel to modem. The other wwan drivers implement these
>> channels in _ctrl.c files, using multiple protocols. Why can't you do
>> something similar and let devlink out of this please?
>>
>> Until you put in arguments why you really need devlink and why is it a
>> good fit, I'm against this. Please don't send any other versions of this
>> patchset that use devlink.
>
>The t7xx driver already has regular wwan data and control interfaces
>registered with the wwan framework, making it functional. Here the
>exposed low level resources are not really wwan/class specific as it
>is for firmware upgrade and coredump, so I think that is why Jinjian
>chose the 'feature agnostic' devlink framework. IMHO I think it makes
>sense to rely on such a framework, or maybe on the devcoredump class.
>
>That said, I see the protocol for flashing and doing the coreboot is
>fastboot, which is already supported on the user side with the
>fastboot tool, so I'm not sure abstracting it here makes sense. If the
>protocol is really fasboot compliant, Wouldn't it be simpler to
>directly expose it as a new device/channel? and rely on a userspace
>tool for regular fastboot operations (flash, boot, dump). This may
>require slightly modifying the fastboot tool to detect and support
>that new transport (in addition to the existing usb and ethernet
>support).

Sounds sane. Please let devlink out of this.

>
>Regards,
>Loic

