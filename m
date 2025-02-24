Return-Path: <netdev+bounces-169035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B21A422CB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB0C17CD4F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8265613A244;
	Mon, 24 Feb 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SHxmHNgq"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377713959D;
	Mon, 24 Feb 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406417; cv=none; b=hYBFbdmOqdk4qf+8nb0BkaBGvH03xYOV30m+H50/XyzyT5t5kqqg3upmfUXQsNKY/71Fe9PxcivbXK3gIGPTdym7ddC+2vWhrIGbcLoGXUk2dIUN+SIxYsQmMABgB4mC5LOH8M2ZHybzKujqmzqe60YO+zsQxgjCHcpKQQxNi6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406417; c=relaxed/simple;
	bh=kNAuwtXcim562dObXcreoHv9UBgRaM0ANCRSQx86Ebg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3SrLZc6VccKQ4D0eIvIBV613uY77sSHncaH1v27wdUQUztqqEitzxhJRslgikNvXHrPs5aqtABehqOV4dVr9VyGQ+aQuelI4peyx2HcXEM/BohVEYy2cW0ZcO7UHlzREmlQ3vbgYjUTLgggu3S6NfE9o1xsKSaj0yhzcbOmT/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SHxmHNgq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3905044280;
	Mon, 24 Feb 2025 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740406413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6ddd5eN9n7fNFqvJfwSzJ+NMubkWkXegBbLwCG/opI=;
	b=SHxmHNgqUIQfAjO5+M0vS07kR4vJdlM2Q61kzT1i3NSw2SLqTYRO4iSTx39hTusWiDbcfy
	YwSkMFjxJO9IJNe7x/060jHUw0D+Ye4V1Yzx1cinWqlsJopQeiwC4+BbMkRtLBaNfspYNE
	8DG8TPBkI8JOAS9jaxL1aE5Qs395CVZj0Yg36ovmBtTPNQBUKomEMtT97a/QSJqL6Eizi2
	P9JsXsUwhBvLTe0qvZtqkhUFsYgwFa8SCFvUpmne+1j+cN9OKUHmEwfifQZ5wdUksIiPgU
	SHLfUolVwn0DNEfcHj9M+/1hPprlSO4mgSjExqk434LItWh6v+5K0QaUfO9URg==
Date: Mon, 24 Feb 2025 15:13:30 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next 01/13] net: phy: Extract the speed/duplex to
 linkmode conversion from phylink
Message-ID: <20250224151330.2e0d95e4@fedora>
In-Reply-To: <Z7x7p3W0ZpkFu44m@shell.armlinux.org.uk>
References: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
	<20250222142727.894124-2-maxime.chevallier@bootlin.com>
	<Z7x7p3W0ZpkFu44m@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvn
 hhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 24 Feb 2025 14:01:11 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Sat, Feb 22, 2025 at 03:27:13PM +0100, Maxime Chevallier wrote:
> > Phylink uses MAC capabilities to represent the Pause, AsymPause, Speed
> > and Duplex capabilities of a given MAC device. These capabilities are
> > used internally by phylink for link validation and get a coherent set of
> > linkmodes that we can effectively use on a given interface.
> > 
> > The conversion from MAC capabilities to linkmodes is done in a dedicated
> > function, that associates speed/duplex to linkmodes.
> > 
> > As preparation work for phy_port, extract this logic away from phylink
> > and have it in a dedicated file that will deal with all the conversions
> > between capabilities, linkmodes and interfaces.  
> 
> Fundamental question: why do you want to extract MAC capabilities from
> phylink?
> 
> At the moment, only phylink uses the MAC capabilities (they're a phylink
> thing.) Why should they be made generic, and what use will they be
> applied to as something generic?
> 
> If there's no answer for that, then I worry that they'll get abused.
> 

I only have a blurry answer for you, so that probably wont cut it, but
for phy_port (which I have ready) and stackable PHY support (which I
have not), I foresee that we may need to specify what can the PHY do on
its MII serdes port.

TBH the only real stuff that will be needed is "Given a set of
phy_interface_t supported by a PHY downstream port, what linkmodes can
we get out of these". The phylink code uses the mac_capabilities as an
intermediate between phylink_get_capabilities and
phylink_caps_to_linkmodes(). Given that this series introduces very very
similar enums in the form of the LINK_CAPA_XXX, we might be able to
keep the MAC_CAPABILITIES a phylink-specific set of values. I can
include that in V2.

Maxime

