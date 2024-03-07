Return-Path: <netdev+bounces-78232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D6C874758
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 05:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F766B21BFD
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 04:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05435817;
	Thu,  7 Mar 2024 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBKV3b4h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20231BF31;
	Thu,  7 Mar 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785830; cv=none; b=R1mG+zuMABeJBlHRMSaJcRjjQK4XgCHqbMxCR2yOKdvChYo6mjNfWRaeuCZ51RptAwhxcYixonYeu7XUUNH3OX1xah2Tmhg92YFWze8E422aAy98QCFXhEaUTYRv2HZL9IZUM7BRs/lrL5e4DyEsHlBErWKccYU00TjHgHc8a6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785830; c=relaxed/simple;
	bh=iffEfLmA7cwx+ct1DNqjmZkXXJTmO8J6oqYcHM5Lz+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SRqang5BVZzbCUK696p1yYURZPQXJga/ZhHXrcUZvITzRrXkhz4feuVd4FNdKmUGmcq0Gk+PJud0IOa+ldkeaAF5QriUa/aXdOysu4pb9nyTYNvN14pVEd1YOpgAv+tr7VOrgc3hz8wNptjLlwNKJ8T3tMUFTzK1qu+/psYbSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBKV3b4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A5D3C43390;
	Thu,  7 Mar 2024 04:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709785830;
	bh=iffEfLmA7cwx+ct1DNqjmZkXXJTmO8J6oqYcHM5Lz+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cBKV3b4h82w+mkBzUmdQtKwLQ9jh1e2UP6dH+Hc8XAGumyjgYSvOMqgcmtZ2rSh2M
	 LZDe3PR1OJIHHBrnQNbz8bJM22wWo2v9andFB+D9bJCh75rCGnKlRRQU8objX4P2pj
	 uRO5a8aAyQiZ8LKOAIsvQmmeshic51oVDLvlCEeXwED6eAmtCnstIxwT6sazUr95HT
	 SWq97AT6Zp6kAiE/55bMO1P9pnH6Mh8R9UzpbHNZ/ZPFiGd6QFj4YE42MeCrOHeTkX
	 w8rxXyBQzdk1IUrq09rTbCPE8TKD7smVp6VrwEt/ePW9byKNpi3/K63xhB+lDY7jgd
	 eOkZexcjaeAYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C34FC04D3F;
	Thu,  7 Mar 2024 04:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-03-06
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170978583017.1930.14993526259352753718.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 04:30:30 +0000
References: <20240306220309.13534-1-daniel@iogearbox.net>
In-Reply-To: <20240306220309.13534-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Mar 2024 23:03:09 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 5 non-merge commits during the last 1 day(s) which contain
> a total of 5 files changed, 77 insertions(+), 4 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-03-06
    https://git.kernel.org/netdev/net/c/d3eee81fd611

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



