Return-Path: <netdev+bounces-203354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7708AF597D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064E016C3E9
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ACF277035;
	Wed,  2 Jul 2025 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="di6iKVFj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64319272E7F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463449; cv=none; b=K3Gjf7kFfKGTluQ216NxbEewV4l33WhRVqjxbHsoOKo1M403F9HJMSei1FIRpg1jZb4tipBymoXUFlPcdbm8OVNPOMDCw7LpJsRklYSFbfzuoWu/bel8cZ0Z72Sik+iXj4xzPkX6BWs1URsJg6EygsuBTR/5GDfr3Tr1ZPlShnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463449; c=relaxed/simple;
	bh=owZJos2mwV7e+UnLZ4FZ+V0LgpU047OWxYg21pCI1C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO/hqlp0LZzjRWCU0Z90AsIIZn7oIEJ082EL3nwq3XQHnBzXV5CxH6fQh/3+4F0lw7tfyz5JpJE+jBqGJ4MpmWadkW37sZmSMooydLo1WwE2h1b6ohA+KL3a8mD7ZpTXc/+I9jphjtPhpYJpw6rWVq7HbdgrAVz9BG5DqtMKWBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=di6iKVFj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1MdNvFa3e3MRKhSXN0JKs1vG8PKNJE2NVVy7wxWrKJc=; b=di6iKVFj3d19R1lIL6rEmPKzGi
	YL07OGMeWemsRValmsR4/JV9jfh+0sfF0hgwlMW2NE1NP7cBILZwRVGNQth+IrEm+9i4bjeO4xIE9
	F2aF6Wf1np8i9sQjGKTSJbSjZto3em+rljZL2aMb3rkn2OME++ZrkdESiEZ1itvad7N/K4ba9BtcL
	+o7MWwtDWFd+6L0pmLTrclX6AQiOBMGVvE1qg4CWHY9ap9eqSOC3pAXqYxg+EsMfslLowU5aIy30Z
	4P6lWrdibiVt27GepsQSg8RM7ueeIY01vtNUf6sXVNvlOgC4I/R3IcVuVbK/HvN1jRboy3bOuGKC0
	EjnFO4UA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53314)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uWxeJ-0007ih-24;
	Wed, 02 Jul 2025 14:37:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uWxeG-00047n-0A;
	Wed, 02 Jul 2025 14:37:16 +0100
Date: Wed, 2 Jul 2025 14:37:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: add
 phylink_sfp_select_interface_speed()
Message-ID: <aGU2C3ipj8UmKHq_@shell.armlinux.org.uk>
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
 <E1uWu14-005KXo-IO@rmk-PC.armlinux.org.uk>
 <20250702151426.0d25a4ac@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702151426.0d25a4ac@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 02, 2025 at 03:14:26PM +0200, Maxime Chevallier wrote:
> On Wed, 02 Jul 2025 10:44:34 +0100
> "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> 
> > Add phylink_sfp_select_interface_speed() which attempts to select the
> > SFP interface based on the ethtool speed when autoneg is turned off.
> > This allows users to turn off autoneg for SFPs that support multiple
> > interface modes, and have an appropriate interface mode selected.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> I don't have any hardware to perform relevant tests on this :(

Me neither, I should've said. I'd like to see a t-b from
Alexander Duyck who originally had the problem before this is
merged.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

