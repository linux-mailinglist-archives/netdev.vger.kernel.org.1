Return-Path: <netdev+bounces-216327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C48DAB331F8
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 20:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E74317A18F
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 18:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083782DEA7E;
	Sun, 24 Aug 2025 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dgANrgpX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66391FE45A;
	Sun, 24 Aug 2025 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756059273; cv=none; b=aCk2iy69h2lkfRNrQOrk4Kh8MyDaU6o8NlSU4vh9g72IHLfnfm7kDRST+dJ6PTQ2B4fTwJuIT3/ZJAtoqxnyC8u/u/w7IkD79PLnmpLEC9+jzbFtPXUCguv8xEQIhAL0VZLGj83eXMqeQZgFnUlJyk2eI+HJAEe1CVVmb0Zwg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756059273; c=relaxed/simple;
	bh=TJNJUs7BdfKwvqPlqwt1ikUMYYrNieg0cHzh8INfazE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvV2v4Zo6GolzU3mWnWLIEetFvvIfIaaZO1un7xomuIpXDA19b1sTGZXr6oYtaYYbeH/GcBWj6n/eWOXju/niT5FmoqeubiATECQY2xy2Qs89CRdtPwrhF5vRtfpZR3ZH/9u3qrXB156iQynbfLwQadFY4nPcRSDPDrnDMKJngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dgANrgpX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NWaOUvxnDMTU8wm7A+2zDGkNmWknEZ9aGJE9ozOoOQc=; b=dgANrgpXkYG0M5WRYaYXGn8w/3
	1KdF1ZKUHDUv09zoDnXgOvIRyyV89H9RYQuhT8S4V5VbrzkwtYOzwwPabExfUQGgFd7ZfCHNV7Ic2
	fOhWc6CYkOEozcpBA8HxquEnrX9aTjXL0ro5Aq9bMb2cPcyQtT/zKWQdJs23mifrYquAwPbTs2qpR
	dGSyAUxFz45swssGl1QCmlJY297u7m416xNVoEwMUj097AoOTLh2M9jfIHb0PATydNrPrzjBJc+xZ
	I0gbNfrX4QpKYAGRFBdHePCK/BlxiT2ZLnKgiMSdfoE3k7EplyYmeUYI9VvRyRzzTLyfynV/Ajekr
	DW4KLfXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35892)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uqFET-000000005hC-1nJE;
	Sun, 24 Aug 2025 19:14:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uqFEQ-000000007EV-2Xov;
	Sun, 24 Aug 2025 19:14:18 +0100
Date: Sun, 24 Aug 2025 19:14:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yangfl <mmyangfl@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <aKtWej0nymW-baTC@shell.armlinux.org.uk>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-4-mmyangfl@gmail.com>
 <ad61c240-eee3-4db4-b03e-de07f3efba12@lunn.ch>
 <CAAXyoMP-Z8aYTSZwqJpDYRVcYQ9fzEgmDuAbQd=UEGp+o5Fdjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMP-Z8aYTSZwqJpDYRVcYQ9fzEgmDuAbQd=UEGp+o5Fdjg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 25, 2025 at 12:38:20AM +0800, Yangfl wrote:
> They are used in phylink_get_caps(), since I don't want to declare a
> port which we know it does not exist on some chips. But the info_* set
> might be inlined and removed since it is not used elsewhere.

The problem is... if you have a port in 0..N that DSA thinks should be
used, but is neither internal or external, DSA's initialisation of it
will fail, because without any caps declared for it, phylink_create()
will return an error, causing dsa_port_phylink_create() to fail,
dsa_shared_port_phylink_register() or dsa_user_phy_setup(),
dsa_shared_port_link_register_of() or dsa_user_create()... etc. It
eventually gets propagated up causing the entire switch probe to fail.

Again... read the code!

> > I don't understand the name _burst here? Why is it called
> > that. Looking at other drivers, _u32 would be more common, especially
> > if you have functions to read a _u16, _u8 etc.
> 
> They are locked wrappers for their unlocked counterparts. I'd like to
> name the unlocked versions __yt921x_smi_read just like __mdiobus_read,
> but that was turned down in the previous version, so I have to give
> the locked versions a stranger marker since we use unlocked versions
> more often.

Who turned it down, and what reason did they give, given that it's an
established pattern in the phylib, mdiobus and mdiodev APIs.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

