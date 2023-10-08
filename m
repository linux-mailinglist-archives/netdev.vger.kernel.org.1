Return-Path: <netdev+bounces-38871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551B67BCCC9
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 08:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C190B281491
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 06:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8CC46B8;
	Sun,  8 Oct 2023 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nhtd5IFd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88015D1
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 06:45:15 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963E0C6
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 23:45:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso8040a12.0
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696747512; x=1697352312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj28NxioJUT9pNxHmjKPy7bneREmBqaMO4pmGBynunM=;
        b=nhtd5IFdbPIj8ifm14qbkA4KYrHzOhw54votUsQUgw1bxjq62+yHiJPWvpOTQPQeqD
         +7vUqog9PZ5Cq0bxgEd8jFQbe73J/MQ7qmY49PaQVwpO8fh97+Fn7o2CP7tEYSCbS+Xl
         K1DWb0tihKGBDwRkr1uv9Pb3zZ4FCcr5Frj9pfnSGEnP5rMnug13/s4PWXPJ/0YpUZ0N
         1aCAxzJcIRDXp5aFWSTdF/QCywx/K2v3cmpMxxoBZwHCOdLfq34b7U4tvSvkhSE9qrwg
         fCLs9rGSSNt6Hr0JyCAlBZYDc4GTEyg2tQJ4RkNYcob50rjkMXdQ41G6Wju2R5QqIixI
         iqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747512; x=1697352312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj28NxioJUT9pNxHmjKPy7bneREmBqaMO4pmGBynunM=;
        b=EkfIcvQoGHpbAZcxwrFMMqOXLaUcW8Fwr33qQ4vrOxR2dfCcx19jM85LtWfm4l/cWq
         3225rt1eiLZA4brICkVQPoPKJM9DabHhL2qH6f2lmgMCdJ+kJt2g8dL+mZ4JNPRdLbBR
         lgj8TvVS+DaW8Yx5BPqhPK86Wclu2Q7093Y/rpn8GXXQIcJYL5/6/75SerS1Emsf72ky
         r/WU1ioMkwWRWsi2mb5NghE2SEMa31Mk5/7wiiLbKPFqNAS2oXeKbq6c6Qd4QNOBtUfE
         sfDxaJefG4rZT14BeicgN9nYSvIMFA2s8aAuAgOsY3BDF5aAPZqGBT7as1BAXQDxXSJh
         k/qg==
X-Gm-Message-State: AOJu0Yw/BnwFS7HBhrP55JvA1FVwu8eTIOTRTvFarqcWpcErz4vlAOE+
	3YHYPa62NTviZaSvg/TWPrU6GuJt4r6R2FSDiN4yLw==
X-Google-Smtp-Source: AGHT+IG4CyyZZCd0/HZEeFTV2mudAvLVlov42FQWSJxLp3oocKs6i+qpPc56NDMRIUK6Uphtzbq9cKh6rZ4HnEp1nu4=
X-Received: by 2002:a50:d0d7:0:b0:538:1d3b:172f with SMTP id
 g23-20020a50d0d7000000b005381d3b172fmr296503edf.3.1696747511677; Sat, 07 Oct
 2023 23:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com> <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev>
In-Reply-To: <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 8 Oct 2023 08:45:00 +0200
Message-ID: <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 7, 2023 at 8:34=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev> wr=
ote:
>
>
> On 2023/10/7 13:29, Eric Dumazet wrote:
> > On Sat, Oct 7, 2023 at 7:06=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev=
> wrote:
> >> Although there is a kfree_skb_reason() helper function that can be use=
d to
> >> find the reason why this skb is dropped, but most callers didn't incre=
ase
> >> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
> >>
> > ...
> >
> >> +
> >> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> >> +{
> >> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_=
alloc() */
> >> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->co=
re_stats);
> >> +       unsigned long *field;
> >> +
> >> +       if (unlikely(!p))
> >> +               p =3D netdev_core_stats_alloc(dev);
> >> +
> >> +       if (p) {
> >> +               field =3D (unsigned long *)((void *)this_cpu_ptr(p) + =
offset);
> >> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
> > This is broken...
> >
> > As I explained earlier, dev_core_stats_xxxx(dev) can be called from
> > many different contexts:
> >
> > 1) process contexts, where preemption and migration are allowed.
> > 2) interrupt contexts.
> >
> > Adding WRITE_ONCE()/READ_ONCE() is not solving potential races.
> >
> > I _think_ I already gave you how to deal with this ?
>
>
> Yes, I replied in v6.
>
> https://lore.kernel.org/all/e25b5f3c-bd97-56f0-de86-b93a3172870d@linux.de=
v/
>
> > Please try instead:
> >
> > +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> > +{
> > +       /* This READ_ONCE() pairs with the write in netdev_core_stats_a=
lloc() */
> > +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->cor=
e_stats);
> > +       unsigned long __percpu *field;
> > +
> > +       if (unlikely(!p)) {
> > +               p =3D netdev_core_stats_alloc(dev);
> > +               if (!p)
> > +                       return;
> > +       }
> > +       field =3D (__force unsigned long __percpu *)((__force void *)p =
+ offset);
> > +       this_cpu_inc(*field);
> > +}
>
>
> This wouldn't trace anything even the rx_dropped is in increasing. It
> needs to add an extra operation, such as:

I honestly do not know what you are talking about.

Have you even tried to change your patch to use

field =3D (__force unsigned long __percpu *)((__force void *)p + offset);
this_cpu_inc(*field);

Instead of the clearly buggy code you had instead :

    field =3D (unsigned long *)((void *)this_cpu_ptr(p) + offset);
     WRITE_ONCE(*field, READ_ONCE(*field) + 1);

If your v7 submission was ok for tracing what you wanted,
I fail to see why a v8 with 3 lines changed would not work.

