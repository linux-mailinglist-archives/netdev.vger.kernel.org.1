Return-Path: <netdev+bounces-36966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD82E7B2B18
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 07:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 36AC72818F1
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 05:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161917D8;
	Fri, 29 Sep 2023 05:15:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FDD399
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 05:15:47 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57936195
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 22:15:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405459d9a96so62175e9.0
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 22:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695964541; x=1696569341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efBzdUz4E1mRCTntOxAJpAn2plhV/lB8ZB1zgWlI4Es=;
        b=qFZsdQ2/AJsIWGzh5XHhi3g39MBk/Xnoyz/gYvIk30VzlbI7LT8g1AZBv44DPAGCT6
         wceMos8tzUddDYgpdgBtapeGs6yU+V+MBtQm367Cg7Vw71FQsWpdFQ6chNVmhkjuVuwg
         bp+VWfZBk1pzbKWVvRvzRu2GxK1ltWv9ZoYGhtEvjBSwEjaYa2wcUiH18va7FlPZjFlK
         BTxY+esuFz8Q9Lbg8564RlMbovuXrp/7KRrNpQH4CWBQ9Q2hXtaHpC6ngQOYedBEtbax
         s2/j6Jtaob2BWMjF365ocfscZ8YSDi9g6UYkWlW9LmYaOC+kHIdkKymRQzynGTtEalrt
         byOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695964541; x=1696569341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efBzdUz4E1mRCTntOxAJpAn2plhV/lB8ZB1zgWlI4Es=;
        b=VzzeF25NLPdqzZricd8dzIzy9CxWVXWJTIsxd++X3IPQtqo75ec21fH0kncvcft4PI
         1Y/Ve71GLlnG25txZAkRuxRM/kgVS0YTOXOlcMnIRS3WQ5+K8kDK9Z6LB75/92NmQ0a8
         N78FYqXs7eUQfB4aZc5YJSNytH3Frzu4tGW2GxbckKhW/ELqq91tgJoKGUv/NXErDp7v
         JHa1AeM2yYGtwoyfEmWxufRezpqlCAfQl25DIJPNtDz6YLh6e2daWKaBXjizICAow1Pf
         L665Rg5WFfxDGaJLYuR0L6phxt040dxnGCDDfIQonUMLHRmxpk4mzo9C2HVkTiKIVFld
         RtKg==
X-Gm-Message-State: AOJu0Yyz7owzEWAtt3kSKOjwaJCLbI0ZAwCMHSa295ZE5eCKLJPJw0YW
	YMmW62NlZa+WhEhwAOBZP9UMg7Q2a1cY7jOZL7U1
X-Google-Smtp-Source: AGHT+IGGDGKqptEZv/WnwMLswdZ9PPXni90i065Pu7UM1Bhewpjh98RbfvPJk4nt3UhWJdYSpmWImk/dGRj31n/QaT0=
X-Received: by 2002:a7b:c445:0:b0:400:46db:1bf2 with SMTP id
 l5-20020a7bc445000000b0040046db1bf2mr431969wmi.2.1695964540632; Thu, 28 Sep
 2023 22:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929023737.1610865-1-maheshb@google.com>
In-Reply-To: <20230929023737.1610865-1-maheshb@google.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 28 Sep 2023 22:15:27 -0700
Message-ID: <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] time: add ktime_get_cycles64() api
To: Mahesh Bandewar <maheshb@google.com>
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 7:37=E2=80=AFPM Mahesh Bandewar <maheshb@google.com=
> wrote:
>
> add a method to retrieve raw cycles in the same fashion as there are
> ktime_get_* methods available for supported time-bases. The method
> continues using the 'struct timespec64' since the UAPI uses 'struct
> ptp_clock_time'.
>
> The caller can perform operation equivalent of timespec64_to_ns() to
> retrieve raw-cycles value. The precision loss because of this conversion
> should be none for 64 bit cycle counters and nominal at 96 bit counters
> (considering UAPI of s64 + u32 of 'struct ptp_clock_time).
>
> Signed-off-by: Mahesh Bandewar <maheshb@google.com>
> CC: John Stultz <jstultz@google.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: Richard Cochran <richardcochran@gmail.com>
> CC: netdev@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  include/linux/timekeeping.h |  1 +
>  kernel/time/timekeeping.c   | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> index fe1e467ba046..5537700ad113 100644
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -43,6 +43,7 @@ extern void ktime_get_ts64(struct timespec64 *ts);
>  extern void ktime_get_real_ts64(struct timespec64 *tv);
>  extern void ktime_get_coarse_ts64(struct timespec64 *ts);
>  extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
> +extern void ktime_get_cycles64(struct timespec64 *ts);
>
>  void getboottime64(struct timespec64 *ts);
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 266d02809dbb..35d603d21bd5 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -989,6 +989,30 @@ void ktime_get_ts64(struct timespec64 *ts)
>  }
>  EXPORT_SYMBOL_GPL(ktime_get_ts64);
>
> +/**
> + * ktime_get_cycles64 - get the raw clock cycles in timespec64 format
> + * @ts:                pointer to timespec variable
> + *
> + * This function converts the raw clock cycles into timespce64 format
> + * in the varibale pointed to by @ts
> + */
> +void ktime_get_cycles64(struct timespec64 *ts)
> +{
> +       struct timekeeper *tk =3D &tk_core.timekeeper;
> +       unsigned int seq;
> +       u64 now;
> +
> +       WARN_ON_ONCE(timekeeping_suspended);
> +
> +       do {
> +               seq =3D read_seqcount_begin(&tk_core.seq);
> +               now =3D tk_clock_read(&tk->tkr_mono);
> +       } while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +       *ts =3D ns_to_timespec64(now);
> +}

Hey Mahesh,
  Thanks for sending this out.  Unfortunately, I'm a bit confused by
this. It might be helpful to further explain what this would be used
for in more detail?

Some aspects that are particularly unclear:
1) You seem to be trying to stuff cycle values into a timespec64,
which is not very intuitive (and a type error of sorts). It's not
clear /why/ that type is useful.

2) Depending on your clocksource, this would have very strange
wrapping behavior, so I'm not sure it is generally safe to use.

3) Nit: The interface is called ktime_get_cycles64 (timespec64
returning interfaces usually are postfixed with ts64).

I guess could you clarify why you need this instead of using
CLOCK_MONOTONIC_RAW which tries to abstract raw cycles in a way that
is safe and avoids wrapping across various clocksources?

thanks
-john

