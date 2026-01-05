Return-Path: <netdev+bounces-247078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE68CF4197
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 15:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D1EB3009540
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA67833FE11;
	Mon,  5 Jan 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AWFrs/tJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61EE33FE09
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623062; cv=none; b=f5duBBV+sXhISkbNYtr2a5JhVD0z8/UU3oU9WnKROxbYRxHDMDgNppGtMxlRwqhOUUTuh+tHZ6A+vz3BmgRZc4tDjak8i4dQ+0V6njkvu7g34rrJdYPUea6NKCPNqTyNcIHaIdl2gE/v52d6/+XeJWk9J9wqJHRoiKUM112HkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623062; c=relaxed/simple;
	bh=UXjrCks0Z3dEvMazss9PDrmnqAKae1/AKEqKpu7NwE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSRQHuSLtSgb5gZCgSazHobsZg4Tsc/hhWh4EAmGSDMApP81g5N9qT3U8ujHnODR8jITz7UGeynUJEfD+jsu3coivRp1aEJrmB8Ayc0mB8Sur0VExatWt6BEjki3bV7/c8WI0o+ijw7mHn2cD28davcC53Ep/RDHIHtBFLwXVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AWFrs/tJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PbkDpX5Hj4iuKAos6ENltZi9lIosp6dE8/eYTptdHPs=; b=AWFrs/tJHDrZI4QD6/Lrzhiw/E
	Y2EUnKKye0UHHLSUJEZfLyVgE3E2ssqFP/dXy8nn8rj/+K7ysGTFU+Un95uW69SQ+TDJHjl32HPZ5
	MpZyTI2fOIt5F4MIpLuZHTA73XdleOAfvPCXhxUh5fZ9zsSk2F41i8pii57KuYxU59Hs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vclVK-001Ujh-MN; Mon, 05 Jan 2026 15:24:18 +0100
Date: Mon, 5 Jan 2026 15:24:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [PATCH net] Revert "dsa: mv88e6xxx: make serdes SGMII/Fiber tx
 amplitude configurable"
Message-ID: <ea3f1274-70bd-4b04-8f6e-468851e6fc8f@lunn.ch>
References: <20260104093952.486606-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104093952.486606-1-vladimir.oltean@nxp.com>

On Sun, Jan 04, 2026 at 11:39:52AM +0200, Vladimir Oltean wrote:
> This reverts commit 926eae604403acfa27ba5b072af458e87e634a50, which
> never could have produced the intended effect:
> https://lore.kernel.org/netdev/AM0PR06MB10396BBF8B568D77556FC46F8F7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com/
> 
> The reason why it is broken beyond repair in this form is that the
> mv88e6xxx driver outsources its "tx-p2p-microvolt" property to the OF
> node of an external Ethernet PHY. This:
> (a) does not work if there is no external PHY (chip-to-chip connection,
>     or SFP module)
> (b) pollutes the OF property namespace / bindings of said external PHY
>     ("tx-p2p-microvolt" could have meaning for the Ethernet PHY's SerDes
>     interface as well)
> 
> We can revisit the idea of making SerDes amplitude configurable once we
> have proper bindings for the mv88e6xxx SerDes. Until then, remove the
> code that leaves us with unnecessary baggage.
> 
> Fixes: 926eae604403 ("dsa: mv88e6xxx: make serdes SGMII/Fiber tx amplitude configurable")
> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

