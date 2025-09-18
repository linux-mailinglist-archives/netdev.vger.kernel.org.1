Return-Path: <netdev+bounces-224605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F70B86D5D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A696D3AD337
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE14307AD8;
	Thu, 18 Sep 2025 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eQW9TtDw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4BA15442C;
	Thu, 18 Sep 2025 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226113; cv=none; b=Gwlvi4hAQxK38fhNKIb7uqZaOE3uihy7NM1KeitHMJOuVW5Y9cQx3JNcfd28V2XU/K5lbbMRkboBr1q3qXgZdOz+l9z1458jZ1ChgmEliFdIt8OhewkA7impnA/GRv7MtBQU1iRvyA8ucGf4FHYW5A5qBNvt0BazGQTYvSdSl4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226113; c=relaxed/simple;
	bh=/xURkBEfhrP61DoKhLS8ai19KyG8Yjda32gGq/Q1IbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bft/q2wAEt10zgK5uLH0OMO3OZdqZ8IiTiZ7NpcSHldosgSuhFFTlKKnd3whNcWPLNsNKYm7tf09nxqlkTjyS7xdBq5LLcOkubEsKtcBkEdFuaCCr4kp5smIY0CtSaKZd/PGWzdkanjppAQGJUeeWMOUh3SL0G7sv2B0/SZ7Tj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eQW9TtDw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jT4S+lSLA3Y+AUajY/seHKGckePfxG1gceQ7KGrgVkc=; b=eQW9TtDw+1Ls7yx8EPz+nWzEin
	QxsQcwqpxrt+dYwLttywOXbRUoP+wEwsVgM4Gde/eyq7X1duA+bq4Rk59C91coMzwXDHvhDOlR7NL
	HSuZzYyv0IqrmM6nVQCsZ3k2KOMgGRhF15abncZN/f7xJIgQlgspcuOxQkiyyl4ugcTUrQDdefZh/
	SKN7Rbsk4kteWetKTNNXgMY0E//tna4bQrxQfwW2FDd+1e+OclQfBtSIplTryq897UcCDiitHQ2iv
	lAbuKpFehN7SQdBJXPCy2MtafF9j85aOkvb/TOHnS78z3sYYSD3PBBlzw6O/hMBWJ/p85dXI0/7Ql
	lPr+eVzA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60456)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uzKvS-0000000024E-3bbf;
	Thu, 18 Sep 2025 21:08:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uzKvP-000000001Tc-06qP;
	Thu, 18 Sep 2025 21:08:15 +0100
Date: Thu, 18 Sep 2025 21:08:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andre Edich <andre.edich@microchip.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH net v4 0/3] net: phy: smsc: use IRQ + relaxed polling to
 fix missed link-up
Message-ID: <aMxmrnmDEqn0Nvx1@shell.armlinux.org.uk>
References: <20250714095240.2807202-1-o.rempel@pengutronix.de>
 <657997b5-1c20-4008-8b70-dc7a7f56c352@lunn.ch>
 <aMqw4LuoTTRspqfA@pengutronix.de>
 <a873e8e3-e1c9-4e82-b3e8-4b1cc8052a73@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a873e8e3-e1c9-4e82-b3e8-4b1cc8052a73@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 18, 2025 at 09:48:33PM +0200, Andrew Lunn wrote:
> > How about a minimal change instead: conditionally call
> > phy_queue_state_machine() from lan87xx_config_aneg()? That would trigger
> > a poll in the broken mode without touching phydev->irq or core teardown
> > paths. Seems less intrusive than rewriting IRQ handling.
> 
> It is currently a static function, so that would have to change.
> 
> Or it might be better to add phy_trigger_machine_soon(), using the
> default 1 second delay? And i would document it as only to be used by
> broken PHYs, to try to stop it being abused. Anybody using it needs to
> acknowledge their PHY is broken.

Couldn't this be even simpler? If the problem is the interrupt
isn't raised, then how about the following.

(This assumes there is no issue with calling phy_trigger_machine()
from IRQ context.)

When lan87xx_config_aneg() detects that we're configuring into the
broken mode, start a timer (which has been pre-initialised at probe
time.) When the timer fires, call phy_trigger_machine(), and modify
the timer for the next poll interval.

When lan87xx_config_aneg() detects that we aren't in the broken
mode, delete the timer synchronously. Also delete the timer when
the PHY is suspended or unbound.

This requires no changes necessary to the core phylib code, and no
fiddling with fragile state either. Does it matter if the
interrupt does fire? Not really.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

