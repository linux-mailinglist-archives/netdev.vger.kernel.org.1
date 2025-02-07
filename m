Return-Path: <netdev+bounces-163901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB7BA2BFC7
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77953A12CB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B81DE3A3;
	Fri,  7 Feb 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="JZcB592A"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D51A2381;
	Fri,  7 Feb 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921537; cv=none; b=YEuaugoTddQc+KfNXFKfZjLwcEoph56KYOImLiK10KYxXipFhxzK3aslX+KcPKpUBr8yiElrMT4JvFHnDukm9pHGykW7HCNfbgZBAmom9mqaU76rUg1l4xanP6qwv45/snIdtJeGTPsYR67SalV9f2/3VjtZlofYF0PEJQg6ihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921537; c=relaxed/simple;
	bh=CTwk6nntsSZIH6A8kRAxGiAdM03yqBNLI0Py6Ec3eRA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IOaC6A1jdW07ialGdVqufj7COuwlCi3DPFyhag0MrbOsFqbM9kXYOV37qe00eupM+NaNnBn/A+ujNzt9qtXllArC5aLx9UUrVnuiroqpTciSzqMP0xVyZreG2Bybf4TNM0W3BRJ+bksJKhJN4GV6yP2qh/CwxZDI1reBFQuY68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=JZcB592A; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738921533;
	bh=CTwk6nntsSZIH6A8kRAxGiAdM03yqBNLI0Py6Ec3eRA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JZcB592AowtHybokzGIu07IS/6avCuYTHcI9vUAR7dQ9ozaTdkxV1E80XckSiWHct
	 Js1oqq9MlH7QrrM5svHcBH8G0qKC1bQs9liXdnFHwDGcmo6mdH7PukuyKc9XdkEeLe
	 VtIkWL+U7y3l6v2BnVyLK+y8I2lkae5hB5/xYxcAZCUUpphs2o0xmO7eeAtFUko37f
	 fraMxHIfdDunKS7dZKlfFhqPEhkT6wcI79S+6OoMk7WfRGKt0ccmfokSF1PEBsWJbB
	 xoVCi0ai8fOua5EQJbieqVj9wo+AhVnGEbPfNGLE3aW4toTm6/rVt+9TZ9EjTxj4Wa
	 pzu6FmruKfhYA==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 545B573446;
	Fri,  7 Feb 2025 17:45:33 +0800 (AWST)
Message-ID: <f670c97228b7ae8ac1efd426f83438825e800625.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 2/2] net: mctp: Add MCTP USB transport driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org,  Santosh Puranik <spuranik@nvidia.com>
Date: Fri, 07 Feb 2025 17:45:33 +0800
In-Reply-To: <2025020716-dandruff-slacked-f6b1@gregkh>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
	 <20250206-dev-mctp-usb-v1-2-81453fe26a61@codeconstruct.com.au>
	 <2025020657-unsubtly-imbecile-faf4@gregkh>
	 <912d59eb611448ed9da16ef82b79f77d6fa0c654.camel@codeconstruct.com.au>
	 <2025020716-dandruff-slacked-f6b1@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Greg,

> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dev_err(&mctp_usb->usbdev->dev, "%s: urb status: %d=
\n",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__f=
unc__, status);
> > >=20
> > > This could flood the logs, are you sure you need it at dev_err()
> > > level?
> > >=20
> > > And __func__ is redundant, it's present in dev_*() calls already.
> >=20
> > am I missing something then?
> >=20
> > =C2=A0=C2=A0 [=C2=A0 146.130170] usb 2-1: short packet (hdr) 6
> >=20
> > emitted from:
> >=20
> > =C2=A0=C2=A0=C2=A0 dev_dbg(&mctp_usb->usbdev->dev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sho=
rt packet (hdr) %d\n",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdr-=
>len);
> >=20
> > Seems like we get the driver name, but not the function.
> >=20
> > I'm happy to remove the __func__ output either way, but I will also
> > make the logs a little more descriptive for context, if we don't have
> > func data.
>=20
> Please read Documentation/admin-guide/dynamic-debug-howto.rst, it shows
> how to get the function information from the dev_dbg() lines at runtime.
>=20
> In short:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$ alias ddcmd=3D'echo $* =
> /proc/dynamic_debug/control'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# add function to all ena=
bled messages
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$ ddcmd '+f'

Your original comment was on the dev_err() call though (sorry, I've
complicated the discussion by using a dev_dbg() example).

Looks like only dev_dbg (and not _err/_warn/etc) has provision for
__func__, is that right?

I've since removed the __func__ references anyway, and replaced with
better context on the messages, but keen to make sure I have the correct
understanding in general.

Cheers,


Jeremy

