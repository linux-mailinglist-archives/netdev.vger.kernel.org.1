Return-Path: <netdev+bounces-17084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF297502D7
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3EB1C20F5A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 09:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0F21F948;
	Wed, 12 Jul 2023 09:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171133F9
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B844C433C7;
	Wed, 12 Jul 2023 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689153621;
	bh=Ex71MzvqnoPSUmJRcXm5WZyi4T6gvlCMkVAhvg0LzGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P2zHdNl2EydNK3q5sGc+nCH2LtNPsa7JIIjoTAxTlKKh7qQ07gNuX6wUisB9DoVQl
	 ENjdh05laikc2HkDUjtU7cMbtKj7eEQ9uqVDmfk5khfmej5ymKVwe/u0C9BaK4yAHb
	 oUD6ujNzjFukKAZgg9IcurQYyyPx78FEKUsaDX/q90pS3f9EpBA5TnZ7RfdrvZrGYh
	 M9bZqdA3aBKhP1bLtCyGjciDzFohNdIJO7ZPKYpeHQ1kaSvI3tyBJWwfPUhkcnsTk1
	 hI89322GvO7MdbIPsy4Gi2916nDEb2ydr8eVbynXyDDuoLMz91KWazPkk620WNtl/G
	 +4jUjPfrA1mEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47AD5E29F44;
	Wed, 12 Jul 2023 09:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: stmmac: dwmac-qcom-ethqos: Improve error
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168915362128.1981.13684727730813685010.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 09:20:21 +0000
References: <20230710201636.200412-1-ahalaney@redhat.com>
In-Reply-To: <20230710201636.200412-1-ahalaney@redhat.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
 alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
 bhupesh.sharma@linaro.org, vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
 andrew@lunn.ch, simon.horman@corigine.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 10 Jul 2023 15:06:36 -0500 you wrote:
> This series includes some very minor quality of life patches in the
> error handling.
> 
> I recently ran into a few issues where these patches would have made my
> life easier (messing with the devicetree, dependent driver of this
> failing, and incorrect kernel configs resulting in this driver not
> probing).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: stmmac: dwmac-qcom-ethqos: Use of_get_phy_mode() over device_get_phy_mode()
    https://git.kernel.org/netdev/net-next/c/a8aa20a64ef2
  - [net-next,v2,2/3] net: stmmac: dwmac-qcom-ethqos: Use dev_err_probe()
    https://git.kernel.org/netdev/net-next/c/b2f3d915b4fe
  - [net-next,v2,3/3] net: stmmac: dwmac-qcom-ethqos: Log more errors in probe
    https://git.kernel.org/netdev/net-next/c/27381e72a2db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



