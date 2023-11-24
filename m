Return-Path: <netdev+bounces-50962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4267F8546
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 21:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB941C25DF6
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C8364C3;
	Fri, 24 Nov 2023 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1LcHPJrk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0577C19A3
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 12:48:22 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-423a125d23cso81431cf.1
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 12:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700858901; x=1701463701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFQWMpDN2F24cc/J03f4NVx2U6EwlQXtQnJp1TM3/K8=;
        b=1LcHPJrkSE6LmyHMrgDoIEpZNHn/ywCyZYHVujYiNCy8y8v5qEqT6rE/drq/47cIwa
         4yfcCQKfCCfSy+UnOyeX3+nAPOvRqPInA7EJWxm6m1GpsIsdUo733GMKcvRBufgfZjDa
         Hyi6KwukEDyLeESd6CtwH8oGuWPzbUaN0jrkPf6UfaWubZpx4FX8kBmN7V/DRglmIwl0
         NPcgFok1JYzrSMZp8Y5sVp4ms/ZycId2UIRAU1OJR5b8YPrarK1ipy/ATnbNqLvc57Mi
         HVCyuEohN3wMNlt6WJxkBQL9fUlQP85/c6ET6wYrQ2F/fPRcVMOzhQ3/+7fuUsrG992f
         vKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700858901; x=1701463701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFQWMpDN2F24cc/J03f4NVx2U6EwlQXtQnJp1TM3/K8=;
        b=ZwlvYl7oewT4Zbes1MSiHh9jRfhz9DZts29jfGbzpNnsPybE3moVke7ZMm+ONZ/bVp
         it2nZgLm4+uoKkthfJzRlnLAkMcRS+A9hBcWCDvNZQjkmBHbrBGpwHcnXyeHe1ZQowcP
         5L7bOIa6/g3FeUUvL1vmetB54hv4JwKK9B7XhnLfoGRjBy+tTEgTO7hbUgRJu5YC3RHc
         X+M8nL+P7Sinx2dS2s4kDyKy3EOnkk07+jIog1WGKbp74ZMpEvjREMon7swxQHGvhoum
         tQNxNwJ0CI0Nn/LmuhnybuuSRndchhljRU8+3TbRjLa9XfoME4afBSYm6Ofb9qI6zerK
         Zx0A==
X-Gm-Message-State: AOJu0YzR9ho6nYWpqn/cMIVHsKpGQL3O3QrQKRn7V7rnQbhLedYMD5aw
	zNKWJG519iOB1uP6wRRt0FbAay+CnSpDSefUADd2rw==
X-Google-Smtp-Source: AGHT+IFlw/BprWhMGyCnxPL0swEeuxm4RjdXSiWCk+/jHDaoAAmc3zBMtDvNW474MpL5i9yKSS1/AA2MWkWolILaYOk=
X-Received: by 2002:ac8:5885:0:b0:421:c8d7:58f1 with SMTP id
 t5-20020ac85885000000b00421c8d758f1mr705562qta.4.1700858900765; Fri, 24 Nov
 2023 12:48:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120220549.cvsz2ni3wj7mcukh@skbuf> <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
 <20231121094354.635ee8cd@kernel.org> <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
 <20231122140850.li2mvf6tpo3f2fhh@skbuf> <20231122085000.79f2d14c@kernel.org>
 <20231122165517.5cqqfor3zjqgyoow@skbuf> <20231122100142.338a2092@kernel.org>
 <20231123160056.070f3311@kmaincent-XPS-13-7390> <20231123093205.484356fc@kernel.org>
 <20231124154343.sr3ajyueoshke6tn@skbuf> <20231124183431.5d4cc189@kmaincent-XPS-13-7390>
In-Reply-To: <20231124183431.5d4cc189@kmaincent-XPS-13-7390>
From: Willem de Bruijn <willemb@google.com>
Date: Fri, 24 Nov 2023 15:47:43 -0500
Message-ID: <CA+FuTSfQgqQyBHSgx32Vdnxs4wgMSyB9yEpJTObS5t1iYFcWBA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
To: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Simon Horman <horms@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 12:34=E2=80=AFPM K=C3=B6ry Maincent
<kory.maincent@bootlin.com> wrote:
>
> On Fri, 24 Nov 2023 17:43:43 +0200
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> > On Thu, Nov 23, 2023 at 09:32:05AM -0800, Jakub Kicinski wrote:
> > > On Thu, Nov 23, 2023 at 04:00:56PM +0100, K=C3=B6ry Maincent wrote:
> > > > So, do we have a consensus? Vlad, do you agree on putting all under
> > > > ethtool?
> > > >
> > > > ETHTOOL_GET_TS_INFO will be in charge of replacing the SIOCGHWSTAMP
> > > > implementation. Need to add ETHTOOL_A_TSINFO_PHC_INDEX
> > > > ETHTOOL_A_TSINFO_QUALIFIER to the request.
> > > >
> > > > ETHTOOL_GET_TS_INFO will list all the hwtstamp provider (aka "{phc_=
index,
> > > > qualifier}") through the dumpit callback. I will add a filter to be=
 able
> > > > to list only the hwtstamp provider of one netdev.
> > > >
> > > > ETHTOOL_SET_TS_INFO will be in charge of replacing the SIOCSHWSTAMP
> > > > implementation.
> > >
> > > If not we can do a vote/poll? Maybe others don't find the configurati=
on
> > > of timestamping as confusing as me.
> >
> > If you mean the ETHTOOL_MSG_TSINFO_GET netlink message (ETHTOOL_GET_TS_=
INFO
> > is an ioctl), you're saying that you want to move the entire contents o=
f
> > SIOCGHWSTAMP there, by making the kernel call ndo_hwtstamp_get() in
> > addition to the existing __ethtool_get_ts_info()?
>
> Yes.
>
> > Yeah, I don't know, I don't have a real objection, I guess it's fine.
> >
> > What will be a bit of an "?!" moment for users is when ethtool gains
> > support for the SIOCGHWSTAMP/SIOCSHWSTAMP netlink replacements, but not
> > for the original ioctls. So hwstamp_ctl will be able to change timestam=
ping
> > configuration, but ethtool wouldn't - all on the same system. Unless
> > ethtool gains an ioctl fallback for a ioctl that was never down its all=
ey.
>
> Yes indeed. Would it break things if both ioctls and netlink can get and =
set
> the hwtstamps configuration? It is only configuration. Both happen under
> rtnl_lock it should be alright.
>
> The question is which hwtstamp provider will the original ioctls be able =
to
> change? Maybe the default one (MAC with phy whitelist) and only this one.
>
> > But by all means, still hold a poll if you want to. I would vote for
> > ethtool netlink, not because it's great, just because I don't have a
> > better alternative to propose.
>
> If you agree on that choice, let's go. Jakub and your are the most proact=
ive
> reviewers in this patch series. Willem you are the timestamping maintaine=
r do
> you also agree on this?

I don't have a strong opinion. Ethtool netlink SGTM.

For new network configuration we are moving away from ioctl towards
netlink in general.

Ethtool itself made this move, where the old ioctl way of things
continues to work, but will no longer be extended.

Since one of the APIs we use already uses ethtool, converting the
other two there makes sense to me.

I'm not familiar enough with configuring CAN or wireless to know
whether it would pose a problem for these mentioned cases.

> If anyone have another proposition let them speak now, or forever remain
> silent! ;)

