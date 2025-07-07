Return-Path: <netdev+bounces-204586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3617FAFB441
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34397420B60
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C446529B8D2;
	Mon,  7 Jul 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LuRDEal+"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A235422A7F9;
	Mon,  7 Jul 2025 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894272; cv=none; b=PErIBo3LpallQ2qQC9ohCftDE0PBabgQaYsiPtJQbol3CZk8I8S6d/5OPiOeBpak4fn50zg0+0cY/4jvRLzsvQ4x14M4jqn3j041vbfibb7Ufz1xpVkSK3pg+lXJeo1PdR131qa/sIzujoKiDg0RZKTRRSAamgeEZZy164jiOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894272; c=relaxed/simple;
	bh=ZGwESFngTCsEdDYfI482+mp1zN4bQJN4DTuppqkhipI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQx2FrHk9gT/WaDFRWkQ5Q2HntGEwAKJlYQmtahV0cjnP12/pIgKoDwDuPLx6kXoxP+eYm44iwryNHT+Ap9Fn5WPRB5M2cFmSqqwOo3wxleUkZsJJWnQw7IVhDClRN/gfEXo08lHZg9O4t4uCNhCuJ8O+2NoUWAsx+t73fbb3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LuRDEal+; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 066DA44447;
	Mon,  7 Jul 2025 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751894261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXd+NKR2+V5gBU2aTB6qQ13tw22ax0OUiOXnrJOt35U=;
	b=LuRDEal+PF8KirAT0KavTQ0yAhFGW1hKCEJDvKkCiYN44QTOTekHx9xZAexiY360GIMTvo
	/mKwMDkHYbhECfnuL+fn/k9uuier8khQDQiwd8m+avuc9koZavtpZMWn3FIVOQcaPI5egk
	70ydXONCEZsiTqAwbeesnHdq2HymEL+GQPpReDc2NRdpZCx4wMrTAgYcE6wAPydHmmpaes
	2qLyAcOXf7HbceP4JcxgHE2s1XpYipDSfJPEAzH386Fsir9UpW7mLvWioqtzJ8sEmUf1WB
	iE8Wq5+cJkSffePy35LkTSgkkU6qeESraT3xGpsZh86klT5Szw129cLGlEm5ng==
Date: Mon, 7 Jul 2025 15:17:38 +0200
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
Subject: Re: [PATCH net-next v4 2/2] net: pse-pd: Add Si3474 PSE controller
 driver
Message-ID: <20250707151738.17a276bc@kmaincent-XPS-13-7390>
In-Reply-To: <4e55abda-ba02-4bc9-86e6-97c08e4e4a2d@adtran.com>
References: <c0c284b8-6438-4163-a627-bbf5f4bcc624@adtran.com>
	<4e55abda-ba02-4bc9-86e6-97c08e4e4a2d@adtran.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdtleemkedtfegrmeehsggsgeemgedvjeehmehfrgegleemkeejuggsmegvgedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggstdelmeektdefrgemhegssgegmeegvdejheemfhgrgeelmeekjegusgemvgegvdegpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehpihhothhrrdhkuhgsihhksegrughtrhgrnhdrtghomhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpt
 hhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

Le Mon, 30 Jun 2025 14:57:09 +0000,
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

...

> +
> +static int si3474_pi_get_admin_state(struct pse_controller_dev *pcdev, i=
nt
> id,
> +				     struct pse_admin_state *admin_state)
> +{
> +	struct si3474_priv *priv =3D to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	bool is_enabled =3D false;
> +	u8 chan0, chan1;
> +	s32 ret;
> +
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
> +	is_enabled =3D ((ret & CHAN_MASK(chan0)) |
> +		      (ret & CHAN_MASK(chan1))) !=3D 0;

I don't think this "!=3D 0" check is needed here.
A bool is an int so it will be set even without this and the next condition
will work.

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

...

> +
> +static int si3474_pi_enable(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct si3474_priv *priv =3D to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	u8 chan0, chan1;
> +	u8 val =3D 0;
> +	s32 ret;
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

What happen in a PD disconnection case? According to the datasheet it simply
raise a disconnection interrupt and disconnect the power with a
DISCONNECT_PCUT_FAULT fault. But it is not clear if it goes back to the
detection + classification process. If it is not the case you will face the
same issue I did and will need to deal with the interrupt and the disconnec=
tion
management.

Could you try to enable a port, plug a PD then disconnect it and plug anoth=
er PD
which belong to another power class. Finally read the class detected to ver=
ify that the
class detected have changed.

> +	val =3D (CHAN_BIT(chan0) | CHAN_UPPER_BIT(chan0) |
> +	       CHAN_BIT(chan1) | CHAN_UPPER_BIT(chan1));
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
> +	u8 chan0, chan1;
> +	u8 val =3D 0;
> +	s32 ret;
> +
> +	if (id >=3D SI3474_MAX_CHANS)
> +		return -ERANGE;
> +
> +	si3474_get_channels(priv, id, &chan0, &chan1);
> +	client =3D si3474_get_chan_client(priv, chan0);
> +
> +	/* Set PI in shutdown mode */
> +	ret =3D i2c_smbus_read_byte_data(client, PORT_MODE_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	val =3D (u8)ret;
> +	val &=3D ~(CHAN_MASK(chan0));
> +	val &=3D ~(CHAN_MASK(chan1));
> +
> +	ret =3D i2c_smbus_write_byte_data(client, PORT_MODE_REG, val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int si3474_pi_get_chan_current(struct si3474_priv *priv, u8 chan)
> +{
> +	struct i2c_client *client;
> +	s32 ret;
> +	u8 reg;
> +	u64 tmp_64;

Reverse christmas tree please.

> +
> +	client =3D si3474_get_chan_client(priv, chan);
> +
> +	/* Registers 0x30 to 0x3d */
> +	reg =3D CHAN_REG(PORT1_CURRENT_LSB_REG, chan);
> +
> +	ret =3D i2c_smbus_read_word_data(client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	tmp_64 =3D ret * SI3474_NA_STEP;
> +
> +	/* uA =3D nA / 1000 */
> +	tmp_64 =3D DIV_ROUND_CLOSEST_ULL(tmp_64, 1000);
> +	return (int)tmp_64;
> +}
> +
> +static int si3474_pi_get_chan_voltage(struct si3474_priv *priv, u8 chan)
> +{
> +	struct i2c_client *client;
> +	s32 ret;
> +	u8 reg;
> +	u32 val;

Same.

> +
> +	client =3D si3474_get_chan_client(priv, chan);
> +
> +	/* Registers 0x32 to 0x3f */
> +	reg =3D CHAN_REG(PORT1_VOLTAGE_LSB_REG, chan);
> +
> +	ret =3D i2c_smbus_read_word_data(client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	val =3D ret * SI3474_UV_STEP;
> +
> +	return (int)val;
> +}
> +
> +static int si3474_pi_get_voltage(struct pse_controller_dev *pcdev, int i=
d)
> +{
> +	struct si3474_priv *priv =3D to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	u8 chan0, chan1;
> +	s32 ret;
> +
> +	si3474_get_channels(priv, id, &chan0, &chan1);
> +	client =3D si3474_get_chan_client(priv, chan0);
> +
> +	/* Check which channels are enabled*/
> +	ret =3D i2c_smbus_read_byte_data(client, POWER_STATUS_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Take voltage from the first enabled channel */
> +	if (ret & CHAN_BIT(chan0))
> +		ret =3D si3474_pi_get_chan_voltage(priv, chan0);
> +	else if (ret & CHAN_BIT(chan1))
> +		ret =3D si3474_pi_get_chan_voltage(priv, chan1);
> +	else
> +		/* 'should' be no voltage in this case */
> +		return 0;
> +
> +	return ret;
> +}
> +
> +static int si3474_pi_get_actual_pw(struct pse_controller_dev *pcdev, int=
 id)
> +{
> +	struct si3474_priv *priv =3D to_si3474_priv(pcdev);
> +	s32 ret;
> +	u32 uV, uA;
> +	u64 tmp_64;
> +	u8 chan0, chan1;

Same


Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

