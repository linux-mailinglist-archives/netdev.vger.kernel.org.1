Return-Path: <netdev+bounces-52542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6774C7FF165
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C08281D83
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B15487B4;
	Thu, 30 Nov 2023 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rEX41nld"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B6385;
	Thu, 30 Nov 2023 06:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xrGDxVjBiy7pGNBE5oOMMvnk6VYQFSoFjjA2DKv6muM=; b=rEX41nldmv40f0DNOVJj3H45rw
	t4zA1ylJWlvA9W/3ulRx3KKe/i8dTncKpRJppD1Ih6xVZcFWzbGVccQAffNR/ozco/EWhK5Vq04ll
	TJsSKiN4ldW1cpuBhLLop5krQxxMIGfo3qdgXAK+BChgMNA/V4EP0APjQv/QDFUX6JrY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r8hku-001fii-QS; Thu, 30 Nov 2023 15:11:04 +0100
Date: Thu, 30 Nov 2023 15:11:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Subject: Re: [PATCH net-next v2] net: phy: mdio_device: Reset device only
 when necessary
Message-ID: <760c746a-5469-4f26-8fd9-5f48affe44a4@lunn.ch>
References: <20231127-net-phy-reset-once-v2-1-448e8658779e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-net-phy-reset-once-v2-1-448e8658779e@redhat.com>

On Mon, Nov 27, 2023 at 03:41:10PM -0600, Andrew Halaney wrote:
> Currently the phy reset sequence is as shown below for a
> devicetree described mdio phy on boot:
> 
> 1. Assert the phy_device's reset as part of registering
> 2. Deassert the phy_device's reset as part of registering
> 3. Deassert the phy_device's reset as part of phy_probe
> 4. Deassert the phy_device's reset as part of phy_hw_init
> 
> The extra two deasserts include waiting the deassert delay afterwards,
> which is adding unnecessary delay.
> 
> This applies to both possible types of resets (reset controller
> reference and a reset gpio) that can be used.
> 
> Here's some snipped tracing output using the following command line
> params "trace_event=gpio:* trace_options=stacktrace" illustrating
> the reset handling and where its coming from:

...
 
> Reported-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


