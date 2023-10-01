Return-Path: <netdev+bounces-37299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B367B493D
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 20:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 9CF89B208F9
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A63EED3;
	Sun,  1 Oct 2023 18:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF6944D
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 18:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 663FEC433C7;
	Sun,  1 Oct 2023 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696185625;
	bh=PWCNXHuvuTJjFY0Ik8yvE3vODJwezAgpe2yQ+TFEW9A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qo1VrCUlzRY5PSAcPbilPZokdnlkLNCGItCTNRWANcLkNV51KiD6+SXTyw+oqcZwj
	 seRPaZNfcFtkS+YIQcfKt99O6Q17jksgbCie09f8LTbrjLIL70ALmyWyAJLBVU1Pbj
	 tcbonfxsrpzHuHZ7y5lHlh4Rg6sK5aMt39BUR9+pLakjhWOvdU3I+YTqqc+GM4vrue
	 uZvdhJIonTFy1zI3BZN/B+J2tP/QXxvViSIqSx8zvI6tEN/PcmZR1Ua7EF6KmHUQlJ
	 huNJG/YPnjX6agR4qJuPKRCZZo62g7NdLKnTMMQQjxFN6gIJQuFvu/lK5Kxr4Oj3jG
	 4y8x+1TGNahig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41015C395C5;
	Sun,  1 Oct 2023 18:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 1/3] net: replace calls to sock->ops->connect() with
 kernel_connect()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169618562525.20334.9043221644649917375.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 18:40:25 +0000
References: <20230921234642.1111903-1-jrife@google.com>
In-Reply-To: <20230921234642.1111903-1-jrife@google.com>
To: Jordan Rife <jrife@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 dborkman@kernel.org, horms@verge.net.au, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
 ast@kernel.org, rdna@fb.com, stable@vger.kernel.org, willemb@google.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 18:46:40 -0500 you wrote:
> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
> ensured that kernel_connect() will not overwrite the address parameter
> in cases where BPF connect hooks perform an address rewrite. This change
> replaces direct calls to sock->ops->connect() in net with kernel_connect()
> to make these call safe.
> 
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
> Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> Cc: stable@vger.kernel.org
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jordan Rife <jrife@google.com>
> 
> [...]

Here is the summary with links:
  - [net,v5,1/3] net: replace calls to sock->ops->connect() with kernel_connect()
    https://git.kernel.org/netdev/net/c/26297b4ce1ce
  - [net,v5,2/3] net: prevent rewrite of msg_name in sock_sendmsg()
    https://git.kernel.org/netdev/net/c/86a7e0b69bd5
  - [net,v5,3/3] net: prevent address rewrite in kernel_bind()
    https://git.kernel.org/netdev/net/c/c889a99a21bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



