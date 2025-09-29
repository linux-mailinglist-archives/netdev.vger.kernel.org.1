Return-Path: <netdev+bounces-227108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BC6BA8649
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 10:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E563A3790
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF0026D4C3;
	Mon, 29 Sep 2025 08:27:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA59266B52
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134436; cv=none; b=GvLhWdUJiHOALnRwndMlNUJ4yzhsxReb2Y+6bDwBgFHaWJgkWPQ7vBupkSCa7YwC2xWnuvcN52S5uoC0EzmhMuTyIyFvxb73RtnT8uChBEDdRxDH/fGkP49v5tjv7gnjJ3RrKq6hJ+4EXqp4fftKCe4RdEM+4QDNxdWclkyr/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134436; c=relaxed/simple;
	bh=3wEnJJupgz1SJm2E9By0j/0oQe0EV3tSedp0jhNUmw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4OxB36oh68gDuVVkXIEfRocYRM9NAwN+CvRlnCuCpKFWKh7kUVJw5iZaRuBKQQumtfbVeI2Cu2G7QZ7RJWxJ33cho1gHbLP8s5vNJo1JK1zw0Xw0CWxjgmAA6oTwJNkaBGSFfRaTCoktSUzSf9/hFpFwNDk0+CY4bcKBfZk9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-58d377d786bso3101712137.1
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 01:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759134430; x=1759739230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjEe7O8j7KCrjhzBmS059atyR4bTunLk3aQjDHMi0Mg=;
        b=r7W0CHt5i0UW5Bh41Aq5tTYExc4k7L0BKXUVGXNuMEw4q06E9uKZhamtfbOi3rmSx0
         1Ei3WF906BKH9N+hj8fUaT94HQPWmo6YpgVhGXuFoVvqhyRz1lUt05VkQKFsRB7Hlsgm
         K/DhI/FU0ktsaImhLFaLy25pho1UJE11qJHS25gzHGKU1hTNoGRmIt8NQauEQHXqSwSU
         3Izia5J6TbQgSR3CqQ7B1Go2+YpzRIu9Ro/3aOYd7V1eizhH97/X1TdMVxdDP5qj+ggi
         XM0buOS1Q8NvbfSM8qv1CG9vXTz3V/Syalhy8Y4yYjHu3ObAwZFt2yuPk0oaBJNNAjyC
         SpMA==
X-Forwarded-Encrypted: i=1; AJvYcCU6E9winmve+2lu8x/0mWOq08OYEJsXsY205tvyxZhExmKPV+DJcQonF5H2r70w0grqqI3hfZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnQ+bfc6Gmo9WpHtXcGkcXbozJ9/g1zclxOYxs2JLROspVgD3
	fIxQkuFtDRDLcbHdX1NPUT43rKB9Fj0kRTg0J5wLNz0+yyk3eq2eUYUw9ZETDSuL
X-Gm-Gg: ASbGncs9JDrnoiW9MBFSxn1v9suU7VidTiirJIne/vMQ6+lOPTis+23dRLMYw8dPb+Q
	exugeA3iedN7wFwyNq4zsRvggVXvGY3outtFMd6yEXIC1g7jAALbE1p7RuRqgGQdBKswwCWIMA7
	VZM9WTheVfXPOh3DnW3/qj9lURTqhMUZw6s9lj/gNPc5gzDfU9UZTogpwrZk39xCLPo30MUyQIq
	9c3zB1AZlReTDu4l8BFpkNG9lLacObQItaVywEswimLDthlGs0ZljTkXB4Tpj8WEol+T4pVxAyK
	BW1EFMX4bIxtSRwiG/jYQyCb3yGLEoxr6ANXrnzRKYTXJol2xSXH6RJkLwfW+204bw6zgwUb/kc
	o/XsULSUc52AKPsq4UwtoF7WbcyIAej++xbrqMfJ8C0KxJZFhYsxHt/k4m1HQ8UhCJjzPoag=
X-Google-Smtp-Source: AGHT+IEKgPtiigQEjBto9Ak+v0KQIrI2M8b0rGjDtd7WbL73xL5Fu/dAa6AmXVzmX11iWYoxYDlBfw==
X-Received: by 2002:a05:6102:b03:b0:5a8:4256:1f14 with SMTP id ada2fe7eead31-5acd94bd965mr6174918137.35.1759134430049;
        Mon, 29 Sep 2025 01:27:10 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916dadfe156sm2211492241.19.2025.09.29.01.27.09
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 01:27:09 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-890190d9f89so2192740241.2
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 01:27:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgpU3Jnqphww8YP2C+wr9ZTYn8g29WUjOswGHSUEZjyrbTovNDvY8THkbuQOYYwsSzZJnJuV4=@vger.kernel.org
X-Received: by 2002:a05:6102:d90:b0:5a4:420c:6f94 with SMTP id
 ada2fe7eead31-5accbcdfbdfmr6816724137.4.1759134429370; Mon, 29 Sep 2025
 01:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756998732.git.geert+renesas@glider.be> <ee4def57eb68dd2c32969c678ea916d2233636ed.1756998732.git.geert+renesas@glider.be>
 <082d5554-7dae-4ff4-bbbe-853268865025@lunn.ch> <CAMuHMdU96u41ESayKOa9Z+fy2EvLCbKSNg256N5XZMJMB+9W6A@mail.gmail.com>
 <c1f6fb82-9188-48ed-9763-712afa71c481@lunn.ch> <20250905184103.GA1887882@ragnatech.se>
 <CAMuHMdU=Q6AZcryj1ZBGW+5F+iYvZCL=Eg0yPw0B4jnczmA8nw@mail.gmail.com>
In-Reply-To: <CAMuHMdU=Q6AZcryj1ZBGW+5F+iYvZCL=Eg0yPw0B4jnczmA8nw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 10:26:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7+F-VdNw+LLCs_WPUsFVNnbsCT-wompswecEmipmhqA@mail.gmail.com>
X-Gm-Features: AS18NWC4L73fMvbY7JVbl7jU9THAB7wi-kzKLyAei1Oc0zvFvsC0lPY-ku9gbpA
Message-ID: <CAMuHMdW7+F-VdNw+LLCs_WPUsFVNnbsCT-wompswecEmipmhqA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] sh_eth: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, 
	Markus Schneider-Pargmann <msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Sept 2025 at 16:36, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
> On Fri, 5 Sept 2025 at 20:41, Niklas S=C3=B6derlund
> <niklas.soderlund@ragnatech.se> wrote:
> > On 2025-09-05 13:57:05 +0200, Andrew Lunn wrote:
> > > > You cannot enter system sleep without CONFIG_PM_SLEEP, so enabling
> > > > WoL would be pointless.
> > >
> > > Yet get_wol will return WoL can be used, and set_wol will allow you t=
o
> > > configure it. It seems like EOPNOTSUPP would be better.
> >
> > Out of curiosity. Are you suggesting a compile time check/construct for
> > CONFIG_PM_SLEEP be added in the driver itself, or in ethtool_set_wol()
> > and ethtool_get_wol() in net/ethtool/ioctl.c to complement the
> >
> >     if (!dev->ethtool_ops->get_wol || !dev->ethtool_ops->set_wol)
> >         return -EOPNOTSUPP;
> >
> > checks already there? To always return EOPNOTSUPP if PM_SLEEP is not
> > selected?
>
> Iff we want to go that route, I'd vote for handling it in common code.
> Still, there is no guarantee that WoL will actually work, as on
> some systems it may depend on the firmware, too.  E.g. on ARM
> systems with PSCI, the SoC may be powered down during s2ram, so
> there is no guarantee that any of the wake-up sources shown in
> /sys/kernel/debug/wakeup_sources can actually wake up the system.
> I tried having a mechanism to describe that in DT, but it was rejected.

(oops, forgot to press "send" in an old draft)

Discovering commit af8dbf9c6aa8972f ("schemas: wakeup-source:
Possibility for system states") in dt-schema.git, there seems to
be hope!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

