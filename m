Return-Path: <netdev+bounces-17033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634674FDCA
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C7B1C20F37
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E891E2101;
	Wed, 12 Jul 2023 03:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702A52114
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D277EC43397;
	Wed, 12 Jul 2023 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689132623;
	bh=KwsKbTt6v0IR4Q8rP+GR6PnPs+ltgKYK5aPH6kmT3mY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EbfNDU4Kjq7ad5m+ffHoayiS5wV5Tt4yzHx7J8U9u9LrnpHzDtpjcO563TayU3qgj
	 Bt3CtuiirPT2wqoaGzea1AKVAvv5SyNdfoS5IXObkaqpdyk4nqVpRH7zyZWbhYoJZn
	 U3UDojN1IiHA7jgwJ32JriOG62/Hno2e4uCdD4JIUlRscwPD8dSF9aIf5EQ3NwU94A
	 L2cLabV7YJhExZqlyebqjPs+myKvEm9qcXGwuk41TPSDzZgQNq/aO7YrLFl9ixYdO6
	 2yC4WLKCaxQ4gQdRUOb7aBguWEsaKHnH6I3kbBLf0J3ynpfS4U+1KWtHkGtUZNCmQp
	 mOZjyXsDHZoqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5B16E52508;
	Wed, 12 Jul 2023 03:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/8] net: freescale: Convert to platform remove
 callback returning void
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168913262373.27250.8401630436062534160.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 03:30:23 +0000
References: <20230710071946.3470249-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230710071946.3470249-1-u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@codeaurora.org
Cc: madalin.bucur@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com,
 wei.fang@nxp.com, simon.horman@corigine.com, nicolas.ferre@microchip.com,
 mkl@pengutronix.de, michal.kubiak@intel.com, robh@kernel.org,
 pantelis.antoniou@gmail.com, claudiu.manoil@nxp.com, leoyang.li@nxp.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, kernel@pengutronix.de,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, linux-imx@nxp.com,
 sean.anderson@seco.com, linuxppc-dev@lists.ozlabs.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jul 2023 09:19:38 +0200 you wrote:
> Hello,
> 
> v2 of this series was sent in June[1], code changes since then only affect
> patch #1 where the dev_err invocation was adapted to emit the error code of
> dpaa_fq_free(). Thanks for feedback by Maciej Fijalkowski and Russell King.
> Other than that I added Reviewed-by tags for Simon Horman and Wei Fang and
> rebased to v6.5-rc1.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/8] net: dpaa: Improve error reporting
    https://git.kernel.org/netdev/net-next/c/1e679b957ae2
  - [net-next,v3,2/8] net: dpaa: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/9c3ddc44d0c0
  - [net-next,v3,3/8] net: fec: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/12d6cc19f29b
  - [net-next,v3,4/8] net: fman: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/4875b2a362e9
  - [net-next,v3,5/8] net: fs_enet: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/ead29c5e0888
  - [net-next,v3,6/8] net: fsl_pq_mdio: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/f833635589ae
  - [net-next,v3,7/8] net: gianfar: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/4be0ebc33f39
  - [net-next,v3,8/8] net: ucc_geth: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/ae18facf566c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



