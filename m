Return-Path: <netdev+bounces-37619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1297B65B2
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 12FD2282DAE
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DFC154A1;
	Tue,  3 Oct 2023 09:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4992101C2
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E71DC433C9;
	Tue,  3 Oct 2023 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696326025;
	bh=12gCSnqKn73aj9viUz4qLx87jDBGNy+dVTV8JgtT3fQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oiusQRoC+VewIdDAFKNbCnLEld/85AGXxTr/Geia2toyY21cc18leoAkn5Om14MNj
	 uYd0VQ5XEkDIqt92IxH1MofCnzo6nFaST3CyhvyMPSjDDonTuzjsN+uxNi/Ksh8eQU
	 deYCCGe0RAmDPC1UiZJIC2Vd0sXQvcahXtQe+73VtRuyCuHY2A67vAD2LxFauP/OoT
	 xsCP0MLf4g4s+b+PpXtNLQfQxcXt0plwRb/JKdWNOZVo2bTX0nZ+np3Mn8KFLGqYiW
	 7KHxP87Q3cXYx7ePEJqg/A+zV/bsII4tS9TQ1tdeUejr0oU+GCFYPZeMuP3UYghMvh
	 n8gqhzhbZ6NlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DA3CE632D2;
	Tue,  3 Oct 2023 09:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] tcp_metrics: four fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169632602524.26043.16439821046036111650.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 09:40:25 +0000
References: <20230922220356.3739090-1-edumazet@google.com>
In-Reply-To: <20230922220356.3739090-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, ycheng@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 Sep 2023 22:03:52 +0000 you wrote:
> Looking at an inconclusive syzbot report, I was surprised
> to see that tcp_metrics cache on my host was full of
> useless entries, even though I have
> /proc/sys/net/ipv4/tcp_no_metrics_save set to 1.
> 
> While looking more closely I found a total of four issues.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] tcp_metrics: add missing barriers on delete
    https://git.kernel.org/netdev/net-next/c/cbc3a1532228
  - [net-next,2/4] tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()
    https://git.kernel.org/netdev/net-next/c/081480014a64
  - [net-next,3/4] tcp_metrics: do not create an entry from tcp_init_metrics()
    https://git.kernel.org/netdev/net-next/c/a135798e6e20
  - [net-next,4/4] tcp_metrics: optimize tcp_metrics_flush_all()
    https://git.kernel.org/netdev/net-next/c/6532e257aa73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



