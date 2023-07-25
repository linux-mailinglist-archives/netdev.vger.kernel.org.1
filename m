Return-Path: <netdev+bounces-21025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4CE762311
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6770B2812ED
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3B026B28;
	Tue, 25 Jul 2023 20:10:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1725931
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 20:10:58 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB0E2118;
	Tue, 25 Jul 2023 13:10:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686bc261111so292241b3a.3;
        Tue, 25 Jul 2023 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690315855; x=1690920655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKPAlFBqfz/fhqIGuaxdBQTHebTtxe/9uM05NU60yXk=;
        b=UnRwOhGV7if+FNnwnBOYSidhXsOU4QlZ7NzG6M/tcxSD5sPWMVtO3MvMLPhdS03smK
         khQ0EDptYnmwqu3MUlz3oR+4PM37hHpPKbSnwdUrimccd0MyP1UXhW2qQq5QONBx2THn
         TM1eebzswO53cQCDT1Q1vz8L8x0sjzqmM1+1AJnbI6neQnnkhtTdV6w2wa6WJvGR2I5x
         z12DvfSFJsy/ly6IQpu6aLiWf+mc9K0Y1U994OMGOl1qgWn5Dd+Lx3YARr0OsD0m6KBc
         rSbLPvagAvpT75x/kssIMhyxWJEWZ3Trf/pATmodq8Z9yACT9cSLNa5sSC6PoKpiMSOH
         5Cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690315855; x=1690920655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKPAlFBqfz/fhqIGuaxdBQTHebTtxe/9uM05NU60yXk=;
        b=eqcq7iMlzQalO2gUiOOGq8PzO9fVi96ag4PgVkWxD7YJM0W2Wvl0L0lpYKIM7Yc2aq
         DKzL1/cjrGeayrpEI8/6L/hzjzlmHb5/CovoLRzjJ6Djvcz2HatIV6ZHK44sd0cQ1MfR
         clvj3fBTFcxyKLeMZ/RopbbUnQGVIGgGVmay2Rk4tAEMB++/mguyoaGTcMcnXQ5SB8+t
         /08k1czsFyafZu6OrCYOC8YnDtmMkgvlX/S8VZoJci4p6ZgHaC3/HuWl9O1jbwBsJhgY
         Ok+7u8/Pljri24bmyM5AZR/SmsAedS4B8/jxEAAPIEO/m92kLy6oVPYtw3kFQ0yzTwNa
         eoEg==
X-Gm-Message-State: ABy/qLZKxnFxf6OjPbRqPks4CgW6EeyrFx5B0m/GBA89JOhGm1lbApyM
	2JEPJj63I0PK7DX/6JM65UmrvbaA9O0oSKYQnSs=
X-Google-Smtp-Source: APBJJlEk5X9+pybB7eLuYNWbeDFCP+wlFKoHfAyk6uM1nk2WbLKfESkxPncd+piZlRgHlyREdM7HPhK5oMMzcH58KbE=
X-Received: by 2002:a17:90b:3907:b0:268:160d:937e with SMTP id
 ob7-20020a17090b390700b00268160d937emr159142pjb.27.1690315855289; Tue, 25 Jul
 2023 13:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720161323.2025379-1-kuba@kernel.org> <c429298e279bd549de923deba09952e7540e534a.camel@gmail.com>
 <20230725115528.596b5305@kernel.org>
In-Reply-To: <20230725115528.596b5305@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 25 Jul 2023 13:10:18 -0700
Message-ID: <CAKgT0UdKWmogiFD_Gip3TCi8-ydy+CVjwca1hPTYBRQQZ8_mGQ@mail.gmail.com>
Subject: Re: [PATCH net] docs: net: clarify the NAPI rules around XDP Tx
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 11:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 25 Jul 2023 10:30:24 -0700 Alexander H Duyck wrote:
> > > -In other words, it is recommended to ignore the budget argument when
> > > -performing TX buffer reclamation to ensure that the reclamation is n=
ot
> > > -arbitrarily bounded; however, it is required to honor the budget arg=
ument
> > > -for RX processing.
> > > +In other words for Rx processing the ``budget`` argument limits how =
many
> > > +packets driver can process in a single poll. Rx specific APIs like p=
age
> > > +pool or XDP cannot be used at all when ``budget`` is 0.
> > > +skb Tx processing should happen regardless of the ``budget``, but if
> > > +the argument is 0 driver cannot call any XDP (or page pool) APIs.
> >
> > This isn't accurate, and I would say it is somewhat dangerous advice.
> > The Tx still needs to be processed regardless of if it is processing
> > page_pool pages or XDP pages. I agree the Rx should not be processed,
> > but the Tx must be processed using mechanisms that do NOT make use of
> > NAPI optimizations when budget is 0.
> >
> > So specifically, xdp_return_frame is safe in non-NAPI Tx cleanup. The
> > xdp_return_frame_rx_napi is not.
> >
> > Likewise there is napi_consume_skb which will use either a NAPI or non-
> > NAPI version of things depending on if budget is 0 or not.
> >
> > For the page_pool calls there is the "allow_direct" argument that is
> > meant to decide between recycling in directly into the page_pool cache
> > or not. It should only be used in the Rx handler itself when budget is
> > non-zero.
> >
> > I realise this was written up in response to a patch on the Mellanox
> > driver. Based on the patch in question it looks like they were calling
> > page_pool_recycle_direct outside of NAPI context. There is an explicit
> > warning above that function about NOT calling it outside of NAPI
> > context.
>
> Unless I'm missing something budget=3D0 can be called from hard IRQ
> context. And page pool takes _bh() locks. So unless we "teach it"
> not to recycle _anything_ in hard IRQ context, it is not safe to call.

That is the thing. We have to be able to free the pages regardless of
context. Otherwise we make a huge mess of things. Also there isn't
much way to differentiate between page_pool and non-page_pool pages
because an skb can be composed of page pool pages just as easy as an
XDP frame can be. All you would just have to enable routing or
bridging for Rx frames to end up with page pool pages in the Tx path.

As far as netpoll itself we are safe because it has BH disabled and so
as a result page_pool doesn't use the _bh locks. There is code in
place to account for that in the producer locking code, and if it were
an issue we would have likely blown up long before now. The fact is
that page_pool has proliferated into skbs, so you are still freeing
page_pool pages indirectly anyway.

That said, there are calls that are not supposed to be used outside of
NAPI context, such as page_pool_recycle_direct(). Those have mostly
been called out in the page_pool.h header itself, so if someone
decides to shoot themselves in the foot with one of those, that is on
them. What we need to watch out for are people abusing the "direct"
calls and such or just passing "true" for allow_direct in the
page_pool calls without taking proper steps to guarantee the context.

> > >  .. warning::
> > >
> > > -   The ``budget`` argument may be 0 if core tries to only process Tx=
 completions
> > > -   and no Rx packets.
> > > +   The ``budget`` argument may be 0 if core tries to only process
> > > +   skb Tx completions and no Rx or XDP packets.
> > >
> > >  The poll method returns the amount of work done. If the driver still
> > >  has outstanding work to do (e.g. ``budget`` was exhausted)
> >
> > We cannot make this distinction if both XDP and skb are processed in
> > the same Tx queue. Otherwise you will cause the Tx to stall and break
> > netpoll. If the ring is XDP only then yes, it can be skipped like what
> > they did in the Mellanox driver, but if it is mixed then the XDP side
> > of things needs to use the "safe" versions of the calls.
>
> IDK, a rare delay in sending of a netpoll message is not a major
> concern.

The whole point of netpoll is to get data out after something like a
crash. Otherwise we could have just been using regular NAPI. If the Tx
ring is hung it might not be a delay but rather a complete stall that
prevents data on the Tx queue from being transmitted on since the
system will likely not be recovering. Worse yet is if it is a scenario
where the Tx queue can recover it might trigger the Tx watchdog since
I could see scenarios where the ring fills, but interrupts were
dropped because of the netpoll.

