Return-Path: <netdev+bounces-24805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFEC771BF5
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2A72810A0
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 08:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B99DC2F2;
	Mon,  7 Aug 2023 08:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0F17E3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6315EC433C8;
	Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691395222;
	bh=hBZi8YKviSxwd+u/UhgkENJSF5xyybQlcARmMAbVMbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SN+EfZfNF48tk8MJ88nv+uYyvCa0SXZfW7yTVu5uGhZkN7DN8nWmgdsB6CMaZUXjX
	 zWL3iH2og3tujfMR21HyXZgPjJ2ITpcQnkv8SHZnRljGWYC9WcTnM5IrXAkdedk6yO
	 2pL/aSbteHvu+vYbHGn1bqpwRHXoyHbqUWkge+UJbMNeDU/KvcEwDJgDfBRcclPNEI
	 FYlLUdKIvIeVTieYATsdgqRpCiZbEFPT8zjjS3QH/2WTodOaa+k86xGMwtz3f2ge2+
	 4sc1J9zxM/Ihz7K/o1bJne3wWInHgXaiw1smi99wqOFJ/vdtkqD6vEq8u59/LnRJ5H
	 mkZZPr+2SR1oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42003E505D1;
	Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/tls: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169139522225.32661.1766199176306782363.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 08:00:22 +0000
References: <20230805104811.45356-1-yuehaibing@huawei.com>
In-Reply-To: <20230805104811.45356-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 5 Aug 2023 18:48:11 +0800 you wrote:
> Commit 3c4d7559159b ("tls: kernel TLS support") declared but never implemented
> these functions.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/tls/tls.h | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - [net-next] net/tls: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/f6ecb68b38a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



