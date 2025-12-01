Return-Path: <netdev+bounces-243009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 914A2C98239
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 16:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1BB84E174C
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2E6333432;
	Mon,  1 Dec 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MJqNBU9j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C6332EC1
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604539; cv=none; b=LxirpagOwggs2q3/7WyDcDAnm+L+hrvzWSLhXkAkZgkXiKrZIx2/u21xIBmJdWb1Ii+xR0wdUEOZaeUYPWRdOchKvTJUNKZlcIC/tLqp0ycFPCwQ/jAKNgqznxuAcYc8n5k0pJ1Wz3eRn2szEEtlHwx4QeEMPnVz9ms658CKVQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604539; c=relaxed/simple;
	bh=icwUZyyoRYBu8gOv4hPzp/qFQgFgLKSsTRprhy0vMck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUxHJ3RXjFQLW/Bhj7SUfE6PiBJMas/CJcYJt/QVEvL1p8joCh12qjU6Nxe28w1ZgbG2HW5CM1Ma9a4YpEcRuCRQO02TDALnnncK4mc7pd998hV/ZgEkLRjFDO88/5yRHeeDl3uZx17hJuHepC6StU5tK3Ign6pRctrmLGsrqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MJqNBU9j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VTEiKyqnmpUyfKxvjtjoMwds4d2cP+VOremdDYjxN14=; b=MJqNBU9jtl/amP4JSRy7O4++9+
	btazn7HSDXfN6POHrEsydPVxIK8vtRn/pcrN5i/818rW83TX8lk8E4U7PI0sIvcEm+rQzYvw6Mwfm
	eQj6EEWt9c7s0tnSNbBwr7BFCqAFh6VewGz7n7AFmAYjD6dhZGwPGL+J+PVN2UiqT1Vw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQ6FF-00FaUH-DN; Mon, 01 Dec 2025 16:55:21 +0100
Date: Mon, 1 Dec 2025 16:55:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 00/15] net: stmmac: rk: cleanups galore
Message-ID: <05db9d3e-88fa-42db-8731-b77039c60efa@lunn.ch>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>

> One of the interesting things is that this appears to deal with RGMII
> delays at the MAC end of the link, but there's no way to tell phylib
> that's the case. I've not looked deeply into what is going on there,
> but it is surprising that the driver insists that the delays (in
> register values?) are provided, but then ignores them depending on the
> exact RGMII mode selected.

Yes, many Rockchip .dts files use phy-mode = 'rgmii', and then do the
delays in the MAC. I've been pushing back on this for a while now, and
in most cases, it is possible to set the delays to 0, and use
'rgmii-id'.

Unfortunately, the vendor version of the driver comes with a debugfs
interface which puts the PHY into loopback, and then steps through the
different delay values to find the range of values which result in no
packet loss. The vendor documentation then recommends
phy-mode='rgmii', and set the delays to the middle value for this
range. So the vendor is leading developers up the garden path.

These delay values also appear to be magical. There has been at least
one attempt to reverse engineer the values back to ns, but it was not
possible to get consistent results across a collection of boards.

       Andrew

