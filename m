Return-Path: <netdev+bounces-205896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 388A1B00B7B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2811C85F87
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C502FCE07;
	Thu, 10 Jul 2025 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RKBKX9Vq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FB27145D
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172534; cv=none; b=doagVrb3Qs6FX/bXFdHfU+uCLehrFz47AvxWN1lyynGG2bp7MmKHYAGiu6Y82zejHJD1W7iDAV5CMRYzjJrYIkxxPEh/nfHPu4kh9Ew4uSQp/jBtkyQnauasofcDaK8ozwBP5mRhzK++s4pONP7vaZcyiiLDFdg5bKyEJ+ymQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172534; c=relaxed/simple;
	bh=pH7aKDfHuwDPJu1Oi1RhQC/3f4zNFI7iKK97pQk6ayI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA9wpSoYsQQo7vzbKV2LLVnqrLlvRc86WSMrsDtQ0WC1NlY1k3ZOXWpzJN/JwLpZLcNWYru6temSm34DhkAo6CdeiH4uc8PBL0ZbxflcmA3WY6aAbB+goi23fNk1HKN+cXo7wC3zqVmy18D6Q8KZxxoNpjRNXqei6jxRtPrLheQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RKBKX9Vq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=82DTVPzCmslYsYBzEi/DNrIGykVn992BD4R5Z+9ByL4=; b=RKBKX9VqcNw5AqzXDOO0ImMNMp
	jgPYVA7zjhha49tBD9s609A21Bo/0OMzylUSRGg4Fhgai53Ghr8PJUZIsfacuGZl1f3gitl7ViBW/
	qxDUZROUIRHtL0eEvbR/KZm+3AoUXEOXzuN2tYzMibIcUdYKg4tME3L/Hn6YxndNkvEMpp9DHnFHQ
	50VPbvWRo4erUAP0KaD/I8AI5JUxGUh0/YT5gRlAxMifRv+yE4ZkHgW/sKQeSaTfn9LA70WNPlTHv
	vyOUU5ab/bZfXD8XLXrH6FpnM9SPA1bw7B9vkmjlX440TbgIDAYaXWMv7f4D1dGhdpCcZ50Crj34g
	EMsJT1UA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43926)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uZw79-0001T6-1O;
	Thu, 10 Jul 2025 19:35:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uZw75-0003qL-1P;
	Thu, 10 Jul 2025 19:35:19 +0100
Date: Thu, 10 Jul 2025 19:35:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: add
 phylink_sfp_select_interface_speed()
Message-ID: <aHAH53ZEE3snK4IE@shell.armlinux.org.uk>
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
 <E1uWu14-005KXo-IO@rmk-PC.armlinux.org.uk>
 <20250702151426.0d25a4ac@fedora.home>
 <aGU2C3ipj8UmKHq_@shell.armlinux.org.uk>
 <CAKgT0UcWGH14B0zZnpHeJKw+5VU96LHFR1vR4CXVjqM10iBJSg@mail.gmail.com>
 <aGWF5Wee3vfoFtMj@shell.armlinux.org.uk>
 <CAKgT0UdVW6_hewR7zNzMd_h7b_Lm_SHdt72yVhc7cLHcfFxuYQ@mail.gmail.com>
 <14b442ad-c0ab-4276-8491-c692f0b7c5c9@lunn.ch>
 <CAKgT0UfXRsVEgvJScapiXNWyqB8Yd07t5dgrKX82MRup78tXrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UfXRsVEgvJScapiXNWyqB8Yd07t5dgrKX82MRup78tXrw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 10, 2025 at 10:22:44AM -0700, Alexander Duyck wrote:
> On Thu, Jul 10, 2025 at 9:11 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > What is wrong, that it is reporting LP information, or that it is
> > reporting it does not support autoneg when in fact it is actually
> > doing autoneg?
> 
> I have some debug code on here that is reporting the FW config as the
> "LP Advertised". I had borrowed that approach from the phylink
> fixedlink config as I thought it was a good way for me to know what
> the FW was requesting without having to report it out to a log file.

There are a few points to be made here.

1. Fixed link configuration is not the same as !autoneg setting with
   the presence of a PHY. !autoneg with a PHY present means that the
   PHY has been instructed not to perform autonegotiation, but to set
   the specified parameters for the link and only allow the link to
   operate at the specified speed/duplex. There are exceptions - as
   users expect 1G to work with "autoneg" disabled, and 1G requires
   AN in order to bring the link up. Some PHYs support disabling the
   autoneg function at 1G speed by internally ignoring the request
   to disable autoneg, and instead only advertising to the link
   partner that 1G at the specified duplex is supported. We took
   that and turned it into a software thing for all PHYs as some
   PHYs decided to go a different route - basically not supporting
   the AN enable bit being turned off at 1G speeds.

2. Fixed link configuration is a software concept where there is no
   accessible PHY present. Phylink rejects fixed link configuration
   with a PHY. There is no support to configure a PHY into fixed
   speed/duplex if present, and has never been supported prior to
   phylink.

3. The history. Prior to phylink (and it remains in some cases today),
   fixed link configuration was created by providing a software
   emulated PHY to phylib for the MAC driver to use, thus avoiding
   MAC drivers having to add explicit code for fixed links. They
   looked just like a normal PHY, but was limited to no faster than
   1G speeds as the software emulation is a Clause 22 PHY.

   This software emulated PHY replaces the presence of a physical
   PHY (there is none) and the PHY it emulates looks like a PHY that
   supports AN, has AN enabled, but only supports a single speed
   and duplex, only advertises a single baseT(x) speed and duplex,
   and the link partner agrees on the speed and duplex. This "fools
   phylib into resolving the speed and duplex as per the fixed link
   configuration.

   However, in reality, there is no AN.

   This has become part of the user API, because the MII registers of
   the fixed link PHY were exported to userspace, and of course through
   ethtool.

   There has never been a MII API for reading the fixed link parameters
   for speeds > 1G, so while phylink enables fixed link configuration
   for those speeds, there is no MII register support for this for
   userspace.

(As an aside)
Someone earlier today sent a reminder about a bug I'd introduced for
10GBASE-R, 5GBASE-R and another interface (I don't recall right now)
and I proposed a patch that only cleared the Autoneg bit in the
adertising mask. Having been reminded about it, and had Andrew's
input on this thread, I'm wondering whether config.advertising
should be entirely cleared as in !autoneg mode, the advertising mask
makes no sense.

However, I'm supposed to be on my vacation, so I'm not going to start
testing anything... this email as a bonus that would've otherwise have
been delayed by about two weeks... but the way things are going (family
issues) it could turn out to be a lot longer as I may have to become a
full time carer. So much for an opportunity to have an opportunity to
relax, which I desperately need.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

