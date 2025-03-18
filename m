Return-Path: <netdev+bounces-175594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C023FA668F2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 06:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25324177CDA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 05:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F651C4A20;
	Tue, 18 Mar 2025 05:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A11922D4
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 05:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742274486; cv=none; b=g8Q0L4/5sr7evLSZrPTyGZZjkFYCscl2yPO/q9IfMQfpuY9xij84Nzf+v9G1UCCSGyrdsNt0LQ/9aFEr91hBgkpi7ST962uBdsfbFVtxGUHp/Ndl+4GCa3Szs2gdMBPUNM5C4GCc0FNKlSv/Q+h9plu1rbL3SagpiOh7qCFau7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742274486; c=relaxed/simple;
	bh=dAwK6VyoBMPJbyyrkiV5DQqfpvk1hO+euZaOunzRArg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otSTUuZDF3+X9yBxf0sHzX4+vZMW+89CPveRvezy8hUE3smMJRNJcL5ngUmtDVqGLH3yl/QPjqGHKnyuLQwfhBE9zW7YxclON+vixg2vAvWsysXKqVYQgC//KE9F47gzErTj0riodc86NzNkA8i73koJ3yIoreAZVc4NYqJERhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tuPBH-0001I9-Sf; Tue, 18 Mar 2025 06:07:59 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuPBF-000N9b-1z;
	Tue, 18 Mar 2025 06:07:58 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuPBF-002v6x-2s;
	Tue, 18 Mar 2025 06:07:57 +0100
Date: Tue, 18 Mar 2025 06:07:57 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 1/7] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <Z9j_rcK23cO4rmZM@pengutronix.de>
References: <20250310115737.784047-1-o.rempel@pengutronix.de>
 <20250310115737.784047-2-o.rempel@pengutronix.de>
 <20250317153611.GB688833@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317153611.GB688833@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Mar 17, 2025 at 03:36:11PM +0000, Simon Horman wrote:
> On Mon, Mar 10, 2025 at 12:57:31PM +0100, Oleksij Rempel wrote:
> 
> ...
> 
> > +static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
> > +{
> >  	struct phy_device *phydev;
> > +	int ret;
> 
> nit: not strictly related to this patch as the problem already existed,
>      but ret is set but otherwise unused in this function. Perhaps
>      it can be removed at some point?
> 
>      Flagged by W=1 builds.

Ack. This is addresses in 3. patch

> > +	u32 buf;
> >  
> >  	phydev = phy_find_first(dev->mdiobus);
> >  	if (!phydev) {
> > -		netdev_dbg(dev->net, "PHY Not Found!! Registering Fixed PHY\n");
> > -		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> > -		if (IS_ERR(phydev)) {
> > -			netdev_err(dev->net, "No PHY/fixed_PHY found\n");
> > -			return NULL;
> > -		}
> > -		netdev_dbg(dev->net, "Registered FIXED PHY\n");
> > -		dev->interface = PHY_INTERFACE_MODE_RGMII;
> > +		netdev_dbg(dev->net, "PHY Not Found!! Forcing RGMII configuration\n");
> >  		ret = lan78xx_write_reg(dev, MAC_RGMII_ID,
> >  					MAC_RGMII_ID_TXC_DELAY_EN_);
> >  		ret = lan78xx_write_reg(dev, RGMII_TX_BYP_DLL, 0x3D00);
> 
> ...
> 
> > @@ -4256,13 +4281,13 @@ static void lan78xx_delayedwork(struct work_struct *work)
> >  		}
> >  	}
> >  
> > -	if (test_bit(EVENT_LINK_RESET, &dev->flags)) {
> > +	if (test_bit(EVENT_PHY_INT_ACK, &dev->flags)) {
> >  		int ret = 0;
> >  
> > -		clear_bit(EVENT_LINK_RESET, &dev->flags);
> > -		if (lan78xx_link_reset(dev) < 0) {
> > -			netdev_info(dev->net, "link reset failed (%d)\n",
> > -				    ret);
> > +		clear_bit(EVENT_PHY_INT_ACK, &dev->flags);
> > +		if (lan78xx_phy_int_ack(dev) < 0) {
> > +			netdev_info(dev->net, "PHY INT ack failed (%pe)\n",
> > +				    ERR_PTR(ret));
> 
> nit: ret is always 0 here. So I'm unsure both why it is useful to include
>      in the error message, and why ERR_PTR() is being used.
> 
>      Flagged by Smatch.

Thank you, i'll take a look on it.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

