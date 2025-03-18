Return-Path: <netdev+bounces-175615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EEEA66E1C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D785A1897AB2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83481F4C9C;
	Tue, 18 Mar 2025 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mdaolHjc"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E41C6FF4;
	Tue, 18 Mar 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286362; cv=none; b=ureWDcfdqHdQVKHdQVUsu5iGpxZGBiTJyx6WaXGwQHc2Exp5eEWUzW16za1OqVAn/TUIY1AO5Q3xkByf18ytQjNDDGGreTW8JGTFd3QPfmuwN7lifttMltI6FR+HSRzAXqib+D5UFt0qsvWcjpNxl2tV1rrLd+/xwbLevSz9liU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286362; c=relaxed/simple;
	bh=tVxzXdFnSTbKiW+Z6b1CkG5VCROLmVTDUl4+wBdGll4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKc5hQY580ARlE7A364s5iMCogfVkSfD8Yc5VUBf/lrTNXEqs2wtbJ3kq4mcrUKC0dVtSyow+tJk6CqvFhC1ayHVGcHsTxysqVQBHR7t195JOx10Wr+t9ne8ISLNEr75oQDkJ6CX6CpGNv/HOqZ99uYa948BZDgRWvAjbDcqIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mdaolHjc; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B6A97442A7;
	Tue, 18 Mar 2025 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742286358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wH9krpUaOUfNxPqmjVtIC4eOg6NnJP0I0NYX9C6ILs0=;
	b=mdaolHjcBM5J+3USTKkvgACDoOJRIL/AZRaMIkYGvGR0P1OhmDOqyM1wf4jSgl+dfFQpwj
	Qi4OGN8uFpLM95YpnzxFfvihz3DyzKsjGMBysp9lTdvEwc6SGODz04nahDPWVp84YrW9HT
	C7JIcWrkX6x/yVN7f1UtqnNrk2kyQAV7lg1dj08exOhf9oC0zmJuiOQ4zZPo34aYDLDtwM
	WiW9uDXFaAiUHGtdx0SsoLEU9egfuii5yoHI6LpDwEGqjeS0hctP1lnbyRE82jMkedXgGS
	B8NemPce+4fzsFw+oIIsdPTlmkZ/ZB1TnZ6Dmg8yKIwt6Fj/9DbOkB+Qt8dt/Q==
Date: Tue, 18 Mar 2025 09:25:51 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Simon Horman
 <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>, Antoine
 Tenart <atenart@kernel.org>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, =?UTF-8?B?QmrDuHJu?= Mork
 <bjorn@mork.no>
Subject: Re: [PATCH net-next v3 0/2] net: phy: sfp: Add single-byte SMBus
 SFP access
Message-ID: <20250318092551.3beed50d@fedora.home>
In-Reply-To: <1653ddbd-af37-4ed1-8419-06d17424b894@lunn.ch>
References: <20250314162319.516163-1-maxime.chevallier@bootlin.com>
	<1653ddbd-af37-4ed1-8419-06d17424b894@lunn.ch>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeduleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjeetjefgheegfeejtdetfefggfekveeggeehudeuteeuleeviedvheevtdeugfetnecuffhomhgrihhnpehmihgtrhhotghhihhprdgtohhmnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsr
 geskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew,

On Mon, 17 Mar 2025 22:34:09 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Mar 14, 2025 at 05:23:16PM +0100, Maxime Chevallier wrote:
> > Hello everyone,
> > 
> > This is V3 for the single-byte SMBus support for SFP cages as well as
> > embedded PHYs accessed over mdio-i2c.  
> 
> Just curious, what hardware is this? And does it support bit-banging
> the I2C pins? If it does, you get a choice, slow but correct vs fast
> but broken and limited?

The HW is a VSC8552 PHY that includes a so-called "i2c mux", which in
reality is that smbus interface.

             +---------+
 +-----+     |         |     +-----+
 | MAC | --- | VSC8552 | --- | SFP |
 +-----+     |         |     +-----+
    |        |         |        |
    +-mdio---|         |-smbus--+
             +---------+

it has 4 SCL and 1 SDA lines, that you can connect to 4 different SFP
cages.

You perform transfers by using 2 dedicated MDIO registers , one
register contains xfer info such as the address to access over smbus,
the direction of the xfer, and the other one contains data :
 - lower byte is write data
 - upper byte is read-back data

and that's all you have :( so the HW can only really do one single byte
transfer at a time, then you re-configure the 2 registers above, rinse
and repeat.

Looks like the datasheet is publicly available :

https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/60001809A.pdf

The whole xfer protocol is described in page 35.

On the board itself, the i2c for the SFP cage is connected to that PHY
smbus.

Now it looks like there's some pinmux within the PHY and we can use the
PHY as a gpio controller, so we could consider using a bitbang approach
indeed (provided that SFP is on PHY smbus bus 0 or 1).

I didn't consider that, it's probably worth giving a try, even if as
you say it's probably be very slow, each bit being set amounting to a
mdio xfer towards the PHY.

But if it allows better HW support, and the SFP reacts well on slow
busses, it may be work :)

Do we still want the current series ? Looks like some other people were
interested in that.

On my side that's the second time I deal with a product that uses a PHY
from this family and uses that smbus feature (but if that bitbang thing
works it's probably better)

Thanks,

Maxime

