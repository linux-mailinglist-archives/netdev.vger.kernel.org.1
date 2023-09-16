Return-Path: <netdev+bounces-34283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693AA7A303F
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 14:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FAF281B06
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9A813AE6;
	Sat, 16 Sep 2023 12:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CCE13AE4
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 12:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37407C433C7;
	Sat, 16 Sep 2023 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694868025;
	bh=Fd4tUJbFTpDAZubkZ/meNJh/ivkIu+elL/akclFttKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bSs26kuHIQD1AojR3LIImDlyvHQGR/YZXkCchaxihMuN66hFkEKA4qNvzPyAN+oGX
	 bi7n6xGwk+rGAV0XTnLUtaZ9NTrlPPBmgekFzvetXzphqYcakuwLuS8fqTXVq+JZdK
	 ozyKgcdk24di0JSvEPB2qCSbqCCroAZ5Z/uYBk9ZVfgtqxMKdifYQNX9UwrIVxwdNc
	 +HqPG6xrRj9nFCbiTyxwJ06noBUpNiauUDkhZNV2vCtMbgx+4rv+rV3C/Rr7hlBo9P
	 7ilL1OECKFwfqjJrlWE+uP0jf7Tknp3E2yUtqEIjl5fL1Kq9qBSEYTqIQEevFbMxDY
	 KnXfIpb3DPWkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D355E26887;
	Sat, 16 Sep 2023 12:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] net: core: Use the bitmap API to allocate bitmaps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169486802511.24089.3642450792901329099.git-patchwork-notify@kernel.org>
Date: Sat, 16 Sep 2023 12:40:25 +0000
References: <20230913110957.485237-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230913110957.485237-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Sep 2023 14:09:57 +0300 you wrote:
> Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> It is less verbose and it improves the type checking and semantic.
> 
> While at it, add missing header inclusion (should be bitops.h,
> but with the above change it becomes bitmap.h).
> 
> Suggested-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/r/20230911154534.4174265-1-andriy.shevchenko@linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/1] net: core: Use the bitmap API to allocate bitmaps
    https://git.kernel.org/netdev/net/c/aabb4af9bb29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



