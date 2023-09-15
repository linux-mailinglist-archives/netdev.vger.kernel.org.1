Return-Path: <netdev+bounces-34009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C921A7A166E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 08:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DDA1C209A3
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 06:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0441963A2;
	Fri, 15 Sep 2023 06:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA616123
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 06:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C71F8C433C9;
	Fri, 15 Sep 2023 06:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694760623;
	bh=ObWNuq8koaE1gLyiliRm7muB6+RXph5Nc8rKBgICxI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VQv6+08CmRTeI9hXC14excCQBIN4tHLDhYrHU1CIhHYNgeziqhlzFqzLpMC6Ot7ME
	 cR9HAcRWGGmo8UIX+HkhsG9ut2ORYRETx1hQw3FvslH9Ov+4sEzctVXBw/kY+AQk1k
	 BsSuZt+IJ3Hnv2Ng1Tz1If+0PzUQeLtUXtnVO8qjhDCpK4eTgKZOcA41XBrmcZ/DcV
	 2d/qYzeDwlivIxAG1rO+5S5vuzsLuK3c+h5H9xEHex2yYR6L1Ril5xwPlthnLt5zsL
	 3syRI+vNyOIVI5U7+CtlkMICx2hntIgopl2fbD4OawwXBB7eptTA9qhnRZQejRRY6O
	 lpmOwqBbZBFPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABC82E22AEE;
	Fri, 15 Sep 2023 06:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: tls: swap the TX and RX sockets in some tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169476062369.6309.9489492222022024788.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 06:50:23 +0000
References: <aae431141a7c5e143af5339e6aa80cb6cd3087b9.1694443646.git.sd@queasysnail.net>
In-Reply-To: <aae431141a7c5e143af5339e6aa80cb6cd3087b9.1694443646.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, shuah@kernel.org,
 davejwatson@fb.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 12 Sep 2023 16:16:25 +0200 you wrote:
> tls.sendmsg_large and tls.sendmsg_multiple are trying to send through
> the self->cfd socket (only configured with TLS_RX) and to receive through
> the self->fd socket (only configured with TLS_TX), so they're not using
> kTLS at all. Swap the sockets.
> 
> Fixes: 7f657d5bf507 ("selftests: tls: add selftests for TLS sockets")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> [...]

Here is the summary with links:
  - [net] selftests: tls: swap the TX and RX sockets in some tests
    https://git.kernel.org/netdev/net/c/c326ca98446e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



