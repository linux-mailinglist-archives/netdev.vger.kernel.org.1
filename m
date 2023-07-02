Return-Path: <netdev+bounces-15001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D65744E34
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 16:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F101C2089A
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C57117C9;
	Sun,  2 Jul 2023 14:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC01FCF
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 14:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50279C433C7;
	Sun,  2 Jul 2023 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688309422;
	bh=X23+jQiYYimq1cCzLMx+0wCOHKPJuBYY/r5BZRqa9tc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fzUvKfG3GjFzQ8/ZjjBMFiXOCPLkot+soJ2jBUcBZc5wSYJMu1+xWeWXkrNzenfa+
	 Smnpj2x54ybHGJP4ZD9ecEznFEdLAGAVe6SzjZCb0LX6o2QAE7lE0JL33jme4Pf3I1
	 G2LmuxSfbingTQktscFjnqwStBXGm4VjA5mTTbPIu3AS7brisYZkKnl7u1Rw6/UyfU
	 lsUKARnpITZ6onLWBTpmOb9rslQ5da1olJYl8SZK0EVpX04ZZrnElVkG3KylWmpvqf
	 dFacIi1UX6GarQ5cwn+SSawzTOGmb9U1utjE+lmAxN3P9Dyipdc6kGs2ZD20BHauD3
	 LhEYltLGgA+Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20B17C0C40E;
	Sun,  2 Jul 2023 14:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patch 0/4] octeontx2-af: MAC block fixes for CN10KB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168830942212.27441.10283621538831195797.git-patchwork-notify@kernel.org>
Date: Sun, 02 Jul 2023 14:50:22 +0000
References: <20230630062845.26606-1-hkelam@marvell.com>
In-Reply-To: <20230630062845.26606-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, sbhatta@marvell.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 30 Jun 2023 11:58:41 +0530 you wrote:
> This patch set contains fixes for the issues encountered in testing
> CN10KB MAC block RPM_USX.
> 
> Patch1: firmware to kernel communication is not working due to wrong
>         interrupt configuration. CSR addresses are corrected.
> 
> Patch2: NIX to RVU PF mapping errors encountered due to wrong firmware
>         config. Corrects this mapping error.
> 
> [...]

Here is the summary with links:
  - [net,1/4] octeontx2-af: cn10kb: fix interrupt csr addresses
    https://git.kernel.org/netdev/net/c/4c5a331cacda
  - [net,2/4] octeontx2-af: Fix mapping for NIX block from CGX connection
    https://git.kernel.org/netdev/net/c/2e7bc57b976b
  - [net,3/4] octeontx2-af: Add validation before accessing cgx and lmac
    https://git.kernel.org/netdev/net/c/79ebb53772c9
  - [net,4/4] octeontx2-af: Reset MAC features in FLR
    https://git.kernel.org/netdev/net/c/2e3e94c2f5dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



