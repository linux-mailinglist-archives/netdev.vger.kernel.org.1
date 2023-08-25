Return-Path: <netdev+bounces-30611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA48F78831D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 11:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1791D1C2091B
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841D0C8E1;
	Fri, 25 Aug 2023 09:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32EFC2D6
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 09:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A4DDC43395;
	Fri, 25 Aug 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692954622;
	bh=ayQFeULtvaJ26zGbRRHB3ZHj4umKdAVnrBX2etc2KMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oLZ2Zc2SF1Yl0cap4gb1Rd2G8PkxwSUBgO3IxRiSP7JNZntxLn1TWVGP+8bfU7Z/P
	 X7OoV02RqkRfYTiQ3LoCNsoOcdTJhXScoFPKtBpSUfk2fVqbK/LRZF2LSxW5xO3FpD
	 nJgxrfVMutC3HJid7uE+Kxk9TnQkVJnTVYCTdufYIm5GGNqLDPs8CwTEMNnNiTcB4i
	 vitL8CsVXiRKIfBXZM1HUbISogVBae3kcV8JuN0mc+PaNgMSZHxGnGNdzXFtCst87d
	 bV7TlfpvnL6RHM9feBNpm+tS7GQqHsYhbyhy5S8h18YuOAHq0ZL5mh5c/h3SmxuOAL
	 zci0+cyTAbNXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41205E33083;
	Fri, 25 Aug 2023 09:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fec: add statistics for XDP_TX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169295462226.4538.9021625369477551979.git-patchwork-notify@kernel.org>
Date: Fri, 25 Aug 2023 09:10:22 +0000
References: <20230824061150.638251-1-wei.fang@nxp.com>
In-Reply-To: <20230824061150.638251-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Aug 2023 14:11:50 +0800 you wrote:
> The FEC driver supports the statistics for XDP actions except for
> XDP_TX before, because the XDP_TX was not supported when adding
> the statistics for XDP. Now the FEC driver has supported XDP_TX
> since commit f601899e4321 ("net: fec: add XDP_TX feature support").
> So it's reasonable and necessary to add statistics for XDP_TX.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: fec: add statistics for XDP_TX
    https://git.kernel.org/netdev/net-next/c/9540329452b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



