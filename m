Return-Path: <netdev+bounces-190402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DFAAB6B78
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBDB1B675CC
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D312749CC;
	Wed, 14 May 2025 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VYVQYDfD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C61F8676;
	Wed, 14 May 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226067; cv=none; b=WhYh+EYwcT1QIAHlFkJDqxwOcsyVBe1KGaabz3HwP/EdTHIms1RJn6n8tpOHfMRxxlac7HsEiNqBsRjzQxNBgLum3efY4AXshLW1jTqX0eSKzwuDmZKCmvvYH4lIVvv5rXRM2qnyJU1Y2jLdZMeadxuHv4ghLOjxFLyyL6d4q9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226067; c=relaxed/simple;
	bh=BoX7BptIjJpFs1HwhFxu9XsSU6wZeouWq00jISncoGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nizZJzxlX2Wmh6aCTQIyHUTWlXF1oTzn6IHG2W1SRXHa44msWD4WvcvJdQTWc57bGrFZY/hbc6YXtpgFWTPkeovKLSZNlQMq0u+8NhcU3ZEV2fezFEdQIgySG5DVJ/qWBya7EWRsUTtq/Mw+L2sboZSSmSK9Kx4TW4+mvWi9KWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VYVQYDfD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cwIC9DjzDBbh5UYo4Hli25lV6RdLiigp3M/qiyFhOpM=; b=VYVQYDfDIfjAbMXrAIS4At3Mja
	I2PCEc0mnNHiXkaGfb+76OJlnFmEoE8oPf5CI1Eo0OvUD1iYpkETlnjj43vBU19HwgoSGPvpCLPll
	mFKgWwhMEuqU495XyzuLlHXXxVpWnurXcIU8WIM18t2GaQl9x7Y/8fE0H4LwlGtkgljc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFBJS-00CYge-Ly; Wed, 14 May 2025 14:34:18 +0200
Date: Wed, 14 May 2025 14:34:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phy: dp83869: Support 1000Base-X SFP
 modules
Message-ID: <c3c043aa-748b-4355-b830-d957f1678f12@lunn.ch>
References: <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
 <20250514-dp83869-1000basex-v1-3-1bdb3c9c3d63@bootlin.com>
 <99c9d8f8-1557-4f90-8762-b04a09cb497c@lunn.ch>
 <10709391.nUPlyArG6x@fw-rgant>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10709391.nUPlyArG6x@fw-rgant>

> > There is also DP83869_RGMII_SGMII_BRIDGE. Can this be used with the
> > SERDES? Copper SFPs often want SGMII.
> 
> It can definitely be used to support non-DAC copper modules. In fact, I've 
> implemented support for these modules locally, but I'm planning to upstream 
> this part of the SFP support later, as there is some additional trickiness to 
> solve beforehand.

Ah, yes. Please add a comment to the commit message.

	Andrew

