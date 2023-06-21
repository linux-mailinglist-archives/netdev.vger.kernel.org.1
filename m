Return-Path: <netdev+bounces-12460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 788D57379D0
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F711C20DB9
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26FA17EF;
	Wed, 21 Jun 2023 03:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F123AA
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39AFCC433CD;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687318822;
	bh=n7YDp81aRWowmsTNymFRUrAAIAZ3gde9nayJmXXBAiU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S1J5fp9lzq6jqSG5No0/nxUTDa8ujViXcQEJ1cEd1jdhQsQKP48b1eXnIXB9Vi1Sk
	 /P1lFml5RkfNoR65ZGE39/BTiY1u39+MQetFGl5DHvpwPDU0eHZgsWG20WkL9r7TD7
	 N0TIRG9iH/ajvl2e8Gu0t/czHTDxeMuvQQWe06dko4GCLjlnvOr+M3XdTU+jNssmHu
	 qTdDOQRZwUhrrO+lDpkorQAoZnOPSEkTzGB6ZaPvhG5KUpWMJ5Kcgfr55d5dtN3RGe
	 waG9QNCAgkwAS2tp0QK7cTkMPytUoNOsBbMazNN/cNwK20iKFHaiXRwnq3rlQ8N7NL
	 FAziqBphSCZ4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C872E21EDF;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove sk_is_ipmr() and sk_is_icmpv6() helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168731882210.8371.9465260672898488740.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 03:40:22 +0000
References: <20230619124336.651528-1-edumazet@google.com>
In-Reply-To: <20230619124336.651528-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 leitao@debian.org, willemb@google.com, dsahern@kernel.org, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 12:43:35 +0000 you wrote:
> Blamed commit added these helpers for sake of detecting RAW
> sockets specific ioctl.
> 
> syzbot complained about it [1].
> 
> Issue here is that RAW sockets could pretend there was no need
> to call ipmr_sk_ioctl()
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove sk_is_ipmr() and sk_is_icmpv6() helpers
    https://git.kernel.org/netdev/net-next/c/634236b34d7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



