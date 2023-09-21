Return-Path: <netdev+bounces-35558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C337E7A9CDA
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA3C285547
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8A4691E7;
	Thu, 21 Sep 2023 18:35:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46268C26
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:35:05 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462BACFF2F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:20:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405361bb93bso8333035e9.3
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695320433; x=1695925233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Drrb5cgIdX9bQlcJOAIQy6p22Hd1U/QgsuYhc+HIXtc=;
        b=Kog+eSd/G+OKGBIna647e1Ji2iWLColpgLdyRmRDriv/fj6rKzO+ySjWta9E691KkV
         MbBqH09NXbjpprj4ZpVNNZgh01esP/80SWbUFTEuYS55JY4URFpTg4TEZp51m04XdAop
         FDOr2yVWXJ59otp+eh1vOBT6s2JaKfMg1aZXnHf2mpYXWXhlUMNMCj3Wc8lZJe7U95zW
         sDvJ0D20jnrb16gwrxTsvVXhNZ3kHsYNJOYuJB/QbGWpYKR9rlkROhRZhiJHz+l2zX2R
         2UwQA/K8sBDWhZivIL5XQ1QJwsrFk0L6R1l05Rppg2giYHHDzmTQ5tE1Jt4Tytb79p8f
         mlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320433; x=1695925233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Drrb5cgIdX9bQlcJOAIQy6p22Hd1U/QgsuYhc+HIXtc=;
        b=lbqVEMfdHWcZkFd1hTD2tjDlC9bP4bSY1RJIkht2qYStpFEsgvKkYGlUCSQx42YoSY
         y4FmpYuFfIDO8rIY0c205+SOX7cd/lOK/ZBfW2GhR2sGwJore6VApdo3HUqZYaR98WG5
         B9sQm4yf66QMRqroXc30DK4VTjWJ7BIiqPzSTeeNSaPCvk+VkuATOoYgAqzyZCfOkQlB
         7fHK1FqLSE1WFcCK8GxB8xYrN4na90Viz7in66WdqpRWRT75pzPbePWUYnr0YePpNvaz
         AHd3ht47jTURtDnC49lvJ5q2OmnUk4gIUZ5DkYJWW6p611ngyiQTSZC4X4361u6w+FpZ
         MjRQ==
X-Gm-Message-State: AOJu0YxpZVOtAT5mcxo4Lrk8VAWRIm1bKh7sI97qmklSOfJwtiUBkQyE
	RUOt4yjo3kLdHVPtdCgUGYhkjofWUmvk952lAXd1ionljUijiitJ1TPXWg==
X-Google-Smtp-Source: AGHT+IHtAdCqWfyKxt1ELmKKg//qfdzKK9qhy8uM34Bqm0u8o8sOZrkwXfRLF0pU4lRrTWBBCH79wK6kC1VudFfOvFA=
X-Received: by 2002:a05:6402:3228:b0:533:f22:17b9 with SMTP id
 g40-20020a056402322800b005330f2217b9mr3895347eda.19.1695289023375; Thu, 21
 Sep 2023 02:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ME3P282MB270323F98B97A1A98A50F8F7BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
 <ZQF+PHTYDZRX1gql@nanopsycho>
In-Reply-To: <ZQF+PHTYDZRX1gql@nanopsycho>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 21 Sep 2023 11:36:26 +0200
Message-ID: <CAMZdPi-qZ3JjZmEAtEmJETNzKd+k6UcLnLkM0MZoSZ1hKaOXuA@mail.gmail.com>
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jinjian Song <songjinjian@hotmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, ryazanov.s.a@gmail.com, 
	johannes@sipsolutions.net, chandrashekar.devegowda@intel.com, 
	linuxwwan@intel.com, chiranjeevi.rapolu@linux.intel.com, 
	haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com, 
	ricardo.martinez@linux.intel.com, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nmarupaka@google.com, 
	vsankar@lenovo.com, danielwinkler@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 13 Sept 2023 at 11:17, Jiri Pirko <jiri@resnulli.us> wrote:
>
> Tue, Sep 12, 2023 at 11:48:40AM CEST, songjinjian@hotmail.com wrote:
> >Adds support for t7xx wwan device firmware flashing & coredump collection
> >using devlink.
>
> I don't believe that use of devlink is correct here. It seems like a
> misfit. IIUC, what you need is to communicate with the modem. Basically
> a communication channel to modem. The other wwan drivers implement these
> channels in _ctrl.c files, using multiple protocols. Why can't you do
> something similar and let devlink out of this please?
>
> Until you put in arguments why you really need devlink and why is it a
> good fit, I'm against this. Please don't send any other versions of this
> patchset that use devlink.

The t7xx driver already has regular wwan data and control interfaces
registered with the wwan framework, making it functional. Here the
exposed low level resources are not really wwan/class specific as it
is for firmware upgrade and coredump, so I think that is why Jinjian
chose the 'feature agnostic' devlink framework. IMHO I think it makes
sense to rely on such a framework, or maybe on the devcoredump class.

That said, I see the protocol for flashing and doing the coreboot is
fastboot, which is already supported on the user side with the
fastboot tool, so I'm not sure abstracting it here makes sense. If the
protocol is really fasboot compliant, Wouldn't it be simpler to
directly expose it as a new device/channel? and rely on a userspace
tool for regular fastboot operations (flash, boot, dump). This may
require slightly modifying the fastboot tool to detect and support
that new transport (in addition to the existing usb and ethernet
support).

Regards,
Loic

