Return-Path: <netdev+bounces-40372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD3D7C6F70
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C1F2828D8
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D6329429;
	Thu, 12 Oct 2023 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQgE70va"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFA27705
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 13:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26A63C433CB;
	Thu, 12 Oct 2023 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697118027;
	bh=L88CARRmiLu4rxw1K/f3K2I8S4J8TgYHDZZQDO7YRQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZQgE70vaPWOeHdiFL7zlPGuiZpm2vpHb+fFaSaY7214Bw0DE+K1a+IcvtIDZo/kzD
	 wOc5vj1IwEEHJXM5s4Eig5Mu9g1f56NE3X1ClYaswtUUUvUWEucpUmvWZM0CEn+joU
	 c9Vk9FJUzL3qiH4MM1HGmMCNtJxSmSe9nsLRzT2lqCLfned8qC5alO8MXnH3M2hqib
	 I4nEuNmTcMhZ5e0/slaMpe3OQAF2gHMNuPa6ByTMqwd93AhIZJAiFDNyzcOgIlmm8S
	 T/4UQputJzWNyOo+A6wN8q6cjCwbtG7tcp+Q5i0+6gl2GO5NSrIoFcbRGYDDPjIznP
	 lngzE4uWPzVpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C0C3C595C4;
	Thu, 12 Oct 2023 13:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: gso_test: fix build with gcc-12 and earlier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169711802704.13816.12651350014833242834.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 13:40:27 +0000
References: <20231012120901.10765-1-fw@strlen.de>
In-Reply-To: <20231012120901.10765-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, willemb@google.com, tasmiya@linux.vnet.ibm.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 12 Oct 2023 14:08:56 +0200 you wrote:
> gcc 12 errors out with:
> net/core/gso_test.c:58:48: error: initializer element is not constant
>    58 |                 .segs = (const unsigned int[]) { gso_size },
> 
> This version isn't old (2022), so switch to preprocessor-bsaed constant
> instead of 'static const int'.
> 
> [...]

Here is the summary with links:
  - [net-next] net: gso_test: fix build with gcc-12 and earlier
    https://git.kernel.org/netdev/net-next/c/2f0968a030f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



