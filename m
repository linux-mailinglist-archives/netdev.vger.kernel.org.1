Return-Path: <netdev+bounces-24698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653E77713DA
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 09:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9474C1C20978
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 07:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BAC23C0;
	Sun,  6 Aug 2023 07:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4C1FAF
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 07:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCE04C433C8;
	Sun,  6 Aug 2023 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691307620;
	bh=zZwpzV2jlAHuJWnIJmHiYcdZl+PjEX3L9XiITuuNmqY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cXhFApz8YEC3p6aXwVhSNgzzlWNlDu/7URSvULTIPNBAC5cJQsSTGPoL9+RFMPdaY
	 3kVAXN8OpcOm4X1xby+qJhyWCQb9Md38uvTf0JHJAwqAMfqdb+F6POCczmKnKYhWyC
	 fKmMaLfAWVmwefF0nzXSH9JaTfKzipE1NBDuSAL2JfaPnTwNNvCOjHAcGhLTAuwilM
	 gkrYIwXt00xQpgGUhWTBxTa2eoKQQ23hkLO+A9h/QGJFgCPJjXigMBkkss2/QKxHHl
	 1w4qb1i44sENZ7LbEHnabvEYBFJbm82RvSZcc9cnLqChq6hiDHWMzB+JIrzYclSjyP
	 6b6MNripbEgZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA6EAC691EF;
	Sun,  6 Aug 2023 07:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: tls: avoid discarding data on record close
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169130762076.9536.15325494811725831048.git-patchwork-notify@kernel.org>
Date: Sun, 06 Aug 2023 07:40:20 +0000
References: <20230804225951.754789-1-kuba@kernel.org>
In-Reply-To: <20230804225951.754789-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, borisp@nvidia.com, john.fastabend@gmail.com,
 dirk.vandermerwe@netronome.com, tariqt@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  4 Aug 2023 15:59:51 -0700 you wrote:
> TLS records end with a 16B tag. For TLS device offload we only
> need to make space for this tag in the stream, the device will
> generate and replace it with the actual calculated tag.
> 
> Long time ago the code would just re-reference the head frag
> which mostly worked but was suboptimal because it prevented TCP
> from combining the record into a single skb frag. I'm not sure
> if it was correct as the first frag may be shorter than the tag.
> 
> [...]

Here is the summary with links:
  - [net] net: tls: avoid discarding data on record close
    https://git.kernel.org/netdev/net/c/6b47808f223c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



