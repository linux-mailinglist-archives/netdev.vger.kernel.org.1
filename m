Return-Path: <netdev+bounces-56965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3AF811783
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB4DB20DD3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0348CE4;
	Wed, 13 Dec 2023 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r07yZCGV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4231D3589;
	Wed, 13 Dec 2023 07:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9978jlZQf3NVTxyYkzi3XIo0ZbcfDevuq9k/9lHvdV4=; b=r07yZCGVUBvJzd9mCwnq2ujqOB
	G6mKzZ7BENeWo0nIxZur6VcFU283fasbIOUFsvpgix6Q7TxGxGNmU9S8XTuKUF/9XufeaSU/fAVGJ
	ZDP+2UgE4uKVDNS+9UfDRrOJWwrEhlGdWCPHssIaXhbZmgjzqQZLDYv9oKECYcVaXnC2/LN8zrwoW
	6q21rIo1GxRN8H6tl+XmJqyNCJDdEdjEcwkvfngCx3JY18GB2XnhXCsY/oAA0i3axClNJ4EBtB4KO
	M99mU+wAZulBGPlInm94Y9b0QEPzsfgOSHlcnwWzwv/OYPPFlOkN33mKusLsD9d7sSbLdkhc82sH0
	VrPUvDIg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49670)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDR8y-00008g-0n;
	Wed, 13 Dec 2023 15:27:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDR8y-0001b4-Qh; Wed, 13 Dec 2023 15:27:28 +0000
Date: Wed, 13 Dec 2023 15:27:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <ZXnNYJer0JrJxOsl@shell.armlinux.org.uk>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
 <20231212153512.67a7a35b@device.home>
 <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 13, 2023 at 10:08:25AM +0100, Andrew Lunn wrote:
> On Tue, Dec 12, 2023 at 03:35:12PM +0100, Maxime Chevallier wrote:
> > Hi Daniel
> > 
> > On Tue, 12 Dec 2023 00:05:35 +0000
> > Daniel Golle <daniel@makrotopia.org> wrote:
> > 
> > > Calling led_trigger_register() when attaching a PHY located on an SFP
> > > module potentially (and practically) leads into a deadlock.
> > > Fix this by not calling led_trigger_register() for PHYs localted on SFP
> > > modules as such modules actually never got any LEDs.
> > 
> > While I don't have a fix for this issue, I think your justification
> > isn't good. This isn't about having LEDs on the module or not, but
> > rather the PHY triggering LED events for LEDS that can be located
> > somewhere else on the system (like the front pannel of a switch).
> 
> SFP LEDs are very unlikely to be on the front panel, since there is no
> such pins on the SFP cage.
> 
> Russell, in your collection of SFPs do you have any with LEDs?

No, and we should _not_ mess around with the "LED" configuration on
PHYs on SFPs. It's possible that the LED output is wired to the LOS
pin on the module, and messing around with the configuration of that
would be asking for trouble.

In any case, I thought we didn't drive the LED configuration on PHYs
where the LED configuration isn't described by firmware - and as the
PHY on SFP modules would never be described by firmware, hooking
such a PHY up to the LED framework sounds like a waste of resources
to me.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

