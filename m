Return-Path: <netdev+bounces-115555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FFB946FEF
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 19:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776561F21329
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E5D6026A;
	Sun,  4 Aug 2024 17:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B92AC29
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722791292; cv=none; b=BFga5ElH63tcFewTq4DDHyPHkeXG/z5nbyquHQ/VwmxGbct9f8Ecp80QKTUBHfmhbFMHDUIvRc8SJ8iVtmgxmZEGl9gAgcDUhLoxTf0KSPhrdsXQpDIW25JrNHYz9WojCuXgkQzbUykzmRSQfzRqjjLcs4lU5rYbjZX4c6PLkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722791292; c=relaxed/simple;
	bh=2OIL7wTQ82wb+3Hnx9//X1QDK/eaWDZvn+KVdN2REHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA4koYc4ETE4UwxuGKBs7f48XHhSEheQbDHSEJw/f3HhFZOqx58w7WHRIAb5DficdOluIxi9pwmPDGRMuo7NJNV5ENYBd4UksQrGcCqv/aG9YNQTx1/0WI1hcLzHca0bsc/MotfGM9rxh0xxhbA8p2mDofGGO4AvbT0b8lQ+Lfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7de4364ca8so132429466b.2
        for <netdev@vger.kernel.org>; Sun, 04 Aug 2024 10:08:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6xQAeaqIMFGMXR3cWbNLUjXKgzeHI9iQinEqSfGtirD3bOYIRnCpvlImSqGetv2C8/726EGddXK57NcRekytbPhmdNjb/
X-Gm-Message-State: AOJu0YzH7VvMw69xFPNirBOL6IAMGSlnvbd87hH+zTkr/ec0uXVey8J7
	BASwVGCCTK87ko/Xed05j5GVrmIq6GnTxjk93GsNjqcnvcjSv8056Y7crmPtuGfLhk4yi7vFjiR
	qg71yeBxCafzo33vBqiaKF9/e7do=
X-Google-Smtp-Source: AGHT+IE+tqUUlNCHT8aN3RdVVK7BYN1dAob8OS0KGlxO0pvX7UcDmrFEKMTA17rhx5Q9iqkhgsG34QT6uuYJuCVA+yo=
X-Received: by 2002:a17:907:724b:b0:a7a:9f0f:ab18 with SMTP id
 a640c23a62f3a-a7dc4e69cadmr715272966b.20.1722791286164; Sun, 04 Aug 2024
 10:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804085547.30a9810a@hermes.local> <20240804160355.940167-1-dilfridge@gentoo.org>
 <20240804095811.04600a4d@hermes.local>
In-Reply-To: <20240804095811.04600a4d@hermes.local>
From: Mike Gilbert <floppym@gentoo.org>
Date: Sun, 4 Aug 2024 13:07:54 -0400
X-Gmail-Original-Message-ID: <CAJ0EP43TXU7U54+hxouCcKZ+GYVMOsM4aVXuoQ2kFtN2Whs0nw@mail.gmail.com>
Message-ID: <CAJ0EP43TXU7U54+hxouCcKZ+GYVMOsM4aVXuoQ2kFtN2Whs0nw@mail.gmail.com>
Subject: Re: [PATCH v2 iproute2] libnetlink.h: Include <endian.h> explicitly
 for musl
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?B?QW5kcmVhcyBLLiBIw7x0dGVs?= <dilfridge@gentoo.org>, 
	netdev@vger.kernel.org, base-system@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 12:58=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sun,  4 Aug 2024 18:03:23 +0200
> Andreas K. H=C3=BCttel <dilfridge@gentoo.org> wrote:
>
> > The code added in "f_flower: implement pfcp opts" uses h2be64,
> > defined in endian.h. While this is pulled in around some corners
> > for glibc (see below), that's not the case for musl and an
> > explicit include is required there.
> >
> > . /usr/include/libmnl/libmnl.h
> > .. /usr/include/sys/socket.h
> > ... /usr/include/bits/socket.h
> > .... /usr/include/sys/types.h
> > ..... /usr/include/endian.h
> >
> > Fixes: 976dca372 ("f_flower: implement pfcp opts")
> > Bug: https://bugs.gentoo.org/936234
> > Signed-off-by: Andreas K. H=C3=BCttel <dilfridge@gentoo.org>
>
> Other parts of flower code use htonll().
> It would have been better to be consistent and not use h2be64() at all.

htonl is used for 32-bit numbers. It won't work properly with 64-bit number=
s.

