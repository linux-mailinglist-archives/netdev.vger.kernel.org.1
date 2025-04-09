Return-Path: <netdev+bounces-180869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1272BA82BC0
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237447AC293
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626481D54F7;
	Wed,  9 Apr 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OM01lotl"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADD61CB332;
	Wed,  9 Apr 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214661; cv=none; b=Yb+2UlxK1a8j2oW46qcwa1T7nB7KbKtjmh9DAIjxI+RO083wcfFEPfLh1EEnmq617gn5bytm3MPKIoFEDUkglgSM6EtV9xNNhOOOgT+oVFWOKJqkPIzY0YSZ5db8wKxoPZvchtOWRjkEnR0J8UNw9u5NVsvo53M06i1JWoq0qhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214661; c=relaxed/simple;
	bh=8j1as58KzeYb+hX/4p0f7gY7sP0ztLj+fMyzpwWCqfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANMxtHXwELFnhpNV8rb8MQVszTRfvRFe1dy/bcp+ghc+woDT14+ALSyQoWjDlqBVpedCckbptX03q++Dfh6iF5Iyix8OG4NYYc7qLZeUmlVo02P1Vu64QfJnzk70Q6MVAFEj9kIFgqKNPWVjyR9QMV4xoKNMiGVJ1JAHDVt/ALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OM01lotl; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 578FF444DA;
	Wed,  9 Apr 2025 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744214656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8j1as58KzeYb+hX/4p0f7gY7sP0ztLj+fMyzpwWCqfE=;
	b=OM01lotltkLqlXuM0lDSFwBFbK4JSMYGz8Dl5U81p5bzHj7IWhp69NdYvX8LMk92KUDtGi
	SrySuVftNDzUysP2iK8nvoufUWb+bclWa3zqphbzDPYtYHpmyOZNGKVBCnUv+i6ysuiP7O
	ARHt5g+An4EN4D9zWQtW2GqnqrJfPq+rQrZxv5zJva0Hy9PjmmlzCIrVZtpcDHpvmjiujW
	pYu6FXWlqHT/jT2xqUQ2C57LK9Nt/5z5Zuj5UR+8nl2vAbkGjJLMcUT+bH057uFwxnA5n5
	vYrjR8l+O/AHke5oqwxN/QeiSl0ktBxHSiNR1IFXQHobCKXTg/ToQPo5G3WLDQ==
Date: Wed, 9 Apr 2025 18:04:14 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <20250409180414.19e535e5@kmaincent-XPS-13-7390>
In-Reply-To: <Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
	<20250408154934.GZ395307@horms.kernel.org>
	<Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
	<20250409101808.43d5a17d@kmaincent-XPS-13-7390>
	<Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
	<20250409104858.2758e68e@kmaincent-XPS-13-7390>
	<Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
	<20250409143820.51078d31@kmaincent-XPS-13-7390>
	<Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeigeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghms
 egurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 9 Apr 2025 14:35:17 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Apr 09, 2025 at 02:38:20PM +0200, Kory Maincent wrote:
> > Ok, thanks for the tests and these information.
> > Did you run ptp4l with this patch applied and did you switch to Marvell=
 PHY
> > PTP source? =20
>=20
> This was using mvpp2, but I have my original patch as part of my kernel
> rather than your patch.

So you are only testing the mvpp2 PTP. It seems there is something broken w=
ith
it. I don't think it is related to my work.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

