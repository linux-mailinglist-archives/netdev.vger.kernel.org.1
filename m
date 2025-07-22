Return-Path: <netdev+bounces-209116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F140B0E603
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAF2189103D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 22:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137AF27F4D5;
	Tue, 22 Jul 2025 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="efkh5OYu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C22128395;
	Tue, 22 Jul 2025 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221655; cv=none; b=rz4Iv/+3S/2WlD8Ssd4CZvPm3+mQq0yJPQ+P41FKBe1xcpoIX+gUuqZ7DZyHiPY+KkNhKcmlxxtR2k182wtCkJ3zEllQvR2vkGTgHZgeLndASp59ocZ5kmNlrBNTClWQykPdXa07Fc4WefI7KakucNU+tY53VSmZKj0ZPIJ5Lj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221655; c=relaxed/simple;
	bh=D28me53HqI/b4OOy5Jg1frH4LmAnj0yC4yp5g60srig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+Gm4eLlH2yElVX05iOS3D3sW4/PyH/ToG+hm7cPf3KVU/mJS8EN7o0l0PDm3l/b/Fvj2i11QF+Hh2OBp8CaQ6ScMlDgwJimrhb7LUqZOH+awAPCzF4EDybMc8OS/HNNuh9x5LSKPgPZ5HDLvXDaXlH+f0v8Bx7hOyeTAvj/yUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=efkh5OYu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XSSmyEAVCfx6UoBN6/vyS4ypSsBayt+epb+whGNpxlc=; b=efkh5OYuxMntLpQJfhREDs00bT
	e31RvBopK3XWSjzCJceqzHhiBJnPqtcwtbFK2oBy1s+de/r7ALJUKHqz9WXbLx63YkB6KsGHefWJm
	bVpZBLUWfqTjXLGYD+9/yA6JkLuiDEHB3SC1+2EKu+hGz0nnQxP1d51EvqA0oztSftHu8f8AOUXY6
	Uh/2FYBf5MV7yTGyrYO4gHZrkZeLx8Ol7t4D5hCvcROVO2KkTqzCgOZJcAGkyqZoeh6yqbhEV3BMY
	oRfBIsyD+K7rDqe/zylRjiXU91hxTdGab+qPmrM/htdnJM+aafdw8LQLtBZ3+B02TzBlV0zgqVBdg
	xuuzHWUQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56144)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ueL2L-0000hK-0z;
	Tue, 22 Jul 2025 23:00:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ueL2I-0007UG-0n;
	Tue, 22 Jul 2025 23:00:34 +0100
Date: Tue, 22 Jul 2025 23:00:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
Message-ID: <aIAKAlkdB5S8UiYx@shell.armlinux.org.uk>
References: <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
 <383299bb-883c-43bf-a52a-64d7fda71064@foss.st.com>
 <2563a389-4e7c-4536-b956-476f98e24b37@lunn.ch>
 <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>
 <ae31d10f-45cf-47c8-a717-bb27ba9b7fbe@lunn.ch>
 <aIAFKcJApcl5r7tL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIAFKcJApcl5r7tL@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 22, 2025 at 10:39:53PM +0100, Russell King (Oracle) wrote:
> rtl8211f_get_wol() does not take account of whether the PMEB pin is
> wired or not. Thus, stmmac can't just forward the get_wol() and
> set_wol() ops to the PHY driver and let it decide, as suggested
> earlier. As stmmac gets used with multiple PHYs, (and hey, we can't
> tell what they are, because DT doesn't list what the PHY actually is!)
> we can't know how many other PHY drivers also have this problem.

I've just read a bit more of the RTL8211F datasheet, and looked at the
code, and I'm now wondering whether WoL has even been tested with
RTL8211F. What I'm about to state doesn't negate anything I've said
in my previous reply.


So, the RTL8211F doesn't have a separate PMEB pin. It has a pin that
is shared between "interrupt" and "PMEB".

Register 22, page 0xd40, bit 5 determines whether this pin is used for
PMEB (in which case it is pulsed on wake-up) or whether it is used as
an interrupt. It's one or the other function, but can't be both.

rtl8211f_set_wol() manipulates this bit depending on whether
WAKE_MAGIC is enabled or not.

The effect of this is...

If we're using PHY interrupts from the RTL8211F, and then userspace
configures magic packet WoL on the PHY, then we reconfigure the
interrupt pin to become a wakeup pin, disabling the interrupt
function - we no longer receive interrupts from the RTL8211F !!!!!!!

Yes, the driver does support interrupts for this device!

This is surely wrong because it will break phylib's ability to track
the link state as there will be no further interrupts _and_ phylib
won't be expecting to poll the PHY.

The really funny thing is that the PHY does have the ability to
raise an interrupt if a wakeup occurs through the interrupt pin
(when configured as such) via register 18, page 0xa42, bit 7...
but the driver doesn't touch that.


Jetson Xavier NX uses interrupts from this PHY. Forwarding an
ethtool .set_wol() op to the PHY driver which enables magic packet
will, as things stand, switch the interrupt pin to wake-up only
mode, preventing delivery of further link state change events to
phylib, breaking phylib.

Maybe there's a need for this behaviour with which-ever network
driver first used RTL8211F in the kernel. Maybe the set of network
drivers that use interrupts from the RTL8211F don't use WoL and
vice versa. If there's any network drivers that do forward WoL
calls to the RTL8211F driver _and_ use interrupts from the PHY...
that's just going to break if magic packet WoL is ever enabled at
the PHY.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

