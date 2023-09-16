Return-Path: <netdev+bounces-34257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFF67A2EFA
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 11:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C76928212A
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1EE12B64;
	Sat, 16 Sep 2023 09:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01967107A7
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 09:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85B35C433C9;
	Sat, 16 Sep 2023 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694856024;
	bh=C4pEbhmdx3omWvkKTyIuqTh824/uMmWj5rsRpOx3Bz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=je61kNqFJ0eQghtNjPOpIzwJxUbMma/R+g4q+bH4bosl6m3Da+XMKiteDDC6nl4Xw
	 NR7Aih3ynTNceWJKqgtcUiwe8H7+qo87iWg8i5bzHUu5yttLk+rJYkdY4xOlrbtuka
	 miYmVQUgfnx5Q6ULXadTv8dGiKfmukfOWxbT3EyzIdunxKLBovhCC9qxzxwpaxvkVn
	 c/BeyIRI/MhrfwCkblQhmZj4f063lOstF9VWE3tQDksZ+tG8+m3eauyehm6FzEsx0Y
	 4vEI+GufLK15jAO1gq0n9j7/eFwuFuI2JJ5o99oFN4eomCXv9mIJ7nFxI2t+2ZL+V4
	 HkctkQmBQk3Cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D940E26882;
	Sat, 16 Sep 2023 09:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add truesize debug checks in
 skb_{add|coalesce}_rx_frag()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169485602444.26566.4463921141418141011.git-patchwork-notify@kernel.org>
Date: Sat, 16 Sep 2023 09:20:24 +0000
References: <20230913134841.3672509-1-edumazet@google.com>
In-Reply-To: <20230913134841.3672509-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Sep 2023 13:48:41 +0000 you wrote:
> It can be time consuming to track driver bugs, that might be detected
> too late from this confusing warning in skb_try_coalesce()
> 
> 	WARN_ON_ONCE(delta < len);
> 
> Add sanity check in skb_add_rx_frag() and skb_coalesce_rx_frag()
> to better track bug origin for CONFIG_DEBUG_NET=y builds.
> 
> [...]

Here is the summary with links:
  - [net-next] net: add truesize debug checks in skb_{add|coalesce}_rx_frag()
    https://git.kernel.org/netdev/net-next/c/c123e0d30bdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



