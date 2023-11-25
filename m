Return-Path: <netdev+bounces-51046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F497F8CAA
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 18:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A677528110C
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD31429439;
	Sat, 25 Nov 2023 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zB2WNWCu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88445106
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 09:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3qpd86IOyW8DxDk9KPMIaP4sX9XO4YDtR3Ognfw5fv4=; b=zB2WNWCuveeRszL8p2fQv8skYS
	DLih/x6pXstlk68KeI3EbrxHI/fZibJQ/Taz8Qzchv7t9uERqlh8DVx5+RGmEj1WpKG+xZMls1zUn
	Ke9ieH1oFokUeC3EiPUBXYu2sk0/C7VlG4xpoThbTdL+OkSjMUvIV6Mwl50jJ9fA1EHE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6wFO-001CRT-2Q; Sat, 25 Nov 2023 18:15:14 +0100
Date: Sat, 25 Nov 2023 18:15:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 09/10] net: phylink: split out PHY validation
 from phylink_bringup_phy()
Message-ID: <9685533d-9cd1-4c0e-afa1-c63f354f97a8@lunn.ch>
References: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
 <E1r6VIQ-00DDM9-LK@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1r6VIQ-00DDM9-LK@rmk-PC.armlinux.org.uk>

On Fri, Nov 24, 2023 at 12:28:34PM +0000, Russell King (Oracle) wrote:
> When bringing up a PHY, we need to work out which ethtool link modes it
> should support and advertise. Clause 22 PHYs operate in a single
> interface mode, which can be easily dealt with. However, clause 45 PHYs
> tend to switch interface mode depending on the media. We need more
> flexible validation at this point, so this patch splits out that code
> in preparation to changing it.
> 
> Tested-by: Luo Jie <quic_luoj@quicinc.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

