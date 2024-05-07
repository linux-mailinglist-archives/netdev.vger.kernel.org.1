Return-Path: <netdev+bounces-94097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E38BE1CA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23658B24FD3
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4EF156F37;
	Tue,  7 May 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ya2BoL79"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5173C1509B9;
	Tue,  7 May 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084101; cv=none; b=D5iDQqt0n/8TAoydrNC4J0JTYpAi6SdjBAYaMuNNhwB5qZVy/ToO3AgHSRNyfKOElNl3j93WgufLcVqG5UMhq7bnOsqQjXgpZ4QF0E1mv8TYxNZJtfafKG1e0zS4ade/OppmQSMOmMO336CYdGsNKLD0TlVReNIB781rrX1A+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084101; c=relaxed/simple;
	bh=3DBodyIseI/KrAKaNn0tJfn2DJ9Ux2goMeQ1lVVmchc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+pyj+8tbISQc2rKT/ceZXYwcAj2MOKvBS0FS36BfTYw5oNSp93p2sIPj1j8XbvoG78yzuz8lQEg+UptAB33FOjO+sm6YEbZOHdVpnB9snPIJETkwkl/pZgc4kUjyy1S5m1pvnmNauGUAFmTgi2JWnyaL9xnon98bvHRHtC/uFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ya2BoL79; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/wYdZa8kaSbc7/RZ6x5/jZT7PXXz4TNl3mHNDIEp4lQ=; b=ya2BoL79fLG9b9HTB5CSQ7keYp
	3dJuWamYr/WVDtO+XIQlOAReAEKcCj+oabAFkeAtVybsuwNAVzMStno0Yr9fld/c73RARx2ip1mhw
	m+rqEu54tftP8qaMH3RvCd7OYe6PDBq8iB4vuZC1M+vb58MAQLSFJtjZ45bBvxQnnr50=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4Jid-00Eqmx-Qw; Tue, 07 May 2024 14:14:51 +0200
Date: Tue, 7 May 2024 14:14:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH net-next v2 1/2] net: phy: marvell: constify
 marvell_hw_stats
Message-ID: <0ff22e1e-fb60-4773-9a78-2e796df09344@lunn.ch>
References: <24d7a2f39e0c4c94466e8ad43228fdd798053f3a.1714643285.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d7a2f39e0c4c94466e8ad43228fdd798053f3a.1714643285.git.matthias.schiffer@ew.tq-group.com>

On Thu, May 02, 2024 at 01:13:00PM +0200, Matthias Schiffer wrote:
> The list of stat registers is read-only, so we can declare it as const.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

