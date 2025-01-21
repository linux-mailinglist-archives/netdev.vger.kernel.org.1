Return-Path: <netdev+bounces-160032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E86EA17E48
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056773A6D80
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26311F2C57;
	Tue, 21 Jan 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dB3FENEN"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9C1DF96A;
	Tue, 21 Jan 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464492; cv=none; b=ms/08XrfAy6PK5sJANwzzKTounqpptAQz/sM7pRiTjdqRHsHtA+0XF2jf+vtt3zK96gC7wujYykbTGK4OcGixjz+n0r91jvsvcjWsL49peISe2or2mVm7uNtA4/YH5+NtjSNIyH8JLF9arNUs5D9Dw/aj2YK9etm18ryT9C4/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464492; c=relaxed/simple;
	bh=wiih2O6WFN0z41ZEn45UgM2Xtisq+dnBfyYxcbvZn/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twlKrmfg3m8JBbRGy1B/GsWqRja5ngXpQpYnfc9MfQrCyMiI2LGvybOwTx6dQQsvAv6fGjNaPy6xnjaynk0HMGdBWcAQO4Om+5Qak399rdw4dlrJC6PtXA753Dy5K76dsdja8zZcr1IaFA2BLZ9CTMnDkM3kYxl9yBGEqvLQCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dB3FENEN; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 987A21BF210;
	Tue, 21 Jan 2025 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737464488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTL2MCxema27TVdjqR+rtl5hDV02kCp0G1xFKUEjEoE=;
	b=dB3FENEN6SSUXRkSPvxuHc8iGTt9G3uinaCKzSl6Mx/O5A3weIOFYJ3MkSY6+1o8jaofJo
	rg9b/SltLF2nEAutJ6gu5EiiU4p6lpLzQRETmN9noxsq3HrVRF99Apbj0+iw+LndB/itMR
	R3w7ToECm3nNMjEy6PvZKK0fM9nk+NUePJXXYqIjZ7ZvjRoaIotbgfIflR7CpYAAyIQaSn
	LOcKqIZaThVDF8VjTVHmF6gtaZAtELWxPorIxbdKkb3vSbRYwf/2q1sivZzWBP1JLlIuSZ
	lPgeD1/K97S/2bxr51JVR9Mth1kxb+JhkQvaZ2ojfb3513ZQOPfRao1ANFU0UQ==
Date: Tue, 21 Jan 2025 14:01:24 +0100
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
Message-ID: <20250121140124.259e36e0@kmaincent-XPS-13-7390>
In-Reply-To: <134f69de-64f9-4d36-94ff-22b93cb32f2e@bp.renesas.com>
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
	<20250120111228.6bd61673@kernel.org>
	<20250121103845.6e135477@kmaincent-XPS-13-7390>
	<134f69de-64f9-4d36-94ff-22b93cb32f2e@bp.renesas.com>
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

On Tue, 21 Jan 2025 11:34:48 +0000
Paul Barker <paul.barker.ct@bp.renesas.com> wrote:

> On 21/01/2025 09:38, Kory Maincent wrote:
> > On Mon, 20 Jan 2025 11:12:28 -0800
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >  =20
> >> On Mon, 20 Jan 2025 15:19:25 +0100 Kory Maincent wrote: =20
>  [...] =20
> >>
> >> I maintain that ravb is buggy, plenty of drivers take rtnl_lock=20
> >> from the .suspend callback. We need _some_ write protection here,
> >> the patch as is only silences a legitimate warning. =20
> >=20
> > Indeed if the suspend path is buggy we should fix it. Still there is lo=
ts of
> > ethernet drivers calling phy_disconnect without rtnl (IIUC) if probe re=
turn
> > an error or in the remove path. What should we do about it?
> >=20
> > About ravb suspend, I don't have the board, Claudiu could you try this
> > instead of the current fix:
> >=20
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c
> > b/drivers/net/ethernet/renesas/ravb_main.c index bc395294a32d..c9a0d2d6=
f371
> > 100644 --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -3215,15 +3215,22 @@ static int ravb_suspend(struct device *dev)
> >         if (!netif_running(ndev))
> >                 goto reset_assert;
> > =20
> > +       rtnl_lock();
> >         netif_device_detach(ndev);
> > =20
> > -       if (priv->wol_enabled)
> > -               return ravb_wol_setup(ndev);
> > +       if (priv->wol_enabled) {
> > +               ret =3D ravb_wol_setup(ndev);
> > +               rtnl_unlock();
> > +               return ret;
> > +       }
> > =20
> >         ret =3D ravb_close(ndev);
> > -       if (ret)
> > +       if (ret) {
> > +               rtnl_unlock();
> >                 return ret;
> > +       }
> > =20
> > +       rtnl_unlock();
> >         ret =3D pm_runtime_force_suspend(&priv->pdev->dev);
> >         if (ret)
> >                 return ret;
> >=20
> > Regards, =20
>=20
> (Cc'ing Niklas and Sergey as this relates to the ravb driver)

Yes, thanks.

> Why do we need to hold the rtnl mutex across the calls to
> netif_device_detach() and ravb_wol_setup()?
>=20
> My reading of Documentation/networking/netdevices.rst is that the rtnl
> mutex is held when the net subsystem calls the driver's ndo_stop method,
> which in our case is ravb_close(). So, we should take the rtnl mutex
> when we call ravb_close() directly, in both ravb_suspend() and
> ravb_wol_restore(). That would ensure that we do not call
> phy_disconnect() without holding the rtnl mutex and should fix this
> issue.

Not sure about it. For example ravb_ptp_stop() called in ravb_wol_setup() w=
on't
be protected by the rtnl lock.
I don't know about netif_device_detach(). It doesn't seems to be the case as
there is lots of driver using it without holding rtnl lock.

Indeed we should add the rtnl lock also in the resume path.=20

> Commit 35f7cad1743e ("net: Add the possibility to support a selected
> hwtstamp in netdevice") may have unearthed the issue, but the fixes tag
> should point to the commits adding those unlocked calls to ravb_close().

The current patch was on phy_device.c that's why the fixes tag does not poi=
nt to
a ravb commit, it will change.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

