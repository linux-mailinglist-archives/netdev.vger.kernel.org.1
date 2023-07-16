Return-Path: <netdev+bounces-18111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82E5754E67
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 12:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6537C281373
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 10:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F063BB;
	Sun, 16 Jul 2023 10:58:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D1EA1
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 10:58:29 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C6010FE
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 03:58:27 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so49952461fa.1
        for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 03:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689505105; x=1692097105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCbanyjPWw7wg8GH0dN5PyTlb5CiuUWTxnicJQNXHbM=;
        b=aLW6VFWlrPWXxOJUYy3beiUVjpzMtIgYfqwQ9bp7pv72xkICLAzYV6/caCMKC/WXYW
         Gpkgz9MMTSQ9iBjhTh0EgTgx92vPVcytU5DSdxeqwqPnOzzbxvlQPXQJ8E/Zdcw2zIgH
         GwPwc51VpsziJigC+OGt9fzWmimAnEUpKp/qvUz6bu/TMsd03pOZ7isQS335fawiHsK2
         lTKUBwZP7WEDQwIhgUK0t/VOiTDC6TfOIFcDrb86METzeAFuhqOOMUY5zpG3Zk3hh6Q4
         2vDHRo/kac+paLlvrEWrMw2XT4qFmT4Op0oCfBjaEUXU0wVAcEhWANl2SZ7JkbfDuwS0
         2WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689505105; x=1692097105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCbanyjPWw7wg8GH0dN5PyTlb5CiuUWTxnicJQNXHbM=;
        b=a/CLVGaJ6HTMCcznUxJvr/HfJZwWkcmVRK3O3tqf9F8qynRcUwG17Oxre/TJn1dqGf
         Q3cYqTL+gOnN1bT4SWnvL4iog8q7MonBvxxL5Y5aTAahYHxoAvpM9DuxcZZaf3xJ/vjM
         HzqvpSWO0GBeGnOapCl1evyAiwNb95RJbxpKjBMPAkgPlYr0bOvQk5Z706RpeBOkc4Es
         aWpzVC/+fgOTwh1u5WTURTGFvIir2kha31TkIbH9+dUdeUzOaCYLFchEPAMlvNw8PjEq
         sgkCLirn69cq2IuaSP/SR7DYNlnwb71yQbspbKj3PUaTkWwYGpdLGE+6unIsciNPbZS7
         rChA==
X-Gm-Message-State: ABy/qLaM1ZT+E9aUokcFhYv8m0Q9SafPkhyVrTa77gwKPLvVxG83CJXF
	YpggVKFiIADSYAdpagnDNpVMDbj6TpKxufGbf1eaPA==
X-Google-Smtp-Source: APBJJlG9KY0nqgKStS8Cj/QJYv2YnwextwQh6Qp0TTrsVN7UOiV7VRzjd+KhTjuBY7aqgmuxUOzxihVATqd0G4robx4=
X-Received: by 2002:a2e:868a:0:b0:2b6:9ab8:9031 with SMTP id
 l10-20020a2e868a000000b002b69ab89031mr6640280lji.16.1689505105319; Sun, 16
 Jul 2023 03:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713202123.231445-1-alex@shruggie.ro> <cad1d05d-acdd-454b-a9f8-06262cf8495b@lunn.ch>
 <CAH3L5QrtFwTqqFKjPrMFCz4JgUWOFWFUJXpN71Gyprcd33A7hg@mail.gmail.com> <ab0ca942-5e84-4663-a0ed-689f023624b6@lunn.ch>
In-Reply-To: <ab0ca942-5e84-4663-a0ed-689f023624b6@lunn.ch>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Sun, 16 Jul 2023 13:58:14 +0300
Message-ID: <CAH3L5QoyOnbLG=pegiAFj0kPkp-mC9edCewxq3OBdGE75+1Jhg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2 net-next] net: phy: mscc: add support for CLKOUT
 ctrl reg for VSC8531 and similar
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, olteanv@gmail.com, marius.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 15, 2023 at 1:27=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Jul 14, 2023 at 09:09:14AM +0300, Alexandru Ardelean wrote:
> > On Thu, Jul 13, 2023 at 11:35=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> w=
rote:
> > >
> > > > +set_reg:
> > > > +     mutex_lock(&phydev->lock);
> > > > +     rc =3D phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_GPIO,
> > > > +                           VSC8531_CLKOUT_CNTL, mask, set);
> > > > +     mutex_unlock(&phydev->lock);
> > >
> > > What is this mutex protecting?
> >
> > This was inspired by vsc85xx_edge_rate_cntl_set().
> > Which has the same format.

Good news.
Removing this mutex works on a 5.10 kernel, with no issues.

>
> phy_modify_paged() locks the MDIO bus while it swaps the page, so
> nothing else can use it. That also protects the read/modify/write.
>
> Nothing is modifying phydev, so the lock is not needed for that
> either.

I remembered what I was doing wrong in that version that had issues
with the lock.
I was doing some manual page changes, with
phy_base_read/()phy_base_write() functions, which are in this file.

These functions have a warning + dump_stack() for when the
"phydev->mdio.bus->mdio_lock" is not held).
That threw me off initially.

>
> > I'll re-test with this lock removed.
> > I may be misremembering (or maybe I did something silly at some
> > point), but there was a weird stack-trace warning before adding this
> > lock there.
> > This was with a 5.10.116 kernel version.
>
> This patch is for net-next, please test there.

I've been testing on a Renesas board CIP project.
Kernel version (on our board is actually 5.10.83 ; I get them confused
since 5.10.xxx seems to be used here-n-there).

The kernel is here:
https://github.com/renesas-rz/rz_linux-cip/tree/rz-5.10-cip3

I'm trying to backport some ARCH patches, so that the board boots up.
I "think" I'm half way there; now the kernel prints something to
console and then stops (that's progress from no prints).

Let's see if we get a different consensus on Rob't suggestion; this
patch may require a different V3 :)



>
> When testing for locking issues, and when doing development in
> general, it is a good idea to turn on CONFIG_PROVE_LOCKING and
> CONFIG_DEBUG_ATOMIC_SLEEP.
>
>         Andrew

