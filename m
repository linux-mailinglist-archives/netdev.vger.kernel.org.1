Return-Path: <netdev+bounces-23843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C0D76DD8C
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 03:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C95E281D6B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 01:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D6C4C69;
	Thu,  3 Aug 2023 01:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674C7F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAEC5C433C9;
	Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691027425;
	bh=TMmuxpQZ2+VhmgcxbFZ8sMilyWCb56CyDDsFwvXvYmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iJiGpTayK2Gneo/DIaSUloHeEtWiYpzeUWuwvdEIhv+ZnlANkmbc7IcPUFrZEIcsU
	 DmuxSneEciw1sBSB3t7B5eYPOHCieGL1/Y8FOoZPLXOZVC2YwXu8S3kz8Q+QhKe0uW
	 Rw1vUnxkk9Xg+5S+nVrmPvAcb6iz5fGyF7PFfFsnynkfRaQ7C4c1Rp2YZlvRje/Tpz
	 Gu7IeFPKZnATTDCTeekXsvGCqk87Zmi1497w0o9zN8drS7ynsd9YEzsFG7gSs6vqiP
	 e4hHNKQ+F3xaxuKWPkqEApvHuS9370egCDYG5fWIYNfzp09uwsKKKv5wkw2E5pdHiB
	 CCuDLKU8rhs7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A03FFE270D7;
	Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169102742565.3352.5989101215364344178.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 01:50:25 +0000
References: <20230731141030.32772-1-yuehaibing@huawei.com>
In-Reply-To: <20230731141030.32772-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 22:10:30 +0800 you wrote:
> These declarations are never implemented since beginning of git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/sctp/sm.h      | 3 ---
>  include/net/sctp/structs.h | 2 --
>  2 files changed, 5 deletions(-)

Here is the summary with links:
  - [net-next] sctp: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/49c467dca39d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



