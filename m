Return-Path: <netdev+bounces-36979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5363A7B2CAC
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 08:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 00281283006
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 06:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547B9C125;
	Fri, 29 Sep 2023 06:57:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8582119
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:57:01 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EE41AA
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 23:57:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4053f24c900so40315e9.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 23:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695970619; x=1696575419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5nybL4dvTURYZgr23LqoAjNxEI6cIl7C36UD+zafSo=;
        b=MxK/gmz16h8Y7usf0+eDPOpOPRbUE6Q0xZHUBWDBBGZsfpsmtCRW5i9gInQPXkA0DT
         v8ViqKLIlixp/TNp6PM4aTdvAFYVI7U43yTlm9V1VqFRukXumo8xBa8iT1bHcBZNClNi
         RtNw0ORsjEqK743kggR9BP9B0vsQ67k14ZTI4cIEx+fo79e0W8DG2zOttpBdQCPNibkg
         L1BZAXfk7irLt3Wi116JLDSmvfUowFBpsaA4t0gQ1Xk2SA3iInBSSesgm5QbjBd1pOYL
         tE3VCHKcEBUq6k9Si9f8G1xhA//+SEsw0wIpKWWXibRIgwOI0wZJeAaxAr+VHG7Of9Hp
         /CKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695970619; x=1696575419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5nybL4dvTURYZgr23LqoAjNxEI6cIl7C36UD+zafSo=;
        b=HHknWG+KKSDqWMzdy5ldKKv52myn8i4HBA+QxZtgSAU7p0xMs/5baRos5SANeCOPH8
         bxtfGcyiacoI9gKXNGEZuTCaaGrKbBGyWU+6Q0icNZ+0tXgduBZ2XX/I1v52PkjjpHAk
         DbaCjhF0X7FoAInbMp0DdirIpZGLuHqsuLCtx6McDpGahp+o5u3nwMJHlnxG2FvxeUXE
         DiNX8/GEsQaFHPIq0VGqLxHRRbnQnfZ6mMB75BPaCrBl0m61VcTMb1AmtO5sFdnR+s1g
         V9Jm8Gwi5HiyfsMyV25gzKxQpAapag8YdRKumI0JeJdhij5YUXh6zJCwTSMgZrbkDDlD
         DmyA==
X-Gm-Message-State: AOJu0YwtMHYjhEVfV7NlEeB87PTuYaA3w48HAvxcn9CYQ0kajpmlxxZP
	GzImrJWPJMdCXdd1SkWIcjO0cgI34xScufcGCsTG
X-Google-Smtp-Source: AGHT+IESudEEHlPoiDYpwHnJVQRlH9wRebcTmOu/1slgAEgwniLCINMpXv2N40IrlQMDzNo0mmRUP1Bv2XbHYaM/5Ic=
X-Received: by 2002:a05:600c:34c8:b0:405:38d1:e146 with SMTP id
 d8-20020a05600c34c800b0040538d1e146mr443186wmq.4.1695970618685; Thu, 28 Sep
 2023 23:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929023737.1610865-1-maheshb@google.com> <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
 <CAF2d9jgeGLCzbFZhptGzpUnmMgLaRysyzBmpZ+dK4sxWdmR5ZQ@mail.gmail.com>
In-Reply-To: <CAF2d9jgeGLCzbFZhptGzpUnmMgLaRysyzBmpZ+dK4sxWdmR5ZQ@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 28 Sep 2023 23:56:46 -0700
Message-ID: <CANDhNCro+AQum3eSmKK5OTNik2E0cFxV_reCQg0+_uTubHaDsA@mail.gmail.com>
Subject: Re: [PATCH 1/4] time: add ktime_get_cycles64() api
To: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
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

On Thu, Sep 28, 2023 at 11:35=E2=80=AFPM Mahesh Bandewar (=E0=A4=AE=E0=A4=
=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=
=BE=E0=A4=B0)
<maheshb@google.com> wrote:
>
> On Thu, Sep 28, 2023 at 10:15=E2=80=AFPM John Stultz <jstultz@google.com>=
 wrote:
> >
> >   Thanks for sending this out.  Unfortunately, I'm a bit confused by
> > this. It might be helpful to further explain what this would be used
> > for in more detail?
> >
> Thanks for looking at this John. I think my cover-letter wasn't sent
> to all reviewers and that's my mistake.

No worries, I was able to find it on lore. Though it looks like your
mail threading isn't quite right?


> > 2) Depending on your clocksource, this would have very strange
> > wrapping behavior, so I'm not sure it is generally safe to use.
> >
> The uapi does provide other alternatives like sys, mono, mono-raw
> along with raw-cycles and users can choose.

Sure, but how does userland know if it's safe to use raw cycles? How
do we avoid userland applications written against raw cycles from
breaking if they run on a different machine?
To me this doesn't feel like the interface has been abstracted enough.

> > 3) Nit: The interface is called ktime_get_cycles64 (timespec64
> > returning interfaces usually are postfixed with ts64).
> >
> Ah, thanks for the explanation. I can change to comply with the
> convention. Does ktime_get_cycles_ts64() make more sense?

Maybe a little (it at least looks consistent), but not really if
you're sticking raw cycles in the timespec :)

> > I guess could you clarify why you need this instead of using
> > CLOCK_MONOTONIC_RAW which tries to abstract raw cycles in a way that
> > is safe and avoids wrapping across various clocksources?
> >
> My impression was that CLOCK_MONOTONIC_RAW (as the same suggests) does
> provide you the raw / undisciplined cycles. However, code like below
> does show that monotonic-raw is subjected to certain changes.
> """
> int do_adjtimex(struct __kernel_timex *txc)
> {
>       [...]

Err. The bit below is from tk_setup_internals() not do_adjtimex(), no?

>         /*
>          * The timekeeper keeps its own mult values for the currently
>          * active clocksource. These value will be adjusted via NTP
>          * to counteract clock drifting.
>          */
>         tk->tkr_mono.mult =3D clock->mult;
>         tk->tkr_raw.mult =3D clock->mult;
>         tk->ntp_err_mult =3D 0;
>         tk->skip_second_overflow =3D 0;

So the comment is correct, except for the tkr_raw.mult value (I can
see how that is confusing). The raw mult is set to the clocksource
mult value and should not modified (unless the clocksource changes).

> """
> and that was the reason why I have added raw-cycles as another option.
> Of course the user can always choose mono-raw if it satisfies their
> use-case.

Having raw monotonic as an option seems reasonable to me (as it was
introduced to provide a generic abstraction for logic that was using
raw TSC values in an unportable way).

But the raw cycles interface still worries me, as I want to make sure
we're not creating user visible interfaces that expose raw hardware
details (making it very difficult to maintain long term).

thanks
-john

