Return-Path: <netdev+bounces-176537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB72DA6AB32
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900298A60A5
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2677E1F03F2;
	Thu, 20 Mar 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lu5rWYvO"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD81494BB;
	Thu, 20 Mar 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488613; cv=none; b=SLXwRt7VDmnvW9EZfC9AprIuiqWzmXpzcml242udvpQmanUM59rn0Qa1gMQyy3eCxu0qgdiSSF9ohS5YSO7b/hiqiS0NC33Q27vRbLcRiPYGScM/t5wb67DoiqHE+9NzsTHb+SswBP4BkRmKY+UnsOOCv7o6sAem5+vGEac4hNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488613; c=relaxed/simple;
	bh=YXVqbVeVIKDqEpFHM8lG7P6fgwKwgBVmmcaK0LD6kbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlM/AUoXlYDMCyJO6nnm3immSupMh2hMkEtvRRgInhncrwWjlAj1eoeLqMKzGD9s3KqUG0pPdM2gnW3SjQEuVn+F+VwF5iGCdKbLpVLBrIATBFPiuw+G0i61WN11s8BNX1eU4BTll5sOl1qzELkQeOFNpdrPEK7pV9tHWUWqpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lu5rWYvO; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D884D442B6;
	Thu, 20 Mar 2025 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742488608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtuWMqe5D/7dd/JWm7IoDbt/FVQIu6yV1QX98bDnazA=;
	b=Lu5rWYvO6k16XHHriAU09wBhzlzyrg+L5x5KICiZRj7YuNRj9pJC3za66Kie+wK3CtahLs
	aLtkfIdFdNUHwt+sdA+5K0oY8FfMcLN20S4GgCU6viI5Ar5gbgqLVoTnIt/lPEFXVyU3eE
	Xang9OmzUTvU8xQrnZoevJGyAyO5xoTKyCHzC8YgkZPuvNeNKLGKidO37bJcmRbaQmmKV+
	RqY+F5JhrUN60RMtmmCVpHT6y6Wx+cyB5J5CJffC+Z+YOgxt4o2HcJ2WNcp+3YGcH6NuGY
	V6Yu0+d7MbxYCgYYXpZ6S1Z1BSBQbbVfXCB0b/qZVZE1EeVrMYKwpVBszRJpKQ==
Date: Thu, 20 Mar 2025 17:36:45 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 08/12] net: pse-pd: pd692x0: Add support for
 PSE PI priority feature
Message-ID: <20250320173645.4ec7db84@kmaincent-XPS-13-7390>
In-Reply-To: <Z9ghgq8zlXKsVjOW@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-8-3dc0c5ebaf32@bootlin.com>
	<Z9ghgq8zlXKsVjOW@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehku
 hgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 17 Mar 2025 14:20:02 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Tue, Mar 04, 2025 at 11:18:57AM +0100, Kory Maincent wrote:
> >  static u8 pd692x0_build_msg(struct pd692x0_msg *msg, u8 echo)
> > @@ -739,6 +755,29 @@ pd692x0_pi_get_actual_pw(struct pse_controller_dev
> > *pcdev, int id) return (buf.data[0] << 4 | buf.data[1]) * 100;
> >  }
> > =20
> > +static int
> > +pd692x0_pi_get_prio(struct pse_controller_dev *pcdev, int id)
> > +{
> > +	struct pd692x0_priv *priv =3D to_pd692x0_priv(pcdev);
> > +	struct pd692x0_msg msg, buf =3D {0};
> > +	int ret;
> > +
> > +	ret =3D pd692x0_fw_unavailable(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	msg =3D pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_PARAM];
> > +	msg.sub[2] =3D id;
> > +	ret =3D pd692x0_sendrecv_msg(priv, &msg, &buf);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (buf.data[2] < 1 || 3 < buf.data[2]) =20
>=20
> if (!buf.data[2] || buf.data[2] > pcdev->pis_prio_max + 1)

Oh indeed that is better, thanks!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

