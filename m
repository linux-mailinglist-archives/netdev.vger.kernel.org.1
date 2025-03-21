Return-Path: <netdev+bounces-176782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F50EA6C1F4
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 19:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B713F7A682C
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE2E22B8D7;
	Fri, 21 Mar 2025 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NF5ixqHF"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4C78F5B;
	Fri, 21 Mar 2025 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580029; cv=none; b=EcIEQNLNj8irprfc8WscZHjMgfNSrJXv00lclV/Ns/whdtlZYMwAScYJy5Vfb2QkHdVh5IGy/2a1RHmwpJY6Gg9Qr2Qhqh5di5pRWfEGfYpQhVEjV8UvdQFM+6sxFpjL/uw5Tu84XUmpnAkdGsHMKIeK95KbTH3uaJYkjtW7jOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580029; c=relaxed/simple;
	bh=7dIOygUXtJq/DqLesxhrpjT1PyotYaJ6LWLXJmcmQ8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G657i+5H+uhsKesgREixg/NEsl3LTzfylZupWUdqHZqZ/xObbUTnZeCxVQeLchlicOmnr7I7c50+XrfbVucfR9rSt8s4v4gaa+1SfGyPzxV/xBI2Qy2Z/Ane49Q081ifT8qO1PlydJZGZ4n79nOs1msvJL+615b7plJ8eO2a5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NF5ixqHF; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE09C4436F;
	Fri, 21 Mar 2025 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742580020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kNWwvY9/Sy+dP/X2ghb1nqiUMXSAMyKqVfkR25QHOk=;
	b=NF5ixqHF2hEDfWChqzpeUbkeEakBIzUu3TnrDiyil7t5K12V2W957iP8RtuJLaQolCjAYr
	Poq/Pg7jeLzcsDkdHrglbK63zB9xgwwVIb8alkyUHbC58pKeINHXXSw0trN/oMW4f2fUwT
	dzrMXuj5/U0RifXrhloTDm0B0v0kXtc4jBh8cz1GV0MsXd2M4vVx/qZBabr4HkpaTaZr+h
	RWL2DlqBW0PIcr4PYp4qFGw0TY7aXFQaNKaJO4uJvcAbJZrzJRJsIHK90+4+vazcNQuqPP
	JlLfPbg52O4bzg+dTw1AP6ixLNLhBXdsL+pZHl1LHOB1lSY08peusiG8ygVUSg==
Date: Fri, 21 Mar 2025 19:00:17 +0100
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
Subject: Re: [PATCH net-next v3 1/2] net: phy: sfp: Add support for SMBus
 module access
Message-ID: <20250321190017.04f6acbc@fedora.home>
In-Reply-To: <53852ebf-bd7d-4f8e-bc7c-8dd3271cb1b0@redhat.com>
References: <20250314162319.516163-1-maxime.chevallier@bootlin.com>
	<20250314162319.516163-2-maxime.chevallier@bootlin.com>
	<53852ebf-bd7d-4f8e-bc7c-8dd3271cb1b0@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedujeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepk
 hhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Paolo,

On Fri, 21 Mar 2025 18:50:54 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On 3/14/25 5:23 PM, Maxime Chevallier wrote:
> > @@ -691,14 +692,71 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> >  	return ret == ARRAY_SIZE(msgs) ? len : 0;
> >  }
> >  
> > -static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
> > +static int sfp_smbus_byte_read(struct sfp *sfp, bool a2, u8 dev_addr,
> > +			       void *buf, size_t len)
> >  {
> > -	if (!i2c_check_functionality(i2c, I2C_FUNC_I2C))
> > -		return -EINVAL;
> > +	u8 bus_addr = a2 ? 0x51 : 0x50;
> > +	union i2c_smbus_data smbus_data;  
> 
> Minor nit: please respect the reverse christmas tree order above.
> 
> > +	u8 *data = buf;
> > +	int ret;
> > +
> > +	while (len) {
> > +		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> > +				     I2C_SMBUS_READ, dev_addr,
> > +				     I2C_SMBUS_BYTE_DATA, &smbus_data);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*data = smbus_data.byte;
> > +
> > +		len--;
> > +		data++;
> > +		dev_addr++;
> > +	}
> > +
> > +	return data - (u8 *)buf;
> > +}
> > +
> > +static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
> > +				void *buf, size_t len)
> > +{
> > +	u8 bus_addr = a2 ? 0x51 : 0x50;
> > +	union i2c_smbus_data smbus_data;  
> 
> same here.

Missed it indeed, I'll address that.

Maxime


