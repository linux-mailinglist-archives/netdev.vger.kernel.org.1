Return-Path: <netdev+bounces-51119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8D27F935A
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 16:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8AF280CCD
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 15:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16361D50E;
	Sun, 26 Nov 2023 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAWjUt+l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7BEC2
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 15:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B5B4C433C9;
	Sun, 26 Nov 2023 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701012025;
	bh=1Yjpk/XlMg3yUrAjqYunQcFobxWrEJfJw6zZi/XyttI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uAWjUt+lukTDGTgFbeNonx9pnmkyQsywYxr8em834lTT53jqp38oE72B1awr4Lzgp
	 ePk5pFh2EJU51vpU0TSugembBEesFATEs0P4Oa+TebDqPsN0/F/gXQMIzJP1uivlzJ
	 Waed7KBjzdhOCgNyr1I7Ma15iIVt8KUw2FbUacE/u4o6Fj0IIhVIB2nk15QJPtc4Qy
	 tvcAZVPfoPmSN3c+Vo1+6vhhDDhcAvp3k/Hx0jkm9fIrEaWLRG+FVKG29n5ig06Ilc
	 5lE2f2PDR4M8wX5HUAgR02YSrxAnuvHjo2F44E4g1uOrt5r93RGVFefJ2X+BOGvpil
	 9it33Jn+sq1HQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 424A9EAA958;
	Sun, 26 Nov 2023 15:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] dpaa2-eth: various fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170101202526.2351.10022529620147250038.git-patchwork-notify@kernel.org>
Date: Sun, 26 Nov 2023 15:20:25 +0000
References: <20231124102805.587303-1-ioana.ciornei@nxp.com>
In-Reply-To: <20231124102805.587303-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 24 Nov 2023 12:28:03 +0200 you wrote:
> The first patch fixes a memory corruption issue happening between the Tx
> and Tx confirmation of a packet by making the Tx alignment at 64bytes
> mandatory instead of optional as it was previously.
> 
> The second patch fixes the Rx copybreak code path which recycled the
> initial data buffer before all processing was done on the packet.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] dpaa2-eth: increase the needed headroom to account for alignment
    https://git.kernel.org/netdev/net/c/f422abe3f23d
  - [v2,net,2/2] dpaa2-eth: recycle the RX buffer only after all processing done
    https://git.kernel.org/netdev/net/c/beb1930f966d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



