Return-Path: <netdev+bounces-176784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D1CA6C20A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 19:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B437A424D
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D6F22F175;
	Fri, 21 Mar 2025 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pZxSIMzE"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34122D7B8;
	Fri, 21 Mar 2025 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580163; cv=none; b=NnwvD9IyRx4Jt7yYLCKKnRs/GHH7tm6kMVVDoiI9Gz4Rz2GDQjvH2d67oDjwbVBPu02Ei/P9gHeWjnxbGVFQ5ueV/GykIsfeOSYgzeezsxnBF6SEwr1LpYKPwh6hAOrOjwJkNvptP82eF5v64zgz31259J80H3vW2q5x3+7PJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580163; c=relaxed/simple;
	bh=FxQ0I2Czp4ZKwPfKwF9LTTuJpX8v/ojHHMTj16elL3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7mWyjqATCvsbEkNwQ89kzpTmerwPTdbUCkJUpctG4dPEdS/RRbvObpV0ELHTjyeievIsoAWO8q89+yXda1uSDPpO82TQFLgLOpy4IzAqCKjbxl3TgTuUMNmqbu/Fi6b/osdC/QLWPmxGoJF1jfhWm+g6gdZHZGFfT8Cd6lJrH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pZxSIMzE; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49D074425E;
	Fri, 21 Mar 2025 18:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742580159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/BjAP6kKUJvzOObt+TypoZPd31KvaGdxLe959lthQI=;
	b=pZxSIMzE8nviuAAPk9tZnzG/JwPJHcFUGyN62rFerT4nLOzmEHVd3rIEDw+2iXs3k5FEGV
	aRO4SRo0u1RbovAxC3D0KJTSnFU4DQQN8YSRm8+1r21EMDS9N1ojhzt/CpsqyZYwfy58Uf
	0dNvjQYh6ARIsGtpE7tPwMxkWwv9lU+yp8s0QOOfyW2mYHccVYGFcCOx601qWB6hewwor2
	go2Jdwhov5QTGA24rEAQul4dNdW78xSC7IvOiKGplcu+Ox64/sQBFGHUolfUxS4/l1lEU9
	BTcADGAGFBEERLWxm3r4rVUYOvGUjyBARS3AwHsxit8+xRci2pr0V/CXR8INtQ==
Date: Fri, 21 Mar 2025 19:02:37 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Simon Horman
 <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>, Antoine
 Tenart <atenart@kernel.org>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, =?UTF-8?B?QmrDuHJu?= Mork
 <bjorn@mork.no>
Subject: Re: [PATCH net-next v3 2/2] net: mdio: mdio-i2c: Add support for
 single-byte SMBus operations
Message-ID: <20250321190237.0a98e8b7@fedora.home>
In-Reply-To: <d86dd4a4-a56a-4d48-ad7d-182f6fed8781@redhat.com>
References: <20250314162319.516163-1-maxime.chevallier@bootlin.com>
	<20250314162319.516163-3-maxime.chevallier@bootlin.com>
	<d86dd4a4-a56a-4d48-ad7d-182f6fed8781@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedujeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepk
 hhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 21 Mar 2025 18:53:51 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On 3/14/25 5:23 PM, Maxime Chevallier wrote:
> > diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
> > index da2001ea1f99..202f486e71f1 100644
> > --- a/drivers/net/mdio/mdio-i2c.c
> > +++ b/drivers/net/mdio/mdio-i2c.c
> > @@ -106,6 +106,62 @@ static int i2c_mii_write_default_c22(struct mii_bus *bus, int phy_id, int reg,
> >  	return i2c_mii_write_default_c45(bus, phy_id, -1, reg, val);
> >  }
> >  
> > +static int smbus_byte_mii_read_default_c22(struct mii_bus *bus, int phy_id,
> > +					   int reg)
> > +{
> > +	struct i2c_adapter *i2c = bus->priv;
> > +	union i2c_smbus_data smbus_data;
> > +	int val = 0, ret;
> > +
> > +	if (!i2c_mii_valid_phy_id(phy_id))
> > +		return 0;
> > +
> > +	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
> > +			     I2C_SMBUS_READ, reg,
> > +			     I2C_SMBUS_BYTE_DATA, &smbus_data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	val = ((smbus_data.byte & 0xff) << 8);  
> 
> External brackets not needed.
> 
> > +
> > +	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
> > +			     I2C_SMBUS_READ, reg,
> > +			     I2C_SMBUS_BYTE_DATA, &smbus_data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	val |= (smbus_data.byte & 0xff);  
> 
> same here.
> 
> > +
> > +	return val;
> > +}
> > +
> > +static int smbus_byte_mii_write_default_c22(struct mii_bus *bus, int phy_id,
> > +					    int reg, u16 val)
> > +{
> > +	struct i2c_adapter *i2c = bus->priv;
> > +	union i2c_smbus_data smbus_data;
> > +	int ret;
> > +
> > +	if (!i2c_mii_valid_phy_id(phy_id))
> > +		return 0;
> > +
> > +	smbus_data.byte = ((val & 0xff00) >> 8);  
> 
> and here.
> 
> > +
> > +	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
> > +			     I2C_SMBUS_WRITE, reg,
> > +			     I2C_SMBUS_BYTE_DATA, &smbus_data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	smbus_data.byte = val & 0xff;  
> 
> I would not have noted the above if even this one carried additional
> brackets...

:( You're correct, sorry not to have spotted that before... I'll fix
this for v4.

Maxime


