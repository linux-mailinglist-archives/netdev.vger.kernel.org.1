Return-Path: <netdev+bounces-38159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670167B994D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D612E281A23
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE9A4C;
	Thu,  5 Oct 2023 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKDtNREQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550CF374
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCF8BC433C8;
	Thu,  5 Oct 2023 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696466427;
	bh=GurQxuIsxPqA7aUBoeYQZ/c+GTIWGiw7bAc0qNwQJJc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IKDtNREQOHWiCFEv/rxEPHxMVZs576br6eANNosTQ2xxEScOudV3FtdzY7km5LCka
	 u1nuTyN6MSu5psose10mBBmJHXmZMwfUPG1V4ND857egNstrGKzNDVbYBq63AFh814
	 g4m+PhY6KC9CbU7v8ymmNCOxxRwBC7hGdbuHYh03oUUymmiM+eueNAbUZuGlD0FUJp
	 /NgelFbI2l3LXq2UplwQY7MKgCiwugXNVYSTPD4vXN1/OY+c9wgiteg2EpmTRU8ytg
	 wkDvVhIwEnnXI0bMtJzbQLCBAEo5NEjx23JiJwftrahon7r13zCb7dgAwlFVCmsiMk
	 rCqctjSwin1GQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3A59E632D6;
	Thu,  5 Oct 2023 00:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: update hb timer immediately after users change
 hb_interval
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169646642773.7507.5611400283325453928.git-patchwork-notify@kernel.org>
Date: Thu, 05 Oct 2023 00:40:27 +0000
References: <75465785f8ee5df2fb3acdca9b8fafdc18984098.1696172660.git.lucien.xin@gmail.com>
In-Reply-To: <75465785f8ee5df2fb3acdca9b8fafdc18984098.1696172660.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 marcelo.leitner@gmail.com, xufeng.zhang@windriver.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Oct 2023 11:04:20 -0400 you wrote:
> Currently, when hb_interval is changed by users, it won't take effect
> until the next expiry of hb timer. As the default value is 30s, users
> have to wait up to 30s to wait its hb_interval update to work.
> 
> This becomes pretty bad in containers where a much smaller value is
> usually set on hb_interval. This patch improves it by resetting the
> hb timer immediately once the value of hb_interval is updated by users.
> 
> [...]

Here is the summary with links:
  - [net] sctp: update hb timer immediately after users change hb_interval
    https://git.kernel.org/netdev/net/c/1f4e803cd9c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



