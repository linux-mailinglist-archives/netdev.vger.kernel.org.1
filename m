Return-Path: <netdev+bounces-37545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D89F7B5E02
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 02:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EC5C62815CF
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 00:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86194362;
	Tue,  3 Oct 2023 00:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6F5360
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 00:13:06 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47D2D3
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 17:13:03 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-65af726775eso2766676d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 17:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696291983; x=1696896783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpzQO8HbLLTPu6D1/OgydzIxmygx7jcnUo/6D03H5hI=;
        b=X7bdRYY0/rynfyoAhSoUh9L8FwvVIleMHYV3oQeM67EEXIdVOiZSw5tSmyocEinHJ/
         xUsV6xnHtdy17N3j8z+ur22UZ0O7f66mdU/bTk+8dFqX/Mj+aU601qu/01XqU9PTh7Ce
         ScpKU6p0MtpyF9T2OCVkmv861WPlKJ/qN16xiJ1kM67yrY7aLTz7oY2tFCWvfbAOoOIP
         1+D60iYy06D0eeY9c4Icf22ebFxkQoQoW9d9ULLRqB/FF998eWlTsouqWysAGKd5o8dc
         o45LbNm/2gVyWoSip9j/wpUgkSSP9ep5d+6uXaWDsLQIiEKb2oq0ziXUIkqxS4f0Um4o
         yU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696291983; x=1696896783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpzQO8HbLLTPu6D1/OgydzIxmygx7jcnUo/6D03H5hI=;
        b=DbI0mGCc69nrX0ROe5nMLZ2tEow9B6nRSTnCUn2AAraGK5NmM7N9ddmCrfbQMSgsKm
         5jgborGK1MLWCIpFTPmN5BCNRFgsOAzohe/SFGEd1m4TeL0LM/c1xO9+kVhTMYjkWvR5
         TGjBXjdwyFlW6AmU40D7/FPWdtV/NxC64hzqm/XF8Ep/RGhD+9RsmB5DkMII7PyUlt1J
         bgfSa8j9gppj6nWCKEuBK3UqUeZa3Gmi3wTL8kaaQZdPHPPcz1p2UpfuFQugwCtFlCVP
         7UtHlnhIz+FWbzJGmHoaEQvkXfh4xB01/yMLpJcjIPBq6HZBF0+JGifokKgQOi/KNSH9
         Eywg==
X-Gm-Message-State: AOJu0YzxwwzHS5VNbuCOvcG5n2LRwtDrxY56dqw8EXQccPyCKklta2VM
	P8JBBVM3azgbOtn59T1rqh2j4pjNqzSp4m5Uw1ef1Q==
X-Google-Smtp-Source: AGHT+IEu+vHhbZ59joJNhLRB31A5U3wMDk5lul1uPHoBj1/3uG4Jv9CQ2ahJSglvAzIhUIsJIRbZZ1sRTx+IlMEUupQ=
X-Received: by 2002:a0c:aad5:0:b0:65b:92c:3eee with SMTP id
 g21-20020a0caad5000000b0065b092c3eeemr1505639qvb.15.1696291982695; Mon, 02
 Oct 2023 17:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929023737.1610865-1-maheshb@google.com> <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
 <CAF2d9jgeGLCzbFZhptGzpUnmMgLaRysyzBmpZ+dK4sxWdmR5ZQ@mail.gmail.com>
 <CANDhNCro+AQum3eSmKK5OTNik2E0cFxV_reCQg0+_uTubHaDsA@mail.gmail.com> <CANDhNCryn8TjJZRdCvVUj88pakHSUvtyN53byjmAcyowKj5mcA@mail.gmail.com>
In-Reply-To: <CANDhNCryn8TjJZRdCvVUj88pakHSUvtyN53byjmAcyowKj5mcA@mail.gmail.com>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Mon, 2 Oct 2023 17:12:36 -0700
Message-ID: <CAF2d9jg4Oxm3NwDuh21eeKC5-m7umZM3XLuxUKcFkchFjTgTtQ@mail.gmail.com>
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

On Fri, Sep 29, 2023 at 12:07=E2=80=AFAM John Stultz <jstultz@google.com> w=
rote:
>
> On Thu, Sep 28, 2023 at 11:56=E2=80=AFPM John Stultz <jstultz@google.com>=
 wrote:
> > On Thu, Sep 28, 2023 at 11:35=E2=80=AFPM Mahesh Bandewar (=E0=A4=AE=E0=
=A4=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=
=A4=BE=E0=A4=B0)
> > <maheshb@google.com> wrote:
> > > On Thu, Sep 28, 2023 at 10:15=E2=80=AFPM John Stultz <jstultz@google.=
com> wrote:
> > > > 3) Nit: The interface is called ktime_get_cycles64 (timespec64
> > > > returning interfaces usually are postfixed with ts64).
> > > >
> > > Ah, thanks for the explanation. I can change to comply with the
> > > convention. Does ktime_get_cycles_ts64() make more sense?
> >
> > Maybe a little (it at least looks consistent), but not really if
> > you're sticking raw cycles in the timespec :)
> >
>
> Despite my concerns that it's a bad idea, If one was going to expose
> raw cycles from the timekeeping core, I'd suggest doing so directly as
> a u64 (`u64 ktime_get_cycles(void)`).
>
> That may mean widening (or maybe using a union in) your PTP ioctl data
> structure to have a explicit cycles field.
> Or introducing a separate ioctl that deals with cycles instead of timespe=
c64s.
>
> Squeezing data into types that are canonically used for something else
> should always be avoided if possible (there are some cases where
> you're stuck with an existing interface, but that's not the case
> here).
>
> But I still think we should avoid exporting the raw cycle values
> unless there is some extremely strong argument for it (and if we can,
> they should be abstracted into some sort of cookie value to avoid
> userland using it as a raw clock).
>
Thanks for the input John. This change is basically to address the API
gap and allow it to give a user-given timebase for the sandwich time.
I will remove this RAW-CYCLES option for now. If it's deemed
necessary, we can always add it later into the same API.

> thanks
> -john

