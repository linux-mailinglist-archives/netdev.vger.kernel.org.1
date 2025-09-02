Return-Path: <netdev+bounces-219176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B11B40427
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6AD4E7768
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD6330F536;
	Tue,  2 Sep 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SgvyQ2aW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACAD18DF80;
	Tue,  2 Sep 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820120; cv=none; b=DRAQYinJAUc5f+2vzgav4juVYm1/9ahGneqBvvOP+uowepRkSNCvHGOGcGz10Pvx9NKvUx/2VNPT4QEqQ13qUZDNJ118+IJmOX1cQsM6+QaqMm5v6F/GToy2vlGe+UElyMU/G42q7BSseKkbXvzvXB3mXwrrIDL2fta1MnTbi6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820120; c=relaxed/simple;
	bh=xUWKJcdlXzMjs1BmaS6HiN8JM5c6HpQ9mNLZ/eAr/Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic7ZvF9AQzcmznKnivdGDPjKJoPJJEYiFFB6v7GWhkZxuVjhxEXp+Q4Iu9Rb93Zy/N0TRY4CxQ2zFF50CFRWlfHZpcMsnEjaXJ5pxJnqWOdiSDk8rqFun6q8HEOpFYyH5/pSM5efBv8HHZwHw7Hu40y0Sf5U3itM6l8mr7M02Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SgvyQ2aW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yPD0mQHG+NFBjBqbvmLZhMDNtWCPfim9f9WnWnRZZHI=; b=SgvyQ2aWLBPcy9uEM52Mpl8SvY
	kQseUi+JQze4tsMl9Cg4mNV8K02dOeP7GpLHtXIQhEtaosqhP3CjsvIcedPM/VfybZCuXOmzH/n04
	7eA5GmwueFp6CZderQWK67IBLFDU9PRPZiU4oTshvxLIyngYIVZm+QOpPuTGQZ+FPXuiZ1LyVDXfS
	5ojC9NTxfpSX/mCeRm1sPMICnR1WgfX58hpaiyjWyKOl7iCHHa45V/EUwM/4DFxLRGZvClk9uwaqB
	vpvKMkDMSWK6ZohNTgFq/+MnzEvKUxRREYrP4KWiZtKY7BzO+pLFYOFnzx7qcRYmYm9BrpaSBjJ0+
	4OX8KLNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42068)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1utRAG-000000007hR-2se5;
	Tue, 02 Sep 2025 14:35:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1utRAE-00000000817-1Qic;
	Tue, 02 Sep 2025 14:35:10 +0100
Date: Tue, 2 Sep 2025 14:35:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: rohan.g.thomas@altera.com
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next] net: phy: marvell: Fix 88e1510 downshift
 counter errata
Message-ID: <aLbyju1nKm5LXDDX@shell.armlinux.org.uk>
References: <20250902-marvell_fix-v1-1-9fba7a6147dd@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-marvell_fix-v1-1-9fba7a6147dd@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 02, 2025 at 01:59:57PM +0800, Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> The 88e1510 PHY has an erratum where the phy downshift counter is not
> cleared on a link power down/up. This can cause the gigabit link to
> intermittently downshift to a lower speed.

Does this apply to all 88e1510 PHYs or just some revisions?

Also, what is a "link power down/up" ? Are you referring to setting
BMCR_PDOWN and then clearing it? (please update the commit description
and repost after 24 hours, thanks.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

