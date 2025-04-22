Return-Path: <netdev+bounces-184623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B975DA96838
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5BE179B99
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40AB20127A;
	Tue, 22 Apr 2025 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j/ROrZby"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85320151985;
	Tue, 22 Apr 2025 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322869; cv=none; b=FIxak0tJ8XZhsRCrNOAajh/KLBJbo1NMKeEGNcsI6GJpLYjqaKNsBO/UBSTOcEUkb1Y7yDp2jqSGtapBASF2fmN9RQq9lVn3viPK6lHMSbFdmMpZWXAAKRuWHA8e+ncsI1JqvSwQKmfi9YcNrR7qn1i5cTj0Mkl4Mh0WIG/wEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322869; c=relaxed/simple;
	bh=e4hOoxwJlowwWg70san1xrXeaRywfsnFnpO5Tk/ZLKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUnQYkK1P5AJjpfcmVJ3l5h1qKRVJNqsVqrD+lEFf+qGKJfDUu2cJF5ReAPvtR2I/pMzT1yRfOSeITEuJeQoF2vNGI7KDcLFkqtxOUv+qcv6NT3+aBIT60jIw4p4N1SK8g3fv6nfvW9S27K19mjtGkHy2JWEoEp43QhPnELmhVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j/ROrZby; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8FCA438A5;
	Tue, 22 Apr 2025 11:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745322858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9LF1/VpjGGXVIZPcc65Fh5WkTR/rYmFKZlW00U9MEQ=;
	b=j/ROrZbyVem2JsNP/GdNMHFLAeU8wlsbcORane3eAGsxCPMEWuPf3xJ3xbi59mLGMTFuIx
	gt83U3eU7GWqDjEWVmC2U9cConxr0ewgVzxyxACFgPHsOGyOIuFDfsmn5Q/PLxcRFHPTwC
	x6ARpoeCFh6E36G9rdVnTc4lWzKF/MLe5VQG3xoD9/91OkdQ3dpTIIozlYt4kL38ebPz3T
	Wg4pzq8yxhDTe9K47Gqm72Q4BkFojPqvysDoaaQgTn3J9P97UQeWcxVNfKqEyy4r3MbWJh
	A3eNmsW5wJXw2+GqS3buQpnT9VBWjQbuOwsgzWZDHpU/0oH1+/Fo5eNKxDZwNg==
Date: Tue, 22 Apr 2025 13:54:15 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Simon Horman <horms@kernel.org>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH net 2/3] net: stmmac: socfpga: Don't check for phy to
 enable the SGMII adapter
Message-ID: <20250422135415.1edd6636@fedora.home>
In-Reply-To: <aAduzwMTLvaeyQkb@shell.armlinux.org.uk>
References: <20250422094701.49798-1-maxime.chevallier@bootlin.com>
	<20250422094701.49798-3-maxime.chevallier@bootlin.com>
	<aAduzwMTLvaeyQkb@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpt
 hhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell,

On Tue, 22 Apr 2025 11:26:23 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Apr 22, 2025 at 11:46:56AM +0200, Maxime Chevallier wrote:
> > The SGMII adapter needs to be enabled for both Cisco SGMII and 1000BaseX
> > operations. It doesn't make sense to check for an attached phydev here,
> > as we simply might not have any, in particular if we're using the
> > 1000BaseX interface mode.
> > 
> > So, check only for the presence of a SGMII adapter to re-enable it after
> > a link config.  
> 
> I wonder whether:
> 
> 	struct stmmac_priv *priv = netdev_priv(dev_get_drvdata(dwmac->dev));
> 
> 	if ((priv->plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
> 	     priv->plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) &&
> 	    sgmii_adapter_base)
>  		writew(SGMII_ADAPTER_ENABLE,
>  		       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
> 
> would describe the required functionality here better, making it clear
> under which interface modes we expect to set the enable bits.

That's true indeed. Thanks for the suggestion, I'll include that in V2
with your suggested-by :)

Thanks,

Maxime



