Return-Path: <netdev+bounces-129776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE5098603B
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616FC287F04
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298D219CC16;
	Wed, 25 Sep 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TzCck2oX"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD419C555;
	Wed, 25 Sep 2024 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268417; cv=none; b=C0PrQaE714RI83+9o8PIiajZGZqM+gq5nWzLkiVWR4FhmoHrTsaD4k2Y3eTDxb8J4ENIPcrX0qfLwmmyLaUvuF2l4gE1lsILR8bzwoUiLmyYV9BfHn65i6tDc9x04+WpGwitnX15Bdc60pi1i1kOSTRrD1DGS5HhbB904D6fJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268417; c=relaxed/simple;
	bh=+h73NwMo5znLu2Ew+i3I2VkupHos0y5Ye4/mBWE8h+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyyrmv/xb0lXAvGtBDuxg/4n/hhpKR23r7ThSvLaT5GxOixfoXQXCCPQ18widt+Ly8yt0YY32TcoHzP2jQobQxNtzuuT6PC/JlDN2s2zPjK+d7l1o1qa4JikinrXnFkiYEIqz4m9FbRcJAP/3hIafLAfIOjixqvS5CwMHx3MQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TzCck2oX; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7CE84240007;
	Wed, 25 Sep 2024 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727268412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ykqGoCKyoZGe85lSwP80aytv9ilQyJvt2Y/G75BsUSk=;
	b=TzCck2oXif/neky+oze7S7hIvR+rneHWHSQod443z/rgmML+WiiWBSjX2q1Z4gyqueUVd6
	BslqbwZp5FHma3Y/8KWsi5randgJqIxzwXwuvP2inFuR3jaqKySj0TSIVYKwBugrkQCNgk
	3pc057P0Cm6jsfgKlODq44gsfc/34xgGwXdNET9FCBPSbO3Uz90U/bMbSaGUXeb0VrIIsg
	drbow4nG2N1oljv5krCDMplerSiLmnwozJQxa+tC9TxtlGtv+cgRT82JD4Wubp0pa4bMc3
	VtydWbYZl6eNWXro7T3eli5JZgBFeUmW+G2zWKic8GvhkmpDWvmcER5y8kw7Kg==
Date: Wed, 25 Sep 2024 14:46:49 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, "Broadcom internal
 kernel review list" <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, "Andy Gospodarek" <andy@greyhouse.net>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 "Horatiu Vultur" <horatiu.vultur@microchip.com>,
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
Message-ID: <20240925144649.086b9771@kmaincent-XPS-13-7390>
In-Reply-To: <e4de7c23-ffee-42f6-aba8-b10f3d44f22c@intel.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
	<20240709-feature_ptp_netnext-v17-4-b5317f50df2a@bootlin.com>
	<39c7fe45-fbee-4de5-ab43-bf042ed31504@intel.com>
	<20240727154426.7ba30ed9@kmaincent-XPS-13-7390>
	<e4de7c23-ffee-42f6-aba8-b10f3d44f22c@intel.com>
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

Hello Jacob,

On Mon, 29 Jul 2024 11:08:01 -0700
Jacob Keller <jacob.e.keller@intel.com> wrote:

Sorry for answering it so late. I was a bit busy.

> >>> --- a/net/core/timestamping.c
> >>> +++ b/net/core/timestamping.c
> >>> @@ -25,7 +25,8 @@ void skb_clone_tx_timestamp(struct sk_buff *skb)
> >>>  	struct sk_buff *clone;
> >>>  	unsigned int type;
> >>> =20
> >>> -	if (!skb->sk)
> >>> +	if (!skb->sk || !skb->dev ||
> >>> +	    !phy_is_default_hwtstamp(skb->dev->phydev))   =20
> >>
> >> I don't follow why this check is added and its not calling something
> >> like "phy_is_current_hwtstamp"? I guess because we don't yet have a way
> >> to select between MAC/PHY at this point in the series? Ok. =20
> >=20
> > skb_clone_tx_timestamp is only used for PHY timestamping so we should do
> > nothing if the default PTP is the MAC.
> >  =20
>=20
> I guess my misunderstanding is what about the case where user selects
> PHY timestamping with the netlink command? Then it would still need to
> do the skb_clone_tx_timestamp even though its not the default? Or does
> phy_is_default_hwtstamp take that into account? In which case it would
> make more sense to name it phy_is_current_hwtstamp.
>=20
> Either way this is mostly bikeshedding and probably just some
> misunderstanding in my reading of the code.

In fact the phy_is_default_hwtstamp() is only needed in case of no netlink
command used. As you can see in patch 8, we call it only if dev->hwtstamp is
null which mean that a netlink command has been sent.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

