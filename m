Return-Path: <netdev+bounces-27990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E63377DD23
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6611C20F78
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60926DDB0;
	Wed, 16 Aug 2023 09:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE67D2EE
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20D6EC433C9;
	Wed, 16 Aug 2023 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692177621;
	bh=C8Cko0gB8VOSgGW8TTwYrrIY3336Zh/1YLWFap7N4iw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TVpW8WYT7ZLj+7anVOeV/tGv6Ox32oXOQnlXB9q2Cpx5AAgEE2mldfBbY4nYT8AHi
	 8kfLgNw2kCbn7aa3/X+So2gA59ou+vFM6dQdMyeSyT/uccS95ertkwNrLYh/dbrQ5Q
	 1Ah044PRn2oyTziJ3ifqmmrRC2sJE0CCkt70+ViNagon6MkEjqwjSH0cTLfE6plXYh
	 zl1DqahDHvKzseuD+cxB7PFqfX6ZxEu2NLrQ0woawvM1+PHOoKjzhPjp/Z8TfAjLoG
	 28CXqnRju1ksG5w5BjUTwzORji5Vw5VBelFBHZFQwMFDQLCZ81sBrzgCp7wTF9Sf26
	 eUjVk5HZJir1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3ED4C691E1;
	Wed, 16 Aug 2023 09:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ipv6: fix indentation of a config attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169217762099.18544.12217683284419223694.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 09:20:20 +0000
References: <20230816075606.16377-1-ppandit@redhat.com>
In-Reply-To: <20230816075606.16377-1-ppandit@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 pjp@fedoraproject.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 16 Aug 2023 13:26:06 +0530 you wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Fix indentation of a type attribute of IPV6_VTI config entry.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  net/ipv6/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - ipv6: fix indentation of a config attribute
    https://git.kernel.org/netdev/net/c/b35c968363c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



