Return-Path: <netdev+bounces-24064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47BD76EAD0
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DF91C2150B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EB01F18E;
	Thu,  3 Aug 2023 13:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B91F164
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EB20C433C8;
	Thu,  3 Aug 2023 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691070021;
	bh=Ag34fpOs/ZDN8OnIF2XhhMhBUdy+7vBk5TXYmXAFKUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ab0voQdVrt9tWWx/PplP1mNbUQVh4BH54VWsLFyJpENE2P4djMIVVKA4ih3+t0Qob
	 NG2IyY5suZH8gdWCQiRTmhbIFr7IlU6pWJHGUgWrp9E5ba5GcBZlbLtODGwO9VuVlp
	 j/GzI2aUvYT7Dfv3YndR7h0gHv7zjRj5HvfDMaFWHDWS7K6SluVrkb7zmRKPPv9Z3u
	 eXMk6YIm14uYDUCL4xhK7hDwHlATzCDMCwbf3n2zeLTXqbOJZn+Rm67UtWwuXFrW1r
	 oG2ZSBhm5dOWjmmt58laaxJVDAM2dwrstGBs/asLVLq+tC+GBK6YhJLallVFKi4qBr
	 SZsmFLv0FKI2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB740C41620;
	Thu,  3 Aug 2023 13:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/mlx4: Remove many unnecessary NULL values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169107002095.31149.2986339328309539867.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 13:40:20 +0000
References: <20230802040026.2588675-1-ruanjinjie@huawei.com>
In-Reply-To: <20230802040026.2588675-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 2 Aug 2023 12:00:26 +0800 you wrote:
> The NULL initialization of the pointers assigned by kzalloc() first is
> not necessary, because if the kzalloc() failed, the pointers will be
> assigned NULL, otherwise it works as usual. so remove it.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - add the wrong removed NULL hunk code in mlx4_init_hca().
> - update the commit message.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/mlx4: Remove many unnecessary NULL values
    https://git.kernel.org/netdev/net-next/c/3986892646de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



