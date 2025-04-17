Return-Path: <netdev+bounces-183742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC334A91C9B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 768BD7A8449
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225EB24394F;
	Thu, 17 Apr 2025 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ld2woqDD"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B39245007;
	Thu, 17 Apr 2025 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893844; cv=none; b=GqEw4cNuqQ6oecMk9hLvEN+rbM+vYrtVEoGIusyjsUS9oo6fa3bp975aaO8OWiFN1OMCBdEfjhOYSXAx//mo9AXk+fUg0VkTIpBuKnHgqJL80k0HBTfRj2kHJCyjDSJDWZPZgU3fXB9g9MdmUCVSi2tD/2Rq9RwwxGnN4FnFu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893844; c=relaxed/simple;
	bh=r5+VfJcA6q9S12ZXAwVAe67Sk2WT28EwKDZnWFqwZQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcJKNygCybe0eK34+FoicJRWXtbEx7fOIrsPu0x2l87IyoL2fjk2pxyHLDrLO3u+I80PxCBGsKl6Ab9addJ+wdlJzyiQ2+O/Qq7S0Dyd8EMuKYiK4pweVMKWZq7sWQ9PKlp4LEflnDrSnyMDKQvo1+S+MeZx8lMsxB/SyaX6JA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ld2woqDD; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EB0943A13;
	Thu, 17 Apr 2025 12:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744893832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zufU3+K/sKPxmcFt6qRZblMLMAi4WpaGiVvI0GTB3Uc=;
	b=Ld2woqDDcMfyZnn7f56vCjolM1DtvQhent67HrJ2EoRcCrpySd07IDW8rb8lvY/fOlQ5yr
	Fuly8XIJDG1un47mkiuBScSTAtFnuLbkDPv7B6sZyksvkPSaK+qdLrEezrkWh8iXpJdfW0
	YGRYBuu0bk/+LxyCk3gwOfD+ZmQBczODsroK1JgLcGVKzz0pK4caGWJVGv4jA5ueyOsXZz
	RjiVK0B0fF0D/ZquawL3MTLV+llZaCEMKogE/UJeeLiBAw22Sa6eKfbE8ouCrdZziJJUuJ
	mhvGEfJcQJMSDhNvGzR9aBs5lNF736brKLxxigqHGPMdPtLkYuHo/aXFkfA+SQ==
Date: Thu, 17 Apr 2025 14:43:49 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 02/13] net: pse-pd: Add support for
 reporting events
Message-ID: <20250417144349.5b30afec@fedora.home>
In-Reply-To: <20250416-feature_poe_port_prio-v8-2-446c39dc3738@bootlin.com>
References: <20250416-feature_poe_port_prio-v8-0-446c39dc3738@bootlin.com>
	<20250416-feature_poe_port_prio-v8-2-446c39dc3738@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdelvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuefhfefggfdthffghfdvhffhhfetuedtkeetgffhteevheehjeejgfduieduhedunecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdeipdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhig
 idruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi K=C3=B6ry,

On Wed, 16 Apr 2025 15:44:17 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> Add support for devm_pse_irq_helper() to register PSE interrupts and repo=
rt
> events such as over-current or over-temperature conditions. This follows a
> similar approach to the regulator API but also sends notifications using a
> dedicated PSE ethtool netlink socket.
>=20
> Introduce an attached_phydev field in the pse_control structure to store
> the phydev attached to the PSE PI, ensuring that PSE ethtool notifications
> are sent to the correct network interface.
>=20
> The attached_phydev pointer is directly tied to the PHY lifecycle. It
> is set when the PHY is registered and cleared when the PHY is removed.
> There is no need to use a refcount, as doing so could interfere with
> the PHY removal process.
>=20
> Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

[...]

> +void ethnl_pse_send_ntf(struct phy_device *phydev, unsigned long notifs,
> +			struct netlink_ext_ack *extack)
> +{
> +	struct net_device *netdev =3D phydev->attached_dev;
> +	struct genl_info info;
> +	void *reply_payload;
> +	struct sk_buff *skb;
> +	int reply_len;
> +	int ret;
> +
> +	if (!netdev || !notifs)
> +		return;
> +
> +	ethnl_info_init_ntf(&info, ETHTOOL_MSG_PSE_NTF);
> +	info.extack =3D extack;
> +
> +	reply_len =3D ethnl_reply_header_size() +
> +		    nla_total_size(sizeof(u32)); /* _PSE_NTF_EVENTS */
> +
> +	skb =3D genlmsg_new(reply_len, GFP_KERNEL);

I think you need to check skb here before using it.

> +	reply_payload =3D ethnl_bcastmsg_put(skb, ETHTOOL_MSG_PSE_NTF);
> +	if (!reply_payload)
> +		goto err_skb;
> +
> +	ret =3D ethnl_fill_reply_header(skb, netdev,
> +				      ETHTOOL_A_PSE_NTF_HEADER);
> +	if (ret < 0)
> +		goto err_skb;
> +
> +	if (nla_put_u32(skb, ETHTOOL_A_PSE_NTF_EVENTS, notifs))
> +		goto err_skb;
> +
> +	genlmsg_end(skb, reply_payload);
> +	ethnl_multicast(skb, netdev);
> +	return;
> +
> +err_skb:
> +	nlmsg_free(skb);
> +}
> +EXPORT_SYMBOL_GPL(ethnl_pse_send_ntf);
>=20

Maxime

