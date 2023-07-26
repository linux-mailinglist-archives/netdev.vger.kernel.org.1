Return-Path: <netdev+bounces-21112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B94076279C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3711B1C21039
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 00:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080DA10E7;
	Wed, 26 Jul 2023 00:03:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C910E5
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 00:03:21 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CF6C0;
	Tue, 25 Jul 2023 17:03:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-55b22f82ac8so267296a12.1;
        Tue, 25 Jul 2023 17:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690329800; x=1690934600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHAapaePXL7+FHN8rpfGGI7gGpJJJih3x0C9nNGs6hY=;
        b=HaWNN2zRlnip3W7uMddb63W3ffj3C+kYWf6UdrCjVIEgLYfdhS/L0jiYP20hOqC8Tl
         VZzQ9USmLP/lE8tzIJLXPPqCbqyMEFEDjEJ4vxBYmKhlgjSPNfeu1O2FAbvyeHV5aiih
         zyTRnsZPii4tPccRnBxwMfk5WR8gEzvLZEu4R3WQsoMSRx/ujQWq+IJe0nB76gWDmWOL
         mxg4ujkKkBdom15NVrc+wH9Wzfgi/SqWh9hCzoq2zc2QNpFcJdzauS04+9D5/MSSojYr
         A5rczThWpPbkTm8xdAAzTtTHz/1lnfYGoa19Hx1rAgW8ryOLHYUxe8nI15rPEIOEfEen
         HPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690329800; x=1690934600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHAapaePXL7+FHN8rpfGGI7gGpJJJih3x0C9nNGs6hY=;
        b=in4xVbl5TgYaw2LxMtEfdsu7tZQUlAoETNWlnZGSOp1Qa3QVVX6wsCSxdyKC/OhUNM
         72ikiDvxzCVHqC7ZWA0tR1hujymHMmCollLcLGjSSzioJ7WxBn5kCB9EALzeg60ZXyIQ
         p47NlFRfdS2b4R9K/fPnMnUveNktL6PrgnR07/3x1Ey0UyDWPw9vpP15PPAx6t/s1fEo
         OtQ2PssjTLNJ6d/KDzdOTiXSIRLbfsNJvUzP3i6Wmm+q4PezEs3DR8uAWw0oDX2v0bC8
         U3cgPkLm+m6Y3FnWffJlYpbMrrFmFPVnZ9IWMjhn8PBsdZ4mhzPt/lJMSjDG8Zyr0J7c
         p1IQ==
X-Gm-Message-State: ABy/qLYNYOI+4MCvDirfwdP26Nf33ygpvzULkEu/BA5mWPJeXCb51Iw5
	1HCraHPfvQu4A6g7bOLguFr5Ms0EtjPTd7O+B7c=
X-Google-Smtp-Source: APBJJlHAJGaHp8s3q5aDkRi/8vCq+A1h9FG3kFeX90wVn6xXBZTi4tyqT3S1tuSwCyz73+YW85KBl6MR49RGASCqtNw=
X-Received: by 2002:a17:90a:2c2:b0:268:2862:7414 with SMTP id
 d2-20020a17090a02c200b0026828627414mr670968pjd.0.1690329799570; Tue, 25 Jul
 2023 17:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720161323.2025379-1-kuba@kernel.org> <c429298e279bd549de923deba09952e7540e534a.camel@gmail.com>
 <20230725115528.596b5305@kernel.org> <CAKgT0UdKWmogiFD_Gip3TCi8-ydy+CVjwca1hPTYBRQQZ8_mGQ@mail.gmail.com>
 <20230725134122.1684a2f1@kernel.org>
In-Reply-To: <20230725134122.1684a2f1@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 25 Jul 2023 17:02:42 -0700
Message-ID: <CAKgT0Udz74tvTL9TfT4boajCFpAog4juJjW83pxEvQ7RNMFGDw@mail.gmail.com>
Subject: Re: [PATCH net] docs: net: clarify the NAPI rules around XDP Tx
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 1:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 25 Jul 2023 13:10:18 -0700 Alexander Duyck wrote:
> > On Tue, Jul 25, 2023 at 11:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > > This isn't accurate, and I would say it is somewhat dangerous advic=
e.
> > > > The Tx still needs to be processed regardless of if it is processin=
g
> > > > page_pool pages or XDP pages. I agree the Rx should not be processe=
d,
> > > > but the Tx must be processed using mechanisms that do NOT make use =
of
> > > > NAPI optimizations when budget is 0.
> > > >
> > > > So specifically, xdp_return_frame is safe in non-NAPI Tx cleanup. T=
he
> > > > xdp_return_frame_rx_napi is not.
> > > >
> > > > Likewise there is napi_consume_skb which will use either a NAPI or =
non-
> > > > NAPI version of things depending on if budget is 0 or not.
> > > >
> > > > For the page_pool calls there is the "allow_direct" argument that i=
s
> > > > meant to decide between recycling in directly into the page_pool ca=
che
> > > > or not. It should only be used in the Rx handler itself when budget=
 is
> > > > non-zero.
> > > >
> > > > I realise this was written up in response to a patch on the Mellano=
x
> > > > driver. Based on the patch in question it looks like they were call=
ing
> > > > page_pool_recycle_direct outside of NAPI context. There is an expli=
cit
> > > > warning above that function about NOT calling it outside of NAPI
> > > > context.
> > >
> > > Unless I'm missing something budget=3D0 can be called from hard IRQ
> > > context. And page pool takes _bh() locks. So unless we "teach it"
> > > not to recycle _anything_ in hard IRQ context, it is not safe to call=
.
> >
> > That is the thing. We have to be able to free the pages regardless of
> > context. Otherwise we make a huge mess of things. Also there isn't
> > much way to differentiate between page_pool and non-page_pool pages
> > because an skb can be composed of page pool pages just as easy as an
> > XDP frame can be. All you would just have to enable routing or
> > bridging for Rx frames to end up with page pool pages in the Tx path.
> >
> > As far as netpoll itself we are safe because it has BH disabled and so
>
> We do? Can you point me to where netpoll disables BH?

I misread the code. Basically it looks like netconsole is explicitly
disabling interrupts via spin_lock_irqsave in write_msg is what is
going on.

> > as a result page_pool doesn't use the _bh locks. There is code in
> > place to account for that in the producer locking code, and if it were
> > an issue we would have likely blown up long before now. The fact is
> > that page_pool has proliferated into skbs, so you are still freeing
> > page_pool pages indirectly anyway.
> >
> > That said, there are calls that are not supposed to be used outside of
> > NAPI context, such as page_pool_recycle_direct(). Those have mostly
> > been called out in the page_pool.h header itself, so if someone
> > decides to shoot themselves in the foot with one of those, that is on
> > them. What we need to watch out for are people abusing the "direct"
> > calls and such or just passing "true" for allow_direct in the
> > page_pool calls without taking proper steps to guarantee the context.
> >
> > > > We cannot make this distinction if both XDP and skb are processed i=
n
> > > > the same Tx queue. Otherwise you will cause the Tx to stall and bre=
ak
> > > > netpoll. If the ring is XDP only then yes, it can be skipped like w=
hat
> > > > they did in the Mellanox driver, but if it is mixed then the XDP si=
de
> > > > of things needs to use the "safe" versions of the calls.
> > >
> > > IDK, a rare delay in sending of a netpoll message is not a major
> > > concern.
> >
> > The whole point of netpoll is to get data out after something like a
> > crash. Otherwise we could have just been using regular NAPI. If the Tx
> > ring is hung it might not be a delay but rather a complete stall that
> > prevents data on the Tx queue from being transmitted on since the
> > system will likely not be recovering. Worse yet is if it is a scenario
> > where the Tx queue can recover it might trigger the Tx watchdog since
> > I could see scenarios where the ring fills, but interrupts were
> > dropped because of the netpoll.
>
> I'm not disagreeing with you. I just don't have time to take a deeper
> look and add the IRQ checks myself and I'm 90% sure the current code
> can't work with netpoll. So I thought I'd at least document that :(

So looking at it more I realized the way we are getting around the
issue is that the skbuffs are ALWAYS freed in softirq context.
Basically we hand them off to dev_consume_skb_any, which will hand
them off to dev_kfree_skb_irq_reason, and it is queueing them up to be
processed in the net_tx_action handler.

As far as the page pool pages themselves I wonder if we couldn't just
look at modifying __page_pool_put_page() so that it had something
similar to dev_consume_skb_any_reason() so if we are in a hardirq or
IRQs are disabled we just force the page to be freed.

