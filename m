Return-Path: <netdev+bounces-196466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C14ADAD4E9C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0F31886249
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C323E25B;
	Wed, 11 Jun 2025 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KLE3P8/3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8832356B3;
	Wed, 11 Jun 2025 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631169; cv=none; b=NvFp+04iiMYaxUyBH6gogu3Ks01gzwg7In/wkrIMxmcwwhan1vYZUSmEWyVNfte9zdPIGpKRgkYImOMbCuXrHYhUVQdLgOtTjz9E+LfMDl9mliGOfLcWezUggCWDHurRQNT97jKxQk8lzFVu121DKAQDZQRQeAqFeHUcbgdJaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631169; c=relaxed/simple;
	bh=eP94DKa1bGgh8+jsHYYEwHFsK16PrWPSAXehlu4LTTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJA9tQWvHzwe5v6El3ZIqcvP0y8Te7HRJXMrxqU3IGdOjD+jmrN7gavgCwPVc88JQZsJ4ASbdjHdy8n7AGFC4ZkE+LLzgpJis1gVR3CL/TXr025wiimv22jQ/3+40yBUAz+whtq8qnhQlDzN7JRWvEObSnEaYHQNMJMoHuYsHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KLE3P8/3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PksZhMl9JN4rPrIRu6s9JViPUrN3CPq4Uz9I+7xLHjQ=; b=KLE3P8/3OR/Go6Ck/x5tQyoe7i
	b3qmYLjwwrb/PeJ2gvOWPC/AKpjqzCTFWzfMXrUUkSbMSDUgDMdSHWM5eMA16ld8ud5dxGHLCdf+Z
	3PHQnit14ofoMsZja+uNXU3DevYTidgnXTNeRjATBqcam9CYpoyBLkXsQHDv4Y1skXXEeP4Rg1LVH
	JzJ1Ob6f/Ky8rxerGZlkLGdK+qBkCACHUacIXmlgJkh1/jBhuM8edHqGlQDBH8z89Spy5kNqNiKGV
	u3qtJ0ieX8kze6aeHdd0MbKnkWrYZGZJKpQX79z5UPYmewQRHbWWZ23PMNshrAKttNn9j4Lh0zYRV
	AXcYk7GQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57842)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uPGzJ-0005rz-0t;
	Wed, 11 Jun 2025 09:39:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uPGzE-00085W-2w;
	Wed, 11 Jun 2025 09:39:08 +0100
Date: Wed, 11 Jun 2025 09:39:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
Message-ID: <aElArNHIwm1--GUn@shell.armlinux.org.uk>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
 <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
 <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
 <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
 <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>
 <ba7b290d-0cd1-4809-822a-bfe902684d7e@lunn.ch>
 <9ebe16a8d33e00c39c142748a1ea6fff96b9565a.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ebe16a8d33e00c39c142748a1ea6fff96b9565a.camel@icenowy.me>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 11, 2025 at 04:03:11PM +0800, Icenowy Zheng wrote:
> 在 2025-06-05星期四的 15:48 +0200，Andrew Lunn写道：
> > Which is theoretically fine. I've not looked at this driver in
> > particular, but there are some MACs were you cannot disable the
> > delay.
> > The MAC always imposes 2ns delay. That would mean a PCB which also
> > has
> > extra long clock lines is simply FUBAR, cannot work, and 'rgmii' is
> > invalid, so reject it.
> 
> BTW I found that in some case the assumption of PHY-side delay being
> always better than MAC-side one is wrong -- modern MACs usually have
> adjustable delay line, but Realtek 8211-series PHYs have only on/off
> delay with a fixed 2ns value.

The only time that MACs may implement delays based on the
PHY_INTERFACE_MODE_RGMII* is if they also include code to pass
PHY_INTERFACE_MODE_RGMII (no suffixes) to phylink / phylib to ensure
that the PHY doesn't _also_ add delays. This isn't something we
encourage because it's more code, more review, and a different way
of implementing it - thus adding to maintainers workloads that are
already high enough.

> > Just for a minute, consider your interpretation of the old text is
> > wrong. Read the old text again and again, and see if you can find an
> > interpretation which is the same as the new text. If you do:
> > 
> > * It proves our point that describing what this means is hard, and
> >   developers will get it wrong.
> > 
> > * There is an interpretation of both the old and new where nothing
> >   changed.
> > 
> > * You have to be careful looking at drivers, because some percent of
> >   developers also interpreted it wrongly, and have broken
> >   implementations as a result.  You cannot say the binding means X,
> >   not Y, because there is a driver using meaning X.
> > 
> > My hope with the new text is that it focuses on hardware, which is
> > what DT is about. You can look at the schematic, see if there is
> > extra
> > long clock lines or not, and then decided on 'rgmii-id' if there are
> > not, and 'rgmii' is there are. The rest then follows from that.
> 
> Well I think "rgmii-*" shouldn't exist at all, if focusing on hardware.
> I prefer only "rgmii" with properties describing the delay numbers.

Yes, I think we as phylib maintainers have also come to the same
conclusion with all the hassle this causes, but we can't get rid
of this without breaking the kernel and breaking device-tree
compatibility. So, we're stuck with it.

> > You are not reading it carefully enough. The binding describes
> > hardware, the board. phy.rst describes the phylib interface. They are
> > different.
> 
> Well I can't find the reason of phy-mode being so designed except for
> leaky abstraction from phylib.

I have no idea what that sentence means, sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

