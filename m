Return-Path: <netdev+bounces-180453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F2A815BD
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F901B84AE7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47098237163;
	Tue,  8 Apr 2025 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v3nzJNZQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F1720E332;
	Tue,  8 Apr 2025 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744140134; cv=none; b=Zeni5Ca0JcqqchaWU2JOGA7mexoNecgufYyNa2lnddCncg22QjZFZHS8kvgFb5X32aRLBEdzV5AZYO9k7U0ThnzD0ekoITrtIhDm8EmPMW4bb+Q69czYHN7PqNTzA5jiIjTr5cRAJO3BhGe0/GXlroXHRyO4sV3K5W2t094JY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744140134; c=relaxed/simple;
	bh=Sq6qE3bdNlKrIH+jwg54WcNbmrQhN9OHUYTXKi+ZC1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqI1o59DmqV0ec1BwSAfkkZcJB4LjFd7qWWw85NoM2QNIhhu+YxsEYRU4zUh3cNwmXGiPXjOVNKyrYjvl8D49EJpUvYjiQPC4r6h2Ct0ykS/VeMNDMRxm+9BuSKLjFJKPBgBZDZSapeYG4eS+ZX9onB/y/OSIdZp9PShoEvogxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v3nzJNZQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nWdwAmsvl+J4jdX1SK8QB+Dmfqlg71MkeOOS1luZS08=; b=v3nzJNZQ07pfSxqfTgz07yzMp+
	FG0I65PEHs5mB4C0ahp50VogmivCjZldf3RPq8CoFwTzr7q6ZDDzn2yY1GZ6w+m5BPiafKX6QGEe5
	jiOHwbp5dp7njlnVsXfSRX/AsSZOVII7irdWqZpm7W84mcNnodWQsPXj2WMqKRhLpMbs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2EWE-008RUU-Dj; Tue, 08 Apr 2025 21:21:58 +0200
Date: Tue, 8 Apr 2025 21:21:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Klein <michael@fossekall.de>
Cc: Joe Damato <jdamato@fastly.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND net-next v5 2/4] net: phy: realtek: Clean up RTL8211E
 ExtPage access
Message-ID: <4d26d92e-f083-4a5c-88b5-93c45c6a51a5@lunn.ch>
References: <20250407182155.14925-1-michael@fossekall.de>
 <20250407182155.14925-3-michael@fossekall.de>
 <Z_SQTi-uKk4wqRcL@LQ3V64L9R2>
 <Z_VvOG91oPZZejye@a98shuttle.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_VvOG91oPZZejye@a98shuttle.de>

On Tue, Apr 08, 2025 at 08:47:20PM +0200, Michael Klein wrote:
> On Mon, Apr 07, 2025 at 07:56:14PM -0700, Joe Damato wrote:
> > > - Factor out RTL8211E extension page access code to
> > >   rtl8211e_modify_ext_page() and clean up rtl8211e_config_init()
> > > 
> > > Signed-off-by: Michael Klein <michael@fossekall.de>
> > > ---
> > >  drivers/net/phy/realtek/realtek_main.c | 38 +++++++++++++++-----------
> > >  1 file changed, 22 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> > > index b27c0f995e56..e60c18551a4e 100644
> > > --- a/drivers/net/phy/realtek/realtek_main.c
> > > +++ b/drivers/net/phy/realtek/realtek_main.c
> > > @@ -37,9 +37,11 @@
> > > 
> > >  #define RTL821x_INSR				0x13
> > > 
> > > -#define RTL821x_EXT_PAGE_SELECT			0x1e
> > >  #define RTL821x_PAGE_SELECT			0x1f
> > > 
> > > +#define RTL8211E_EXT_PAGE_SELECT		0x1e
> > > +#define RTL8211E_SET_EXT_PAGE			0x07
> > > +
> > >  #define RTL8211E_CTRL_DELAY			BIT(13)
> > >  #define RTL8211E_TX_DELAY			BIT(12)
> > >  #define RTL8211E_RX_DELAY			BIT(11)
> > > @@ -135,6 +137,21 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
> > >  	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
> > >  }
> > > 
> > > +static int rtl8211e_modify_ext_page(struct phy_device *phydev, u16 ext_page,
> > > +				    u32 regnum, u16 mask, u16 set)
> > > +{
> > > +	int oldpage, ret = 0;
> > > +
> > > +	oldpage = phy_select_page(phydev, RTL8211E_SET_EXT_PAGE);
> > > +	if (oldpage >= 0) {
> > > +		ret = __phy_write(phydev, RTL8211E_EXT_PAGE_SELECT, ext_page);
> > > +		if (ret == 0)
> > > +			ret = __phy_modify(phydev, regnum, mask, set);
> > > +	}
> > > +
> > > +	return phy_restore_page(phydev, oldpage, ret);
> > > +}
> > > +
> > >  static int rtl821x_probe(struct phy_device *phydev)
> > >  {
> > >  	struct device *dev = &phydev->mdio.dev;
> > > @@ -607,7 +624,9 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
> > > 
> > >  static int rtl8211e_config_init(struct phy_device *phydev)
> > >  {
> > > -	int ret = 0, oldpage;
> > > +	const u16 delay_mask = RTL8211E_CTRL_DELAY |
> > > +			       RTL8211E_TX_DELAY |
> > > +			       RTL8211E_RX_DELAY;
> > >  	u16 val;
> > > 
> > >  	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
> > > @@ -637,20 +656,7 @@ static int rtl8211e_config_init(struct phy_device *phydev)
> > >  	 * 12 = RX Delay, 11 = TX Delay
> > >  	 * 10:0 = Test && debug settings reserved by realtek
> > >  	 */
> > > -	oldpage = phy_select_page(phydev, 0x7);
> > > -	if (oldpage < 0)
> > > -		goto err_restore_page;
> > > -
> > > -	ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0xa4);
> > > -	if (ret)
> > > -		goto err_restore_page;
> > > -
> > > -	ret = __phy_modify(phydev, 0x1c, RTL8211E_CTRL_DELAY
> > > -			   | RTL8211E_TX_DELAY | RTL8211E_RX_DELAY,
> > > -			   val);
> > > -
> > > -err_restore_page:
> > > -	return phy_restore_page(phydev, oldpage, ret);
> > > +	return rtl8211e_modify_ext_page(phydev, 0xa4, 0x1c, delay_mask, val);
> > >  }
> > 
> > Seems good to add RTL8211E_SET_EXT_PAGE to remove a constant from
> > the code. Any reason to avoid adding constants for 0xa4 and 0x1c ?
> 
> My copy of the datasheet does not document this register, so I did not
> feel qualified to come up with a meaningful name.

Is the page documented?

As for the register, it appears to contain RGMII delay configuration,
so why not call it RTL8211E_RGMII_DELAY ?

Sometimes you just have to make names up. If somebody has a datasheet
which lists it and wants to rename it, they can.

   Andrew


