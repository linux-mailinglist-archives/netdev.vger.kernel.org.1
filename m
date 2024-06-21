Return-Path: <netdev+bounces-105608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14735911F75
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED441F2424B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB5916E861;
	Fri, 21 Jun 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FHAqc9G9"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBC716D9C7;
	Fri, 21 Jun 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960057; cv=none; b=e6JoJtS26uPh47Ve2qmn5rcfqKKA0EI9YquXb/FkuszeteKwf6Vb3ZQTL4ubr3zqeLE0d2vy+o+S/Vh+9AMp9Ip9P425boPtuxRYuFZ70VzRqndzm5Rb2Heqpop2KEcdqpvDQ/DGKpXy4/6Zz4wCLFYCPuFklb8igpVScRxCujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960057; c=relaxed/simple;
	bh=I+i+aOzkOGompNR/7ELLGU0rPfoK8zPNywwKcT91Ckc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6So1nyjjPhjc9GGiLDLUAPTVfKFJG567EbRyhYutJijLqiSwJuNkELpyV6oEiQKAElgHaO2nH+oNbBvYySVqBub+RKoVLtrpDMEFhynM3ahmA1dd+ufnaJTL5uveG541yTMdXxLADhB7vdiFgc6HdO9eeLrV/Lka6hQigH94PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FHAqc9G9; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5EDDD1BF208;
	Fri, 21 Jun 2024 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718960052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JD45edoD5rUpwPloN7d/OFffiaD3jVvluuyCPi42kDU=;
	b=FHAqc9G97UNoty+XvEzr3zA16vh3jQ8NP3ceQTaHkPwv8XCt2Fp0/0rkcIgCgvZc1hzAf0
	yUa59H/4KIc1Re3sTHiRSiLSDx+MpHdvlEvtT3EjH41JHCaT+WYmTCdstDzY79roPtBJed
	DkDkrj+oHz5wQtPXWXi8yLI0UPTHcKh/eOllmLOL19gHQWTDvk930XC3gGxUcRXxsRUODx
	VtmihXBkmCLAkppGaHHr5ueO+ST+S45IBakzSb/AqNQPBkk9wE3IKtM521s5CQNUmmHXHA
	Tt5DXhFp2+Gb2SWkbZ68ctf/rTg+Bj4hqziqBUAkjgDXANOIHfF8UL3abVU+6w==
Date: Fri, 21 Jun 2024 10:54:08 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v15 13/14] net: ethtool: tsinfo: Add support
 for hwtstamp provider and get/set hwtstamp config
Message-ID: <20240621105408.6dda7a0e@kmaincent-XPS-13-7390>
In-Reply-To: <20240617184331.0ddfd08e@kernel.org>
References: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
	<20240612-feature_ptp_netnext-v15-13-b2a086257b63@bootlin.com>
	<20240617184331.0ddfd08e@kernel.org>
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

On Mon, 17 Jun 2024 18:43:31 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

Thanks for your review!

> On Wed, 12 Jun 2024 17:04:13 +0200 Kory Maincent wrote:
> > Enhance 'get' command to retrieve tsinfo of hwtstamp providers within a
> > network topology and read current hwtstamp configuration.
> >=20
> > Introduce support for ETHTOOL_MSG_TSINFO_SET ethtool netlink socket to
> > configure hwtstamp of a PHC provider. Note that simultaneous hwtstamp
> > isn't supported; configuring a new one disables the previous setting.
> >=20
> > Also, add support for a specific dump command to retrieve all hwtstamp
> > providers within the network topology, with added functionality for
> > filtered dump to target a single interface. =20
>=20
> Could you split this up, a little bit? It's rather large for a core
> change.

Ok I will do so.
=20
> >  Desired behavior is passed into the kernel and to a specific device by
> > -calling ioctl(SIOCSHWTSTAMP) with a pointer to a struct ifreq whose
> > -ifr_data points to a struct hwtstamp_config. The tx_type and
> > -rx_filter are hints to the driver what it is expected to do. If
> > -the requested fine-grained filtering for incoming packets is not
> > +calling the tsinfo netlink socket ETHTOOL_MSG_TSINFO_SET.
> > +The ETHTOOL_A_TSINFO_TX_TYPES, ETHTOOL_A_TSINFO_RX_FILTERS and
> > +ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS netlink attributes are then used to se=
t the
> > +struct hwtstamp_config accordingly. =20
>=20
> nit: EHTOOL_A* defines in `` `` quotes?

Ack.

>=20
> > +		if (hwtstamp && ptp_clock_phydev(hwtstamp->ptp) =3D=3D phydev)
> > {
> > +			rcu_assign_pointer(dev->hwtstamp, NULL);
> > +			synchronize_rcu();
> >  			kfree(hwtstamp); =20
>=20
> Could you add an rcu_head to this struct and use kfree_rcu()
> similarly later use an rcu call to do the dismantle?
> synchronize_rcu() can be slow.

Ack. I might need to use call_rcu() as I have to call ptp_clock_put also be=
fore
the kfree.
=20
> > +const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX +=
 1]
> > =3D { [ETHTOOL_A_TSINFO_HEADER]		=3D
> >  		NLA_POLICY_NESTED(ethnl_header_policy_stats),
> > +	[ETHTOOL_A_TSINFO_GHWTSTAMP] =3D
> > +		NLA_POLICY_MAX(NLA_U8, 1), =20
>=20
> I think this can be an NLA_FLAG, but TBH I'm also confused about=20
> the semantics. Can you explain what it does from user perspective?

As I described it in the documentation it replaces SIOCGHWTSTAMP:
"Any process can read the actual configuration by requesting tsinfo netlink
socket ETHTOOL_MSG_TSINFO_GET with ETHTOOL_MSG_TSINFO_GHWTSTAMP netlink
attribute set.

The legacy usage is to pass this structure to ioctl(SIOCGHWTSTAMP) in the  =
    =20
same way as the ioctl(SIOCSHWTSTAMP).  However, this has not been implement=
ed  =20
in all drivers."

The aim is to get rid of ioctls.

Indeed NLA_FLAG is the right type I should use.
=20
> > +	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER] =3D
> > +		NLA_POLICY_NESTED(ethnl_tsinfo_hwtstamp_provider_policy),
> >  };
> > =20
> > +static int tsinfo_parse_hwtstamp_provider(const struct nlattr *nest,
> > +					  struct hwtst_provider *hwtst,
> > +					  struct netlink_ext_ack *extack,
> > +					  bool *mod)
> > +{
> > +	struct nlattr
> > *tb[ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy)]; =20
>=20
> Could you find a more sensible name for this policy?

I am not a naming expert but "hwtstamp_provider" is the struct name I have =
used
to describe hwtstamp index + qualifier and the prefix of the netlink nested
attribute, so IMHO it fits well.
Have you another proposition to clarify what you would expect?
=20
> > +	int ret;
> > +
> > +	ret =3D nla_parse_nested(tb,
> > +
> > ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy) - 1,
> > +			       nest,
> > +			       ethnl_tsinfo_hwtstamp_provider_policy,
> > extack);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (NL_REQ_ATTR_CHECK(extack, nest, tb,
> > ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX) ||
> > +	    NL_REQ_ATTR_CHECK(extack, nest, tb,
> > ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER)) =20
>=20
> nit: wrap at 80 chars, if you can, please

Yes indeed, thanks!

> >  	struct tsinfo_reply_data *data =3D TSINFO_REPDATA(reply_base);
> > +	struct tsinfo_req_info *req =3D TSINFO_REQINFO(req_base);
> >  	struct net_device *dev =3D reply_base->dev;
> >  	int ret;
> > =20
> >  	ret =3D ethnl_ops_begin(dev);
> >  	if (ret < 0)
> >  		return ret;
> > +
> > +	if (req->get_hwtstamp) {
> > +		struct kernel_hwtstamp_config cfg =3D {};
> > +
> > +		if (!dev->netdev_ops->ndo_hwtstamp_get) {
> > +			ret =3D -EOPNOTSUPP;
> > +			goto out;
> > +		}
> > +
> > +		ret =3D dev_get_hwtstamp_phylib(dev, &cfg);
> > +		data->hwtst_config.tx_type =3D BIT(cfg.tx_type);
> > +		data->hwtst_config.rx_filter =3D BIT(cfg.rx_filter);
> > +		data->hwtst_config.flags =3D BIT(cfg.flags);
> > +		goto out; =20
>=20
> This is wrong AFAICT, everything up to this point was a nit pick ;)
> Please take a look at 89e281ebff72e6, I think you're reintroducing a
> form of the same bug. If ETHTOOL_FLAG_STATS was set, you gotta run stats
> init.
>=20
> Perhaps you can move the stats getting up, and turn this code into if
> / else if / else, without the goto.

Indeed thanks for spotting the issue.

> > +
> > +	if (ret =3D=3D -EMSGSIZE && skb->len)
> > +		return skb->len;
> > +	return ret; =20
>=20
> You can just return ret without the if converting to skb->len
> af_netlink will handle the EMSGSIZE errors in the same way.

Alright, thanks.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

