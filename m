Return-Path: <netdev+bounces-226038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F09B9B1C6
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB89E1B264FC
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBEA313E3E;
	Wed, 24 Sep 2025 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HO3rF3uB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B52FBE05;
	Wed, 24 Sep 2025 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736230; cv=none; b=LD7v0v1ZlPSE1kzurYByicUMv0GIzZfnjBLVIs204fYvB3Z5sXDMVRCVB79i519w3mz3r1MsPkpWInNANxl3hXaR6Z7bgywWMEwCxTKMtzWzn42QhNzKNXoiPd0HNvqEe09E3wh8fPw4fMXAbgGfMTslTfLhw+xWMvgmdLbMwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736230; c=relaxed/simple;
	bh=xB7pPlWW0+eiQnT8mrW75khUnjKN0I9h+uNbHWk55Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkTKBmU9wb6Qmf4QqkkjH5ZLAnHJ1SYz3W779IYaMHhuKPEy9OnVDQsFbM2cMeLpr6x+ts1+w7jgxWRtqWpgI1FxBkiAZz40RDlM90bWAzKRXlrAv3M7TGs8IymV5zqRjh8OMvJPThzxk9QzG60lVdb2J8QipT9jgPYiT1CkkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HO3rF3uB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+vJ1dOlsQQaSGt9wLwAFi3DtF1NLVEuTTQ4UpKnYZ3M=; b=HO3rF3uBCQ2jcVMAxeZgSdPp+w
	8JkNip2tIfNxVFlpWPPVkI3BxcxjT7OnUMTN+u9aYpdeRIv/Z9nfvGmfCqFFLocvpncoMTU5AwrkI
	GV91ILjtr0b025Bd2tFtERmWPEgLfydMGRbR6Kkz9kOtIt8R+KhJO3N4o8dzZ/RcLDeIWSHByJTuh
	I8aS1ggLI1BYgbwVQZNMs+x+aNZ0IqLloKs2pVEMtkg7neTQ9XzTSoonUdT7AOxQyVR7yg7kQVeaw
	lZ7J5eK6Fi/eEXF2iAgmf8NpuEfoORJxZQZD/gDLQXImTU2ZIActbAJNmtXC3rWEy4r+Ijg2uaRNS
	aCqWKUXQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55252)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v1TdH-000000000z7-0TDa;
	Wed, 24 Sep 2025 18:50:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v1TdE-000000007L9-04ys;
	Wed, 24 Sep 2025 18:50:20 +0100
Date: Wed, 24 Sep 2025 18:50:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Yang <mmyangfl@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 2/5] net: phy: introduce
 PHY_INTERFACE_MODE_REVSGMII
Message-ID: <aNQvW54sk3EzmoJp@shell.armlinux.org.uk>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
 <20250922131148.1917856-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922131148.1917856-3-mmyangfl@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 22, 2025 at 09:11:40PM +0800, David Yang wrote:
> The "reverse SGMII" protocol name is a personal invention, derived from
> "reverse MII" and "reverse RMII", this means: "behave like an SGMII
> PHY".

Sorry to mess you around, but... I've been getting further with stmmac's
PCS stuff (I've started again with it) and I've come to realise that the
stmmac driver is full of worms here.

I think we need to have a bigger discussion here.

Today, we have:

- PHY_INTERFACE_MODE_REVMII
- PHY_INTERFACE_MODE_REVRMII

which both complement their _MII and _RMII definitions. So, it seems
entirely sensible to also introduce REVSGMII to complement SGMII.

However, stmmac hardware supports "reverse" mode for more than just
SGMII, also RGMII and SMII. The driver doesn't support SMII, and is
actually buggy - despite having the DT configuration knobs (which
are used), the hardware is never actually configured to operate in
"reverse" mode (it never has the GMAC_CONFIG_TC bit set to allow the
core to, in effect, act as a PHY.) That said, the core does have
it's SGMII rate adapter switched from using the incoming inband word
to using the MAC configuration.

So, while I thought this would be useful for stmmac, given that all
the platforms we have today aren't actually using "reverse SGMII"
mode, I don't think this will be useful there.

If we go round the route of adding REVSGMII, we are also opening
the path to also having REVSMII, and all four REVRGMII* as well.
Is this a good idea?

Would it be better to have phy_interface_t + reverse-mode flag
and accept REVMII and REVRMII as a pecularity? That's probably
going to be a very painful change.

Andrew, any views?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

