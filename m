Return-Path: <netdev+bounces-40398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD867C7384
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1D728290A
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D3E2AB57;
	Thu, 12 Oct 2023 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYDux2c1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA002AB53
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 16:54:52 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5971C6
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 09:54:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so488549a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697129689; x=1697734489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bBUBWcfqd6h2FYCx6HxLCGICG3O8Ap6wf3BtHDsyNkw=;
        b=XYDux2c1jm61KTl0piNXwt+k6rvxPnpV3yItyhaASGTP2US5lB3J520yPNlXP1bEN7
         P/VPJ802FDEHGUtTsu6BO3QVLzh0sGIB1HsEepeVVBX5AZLH4Pgz0dJuiQXVOdQaMzlZ
         vwKnBK5hlpq5+MreMPp5VzAfpHnQr+UWQbtrxDP+AlOyW6KUvUi8GVc+i+rBdVzuG+Og
         ywQsuVByCGWvanFIkNQLS7rxlmF9J31tusfPQy7cw6gcPquZeg5jSBLq9hbjnNVQF7zv
         K20+TeD3pllofe4IXandv7/f9Q5LOsUZeggzhHVdPunJqjcjGb1VZK+HSSWx3V10+h7F
         1iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129689; x=1697734489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBUBWcfqd6h2FYCx6HxLCGICG3O8Ap6wf3BtHDsyNkw=;
        b=S7VKtWf/8zPlDrz+v1wcLaTmq9thI9S9M04ip9QaJD9WMC15g7glc1umWbuhyhgLk4
         Rj73C1neB7XUWsN3c+J9IEv9TjV4FktIwr2hwcW6MMgMOgkyUkvGsLjTwZulUCmJP8Bf
         xYhnPPZjyVslik16AppwvdjqiC0mwJ/SSTX4OuEZ/1n+hRau85NuTWXIV5Jk72Jelbw9
         8Lbac6V92cbJa0tDEDqOSZagoJ4F1nc4zxog1URwsRYF35rFrDcU1jbV2EJ+V9jycvTN
         EaFzaXzXWJAQ0GYHH6f/AsGc+njcBebFDUbSgg/6+Uq48/Dr2prR+dOkFy5EegXbEByG
         5UoQ==
X-Gm-Message-State: AOJu0YwNClwTuiAXUaigHLVMp7Hpp7VyfL8V5GDnExYDgsUFxP+Wp45N
	X5e8QN69zdcHqVNifVbdnNzApg3mCUAr6HRP3ArjOw==
X-Google-Smtp-Source: AGHT+IERlaWWwiML/RFT3cp2GcW0IWarhx9gkibx1TlIHF9bhAGNQd9/QPTUhc2WeHSsLpPbF34UNy9rAMlj9u2bDOA=
X-Received: by 2002:aa7:d88e:0:b0:532:e24d:34f4 with SMTP id
 u14-20020aa7d88e000000b00532e24d34f4mr21115676edq.39.1697129689228; Thu, 12
 Oct 2023 09:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com>
In-Reply-To: <267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 12 Oct 2023 18:54:11 +0200
Message-ID: <CAMZdPi9RDSAsA8bCwN1f-4v3Ahqh8+eFLTArdyE5qZeocAMhtQ@mail.gmail.com>
Subject: Re: Intel 7560 LTE Modem stops working after resuming from standby
To: Bagas Sanjaya <bagasdotme@gmail.com>, M Chetan Kumar <m.chetan.kumar@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, Linux Networking <netdev@vger.kernel.org>, 
	Linux Intel Wireless WAN <linuxwwan@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Chetan,

On Thu, 12 Oct 2023 at 11:52, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> I notice a regression report on Bugzilla [1]. Quoting from it:
>
> > I noticed a few days ago, after Fedora moved to Kernel 6.5, that my Intel LTE Modem was not working anymore after resuming from standby.
> >
> > The journal listed this error message multiple times:
> > kernel: iosm 0000:01:00.0: msg timeout
> >
> > It took me a while to determine the root cause of the problem, since the modem did not work either in the following warm reboots.
> > Only a shutdown revived the modem.
> >
> > I did a bisection of the error and I was able to find the culprit:
> >
> > [e4f5073d53be6cec0c654fac98372047efb66947] net: wwan: iosm: enable runtime pm support for 7560

Any quick fix for this issue? alternatively we will probably revert e4f5073d53.

Regards,
Loic

