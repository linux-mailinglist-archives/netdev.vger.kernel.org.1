Return-Path: <netdev+bounces-36978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B827B2C6E
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 08:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 48E251C20A5C
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 06:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E8188;
	Fri, 29 Sep 2023 06:35:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360717F3
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:35:07 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBC91A7
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 23:35:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77574c2cffdso13376385a.0
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 23:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695969304; x=1696574104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DfmXp2T2GKuyyceQ+OhxXHG99X5ZXI8F9X8Rh+6G4E=;
        b=BsRbBc8p/fCut5uRlcEHFhTkwa76P0nI968Z0jQk69RrcsBl+Ne5J6yEOqqUQpN02g
         mAmgSiUv75objR7Ne+gRLP4fS0HCc3SV9YVrA3R+iaPLJ510QTzUGlXl0AD1L+j2/qsw
         GnwHVoXU+kZgXaejhaKgNyg0EAZNF3fnOx020SwOGWRFiqpyufbWD/iZ5JJ9CocWWgUh
         i44zK4dfsggk60Lg0zOuOFHn35p28bzDNoHFgSpOj7xpfF3aWkT8OyQT5u6INiTpMwJb
         XMfehxtRTWmzFM029GcDwhSPwHK6G1v7XpMgfxK5oAcg+C/arXpdDc0guUpYxMBV3kX8
         TCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695969304; x=1696574104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DfmXp2T2GKuyyceQ+OhxXHG99X5ZXI8F9X8Rh+6G4E=;
        b=mb1VinQ/lFA82KfMhVGl/NKxGJM/0TX+OhMv8X6olLxYXQr9pedx3foGKgCaDjVa2K
         OS4jGG/ARYuzL1ADJjeuqAmxVw4MG91wGv5hGg80kViYdTjmBXbLi20gti1aNsiEBj+H
         9YCYDAibuKIxbtXEuLNHrCMsoEZpyancex7f2A8WA2cWz1EGyn99UNKU0j6zRsuhP1kO
         8CeePExjYQhBfEelI2WOZjlFneVG73KtC0raGErLK1pEcpxiNDh6zHBxJwvG8suCQJPr
         hxgIaxsUn/+OpJmL8fZtycR+rPZ38K+dK08VU8DdrkgiBqAeg/JvpCppbCA5rvsaVv6S
         /BCA==
X-Gm-Message-State: AOJu0YyPN5DjgisK1HCcawnTFvu7QUejLCc/0zkGspg4+/vCWrZH9911
	RjjY+KubEFTESUXIwJ/AdA61PTIS9OJK0hRuOg9Hqg==
X-Google-Smtp-Source: AGHT+IH4zDENmAMWoN1CplV5Qya5xoVVaDg6Z7DhDFS6UI4vcZXJX1n0s1bPIh/K+XQB1aSFeWgLRgb0e6T7UOQrxUs=
X-Received: by 2002:a05:620a:4611:b0:762:3567:a64c with SMTP id
 br17-20020a05620a461100b007623567a64cmr3338763qkb.11.1695969304568; Thu, 28
 Sep 2023 23:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929023737.1610865-1-maheshb@google.com> <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
In-Reply-To: <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Thu, 28 Sep 2023 23:34:37 -0700
Message-ID: <CAF2d9jgeGLCzbFZhptGzpUnmMgLaRysyzBmpZ+dK4sxWdmR5ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] time: add ktime_get_cycles64() api
To: John Stultz <jstultz@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 10:15=E2=80=AFPM John Stultz <jstultz@google.com> w=
rote:
>
> On Thu, Sep 28, 2023 at 7:37=E2=80=AFPM Mahesh Bandewar <maheshb@google.c=
om> wrote:
> >
> > add a method to retrieve raw cycles in the same fashion as there are
> > ktime_get_* methods available for supported time-bases. The method
> > continues using the 'struct timespec64' since the UAPI uses 'struct
> > ptp_clock_time'.
> >
> > The caller can perform operation equivalent of timespec64_to_ns() to
> > retrieve raw-cycles value. The precision loss because of this conversio=
n
> > should be none for 64 bit cycle counters and nominal at 96 bit counters
> > (considering UAPI of s64 + u32 of 'struct ptp_clock_time).
> >
> > Signed-off-by: Mahesh Bandewar <maheshb@google.com>
> > CC: John Stultz <jstultz@google.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Stephen Boyd <sboyd@kernel.org>
> > CC: Richard Cochran <richardcochran@gmail.com>
> > CC: netdev@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  include/linux/timekeeping.h |  1 +
> >  kernel/time/timekeeping.c   | 24 ++++++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> > index fe1e467ba046..5537700ad113 100644
> > --- a/include/linux/timekeeping.h
> > +++ b/include/linux/timekeeping.h
> > @@ -43,6 +43,7 @@ extern void ktime_get_ts64(struct timespec64 *ts);
> >  extern void ktime_get_real_ts64(struct timespec64 *tv);
> >  extern void ktime_get_coarse_ts64(struct timespec64 *ts);
> >  extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
> > +extern void ktime_get_cycles64(struct timespec64 *ts);
> >
> >  void getboottime64(struct timespec64 *ts);
> >
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index 266d02809dbb..35d603d21bd5 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -989,6 +989,30 @@ void ktime_get_ts64(struct timespec64 *ts)
> >  }
> >  EXPORT_SYMBOL_GPL(ktime_get_ts64);
> >
> > +/**
> > + * ktime_get_cycles64 - get the raw clock cycles in timespec64 format
> > + * @ts:                pointer to timespec variable
> > + *
> > + * This function converts the raw clock cycles into timespce64 format
> > + * in the varibale pointed to by @ts
> > + */
> > +void ktime_get_cycles64(struct timespec64 *ts)
> > +{
> > +       struct timekeeper *tk =3D &tk_core.timekeeper;
> > +       unsigned int seq;
> > +       u64 now;
> > +
> > +       WARN_ON_ONCE(timekeeping_suspended);
> > +
> > +       do {
> > +               seq =3D read_seqcount_begin(&tk_core.seq);
> > +               now =3D tk_clock_read(&tk->tkr_mono);
> > +       } while (read_seqcount_retry(&tk_core.seq, seq));
> > +
> > +       *ts =3D ns_to_timespec64(now);
> > +}
>
> Hey Mahesh,
>   Thanks for sending this out.  Unfortunately, I'm a bit confused by
> this. It might be helpful to further explain what this would be used
> for in more detail?
>
Thanks for looking at this John. I think my cover-letter wasn't sent
to all reviewers and that's my mistake.

> Some aspects that are particularly unclear:
> 1) You seem to be trying to stuff cycle values into a timespec64,
> which is not very intuitive (and a type error of sorts). It's not
> clear /why/ that type is useful.
>
The primary idea is to build a PTP API similar to gettimex64() that
gives us a sandwich timestamp of a given timebase instead of just
sys-time. Since sys-time is disciplined (adjustment / steps), it's not
really suitable for all possible use cases. For the same reasons
CLOCK_MONOTONIC is also not suitable in a subset of use cases while
some do want to use it. So this API gives user a choice to select the
timebase. The ioctl() interface uses 'struct ptp_clock_time' (similar
to timespec64) hence the interface.

> 2) Depending on your clocksource, this would have very strange
> wrapping behavior, so I'm not sure it is generally safe to use.
>
The uapi does provide other alternatives like sys, mono, mono-raw
along with raw-cycles and users can choose.

> 3) Nit: The interface is called ktime_get_cycles64 (timespec64
> returning interfaces usually are postfixed with ts64).
>
Ah, thanks for the explanation. I can change to comply with the
convention. Does ktime_get_cycles_ts64() make more sense?

> I guess could you clarify why you need this instead of using
> CLOCK_MONOTONIC_RAW which tries to abstract raw cycles in a way that
> is safe and avoids wrapping across various clocksources?
>
My impression was that CLOCK_MONOTONIC_RAW (as the same suggests) does
provide you the raw / undisciplined cycles. However, code like below
does show that monotonic-raw is subjected to certain changes.
"""
int do_adjtimex(struct __kernel_timex *txc)
{
      [...]
        /*
         * The timekeeper keeps its own mult values for the currently
         * active clocksource. These value will be adjusted via NTP
         * to counteract clock drifting.
         */
        tk->tkr_mono.mult =3D clock->mult;
        tk->tkr_raw.mult =3D clock->mult;
        tk->ntp_err_mult =3D 0;
        tk->skip_second_overflow =3D 0;
}
"""
and that was the reason why I have added raw-cycles as another option.
Of course the user can always choose mono-raw if it satisfies their
use-case.

> thanks
> -john

