Return-Path: <netdev+bounces-115556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CA0946FF8
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 19:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B27E1F21206
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8711A768EC;
	Sun,  4 Aug 2024 17:09:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96B1EEE3
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722791386; cv=none; b=H9aZ07rCflsUygghHQUzm46Z8OYzHB3b/6IpwFzr+RfMqU2QDZ1vzuTdDTuRyhxGE5tFD3E4OrSjQt+PNfitoTvAoHeh14bKK+F+Wrm2fndYi8jaWooA4TZpmbRf7cACrMuJZlzO/lFVoP/RcwGzTBf3HCnUhqbNVL5PU4xmbH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722791386; c=relaxed/simple;
	bh=HfvUqHmyhHB+tsyhyP/NGYASM5rhPLTzluqXXwocDF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNmjBEAdaSL0tc7qmz9eu0hw7qqDBqFb3kHNc5ArKTUoslt1fvl2QvmF0xOg+YeaL0FZxex4ueVtZ6CgCPO07s73OTbVhwikUSG3X2OLKlyiHzurZWDnMYS1sELuEFz8o3C9NZetymIrfaUw+9XGzHZmOCqLJcvujuZ36RvNv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52fc4388a64so15532581e87.1
        for <netdev@vger.kernel.org>; Sun, 04 Aug 2024 10:09:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJai403y1LVZjx9ztxhLgkpO23UaHKUbQ8Nh6Evb2Oi0qMhfVWUz0FOUbqYkLAmX+ZiFf36816erS6z8ClI5QILlWvPbdy
X-Gm-Message-State: AOJu0YygmXa9mk6pD58tncE6mCqIQ9LP4KCc0kGQ5oZ2QWdy/1Wq7Q8W
	wNQex+pBJT76c95cApaVB5Sh6gtohZ9qiZyftsY8TAuDpYtCo4uWC/7U0Fnb4Dbs00E62Bqoxoc
	hPzghIaaISUx+aRg518CeEMi+sc8=
X-Google-Smtp-Source: AGHT+IE1c5W8j32BCrYT+7aGe8ETPcS3tacBsuMVFwVyG9VZvV9SG+pVdnTCCiarmL+qjcox2oa8MipQODiSwP0NhYo=
X-Received: by 2002:a05:6512:3f0d:b0:530:b871:eb90 with SMTP id
 2adb3069b0e04-530bb39b860mr7154389e87.40.1722791381871; Sun, 04 Aug 2024
 10:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804085547.30a9810a@hermes.local> <20240804160355.940167-1-dilfridge@gentoo.org>
 <20240804095811.04600a4d@hermes.local> <CAJ0EP43TXU7U54+hxouCcKZ+GYVMOsM4aVXuoQ2kFtN2Whs0nw@mail.gmail.com>
In-Reply-To: <CAJ0EP43TXU7U54+hxouCcKZ+GYVMOsM4aVXuoQ2kFtN2Whs0nw@mail.gmail.com>
From: Mike Gilbert <floppym@gentoo.org>
Date: Sun, 4 Aug 2024 13:09:29 -0400
X-Gmail-Original-Message-ID: <CAJ0EP40OAwcYMZRtiuERzOG2dm5aRoOtLZntwq8D4hgyHJAJUA@mail.gmail.com>
Message-ID: <CAJ0EP40OAwcYMZRtiuERzOG2dm5aRoOtLZntwq8D4hgyHJAJUA@mail.gmail.com>
Subject: Re: [PATCH v2 iproute2] libnetlink.h: Include <endian.h> explicitly
 for musl
To: Mike Gilbert <floppym@gentoo.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, =?UTF-8?B?QW5kcmVhcyBLLiBIw7x0dGVs?= <dilfridge@gentoo.org>, 
	netdev@vger.kernel.org, base-system@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 1:07=E2=80=AFPM Mike Gilbert <floppym@gentoo.org> wr=
ote:
>
> On Sun, Aug 4, 2024 at 12:58=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Sun,  4 Aug 2024 18:03:23 +0200
> > Andreas K. H=C3=BCttel <dilfridge@gentoo.org> wrote:
> >
> > > The code added in "f_flower: implement pfcp opts" uses h2be64,
> > > defined in endian.h. While this is pulled in around some corners
> > > for glibc (see below), that's not the case for musl and an
> > > explicit include is required there.
> > >
> > > . /usr/include/libmnl/libmnl.h
> > > .. /usr/include/sys/socket.h
> > > ... /usr/include/bits/socket.h
> > > .... /usr/include/sys/types.h
> > > ..... /usr/include/endian.h
> > >
> > > Fixes: 976dca372 ("f_flower: implement pfcp opts")
> > > Bug: https://bugs.gentoo.org/936234
> > > Signed-off-by: Andreas K. H=C3=BCttel <dilfridge@gentoo.org>
> >
> > Other parts of flower code use htonll().
> > It would have been better to be consistent and not use h2be64() at all.
>
> htonl is used for 32-bit numbers. It won't work properly with 64-bit numb=
ers.

Sorry, I missed the second "l".

