Return-Path: <netdev+bounces-208208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17096B0A968
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 19:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4752B5A2CE8
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383D2E6D26;
	Fri, 18 Jul 2025 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dxnHCWua"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A117A586;
	Fri, 18 Jul 2025 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859604; cv=none; b=S0p0KrAoGnoiZMvdXsCfsdV75e3XQTiOWTfgoUtg7naXz9uSVpEJ4urXDDfklh2hua93LdPQ9LcRYbvwnH28hUnwsFMt7Te1jW5rxyX3WLvC+ELqjciaOmhYkcgIm30bpOr8wPST38fZb1gB3h9u1BxldR9/EHPvdflCaWQ7nbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859604; c=relaxed/simple;
	bh=da1mvWxza9iINiLn1/BRsDyg7r50P57JvCmMN1cPmWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IG2NckMtfG/6IDoRaVRtZnZzxmkTgjjfwrJjt17MgSMxhWvxmj+16UaZ3GPdnjDT7DKTFyqt9r/HtKuRrHQmNrrcyjEtU2kbNApwq3J9Z9aQLjvYZ4CODR/NztfxSNwRsXUdbACLbH6d/8jxVAXN0CP+J100aVW7650Y4aP6Pdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dxnHCWua; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F08F43988;
	Fri, 18 Jul 2025 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752859599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOm/XILhExfpLJ0fE/lDLC2xmFMxLGZpbBGVUQulu5A=;
	b=dxnHCWuaujOcfol5xBWDnegkPHq/XumRW9ZPddOFDDgT1MIYfhNWJvCUQ/bzNWn/bhsJ8T
	7XMQjbdnKZONiFlvJHZaSlyFeKq9BLoUHdSjm0yIPXuU0UoHn5iYw3bpFiKD5jqSmMonQ+
	+gwfOsDeO/tsNZtVnx/1sCquSgrVmWetb7isuAzuLedpCkF12+T+/+aQDmqt0QeqpBEMGu
	CNEndGkTnffB6dTJpv9SOsSU5Gd2cSoFNy6dWWXhtwdSTwI2Z9cZoZ5W3WdhE3/WuRWYIy
	dHTKZbx+zca+TksEBf/nGV+14yXe9cDx/ZdmoHB9Ff0YIUfSlxBlm2WgmxbJ4g==
Date: Fri, 18 Jul 2025 19:26:38 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Piotr Kubik <piotr.kubik@adtran.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 2/2] net: pse-pd: Add Si3474 PSE controller
 driver
Message-ID: <20250718192638.681ef327@kmaincent-XPS-13-7390>
In-Reply-To: <b2361682-05fe-4a38-acfd-2191f7596711@adtran.com>
References: <be0fb368-79b6-4b99-ad6b-00d7897ca8b0@adtran.com>
	<b2361682-05fe-4a38-acfd-2191f7596711@adtran.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigedtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduheemfegvgeemtgehtddtmeekvddttgemiegvtddumeejkegrtgemvdgtugefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduheemfegvgeemtgehtddtmeekvddttgemiegvtddumeejkegrtgemvdgtugefpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehpihhothhrrdhkuhgsihhksegrughtrhgrnhdrtghomhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhto
 heprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

Le Fri, 11 Jul 2025 11:25:02 +0000,
Piotr Kubik <piotr.kubik@adtran.com> a =C3=A9crit :

> From: Piotr Kubik <piotr.kubik@adtran.com>
>=20
> Add a driver for the Skyworks Si3474 I2C Power Sourcing Equipment
> controller.
>=20
> Driver supports basic features of Si3474 IC:
> - get port status,
> - get port power,
> - get port voltage,
> - enable/disable port power.
>=20
> Only 4p configurations are supported at this moment.
>=20
> Signed-off-by: Piotr Kubik <piotr.kubik@adtran.com>
> ---

It would be nice to have the patch changes description here.

...

> +static int si3474_pi_get_admin_state(struct pse_controller_dev *pcdev, i=
nt
> id,
> +				     struct pse_admin_state *admin_state)
> +{
> +	struct si3474_priv *priv =3D to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	s32 ret;
> +	u8 chan0, chan1;
> +	bool is_enabled =3D false;

I think you forgot to fix the xmas style here.=20

> +	if (id >=3D SI3474_MAX_CHANS)
> +		return -ERANGE;
> +
> +	si3474_get_channels(priv, id, &chan0, &chan1);
> +	client =3D si3474_get_chan_client(priv, chan0);
> +
> +	ret =3D i2c_smbus_read_byte_data(client, PORT_MODE_REG);
> +	if (ret < 0) {
> +		admin_state->c33_admin_state =3D
> +			ETHTOOL_C33_PSE_ADMIN_STATE_UNKNOWN;
> +		return ret;
> +	}
> +
> +	is_enabled =3D (ret & CHAN_MASK(chan0)) |
> +		     (ret & CHAN_MASK(chan1));
> +
> +	if (is_enabled)
> +		admin_state->c33_admin_state =3D
> +			ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
> +	else
> +		admin_state->c33_admin_state =3D
> +			ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
> +
> +	return 0;
> +}
> +
> +static int si3474_pi_get_pw_status(struct pse_controller_dev *pcdev, int=
 id,
> +				   struct pse_pw_status *pw_status)
> +{
> +	struct si3474_priv *priv =3D to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	s32 ret;
> +	u8 chan0, chan1;
> +	bool delivering =3D false;

And here.

> +
> +	if (id >=3D SI3474_MAX_CHANS)
> +		return -ERANGE;
> +
> +	si3474_get_channels(priv, id, &chan0, &chan1);
> +	client =3D si3474_get_chan_client(priv, chan0);
> +
> +	ret =3D i2c_smbus_read_byte_data(client, POWER_STATUS_REG);
> +	if (ret < 0) {
> +		pw_status->c33_pw_status =3D
> ETHTOOL_C33_PSE_PW_D_STATUS_UNKNOWN;
> +		return ret;
> +	}
> +
> +	delivering =3D ret & (CHAN_UPPER_BIT(chan0) | CHAN_UPPER_BIT(chan1));
> +
> +	if (delivering)
> +		pw_status->c33_pw_status =3D
> +			ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
> +	else
> +		pw_status->c33_pw_status =3D
> ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;=20
> +
> +	return 0;
> +}
> +
> +static int si3474_get_of_channels(struct si3474_priv *priv)
> +{
> +	struct pse_pi *pi;
> +	u32 chan_id;
> +	s32 ret;
> +	u8 pi_no;

And here.

> +
> +	for (pi_no =3D 0; pi_no < SI3474_MAX_CHANS; pi_no++) {
> +		pi =3D &priv->pcdev.pi[pi_no];
> +		u8 pairset_no;
> +
> +		for (pairset_no =3D 0; pairset_no < 2; pairset_no++) {
> +			if (!pi->pairset[pairset_no].np)
> +				continue;
> +
> +			ret =3D
> of_property_read_u32(pi->pairset[pairset_no].np,
> +						   "reg", &chan_id);
> +			if (ret) {
> +				dev_err(&priv->client[0]->dev,
> +					"Failed to read channel reg
> property\n");
> +				return ret;
> +			}
> +			if (chan_id > SI3474_MAX_CHANS) {
> +				dev_err(&priv->client[0]->dev,
> +					"Incorrect channel number: %d\n",
> chan_id);
> +				return ret;
> +			}
> +
> +			priv->pi[pi_no].chan[pairset_no] =3D chan_id;
> +			/* Mark as 4-pair if second pairset is present */
> +			priv->pi[pi_no].is_4p =3D (pairset_no =3D=3D 1);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int si3474_setup_pi_matrix(struct pse_controller_dev *pcdev)
> +{
> +	struct si3474_priv *priv =3D to_si3474_priv(pcdev);
> +	s32 ret;
> +
> +	ret =3D si3474_get_of_channels(priv);
> +	if (ret < 0) {
> +		dev_warn(&priv->client[0]->dev,
> +			 "Unable to parse DT PSE power interface matrix\n");
> +	}
> +	return ret;
> +}
> +
> +static int si3474_pi_enable(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct si3474_priv *priv =3D to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	s32 ret;
> +	u8 chan0, chan1;
> +	u8 val =3D 0;

And here.

> +
> +	if (id >=3D SI3474_MAX_CHANS)
> +		return -ERANGE;
> +
> +	si3474_get_channels(priv, id, &chan0, &chan1);
> +	client =3D si3474_get_chan_client(priv, chan0);
> +
> +	/* Release PI from shutdown */
> +	ret =3D i2c_smbus_read_byte_data(client, PORT_MODE_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	val =3D (u8)ret;
> +	val |=3D CHAN_MASK(chan0);
> +	val |=3D CHAN_MASK(chan1);
> +
> +	ret =3D i2c_smbus_write_byte_data(client, PORT_MODE_REG, val);
> +	if (ret)
> +		return ret;
> +
> +	/* DETECT_CLASS_ENABLE must be set when using AUTO mode,
> +	 * otherwise PI does not power up - datasheet section 2.10.2
> +	 */
> +	val =3D CHAN_BIT(chan0) | CHAN_UPPER_BIT(chan0) |
> +	      CHAN_BIT(chan1) | CHAN_UPPER_BIT(chan1);
> +
> +	ret =3D i2c_smbus_write_byte_data(client, DETECT_CLASS_ENABLE_REG,
> val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int si3474_pi_disable(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct si3474_priv *priv =3D to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	s32 ret;
> +	u8 chan0, chan1;
> +	u8 val =3D 0;

And here, and other places in the patch. Are you sure you did it as you
described in your cover letter?
The code seems ok otherwise.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

