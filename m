Return-Path: <netdev+bounces-169896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B212A464B6
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AEE1880650
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4708122FDEC;
	Wed, 26 Feb 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R9LQM1rT"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7B227B9A;
	Wed, 26 Feb 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583616; cv=none; b=I/d4zklgoExMj8O0datio2wEEWXtWqpTsxqA56HPI2uNwrOqKfAiAlI7jZqsSyWCWg8f1VfeMT5KxwtSbq0Nb0Wlg4BbDm4pn6wHu8AAu+B6HOCgXfwr5jhG1cES6jqJTFJsnb6OCtcRJwsZMplJY0exYX9eISIHO3ofIINdYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583616; c=relaxed/simple;
	bh=Px0TsxbCfQ9bAXB7TeNIXcIiDKaORZDXwBKEcQweDUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAnuY6I0cjCt6fdVBrDHfFNCcFdqnLDz+ptit0UEABdxdOuhFlYhy5sJcvHHmk7ui0aWA1tPZ0JLS2dpvT0UPVEQJ55Vn9mBIsm+99P2R96aLH+tcmsmWE5yXVOrissgKVw/qbT/7q6cgzCKS+3TnLIbWB/EPGRb1W/mtzPEGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R9LQM1rT; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3D44442DF;
	Wed, 26 Feb 2025 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740583611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYxcMPGYKbGinA0gFQqz77Ivwma0qnrykC+7U+WLLDY=;
	b=R9LQM1rTBbQzW/3h544Dab7/s3B629oLhkrD52C73nvXc+5k5Xht4xixV5VXZlH1rRTdKp
	FtF3Gqa9/6k4ieSgvAJzFWhnyWuvJszk0L45OQYO5GJoG3jVzEIEpKBfHutHBGE/O7A+IG
	M+3BISZ2dOB66QbBhrPmZ3ctvmTx1zOYp4eUOn+fVUks6JG3Gwe1r/WfC9/3wrCVZz8dCU
	alNVGDSZ/Cf6lYdhe1owXO8Kh147ldzivqk/Mt/CKq3a5wFFhICoiqPM+OpIFxpzz24yQE
	EOQCUPjvyGr8TM5S+tfFaU1QT+lraNlF8KqDUFdOe/a+c/DItAkjVQAdEeINDQ==
Date: Wed, 26 Feb 2025 16:26:49 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for FS SFP-10GM-T copper
 SFP+ module
Message-ID: <20250226162649.641bba5d@kmaincent-XPS-13-7390>
In-Reply-To: <d03103b9cab4a1d2d779b3044f340c6d@dev.tdt.de>
References: <20250226141002.1214000-1-ms@dev.tdt.de>
	<Z78neFoGNPC0PYjt@shell.armlinux.org.uk>
	<d03103b9cab4a1d2d779b3044f340c6d@dev.tdt.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemleehrggvmeelfhdttdemrggsvggtmedugehfjeemvgdviegrmedufegttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeelhegrvgemlehftddtmegrsggvtgemudegfhejmegvvdeirgemudeftgdtpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehmshesuggvvhdrthguthdruggvpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfiesl
 hhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 26 Feb 2025 15:50:46 +0100
Martin Schiller <ms@dev.tdt.de> wrote:

> On 2025-02-26 15:38, Russell King (Oracle) wrote:
> > On Wed, Feb 26, 2025 at 03:10:02PM +0100, Martin Schiller wrote: =20
> >> Add quirk for a copper SFP that identifies itself as "FS"=20
> >> "SFP-10GM-T".
> >> It uses RollBall protocol to talk to the PHY and needs 4 sec wait=20
> >> before
> >> probing the PHY.
> >>=20
> >> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> >> ---
> >>  drivers/net/phy/sfp.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> >> index 9369f5297769..15284be4c38c 100644
> >> --- a/drivers/net/phy/sfp.c
> >> +++ b/drivers/net/phy/sfp.c
> >> @@ -479,9 +479,10 @@ static const struct sfp_quirk sfp_quirks[] =3D {
> >>  	// PHY.
> >>  	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
> >>=20
> >> -	// Fiberstore SFP-2.5G-T uses Rollball protocol to talk to the
> >> PHY and
> >> -	// needs 4 sec wait before probing the PHY.
> >> +	// Fiberstore SFP-2.5G-T and SFP-10GM-T uses Rollball protocol to=20
> >> talk
> >> +	// to the PHY and needs 4 sec wait before probing the PHY.
> >>  	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_fs_2_5gt),
> >> +	SFP_QUIRK_F("FS", "SFP-10GM-T", sfp_fixup_fs_2_5gt), =20
> >=20
> > Which makes sfp_fixup_fs_2_5gt mis-named. Please rename. =20
>=20
> OK, I'll rename it to sfp_fixup_rollball_wait.

I would prefer sfp_fixup_fs_rollball_wait to keep the name of the manufactu=
rer.
It can't be a generic fixup as other FSP could have other waiting time valu=
es
like the Turris RTSFP-10G which needs 25s.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

