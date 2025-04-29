Return-Path: <netdev+bounces-186738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F00AA0BB2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DD117D55C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 12:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2ED2C2AB3;
	Tue, 29 Apr 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c5BJl+7K"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0F524F;
	Tue, 29 Apr 2025 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929779; cv=none; b=O/GAyftsfEUKRpu4dsJZ4XmgQ4YO0XVo1IJH6Dm5Xq47+9QqM4POtRCHmSsfhZAc1dhYdMIkN5q+r24fpxuBkF7cdwxukxV/Od0XDysMYs/rJAe9RzttVQRzHoDsCX1lZpdnQvTWxbRRN+pJiJyiXWmSwWBLk0/GDJ0fVbAx3bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929779; c=relaxed/simple;
	bh=R4hIbiasEfWJ6KpbYMDWZDcsupzXecQo/dfwa/BA+Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2ndm0DCaa0MvEXquYd2sJmL9WznTyIbS5slqcS3sGitNAKvotXbsHiifRBXwYXfVWwxIHEa0yG1M8jlrNsaLR0qFfsIuPKkrFIcDEh8YLbrwFHATApEgB2l7x0byscxvbd6eUaXnQcGZ8RqYfkuv+8z7+pBWS1P9qiId9cV+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c5BJl+7K; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4381243AF0;
	Tue, 29 Apr 2025 12:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745929775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omuNp2b6rybMb7GMAP26voHy5cNldstelBvz6qt6wuY=;
	b=c5BJl+7KmJVkPYdSDB5vSRXnvCdO1iSQhgT6po339KJX9iYhcnvYkj8SCRk1eiBGkCLVzB
	NGwM6Atw+QlakitMYQQwOGboBiKAAB+Xvk/i0GWFs8bWzvaza0n05VWKpOG0vOOYmvADQE
	UUCyjGq23ka66F5kt1HgrF3XpHqqihb6TpaI3WAHZJQIZtqZJTD+0bf/SYaBJP7PBCPCI0
	0q5tAgboqQsKKOtzOhjefCpmpYcyvyONVR5H0yNahEL8RW4z/2xynLxM5PUx7kFhsio2Ya
	MAgbY+QC2U4nn+TFQeLBkGlATZyztb9awAC+YXZZaMH9tEy+kWb3X4Zpo0itPA==
Date: Tue, 29 Apr 2025 14:29:32 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 03/13] net: pse-pd: tps23881: Add support
 for PSE events and interrupts
Message-ID: <20250429142932.718a8415@kmaincent-XPS-13-7390>
In-Reply-To: <366c8743-224b-4715-a2ff-399b16996621@redhat.com>
References: <20250422-feature_poe_port_prio-v9-0-417fc007572d@bootlin.com>
	<20250422-feature_poe_port_prio-v9-3-417fc007572d@bootlin.com>
	<366c8743-224b-4715-a2ff-399b16996621@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughum
 hgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 29 Apr 2025 11:07:04 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 4/22/25 4:56 PM, Kory Maincent wrote:
> > +/* Convert interrupt events to 0xff to be aligned with the chan
> > + * number.
> > + */
> > +static u8 tps23881_irq_export_chans_helper(u16 reg_val, u8 field_offse=
t)
> > +{
> > +	u8 val;
> > +
> > +	val =3D (reg_val >> (4 + field_offset) & 0xf0) |
> > +	      (reg_val >> field_offset & 0x0f); =20
>=20
> I'm probably low on coffee but I don't see why the above could not be
> replaced with:
>=20
> 	return reg_val >> field_offset;
>=20
> (given that the return type is u8)

Shift takes precedence to bit operation.
So the calculation is like:
val =3D ((reg_val >> (4 + field_offset)) & 0xf0) |=20
      ((reg_val >> field_offset) & 0x0f)

Supposing reg_val =3D 0xabcd;

- If field_offset =3D 0, we return 0xbd;
- If field_offset =3D 4, we return 0xac

Regards
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

