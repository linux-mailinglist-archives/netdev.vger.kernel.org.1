Return-Path: <netdev+bounces-170790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E81A49E82
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911633B270B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8F26A0DB;
	Fri, 28 Feb 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I76fipOA"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06528E7;
	Fri, 28 Feb 2025 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759450; cv=none; b=txR95XapLvpOlXZUNK3DUqzwoCKHygzOUEsIqX3xHJWNwB4YIzFldM7MEPUpDhiHn7KFbeolNetXbl0pEFiYh/3eeUNcF21s2DySR4DH2ImwtNNehN+Nq2uFkmcQu4h++Zmw0cyrecZViea883HIrC1Bf8AzYisXJEoO9Bznm3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759450; c=relaxed/simple;
	bh=2edDRC4ILu3SR2NspAwtrr0fFn5xXiAgXbR1cRFlIE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmT+7kCMpeKUwxmlWPgH2lBT/TLszzIQGxxgJZI+9i2UXClnCz247vlS+he7esBiif7LjpPC4fOmWcZfnjB9j1N1Qd5PH3PfOmz9c3jQAxs3p+6MUUMYilacZNXi2CtW3WeTkrzVlQnOEgcpaZ7ztKACLEDFDUD3xa/F9hbcyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I76fipOA; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1C7C4431B;
	Fri, 28 Feb 2025 16:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740759445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiOs4t5S7Vba+FbukFmy46w8UUZlBA+9AHiDIzVMiQY=;
	b=I76fipOAMV7OPHWC4tqyxx8hPk3KRxyyJzzjkT6yeg97wsKfB9m6ApewNq1NavNRoH/KJR
	D0ZewdrLLIFjrpBQqT7EwFSOJUhPfLiA5jVJa6wPfe+vi/l9r7Mp0tgVJ4dgtIKdfZaM3k
	wGbOrUxMt+C21aLQaHwvkevZ0xCgVDXJOo6nvoRQ8mjHhCdmaPAUgwKUU5iX7bSGj54Lb6
	4hMZN83760UNGxmckO3c35zyTtD9APBMET7CgbjtSb1ffXQLO9b/e1rJZuocNIQ5vSfu6Q
	6+HY3uIkCBvlWOG5rvzISylYNwLyg9Wu/QcRjmDvs4h/d0PqWjMKXrCKO+uCqQ==
Date: Fri, 28 Feb 2025 17:17:20 +0100
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
Subject: Re: [PATCH net-next v3 03/13] net: phy: phy_caps: Move phy_speeds
 to phy_caps
Message-ID: <20250228171720.62c6b378@fedora.home>
In-Reply-To: <Z8Hf-9yR3qD9cqsX@shell.armlinux.org.uk>
References: <20250228145540.2209551-1-maxime.chevallier@bootlin.com>
	<20250228145540.2209551-4-maxime.chevallier@bootlin.com>
	<Z8Hf-9yR3qD9cqsX@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtt
 hhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell,

On Fri, 28 Feb 2025 16:10:35 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Fri, Feb 28, 2025 at 03:55:28PM +0100, Maxime Chevallier wrote:
> > Use the newly introduced link_capabilities array to derive the list of
> > possible speeds when given a combination of linkmodes. As
> > link_capabilities is indexed by speed, we don't have to iterate the
> > whole phy_settings array.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

[...]

> > +/**
> > + * phy_caps_speeds() - Fill an array of supported SPEED_* values for given modes
> > + * @speeds: Output array to store the speeds list into
> > + * @size: Size of the output array
> > + * @linkmodes: Linkmodes to get the speeds from
> > + *
> > + * Fills the speeds array with all possible speeds that can be achieved with
> > + * the specified linkmodes.
> > + *
> > + * Returns: The number of speeds filled into the array. If the input array isn't
> > + *	    big enough to store all speeds, fill it as much as possible.
> > + */
> > +size_t phy_caps_speeds(unsigned int *speeds, size_t size,
> > +		       unsigned long *linkmodes)
> > +{
> > +	size_t count;
> > +	int capa;
> > +
> > +	for (capa = 0, count = 0; capa < __LINK_CAPA_MAX && count < size; capa++) {
> > +		if (linkmode_intersects(link_caps[capa].linkmodes, linkmodes) &&
> > +		    (count == 0 || speeds[count - 1] != link_caps[capa].speed))
> > +			speeds[count++] = link_caps[capa].speed;
> > +	}  
> 
> Having looked at several of these patches, there's a common pattern
> emerging, which is we're walking over link_caps in either ascending
> speed order or descending speed order. So I wonder whether it would
> make sense to have:
> 
> #define for_each_link_caps_asc_speed(cap) \
> 	for (cap = link_caps; cap < &link_caps[__LINK_CAPA_MAX]; cap++)
> #define for_each_link_caps_desc_speed(cap) \
> 	for (cap = &link_caps[__LINK_CAPA_MAX - 1]; cap >= link_caps; cap--)
> 
> for where iterating over in speed order is important. E.g. this would
> make the above:
> 
> 	struct link_capabilities *lcap;
> 
> 	for_each_link_caps_asc_speed(lcap)
> 		if (linkmode_intersects(lcap->linkmodes, linkmodes) &&
> 		    (count == 0 || speeds[count - 1] != lcap->speed)) {
> 			speeds[count++] = lcap->speed;
> 			if (count >= size)
> 				break;
> 		}
> 
> which helps to make it explicit that speeds[] is in ascending value
> order.

That makes a lot of sense indeed, I will definitely add that.

Thanks a lot for the review,

Maxime

