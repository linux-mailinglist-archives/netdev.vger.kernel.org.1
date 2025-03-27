Return-Path: <netdev+bounces-177947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092D7A73313
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9413AD19D
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D35A21516C;
	Thu, 27 Mar 2025 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d+Mf58ie"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC320E03B;
	Thu, 27 Mar 2025 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080951; cv=none; b=UPrVLo6nSM3FvJJkltwdoYO+LIUzKiYUgKkcXpWVCSSwY3VQN6HPNDAb099dNP9e3yNgdIicq3boM7r1HYXKdNvRps3DSh25w2NzAubxHrV4QXBMVj3O/u3whwvIBqRy4xrEj4r+FvUGTRtRU2cVJC4wOOwlEB/eIVDQwQDcEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080951; c=relaxed/simple;
	bh=Qeh6SQ0L5bAjAQ31KKCXGB4po7wDNkkVxT6qWMX6g/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkvkwPd1Rt3xFqKI8tnqxlfa0TuHIAayKsH4Dc39uSJpURV5BiZZKntlt+SxCZYkwOGpg09unt4lJixKisUDIM6ADHGIQaqCHd00QqV1ZPjnKyF5h/rGRcqfXcJXmatOSaWOb660n4F4wZN45txiqvOV/4j6ovAHUfpF6UHJbWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d+Mf58ie; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8332044350;
	Thu, 27 Mar 2025 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743080947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl39aCu7ftbbyjG6limkQhYT+AN9y9auh49IjHk2xq0=;
	b=d+Mf58ieFcrPUIVei3KukvPp9ftRuK0bwttzbIAAUyLiuTwh3OZSpmJYmw/WbWAfLpHPfC
	mn1E6KoU34kOL8KS5IoTf9dDAHLj9teImgTK8yaVuRJo1gue1+M2NDo9KdsxOCSKTQj2V9
	bmFyvLfJk7y5ZszGm5qIV5lxbwlBL+RE6Fk4Tj4GfWqpfZOpuAAVqaL5m5PjuZJx+gAV63
	lVvSjOdB/lSn+uclcwju/9ydoLeQol0LLwJ+ZkXgjD2Rj8n/DxkO/3OPH+tQpr/s0u61m4
	PPmy3fNBgD5feYLl35TTCzWDHxLxZB091c/HTMOz+lkDAKOeYUEQVmCVei6pVA==
Date: Thu, 27 Mar 2025 14:09:05 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: kernel test robot <oliver.sang@intel.com>, Andrew Lunn <andrew@lunn.ch>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org
Subject: Re: [linus:master] [net]  03abf2a7c6: WARNING:suspicious_RCU_usage
Message-ID: <20250327140905.26ab227b@kmaincent-XPS-13-7390>
In-Reply-To: <Z6OdkdI2ss19FyVT@shell.armlinux.org.uk>
References: <202502051331.7587ac82-lkp@intel.com>
	<Z6OdkdI2ss19FyVT@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekgeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudfgheelgeekffdugeejveegteeuheegiedvleegvdehudfgtdejfeegffejveehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpthgvrhhmsghinhdrtghomhdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepohhlihhvvghrrdhsrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehovgdqlhhkp
 heslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Hello Russell,

On Wed, 5 Feb 2025 17:19:13 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Feb 05, 2025 at 02:08:04PM +0800, kernel test robot wrote:
> > kernel test robot noticed "WARNING:suspicious_RCU_usage" on:
> >=20
> > commit: 03abf2a7c65451e663b078b0ed1bfa648cd9380f ("net: phylink: add EEE
> > management")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master =
=20
>=20
> I think there's multiple issues here that need addressing:
>=20
> 1) calling phy_detach() in a context that phy_attach() is allowed
>    causes this warning, which seems absurd (being able to attach but
>    not detach on error is a problem.)
>=20
> This is the root cause of the issue, and others have run into this same
> problem. There's already been an effort to address this:
>    https://lore.kernel.org/r/20250117141446.1076951-1-kory.maincent@bootl=
in.com
>    https://lore.kernel.org/r/20250117173645.1107460-1-kory.maincent@bootl=
in.com
>    https://lore.kernel.org/r/20250120141926.1290763-1-kory.maincent@bootl=
in.com
> and I think the conclusion is that the RTNL had to be held while calling
> phy_detach().
>=20
> 2) phy_modify_mmd() returning -EPERM. Having traced through the code,
>    this comes from my swphy.c which returns -1 (eww). However, as this
>    code was extracted from fixed_phy.c, and the emulation is provided
>    for userspace, this is part of the uAPI of the kernel and can't be
>    changed.
>=20
> 3) the blamed commit introduces a call to phy_modify_mmd() to set the
>    clock-stop bit, which ought not be done unless phylink managed EEE
>    is being used.
>=20
> (2) and (3) together is what ends up causing:
>=20
> > [   19.646149][   T22] dsa-loop fixed-0:1f lan1 (uninitialized): failed=
 to
> > connect to PHY: -EPERM [   19.647542][   T22] dsa-loop fixed-0:1f lan1
> > (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 0 [
> > 19.649283][   T22] dsa-loop fixed-0:1f lan2 (uninitialized): PHY
> > [dsa-0.0:01] driver [Generic PHY] (irq=3DPOLL) [   19.650853][   T22]
> > dsa-loop fixed-0:1f lan2 (uninitialized): failed to connect to PHY: -EP=
ERM
> > [   19.652238][   T22] dsa-loop fixed-0:1f lan2 (uninitialized): error =
-1
> > setting up PHY for tree 0, switch 0, port 1 [   19.653856][   T22] dsa-=
loop
> > fixed-0:1f lan3 (uninitialized): PHY [dsa-0.0:02] driver [Generic PHY]
> > (irq=3DPOLL) [   19.655392][   T22] dsa-loop fixed-0:1f lan3 (uninitial=
ized):
> > failed to connect to PHY: -EPERM [   19.656689][   T22] dsa-loop fixed-=
0:1f
> > lan3 (uninitialized): error -1 setting up PHY for tree 0, switch 0, por=
t 2
> > [   19.658308][   T22] dsa-loop fixed-0:1f lan4 (uninitialized): PHY
> > [dsa-0.0:03] driver [Generic PHY] (irq=3DPOLL) [   19.659841][   T22]
> > dsa-loop fixed-0:1f lan4 (uninitialized): failed to connect to PHY: -EP=
ERM
> > [   19.661168][   T22] dsa-loop fixed-0:1f lan4 (uninitialized): error =
-1
> > setting up PHY for tree 0, switch 0, port 3 [   19.663018][   T22] DSA:
> > tree 0 setup [   19.663591][   T22] dsa-loop fixed-0:1f: DSA mockup dri=
ver:
> > 0x1f =20
>=20
> which then causes phy_detach() to be called, which then triggers the
> "suspicious RCU" warning.
>=20
> This has merely revealed a problem in the error handling since Kory's
> commit on the 12th December, and actually has nothing to do with the
> blamed commit, other than it revealing the latent problem.
>=20
> The "hold RTNL" solution isn't trivial to implement here - phylink's
> PHY connection functions can be called with RTNL already held, so it
> isn't a simple case of throwing locking at phylink (which will cause
> a deadlock) - it needs every phylink user to be audited and individual
> patches to take the RTNL in the driver generated as necessary. I'm not
> sure when I'll be able to do that. It's also a locking change for this
> API - going from not needing the RTNL to requiring it.
>=20
> This is probably going to result in more kernel warnings being
> generated when I throw in ASSERT_RTNL() into phylink paths that could
> call phy_detach(). Sounds joyful.

It is indeed painful! I have began to take a look at it:
https://termbin.com/d9tq

I don't know if there is a better way to do this ...

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

