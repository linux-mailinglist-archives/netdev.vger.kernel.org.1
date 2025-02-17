Return-Path: <netdev+bounces-167048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA26A388F2
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289D81679CA
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1A32253ED;
	Mon, 17 Feb 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CGN7mBl2"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E0225404;
	Mon, 17 Feb 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808907; cv=none; b=ehTi4OkRDCreC1JX6imV9/2WLXTqrGr6ERdNeNS2REPn+PfkFicKCbRKYIxTvjsB+qHA1sGpqx7iB5RAjonTlnI+x/ymTraxwTdDKEV9KnpCbLBGCCLyioMtc3KUgEzuYeohQ95lAssSrV10mgO7cWCdnrZa8LfD+US5ZLEFuKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808907; c=relaxed/simple;
	bh=l46BqOFjw4AhN6v4MslaecuDquLIk/2juU4bc70f7k8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrZlhvDCVBmDpoOMg1HYff5sNezPmcv1nn0Hw2z7O+lTzg5v089BHTtL9Ej/7gvEeFV0wdngwRt70ISPKfUooSgbT2U4spzx7WlkAbwjZEbNN2c9ZTZQgdBtu7xJO1DruUrYqU+ZUagZucLr9FgGwL4FpXJoqiAErKmviCOFFA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CGN7mBl2; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31BB6442B2;
	Mon, 17 Feb 2025 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739808903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCAruAplvrh9CTzplEZWARPcYnJG6c4oelg/rF1mVsk=;
	b=CGN7mBl2DhZF4inxJfydz6QAbL2Ah/LtgMvjvqcgbVCh1NYe54rkEMGmp4azvouUcF2WxO
	fnNWUAzRrYkQdoBUvvchu9MisFxvr9q6hza//jR53pWbOOE2vNaOmhnvl+pTlbZMUb+PvN
	NLK+8v260wabceWfy+1BjIKl1j+xlLg+rGbuc5bkxUDvPOhd1zv93ySEsErYZ4XtfRyYz4
	+c/apWLc2eqDXb05/DGOnV9+E5tiIBcIeiYi3xw77/pk4LMUYkrwDxBnz414ZSsuEGbSnO
	vP2tomFo6lRN0DLWhZEo/dLH2YsWI7N4R4QZWL5rqBZuXnXWhBbdV27DgW/zww==
Date: Mon, 17 Feb 2025 17:15:00 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: pd692x0: Fix power limit retrieval
Message-ID: <20250217171500.0fd4a519@kmaincent-XPS-13-7390>
In-Reply-To: <bb058f5f-31f2-4c20-848e-54c178ecaf6c@lunn.ch>
References: <20250217134812.1925345-1-kory.maincent@bootlin.com>
	<bb058f5f-31f2-4c20-848e-54c178ecaf6c@lunn.ch>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnu
 higqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 17 Feb 2025 16:24:44 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Mon, Feb 17, 2025 at 02:48:11PM +0100, Kory Maincent wrote:
> > Fix incorrect data offset read in the pd692x0_pi_get_pw_limit callback.
> > The issue was previously unnoticed as it was only used by the regulator
> > API and not thoroughly tested, since the PSE is mainly controlled via
> > ethtool.
> >=20
> > The function became actively used by ethtool after commit 3e9dbfec4998
> > ("net: pse-pd: Split ethtool_get_status into multiple callbacks"),
> > which led to the discovery of this issue.
> >=20
> > Fix it by using the correct data offset.
> >=20
> > Fixes: a87e699c9d33 ("net: pse-pd: pd692x0: Enhance with new current li=
mit
> > and voltage read callbacks") Signed-off-by: Kory Maincent
> > <kory.maincent@bootlin.com> ---
> >  drivers/net/pse-pd/pd692x0.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
> > index fc9e23927b3b..7d60a714ca53 100644
> > --- a/drivers/net/pse-pd/pd692x0.c
> > +++ b/drivers/net/pse-pd/pd692x0.c
> > @@ -1047,7 +1047,7 @@ static int pd692x0_pi_get_pw_limit(struct
> > pse_controller_dev *pcdev, if (ret < 0)
> >  		return ret;
> > =20
> > -	return pd692x0_pi_get_pw_from_table(buf.data[2], buf.data[3]);
> > +	return pd692x0_pi_get_pw_from_table(buf.data[0], buf.data[1]); =20
>=20
> Would the issue of been more obvious if some #defines were used,
> rather than magic numbers?

We would need lots of defines as the offset of the useful data can
change between each command. Don't know if it would have been better.=20

On my current patch priority series.
git grep "buf\." drivers/net/pse-pd/pd692x0.c | wc -l
29

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

