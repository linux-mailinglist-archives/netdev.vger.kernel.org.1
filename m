Return-Path: <netdev+bounces-86096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E6889D885
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 13:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28CC1C21A59
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943391292DC;
	Tue,  9 Apr 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCdrr/VE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A23B1EB46;
	Tue,  9 Apr 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663428; cv=none; b=Eiosv81JjCV4OVxXaYfmi7NeF6etk/6Vm8tkJHjEmDPgiGxtTWNdG0wEW+nu09SZT2Z3avKxN6sNZq45HjGS96PCpvWxCxS60xwhQh6WY8Bo36VdGwnEf0WOyvSVI/yuyYCTCrDYaiCMwtc5xHMxvCowmczHNsJqmLehmwmkIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663428; c=relaxed/simple;
	bh=I4BnYVYT3gg87LXbBOgTCHDCQcRo/zxWen2A3wtiEMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tRrRgDXNQCgHJ3WAIThfOiBj9CdOt83oooGqSEOw0d5S2uSIYiz8ZoFqaYHzV5/HicPzs8JrZDqQiUTrbg8plgw/Of3x47L/Kvd1ZT0xVb2f1fo6QQYdUNBexDxpI4P0LBgRybJgw6lE5GE/3oLZdLL2MaiUISZkUNAUInrEV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCdrr/VE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBF63C43390;
	Tue,  9 Apr 2024 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712663427;
	bh=I4BnYVYT3gg87LXbBOgTCHDCQcRo/zxWen2A3wtiEMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QCdrr/VEILDIMOZGjwiBJotnjd9n+XfRhDsOhVl4nsSazDS/f51cNH9VUMetQhcmd
	 1JdkhPIzg8hdXtTtym5SJabGDU1klTmSYavumGTKd9YrauHBPshEBL8vQvbrIQdF6/
	 mY6aR/NkfucqWfdc/z7o3Q/m8wNdk5K+yORBmr7DeAd3yJJSTaKgGygv0c0t30A3rv
	 2dwFjvkv7+reaxe1eVwoE4JQXiog+h0QDV5Q7po5EuivrPEsuTnapAS7EYB2d8PKAj
	 wqSKnCxYzVX4vXZtItCTyrASdZngE+hNSKXXWITHmEcgHxtOOwXhVIKmFXksPdOFdi
	 XH9IFQk0SaAuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAC4BD6030D;
	Tue,  9 Apr 2024 11:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: phy: micrel: lan8814: Enable
 PTP_PF_PEROUT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171266342776.5043.8472571400532563052.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 11:50:27 +0000
References: <20240408064432.3881636-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240408064432.3881636-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, divya.koppera@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 8 Apr 2024 08:44:30 +0200 you wrote:
> Add support for PTP_PF_PEROUT to lan8814. First patch just enables
> the LTC at probe time, such that it is not required to enable
> timestamping to have the LTC enabled. While the second patch actually
> adds support for PTP_PF_PEROUT.
> 
> v2->v3:
> - rebase on latest net-next
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: phy: micrel: lan8814: Enable LTC at probe time
    https://git.kernel.org/netdev/net-next/c/9f6b3a498174
  - [net-next,v3,2/2] net: phy: micrel: lan8814: Add support for PTP_PF_PEROUT
    https://git.kernel.org/netdev/net-next/c/9e63941b8976

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



