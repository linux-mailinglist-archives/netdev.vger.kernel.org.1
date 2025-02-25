Return-Path: <netdev+bounces-169454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21441A4402F
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A1217E0E6
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CCD268FCC;
	Tue, 25 Feb 2025 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bSi34QCM"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D126869E;
	Tue, 25 Feb 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488810; cv=none; b=FZm/eyGf9pUiUQoMsTbsDsvI4wYpl6xlxVchG3r/1HkW/vwvOAFjyaeYR1ACBXLfRo1J5zB1tMgOilYUsq7sBTLIYojPLifXln8JshruJ78f0PVFyBQkV3PWSJKMbcTCqS+ID1sm2BMpVi4ZRHryT6hW/1IdoDkWE2Jtaox56tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488810; c=relaxed/simple;
	bh=FH0Z9n6n+rbztuPpg0AwFq+ZeandoPBp2IqLIgthyHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwuE18VNobyvCT2ML4bIbliObb9TBQ5jLuuwHXJtXfQUapSwuMo/5WCosH8xpotZNTsCLsPYrwWIt2FPVgekB2eNSQX+y1+Sh5hSNVfo/MrNrqpSUkIPOPqpZ3D9+liOFqcIkMdwWVjnVbDbXV+JoJVHegnpA5tzGOS1WvB0Uh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bSi34QCM; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D8814439E;
	Tue, 25 Feb 2025 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740488805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kIvi06Mb+JppGKBH1GDtlMpik2hj2BRVbz0nApw4Vws=;
	b=bSi34QCMkoea7NELXiPstkmIqW7+LCROLfLbLU7kFnoEGfYXlqYWpd23eaCl7hNz5p6kX9
	J4fFRWYlOwbJXWg4zGMK5ZXEa6WX9G0HG9rXzvPfoXJadb9CHgu1nltY2uGeeQRG70FV8t
	dNNevOCrq9pRrx3QA7eSGuc24cfN3MhkZ2h7k3dzVoTRjHalXjNNaBIJXlLWgRv40qBdAn
	gepfv/7BL3apoDQ6OUU5DTXuAYQH7hPTaT3aimNulpI6RekbU0Cf+lXf/R8jmQ9uBvprpX
	KnWqoz0iVFcmrE3WhfnUrUpQpLgFNaAeOP5qQD4aTCSXMCESjtJyJgcDwvaUsA==
Date: Tue, 25 Feb 2025 14:06:40 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Florian
 Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>, Romain
 Gantois <romain.gantois@bootlin.com>, Antoine Tenart <atenart@kernel.org>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <20250225140640.382fec83@fedora.home>
In-Reply-To: <87o6yqrygp.fsf@miraculix.mork.no>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
	<Z7tdlaGfVHuaWPaG@shell.armlinux.org.uk>
	<87o6yqrygp.fsf@miraculix.mork.no>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuueeuhffgtdetjefhgfetgfefjeeltdehieetvdfgffelieekteegtdeilefhleenucffohhmrghinhepmhgrrhhvvghllhdrtghomhdprhgvphhothgvtgdrtghomhdprghprggtohgvrdgtohhmrdhtfienucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegsjhhorhhnsehmohhrkhdrnhhopdhrtghpthhtoheplhhinhhugiesrghrm
 hhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Tue, 25 Feb 2025 13:38:30 +0100
Bj=C3=B8rn Mork <bjorn@mork.no> wrote:

> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> > On Sun, Feb 23, 2025 at 06:28:45PM +0100, Maxime Chevallier wrote: =20
> >> Hi everyone,
> >>=20
> >> Some PHYs such as the VSC8552 have embedded "Two-wire Interfaces" desi=
gned to
> >> access SFP modules downstream. These controllers are actually SMBus co=
ntrollers
> >> that can only perform single-byte accesses for read and write. =20
> >
> > This goes against SFF-8472, and likely breaks atomic access to 16-bit
> > PHY registers.
> >
> > For the former, I quote from SFF-8472:
> >
> > "To guarantee coherency of the diagnostic monitoring data, the host is
> > required to retrieve any multi-byte fields from the diagnostic
> > monitoring data structure (e.g. Rx Power MSB - byte 104 in A2h, Rx
> > Power LSB - byte 105 in A2h) by the use of a single two-byte read
> > sequence across the 2-wire interface."
> >
> > So, if using a SMBus controller, I think we should at the very least
> > disable exporting the hwmon parameters as these become non-atomic
> > reads. =20
>=20
> Would SMBus word reads be an alternative for hwmon, if the SMBus
> controller support those?  Should qualify as "a single two-byte read
> sequence across the 2-wire interface."

There are different flavors when it comes to what an SMBus controller
can do. In the case of what this patchset supports, its really about
SMBus controllers that can only perform single-byte operations, which
will cause issues here.

What I have is a controller that only supports I2C_FUNC_SMBUS_BYTE, in
that the controller will issue a STOP after reading/writing one byte.

But if you have a controller that supports, say,
I2C_FUNC_SMBUS_WORD_DATA (i.e. 16 bits words xfers), that's already a
different story, as the diags situation Russell mentions will fit in a
word. That will also make MDIO accesses to embedded PHYs easier, at
least for C22.=20

> > Whether PHY access works correctly or not is probably module specific.
> > E.g. reading the MII_BMSR register may not return latched link status
> > because the reads of the high and low bytes may be interpreted as two
> > seperate distinct accesses. =20
>=20
> Bear with me.  Trying to learn here.  AFAIU, we only have a defacto
> specification of the clause 22 phy interface over i2c, based on the
> 88E1111 implementation.  As Maxime pointed out, this explicitly allows
> two sequential distinct byte transactions to read or write the 16bit
> registers. See figures 27 and 30 in
> https://www.marvell.com/content/dam/marvell/en/public-collateral/transcei=
vers/marvell-phys-transceivers-alaska-88e1111-datasheet.pdf
>=20
> Looks like the latch timing restrictions are missing, but I still do not
> think that's enough reason to disallow access to phys over SMBus.  If
> this is all the interface specification we have?
>=20
> I have been digging around for the RollBall protocol spec, but Google
> isn't very helpful.  This list and the mdio-i2c.c implementation is all
> that comes up.  It does use 4 and 6 byte transactions which will be
> difficult to emulate on SMBus.  But the
>=20
> 	/* By experiment it takes up to 70 ms to access a register for these
> 	 * SFPs. Sleep 20ms between iterations and try 10 times.
> 	 */
>=20
> comment in i2c_rollball_mii_poll() indicates that it isn't very timing
> sensitive at all. The RollBall SFP+ I have ("FS", "SFP-10G-T") is faster
> than the comment indicates, but still leaves plenty of time for the
> single byte SMBus transactions to complete.
>=20
> Haven't found any formal specification of i2c clause 45 access either.
> But some SFP+ vendors have been nice enough to document their protocol
> in datasheets.  Examples:
>=20
> https://www.repotec.com/download/managed-ethernet/ds-ml/01-MOD-M10GTP-DS-=
verB.pdf
> https://www.apacoe.com.tw/files/ASFPT-TNBT-X-NA%20V1.4.pdf
>=20
> They all seem to agree that 2/4/6 byte accesses are required, and they
> offer no single byte alternative even if the presence of a "smart"
> bridge should allow intelligent latching.  So this might be
> "impossible" (aka "hard") to do over SMBus.   I have no such SFP+ so I
> cannot even try.
>=20
> > In an ideal world, I'd prefer to say no to hardware designs like this,
> > but unfortunately, hardware designers don't know these details of the
> > protocol, and all they see is "two wire, oh SMBus will do". =20
>=20
> I believe you are reading more into the spec than what's actually there.
>=20
> SFF-8419 defines the interface as
>=20
>  "The SFP+ management interface is a two-wire interface, similar to
>   I2C."
>=20
> There is no i2c requirement. This does not rule out SMBus. Maybe I am
> reading too much into it as well, but in my view "similar to I2C" sounds
> like they wanted to include SMBus.
>=20
> Both the adhoc phy additions and the diagnostic parts of SFF-8472
> silently ignores this.  I do not think the blame for any incompatibilty
> is solely on the host side here.

At least for this series, SMBus by itself isn't the main issue, the
main problem is single-byte SMBus. As soon as you can do 16 bits xfers,
that rules-out a whole class of potential problems (which doesn't mean
there will be no issue :) ), but I haven't really digged into how C45
and rollball will behave in that case.

Note that the series actually doesn't support I2C_FUNC_SMBUS_WORD_DATA,
but doesn't prevent it either :)

The driver for the SMBus controller in the rtl930x SoC you mention seem
to support I2C_FUNC_SMBUS_WORD_DATA and even longer xfers, in which
case you could add SFP support for smbus-only controllers in a much
more reliable way. It could be conceivable to remove the hwmon-disabled
restriction for I2C_FUNC_SMBUS_WORD_DATA.

Maxime

