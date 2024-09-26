Return-Path: <netdev+bounces-129899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B75986F32
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B84E2865E3
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 08:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E477192594;
	Thu, 26 Sep 2024 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lNTazN9P"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A822214884C;
	Thu, 26 Sep 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340445; cv=none; b=JL12vieBiFaU7qccMDAqjykP8D+BqOa42tgvl4WnFeA4twyI1UCKP2t56YvhrEnt44QBfeFBtH+ZoeGNALnhuhDLXq1b1kIcdfNuHpK2buA8LUJGBAKP9N0AUMH/iGhj5fkLWpKU63vBWH24vvmjZTZnMJPPmVP76TBFaJp4cFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340445; c=relaxed/simple;
	bh=U4bxZTwT2YaLl+cJuAaGnd5Xz6gw3YAeiyLLHefNmK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bt+FCcOliBX0ji2wqnq4gBgQI4bpkoZqRSAp6XQOFYgkgW4q/+eRoO5GXXx1UcerZWCj6MRMgBqR+twSZpTT7MpswnR5UhYH6yq7/SYfh9oij3rysADJyQsNu0B+EkZt0bjDUByMZDmNdCFsuWV0yrPaeWcnTOEnnBoW03sHoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lNTazN9P; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E8701C000F;
	Thu, 26 Sep 2024 08:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727340435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ9Wisee95FqaPjfkdd5lfW+HMn3+ekkbZ+x5uP4V4E=;
	b=lNTazN9P1SF3c5yc3oqWbAwmS4Vrtxmw84oD7vL/mJ+IN9lAFDW2RyOxgCfbVHDAfYjD+a
	tSO9CXIhduKnVg20dNubp5tU3KTS0ISP+Kceeem6osuYCUdq7X8rWL0tUQI2+koHt//nBP
	usHWfv2yqp+Tx9yL9KctHMk1KoC0gXipG9lbtIANK6/OOs47+jSS9RpHCoYcPb/HtSpwlo
	MBOwNAlEEsC2UGQWWsJmRJLTgT1MaofX6IOnIaAxuqYsed2/Yc+6Gq8dwLPk97MIbhW7/l
	HEtm9godSlOjhX9es9tLluZiGBAR+PGzOgqGnEOsL9m8Jvd4/zm4C7+Tg07UBA==
Date: Thu, 26 Sep 2024 10:47:12 +0200
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
 Oltean <vladimir.oltean@nxp.com>, donald.hunter@gmail.com,
 danieller@nvidia.com, ecree.xilinx@gmail.com, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v17 13/14] net: ethtool: Add support for
 tsconfig command to get/set hwtstamp config
Message-ID: <20240926104712.6a55d263@kmaincent-XPS-13-7390>
In-Reply-To: <20240715075926.7f3e368c@kernel.org>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-13-b5317f50df2a@bootlin.com>
 <20240715075926.7f3e368c@kernel.org>
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

Hello Jakub,=20

On Mon, 15 Jul 2024 07:59:26 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

Thanks for the review and sorry for the late reply.

> On Tue, 09 Jul 2024 15:53:45 +0200 Kory Maincent wrote:
> > +	/* Get the hwtstamp config from netlink */
> > +	if (tb[ETHTOOL_A_TSCONFIG_TX_TYPES]) {
> > +		ret =3D ethnl_parse_bitset(&req_tx_type, &mask,
> > +					 __HWTSTAMP_TX_CNT,
> > +					 tb[ETHTOOL_A_TSCONFIG_TX_TYPES],
> > +					 ts_tx_type_names, info->extack);
> > +		if (ret < 0)
> > +			goto err_clock_put;
> > +
> > +		/* Select only one tx type at a time */
> > +		if (ffs(req_tx_type) !=3D fls(req_tx_type)) {
> > +			ret =3D -EINVAL;
> > +			goto err_clock_put;
> > +		}
> > +
> > +		hwtst_config.tx_type =3D ffs(req_tx_type) - 1;
> > +	}
> > +	if (tb[ETHTOOL_A_TSCONFIG_RX_FILTERS]) {
> > +		ret =3D ethnl_parse_bitset(&req_rx_filter, &mask,
> > +					 __HWTSTAMP_FILTER_CNT,
> > +					 tb[ETHTOOL_A_TSCONFIG_RX_FILTERS],
> > +					 ts_rx_filter_names, info->extack);
> > +		if (ret < 0)
> > +			goto err_clock_put;
> > +
> > +		/* Select only one rx filter at a time */
> > +		if (ffs(req_rx_filter) !=3D fls(req_rx_filter)) {
> > +			ret =3D -EINVAL;
> > +			goto err_clock_put;
> > +		}
> > +
> > +		hwtst_config.rx_filter =3D ffs(req_rx_filter) - 1;
> > +	}
> > +	if (tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS]) {
> > +		ret =3D nla_get_u32(tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS]);
> > +		if (ret < 0)
> > +			goto err_clock_put;
> > +		hwtst_config.flags =3D ret;
> > +	} =20
>=20
> We should be tracking mod on these, too. Separately from the provider
> mod bit, let's not call the driver and send notification if nothing
> changed.

Ok
=20
> > +	ret =3D net_hwtstamp_validate(&hwtst_config);
> > +	if (ret)
> > +		goto err_clock_put;
> > +
> > +	/* Disable current time stamping if we try to enable another one */
> > +	if (mod && (hwtst_config.tx_type || hwtst_config.rx_filter)) {
> > +		struct kernel_hwtstamp_config zero_config =3D {0};
> > +
> > +		ret =3D dev_set_hwtstamp_phylib(dev, &zero_config,
> > info->extack);
> > +		if (ret < 0)
> > +			goto err_clock_put;
> > +	}
> > +
> > +	/* Changed the selected hwtstamp source if needed */
> > +	if (mod) {
> > +		struct hwtstamp_provider *__hwtstamp;
> > +
> > +		__hwtstamp =3D rcu_replace_pointer_rtnl(dev->hwtstamp,
> > hwtstamp);
> > +		if (__hwtstamp)
> > +			call_rcu(&__hwtstamp->rcu_head,
> > +				 remove_hwtstamp_provider);
> > +	}
> > +
> > +	ret =3D dev_set_hwtstamp_phylib(dev, &hwtst_config, info->extack);
> > +	if (ret < 0)
> > +		return ret; =20
>=20
> We can't unwind to old state here?

Yes indeed we could unwind old state here. I will update it in next version.

> Driver can change hwtst_config right? "upgrade" the rx_filter=20
> to a broader one, IIRC. Shouldn't we reply to the set command with=20
> the resulting configuration, in case it changed? Basically provide=20
> the same info as the notification would.

Yes, the driver does that.
Indeed that's a good idea to report the resulting configuration.
I will take a look at how I can do that.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

