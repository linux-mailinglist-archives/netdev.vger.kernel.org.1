Return-Path: <netdev+bounces-200331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040DBAE4944
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A3D3A9026
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F4826D4F7;
	Mon, 23 Jun 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cqhA5rWB"
X-Original-To: netdev@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940BA25EF82;
	Mon, 23 Jun 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693908; cv=none; b=eGj2rZpr9LJkSeZA2LzjNpuTpHY0HzcTf5UE5vYXFwJe8mJzseJZ4BWiCpHRU41z8MYioBw8y6ruQqaztvF0EjAfNgi32ZAsFK0ECKfZh0Hg+cnsa2BuovYNPydyrt2B2DkYMi+6xYyoTInMs1I/GJ0+8Fh1ZAr0SA7PzFtv6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693908; c=relaxed/simple;
	bh=h4AVMYKSCrcTc9JYJnM3RTwqyK7hwOu18sc9aiNikIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgQtQzZfVNhOp0LTxu0X4MYyBEeKrpeu+DoFxFrWfx1RPq4/5SNhdWtMnCXR+FXwqWVrfMAQy/hTkVTu/VP7Ldq4o39wnVs3D7oLbnKS2rRLUreFxGyt4Pg+x3qxr06pEUe6vCZUz/3834Zs9mUxSNv0eheWsMD3wfIZaoaO3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cqhA5rWB; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAB9044A1F;
	Mon, 23 Jun 2025 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750693898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4AVMYKSCrcTc9JYJnM3RTwqyK7hwOu18sc9aiNikIQ=;
	b=cqhA5rWBKGfnwGDr8MdDoAJKA3fxBJKamPaUJS01dWNPaHzYUlu7oR2qF6y5gb8JjENZ/c
	EwZD2+WDsRxwihbN5/fXd4Qkdt4nokjzdBCA64uNMJrIRHC9OK4a3cQiy4mfb7KYl+e69h
	OKcKmCkyLKsA7jRo9M0AxeOzQ2r3mSSq4bKck7AM69Tt4v8o0Wz8rzBnKY2gH2qQ24JPy5
	fzqBLPLusX/mEoklOXkvRutS/7jX8VD8VY1LFrr2Xfp3sf/RtzbutSx70QjyvZ9284sv2E
	eKDxzxC1IHojLwgUIbeanpN6iEXA+cYoeXTXq6qLcqARiTcPn3u2PUCcFecRWw==
Date: Mon, 23 Jun 2025 17:51:35 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Kamil =?UTF-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>
Cc: <florian.fainelli@broadcom.com>,
 <bcm-kernel-feedback-list@broadcom.com>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <robh@kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: phy: bcm5481x: Implement MII-Lite
 mode
Message-ID: <20250623175135.5ddee2ea@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>
In-Reply-To: <20250623151048.2391730-2-kamilh@axis.com>
References: <20250623151048.2391730-1-kamilh@axis.com>
	<20250623151048.2391730-2-kamilh@axis.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeektdfhhfehleffjeegteetteehgedtgfekueeffffghedugfetlefgtdekteekieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdejiedriedvrddujedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdejiedriedvrddujedupdhhvghlohepvdgrtddvqdekgeegtddqugduudehqdgsvgdtugdqtggvtgdtqdgrvdgruddqsggtfegtqdeivddvvgdrrhgvvhdrshhfrhdrnhgvthdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehkrghmihhlhhesrgigihhsrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopegstghmqdhkvghrnhgvl
 hdqfhgvvggusggrtghkqdhlihhsthessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh

Hi Kamil,

On Mon, 23 Jun 2025 17:10:46 +0200
Kamil Hor=C3=A1k - 2N <kamilh@axis.com> wrote:

> From: Kamil Hor=C3=A1k (2N) <kamilh@axis.com>
>=20
> The Broadcom bcm54810 and bcm54811 PHYs are capable to operate in
> simplified MII mode, without TXER, RXER, CRS and COL signals as defined
> for the MII. While the PHY can be strapped for MII mode, the selection
> between MII and MII-Lite must be done by software.
> The MII-Lite mode can be used with some Ethernet controllers, usually
> those used in automotive applications. The absence of COL signal
> makes half-duplex link modes impossible but does not interfere with
> BroadR-Reach link modes on Broadcom PHYs, because they are full-duplex
> only. The MII-Lite mode can be also used on an Ethernet controller with
> full MII interface by just leaving the input signals (RXER, CRS, COL)
> inactive.

I'm following-up to Andrew's suggestion of making it a dedicated
phy-mode. You say that this requires only phy-side configuration,
however you also say that with MII-lite, you can't do half-duplex.

Looking at the way we configure the MAC to PHY link, how can the MAC
driver know that HD isn't available if this is a phy-only property ?

Relying on the fact that the PHYs that use MII-Lite will only ever
setup a full-duplex link with the partner seems a bit fragile, when we
could indicate that this new MII-Lite mode only supports 10FD/100FD,
through this mapping code here :

https://elixir.bootlin.com/linux/v6.16-rc2/source/drivers/net/phy/phy_caps.=
c#L282

Besides that, given that this is a physically different MAC to PHY
interface (missing signals compared to MII), one could also argue that
this warrants a dedicated phy-mode.

Maxime

