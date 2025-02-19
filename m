Return-Path: <netdev+bounces-167744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1CA3C00F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E646188BC4D
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6B31E0DFE;
	Wed, 19 Feb 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OboORU5z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665691D90A5
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972166; cv=none; b=Q4fkmvmz27n0xQQztQ779szMv5QuHQIvAensZvGqRQRg0ZH2aJdD2Rp+sbUoazfQoelKXCE6Uz+3pyYHvzZIQvrzaJMyDnpN90O0ucd6eerbmvqdbVpM5OM90xOLCsWGVuQPXuHOjdoumBtWF8qqXK7Gz885pthLzWLgN86++EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972166; c=relaxed/simple;
	bh=vMeSW1zvRepqzCiNEFCGVnhpQI0xBPH9NM90uBz6wYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elsKRaA3iki7ifULtDrbxLW4LEV4UTYZBct98tFPkK7TdbBZ0Yp/VMp2KWEsbhK9qO3g0BtCXHdPdR9R0Ic7ZJFRT+8D0w2Iqxyzw2A4dYJCGCrTzjwmEy0+WrQpa7pUare6vWuyd8Ax+jqOqFG1RZPgsJbp1ckwA5ir3jOnshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OboORU5z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5RKXL7Pr+B0O9seaerq9LcKhvhCxKtfn2XfpbvP95Q8=; b=OboORU5zk7+Pa+nHwzajTMX0mp
	W2SORrqhipef9dQU19UTt4jY8nKvz/mW86dB1pnQdGMI6iuN8OWU6zM9dy14KKdheT6JBqhr4uPpe
	sPVVp529i+BTqTmiwlCa9Js70pYhcDfLoR4Msd3Ct+boTNlSdPp1Pm5wGWP1IQDX2NXQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkkF3-00FdoT-90; Wed, 19 Feb 2025 14:35:57 +0100
Date: Wed, 19 Feb 2025 14:35:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: add phylib-internal.h
Message-ID: <4b2ebf2e-28b3-4b6a-9772-e5495c18b1d6@lunn.ch>
References: <290db2fb-01f3-46af-8612-26d30b98d8b3@gmail.com>
 <8f7cf3ac-14f4-4120-a8ed-01b83737e6b8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f7cf3ac-14f4-4120-a8ed-01b83737e6b8@gmail.com>

On Wed, Feb 19, 2025 at 07:37:52AM +0100, Heiner Kallweit wrote:
> On 18.02.2025 23:43, Heiner Kallweit wrote:
> > This patch is a starting point for moving phylib-internal
> > declarations to a private header file.
> > 
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> >  drivers/net/phy/phy-c45.c          |  1 +
> >  drivers/net/phy/phy-core.c         |  3 ++-
> >  drivers/net/phy/phy.c              |  2 ++
> >  drivers/net/phy/phy_device.c       |  2 ++
> >  drivers/net/phy/phy_led_triggers.c |  2 ++
> >  drivers/net/phy/phylib-internal.h  | 25 +++++++++++++++++++++++++
> >  include/linux/phy.h                | 13 -------------
> >  7 files changed, 34 insertions(+), 14 deletions(-)
> >  create mode 100644 drivers/net/phy/phylib-internal.h

Maybe we should discuss a little where we are going with this...

I like the idea, we want to limit the scope of some functions so they
don't get abused. MAC drivers are the main abusers here, they should
have a small set of methods they can use.

If you look at some other subsystems they have a header for consumers,
and a header for providers. include/linux/gpio/{consumer|driver}.h,
clk-provider.h and clk.h, etc.

Do we want include/linux/phy.h to contain the upper API for phylib,
which MAC drivers can use? Should phylib-internal.h be just the
internal API between parts of the core? There will be another header
which has everything a PHY driver needs for the lower interface of
phylib?

Is this what you are thinking?

	Andrew

