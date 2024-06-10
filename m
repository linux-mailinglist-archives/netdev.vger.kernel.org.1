Return-Path: <netdev+bounces-102226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B8E902011
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AF27B20BCE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD1371743;
	Mon, 10 Jun 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ1LmgGI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB6F9E8
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017232; cv=none; b=Q+zMaomzLTr8I2CJQILBoYoxrcqkXRulLinrojKgsMcCuhCawtep+x88wI9o6kfQpDfJ7QG+FYTMEmWU+OnPl708BC0clNfhG2/5+shhAOcM6MrWah3mqg4M604ZUXTzTKMEdvBQG2JgCdOKXzd48L2QfgPkqyU/z/IGmhSAcBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017232; c=relaxed/simple;
	bh=PdkNS7HEucWkeIB+46ii2XLa8R8jy17SbN6jVZGXuus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cpbsgNu00lb4EUf3s1/MZ6n1gVGXOuSvj6gMOyTJFpoK47KQdaOktpa7REmLgRB2tHfPdrjN6s3orenQtztzzE795FTShM6jLIye/5z29CK9JJq4X6ChljR+vGwKAn4GVtjTf5X31Y4jDFiHq463ydxB1V+NF4we1OqqgcrZ/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ1LmgGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64989C4AF1D;
	Mon, 10 Jun 2024 11:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718017232;
	bh=PdkNS7HEucWkeIB+46ii2XLa8R8jy17SbN6jVZGXuus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KQ1LmgGIxHdeoFjkbjy3GLUXPOe48JduR9cGGoWlyBV7ZzWxwT33t2HT8S/uTrz0R
	 gSbVl+N/FOgLMp1e6+8/0ZiDjqAfqR40P0zGPBhvpJOlExS6OSpN9oluoyHs/JekWs
	 lqRD2Him6Lx4f7UEpdTbiFRwEQexg/85DEe28jmX/eggXlB1W5+8nQ0hJKTYCsgpHV
	 IIM6Q3q4yVaRsjyk4NxflfPQyiLPtTg+++DVPwK9b34Mo1hXgDpR8tolcYTOCFj8zw
	 1/apZcJETNj/xvgjy2HBA7Y/qdD68x4op11eWpMxrWfeac8amCq8ERzSJbFvN3RtlH
	 G7+SWlGyk6n9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58E16E7B60A;
	Mon, 10 Jun 2024 11:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/3] net: tcp: un-pin tw timer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171801723235.20490.2315848723603673473.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 11:00:32 +0000
References: <20240606151332.21384-1-fw@strlen.de>
In-Reply-To: <20240606151332.21384-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bigeasy@linutronix.de,
 vschneid@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  6 Jun 2024 17:11:36 +0200 you wrote:
> Changes since previous iteration:
>  - Patch 1: update a comment, I copied Erics v7 RvB tag.
>  - Patch 2: move bh off/on into hashdance_schedule and get rid of
>    comment mentioning pinned tw timer.
>    I did not copy Erics RvB tag over from v7 because of the change.
>  - Patch 3 is unchanged, so I kept Erics RvB tag.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/3] net: tcp/dccp: prepare for tw_timer un-pinning
    https://git.kernel.org/netdev/net-next/c/b334b924c9b7
  - [net-next,v8,2/3] net: tcp: un-pin the tw_timer
    https://git.kernel.org/netdev/net-next/c/c75ad7c759cc
  - [net-next,v8,3/3] tcp: move inet_twsk_schedule helper out of header
    https://git.kernel.org/netdev/net-next/c/f81d0dd2fde3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



