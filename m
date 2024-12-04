Return-Path: <netdev+bounces-148888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DBD9E3520
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0794B16356F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB19E192B90;
	Wed,  4 Dec 2024 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zka3L9u9"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511BB136338;
	Wed,  4 Dec 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300561; cv=none; b=dq5Imk0H/4XDp53YAAM0W3IDx/BDW+gvB+6rayBpOJQziRtqcXWlTefeGd2C4Jt1pd03V2opFnra6hRoDN7GD4m05gvO2nCzKZsAYxIH8eAuCWnXPqqk5fNjrA1qhhUZryn3M2Wmsuj2C3mPYeR0Nqno96k5C5bJb/5fK/ruL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300561; c=relaxed/simple;
	bh=fbyuQ3f6W4UNcWoqGexeR8osK5gww/Emc30PmyimhiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwUDw9Q5zDtvi//+7H0zWLZimXSGC4QY+42qpxKuT0JRIMXqp8VXn0qABPdd4hffwszlO2RtIBMoi3l/TbCh0hO4r3NQnsICFEPF8SZ/x/0avEyuwkGSOeAOMUIsKIg+W80mOSy8Bqe1DzYquelpVWTnXwa8LE2BI3hHmF9Xehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zka3L9u9; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC03E20004;
	Wed,  4 Dec 2024 08:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733300555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1RIotwJy9sqXQwL5qTyXf76s+adD7eN65AFmUkxujw=;
	b=Zka3L9u9yi/YcYD5QweP2ZXtXKyh6ixJ+45+o1WWC4jNcqbyYglqucX4kVrxl/SgmBONQn
	+CMoQNjyuQ2jL5e507DyCdXjVtCJb7o+UsmDqOYLPOKCc3ggKnjam3bhx5N8/Z+i5rtjoV
	Dac8m/ylVEQWmQw+sXE6yKdNSjXOvo67jb+qJMy7DYPGfoBzFF57Lbm6VNZGPIqc2Lb5de
	eKD+pTOXvAyAPxQCGfxNa/GwQd02aQJe9kLFY+toFGGf4WNARoN2UxdXWNowRHddFXz7Qh
	4rt/FEV6UILiJRzwee84O8qIFPFD1TRuZPT5c7da+6Ys3q0pOmzX5MNlXwnyoA==
Date: Wed, 4 Dec 2024 09:22:32 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Simon Horman
 <horms@kernel.org>, Herve Codina <herve.codina@bootlin.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 09/10] net: freescale: ucc_geth: Introduce a
 helper to check Reduced modes
Message-ID: <20241204092232.02b8fb9a@fedora.home>
In-Reply-To: <ce002489-2a88-47e3-ba9a-926c3a71dea9@lunn.ch>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
	<20241203124323.155866-10-maxime.chevallier@bootlin.com>
	<ce002489-2a88-47e3-ba9a-926c3a71dea9@lunn.ch>
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
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew,

On Wed, 4 Dec 2024 03:15:52 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static bool phy_interface_mode_is_reduced(phy_interface_t interface)
> > +{
> > +	return phy_interface_mode_is_rgmii(interface) ||
> > +	       interface == PHY_INTERFACE_MODE_RMII ||
> > +	       interface == PHY_INTERFACE_MODE_RTBI;
> > +}  
> 
> I wounder if this is useful anywhere else? Did you take a look around
> other MAC drivers? Maybe this should be in phy.h?

Yes I did consider it but it looks like ucc_geth is the only driver
that has a configuration that applies to all R(MII/GMII/TBI) interfaces
:/ I didn't even know about RTBI mode before looking at that driver and
it does look like it's not supported by that many devices... I'd be
happy to put that in phy.h but I think ucc_geth is going to be the sole
user :)

Thanks,

Maxime


