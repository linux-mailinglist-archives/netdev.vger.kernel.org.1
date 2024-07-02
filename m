Return-Path: <netdev+bounces-108407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647DB923B27
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD143283AFC
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76C214F9D1;
	Tue,  2 Jul 2024 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="v12porom"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C2374F5;
	Tue,  2 Jul 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915337; cv=none; b=Fx7YFYLkojaGOr3w2aYdTtcTozgJYKVRtBgXL2LEKeq2SQyiEFJRqU1twefYS5iGLYjOILfBY5Ae9QIqN8BsupgNjMJ1nnnydNYDOsyS9cOCeEBSMD79+re71i/PDyJCHTjlHhvqPy1UuI/MjjV8rxBOXOWDW4FSxvBTKhyOO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915337; c=relaxed/simple;
	bh=0zbOiOzWTEDtxycxNU5fkEBa+pCqvyOmxAilew1VkjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJoMOBdaHn3zQ/GYrnqr8d1OwnXLzwbftZTPMR2uVMNf7QOPZi9KXvapj34IblW+N3AkmsQ894+0X+bM1YtYkNI0Ckq5OYArBcLiGCBr2ijt06THp4NsaW9WZPrCQvMzx8Y0SdvoInNz7j5GJFW99dEa2owJSy9HkfPpacY14S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=v12porom; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KSgvP1Di8b6uqIyo89tU+EzKugA+qtNmAa5rkGbhT9g=; b=v12poromr+fZkYrQd7dCNRZns4
	kQPR9eJZzqollNvXRmLQcfb/Jt0FJkDN0CL8IrsAinIZw1xU0Kkt1kCajt6gwlIl7tQcEDpvYA75S
	k051OxYAUvzuQ+Ie3sZBCm/Dg6BCewXqhbnY9wDXDlcUjaC//M0znsKe9Yvv7Z0SS7HN9bi4F5o5u
	pkIerq2hdEsG/M/EB/Nenig3NUOOuCUTtw4C8mXV8bC8tSXp7jHrWamDAnV045LWowBqUgCxQ/FBw
	bCbtMUqqoowMXm9VrSqtrrh2AePURjzbCAZ2CWoN++LCfTkqaxWx109/U4NphifKRFi3YFW4l3fR9
	AI/jgJ+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46258)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sOaXi-0003B4-2S;
	Tue, 02 Jul 2024 11:15:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sOaXk-0001rb-7y; Tue, 02 Jul 2024 11:15:24 +0100
Date: Tue, 2 Jul 2024 11:15:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] net: phy: dp83869: Disable autonegotiation
 in RGMII/1000Base-X mode
Message-ID: <ZoPTPH3YQYMMe4YZ@shell.armlinux.org.uk>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <3818335.kQq0lBPeGt@fw-rgant>
 <ZoPHQms2bDo5zWZm@shell.armlinux.org.uk>
 <2614671.Lt9SDvczpP@fw-rgant>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2614671.Lt9SDvczpP@fw-rgant>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 02, 2024 at 11:42:04AM +0200, Romain Gantois wrote:
> Hello Russell,
> 
> This seems to be a limitation of this particular PHY. From the DP83869
> datasheet:
> 
> "7.4.2.1 1000BASE-X
> The DP83869HM supports the 1000Base-X Fiber Ethernet protocol as
> defined in IEEE 802.3 standard. In 1000M Fiber mode, the PHY will use
> two differential channels for communication. In fiber mode, the speed is not
> decided through auto-negotiation. Both sides of the link must be
> configured to the same operating speed. The PHY can be configured to
> operate in 1000BASE-X through the register settings (Section 7.4.8) or
> strap settings (Section 7.5.1.2)."

I think you grossly misunderstand 1000base-X there. You seem to be
equating auto-negotiation with negotiation of speed. That isn't
necessarily the case.

Clause 37 auto-negotiation doesn't negotiate speed. It negotiates
other aspects of the link. See 37.2.1:

LSB                                                                      MSB

 D0     D1    D2   D3   D4    D5   D6   D7   D8   D9 D10 D11 D12 D13 D14 D15
rsvd rsvd rsvd rsvd rsvd      FD   HD PS1 PS2 rsvd rsvd rsvd RF1 RF2 Ack NP

FD/HD - full duplex/half duplex capability
PS1/PS2 - pause capabilties
RF1/RF2 - remote fault bits
Ack - Ack bit
NP - Next Page bit

So, just because the PHY documentation states that speed is not
negotiated, that doesn't mean that negotiation is not supported.
IEEE 802.3 *requires* AN be implemented.

Moreover, the clue is in the name - 1000base-X. The 1000 part. That
means it's a protocol operating at 1G speed, just the same as 1000base-T
which only operates at 1G speed.

BTW, with twisted pair, negotiation does include speed, and the result
of that is used to select between 1000base-T for 1G speeds, 100base-Tx
for 100M, and 10base-T for 10M - these each are separate protocols.
There is no 1000base-T operating at 100M or 10M speeds - that just
doesn't exist.

Hope this clears up the issue.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

