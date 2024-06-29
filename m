Return-Path: <netdev+bounces-107879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8AA91CBD7
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 11:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9F91C2121A
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3F038DD1;
	Sat, 29 Jun 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw3PYbzN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A017208B0;
	Sat, 29 Jun 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719652567; cv=none; b=J6iqclD2tqRbR2fPBi7FnODEN9fO2sVctKdUUAqjhgSppmerlq6REXoGlpHxh2BfNunsx2spZrJr+dFAx9GVyW9kd/01zZxxazsKjjcmSYhQ+Ra+ev9juH+mZ4QgNFy6wy3SPcX97t00VVOodM2unjlfPhGV8Z/be+XoiWCq37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719652567; c=relaxed/simple;
	bh=1CNjP73ry8cY70hB93727FwLvKQuKgEDilX8HeyNIS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvwXoNlA2ucc4qmDOy7PhixeBPuLXJRSk8L39FnohF5mjMRR9MeDhdVR8gPhCi3NxDHcXlhtwFN/TbMwNp4izJHTtr/FGpFOsIMmU27tOHuahRvR/NiJNq50s4it+lcWKCvlqdIeHnDg9pbX7Wdp6sA1YLvC/HdNj2J8MR5g/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pw3PYbzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58BFC2BBFC;
	Sat, 29 Jun 2024 09:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719652567;
	bh=1CNjP73ry8cY70hB93727FwLvKQuKgEDilX8HeyNIS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pw3PYbzN4tbTTU5JwIMg7eqRBo6uEwa/HOk4g81tqa4h95BTEtv4JNxrHT3HXMqHQ
	 6GFN9VoBYQocs+UFopOonVAPOjL5eCs+HQWJs+C41ASODv1EtSvmFHydAfsx4WKk8S
	 VLgf2gAPjXRGd/4EMynLWBUUOK4tQtK0TqLeut+fHeuNtB8r3ly/+68wnHDkcqUPBo
	 XwfASXmg/su3W0+9nK1QJvDe9flLImqutXozY4RUBzPXGzRSoUPKF3XWuU98gz64T0
	 H2Cgp7PgPJP8g66f5UDUboPG6BfIRBJU/8ShLW2xEImu3kBgwoI1YATMVN24rhx3tI
	 WrTwUHUuq7bFQ==
Date: Sat, 29 Jun 2024 10:16:02 +0100
From: Simon Horman <horms@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH v2] net: phy: realtek: Add support for PHY LEDs
 on RTL8211F
Message-ID: <20240629091602.GJ837606@kernel.org>
References: <20240625204221.265139-1-marex@denx.de>
 <20240628142742.GH783093@kernel.org>
 <a7f614cd-fe39-4746-8a83-2a2d14fc46f4@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f614cd-fe39-4746-8a83-2a2d14fc46f4@denx.de>

On Fri, Jun 28, 2024 at 08:58:51PM +0200, Marek Vasut wrote:
> On 6/28/24 4:27 PM, Simon Horman wrote:
> > On Tue, Jun 25, 2024 at 10:42:17PM +0200, Marek Vasut wrote:
> > > Realtek RTL8211F Ethernet PHY supports 3 LED pins which are used to
> > > indicate link status and activity. Add minimal LED controller driver
> > > supporting the most common uses with the 'netdev' trigger.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > ---
> > > Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > > Cc: Andrew Lunn <andrew@lunn.ch>
> > > Cc: Christophe Roullier <christophe.roullier@foss.st.com>
> > > Cc: David S. Miller <davem@davemloft.net>
> > > Cc: Eric Dumazet <edumazet@google.com>
> > > Cc: Heiner Kallweit <hkallweit1@gmail.com>
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Cc: Paolo Abeni <pabeni@redhat.com>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: kernel@dh-electronics.com
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: netdev@vger.kernel.org
> > > ---
> > > V2: - RX and TX are not differentiated, either both are set or not set,
> > >        filter this in rtl8211f_led_hw_is_supported()
> > > ---
> > >   drivers/net/phy/realtek.c | 106 ++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 106 insertions(+)
> > > 
> > > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > > index 2174893c974f3..bed839237fb55 100644
> > > --- a/drivers/net/phy/realtek.c
> > > +++ b/drivers/net/phy/realtek.c
> > > @@ -32,6 +32,15 @@
> > >   #define RTL8211F_PHYCR2				0x19
> > >   #define RTL8211F_INSR				0x1d
> > > +#define RTL8211F_LEDCR				0x10
> > > +#define RTL8211F_LEDCR_MODE			BIT(15)
> > > +#define RTL8211F_LEDCR_ACT_TXRX			BIT(4)
> > > +#define RTL8211F_LEDCR_LINK_1000		BIT(3)
> > > +#define RTL8211F_LEDCR_LINK_100			BIT(1)
> > > +#define RTL8211F_LEDCR_LINK_10			BIT(0)
> > > +#define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
> > > +#define RTL8211F_LEDCR_SHIFT			5
> > > +
> > 
> > Hi Marek,
> > 
> > FWIIW, I think that if you use FIELD_PREP and FIELD_GET then
> > RTL8211F_LEDCR_SHIFT can be removed.
> 
> FIELD_PREP/FIELD_GET only works for constant mask, in this case the mask is
> not constant but shifted by SHIFT*index .
> 
> Other drivers introduce workarounds like this for exactly this issue:
> 
> drivers/clk/at91/pmc.h:#define field_prep(_mask, _val) (((_val) <<
> (ffs(_mask) - 1)) & (_mask))
> 
> I don't think it is worth perpetuating that.

Thanks Marek,

Sorry for missing that the mask is not constant.
And in that case I agree with the approach you have taken in this patch.

