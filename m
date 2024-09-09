Return-Path: <netdev+bounces-126464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589CA9713C0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152FF2844F8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E30F1B78F5;
	Mon,  9 Sep 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ70S5aJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D61B78F2;
	Mon,  9 Sep 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874236; cv=none; b=u65oZl8gbmJObLVU0gWQTUTFo1cb+ow1lZSmVR4fS1GseX6d1jwr56kiAxCvo/rjOcmh83VNN8KA5kmFZ7/aATIeM86ECPrY+SHpoO2j9XuslYfuj3SrbzxLm1dsJF9oh4kw/BSUMVF3JTsCml9e0s8qZ7cIDgRemlKuY1VCVxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874236; c=relaxed/simple;
	bh=jM+eEh3z9hLSGFBAP2spBKroZ66fcOCywXa+4ATXtio=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mMm0+cbWKi0/GaTtldwbYt9Ha5Kq2C+oVjnkmsheGaqStBap60OCouoP1QJ8Xnf7c3xNq/goZRK1d8r6QHeFDOpRESzxcrJllQNiUub1/KYXv2HF6ZXV0kVgW3qhgidCcTFf8AKW1P/Ujru58l1sqH25O97lbqFKvn9pc2brgZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ70S5aJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E7DC4CEC5;
	Mon,  9 Sep 2024 09:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725874236;
	bh=jM+eEh3z9hLSGFBAP2spBKroZ66fcOCywXa+4ATXtio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GZ70S5aJU5Pg8yp0BGZe4FbpXG0LTPt+mnwb/p2aR9Rune2sPb6vDxQe219aZmUaj
	 Zn13wbt1wlH+NLRpkFVOlNoSP+42XBL9vyZNEKQ4UA1ICY0hOsYp1YN2NnMKw9tGtL
	 p6l2GGgcTn33qPycPaIJbvXKWoBsSu5PC4X1yQJSdYcI3tCnbMZ5XCVj7MRgTA5ZlK
	 DeIG+QGnYU3wM2UXFY2LdXSoBp2sS+NHLjzhFPuZoPFOUL53F273KzdN2xsfkoCrH9
	 Mwi3DPghOS4cQUE5fRWj8fl3pB4WjFkYWPSt0H89gx+HGIlcyRSdtPNlkJF+nhnu18
	 x9zh/6itZ0eDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C533804CAB;
	Mon,  9 Sep 2024 09:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/8] net: ethernet: fs_enet: Cleanup and phylink
 conversion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172587423699.3396102.11607239737245606580.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 09:30:36 +0000
References: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, pantelis.antoniou@gmail.com, andrew@lunn.ch,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, christophe.leroy@csgroup.eu, f.fainelli@gmail.com,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, herve.codina@bootlin.com,
 linuxppc-dev@lists.ozlabs.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  4 Sep 2024 19:18:13 +0200 you wrote:
> Hi everyone,
> 
> This is V3 of a series that cleans-up fs_enet, with the ultimate goal of
> converting it to phylink (patch 8).
> 
> The main changes compared to V2 are :
>  - Reviewed-by tags from Andrew were gathered
>  - Patch 5 now includes the removal of now unused includes, thanks
>    Andrew for spotting this
>  - Patch 4 is new, it reworks the adjust_link to move the spinlock
>    acquisition to a more suitable location. Although this dissapears in
>    the actual phylink port, it makes the phylink conversion clearer on
>    that point
>  - Patch 8 includes fixes in the tx_timeout cancellation, to prevent
>    taking rtnl twice when canceling a pending tx_timeout. Thanks Jakub
>    for spotting this.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/8] net: ethernet: fs_enet: convert to SPDX
    https://git.kernel.org/netdev/net-next/c/30ba6d2f3463
  - [net-next,v3,2/8] net: ethernet: fs_enet: cosmetic cleanups
    https://git.kernel.org/netdev/net-next/c/2b29ac68e786
  - [net-next,v3,3/8] net: ethernet: fs_enet: drop the .adjust_link custom fs_ops
    https://git.kernel.org/netdev/net-next/c/96bf0c4e9f48
  - [net-next,v3,4/8] net: ethernet: fs_enet: only protect the .restart() call in .adjust_link
    https://git.kernel.org/netdev/net-next/c/aa3672be731d
  - [net-next,v3,5/8] net: ethernet: fs_enet: drop unused phy_info and mii_if_info
    https://git.kernel.org/netdev/net-next/c/6b576b2d4430
  - [net-next,v3,6/8] net: ethernet: fs_enet: use macros for speed and duplex values
    https://git.kernel.org/netdev/net-next/c/21c6321459aa
  - [net-next,v3,7/8] net: ethernet: fs_enet: simplify clock handling with devm accessors
    https://git.kernel.org/netdev/net-next/c/c614acf6e8e1
  - [net-next,v3,8/8] net: ethernet: fs_enet: phylink conversion
    https://git.kernel.org/netdev/net-next/c/41f5fbffd177

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



