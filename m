Return-Path: <netdev+bounces-48786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D31C57EF8D7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 21:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B695B20A04
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 20:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1F93BB56;
	Fri, 17 Nov 2023 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="N9oRVzZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2993D4B
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 12:47:12 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a84204e7aeso26995387b3.0
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 12:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700254032; x=1700858832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpojI4YGTKO3dE16H2GU+1IUhhYRo8LLeleDocOeMYY=;
        b=N9oRVzZxoshE/BNtDx7M6RFZEYgM2elSUy+5s8He5GsAB0EsNgK+bkNIsahEFIW6yc
         Q6tg6JSDHY3+Bk2dUcwTv79Vm6vtneesnkYo1pVX1H+C9ji2D4gr0DA/deFWTD/jRh3q
         Tfi42PWvQ/jWd5au+vlPTpRBHq9XGtIhC3pkRsjM4kIOKwmAv+39LcGU9iJikYG1fhzA
         9J7/jdgdNlF0HgoXIrvjGfiPv2vkR30BeThEfs+3yBIG7sLnokQSyqtW2bw2ao1m7/CA
         ITUMkSNa1VC8SFh4Tk1RqSkSlGLCCmp+yX3EZToHCdVH+txDkA+LMHTK9WYiiPPMcmel
         6akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700254032; x=1700858832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpojI4YGTKO3dE16H2GU+1IUhhYRo8LLeleDocOeMYY=;
        b=lFzjFFFpLE6Vu10qZzyx5GQeciDsACmWaeGFYwropZiSTrGUqGANCWmMeuN7/dVB7S
         D9Zq0J8V0b1fSf2PsG7fGs8VCh92ID6tC7yVR4K1gh5kg7itEl4Yf2b7dKf+dNpOXRwM
         9V8ZsXSSIJi+bAM5WcEK6vg20YsOSeiJ82iFDOXmNGW+XH84PKH2ZW67w+ai+i9B4vkS
         kf5uRRTbDfcHsofz8rtnPvI97fAmceC02lMo1mk9lt2ETFXaQ7qQuIMeC3MoKZr73XoS
         tlK/JDqO+jdcCHzAU/YoGXYeXZPFXswsTZec0xd2O4NR7KGbC2L6PCcJP+opzhppt7he
         /bwQ==
X-Gm-Message-State: AOJu0YwFnbkrj+g/1aUqZcR7kEb210BvXct6Bofrk1SqLVpH6epERthV
	IfHqfg/8NL+C9KT7ku4MUBh4aAMXIPZSyh7z3bY9kw==
X-Google-Smtp-Source: AGHT+IElpurR2LFD/KA0YxydPskNWdyiyMXOXjDojji/C5TQQDen9BYKRZvCtcHWgjN3q2aXyZrNdNjq0ylj47TmWuQ=
X-Received: by 2002:a0d:d343:0:b0:599:8bd:5bdf with SMTP id
 v64-20020a0dd343000000b0059908bd5bdfmr697795ywd.50.1700254031913; Fri, 17 Nov
 2023 12:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117171208.2066136-1-pctammela@mojatatu.com>
In-Reply-To: <20231117171208.2066136-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 17 Nov 2023 15:47:00 -0500
Message-ID: <CAM0EoM=YwfXTx5X9zEhZUgDFe3FL4i2t8QfQrO4tc6J-VMhaKg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] selftests: tc-testing: more updates to tdc
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 12:12=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.=
com> wrote:
>
> Address the issues making tdc timeout on downstream CIs like lkp and
> tuxsuite.
>
> Pedro Tammela (6):
>   selftests: tc-testing: cap parallel tdc to 4 cores
>   selftests: tc-testing: move back to per test ns setup
>   selftests: tc-testing: use netns delete from pyroute2
>   selftests: tc-testing: leverage -all in suite ns teardown
>   selftests: tc-testing: timeout on unbounded loops
>   selftests: tc-testing: report number of workers in use
>
>  .../tc-testing/plugin-lib/nsPlugin.py         | 98 +++++++++----------
>  tools/testing/selftests/tc-testing/tdc.py     |  3 +-
>  2 files changed, 51 insertions(+), 50 deletions(-)

For the series:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> --
> 2.40.1
>

