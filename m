Return-Path: <netdev+bounces-180201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 079FDA805C9
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8CB7AE7BA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942D72673B7;
	Tue,  8 Apr 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PWhd/3lX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52514269CF7;
	Tue,  8 Apr 2025 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114653; cv=none; b=WP+rWRHCs/iwJ4S7nhfwuSL7g1TJ8ewh5HuUqDj1xGsIoxOanHYo9gK9HHjrkRV0Mo2ihUqhtkC/vxecvZOIEDsCVzuo7itoJwkXHNq/ng/SVqDVmvxU3YxcsurKziXqXoEIzIWFGcy+eVMMPllzyLFJOC8j7uoNgNa22+43ybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114653; c=relaxed/simple;
	bh=7MIQ9HHSB2bH2AFr+0VI1B0l0NJu73hsXo5dH0HrwKI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUYN/Zu6xB0mLgZkxqchzN3Pw4fmwxi6f4KhIT+f5VpbUuo36jcnZjvigWIAU9wg2QXPKjuTAU3oUTbyGkI2f+B4FboU/3F7dP3O24TuMZcqH69et/VTbEEZAh+w0SHMGmUfZ2ZVHiwP+J/BKdtVkLHLZFKEay5IeGe38nggH7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PWhd/3lX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kV+poe5wqojrBL+yWUAaYGMQtjRzHk+4Yf5T5cMCjWE=; b=PWhd/3lXU32H5fKoyfO3jNBLZr
	PqLirgjLch0awcFc0ZGkz6HGrU/fgiC5+4TAeDV7bJUdpypw4f0100ekTCGWQ4IZNsBa6b1uwfmT1
	S+AyorDOa9VhA5dessSUieUKMPeNyZW71j/oQqmJ4de7++9njBXAGlkEKxf+9e2Lj5Jc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u27tH-008NtL-Ru; Tue, 08 Apr 2025 14:17:19 +0200
Date: Tue, 8 Apr 2025 14:17:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joe Damato <jdamato@fastly.com>, Michael Klein <michael@fossekall.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND net-next v5 1/4] net: phy: realtek: Group RTL82* macro
 definitions
Message-ID: <96fcff68-6a96-49fe-b771-629d3bef03ea@lunn.ch>
References: <20250407182155.14925-1-michael@fossekall.de>
 <20250407182155.14925-2-michael@fossekall.de>
 <Z_SPgqil9HFyU7Y6@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_SPgqil9HFyU7Y6@LQ3V64L9R2>

On Mon, Apr 07, 2025 at 07:52:50PM -0700, Joe Damato wrote:
> On Mon, Apr 07, 2025 at 08:21:40PM +0200, Michael Klein wrote:
> > Group macro definitions by chip number in lexicographic order.
> > 
> > Signed-off-by: Michael Klein <michael@fossekall.de>
> > ---
> >  drivers/net/phy/realtek/realtek_main.c | 30 +++++++++++++-------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> > index 893c82479671..b27c0f995e56 100644
> > --- a/drivers/net/phy/realtek/realtek_main.c
> > +++ b/drivers/net/phy/realtek/realtek_main.c
> > @@ -17,6 +17,15 @@
> >  
> >  #include "realtek.h"
> >  
> > +#define RTL8201F_ISR				0x1e
> > +#define RTL8201F_ISR_ANERR			BIT(15)
> > +#define RTL8201F_ISR_DUPLEX			BIT(13)
> > +#define RTL8201F_ISR_LINK			BIT(11)
> > +#define RTL8201F_ISR_MASK			(RTL8201F_ISR_ANERR | \
> > +						 RTL8201F_ISR_DUPLEX | \
> > +						 RTL8201F_ISR_LINK)
> > +#define RTL8201F_IER				0x13
> 
> If sorting lexicographically, wouldn't RTL8201F_IER come before
> RTL8201F_ISR ?

The change log says "chip_number" lexicographic order. RTL8201F is the
chip number, ISR is the register name.

You would normally sub sort register number, so i would of put
IER=0x13 before ISR=0x1e, within RTL8201F.

> 
> >  #define RTL821x_PHYSR				0x11
> >  #define RTL821x_PHYSR_DUPLEX			BIT(13)
> >  #define RTL821x_PHYSR_SPEED			GENMASK(15, 14)
> > @@ -31,6 +40,10 @@
> >  #define RTL821x_EXT_PAGE_SELECT			0x1e
> >  #define RTL821x_PAGE_SELECT			0x1f
> >  
> > +#define RTL8211E_CTRL_DELAY			BIT(13)
> > +#define RTL8211E_TX_DELAY			BIT(12)
> > +#define RTL8211E_RX_DELAY			BIT(11)
> 
> Maybe I'm reading this wrong but these don't seem sorted
> lexicographically ?

This i don't follow, you normally keep register bits next to the
register. This is particularly important when the register bits don't
have the register name embedded within it.

    Andrew

---
pw-bot: cr

