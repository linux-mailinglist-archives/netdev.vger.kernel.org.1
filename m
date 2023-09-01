Return-Path: <netdev+bounces-31684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E4D78F891
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 08:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29811C20B9C
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 06:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D1E5C98;
	Fri,  1 Sep 2023 06:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D00947B
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 06:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5A38C433C8;
	Fri,  1 Sep 2023 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693549825;
	bh=h/l8lBr50ywcyqBADBBaHxUsxWOv7N0ZPFCJ+r8NFUI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iHltdhV7mMDOJrFXyTjCAfVelSB2DHDrM6CN5HKtkAhnrav6pyDOyG5nQNSTqs5Yt
	 CiDh8ugzMk7+euF5B9ktmIZLZj7gwFhGbeMBuv+lYssYQHDptqepVMlYfAsUBoYHa2
	 LE50h3KalIgktp1lluWEmulYkGMQPoEDp9219RPq1D1AKOBWGbYjJ+WvZn8Zn0DuQC
	 v84xB3KE2DqWmQW+paKJqte3cbgLZWob5MI8F3/a4kjPcoHAU5j3f5Qqs2LqrjTsbs
	 7h9jXMaOl/0NEqmJ3WwlFRmtphwN12GUAH4cxnIRTtqBejtsrm9TfFrD5t/uElEytE
	 KCnUJt/gWZ7Zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B42BE29F3C;
	Fri,  1 Sep 2023 06:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] net: another round of data-race annotations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169354982556.31046.11317171090973408692.git-patchwork-notify@kernel.org>
Date: Fri, 01 Sep 2023 06:30:25 +0000
References: <20230831135212.2615985-1-edumazet@google.com>
In-Reply-To: <20230831135212.2615985-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 31 Aug 2023 13:52:07 +0000 you wrote:
> Series inspired by some syzbot reports, taking care
> of 4 socket fields that can be read locklessly.
> 
> Eric Dumazet (5):
>   net: use sk_forward_alloc_get() in sk_get_meminfo()
>   net: annotate data-races around sk->sk_forward_alloc
>   mptcp: annotate data-races around msk->rmem_fwd_alloc
>   net: annotate data-races around sk->sk_tsflags
>   net: annotate data-races around sk->sk_bind_phc
> 
> [...]

Here is the summary with links:
  - [net,1/5] net: use sk_forward_alloc_get() in sk_get_meminfo()
    https://git.kernel.org/netdev/net/c/66d58f046c9d
  - [net,2/5] net: annotate data-races around sk->sk_forward_alloc
    https://git.kernel.org/netdev/net/c/5e6300e7b3a4
  - [net,3/5] mptcp: annotate data-races around msk->rmem_fwd_alloc
    https://git.kernel.org/netdev/net/c/9531e4a83feb
  - [net,4/5] net: annotate data-races around sk->sk_tsflags
    https://git.kernel.org/netdev/net/c/e3390b30a5df
  - [net,5/5] net: annotate data-races around sk->sk_bind_phc
    https://git.kernel.org/netdev/net/c/251cd405a9e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



