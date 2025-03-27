Return-Path: <netdev+bounces-177902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DBEA72B66
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 09:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E0C16959D
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 08:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264AD2054E9;
	Thu, 27 Mar 2025 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KZgKVwiF"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B5204F87;
	Thu, 27 Mar 2025 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063865; cv=none; b=AHFjsXqHH7rBsYkX8xg5rjNNkkEfvxwTqTzaDYKi+gQeQF5tqi5cfeCsLAbdTFavoXsMeFKDyCbDmktgCePqsz1LPKzvPVO/v9Kom7MuTiNLmhOn/2GdyfvrOxUDb5mbA9lG5td3CDkO+VsUI60kyAp7xzeapioOfG5M95hTzxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063865; c=relaxed/simple;
	bh=Oo9S+xOjeLws4diGw62TueYch40yhype9WmT5f8Bm7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLr7ZyVYtxMzPg58fLtQLaNWrVmeE++GSWGc/XHR8Fbr3BROJ9d5TxDUw42Jbv9tjlMzQQuWtlijY7qsh5HzAEvvmQDDwVbgNXoUfNORTkUXS3LNRKUK4P6XiGbByZ9p15aNWQ8moSyAzTKPfD0gmsrXkJZqeYdM/gLDgYDXBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KZgKVwiF; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9D49442AC;
	Thu, 27 Mar 2025 08:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743063860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cakyJcamr6ifEel+JnINPPg6H4O22U1iqk8+y8IL+AY=;
	b=KZgKVwiFiDok0zNj49lyw5D4FkrgzsyLYQZvEGSYYA3irgreWf+6l2q+DBOU56ZnJW5wsA
	z0kySULXDZJbPwysZ5bPRlOYDYGHyKTb2BscqmY/nEe3wXLd4eCAYwWyOmlECFjeOFiu7K
	gAVC69qbrDQlfHlDzceJSEbEC7bzpCi0nUTP26F4hk8G0heA57Qc5inu17yd/EYMldik4C
	CRYKF/+tBLAcUN512/gEL00e6oIuWFcPIGQFhtNwL6XzLKcFSNicyu4U/vlhod3XCHVC4L
	WgvvXoKcSeHuLxgtu73pYV+r1iHHyry3owRj5DjRgtUF/GCU9WC+ikfUUk6Juw==
Date: Thu, 27 Mar 2025 09:24:18 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Eric Woudstra <ericwouds@gmail.com>, Daniel Golle
 <daniel@makrotopia.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 3/4] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <20250327092418.78f55466@fedora-2.home>
In-Reply-To: <20250326233512.17153-4-ansuelsmth@gmail.com>
References: <20250326233512.17153-1-ansuelsmth@gmail.com>
	<20250326233512.17153-4-ansuelsmth@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieejledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveeiveeghefgkeegtdelvdelueeileehgeeiffdtuefhledvudefleehgeetveegnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtoheprghnshhuvghlshhmthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtr
 dhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Christian,

On Thu, 27 Mar 2025 00:35:03 +0100
Christian Marangi <ansuelsmth@gmail.com> wrote:

> Add support for Aeonsemi AS21xxx 10G C45 PHYs. These PHYs integrate
> an IPC to setup some configuration and require special handling to
> sync with the parity bit. The parity bit is a way the IPC use to
> follow correct order of command sent.
>=20
> Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> AS21210PB1 that all register with the PHY ID 0x7500 0x7510
> before the firmware is loaded.
>=20
> They all support up to 5 LEDs with various HW mode supported.
>=20
> While implementing it was found some strange coincidence with using the
> same logic for implementing C22 in MMD regs in Broadcom PHYs.
>=20
> For reference here the AS21xxx PHY name logic:
>=20
> AS21x1xxB1
>     ^ ^^
>     | |J: Supports SyncE/PTP
>     | |P: No SyncE/PTP support
>     | 1: Supports 2nd Serdes
>     | 2: Not 2nd Serdes support
>     0: 10G, 5G, 2.5G
>     5: 5G, 2.5G
>     2: 2.5G
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
=09
 [...]

I know this is only RFC, but I have some questions

> +static int as21xxx_match_phy_device(struct phy_device *phydev,
> +				    const struct phy_driver *phydrv)
> +{
> +	struct as21xxx_priv *priv;
> +	u32 phy_id;
> +	int ret;
> +
> +	/* Skip PHY that are not AS21xxx or already have firmware loaded */
> +	if (phydev->c45_ids.device_ids[MDIO_MMD_PCS] !=3D PHY_ID_AS21XXX)
> +		return phydev->phy_id =3D=3D phydrv->phy_id;
> +
> +	/* Read PHY ID to handle firmware just loaded */
> +	ret =3D phy_read_mmd(phydev, MDIO_MMD_PCS, MII_PHYSID1);
> +	if (ret < 0)
> +		return ret;
> +	phy_id =3D ret << 16;
> +
> +	ret =3D phy_read_mmd(phydev, MDIO_MMD_PCS, MII_PHYSID2);
> +	if (ret < 0)
> +		return ret;=09
> +	phy_id |=3D ret;
> +
> +	/* With PHY ID not the generic AS21xxx one assume
> +	 * the firmware just loaded
> +	 */
> +	if (phy_id !=3D PHY_ID_AS21XXX)
> +		return phy_id =3D=3D phydrv->phy_id;
> +
> +	/* Allocate temp priv and load the firmware */
> +	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mutex_init(&priv->ipc_lock);
> +
> +	ret =3D aeon_firmware_load(phydev);
> +	if (ret)
> +		return ret;

Here, and below, you leak priv by returning early.

> +
> +	ret =3D aeon_ipc_sync_parity(phydev, priv);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable PTP clk if not already Enabled */
> +	ret =3D phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
> +			       VEND1_PTP_CLK_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D aeon_dpc_ra_enable(phydev, priv);
> +	if (ret)
> +		return ret;

Does all of the above with sync_parity, PTP clock cfg and so on needs
to be done in this first pass of the matching process for this PHY ?

=46rom what I got from the discussions, the only important bit is to load
the FW to get the correct PHY id ?

> +	mutex_destroy(&priv->ipc_lock);
> +	kfree(priv);
> +
> +	/* Return not maching anyway as PHY ID will change after
> +	 * firmware is loaded.
> +	 */
> +	return 0;
> +}

Maxime

