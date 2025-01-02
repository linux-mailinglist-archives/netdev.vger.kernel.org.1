Return-Path: <netdev+bounces-154702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539459FF813
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4303A214D
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2679A1917EE;
	Thu,  2 Jan 2025 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UT96O4/H"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845B2CA9
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735813936; cv=none; b=fliRYxPRJeeXpcLfULW6+3Z7I48eNDVB21rJ54nAWyQMSHYINFEMPm43blDCJzIxbQ+Ge5NXOU4MC9gwVwM7JJSh3Wrl4/Qsi+LG/yckJnzbBf9+N4bOrJQsAIiezZ9FQpqO7DMlhXZ5ogrMQkAdY5e0kdeE8hw2NmRm/7lsuL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735813936; c=relaxed/simple;
	bh=Sz66eLaZigTRLwrcnmmv0vAKUE3HaoCb02eF1gC7bco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcsexx5eP2Dj4N7SnEHVZ4Tf1zRbZx/Qps4sOvzcJDGKQcRBbL6u4u44bAfrXGw5inQG6pWYUBr9Wj8VuFydIuryNfVotPR+g0YIMcNwDq+wbwmXkQWKIlfNvvOdtMCF2bzYIoHUOy8+oqlJthfke/yFOpt5cBtsjcyK/7aNJRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UT96O4/H; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/z4Gm45a8EMmHxnDCh9miyxEAtSOON+rPQZopY3zPAA=; b=UT96O4/HJv2Hg3Au3iV9DHGZ37
	PCdeafEsnaT4T43L6/h2klNzY+BLNm3yWukJqt9MmRRb1KWcvJR9Ju7t/vNp0uylQezZcOknKmeIs
	6cXzdz4EYhCiaRLwkKfF6+E5Nw7cNG5IUgumtTHiBPryZLttLbBKvubqHuqVJKavgQnA1fPIzw6QO
	59/IGQriPCkQx7bNSewWUGy9IrloO5E+csjeJ4q3x26qy/ndy4CwYq0sI+T7adnyP6Fj5Hv7B4FYw
	MzUM5ZTgXF5tt5jg5qaE71F6eTQ8CDqPnJ1/5EjST4S4R/IJwQel3bfOO2QuN9Qj/N8McQncz0svD
	iLaA2mZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59420)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTIUm-0001sQ-34;
	Thu, 02 Jan 2025 10:32:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTIUh-0000C3-0s;
	Thu, 02 Jan 2025 10:31:59 +0000
Date: Thu, 2 Jan 2025 10:31:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 3/4] net: dsa: mv88e6xxx: Never force link on
 in-band managed MACs
Message-ID: <Z3ZrH9yqtvu2-W7f@shell.armlinux.org.uk>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-4-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219123106.730032-4-tobias@waldekranz.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 19, 2024 at 01:30:42PM +0100, Tobias Waldekranz wrote:
> NOTE: This issue was addressed in the referenced commit, but a
> conservative approach was chosen, where only 6095, 6097 and 6185 got
> the fix.
> 
> Before the referenced commit, in the following setup, when the PHY
> detected loss of link on the MDI, mv88e6xxx would force the MAC
> down. If the MDI-side link was then re-established later on, there was
> no longer any MII link over which the PHY could communicate that
> information back to the MAC.
> 
>         .-SGMII/USXGMII
>         |
> .-----. v .-----.   .--------------.
> | MAC +---+ PHY +---+ MDI (Cu/SFP) |
> '-----'   '-----'   '--------------'
> 
> Since this a generic problem on all MACs connected to a SERDES - which
> is the only time when in-band-status is used - move all chips to a
> common mv88e6xxx_port_sync_link() implementation which avoids forcing
> links on _all_ in-band managed ports.
> 
> Fixes: 4efe76629036 ("net: dsa: mv88e6xxx: Don't force link when using in-band-status")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

I'm feeling uneasy about this change.

The history of the patch you refer to is - original v1:

https://lore.kernel.org/r/20201013021858.20530-2-chris.packham@alliedtelesis.co.nz

When v3 was submitted, it was unchanged:

https://lore.kernel.org/r/20201020034558.19438-2-chris.packham@alliedtelesis.co.nz

Both of these applied the in-band-status thing to all Marvell DSA
switches, but as Marek states here:

https://lore.kernel.org/r/20201020165115.3ecfd601@nic.cz

doing so breaks last least one Marvell DSA switch (88E6390). Hence why
this approach is taken, rather than not forcing the link status on all
DSA switches.

Your patch appears to be reverting us back to what was effectively in
Chris' v1 patch from back then, so I don't think we can accept this
change. Sorry.

If you have a switch that needs your change, then I think you also need
to adopt the "conservative" approach and only fix the switch you're
working with - short of someone going through all the Marvell DSA
switch datasheets or testing on real hardware, I don't think it's a
good idea to change the behaviour of all Marvell switches like this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

