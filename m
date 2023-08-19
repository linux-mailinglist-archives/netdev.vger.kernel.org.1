Return-Path: <netdev+bounces-29090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0678195F
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 13:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8649281B9A
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 11:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB94C8A;
	Sat, 19 Aug 2023 11:51:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E386AA6
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 11:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9FECC433C9;
	Sat, 19 Aug 2023 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692445899;
	bh=TEW/UkmWKofUATAX/yySTM8Wa+yZwEIV33TCwdjld18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tv1lmSO/TVyV1qk+b05FXg51PegCrsqOnON2yZ4OABvEVrcd47XD9jGPml7ZYtQH8
	 0yT/X7t3q1JCfiju9/mxisNUehHccSarNn79ThJhyy9NS69TgSxuRVUi927bfJGEjT
	 B+MZnHOaBW4YfW2vy9Bx0hsHD3nSFF4RZXF3OWXwJok7345WM1VUYeuOdk1h04YVCG
	 Vm8MSpczgIZK50R32kBZ6s7IqdvPQVAksgSYtwfu0EOVCVCIG2xVV/KXMZRX/+ciab
	 v86bGwmj7T2vI0I7WCKUbl4kQpwK02EYL78CnY9NCJ5Q3LtjaUs9WLauHFoed7+rfm
	 163hjsbsHmDlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EC72E1F65A;
	Sat, 19 Aug 2023 11:51:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mdio: mdio-bitbang: Fix C45 read/write protocol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169244589958.30754.16676422230846280985.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 11:51:39 +0000
References: <20230816180656.18780-1-fancer.lancer@gmail.com>
In-Reply-To: <20230816180656.18780-1-fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 geert+renesas@glider.be, michael@walle.cc, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 16 Aug 2023 21:06:52 +0300 you wrote:
> Based on the original code semantic in case of Clause 45 MDIO, the address
> command is supposed to be followed by the command sending the MMD address,
> not the CSR address. The commit 002dd3de097c ("net: mdio: mdio-bitbang:
> Separate C22 and C45 transactions") has erroneously broken that. So most
> likely due to an unfortunate variable name it switched the code to sending
> the CSR address. In our case it caused the protocol malfunction so the
> read operation always failed with the turnaround bit always been driven to
> one by PHY instead of zero. Fix that by getting back the correct
> behaviour: sending MMD address command right after the regular address
> command.
> 
> [...]

Here is the summary with links:
  - [net] net: mdio: mdio-bitbang: Fix C45 read/write protocol
    https://git.kernel.org/netdev/net/c/2572ce62415c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



