Return-Path: <netdev+bounces-94522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9497F8BFC12
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3414A1F2288D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5338782D6D;
	Wed,  8 May 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMeOaKTw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4D824AF;
	Wed,  8 May 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167829; cv=none; b=fnCtXrBGhnf7PO6UnBHmyzU0Kj2jpGyOK+x64HeDhOXjPCMFr2URd65zYklU+SgPPDPr3cwdpmpV7n1Rm0VWh5LZ3QH4EX0pgcYCj8m+QX+Txd3ZcxrtHnyszkHSMaF/W02w3mb1axbzPGhCr/46iB0aMhLP6N5qgIsLcS2EpBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167829; c=relaxed/simple;
	bh=JplgA3sOoAVitsl+Ba7UDOQPODwGUUkz1NsrTl0hLEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e/9cZzhvFXZswC46J5bnATK7KPQHLDcJTuobPViwT9zUBsu91eaVXsVa25cV3EdFzLP092s+D4gSD21WKmbHtyYvxVJuryods60JRhbSRIZKJBWkQ8ko0in9GnxUXjX/9c3B2qT6/X0t3FcLcRNXueJ+6WLqiyPM0bxhutLKQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMeOaKTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B95A4C4DDE7;
	Wed,  8 May 2024 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715167828;
	bh=JplgA3sOoAVitsl+Ba7UDOQPODwGUUkz1NsrTl0hLEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XMeOaKTw9qZBqxZJ1u1IXitPaUkLmyrU0U/oIhNh+zqMJ8Ej1iXUrlODKuPia5MoT
	 w8eCFCwo8PK7Bx+zp8M0EQiFSTCrzXoym8dcwMjyz2QVdv4gsLnbBY3EDvXmDFWelW
	 sd3OshvIAUZR+UnjUKlFbW/WcOkYNG1X5l09kDRB6TA34D8o8F9hjuewZ62TTdav0s
	 bDqhe0gdgcpxopBk0AhvfkcJoVmyqyEPISfcV5b96CBJ/D4wyR7UNkbbRECBCFr5o6
	 FxJiw3ogarNXW5L/zjGy0eJ/fT4fyJyJUFb1kn6ecauyedcFBclRK6cJph2ECebEuF
	 UpkgXsOruEK4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A74A9C54BB0;
	Wed,  8 May 2024 11:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: stmmac: dwmac-ipq806x: account for
 rgmii-txid/rxid/id phy-mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171516782868.10113.14186792810495215260.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 11:30:28 +0000
References: <20240506123248.17740-1-ansuelsmth@gmail.com>
In-Reply-To: <20240506123248.17740-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  6 May 2024 14:32:46 +0200 you wrote:
> Currently the ipq806x dwmac driver is almost always used attached to the
> CPU port of a switch and phy-mode was always set to "rgmii" or "sgmii".
> 
> Some device came up with a special configuration where the PHY is
> directly attached to the GMAC port and in those case phy-mode needs to
> be set to "rgmii-id" to make the PHY correctly work and receive packets.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: dwmac-ipq806x: account for rgmii-txid/rxid/id phy-mode
    https://git.kernel.org/netdev/net-next/c/abb45a2477f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



