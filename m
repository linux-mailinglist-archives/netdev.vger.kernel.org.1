Return-Path: <netdev+bounces-22110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AB476616C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609501C2178A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 01:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4200615C3;
	Fri, 28 Jul 2023 01:41:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331C715C1
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:41:32 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F840358B
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:41:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so8363e87.3
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690508490; x=1691113290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQZDst5qjaEpnNLHre25dv9hzF5f2KbCPvv3bZhdA8M=;
        b=E7GwpTEiXCWXp8CvDlE/e2MFibkDirRGzggEgGqz3YZAxhOwVJtb//aXRVjKhWoB8v
         sJSqiihV23CXLrIF1uwXmf/MjUJKpPyqH3wunQUCjYi7w/8rRBcaTZ/tTQXf77uBzNfg
         EqadLhb04SWm07uyZ0hE/O7rZO8oqe9azO5t81v+QOLLBiqrngZXYX3xJeiUfLzD4y/Y
         8K/C+IBGfYWitjWeUy/IB2Ng/tuLIVjGrvrmJ0sqf6lm3helPmB1CIMn+p9xdJe+W87F
         WsY/Uhi623LB8Gh3VT5nw2mjw9GjvbjvQVpme/LS6Brl0+YaKVJ/ZgxW6pRllr4nGKHi
         AzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690508490; x=1691113290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQZDst5qjaEpnNLHre25dv9hzF5f2KbCPvv3bZhdA8M=;
        b=JbAcPw6yycsOXGAMihCaiVlKOS7XM2lX1z9DOoVLKuHb25S7n/Fw+k+zeDLZQ/O0wT
         WFWgmqnXsx+kiXn85Ib9+TZ7qjnGkcKkzNwNzWx9YHlWf4DfKNAezC4koPJzqWFcZhB1
         jJO2CHgy17zt4ZwXkjzPdjrrsaZHLTBC/76fxD//0GRQHIVjfypyWG0ZOeLChj0lmLbR
         dY3J9fcFSqrjIBBliVqecazxMyeV7Q7BJ8XHq2G84sc16OGPy4kYakktBVPBoJlRjumz
         NiyENUNcylbgyvqllPMLuQv4gqwBacUvXngud5bO4utuOi+UqKaMDTeez+nveTv77M7Y
         0OKg==
X-Gm-Message-State: ABy/qLYQlvHJArhpOxI0g+lNX5eYLluoGJvUitZXEKPPSDI0tm7Skv+k
	YskLaYbKws4ABwnjOQcEtaiq8GMf9PSWcH4vPPM=
X-Google-Smtp-Source: APBJJlFuNSIT3DQIyoCdYBI8pbyqFOvtpvPqQAWD6q9xtgQtJXnh9HSdLOVh99FsJVU3EiolsIwUz+APhic3TrJzcYo=
X-Received: by 2002:a05:6512:541:b0:4f9:cd02:4aec with SMTP id
 h1-20020a056512054100b004f9cd024aecmr525694lfl.29.1690508489684; Thu, 27 Jul
 2023 18:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <067f87d9785849c13f2f8733d457ffe8616a1aa0.1690439335.git.chenfeiyang@loongson.cn>
 <5b52d461-77e5-493a-a634-4c8a0637a0bc@lunn.ch>
In-Reply-To: <5b52d461-77e5-493a-a634-4c8a0637a0bc@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 28 Jul 2023 09:41:18 +0800
Message-ID: <CACWXhKnqkjS7mG0N-=Htt1Ee8xTmb3EYfAOJpFta7C0076advQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] net: stmmac: dwmac1000: Allow platforms to
 choose some register offsets
To: Andrew Lunn <andrew@lunn.ch>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, chenhuacai@loongson.cn, 
	linux@armlinux.org.uk, dongbiao@loongson.cn, 
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 5:10=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +#define _REGS                        (priv->plat->dwmac_regs)
> >
> > -/* Rx watchdog register */
> > +/* DMA CRS Control and Status Register Mapping */
> > +#define DMA_CHAN_OFFSET              (_REGS->addrs->chan_offset)
>
> It is thought to be bad practice for a macro to access things not
> passed to it. Please try to make a cleaner solution.
>

Hi, Andrew,

OK. I will try.

Thanks,
Feiyang

>        Andrew

