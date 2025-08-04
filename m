Return-Path: <netdev+bounces-211592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD932B1A484
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09288179892
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2E326FA70;
	Mon,  4 Aug 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="heegnlbo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345AF19B5A7;
	Mon,  4 Aug 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317386; cv=none; b=Yl+QwEFLumdk068OkalElptK2MHE1BxkLS9mRZxF2SQxiNa+BcfUk4jm7+mWS8cv4A9LKL5SricdysgqhBlDyYaF8ygFA2JzknyzJzH2fuK+C1TFUTcU3KjIALKLL7Pc+5xv4zHQ9eEs/2FhqFlXYCa4BuqMv8s1hGTAfx1UD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317386; c=relaxed/simple;
	bh=Cy7/3H0q3cx0Rbvqsw++44rJBoWXnbz+ae5q066m/WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ka9BmmiwmXWcfk0dIGuaZO6G/a7EQbHtCExYf03ulm8jLyVoATwQ9pjDEbIQb9iNBdRa8crZHr67wEYafc1rG/7Oejy03t9JOd3Cmt7Ixo1QlkFM7r5VO4KpH38uFommjo5S0ZcNBPmWw//f43gdXb8Wsmx2OrMPO+jQ5uJAK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=heegnlbo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=et/dI5/h3BCkcc6Ucfe8h5aatgps4oRPy2URF21voK4=; b=heegnlbo3j87JCJFkOZm4ZS10R
	QRL9oNK14GE6ZRSgdGDZxyMlgo7wsoYafwq/UejM/vrc04Bx2Fvnt8hG/M9Ryw13o/4eAZT80Zruc
	FEYVFXqsqc5fTx0PgI4AsJ7G8hpUwrPYXgUKY5z2zC9FSQECnHAZZndcYkJeqQmIjyoaCQ5w/Vhqb
	TFb6DS5USsKNII1sVyyC0HwuhEIvHkwMZIxv6P/pvdszO1qirK08U4tPpj91R8otw/6gkODZffGA/
	G0WkYetuvB18rtdGOA3yTaeGExKoUnJgSz3MSRlLW2ZLpMmR3jNgkiqX8KdWWKvV4/NIkO6lpDyTD
	6V5o4OsA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59986)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uiw5W-0001mI-0v;
	Mon, 04 Aug 2025 15:22:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uiw5S-00058C-1P;
	Mon, 04 Aug 2025 15:22:50 +0100
Date: Mon, 4 Aug 2025 15:22:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aJDCOoVBLky2eCPS@shell.armlinux.org.uk>
References: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
 <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 04, 2025 at 03:01:44PM +0200, Alexander Wilhelm wrote:
> Am Mon, Aug 04, 2025 at 01:01:39PM +0300 schrieb Vladimir Oltean:
> > On Mon, Aug 04, 2025 at 08:17:47AM +0200, Alexander Wilhelm wrote:
> > > Am Fri, Aug 01, 2025 at 04:04:20PM +0300 schrieb Vladimir Oltean:
> > > > On Fri, Aug 01, 2025 at 01:23:44PM +0100, Russell King (Oracle) wrote:
> > > > > It looks like memac_select_pcs() and memac_prepare() fail to
> > > > > handle 2500BASEX despite memac_initialization() suggesting the
> > > > > SGMII PCS supports 2500BASEX.
> > > > 
> > > > Thanks for pointing this out, it seems to be a regression introduced by
> > > > commit 5d93cfcf7360 ("net: dpaa: Convert to phylink").
> > > > 
> > > > If there are no other volunteers, I can offer to submit a patch if
> > > > Alexander confirms this fixes his setup.
> > > 
> > > I'd be happy to help by applying the patch on my system and running some tests.
> > > Please let me know if there are any specific steps or scenarios you'd like me to
> > > focus on.
> > > 
> > > Best regards
> > > Alexander Wilhelm
> > 
> > Please find the attached patch.
> [...]
> 
> Hi Vladimir,
> 
> I’ve applied the patch you provided, but it doesn’t seem to fully resolve the
> issue -- or perhaps I’ve misconfigured something. I’m encountering the following
> error during initialization:
> 
>     mdio_bus 0x0000000ffe4e7000:00: AN not supported on 3.125GHz SerDes lane
>     fsl_dpaa_mac ffe4e6000.ethernet eth0: pcs_config failed: -EOPNOTSUPP

We're falling foul of the historic crap that 2500base-X is (802.3 were
very very late to the party in "standardising" it, but after there were
many different implementations with varying capabilities already on the
market.)

aquantia_main.c needs to implement the .inband_caps() method, and
report what its actual capabilities are for the supplied interface
mode according to how it has been provisioned.

> 
> The relevant code is located in `drivers/net/pcs/pcs-lynx.c`, within the
> `lynx_pcs_config(...)` function. In the case of 2500BASE-X with in-band
> autonegotiation enabled, the function logs an error and returns -EOPNOTSUPP.
> 
> From what I can tell, autonegotiation isn’t supported on a 3.125GHz SerDes lane
> when using 2500BASE-X.

Due to the lack of early standardisation, some manufacturers require
AN, some have it optional, others simply do not support it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

