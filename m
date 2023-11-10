Return-Path: <netdev+bounces-47156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BE47E854A
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 23:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C22BB20B58
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 22:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBCC3C695;
	Fri, 10 Nov 2023 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuLNARtW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618793C698
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 22:01:36 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8BC4229
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 14:01:34 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so2595389276.2
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 14:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699653694; x=1700258494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Bn5knu/eRqw5OUUNR8LaSLSQaE/mPmJj9KAiKEUOKw=;
        b=iuLNARtWNtH70bgEv8YX7kCjsLsJY6tRs3HHOMkTE109dLbeovi+S9MhNTDjZSGen8
         /GaAVo0b9xkqYok12SCy5neBS7CUQnYZ3aPuMQHzzAu4o+HYzzejYaIEQXHEWYELpruH
         zknd1WKMp9B0bFYI63rxUws7aQQiBmR6dTB7jGTvfkbHp9OraQuAmrXIe1nIuoldIo/4
         1O8JwGOATPLj3TrwvkCbk10TSKR5vHrO2m2Vr+HxtMyhgn5h64EMhxB8r8aSKK2T+XuE
         x+EdCYPgJC/tW2zXxA/rP8BNNl9zqjmtilbs+MU7KkG3AVduQHnOcYjXG1hLmOpomAtl
         aIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699653694; x=1700258494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Bn5knu/eRqw5OUUNR8LaSLSQaE/mPmJj9KAiKEUOKw=;
        b=IjnJPV9mWxR5fxnZcu+PMRzVmBW5qKJ1rpXuJgF2K4m1u3o9+VCOXfKxLEXcTW8bQe
         mzwS/vrz3KXf/hkTFARsmZ+arYrrDNy23mOHWPApZGX9BiN6y1bP9iBY0lb6VQw9FSQr
         Dqka9zdA0RDdop6Evty64bTHTdlnogtve1P+cDlTfXKi5EjkrWlCIsnbJ2XF/vtz6CQ9
         uPFCduVZ1gp9UHXUkJ3vu1hLxTWLdGa7tjdaV5+35Fu2dEHnyz/5IQJd9rFm7lTRsW1S
         k+m/Q5vl97Z/OaoAjWgC7jhP/SxbvqmEs7Ex8ArM3GhJQ6p9Y1Bhd/YKmCMzM+jD1ERM
         uEpg==
X-Gm-Message-State: AOJu0Yw1+J6THxUZZpH5JpveJJXdDGm8WXfm1yhiTpZKJIkQRrAmKwVN
	s23wxcgumgtxNWGQLkMZxJQpHuIyQ6cbdO5JkfI=
X-Google-Smtp-Source: AGHT+IEEHgokAlchOZqxh3Xe9p4WVw13pbhFYsSL3i2rDBHXvnb6Y075J4OIKCpbYMy4g+bxzQd3acLKsIMa77Q3bbE=
X-Received: by 2002:a25:54d:0:b0:da0:6876:c20d with SMTP id
 74-20020a25054d000000b00da06876c20dmr403135ybf.19.1699653693856; Fri, 10 Nov
 2023 14:01:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106001410.183542-1-luca.boccassi@gmail.com>
 <87fs1dyax9.fsf@nvidia.com> <87bkc1yaqa.fsf@nvidia.com> <ZU6TFWw9UuBkRazb@renaissance-vector>
In-Reply-To: <ZU6TFWw9UuBkRazb@renaissance-vector>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Fri, 10 Nov 2023 22:01:22 +0000
Message-ID: <CAMw=ZnQToc1E-KVcrK8pJ9jrt8XAyD9_GLgUWqpDs6vNLuFgOw@mail.gmail.com>
Subject: Re: [PATCH iproute2] Revert "Makefile: ensure CONF_USR_DIR honours
 the libdir config"
To: Andrea Claudi <aclaudi@redhat.com>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Nov 2023 at 20:31, Andrea Claudi <aclaudi@redhat.com> wrote:
>
> On Fri, Nov 10, 2023 at 02:54:16PM +0100, Petr Machata wrote:
> >
> > Petr Machata <petrm@nvidia.com> writes:
> >
> > > luca.boccassi@gmail.com writes:
> > >
> > >> From: Luca Boccassi <bluca@debian.org>
> > >>
> > >> LIBDIR in Debian and derivatives is not /usr/lib/, it's
> > >> /usr/lib/<architecture triplet>/, which is different, and it's the
> > >> wrong location where to install architecture-independent default
> > >> configuration files, which should always go to /usr/lib/ instead.
> > >> Installing these files to the per-architecture directory is not
> > >> the right thing, hence revert the change.
> > >
> > > So I looked into the Fedora package. Up until recently, the files were
> > > in /etc, but it seems there was a deliberate change in the spec file
> > > this September that moved them to /usr/lib or /usr/lib64.
> > >
> > > Luca -- since you both sent the patch under reversion, and are Fedora
> >
> > Ugh, I mean Andrea, not Luca. Sorry!
> >
> > > maintainer, could you please elaborate on what the logic was behind it?
> > > It does look odd to me to put config files into an arch-dependent
> > > directory, but I've been out of packaging for close to a decade at this
> > > point.
>
> Hi Petr,
> the change in Fedora iproute package is in response to 0a0a8f12fa1b
> ("Read configuration files from /etc and /usr"): it moves config files
> from /etc to /usr to make room for customization using /etc/iproute2, as
> described over there.
>
> What I tried to achieve with my patch is to have a single location in
> /usr for iproute files; but I agree with both you and Luca that storing
> config files in an arch-dependent directory doesn't look right.
>
> However, even using /usr/lib doesn't seems quite right to me. According
> to the FHS [1]:
>
> "/usr/lib includes object files and libraries. On some systems, it may
> also include internal binaries that are not intended to be executed
> directly by users or shell scripts."
>
> A better location is probably /usr/share [2]:
>
> "The /usr/share hierarchy is for all read-only architecture independent
> data files.
> This hierarchy is intended to be shareable among all architecture
> platforms of a given OS; thus, for example, a site with i386, Alpha, and
> PPC platforms might maintain a single /usr/share directory that is
> centrally-mounted."
>
> And this is exactly our case: read-only, shareable, config files that
> can be overridden using /etc/iproute2.
>
> Luca, does something along the lines below work for you? If so, I can
> test and send a patch fixing my own stuff.
>
> diff --git a/Makefile b/Makefile
> index 5c559c8d..ec57bd4c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -16,11 +16,11 @@ endif
>
>  PREFIX?=/usr
>  SBINDIR?=/sbin
> +DATADIR?=$(PREFIX)/share
>  CONF_ETC_DIR?=/etc/iproute2
> -CONF_USR_DIR?=$(LIBDIR)/iproute2
> +CONF_USR_DIR?=$(DATADIR)/iproute2
>  NETNS_RUN_DIR?=/var/run/netns
>  NETNS_ETC_DIR?=/etc/netns
> -DATADIR?=$(PREFIX)/share
>  HDRDIR?=$(PREFIX)/include/iproute2
>  DOCDIR?=$(DATADIR)/doc/iproute2
>  MANDIR?=$(DATADIR)/man
>
> [1] https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s06.html
> [2] https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s11.html

/usr/lib/ is used for configuration too - all the systemd configs for
example are stored there. That said, /usr/share/ works just as well
for me, so I don't mind one way or the other.

