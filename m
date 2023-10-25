Return-Path: <netdev+bounces-44328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB507D78CD
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B317FB212BD
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C04F381AA;
	Wed, 25 Oct 2023 23:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4iZxpwW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C7381A4
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:42:00 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB1A186
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:41:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507d1cc0538so331828e87.2
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698277317; x=1698882117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8VIiqLkglYqJ+Q19MxelXV/EJXHtj9elKsbPyNgJFE=;
        b=X4iZxpwW9noy6PCl7Fek6l3YBr1XUibRBJzDmAgzP82lCayz5gergKKAzLCpu/Kq6o
         DtfuzkoO0yo4/vuZRPQcNn4YL5P/DJJ7u/C0IpZRCTohn+pqVr68KgK+zeWZjh5b24rm
         1tQOfnDf16ZjAs3diwlNVYQPZ9ySH2PkAoFAbilPzGQ69pxx9KidtW3mV9hc1h13tK0q
         krp2qZD2+8mn/zePSDw4fmw9665OgUIVOnqUHF+GHy/qc4VzsLBOHIywuTWF/o2lWhNL
         4Y2KiGLsEtyo6EP6dbyJ3gp13vxn8wUd4YOMTTZw2ue97ytaTPbrGWuBb/dCIr3QzHt6
         ZNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698277317; x=1698882117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8VIiqLkglYqJ+Q19MxelXV/EJXHtj9elKsbPyNgJFE=;
        b=PlrHO/OCQZqb1Qi0y/BnzQXePDJIn8Y9cC0TXTsnRtmHEhQba41hUdCzmu0+2nPyCB
         VmaJIx1w+OtLX+qmmlqxQDiS4/gnNFy0xm6P8ouVPBCdckyUihQ9JAMRVnDjVqnuQR+r
         c1AMVMZI+xNKw8fu6yHK5yUliZQYteSZp5vhPebyTvAmHtVnMV6jMTwbmv7pfNG0YsDq
         VqJzuEb3cAV/DoxAvKauMGH2uow2Wi1NyyGwvyZVh2uQLbTcP/gt2Wutv10CQcx1AvEv
         5IgeCPgkLLTTyB4KMO4oTcfaYZ576XVHDlMsHbAu3uWkQjCT4OpXKYPNE6mo8Mqk+0xf
         QbYg==
X-Gm-Message-State: AOJu0YwjMhwTVNslS/L6q6EajA8TdMv/9xPUMeqUkdckdTzl0LEB9KIH
	GIwvVRsweKUPap9LAEQci42j0HUoKJ2sgRgIZvv8e9+K6C8ElsQkeQIzt6sf
X-Google-Smtp-Source: AGHT+IFvspkBVEQcaXlvdiXLBc5/Nnce7QqmAyRawMvbFwO+bR8RKg0bupAzqNCymHeTUjheo+zdDooay+3N3QXOwCg=
X-Received: by 2002:a19:6716:0:b0:500:9a29:bcb8 with SMTP id
 b22-20020a196716000000b005009a29bcb8mr11657885lfc.4.1698277316604; Wed, 25
 Oct 2023 16:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch> <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
 <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch> <CAFhGd8p3WzqQu7kT0Pt8Axuv5sKdHJQOLZVEg5x8S_QNwT6bjQ@mail.gmail.com>
 <CAFhGd8qcLARQ4GEabEvcD=HmLdikgP6J82VdT=A9hLTDNru0LQ@mail.gmail.com>
 <202310131630.5E435AD@keescook> <a958d35e-98b6-4a95-b505-776482d1150c@lunn.ch>
 <202310141935.B326C9E@keescook>
In-Reply-To: <202310141935.B326C9E@keescook>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 25 Oct 2023 16:41:43 -0700
Message-ID: <CAFhGd8r3=ndtYgjK3O5KV_wrd5OL+0hP6RjqBwhJXgc0jr1hDw@mail.gmail.com>
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with ethtool_sprintf
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 14, 2023 at 7:36=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Sat, Oct 14, 2023 at 03:55:41AM +0200, Andrew Lunn wrote:
> > > I've been told that this whole ethtool API area is considered
> > > deprecated. If that holds, then I don't think it's worth adding new
> > > helpers to support it when ethtool_sprintf() is sufficient.
> >
> > I think deprecated is too strong. The current API is not great, so
> > maybe with time a new API will emerge. But given there are around 160
> > users of the API, probably over 100 drivers, it will be 20 years or
> > more before all that hardware becomes obsolete and the drivers are
> > removed.
> >
> > > Once you're done with the strncpy->ethtool_sprintf conversions I thin=
k
> > > it would be nice to have a single patch that fixes all of these
> > > "%s"-less instances to use "%s". (Doing per-driver fixes for that cas=
e
> > > seems just overly painful.)
> >
> > I guess it is the same amount of effort to replace them with
> > ethtool_puts()?
>
> Yup, right. If adding ethtool_puts() makes sense, then I totally agree.

Thanks for the discussion here.

I've sent a series [1] implementing ethtool_puts() and sending out a
wave of replacements.

[1]: https://lore.kernel.org/all/20231025-ethtool_puts_impl-v1-0-6a53a93d3b=
72@google.com/
>
> --
> Kees Cook

Thanks
Justin

