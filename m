Return-Path: <netdev+bounces-108949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B69C9264F9
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E5BAB26784
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1591018133A;
	Wed,  3 Jul 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OBMttbIF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69883181319;
	Wed,  3 Jul 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020994; cv=none; b=qOZagCBCPH55dvlihTAo4yfaksGupuid/YyRWkRQZa/wMAsbrX0jLJDzdlSydSa28vt7ls8Z95661oyKzDAiR2AsSpo7DUG82F/qfPUx6QP0//0yYuMrTgv+ducmRzbReFE+TjDnnNfKQ8O9f8bH+dEaH1rvwnc8n7G93OKQTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020994; c=relaxed/simple;
	bh=dU0xe+R284kEXjls7+XMRdqqLv7SlbOEtIOd3CTDKXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/nzwB7bvahjwvLumPDuSUYS1iHiX40qK5WTWZ8Z1moN3efU4ZTsGLlcCl5vXefk8V8n2y20KGNolsYjTEJqdQ57RzZuDmTo/Hgnx+TJ4WwjWiXonq0mTnzq3qUuzD/xDbWt8SjUI0L8ANILouoULrMUG7P112ZwC7GQFbLNQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OBMttbIF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zH2SD8rUaX7tL9j2puH1Vo4TaLc9D24I4uSOaHfGKUU=; b=OBMttbIFFxa0CY+KssUWOtm0A1
	MuzR5/Om6OAM9o8YYKpZcd+S4mTrbqKuaFYLLJR9sslmq+iXG8HcvbGIff7sd4FtT20tOCq609qxz
	wfpx6UGzsmNfx8uSE8XqMzqCOFG+p8KY2aw6tQf4Up6+3iBqjQD0IvG7RIPDBy9kHRVUttM4d+H1G
	QzjD4PlsuQHxPEl4vBNVxLb4qy1ed9/BWbJ22drVQjQSf7SgTndX0dm4tzXsRo4D2JZVZaBhxjshD
	KdMZpHb03O6Px8NlpjJHf2m65cnkmJYW26UqlQFIldn5pVg7WWSrjgu8WTDXgGZwOGC25Z4F5uQgR
	6Lf/xFRQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51192)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sP21s-0005mW-1U;
	Wed, 03 Jul 2024 16:36:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sP21s-00031Y-W0; Wed, 03 Jul 2024 16:36:21 +0100
Date: Wed, 3 Jul 2024 16:36:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next v15 04/14] net: sfp: Add helper to return the
 SFP bus name
Message-ID: <ZoVv9OJl0Cu67q1E@shell.armlinux.org.uk>
References: <20240703140806.271938-1-maxime.chevallier@bootlin.com>
 <20240703140806.271938-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703140806.271938-5-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 03, 2024 at 04:07:54PM +0200, Maxime Chevallier wrote:
> Knowing the bus name is helpful when we want to expose the link topology
> to userspace, add a helper to return the SFP bus name.

I think it's worth mentioning about the use case in this patch as well,
something like:

"This call will always be made while holding the RTNL which ensures
that the SFP driver won't unbind from the device. The returned pointer
to the bus name will only be used while RTNL is held."

> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/phy/sfp-bus.c | 11 +++++++++++
>  include/linux/sfp.h       |  6 ++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
> index 56953e66bb7b..37c85f1e6534 100644
> --- a/drivers/net/phy/sfp-bus.c
> +++ b/drivers/net/phy/sfp-bus.c
> @@ -860,3 +860,14 @@ void sfp_unregister_socket(struct sfp_bus *bus)
>  	sfp_bus_put(bus);
>  }
>  EXPORT_SYMBOL_GPL(sfp_unregister_socket);
> +
> +const char *sfp_get_name(struct sfp_bus *bus)
> +{
> +	ASSERT_RTNL();
> +
> +	if (bus->sfp_dev)
> +		return dev_name(bus->sfp_dev);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(sfp_get_name);

Please move this to just below sfp_bus_del_upstream() since the
functions in this file are organised as:

- internal functions
- upstream callable functions
- downstream (sfp driver) callable functions.

Note also that the upstream callable functions are all documented with
kerneldoc, and sfp_get_name() is clearly a function called from the
upstream side.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

