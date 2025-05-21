Return-Path: <netdev+bounces-192461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32195ABFF1E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31C54E754D
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BE023183C;
	Wed, 21 May 2025 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N9iu+Zqc"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1B1C32;
	Wed, 21 May 2025 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747864183; cv=none; b=S1Gt5TvNLTQFe/+PzDddiaKUVGV70cpXsvKIjDDLA4ypkjSI9gjdBZvEj/k6dqhoXNr7AC7xabJGp41tXKXP2OjxIUs28Cw+CfYywT/aa6FkmeCGuUXHqy4ZHYwLM/M9hAJlcA8LQIzJrmhkk7aWo0uTTIa6iQY3hxtB4CUs7yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747864183; c=relaxed/simple;
	bh=U9os5TII6LxXLLkJL9Ue1hk9ekAMkSZKxP2BFf8ugUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezWPbSlooPEoEKLwboMp3FuRv5165VtrHZ/EsKk4HntOCYJ3TKqg3+pdwUD1FA97KkL3ae31i7RqQD0XWSJItzhMGJa5g0N9hgO6KGZgggOJAciJK/T0lIJM5SDl3FrXPgYpS83ZhptvCFI4guHjSwnWxEyDHXI42zkhflcUasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N9iu+Zqc; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A537E43280;
	Wed, 21 May 2025 21:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747864177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72uLjnDwYtf0i/HOFO/K1hGBe6ZH7TCozYNfsiGSliY=;
	b=N9iu+ZqcXOgFyFT5sCwjl4yjWJAJBEHTItv2qfLgvMYzqDgI+fLT084NW7lVteM5VIEn4r
	hXJuYsgFVHOycPKj9ztDjD9MdEOC4OWRAQ8BtYeTPE7S4siNbzW1M+/a2lc15DGMSbfolQ
	1JG2LrdbLOoGhylsGM/+9dJDQjhFJ7z/COWly7xMtkY3RLSiIZsjsFtWgU/rC6d/hGdgbW
	wVYc0h5OTbYL1swadFnQJ5OV7XvrJkAQe6WwCsbNatk6ojOhQqhnm2xOR4MjwrIzPK4ZAM
	ptiuI1hdXkzMWU5OBZ8MSzXwffzddk74wQ3G583xMivuzC/P7AkRqxzyLUa5Zw==
Date: Wed, 21 May 2025 23:49:35 +0200
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
Message-ID: <20250521234935.7dad7f72@kmaincent-XPS-13-7390>
In-Reply-To: <e036f7e2-5e5d-40bc-b22c-6dbd6a34eb15@adtran.com>
References: <f975f23e-84a7-48e6-a2b2-18ceb9148675@adtran.com>
	<584b7975-1544-4833-8f8a-00a8769a80c2@adtran.com>
	<20250519115439.35382771@kmaincent-XPS-13-7390>
	<e036f7e2-5e5d-40bc-b22c-6dbd6a34eb15@adtran.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegvddtucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfduveekuedtvdeiffduleetvdegteetveetvdelteehhfeuhfegvdeuuedtleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemkeehkeejmeejuddttdemjegtvghfmegvjegtugemieejrgdvmegutdelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmeejtggvfhemvgejtggumeeijegrvdemugdtleehpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehpihhothhrrdhkuhgsihhksegrughtrhgrnhdrtghomhdprhgtphhtthhopehordhrvghmp
 hgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 21 May 2025 08:04:23 +0000
Piotr Kubik <piotr.kubik@adtran.com> wrote:

> On 5/19/25 11:54, Kory Maincent wrote:
> > On Fri, 16 May 2025 13:07:18 +0000
> > Piotr Kubik <piotr.kubik@adtran.com> wrote:
> >  =20
> >> From: Piotr Kubik <piotr.kubik@adtran.com>
> >>
> >> Add a driver for the Skyworks Si3474 I2C Power Sourcing Equipment
> >> controller.
> >>
> >> Based on the TPS23881 driver code.
> >>
> >> Driver supports basic features of Si3474 IC:
> >> - get port status,
> >> - get port power,
> >> - get port voltage,
> >> - enable/disable port power.
> >>
> >> Only 4p configurations are supported at this moment. =20

...

> >> +
> >> +	ret =3D i2c_smbus_write_byte_data(client, PORT_MODE_REG, val);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Give time for transition to complete */
> >> +	ssleep(1); =20
> >=20
> > 1s sleep?! It is a lot. Why do you need this? Does it comes from the
> > datasheet?=20
>=20
> This comes from my experience. I didn't find it in a datasheet.
> I agree this seems a lot, but for 500ms sometimes ports were not powered =
up.=20
> I think I'll give a try to another register and instead PB_POWER_ENABLE=20
> I will try to use PB_RESET in combination with PORT_MODE as this seems
> promising.
>=20
> btw. Regarding power enable/disable, I think you may have same issue in
> tps23881 as I had here as tps looks very similar to si3474.
> For Si3474 POWER_STATUS register cannot be used as an admin state registe=
r as
> it holds actual power interface status (powered/not powered) instead of i=
ts
> administrative state (enabled/disabled).=20
> Ethtool in this approach was showing for both Admin state and Detection
> status always the same state - actual status.
> PB_POWER_ENABLE register cannot be used for this purpose as well as it is=
 a
> write-only register. That's why I used PORT_MODE register, it acts like an
> admin state holder in my implementation.

Indeed I figured that the power status of the tps23881 can not be really
considered as an admin_state as described in the standard. For example, it
doesn't automatically power off in case of PD unplugged.
That's why I fixed it in the current budget evaluation strategy patch serie=
s.
The admin_state is now managed by software and the the PSE core will power =
on
the port if it catches a classification interrupt event or if a PD was alre=
ady
plugged and classify.
https://lore.kernel.org/netdev/20250520-feature_poe_port_prio-v11-12-bbaf44=
7e1b28@bootlin.com/

If the Si3474 behaves the same maybe you should rebase your patch on my ser=
ies.

But waiting this long won't be ok, as we have rtnl lock acquired here.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

