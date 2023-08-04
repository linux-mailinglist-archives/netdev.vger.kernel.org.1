Return-Path: <netdev+bounces-24595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2ED770C02
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 00:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09706281A01
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4F8253BB;
	Fri,  4 Aug 2023 22:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663C1BF1F
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02D90C433AB;
	Fri,  4 Aug 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691188824;
	bh=+145GeTBUgxtFo9heKiGO0oZ9/Cg6OoWJJ2EIkj3maQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NrUtTP1J1yElaMpnNwJT3daWWOfgrsvREZEBiyfTPIQ9MPLPHF9x4Qmc0fFnRdPGd
	 t5k1wK1sgOk3cwADlvRZmAVT6c85mXuxoACI1duLUt2fVWHWY660x+n+cZPQV0zyan
	 tsys376CVbPQ15cHUi95CIMvTHGlMv8FTNT0uMk1QgH5kbCpj/ih/BUGPSXhSPh1oX
	 W2W3CbMAhyvZ1czmaILgdDNBVqkeQbn57N7516ZIiK6h6AcwRTGCKVxcZo7Ju2fqtm
	 xi/dkPZR4SuMZsOX3k6UqmA7gA1Nb3656W0ivzhqm6y+VJefFEd1WoFThwEDnYcE8e
	 TvR84Yt+4Aj4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA3C4C73FE1;
	Fri,  4 Aug 2023 22:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp_metrics: hash table allocation cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118882388.4114.3278994026107355586.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 22:40:23 +0000
References: <20230803135417.2716879-1-edumazet@google.com>
In-Reply-To: <20230803135417.2716879-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@amazon.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 13:54:16 +0000 you wrote:
> After commit 098a697b497e ("tcp_metrics: Use a single hash table
> for all network namespaces.") we can avoid calling tcp_net_metrics_init()
> for each new netns.
> 
> Instead, rename tcp_net_metrics_init() to tcp_metrics_hash_alloc(),
> and move it to __init section.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp_metrics: hash table allocation cleanup
    https://git.kernel.org/netdev/net-next/c/c4a6b2da4b59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



