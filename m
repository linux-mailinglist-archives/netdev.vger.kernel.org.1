Return-Path: <netdev+bounces-33353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3E979D851
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DC5281F3A
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198309463;
	Tue, 12 Sep 2023 18:05:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCEA3D70
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 18:05:58 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFD6115
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:05:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52c96d5df86so2089a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694541956; x=1695146756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYqDUs3nkzy+99JdbqiBWkMenPxzjtYzz/eA+mvCidk=;
        b=pEdgLNOfVB/fRhmxx8BGsFlFx3MoU7VDnEDB/S+Y3W9CJW04mevLIHVX3HsorF5U6R
         2V5jgW8g9AiD6yru9aaaLFh8fXC35dz0nR0GS/dQz5bdy0itnBt91HVlMjglk2tJS2Nc
         v671pgDG5oL9ootYL1U3L756IKxPQ6z4ViZ7iwq2QcG9trkO3AC/JdBwxl88Nrh+etWH
         GkNfzhv/NJwvPAw4q6GSD6Oi8188Yn9t4xT9GYDhAlmKd5muJcWuadcDPLuOd+UodnYr
         YrfSySnqyA3Id4tNKisgfBvY9QcB2DQYdU+sRBgEff+3e82ItGT6espRlAIFytmFGTUh
         l3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541956; x=1695146756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYqDUs3nkzy+99JdbqiBWkMenPxzjtYzz/eA+mvCidk=;
        b=Rcqyb1LriiMxpf7Lg0F8t22oyWQiVZCNaPH83mgEmVM0LRMKml6eALuJiCjtkDOr9C
         jMjskmf3qNY8apG4iaiqchK20Qv9DpTILeJqHqlAntlGfFg0Sf/sGWhGQJAtODGoNr3V
         nteacMmHnZELHDCn4Qh6A3TXGOTk4jJIRvaUgkx4ptV1Xd8sP9FFx++C+TJKCVX7brUJ
         q+p/+q6iQnXRcLI0eG0IYFMl6tYiw0v71cuTbI2YZF5HbEdUX3/CM+zFMYMui4ywTco5
         8fbCva9sh9gF5RV6baaJv6qYR4Yv+J/i0l8vmqcUBXbNIdrG1zrWh+515AmjxZrefR79
         S+EA==
X-Gm-Message-State: AOJu0Ywbvs85EBSxlZlz+LYBRF7/js/dKcr8XMjlz08P27S0x/bFCn40
	YSOVl4Sr16UL43oZJpmAKYjXo1p0FgaZfL2SvlnFOA==
X-Google-Smtp-Source: AGHT+IEYr0P1WStyJpUE0/XWzPhwSlxaxamU9zj8epty3cb1jYzzDn81j9YUAjkSKqC+XdwL4wOnkp4W/jFg8vp3Jx4=
X-Received: by 2002:a50:cd59:0:b0:522:4741:d992 with SMTP id
 d25-20020a50cd59000000b005224741d992mr12316edj.4.1694541956322; Tue, 12 Sep
 2023 11:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
 <CANn89i+W1iAQmOhunLbqpvHu8EUO6uawv6Uvx7qimyBa_PBNCg@mail.gmail.com>
 <f3e84a37-3218-0d52-e7ed-2d215fed58e3@intel.com> <CANn89i+AwmpjM-bNuYRS26v-GRrVoucewxgmkvv25PNM4VWPGA@mail.gmail.com>
 <39c906f6-910d-01c7-404a-8fe6a161ef2e@intel.com> <CANn89i+QSPoXphaLzfKCqCHxjsD20ifr8YPJM_fZ_H5kFZ7dwQ@mail.gmail.com>
 <8bc6c1cd-50bb-44ef-5979-3bb50a70afcb@intel.com> <CANn89iL6HVvRegORfP49prJV4EJU2-AbD4YXB-eo_vwU1JG1ew@mail.gmail.com>
In-Reply-To: <CANn89iL6HVvRegORfP49prJV4EJU2-AbD4YXB-eo_vwU1JG1ew@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Sep 2023 20:05:42 +0200
Message-ID: <CANn89iKbn97Rbjc+3uZMpUi0tqCuhj88UdFZhhnqpC6nJRLC=A@mail.gmail.com>
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 8:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:

> Sure, this was what was suggested (perhaps not _very_ precisely, but
> the general idea was pretty clear).
> v2 seems ok, right ?
>
> It seems we are all on the same page.
>
> +static __cold struct net_device_core_stats __percpu
> *dev_core_stats(struct net_device *dev)
> +{
> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_all=
oc() */
> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_=
stats);
> +
> +       if (likely(p))
> +               return p;
> +
> +       return netdev_core_stats_alloc(dev);
> +}
> +
> +#define DEV_CORE_STATS_INC(FIELD)                              \
> +void dev_core_stats_##FIELD##_inc(struct net_device *dev)      \
> +{                                                              \
> +       struct net_device_core_stats __percpu *p;               \
> +                                                               \
> +       p =3D dev_core_stats(dev);                                \
> +       if (p)                                                  \
> +               this_cpu_inc(p->FIELD);                         \
> +}                                                              \
> +EXPORT_SYMBOL(dev_core_stats_##FIELD##_inc)

Oh well, I just read the patch, and it seems wrong indeed.

netdev_core_stats_alloc() is the one that can be cold.

