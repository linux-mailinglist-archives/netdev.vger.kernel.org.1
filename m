Return-Path: <netdev+bounces-39464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6276C7BF59D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604A21C20B08
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 08:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69957C12B;
	Tue, 10 Oct 2023 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iUAEH+Lm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30B15AC0
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:24:02 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CDA138;
	Tue, 10 Oct 2023 01:23:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91DB71C000C;
	Tue, 10 Oct 2023 08:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696926229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4W4ki9yJ0aQRYnIclXGVVivV68iXHwUsohQy3qfUB0=;
	b=iUAEH+LmEqB+Z9kS3chvGiSknIjEn/Xfvpez8DlzWvIQqS1FON1cbMUuCvp9Ps9VnDAyhW
	tR6Qy8Xj6Xsq5+zr+FcnZv24K47h7JNY7V8iySAM+Vj9+MxdZ3IzesZ6ETW/QmT3HRYYT8
	C6/J1s+NREceDczqmOgWEO3idZL//SY5twfGigY9/1X1oZNYx80E7haMeBBhrnHNH5UgG9
	mr0KG35Rck24oqYLpdAkuiC1pKAiCj6rwLQMC91F30Rx1864BhyG9JuS8rznUbbqbML1JW
	Q+CauAfaEkoMY6E5PLuXMRPa3aHJFpc+8vPZunVea9y5Zch4JHtAWW9N1eV/tA==
Date: Tue, 10 Oct 2023 10:23:43 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michael Walle <michael@walle.cc>, Jacob Keller
 <jacob.e.keller@intel.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
In-Reply-To: <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
	<20231009155138.86458-9-kory.maincent@bootlin.com>
	<2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 9 Oct 2023 14:20:02 -0700
Florian Fainelli <florian.fainelli@broadcom.com> wrote:

Hello Florian,
Thanks for your review!

> > +/*
> > + * Hardware layer of the TIMESTAMPING provider
> > + * New description layer should have the NETDEV_TIMESTAMPING or
> > + * PHYLIB_TIMESTAMPING bit set to know which API to use for timestamping.  
> 
> If we are talking about hardware layers, then we shall use either 
> PHY_TIMESTAMPING or MAC_TIMESTAMPING. PHYLIB is the sub-subsystem to 
> deal with Ethernet PHYs, and netdev is the object through which we 
> represent network devices, so they are not even quite describing similar 
> things. If you go with the {PHY,MAC}_TIMESTAMPING suggestion, then I 
> could see how we could somewhat easily add PCS_TIMESTAMPING for instance.

I am indeed talking about hardware layers but I updated the name to use NETDEV
and PHYLIB timestamping for a reason. It is indeed only PHY or MAC timestamping
for now but it may be expanded in the future to theoretically to 7 layers of
timestamps possible. Also there may be several possible timestamp within a MAC
device precision vs volume.
See the thread of my last version that talk about it:
https://lore.kernel.org/netdev/20230511203646.ihljeknxni77uu5j@skbuf/

All these possibles timestamps go through exclusively the netdev API or the
phylib API. Even the software timestamping is done in the netdev driver,
therefore it goes through the netdev API and then should have the
NETDEV_TIMESTAMPING bit set.

> > + */
> > +enum {
> > +	NO_TIMESTAMPING = 0,
> > +	NETDEV_TIMESTAMPING = (1 << 0),
> > +	PHYLIB_TIMESTAMPING = (1 << 1),
> > +	SOFTWARE_TIMESTAMPING = (1 << 2) | (1 << 0),  
> 
> Why do we have to set NETDEV_TIMESTAMPING here, or is this a round-about 
> way of enumerating 0, 1, 2 and 3?

I answered you above the software timestamping should have the
NETDEV_TIMESTAMPING bit set as it is done from the net device driver.

What I was thinking is that all the new timestamping should have
NETDEV_TIMESTAMPING or PHYLIB_TIMESTAMPING set to know which API to pass
through.
Like we could add these in the future:
MAC_DMA_TIMESTAMPING = (2 << 2) | (1 >> 0),
MAC_PRECISION_TIMESTAMPING = (3 << 2) | (1 >> 0),
...
PHY_SFP_TIMESTAMPING = (2 << 2) | (1 << 1),
...


Or maybe do you prefer to use defines like this:
# define NETDEV_TIMESTAMPING (1 << 0)
# define PHYLIB_TIMESTAMPING (1 << 1)

enum {
	NO_TIMESTAMPING = 0,
	MAC_TIMESTAMPING = NETDEV_TIMESTAMPING,
	PHY_TIMESTAMPING = PHYLIB_TIMESTAMPING,
	SOFTWARE_TIMESTAMPING = (1 << 2) | NETDEV_TIMESTAMPING,
	...
	MAC_DMA_TIMESTAMPING = (2 << 2) | NETDEV_TIMESTAMPING,
	MAC_PRECISION_TIMESTAMPING = (3 << 2) | NETDEV_TIMESTAMPING,

or other idea?

Regards,

