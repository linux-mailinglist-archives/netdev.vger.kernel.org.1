Return-Path: <netdev+bounces-22367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5434976730F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 19:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864881C20E02
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B12154B6;
	Fri, 28 Jul 2023 17:15:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC9134B4
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:15:24 +0000 (UTC)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962BC3A85
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:15:21 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44758510539so916906137.2
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690564520; x=1691169320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LROTV5y5IdBJTsjpYwl/eIhz/Ub1IxtdypTbt/I1aSA=;
        b=T/h+VFDtennYU7jNdQ2B6p2dhvppEuTLLFAp8Qh8aosb8BzxrSZZAt8MB5X+QvfUKa
         b//lf0SfR7OwJ637yyR0pMnh3twOFbc7y421CW00PURa5JcT2nCnH0Wy+xn9y6XBGtx5
         4I6J5ouwqYuvYAnofG2Rz6IINeRNlmwTaTwAhlCfe+dX3ImlmLhbROff+YuGiDZP6I3E
         qKPb7mHVsUMdbkeEQMFRzdz9mYIkxnUfXU8NTM8R9sNIbj1tm37ks9IyyG1wpjRGRKya
         RFkfON1/7J9HFiKnMKTeUGcw/P8Sozie4sH1Aq/jE3Qn6qT4yV16rcO1cGJu1v/4+Q5b
         qNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690564520; x=1691169320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LROTV5y5IdBJTsjpYwl/eIhz/Ub1IxtdypTbt/I1aSA=;
        b=cJWjoBpnw9KQhFtThROO2lXCHKDMG/34LUntkFDvB8XVe6CkmKRehfaOaB2aY8cAvx
         X9wJGn0rMT6HwE5uN2ngcDVuOhZEE8UNzcsrMWDwoP3uSMvC1CsaNLSLyDIXOT8A6MkX
         vNXP1SESCZKV+1UxLi6UBgyjVX7cL1csrVJU+T4tElhXUffE2f3L52cyqDcCUMElgV41
         fBQF4h+3mY1bL03FZ8SKtS49v5NVmOhAQ7/feSOn1NVmUgizi9PwfRQB7OHJhG6Zg3u8
         mCnbaDXyFIk/l0imnAEDiS+vBny+l7rd5r6wCRONg5ukEAV7A8/UgbbTUe4GW9bMjvkj
         0ARA==
X-Gm-Message-State: ABy/qLbetNkdk1TkI6qRqn3yGAUBEPjSNvS4cbAW73ZKWEIczpTX1xEc
	TznSet2rKIhAeMVJIAKKWLggwDe48XzAaPpiMGyUGQ==
X-Google-Smtp-Source: APBJJlFVdT0zaDWaI5U/9NiLV0sdX1+Ej6YT5qIxNRjvRnVfgRvHOQMDCbu+agBUeFPAwAwtj0Fc2+EV49TD/jaB8+g=
X-Received: by 2002:a67:e207:0:b0:447:6ef1:c4e with SMTP id
 g7-20020a67e207000000b004476ef10c4emr2228898vsa.34.1690564520259; Fri, 28 Jul
 2023 10:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com>
 <20230727125125.1194376-4-imagedong@tencent.com> <CANn89iKWTrgEp3QY34mNqVAx09fSxHUh+oHRTd6=aWurGS7qWA@mail.gmail.com>
 <CADxym3YhjMv3Xkts99fiajq-cR-BqxDayKFzFZ1L49BNfFXkdw@mail.gmail.com>
 <CADVnQynQ1Hw+Jh7pjdNw_Mo4tWZV8V_sA+L-o=O4uV+9Gv7Prg@mail.gmail.com>
 <CADxym3Zqb2CCpJojGiT7gVL98GDdOmjxqLY6ApLeP2zZU1Kn3Q@mail.gmail.com>
 <CANn89i+WnwgpGy4v=aXsjThPBA2FQzWx9Y=ycXWWGLDdtDHBig@mail.gmail.com> <CADVnQy=OumgmsbsQ8QLhUiyUNN95Ay2guVjgGVVLH93QXanBSw@mail.gmail.com>
In-Reply-To: <CADVnQy=OumgmsbsQ8QLhUiyUNN95Ay2guVjgGVVLH93QXanBSw@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 28 Jul 2023 10:15:03 -0700
Message-ID: <CADVnQynwrvdoEH2d7VVNSG6vHg8BC5ikz+PApOOMG4Eo3MqSww@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: check timeout by
 icsk->icsk_timeout in tcp_retransmit_timer()
To: Eric Dumazet <edumazet@google.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>, 
	Yuchung Cheng <ycheng@google.com>, Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 7:25=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Fri, Jul 28, 2023 at 1:50=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Jul 28, 2023 at 8:25=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > On Fri, Jul 28, 2023 at 12:44=E2=80=AFPM Neal Cardwell <ncardwell@goo=
gle.com> wrote:
> > > >
> > > > On Thu, Jul 27, 2023 at 7:57=E2=80=AFPM Menglong Dong <menglong8.do=
ng@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jul 28, 2023 at 3:31=E2=80=AFAM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 27, 2023 at 2:52=E2=80=AFPM <menglong8.dong@gmail.c=
om> wrote:
> > > > > > >
> > > > > > > From: Menglong Dong <imagedong@tencent.com>
> > > > > > >
> > > > > > > In tcp_retransmit_timer(), a window shrunk connection will be=
 regarded
> > > > > > > as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'.=
 This is not
> > > > > > > right all the time.
> > > > > > >
> > > > > > > The retransmits will become zero-window probes in tcp_retrans=
mit_timer()
> > > > > > > if the 'snd_wnd=3D=3D0'. Therefore, the icsk->icsk_rto will c=
ome up to
> > > > > > > TCP_RTO_MAX sooner or later.
> > > > > > >
> > > > > > > However, the timer is not precise enough, as it base on timer=
 wheel.
> > > > > > > Sorry that I am not good at timer, but I know the concept of =
time-wheel.
> > > > > > > The longer of the timer, the rougher it will be. So the timeo=
ut is not
> > > > > > > triggered after TCP_RTO_MAX, but 122877ms as I tested.
> > > > > > >
> > > > > > > Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is =
always true
> > > > > > > once the RTO come up to TCP_RTO_MAX.
> > > > > > >
> > > > > > > Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->ic=
sk_timeout',
> > > > > > > which is exact the timestamp of the timeout.
> > > > > > >
> > > > > > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > > > > > ---
> > > > > > >  net/ipv4/tcp_timer.c | 6 +++++-
> > > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > > > > > > index 470f581eedd4..3a20db15a186 100644
> > > > > > > --- a/net/ipv4/tcp_timer.c
> > > > > > > +++ b/net/ipv4/tcp_timer.c
> > > > > > > @@ -511,7 +511,11 @@ void tcp_retransmit_timer(struct sock *s=
k)
> > > > > > >                                             tp->snd_una, tp->=
snd_nxt);
> > > > > > >                 }
> > > > > > >  #endif
> > > > > > > -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_=
MAX) {
> > > > > > > +               /* It's a little rough here, we regard any va=
lid packet that
> > > > > > > +                * update tp->rcv_tstamp as the reply of the =
retransmitted
> > > > > > > +                * packet.
> > > > > > > +                */
> > > > > > > +               if ((u32)icsk->icsk_timeout - tp->rcv_tstamp =
> TCP_RTO_MAX) {
> > > > > > >                         tcp_write_err(sk);
> > > > > > >                         goto out;
> > > > > > >                 }

One potential pre-existing issue with this logic: if the connection is
restarting from idle, then tp->rcv_tstamp could already be a long time
(minutes or hours) in the past even on the first RTO, in which case
the very first RTO that found a zero tp->snd_wnd  would find this
check returns true, and would destroy the connection immediately. This
seems extremely brittle.

AFAICT it would be safer to replace this logic with a call to the
standard tcp_write_timeout() logic that has a more robust check to see
if the connection should be destroyed.

neal

