Return-Path: <netdev+bounces-20874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6106761A2A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66511C20B9F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEDD1F936;
	Tue, 25 Jul 2023 13:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D18C0A
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D75D0C433C7;
	Tue, 25 Jul 2023 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690292421;
	bh=TkPJ4l/Y6tFm9PufblJMBPU0hAhAtQgdHuUkxd44AHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H284CE5RCCXG3sDEuDV1f1lyVr+rG8P7qhTtPvZbAvZlep1VSD0x4Fr5iSEAoqHv7
	 wox2jB+jiWf01TBbbHHyoFVIvq9BvuGrNyF9PEs0XRJYgLMMhobxSYfyr2tj5n0Qf/
	 rvqDfiRpDD2l/dZU9I1TI32/X/W9Szyx4eqM30ppw0bOmh7yzROFiylbwjM0vsr/DM
	 dCtr24wndFp9JnGZI4D6Rpg7xVBpYfCiCSDNxhknCt5EohEsWsN1bqaLEnktdr1HHR
	 IshNPMNxnOYqB/bCLtH3wP0t+/7l3FJPvzeEK/izMS5epD7jxN1U3LkzhtEfgo2age
	 8eehnctK/59jA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B41C6C59A4C;
	Tue, 25 Jul 2023 13:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] Support UDP encapsulation in packet offload mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169029242172.30370.2839867233183964254.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 13:40:21 +0000
References: <cover.1689757619.git.leon@kernel.org>
In-Reply-To: <cover.1689757619.git.leon@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: steffen.klassert@secunet.com, kuba@kernel.org, leonro@nvidia.com,
 edumazet@google.com, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 pabeni@redhat.com, saeedm@nvidia.com, simon.horman@corigine.com,
 quic_ilial@quicinc.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 19 Jul 2023 12:26:52 +0300 you wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> As was raised by Ilia in this thread [1], the ESP over UDP feature is
> supported in packet offload mode. So comes this series, which adds
> relevant bits to the mlx5 driver and opens XFRM core code to accept
> such configuration.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net/mlx5: Add relevant capabilities bits to support NAT-T
    https://git.kernel.org/netdev/net-next/c/57266281271a
  - [net-next,2/4] net/mlx5e: Check for IPsec NAT-T support
    https://git.kernel.org/netdev/net-next/c/4acea83a849a
  - [net-next,3/4] net/mlx5e: Support IPsec NAT-T functionality
    https://git.kernel.org/netdev/net-next/c/d65954934937
  - [net-next,4/4] xfrm: Support UDP encapsulation in packet offload mode
    https://git.kernel.org/netdev/net-next/c/89edf40220be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



