Return-Path: <netdev+bounces-169472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438F7A4418E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B627AC0F0
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B15126E178;
	Tue, 25 Feb 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hQfY6BZT"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493826AA8A;
	Tue, 25 Feb 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491783; cv=none; b=SeMFw9WhLGGVCx00y+j7lExUTI0oMWdDsNRN4dfGk3ogMtqS8ENpND0+VH8g3Bwpv01AUoBTpEP1R5f4DznqWzLfcxRRhf2OYy2n1yIurD/JZtkR7Vzq96fuWg3vv8Vq8xsQaP9daIjojuTl5aY9TYl2MRM0ok3h9PiJl4yJyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491783; c=relaxed/simple;
	bh=sk3A+C/3YF/aw+qmXdV3WY5MUHEfjGuEtG3jNw8Ywxs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJ44/ndax4XheYh9FQ8Ay3F/CqZXlanXIbAcbr08hyOSc9JAx0/c1BOB3DJOAlvL9RKsBoSE/rn1cerDzJmI90LvNS2VJSQSy4bDNnpOVHrl3Tyvj5KmcENtVAL/Hwj44iNAdZLf+6AGCMFLMns6cUdBwY9EjEMfKPCE9rtr2FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hQfY6BZT; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD31320454;
	Tue, 25 Feb 2025 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740491779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0xoAglwtX05uIrcTfA8VEz2V2/yZL+wn+pNIMqwOKM=;
	b=hQfY6BZTgnQRGkyolkYMlC3w1c05S8eOuj/k7QAOQcU4IskjRGDKoIn9qGyG1Zhh3w6dF2
	74FOFCZ6IYqlKrRlmL5sX218RHQEhskI22OvTf449QGkDJFaNhB6s+Wtkzfa+zN0hlh8r7
	MrnQ9B9kq61hbTgA5jWgz5BmBVvGhGbypU38kRnCqUaLiUEkJriEGCu2xVu+izR5pXYvCs
	WbSKlrS54Qrdq1lpEQTGcTWtQQcN66JF9qFIIhaFDcZEYQKtWOzFQjzknaB2hyjNqwo5Le
	WRDnpryLYW71H24FSrh2yPy+LGwriC33taRpoQ5pp1OdWXKy6ZYfB018eHvGKA==
Date: Tue, 25 Feb 2025 14:56:17 +0100
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
Subject: Re: [PATCH net-next v2 1/2] net: phy: sfp: Add support for SMBus
 module access
Message-ID: <20250225145617.1ed1833d@fedora.home>
In-Reply-To: <6ff4a225-07c0-40f6-9509-c4fa79966266@lunn.ch>
References: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
	<20250225112043.419189-2-maxime.chevallier@bootlin.com>
	<6ff4a225-07c0-40f6-9509-c4fa79966266@lunn.ch>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughum
 hgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Andrew,

> > -static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
> > +static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,  
> 
> Maybe call this sfp_smbus_byte_read(), leaving space for
> sfp_smbus_word_read() in the future.

Good idea, I'll do that :)

> > +			  size_t len)
> >  {
> > -	if (!i2c_check_functionality(i2c, I2C_FUNC_I2C))
> > -		return -EINVAL;
> > +	u8 bus_addr = a2 ? 0x51 : 0x50;
> > +	union i2c_smbus_data smbus_data;
> > +	u8 *data = buf;
> > +	int ret;
> > +
> > +	while (len) {
> > +		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> > +				     I2C_SMBUS_READ, dev_addr,
> > +				     I2C_SMBUS_BYTE_DATA, &smbus_data);
> > +		if (ret < 0)
> > +			return ret;  
> 
> Isn't this the wrong order? You should do the upper byte first, then
> the lower?

You might be correct. As I have been running that code out-of-tree for
a while, I was thinking that surely I'd have noticed if this was
wrong, however there are only a few cases where we actually write to
SFP :

 - sfp_modify_u8(...) => one-byte write
 - in sfp_cotsworks_fixup_check(...) there are 2 writes : one 1-byte
write and a 3-bytes write.

As I don't have any cotsworks SFP, then it looks like having the writes
mis-ordered would have stayed un-noticed on my side as I only
stressed the 1 byte write path...

So, good catch :) Let me triple-check and see if I can find any
conceivable way of testing that...

Thanks,

Maxime

