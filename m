Return-Path: <netdev+bounces-62225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1928264A7
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 16:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CF61C21064
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689A134D3;
	Sun,  7 Jan 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8dEoeR6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD5134CB
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 223BEC43391;
	Sun,  7 Jan 2024 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704640822;
	bh=lEdCqy6sAGSqHU+hVTx75IW3a0MHqUXYtm66ZoUaFQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h8dEoeR6plr9E73kgAYjkUZEREzZpXW5LAxvtQbFIsZ0+Fe1k9YmiwxMAl0fRsfDv
	 ekk7cOLI3k4gjdobjTGfWfJDtl4y+H4CnsH8JtW9dfIWjOWoGKu+hOJZU+9kB5cmcw
	 bpj86kPA1UPAYXDsYPrLfgkzK52eyAjVaQm6VCZ91w5W+iBH9BWKbeRFrIgsXRTTRl
	 z/cN6AaywYgN4zWIW8pzK/rwF1uj9FJi0P/+kJ8c8T5MdqdW3UPgVgo5rDXxe2URWc
	 E+pbW4L+tXCkepJxK+N1365KaQA4hPs6rFQO6duNDX7PmPaMyke4agGj5XnwzF5evt
	 1hkxS/jU+iPbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C076C4167E;
	Sun,  7 Jan 2024 15:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] fib: rules: remove repeated assignment in
 fib_nl2rule
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170464082204.11926.12917378889092577923.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 15:20:22 +0000
References: <20240105065634.529045-1-shaozhengchao@huawei.com>
In-Reply-To: <20240105065634.529045-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 5 Jan 2024 14:56:34 +0800 you wrote:
> In fib_nl2rule(), 'err' variable has been set to -EINVAL during
> declaration, and no need to set the 'err' variable to -EINVAL again.
> So, remove it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  net/core/fib_rules.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] fib: rules: remove repeated assignment in fib_nl2rule
    https://git.kernel.org/netdev/net-next/c/c4a5ee9c09aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



