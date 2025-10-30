Return-Path: <netdev+bounces-234461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE61C20E0B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D20C3B3282
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D423835BDDB;
	Thu, 30 Oct 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CFhWNvqL"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3524337B
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837513; cv=none; b=p7727+VmA0n+f3GI16/82V+NohqZae57e4mom7/OyJTEK0FWMupMf4dvPr16hSjbuJ+yvNpWRXhnO2JWi4HoLlK64b3Z8SQaWdqO/VvMdtBb4MuRR8yMFJPTB2LxanNqAbKPg4An7B/gV8bpbBkRl5XnetvXOCY6ye5o1Og3lFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837513; c=relaxed/simple;
	bh=d9HrJ1Yb0PQtCuWoG+jVQj2m/iOww1Um89Fj1p5nJos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hjq7ARqOJlEobUaNlK+6ZsfEDoioWF3A+u2RB3Lb9iOufsyC/EMAaHqlHb52X3HTPqF3gChdJ/n7OqLXm5E7Nn55K3s0zESGaNj3gWc/PFbMK7kvobzZFAtDtxk7PUzyaRjEkBt2rf5gpb4uWogYOXpVaIuDHdONn4cFQ4m2+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CFhWNvqL; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CA056C0DAA9;
	Thu, 30 Oct 2025 15:18:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3B1F36068C;
	Thu, 30 Oct 2025 15:18:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C1CE0102F248E;
	Thu, 30 Oct 2025 16:18:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761837508; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aJItKe0WGcjRea3xs8cPeKa+4mwSiWR3AJZ3R3JthBA=;
	b=CFhWNvqLP+cti/o6C3V6eY3Zz3bXbFxhlLSfNv2vQJPX7zdBXL8Tf1cavPy2srC1cC9PH1
	Wn8W5zT38TgUqnOkmLvCYE01J777htBl5eRqLYyHkfaF9vWRPZ+4UqxERIWm9SZtGg21aF
	OEY44Ke0CCfiWothwQqdC474596Q0SEzs5qJnaXKcOAbAaRmk0oKWeawWeAB25VgCjnqt1
	cqfAYvJb3YBaoXzhZrksEKryW/nqmWwjh0zor5pz2U1epaIc8asVNGO3xZiR9fEsLEto4V
	DpblYfdwMPzEyP2tphCfOqjqX38RvBOAMSnxO780Afdo1qCtY0ibF9IME2LdYw==
Date: Thu, 30 Oct 2025 16:18:24 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next] ti: netcp: convert to ndo_hwtstamp callbacks
Message-ID: <20251030161824.0000568a@kmaincent-XPS-13-7390>
In-Reply-To: <0a37246f-9dad-4977-b7e0-5fa73c69ee94@linux.dev>
References: <20251029200922.590363-1-vadim.fedorenko@linux.dev>
	<20251030113007.1acc78b6@kmaincent-XPS-13-7390>
	<0a37246f-9dad-4977-b7e0-5fa73c69ee94@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 30 Oct 2025 12:18:50 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> On 30/10/2025 10:30, Kory Maincent wrote:
> > On Wed, 29 Oct 2025 20:09:22 +0000
> > Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> >  =20
> >> Convert TI NetCP driver to use ndo_hwtstamp_get()/ndo_hwtstamp_set()
> >> callbacks. The logic is slightly changed, because I believe the origin=
al
> >> logic was not really correct. Config reading part is using the very
> >> first module to get the configuration instead of iterating over all of
> >> them and keep the last one as the configuration is supposed to be iden=
tical
> >> for all modules. HW timestamp config set path is now trying to configu=
re
> >> all modules, but in case of error from one module it adds extack
> >> message. This way the configuration will be as synchronized as possibl=
e. =20
> >=20
> > On the case the hwtstamp_set return the extack error the hwtstamp_get w=
ill
> > return something that might not be true as not all module will have the=
 same
> > config. Is it acceptable? =20
>=20
> Well, technically you are right. But this logic was broken from the very
> beginning. And as I also mentioned, both modules use the same set
> function with the same error path, which means in current situation if
> the first call is successful, the second one will also succeed. And
> that's why it's acceptable
>=20
> >> There are only 2 modules using netcp core infrastructure, and both use
> >> the very same function to configure HW timestamping, so no actual
> >> difference in behavior is expected.
> >>
> >> Compile test only.
> >>
> >> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> >> b/drivers/net/ethernet/ti/netcp_ethss.c index 55a1a96cd834..0ae4411281=
2c
> >> 100644 --- a/drivers/net/ethernet/ti/netcp_ethss.c
> >> +++ b/drivers/net/ethernet/ti/netcp_ethss.c
> >> @@ -2591,20 +2591,26 @@ static int gbe_rxtstamp(struct gbe_intf *gbe_i=
ntf,
> >> struct netcp_packet *p_info) return 0;
> >>   }
> >>  =20
> >> -static int gbe_hwtstamp_get(struct gbe_intf *gbe_intf, struct ifreq *=
ifr)
> >> +static int gbe_hwtstamp_get(void *intf_priv, struct kernel_hwtstamp_c=
onfig
> >> *cfg) {
> >> -	struct gbe_priv *gbe_dev =3D gbe_intf->gbe_dev;
> >> -	struct cpts *cpts =3D gbe_dev->cpts;
> >> -	struct hwtstamp_config cfg;
> >> +	struct gbe_intf *gbe_intf =3D intf_priv;
> >> +	struct gbe_priv *gbe_dev;
> >> +	struct phy_device *phy;
> >> +
> >> +	gbe_dev =3D gbe_intf->gbe_dev;
> >>  =20
> >> -	if (!cpts)
> >> +	if (!gbe_dev->cpts)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	phy =3D gbe_intf->slave->phy;
> >> +	if (phy_has_hwtstamp(phy))
> >>   		return -EOPNOTSUPP; =20
> >=20
> > This condition should be removed.
> > The selection between PHY or MAC timestamping is now done in the net co=
re:
> > https://elixir.bootlin.com/linux/v6.17.1/source/net/core/dev_ioctl.c#L2=
44 =20
>=20
> Yeah, but the problem here is that phy device is not really attached to=20
> netdev, but rather to some private structure, which is not accessible by
> the core, only driver can work with it, according to the original code.

The PHY are either attached to gbe_intf->ndev or gbe_dev->dummy_ndev.
Therefore I think it will already attached to the net_device pointer used by
hwtstamp NDOs.
Mmh indeed each slave can have a different PHY. Why is there several slave =
+ phy
per netdev?
https://elixir.bootlin.com/linux/v6.17.1/source/drivers/net/ethernet/ti/net=
cp_ethss.c#L3163
Shouldn't each netdev be associated to one PHY (or use the phy topology
support). This is kind of weird.

In either case if there is an issue here, it should be split in a second pa=
tch
as you are modifying the behavior of the driver.
Maybe you should already split the patch in two to separate the NDO convers=
ion
from the module iteration logic design change.

> But I might be missing something obvious here, if someone is at least a
> bit aware of this code and can shed some light and confirm that phydev
> is correctly set and attached to actual netdev, I'm happy to remove this
> ugly part.

Yeah, this driver seems a bit ugly to me also but maybe we are missing
something.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

