Return-Path: <netdev+bounces-185600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82653A9B134
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067A23A95F2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA40015573A;
	Thu, 24 Apr 2025 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TFp7cV7X"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A461943AA1;
	Thu, 24 Apr 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505518; cv=none; b=tWy1aF4CXmd1etD2CuyehfPJpjLmCciteA3xRKAYuFGdPx9wFT7n30eKKudbuNeeT3Pza04jiZUjEKAiy9Aype5gyFhiJQALzo56WLEvwZBNviZb7f8/19yE2fQbz82P0TBPAIAwxpf9VZNOP/BpGR/inMjI3AeVk8ThthphJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505518; c=relaxed/simple;
	bh=0shyGyjWgRAR/8tg/n5qJjtkOYqa15lSbO+H7hie4Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/cacxJsnTTH8gmpcdIRh7M8Nd/d9BtmxI1p/PtML5m3IALTT7OPLREVH0UcM/I3KPOX9qWweeCBdR/qzj7GtBqp5MPn8P+e3TgoiOXZkzkJTVH/MrbfgXUUB62vn8Bo95o+nH5kQeWzSrksaLB7qV8CQ+rX7Y5OMNXyKE5btTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TFp7cV7X; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iP7yszLUsUADo0WsHtRm94kACcNDCCcdMa0yUAjuQ/g=; b=TFp7cV7XHU3T0+OTtLxOJEDQZm
	Qok3jV0AAmSTjzTw4o3X/nCuZ4ajVctMMy8gACT/IXXouHEpcVxAV0R0KuYD705LT2heSF/QJ2K0i
	5gWAWmzHt+q8Cepdr2nooXRJAgNT9/MipTh3ffSJRsHXvq/Ps9r7oIrJHc1LcB/Til7rSZzoi3QGe
	6YIpiosNpb2K7pMSmIo/Fwxgd6M0ASGZ6CE9wI+tdynUoN3be9a7C/qhYe+PiVdeV23q5+pbhe7Ae
	g8mZGvx0O7ZQilogp+L8358szTQddWzEoBH/m+OjZnZgqgfC8+s7zwM4Vrw+cr3MiFFEDTutIDCFP
	d9bZVdkA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35610)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7xia-0007WE-0w;
	Thu, 24 Apr 2025 15:38:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7xiW-0001Ag-0w;
	Thu, 24 Apr 2025 15:38:20 +0100
Date: Thu, 24 Apr 2025 15:38:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v1 3/4] net: phy: Don't report advertised EEE
 modes if EEE is disabled
Message-ID: <aApM3MC_FW6BSpW8@shell.armlinux.org.uk>
References: <20250424130222.3959457-1-o.rempel@pengutronix.de>
 <20250424130222.3959457-4-o.rempel@pengutronix.de>
 <07bd8b38-c49c-481b-b08b-fff78b9ffe98@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07bd8b38-c49c-481b-b08b-fff78b9ffe98@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 24, 2025 at 04:30:40PM +0200, Andrew Lunn wrote:
> On Thu, Apr 24, 2025 at 03:02:21PM +0200, Oleksij Rempel wrote:
> > Currently, `ethtool --show-eee` reports "Advertised EEE link modes" even when
> > EEE is disabled, which can be misleading. For example:
> > 
> >   EEE settings for lan1:
> >           EEE status: disabled
> >           Tx LPI: disabled
> >           Supported EEE link modes:  100baseT/Full
> >                                      1000baseT/Full
> >           Advertised EEE link modes:  100baseT/Full
> >                                       1000baseT/Full
> >           Link partner advertised EEE link modes:  Not reported
> 
> What is the behaviour for normal link mode advertisement? If i turn
> autoneg off, do the advertised link modes disappear? Do they reappear
> when i turn autoneg back on again?
> 
> I would expect EEE to follow what the normal link modes do. Assuming
> the Read/modify/write does not break this.

It's difficult to compare, because ethtool is implemented differently
between modifying the link modes and the EEE stuff. ethtool -s autoneg
on uses this:

                        if (autoneg_wanted == AUTONEG_ENABLE &&
                            advertising_wanted == NULL &&
                            full_advertising_wanted == NULL) {
                                unsigned int i;

                                /* Auto negotiation enabled, but with
                                 * unspecified speed and duplex: enable all
                                 * supported speeds and duplexes.
                                 */

whereas do_seee() has no special handling.

So, if we want ethtool --set-eee eee off; ethtool --set-eee eee on *not*
to end up with the advertising mask being cleared, then we have to
preserve it, or force the advertising mask to something if the
advertising mask is empty and eee_enabled is true.

Or we preserve the advertising mask when eee_enabled is cleared, which
is what we do today.

I think, given the different implementations in ethtool, we can't just
say "we want it to be have the same" by just modifying the kernel.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

