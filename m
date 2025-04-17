Return-Path: <netdev+bounces-183793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101ADA91FCC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B40C19E7FBA
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ED824290B;
	Thu, 17 Apr 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G6amCWHs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7815A868
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900568; cv=none; b=T7HFcVL6RI2a/VZxs3MlmaoS3RGcUzKLrmaZo8iWsCJWFPGAvJXLJoMpUL0c800BKCMcwMNAvgOMnNTDu/1yzEwpYvFREd+PeHtwXmGEFXG8mGyoIxK3h/UAVLz5V/c8wLMTEY5eIC0HoHQ6yhKH2cdkTi0nN6uh3qhDbPzwKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900568; c=relaxed/simple;
	bh=g4GIEyoKGnYEoIlrmiLj5NrvXyWBIpC0nUqdAYuEV34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9MNKrY90hgfsSoKaBBH/WPMQzi7pZczzRBbqhUQMph28DJRQrv1hV834IXuPiFCx5eaI+7yZwlaqg9xll2zbgMe9RkeEY6+8JIyVRn2qiqTTaI8qoCSk01XOhB0EuCLDf8NT4TtP0qOOptCxT20U+Xne+Puvv4m+1GjWJLv4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=G6amCWHs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=na3IgQ+IE2L7VcnvxSM9ZbWMv/cejCn8LqRzyVW5wx0=; b=G6amCWHsTr4uB6FY1evXOGH3f8
	QH0R2CndR7w5Xg4sLUx+0sLa+iPBDV7mHfT6m9VbILXQsmykZRqhnDK7Pilld6MUVDoL/NmPKW7G+
	28vjvDPgpmJXm5c9COv3sGRFz15mIUYmCUkkloc7z+TmXbszqa3B9R7ghZdUJTDfNkaKCAe6EzYki
	YJoVIBdjKC8psI859aXhGVu7AfJ7v2lIBv6h/MZ/DaMbuqr3m5KzTr2LcOwdn/F4yo0VNNdPdXr9E
	Or/poUSvIhw9s24XAf4jSNbQFtRyAAO7k7wa/vxmsdIFLeNiaxWd2GE+bf2tZpTDn3PQSjC0yB9f3
	9AR2oLHQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53996)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u5QLO-0007Qw-1o;
	Thu, 17 Apr 2025 15:35:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u5QLM-0002Vn-0F;
	Thu, 17 Apr 2025 15:35:56 +0100
Date: Thu, 17 Apr 2025 15:35:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phylink: fix suspend/resume with WoL enabled
 and link down
Message-ID: <aAERy1qnTyTGT-_w@shell.armlinux.org.uk>
References: <Z__URcfITnra19xy@shell.armlinux.org.uk>
 <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
 <9910f0885c4ee48878569d3e286072228088137a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9910f0885c4ee48878569d3e286072228088137a.camel@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 17, 2025 at 07:30:05AM -0700, Alexander H Duyck wrote:
> On Wed, 2025-04-16 at 17:16 +0100, Russell King (Oracle) wrote:
> > When WoL is enabled, we update the software state in phylink to
> > indicate that the link is down, and disable the resolver from
> > bringing the link back up.
> > 
> > On resume, we attempt to bring the overall state into consistency
> > by calling the .mac_link_down() method, but this is wrong if the
> > link was already down, as phylink strictly orders the .mac_link_up()
> > and .mac_link_down() methods - and this would break that ordering.
> > 
> > Fixes: f97493657c63 ("net: phylink: add suspend/resume support")
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > 
> > To fix the suspend/resume with link down, this is what I think we
> > should do. Untested at the moment.
> > 
> >  drivers/net/phy/phylink.c | 38 ++++++++++++++++++++++----------------
> >  1 file changed, 22 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 69ca765485db..d2c59ee16ebc 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -81,6 +81,7 @@ struct phylink {
> >  	unsigned int pcs_state;
> >  
> >  	bool link_failed;
> > +	bool suspend_link_up;
> >  	bool major_config_failed;
> >  	bool mac_supports_eee_ops;
> >  	bool mac_supports_eee;
> 
> I'm pretty sure this extra bit of state isn't needed.
> 
> > @@ -2545,14 +2546,16 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
> >  		/* Stop the resolver bringing the link up */
> >  		__set_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state);
> >  
> > -		/* Disable the carrier, to prevent transmit timeouts,
> > -		 * but one would hope all packets have been sent. This
> > -		 * also means phylink_resolve() will do nothing.
> > -		 */
> > -		if (pl->netdev)
> > -			netif_carrier_off(pl->netdev);
> > -		else
> 
> This is the only spot where we weren't setting netif_carrier_on/off and
> old_link_state together. I suspect you could just carry old_link_state
> without needing to add a new argument. Basically you would just need to
> drop the "else" portion of this statement.
> 
> In the grand scheme of things with the exception of this one spot
> old_link_state is essentially the actual MAC/PCS link state whereas
> netif_carrier_off is the administrative state.

Sorry to say, but you have that wrong. Neither are the administrative
state.

> > +		pl->suspend_link_up = phylink_link_is_up(pl);
> > +		if (pl->suspend_link_up) {
> > +			/* Disable the carrier, to prevent transmit timeouts,
> > +			 * but one would hope all packets have been sent. This
> > +			 * also means phylink_resolve() will do nothing.
> > +			 */
> > +			if (pl->netdev)
> > +				netif_carrier_off(pl->netdev);
> >  			pl->old_link_state = false;
> > +		}
> >  
> >  		/* We do not call mac_link_down() here as we want the
> >  		 * link to remain up to receive the WoL packets.
> > @@ -2603,15 +2606,18 @@ void phylink_resume(struct phylink *pl)
> >  	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
> >  		/* Wake-on-Lan enabled, MAC handling */
> >  
> > -		/* Call mac_link_down() so we keep the overall state balanced.
> > -		 * Do this under the state_mutex lock for consistency. This
> > -		 * will cause a "Link Down" message to be printed during
> > -		 * resume, which is harmless - the true link state will be
> > -		 * printed when we run a resolve.
> > -		 */
> > -		mutex_lock(&pl->state_mutex);
> > -		phylink_link_down(pl);
> > -		mutex_unlock(&pl->state_mutex);
> > +		if (pl->suspend_link_up) {
> > +			/* Call mac_link_down() so we keep the overall state
> > +			 * balanced. Do this under the state_mutex lock for
> > +			 * consistency. This will cause a "Link Down" message
> > +			 * to be printed during resume, which is harmless -
> > +			 * the true link state will be printed when we run a
> > +			 * resolve.
> > +			 */
> > +			mutex_lock(&pl->state_mutex);
> > +			phylink_link_down(pl);
> > +			mutex_unlock(&pl->state_mutex);
> > +		}
> 
> You should be able to do all of this with just old_link_state. The only
> thing that would have to change is that you would need to set
> old_link_state to false after the if statement.

Nope.

> I'm assuming part of the reason for forcing the link down here also has
> to do with the fact that you are using phylink_mac_initial_config which
> calls phylink_major_config after this?

Another of phylink's guarantees is that it won't do the mac_config()
etc with the link up. So, in order to ensure that everything is
correctly programmed after resume, it needs mac_config() etc called
which means the link needs to come down first.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

