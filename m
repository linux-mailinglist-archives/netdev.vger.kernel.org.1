Return-Path: <netdev+bounces-109124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ECD92712B
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C73328422E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1F21A3BC7;
	Thu,  4 Jul 2024 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oUWeZS9A"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CE1A0AF7;
	Thu,  4 Jul 2024 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080197; cv=none; b=fCr6RnKUjNPrgmzC+sPWQ7qLEyGFsbt4jlLQ0wUfSsFXiNpvvn9zqInCcPfphR3nPcgWNNI5M4p4501Z01CEfW9CpFSLHVbltQ9wCYi2K2n4oaxl/MKPNHnKKl96MgizdWQtGVIshimdC4IEZ4fSqiS9mhUIwcyI2uNaMc6Exiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080197; c=relaxed/simple;
	bh=wjdxwy7JdU++nCctnY2Z7f24fc/hxQ0ZQpltW56jY7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSAshIoPwSdSp+VeRXhmvp+5n6do0YVuwPtyks8nwc5fHzuhr7/87jGVQai96ctISgcmBjjf156J9dzY686462cPd0cnWosqU5AsixGWKXnSGnQnMMUn468g6alUjg4z0C9rYOKWeKiFzHNnHKlGqaTLm8KgsBq02BuwWn5g2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oUWeZS9A; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 106C220003;
	Thu,  4 Jul 2024 08:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720080186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3QQQ5ARWg4GTEklbN8jcuflrQuDFZGUcDJdod6ovi4=;
	b=oUWeZS9AvwLJ2VifN/dXxxjXi9B37TDv2jxdj9yaKQZnECttYL+V09i0//Ce9dFEzKqt01
	2k3HKUvF70jPFlCUTyqIS55woW9/BLrOBtbk9PuccudyuBA09RPMiwM7xJkWHND2BJWvHL
	HH6Y+HoyugneC2qbg6fBjgpIKlhv9fQ3T+rTzv6t/l02VmuL9cfrDxyC09xguVUYuYd0DK
	VkX1SR8halZQihNKORBNlkJ/LF+lbmza3olJ5dIkRbdLJ4qpv6nRszfnWNBzy/FxKviEWt
	HWn3hJ7RETbTITuk0Qci1Cxu9fLktAqNCzfFspDoK165xgnQeDo/HfR86Bz2uQ==
Date: Thu, 4 Jul 2024 10:03:02 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next v15 07/14] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <20240704100302.2c9983ca@fedora-2.home>
In-Reply-To: <ZoVlnLkXuJ0J/da3@shell.armlinux.org.uk>
References: <20240703140806.271938-1-maxime.chevallier@bootlin.com>
	<20240703140806.271938-8-maxime.chevallier@bootlin.com>
	<ZoVlnLkXuJ0J/da3@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell,

On Wed, 3 Jul 2024 15:52:12 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> So, if we want to report the ID of the PHY, then really we need to
> report the clause 22 ID, and at least all the devids of each MMD in
> a clause 45 PHY. Alternatively, we may decide it isn't worth the
> effort of reporting any of these IDs.
> 
> However, reporting just the clause 22 ID would be a design error
> IMHO.

I don't have any strong reason to keep exporting the PHY id. Reporting
the driver name is enough to get a good idea of the nature of the
device, I'll drop that field then.

Thanks for taking a look,

Maxime


