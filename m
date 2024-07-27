Return-Path: <netdev+bounces-113375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42193DF94
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 15:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7C41F21A54
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365B16E876;
	Sat, 27 Jul 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MSDp3HIj"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE856F2E2;
	Sat, 27 Jul 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722087882; cv=none; b=UJsCj4nvx5+oXvrZmTq6BZDn2iZLmMyjARtjxb/auFOYm3MSAhLoNL8+UQCrhh8i/kSYfLX+C5BLNYGarg+O405BzfIj7XLbRVICTDNvxo3Sfy8fOT++9YhRzvqv+dIkw3h5tH11M8ht088QiXdvWpc5etUbcV1CBEQBUPxIMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722087882; c=relaxed/simple;
	bh=wl5NAwzcxjFCy+OUk/uEwWiJLpbJLs3EK1hdWc9+KG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLxebjiHbrgsRL/bRFO3bMBp111Q293SgiRgi1ULAuMK9Bhh3YDKXCPPKZ6Ndl8otbMtx4yZi6+5LuDbCSy4mSWsztXNxuhJbTGd30V/XVU+m4O1Pm0B3glc9S03vjDzCuqSE6JDs561THR/Dpzbo2/3WnUM5vJCdP5AZM6bTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MSDp3HIj; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0095E0003;
	Sat, 27 Jul 2024 13:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722087870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVGYpz4EMRqUqEfeUp3ItIDDmDoKY0516WwTXBxXGRM=;
	b=MSDp3HIj+BuGqizb6wIE+kxDRNF89m1Avb9+dWW7HLFnWhfkL8/D6diHn5Q4vDJyZSwkUb
	gzBhFsOMqIaQDr4S5QwDly05OcgAbnm0GO2Y/NGtOByWH679ZhjMyeAG+kD8YP8RIMVv31
	zH+6oM/cAZ8Eh8av68cCn11mPf5DOw9mmy1sxEmc+ZpkPLZ+51w62Sy/u4GJMWEKyN86iS
	i3my1siR1AmhNqEl2L8HHcCnXH/dW4O6N9tv+EBTWohCcATQ5Fpq291A6Bn41njv/U1ZJ3
	nIP4/qd6bljB+Y1kSDr03ubyJxpQvugZvOHplJ2Z1iDjVVIr1ajnDcAg6DTwaA==
Date: Sat, 27 Jul 2024 15:44:26 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, "Heiner Kallweit" <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, "Jay Vosburgh"
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, "Horatiu Vultur" <horatiu.vultur@microchip.com>,
 <UNGLinuxDriver@microchip.com>, "Simon Horman" <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <donald.hunter@gmail.com>,
 <danieller@nvidia.com>, <ecree.xilinx@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v17 04/14] net: Change the API of PHY default
 timestamp to MAC
Message-ID: <20240727154426.7ba30ed9@kmaincent-XPS-13-7390>
In-Reply-To: <39c7fe45-fbee-4de5-ab43-bf042ed31504@intel.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
	<20240709-feature_ptp_netnext-v17-4-b5317f50df2a@bootlin.com>
	<39c7fe45-fbee-4de5-ab43-bf042ed31504@intel.com>
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

On Mon, 15 Jul 2024 16:37:01 -0700
Jacob Keller <jacob.e.keller@intel.com> wrote:

> On 7/9/2024 6:53 AM, Kory Maincent wrote:
> > Change the API to select MAC default time stamping instead of the PHY.
> > Indeed the PHY is closer to the wire therefore theoretically it has less
> > delay than the MAC timestamping but the reality is different. Due to lo=
wer
> > time stamping clock frequency, latency in the MDIO bus and no PHC hardw=
are
> > synchronization between different PHY, the PHY PTP is often less precise
> > than the MAC. The exception is for PHY designed specially for PTP case =
but
> > these devices are not very widespread. For not breaking the compatibili=
ty
> > default_timestamp flag has been introduced in phy_device that is set by
> > the phy driver to know we are using the old API behavior.
> >  =20
>=20
> This description feels like it is making a pretty broad generalization
> about devices. The specifics of whether MAC or PHY timestamping is
> better will be device dependent.

As explained, except for specific PTP specialized PHY, the MAC is better in
term of PTP precision.
This patch was a requisite from Russell, who wanted to add support for the =
PTP
in the marvell PHY. Doing so would select the PHY PTP by default which caus=
e a
regression as the PHY hardware timestamp is less precise than the MAC.
https://lore.kernel.org/netdev/20200729105807.GZ1551@shell.armlinux.org.uk/
https://lore.kernel.org/netdev/Y%2F4DZIDm1d74MuFJ@shell.armlinux.org.uk/
There is also discussion on how to support it in older version of this seri=
es.
=20
> It looks like you introduce a default_timestamp flag to ensure existing
> devices default to PHY? I assume your goal here is to discourage this
> and not allow setting it for new devices? Or do we want to let device
> driver authors decide which is a better default?

Yes to not change the old behavior the current PHY with PTP support will st=
ill
behave as default PTP. The point is indeed to discourage future drivers to
select the PHY as default PTP.

> > Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Overall this makes sense, with a couple questions I had during review.
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>=20
> > ---
> > diff --git a/include/linux/phy.h b/include/linux/phy.h
> > index bd68f9d8e74f..e7a38137211c 100644
> > --- a/include/linux/phy.h
> > +++ b/include/linux/phy.h
> > @@ -616,6 +616,8 @@ struct macsec_ops;
> >   *                 handling shall be postponed until PHY has resumed
> >   * @irq_rerun: Flag indicating interrupts occurred while PHY was suspe=
nded,
> >   *             requiring a rerun of the interrupt handler after resume
> > + * @default_timestamp: Flag indicating whether we are using the phy
> > + *		       timestamp as the default one =20
>=20
> This is clearly intended to ensure existing drivers maintain legacy
> behavior. But what is our policy going forward for new devices? Do we
> want to leave it up to PHY driver authors?

Yes, new devices should not set this flag.

> > diff --git a/net/core/timestamping.c b/net/core/timestamping.c
> > index 04840697fe79..3717fb152ecc 100644
> > --- a/net/core/timestamping.c
> > +++ b/net/core/timestamping.c
> > @@ -25,7 +25,8 @@ void skb_clone_tx_timestamp(struct sk_buff *skb)
> >  	struct sk_buff *clone;
> >  	unsigned int type;
> > =20
> > -	if (!skb->sk)
> > +	if (!skb->sk || !skb->dev ||
> > +	    !phy_is_default_hwtstamp(skb->dev->phydev)) =20
>=20
> I don't follow why this check is added and its not calling something
> like "phy_is_current_hwtstamp"? I guess because we don't yet have a way
> to select between MAC/PHY at this point in the series? Ok.

skb_clone_tx_timestamp is only used for PHY timestamping so we should do no=
thing
if the default PTP is the MAC.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

