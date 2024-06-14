Return-Path: <netdev+bounces-103699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEBB909227
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5B21C2214A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6B14659F;
	Fri, 14 Jun 2024 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FdNCTGQE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEBD1854;
	Fri, 14 Jun 2024 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389012; cv=none; b=XIP8BA+m+f2DS/WP5GO+wgrthlYyF5R6EC8k4XwI5D4Iyb1l38k0PpvGyylAx36ESxsOuC43guU51+EhbHihf2Pi4Kai6LEDLM/PmkuoQNGDONhlmrT3ogU5jVzUul7MDtSWfPZiCodegUeLq7+3NlkoeRPdY8TVddbCeczwXM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389012; c=relaxed/simple;
	bh=JkDujCY71x7ysttBitt69fHWEEaGlbrnQylnP6rlZPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWsEuzPEm7I+0NsGU/W/56koWWVDVgdA16NdMeYGWwSGMdp//9QkvvCN+Ow5Ccuc4urMl6Op0c/vIZlwj+cfwGFHXwexLEW6VURM1yFGbC1hSBXNRQmfnxhKlbfIBbQH3/RUQ7D1bAtvug9RXJOPFASW5GbWa5ymULiTbtBSxxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FdNCTGQE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=6/9r/NEdMohFee33dMVvNr76HDxRwxYVUB3+5R4hQZU=; b=Fd
	NCTGQEZnJbGJubZmNxMemPpWIuVpQgqAz2qtR7RAJAlPI2dDKhfbZVlfHyFB6pSx+QbPXJl+H1w7a
	q4OAHx07XXi25pf9xVq+Glu7iyJiw/KEHg72OtH7pVE9AC7LXwkCqzn1yz+6Bl2Y8FpOCL9aA0q5u
	7Thb291WGulLEH0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sIBTU-0005Ml-Dm; Fri, 14 Jun 2024 20:16:32 +0200
Date: Fri, 14 Jun 2024 20:16:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Jo=E3o?= Rodrigues <jrodrigues@ubimet.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: phy: dp83867: add cable test support
Message-ID: <21b38798-46e2-4a26-bf8c-554524fdcdc4@lunn.ch>
References: <20240613145153.2345826-1-jrodrigues@ubimet.com>
 <20240613145153.2345826-3-jrodrigues@ubimet.com>
 <d2e2232e-7519-4d62-b2be-265058350e08@lunn.ch>
 <20240614185210.3a53be61@pcn112>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614185210.3a53be61@pcn112>

On Fri, Jun 14, 2024 at 06:52:10PM +0200, João Rodrigues wrote:
> On Thu, 13 Jun 2024 19:19:45 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +/* TDR bits */
> > > +#define DP83867_TDR_GEN_CFG5_FLAGS	0x294A
> > > +#define DP83867_TDR_GEN_CFG6_FLAGS	0x0A9B  
> > 
> > Is it documented what these bits actually mean?
> > 
> >    Andrew
> 
> No, all three (CFG5, CFG6 and CFG7) are undocumented.

Then i would suggest you use the magic values directly.  The only
advantage i see with DP83867_TDR_GEN_CFG5_FLAGS is that is stops you
accidentally using it with CFG4, etc. But magic is magic, and you
should not really hide it.

       Andrew

