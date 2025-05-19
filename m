Return-Path: <netdev+bounces-191496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D705ABBA57
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BF03A54CA
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4AA202960;
	Mon, 19 May 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RUgAbfbT"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3631E7C23;
	Mon, 19 May 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648486; cv=none; b=JPeVBnMnd0m3L+XHMXmBK1FILmLNXjIaFjN/3E817AiK9VkWXuvWJdXX2rMmt7UvJVWJyjx+CywPxoklo5tk4R7ECIinIpGgUa6Imnsi8xQKfsrfSkfvgIr0V9SaiX6J/R+mkieEBHo6WQKNM1l5b2NuuO5+VgQh8ImgyDlLyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648486; c=relaxed/simple;
	bh=QtuSnniUfqIpFx7jG8UHI+yTW35b28R08n0ZlEpEQlI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ro5zXdE49kB4ZAVAE6NCYLvZmFfFSvr2X+7CVTNvRymI+XZBgGtfr5TAmgi0D2Ao42jo9+FNDnLJzxpHtU0jsEIY/Nw7rQyWoLzsS8V5h4S+soXyv76Kn4WycBnoAJ9gh0WhxLb1uowT7TDlmpQX46XQQloJRCmYyhDG+MI/28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RUgAbfbT; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ADD95439EF;
	Mon, 19 May 2025 09:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747648481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwLUAK0HIanJR49tKGatSZUNIVksD3vcYe87IuvaxcU=;
	b=RUgAbfbT0y5CTEnQaX3/qavcIwUxQSPajtNpzSKTpczUkGWtATsMQNHJ5vVwf/SqpooaHw
	26mad0v9SUdEHsCyhNtQSDTPagnFzFRPeoHiEN/1508uR8ZuylC+rNLYkWZiRpjtEpDXrc
	4hV8r92CqMLlMC85fkt3u79gFhH3d3QHxHaIywYJO1UcdvduC6XvBFs5k4q+OknvBQa8Ww
	vFHzSkRW39RRim+qS/SA15YTNvgS2E7Q9UeA3W1SJ90ZBg1T78aojmz9sePHNbxyFfFXSS
	33clbXrRiCth48GNHNWvlaoC30kdhsCJGh/Ab2DH//YmFaVvuGwhqqsCHq+OKg==
Date: Mon, 19 May 2025 11:54:39 +0200
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
Subject: Re: [PATCH net-next v3 2/2] net: pse-pd: Add Si3474 PSE controller
 driver
Message-ID: <20250519115439.35382771@kmaincent-XPS-13-7390>
In-Reply-To: <584b7975-1544-4833-8f8a-00a8769a80c2@adtran.com>
References: <f975f23e-84a7-48e6-a2b2-18ceb9148675@adtran.com>
	<584b7975-1544-4833-8f8a-00a8769a80c2@adtran.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqheftdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfejveefgeeggefhgfduhfehvdevvdeukeelveejuddvudethfdvudegtdefledunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepphhiohhtrhdrkhhusghikhesrgguthhrrghnrdgtohhmpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvt
 hdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 16 May 2025 13:07:18 +0000
Piotr Kubik <piotr.kubik@adtran.com> wrote:

> From: Piotr Kubik <piotr.kubik@adtran.com>
>=20
> Add a driver for the Skyworks Si3474 I2C Power Sourcing Equipment
> controller.
>=20
> Based on the TPS23881 driver code.
>=20
> Driver supports basic features of Si3474 IC:
> - get port status,
> - get port power,
> - get port voltage,
> - enable/disable port power.
>=20
> Only 4p configurations are supported at this moment.

By curiosity, I suppose your hardware have only PoE4 PIs. Could you support=
 and
test 2p configuration by only configuring 2 of the 4 pairs on one PI?

Maybe it could be done on a second stage if you prefer.

>=20
> Signed-off-by: Piotr Kubik <piotr.kubik@adtran.com>

...

> +	is_enabled =3D ((ret & (0x03 << (2 * (chan0 % 4)))) |
> +		      (ret & (0x03 << (2 * (chan1 % 4))))) !=3D 0;

There are precedence in the operators. I don't think you need that much of
parenthesis.
This should do the work:
is_enabled =3D (ret & 0x03 << chan0 % 4 * 2) |
             (ret & 0x03 << chan1 % 4 * 2) !=3D 0;

Also I saw that this kind of calculation is made several times. Maybe you c=
ould
add a helper with documentation like I did:
https://elixir.bootlin.com/linux/v6.14.7/source/drivers/net/pse-pd/tps23881=
.c#L79=20

> +/* Parse pse-pis subnode into chan array of si3474_priv */
> +static int si3474_get_of_channels(struct si3474_priv *priv)
> +{
> +	struct device_node *pse_node;
> +	struct pse_pi *pi;
> +	u32 pi_no, chan_id;
> +	s8 pairset_cnt;
> +	s32 ret =3D 0;
> +
> +	pse_node =3D of_get_child_by_name(priv->np, "pse-pis");
> +	if (!pse_node) {
> +		dev_warn(&priv->client[0]->dev,
> +			 "Unable to parse DT PSE power interface matrix, no
> pse-pis node\n");
> +		return -EINVAL;
> +	}

You should not parse the pse-pis node and subnodes, it is already done befo=
re
the setup_pi_matrix ops call in the core framework.
https://elixir.bootlin.com/linux/v6.14.7/source/drivers/net/pse-pd/pse_core=
.c#L131

You should rather use directly the pcdev->pi[x] table. You have to match the
the phandle save in pcdev->pi[x].pairset[0/1].np to your channel device node
and set up the hardware matrix accordingly.

That's good to have another development on PSE, this shows me that document=
ation
are missing or not enough in PSE core like on this ops. I will update it wh=
en I
have time.

> +
> +	for_each_child_of_node_scoped(pse_node, node) {
> +		if (!of_node_name_eq(node, "pse-pi"))
> +			continue;
> +
> +		ret =3D of_property_read_u32(node, "reg", &pi_no);
> +		if (ret) {
> +			dev_err(&priv->client[0]->dev,
> +				"Failed to read pse-pi reg property\n");
> +			goto out;
> +		}
> +		if (pi_no >=3D SI3474_MAX_CHANS) {
> +			dev_err(&priv->client[0]->dev,
> +				"Invalid power interface number %u\n",
> pi_no);
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +

...

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
> +	chan0 =3D priv->pi[id].chan[0];
> +	chan1 =3D priv->pi[id].chan[1];
> +
> +	if (chan0 < 4)
> +		client =3D priv->client[0];
> +	else
> +		client =3D priv->client[1];
> +
> +	/* Release pi from shutdown */
> +	ret =3D i2c_smbus_read_byte_data(client, PORT_MODE_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	val =3D (u8)ret;
> +	val |=3D (0x03 << (2 * (chan0 % 4)));
> +	val |=3D (0x03 << (2 * (chan1 % 4)));

Same calculation as before, use a helper as said before.

> +
> +	ret =3D i2c_smbus_write_byte_data(client, PORT_MODE_REG, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Give time for transition to complete */
> +	ssleep(1);

1s sleep?! It is a lot. Why do you need this? Does it comes from the datash=
eet?

> +
> +	/* Trigger pi to power up */
> +	val =3D (BIT(chan0 % 4) | BIT(chan1 % 4));
> +	ret =3D i2c_smbus_write_byte_data(client, PB_POWER_ENABLE_REG, val);
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
> +	chan0 =3D priv->pi[id].chan[0];
> +	chan1 =3D priv->pi[id].chan[1];
> +
> +	if (chan0 < 4)
> +		client =3D priv->client[0];
> +	else
> +		client =3D priv->client[1];
> +
> +	/* Trigger pi to power down */
> +	val =3D (BIT((chan0 % 4) + 4) | BIT((chan1 % 4) + 4));

This calculation is also used several times. Please use a helper with
documentation.

> +	ret =3D i2c_smbus_write_byte_data(client, PB_POWER_ENABLE_REG, val);
> +
> +	/* Shutdown pi */
> +	ret =3D i2c_smbus_read_byte_data(client, PORT_MODE_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	val =3D (u8)ret;
> +	val &=3D ~(0x03 << (2 * (chan0 % 4)));
> +	val &=3D ~(0x03 << (2 * (chan1 % 4)));

Use a helper.

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
> +
> +	if (chan < 4)
> +		client =3D priv->client[0];
> +	else
> +		client =3D priv->client[1];
> +
> +	/* Registers 0x30 to 0x3d */
> +	reg =3D PORT1_CURRENT_LSB_REG + (chan % 4) * 4;

Idem

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
> +
> +	if (chan < 4)
> +		client =3D priv->client[0];
> +	else
> +		client =3D priv->client[1];
> +
> +	/* Registers 0x32 to 0x3f */
> +	reg =3D PORT1_VOLTAGE_LSB_REG + (chan % 4) * 4;

Idem

> +
> +	ret =3D i2c_smbus_read_word_data(client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	val =3D ret * SI3474_UV_STEP;
> +
> +	return (int)val;
> +}

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

