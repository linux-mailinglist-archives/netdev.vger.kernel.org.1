Return-Path: <netdev+bounces-160095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F9A181C0
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 17:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47BA7A13CF
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442181925AF;
	Tue, 21 Jan 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QRj81tSm"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E11741D2;
	Tue, 21 Jan 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475925; cv=none; b=bglG/rFvSg7BlyeyAGhxB3whTjzNROLdhflCsjp5Gew+5Xircbia9eVgYsqYK7DGm8aHY6nj9CvH1R9KgB7awiNImRgjZlxuv1rZWRmb4NTyvIxoqOQrDi7CvPN2ZYmz0cglUrX7vHtEVLsJDXIWGLtJN/p64V05QmV/DwFDQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475925; c=relaxed/simple;
	bh=4lwSZ5qODNbiSUtsK/Uam0j66IwdA7OexD3x1M0bRLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7pEyKU5cr90tR0lNP9YMVtar9IZOqSgvI2Z0+CrxRO69Y5cCpkNnTG+W+o6KmJMNDyUPrP+FnjIVb0EBbRjkPjqn9itp/5Dq4244MSFJGHKdbhxSfOvA1Xabdjm8r9bBNyvnKi6g0KCZ7KjbIQ7LfL2J/UCgLwAbjnOFdwcEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QRj81tSm; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 597F6240003;
	Tue, 21 Jan 2025 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737475921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y09eIAOuct9VarPPAwVLaRxNXkOg2xjw8AVEzpAcu7E=;
	b=QRj81tSmyJxjmgjwSgbqo2uA4YAkj801tTLEavWfbppKHBrtHeKc5xXQS1/xwdLEktfykv
	vIRyjwVMcVSjAvGYGpDtHlHdfHJAhzMvqnHlzE6pOYmGRAX0FPA/UgQVD/vJDT0zL+My4P
	nTIBdoba8WuQ7so9E4oEMK8cFd4KdyF6dhNNCHrgvNDQ+Z41oI9ChSJnofDZYqdqxXvNBc
	ctas184ao793bD9CuwGB25LIKVYybp9VscN3kUGjkVQsqBis4lkpypE9nnUXaS184B5ZoT
	aIoC2NVdcMu6oAR+dIrgOclF/BsOxSKzWbpwNrfLKqj8O3vYVkKL2Xirc478tQ==
Date: Tue, 21 Jan 2025 17:11:56 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, thomas.petazzoni@bootlin.com, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?=
 <niklas.soderlund@ragnatech.se>, Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <20250121171156.790df4ba@kmaincent-XPS-13-7390>
In-Reply-To: <d512e107-68ac-4594-a7cb-8c26be4b3280@bp.renesas.com>
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
	<20250120111228.6bd61673@kernel.org>
	<20250121103845.6e135477@kmaincent-XPS-13-7390>
	<134f69de-64f9-4d36-94ff-22b93cb32f2e@bp.renesas.com>
	<20250121140124.259e36e0@kmaincent-XPS-13-7390>
	<d512e107-68ac-4594-a7cb-8c26be4b3280@bp.renesas.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 21 Jan 2025 15:44:34 +0000
Paul Barker <paul.barker.ct@bp.renesas.com> wrote:

> On 21/01/2025 13:01, Kory Maincent wrote:
> > On Tue, 21 Jan 2025 11:34:48 +0000
> > Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
> >  =20
> >> On 21/01/2025 09:38, Kory Maincent wrote: =20
>  [...] =20
>  [...] =20
> >>  [...]   =20
>  [...] =20
>  [...] =20
> >>
> >> (Cc'ing Niklas and Sergey as this relates to the ravb driver) =20
> >=20
> > Yes, thanks.
> >  =20
> >> Why do we need to hold the rtnl mutex across the calls to
> >> netif_device_detach() and ravb_wol_setup()?
> >>
> >> My reading of Documentation/networking/netdevices.rst is that the rtnl
> >> mutex is held when the net subsystem calls the driver's ndo_stop metho=
d,
> >> which in our case is ravb_close(). So, we should take the rtnl mutex
> >> when we call ravb_close() directly, in both ravb_suspend() and
> >> ravb_wol_restore(). That would ensure that we do not call
> >> phy_disconnect() without holding the rtnl mutex and should fix this
> >> issue. =20
> >=20
> > Not sure about it. For example ravb_ptp_stop() called in ravb_wol_setup=
()
> > won't be protected by the rtnl lock. =20
>=20
> ravb_ptp_stop() modifies a couple of device registers and calls
> ptp_clock_unregister(). I don't see anything to suggest that this
> requires the rtnl lock to be held, unless I am missing something.

What happens if two ptp_clock_unregister() with the same ptp_clock pointer =
are=20
called simultaneously? From ravb_suspend and ravb_set_ringparam for example=
. It
may cause some errors.
For example the ptp->kworker pointer could be used after a kfree.
https://elixir.bootlin.com/linux/v6.12.6/source/drivers/ptp/ptp_clock.c#L416

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

