Return-Path: <netdev+bounces-22151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA0766417
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFCE2825F5
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768F9BA35;
	Fri, 28 Jul 2023 06:25:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6DA1FAF
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 06:25:42 +0000 (UTC)
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BFCA0;
	Thu, 27 Jul 2023 23:25:40 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-577497ec6c6so19553587b3.2;
        Thu, 27 Jul 2023 23:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690525540; x=1691130340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ7uCM9gCmC7Ec+PIxmYSly2Nv+UftyJKyYRxKcBUVA=;
        b=K9Y/MMyD9/5jKIzEZ/V/aFDa8azmFWJIZhBSBmsqXY1q5rGJsWO1rjjmVzXBoL3NBW
         X4+LFZYEg2OkaZOtDHdPauWx5VKj0EdTuPcl1VVwZgKd24Yr+vH7J6eKNC8OKn8W8V+J
         S3UUC8UgdhkxmVhe3gycNurrRMNte7RMMNo3X7++pDxoWHZ5HJ7fRdiNMLlp0bB+wIDa
         MMLigdB1YwOpPYgOn0bRn7ldv1ZL0JSXlMc283ViCV4DBYmcvzEkxTGcOdEP7a5/DxKZ
         vo9G5A1rJQoEfgzNVXPO7f4OgfHeehx7uKobZz2r3YO2CxjBhtYEFQ6tJ0y+2EaS4z5n
         su3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690525540; x=1691130340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJ7uCM9gCmC7Ec+PIxmYSly2Nv+UftyJKyYRxKcBUVA=;
        b=XSagOv6T0Wu6J/1Ik/viN1C1w7FGmYY8zj7ySent/35QLj5+wSVoW4uDGid2itdedH
         yqUdr16OBNlE/1pqLasDoS1puHuZIpvkU59mVdYkc5IVWsE+d5vR6EuvBukXWJP+xMw5
         ID0be+Hy3DaBEVCgCJK2yteDmQRJDMxKaMHsoH1U0krgeR5BrHu2/BOPOSL5VtGPlIHx
         XpjZArUcA+nxmYMO4iLvP7NFA8/nHNyK6+Xu5chiTzqTJty/SnVVsMGWAiINlPd+UngK
         98xr9m3k033pOcZkLsMIjLvLKbzrmobY03Y3vXDiaqxxc/rUD9DttLXuJlTHalcm5YLZ
         rthA==
X-Gm-Message-State: ABy/qLbvVpbzkNrsgev/CjQxEaPszCpJIrPH0VJOTFFTo/gFQ7otvRrO
	p1BlJNNGAffxwxp6jkSBcY3KSPQI7FKL4RfirFY=
X-Google-Smtp-Source: APBJJlGbJBxbMIsBz86uOE3YjHYLMuHaEEnEY+fVotWoJjYeOSf7FpwhrzqYGVClNvIMsEy4X2wQkro8l4ADRPuelDY=
X-Received: by 2002:a81:4943:0:b0:583:78b8:f42e with SMTP id
 w64-20020a814943000000b0058378b8f42emr1093347ywa.42.1690525539847; Thu, 27
 Jul 2023 23:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com>
 <20230727125125.1194376-4-imagedong@tencent.com> <CANn89iKWTrgEp3QY34mNqVAx09fSxHUh+oHRTd6=aWurGS7qWA@mail.gmail.com>
 <CADxym3YhjMv3Xkts99fiajq-cR-BqxDayKFzFZ1L49BNfFXkdw@mail.gmail.com> <CADVnQynQ1Hw+Jh7pjdNw_Mo4tWZV8V_sA+L-o=O4uV+9Gv7Prg@mail.gmail.com>
In-Reply-To: <CADVnQynQ1Hw+Jh7pjdNw_Mo4tWZV8V_sA+L-o=O4uV+9Gv7Prg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 28 Jul 2023 14:25:28 +0800
Message-ID: <CADxym3Zqb2CCpJojGiT7gVL98GDdOmjxqLY6ApLeP2zZU1Kn3Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: check timeout by
 icsk->icsk_timeout in tcp_retransmit_timer()
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>, 
	Yuchung Cheng <ycheng@google.com>, Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 12:44=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
>
> On Thu, Jul 27, 2023 at 7:57=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > On Fri, Jul 28, 2023 at 3:31=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Jul 27, 2023 at 2:52=E2=80=AFPM <menglong8.dong@gmail.com> wr=
ote:
> > > >
> > > > From: Menglong Dong <imagedong@tencent.com>
> > > >
> > > > In tcp_retransmit_timer(), a window shrunk connection will be regar=
ded
> > > > as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'. This =
is not
> > > > right all the time.
> > > >
> > > > The retransmits will become zero-window probes in tcp_retransmit_ti=
mer()
> > > > if the 'snd_wnd=3D=3D0'. Therefore, the icsk->icsk_rto will come up=
 to
> > > > TCP_RTO_MAX sooner or later.
> > > >
> > > > However, the timer is not precise enough, as it base on timer wheel=
.
> > > > Sorry that I am not good at timer, but I know the concept of time-w=
heel.
> > > > The longer of the timer, the rougher it will be. So the timeout is =
not
> > > > triggered after TCP_RTO_MAX, but 122877ms as I tested.
> > > >
> > > > Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always=
 true
> > > > once the RTO come up to TCP_RTO_MAX.
> > > >
> > > > Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_tim=
eout',
> > > > which is exact the timestamp of the timeout.
> > > >
> > > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > > ---
> > > >  net/ipv4/tcp_timer.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > > > index 470f581eedd4..3a20db15a186 100644
> > > > --- a/net/ipv4/tcp_timer.c
> > > > +++ b/net/ipv4/tcp_timer.c
> > > > @@ -511,7 +511,11 @@ void tcp_retransmit_timer(struct sock *sk)
> > > >                                             tp->snd_una, tp->snd_nx=
t);
> > > >                 }
> > > >  #endif
> > > > -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
> > > > +               /* It's a little rough here, we regard any valid pa=
cket that
> > > > +                * update tp->rcv_tstamp as the reply of the retran=
smitted
> > > > +                * packet.
> > > > +                */
> > > > +               if ((u32)icsk->icsk_timeout - tp->rcv_tstamp > TCP_=
RTO_MAX) {
> > > >                         tcp_write_err(sk);
> > > >                         goto out;
> > > >                 }
> > >
> > >
> > > Hmm, this looks like a net candidate, since this is unrelated to the
> > > other patches ?
> >
> > Yeah, this patch can be standalone. However, considering the
> > purpose of this series, it is necessary. Without this patch, the
> > OOM probe will always timeout after a few minutes.
> >
> > I'm not sure if I express the problem clearly in the commit log.
> > Let's explain it more.
> >
> > Let's mark the timestamp of the 10th timeout of the rtx timer
> > as TS1. Now, the retransmission happens and the ACK of
> > the retransmitted packet will update the tp->rcv_tstamp to
> > TS1+rtt.
> >
> > The RTO now is TCP_RTO_MAX. So let's see what will
> > happen in the 11th timeout. As we timeout after 122877ms,
> > so tcp_jiffies32 now is "TS1+122877ms", and
> > "tcp_jiffies32 - tp->rcv_tstamp" is
> > "TS1+122877ms - (TS1+rtt)" -> "122877ms - rtt",
> > which is always bigger than TCP_RTO_MAX, which is 120000ms.
> >
> > >
> > > Neal, what do you think ?
>
> Sorry, I am probably missing something here, but: what would ever make
> this new proposed condition ((u32)icsk->icsk_timeout - tp->rcv_tstamp
> > TCP_RTO_MAX) true? :-)
>

If the snd_wnd is 0, we need to keep probing until the window
is available. Meanwhile, any retransmission that don't have
a corresponding ACK (see what we do in the 1st patch), which
can be caused by the lost of the ACK or the lost of the retransmitted
packet, can make the condition true, as the tp->rcv_tstamp can't be
updated in time.

This is a little strict here. In the tcp_probe_timer(), we are allowed to
retransmit the probe0 packet for sysctl_tcp_retries2 times. But
we don't allow packets to be lost here.

> In your nicely explained scenario, your new expression,
> icsk->icsk_timeout - tp->rcv_tstamp, will be:
>
>   icsk->icsk_timeout - tp->rcv_tstamp
> =3D TS1 + 120 sec      - (TS1+rtt)
> =3D 120 sec - RTT
>
> AFAICT there is no way for that expression to be bigger than
> TCP_RTO_MAX =3D 120 sec unless somehow RTT is negative. :-)
>
> So AFAICT your expression ((u32)icsk->icsk_timeout - tp->rcv_tstamp >
> TCP_RTO_MAX) will always be false, so rather than this patch we may as
> well remove the if check and the body of the if block?
>

Hmm......as I explained above, the condition will be true
if the real packet loss happens. And I think it is the origin
design.

> To me such a change does not seem like a safe and clear bug fix for
> the "net" branch but rather a riskier design change (appropriate for
> "net-next" branch) that has connections retry forever when the
> receiver retracts the window to zero, under the estimation that this
> is preferable to having the connections die in such a case.
>
> There might be apps that depend on the old behavior of having
> connections die in such cases, so we might want to have this new
> fail-faster behavior guarded by a sysctl in case some sites need to
> revert to the older behavior? Not sure...

Yeah, the behavior here will be different for the users. I'm not
sure if there are any users that rely on such behavior.

What do you think, Eric? Do we need a sysctl here?

Thanks!
Menglong Dong

>
> neal

