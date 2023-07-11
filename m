Return-Path: <netdev+bounces-16810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3122174EC22
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6273B1C20D0D
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FBD182BF;
	Tue, 11 Jul 2023 11:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C2418AE0
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 11:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA507C433C7;
	Tue, 11 Jul 2023 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689073220;
	bh=6YYe+AM3PENlhMrs43LHH3XDqNI7URfdzWV63NIQAFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eEWrEcHNb0dRGg5s4NUuQjPGRKN4i/ciaEA2TkEHO+xtm5M4382qGBEmsQg6gEgsl
	 x1ng2O7qlqqnzE80GXtOyhdxUyIZyorTIEYZfkwkwwg5qHH2tD4QC8H7E4m+QAlX98
	 ondbqZTI5jXfdsaVinjT+hbBVZZPgXIKkcNRnpAga/BUSlI5pU90Kv06HSoj6J/xEm
	 Ii/JJfdxPazYL3yyO2MzlDsbu1Q99/sC4ulTp7jlO6Ky3PotEBgjVu3hq+EbcGByXE
	 mkNY2rnX3hEarQav+ajs17HIk8OPVkjltPCQr5ay3qDBV1bMLit9vGkCJG5rknkyWq
	 SR/Cv8xPXEBHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7106C4167B;
	Tue, 11 Jul 2023 11:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next][resend v1 1/2] net/core: Make use of assign_bit()
 API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168907322073.9631.16368266166641321480.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jul 2023 11:00:20 +0000
References: <20230710100830.89936-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230710100830.89936-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 brauner@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Jul 2023 13:08:29 +0300 you wrote:
> We have for some time the assign_bit() API to replace open coded
> 
> 	if (foo)
> 		set_bit(n, bar);
> 	else
> 		clear_bit(n, bar);
> 
> [...]

Here is the summary with links:
  - [net-next,resend,v1,1/2] net/core: Make use of assign_bit() API
    https://git.kernel.org/netdev/net-next/c/274c4a6d529c
  - [net-next,resend,v1,2/2] netlink: Make use of __assign_bit() API
    https://git.kernel.org/netdev/net-next/c/b8e39b38487e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



