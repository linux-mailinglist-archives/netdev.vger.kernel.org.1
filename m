Return-Path: <netdev+bounces-150911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA439EC107
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399EF188A91F
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516C6364BA;
	Wed, 11 Dec 2024 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG+BKg9J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D772A1CF;
	Wed, 11 Dec 2024 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733877790; cv=none; b=Z2z9L7+z4Tirq9F5UDJKFU3Do2pktxGpFBFHWiOY59KLnxvKi5HVpDSuOxMvynuMta7EBengXEzT/1ACogON5tDZjP1jttrh8iv8+ac72+gW1z+wTiIi3VXIzsjBjlD+rBRppJUvZ5dxd4EqoQJBYzSTbxvFH0IJp2HXAU9GHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733877790; c=relaxed/simple;
	bh=NgVez8nReWQlSrD2wR+9xnrrekmBUArkj9umbfrXTF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCpL/AXunVBJ+9+fjEKxV8YhIesuXQdXSP6UrUeqJ9vIaJGL2oAMimJXME2ERZBzSkPz2qsJfJ4/G4f9AIfEAdYuHQTWEiEM4YlxsUBImZreyr1s0fbjblSAMUx7Q9v/9DN2ulwZn0Q1E0qFqrqq5Ed3lem11KXOYKQgL6FJQ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pG+BKg9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9EAC4CED6;
	Wed, 11 Dec 2024 00:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733877789;
	bh=NgVez8nReWQlSrD2wR+9xnrrekmBUArkj9umbfrXTF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pG+BKg9JU+q5lYb8UWPUOfOa2unJCPTPaYl4i003XvIpDyMqQD4KQHnTwV1i+wPaP
	 6pZ1/sCNgnaWmkRz7Nn+Q4GNJoSNX0RxxBbd67snXEjcytav4+Hy+NqbYRfHcGizN4
	 zVT870Sde5f5u8aAE2irXkONA6NBdDRea+KwsBQWfWCchBpgbxxhWjLdZWtHoVMuA7
	 F5TUoQR+xBE4RZvmo3XJpI/+EC46Sx/7XIgasuXot1fFyk5BaXnNLT/+8n3g6qbGlt
	 yfBsiWf5wNWxbvUzUnzGlqsMvh61B+KfGUqtORJsJG5K4k1VsNO1Qcxh7V5MuonkZ5
	 KQCDRO97PcF/g==
Date: Tue, 10 Dec 2024 16:43:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
 <hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
 "heiko.stuebner@cherry.de" <heiko.stuebner@cherry.de>, "fank.li@nxp.com"
 <fank.li@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v3 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Message-ID: <20241210164308.6af97d00@kernel.org>
In-Reply-To: <PAXPR04MB85104EC1BFE4075DF1A27B93883D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241206012113.437029-1-wei.fang@nxp.com>
	<20241209181451.56790483@kernel.org>
	<PAXPR04MB85104EC1BFE4075DF1A27B93883D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 02:45:57 +0000 Wei Fang wrote:
> The simple fix could only fix the commit 985329462723 ("net: phy: micrel: use
> devm_clk_get_optional_enabled for the rmii-ref clock"), because as the commit
> message said some clock suppliers need to be enabled so that the driver can get
> the correct clock rate.
> 
> But the problem is that the simple fix cannot fix the 99ac4cbcc2a5 ("net: phy:
> micrel: allow usage of generic ethernet-phy clock"). The change is as follows,
> this change just enables the clock when the PHY driver probes. There are no
> other operations on the clock, such as obtaining the clock rate. So you still think
> a simple fix is good enough for net tree?

I may be missing something but if you don't need to disable the generic
clock you can put the disable into the if () block for rmii-ref ?

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 3ef508840674..8bbd2018f2a6 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2214,6 +2214,8 @@ static int kszphy_probe(struct phy_device *phydev)
                                   rate);
                        return -EINVAL;
                }
+
+               clk_disable_unprepare(clk);
        } else if (!clk) {
                /* unnamed clock from the generic ethernet-phy binding */
                clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, NULL);

