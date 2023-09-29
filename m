Return-Path: <netdev+bounces-36981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06B77B2CD8
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 09:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ECEE4282F90
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 07:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D44C133;
	Fri, 29 Sep 2023 07:07:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9DD3D78
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:07:02 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DDA1A8
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 00:07:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so11052a12.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 00:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695971219; x=1696576019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VDhsG3RvqxurmnHIUU3NyMw2Ckx5kzAqe1lOg3jvtw=;
        b=yqOdf/Xe738+uS/bdp7sa/4PaONqHb7OVBN4HkvAdt2ijif6Y4+bm7V9iAD0igjNZs
         cONxpOdz/qUyZ9mlxY5Ckj6fFtCsMEWx98jqa6FmwoOy/RwkPI+leXv9N3RiQ1H21cQU
         l6Z9APHuPqwGsn4re+yEqh9525Iiz9yA49UrF1bebORvtZa4K/jPm7IzPFFniMpYT2Q5
         YMdEUHpkSs33IR3lo97OyCLZheebi7H3a+BQV6zAqViYxonj5rJuo2KjeYunod79Cov9
         zd6+I2CX8rK1nLLWvYMqmB+nmEW6yYxWIPT7qFfsTId4bjF3G+JvNtjY9HcCXWNW3epU
         pGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695971219; x=1696576019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VDhsG3RvqxurmnHIUU3NyMw2Ckx5kzAqe1lOg3jvtw=;
        b=fVfAxt6qXeIEfGDhHHeoz5jfEEV3b5bi8tmFz7T3VaoXH5d+zwfV49/DqI59svPUIq
         OQbZBkxJt8J0SDh7G0LuirKyrjgfXx+xsSDDw/bRokY5joWnA2T91VvLd619BaCsKEbQ
         V6AdhqPsciZhOMXed6QCvQOqg9sX9hhb6kE4ZECfx1qTPF5HRNwoxpI/2rxvY1Bz/9Se
         eiIzMUlQhyNRtD8VHeCv0IkqUfdE9U8Y18hJihDaWZz/iFGJCB3s6epPCfqX2T++EB/m
         yYpcWJdMnYhOkpqGjinQY3A+7Xi5+YQyBaaSbVygXE/Hb2UuPTWt5kqCTfAiLKP1M786
         dU1g==
X-Gm-Message-State: AOJu0YxIzp8KtJ3nqL6k4tqgSeanFEZvOxFBtlvY6giV1boMb2x420R/
	X4CvcafBz7s44g7KRBtOgaS4SbVD2KWwnUKs5M0d
X-Google-Smtp-Source: AGHT+IFnfnJXkiewY/umtolhOz81iE67AbIHb6KpIZ6rJ1t3VwVdF7zYwbMSa8r53kwey8FGA0L57aj/oWvhXqVeODE=
X-Received: by 2002:a50:aa93:0:b0:52e:f99a:b5f8 with SMTP id
 q19-20020a50aa93000000b0052ef99ab5f8mr493256edc.7.1695971219021; Fri, 29 Sep
 2023 00:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929023737.1610865-1-maheshb@google.com> <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
 <CAF2d9jgeGLCzbFZhptGzpUnmMgLaRysyzBmpZ+dK4sxWdmR5ZQ@mail.gmail.com> <CANDhNCro+AQum3eSmKK5OTNik2E0cFxV_reCQg0+_uTubHaDsA@mail.gmail.com>
In-Reply-To: <CANDhNCro+AQum3eSmKK5OTNik2E0cFxV_reCQg0+_uTubHaDsA@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 29 Sep 2023 00:06:46 -0700
Message-ID: <CANDhNCryn8TjJZRdCvVUj88pakHSUvtyN53byjmAcyowKj5mcA@mail.gmail.com>
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

On Thu, Sep 28, 2023 at 11:56=E2=80=AFPM John Stultz <jstultz@google.com> w=
rote:
> On Thu, Sep 28, 2023 at 11:35=E2=80=AFPM Mahesh Bandewar (=E0=A4=AE=E0=A4=
=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=
=BE=E0=A4=B0)
> <maheshb@google.com> wrote:
> > On Thu, Sep 28, 2023 at 10:15=E2=80=AFPM John Stultz <jstultz@google.co=
m> wrote:
> > > 3) Nit: The interface is called ktime_get_cycles64 (timespec64
> > > returning interfaces usually are postfixed with ts64).
> > >
> > Ah, thanks for the explanation. I can change to comply with the
> > convention. Does ktime_get_cycles_ts64() make more sense?
>
> Maybe a little (it at least looks consistent), but not really if
> you're sticking raw cycles in the timespec :)
>

Despite my concerns that it's a bad idea, If one was going to expose
raw cycles from the timekeeping core, I'd suggest doing so directly as
a u64 (`u64 ktime_get_cycles(void)`).

That may mean widening (or maybe using a union in) your PTP ioctl data
structure to have a explicit cycles field.
Or introducing a separate ioctl that deals with cycles instead of timespec6=
4s.

Squeezing data into types that are canonically used for something else
should always be avoided if possible (there are some cases where
you're stuck with an existing interface, but that's not the case
here).

But I still think we should avoid exporting the raw cycle values
unless there is some extremely strong argument for it (and if we can,
they should be abstracted into some sort of cookie value to avoid
userland using it as a raw clock).

thanks
-john

