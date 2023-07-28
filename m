Return-Path: <netdev+bounces-22426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31A76774F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 23:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CAE1C215D9
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC491BB58;
	Fri, 28 Jul 2023 21:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD88A156C3
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 21:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30ECBC433C9;
	Fri, 28 Jul 2023 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690578022;
	bh=BLuO9fxyb5nfsuBnY5gEGpyat676kpp+V/xinZWSiHM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eS4K4QLeoMRUwslZYdbKZBqypshcI6n5pZSkh9Bn/9DE2KQV5RtvX1zTI7W38seGi
	 zH1gsfGax0ApM+7GIrAq6O9JbGQaMMniLxRKACoY6igdo09AGXE6poM6VwgfAUpU6P
	 /3eM5Tq7aKhPYhmncXCF+4iMEPzZTPdcsjzHnX8wOWZw/uLT8ZY3X+gt6vVgVSWYAb
	 0PUGEmwD1jq/sjkO70o9KtR4z409MFEZ4rOK35ouXmu1aXdB1YJ2bT+Neb74gIeqXW
	 JjazlIxCFQjXnBVl4/BHNxRxrqjwCIztdRCUgy2J8tFhoUtV9CUZW/O/Zqjfbt75bm
	 F3g5Y+ELr+nHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C718C39562;
	Fri, 28 Jul 2023 21:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] eth: bnxt: fix a couple of W=1 C=1 warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169057802204.29684.265732152415108009.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 21:00:22 +0000
References: <20230727190726.1859515-1-kuba@kernel.org>
In-Reply-To: <20230727190726.1859515-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jul 2023 12:07:24 -0700 you wrote:
> Fix a couple of build warnings.
> 
> Jakub Kicinski (2):
>   eth: bnxt: fix one of the W=1 warnings about fortified memcpy()
>   eth: bnxt: fix warning for define in struct_group
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c | 2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next,1/2] eth: bnxt: fix one of the W=1 warnings about fortified memcpy()
    https://git.kernel.org/netdev/net-next/c/833c4a8105ac
  - [net-next,2/2] eth: bnxt: fix warning for define in struct_group
    https://git.kernel.org/netdev/net-next/c/9f49db62f58e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



