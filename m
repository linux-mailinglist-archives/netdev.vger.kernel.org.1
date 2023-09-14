Return-Path: <netdev+bounces-33847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315337A0762
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3B91C20B08
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831F927EDA;
	Thu, 14 Sep 2023 14:30:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326C534CC1
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6ACAC433C9;
	Thu, 14 Sep 2023 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694701829;
	bh=qin1FzLxVYHR2AvImx/4isLUMXJN/Zip+Q7Ps8TUgAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oHHmTwADBJNEgrGojabySSWH2q70pnigUnj7bj7j0H5wFvHat0m3um9ZFhz61xOJf
	 AQVuEKkm7AuQy6xSvpmb86dkT6yRwdRdoSZzeEPmHEdfEZvRxFf3Hq/DQccx89Seku
	 kMlHi6MrwQtNjOBESSB6ZHIGWwB/Jy6rlnogFHIWVf+mRKbINoPCrEmZQ1Ql5KPPmU
	 FTLX5oLLjycHxyaaESP9eaFHIANyI581OKKgEOOttLPOkBWmBYJMoVCLbswr0DUQXa
	 YT2N8aUUYm2Ck+/AqWroBVAIUpGjAFyCRvfnQliJI8gGh5bj+6QMAE3pDch6CoT6bD
	 aAK04rngVz/GA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89326E1C280;
	Thu, 14 Sep 2023 14:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] udp: round of data-races fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169470182955.13548.9023234133181201868.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 14:30:29 +0000
References: <20230912091730.1591459-1-edumazet@google.com>
In-Reply-To: <20230912091730.1591459-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Sep 2023 09:17:20 +0000 you wrote:
> This series is inspired by multiple syzbot reports.
> 
> Many udp fields reads or writes are racy.
> 
> Add a proper udp->udp_flags and move there all
> flags needing atomic safety.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] udp: introduce udp->udp_flags
    https://git.kernel.org/netdev/net-next/c/81b36803ac13
  - [net-next,02/10] udp: move udp->no_check6_tx to udp->udp_flags
    https://git.kernel.org/netdev/net-next/c/a0002127cd74
  - [net-next,03/10] udp: move udp->no_check6_rx to udp->udp_flags
    https://git.kernel.org/netdev/net-next/c/bcbc1b1de884
  - [net-next,04/10] udp: move udp->gro_enabled to udp->udp_flags
    https://git.kernel.org/netdev/net-next/c/e1dc0615c6b0
  - [net-next,05/10] udp: add missing WRITE_ONCE() around up->encap_rcv
    https://git.kernel.org/netdev/net-next/c/6d5a12eb9122
  - [net-next,06/10] udp: move udp->accept_udp_{l4|fraglist} to udp->udp_flags
    https://git.kernel.org/netdev/net-next/c/f5f52f0884a5
  - [net-next,07/10] udp: lockless UDP_ENCAP_L2TPINUDP / UDP_GRO
    https://git.kernel.org/netdev/net-next/c/ac9a7f4ce5dd
  - [net-next,08/10] udp: annotate data-races around udp->encap_type
    https://git.kernel.org/netdev/net-next/c/70a36f571362
  - [net-next,09/10] udplite: remove UDPLITE_BIT
    https://git.kernel.org/netdev/net-next/c/729549aa350c
  - [net-next,10/10] udplite: fix various data-races
    https://git.kernel.org/netdev/net-next/c/882af43a0fc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



