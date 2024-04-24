Return-Path: <netdev+bounces-90742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317918AFE49
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04DA2825B5
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966BA134A5;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0XBHQ+H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72131125C1
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925228; cv=none; b=lX7ppEKikCui5ayVee1hDXzdRHnCxD8WqDYTKtcKBnN4JsNcconYRF1nc+8c/isSN5d53pG+A6c+Ve/gOjLjrZ6EZIX8JprkftbPgSxe20ZxkkS+x8DqyH4wX9hUvd6jl25I3OnMqAPhcokZBZtqO+scF9aj9NKNjcr3Gblosb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925228; c=relaxed/simple;
	bh=vLIB5C4tWPU51TYKuCk+H3kWhh202vALyQr5QAIowgc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bsfZ1KINeDZf9j8jdqNWnWXSCu3g5d46t3dDeovDPWYRHzWR047psR90I2sYmsif+o+93zz27XyfcdAdZYI8wAnAIUY6CcRXsWRKO4vkP/ea8RqNSUfGbiztSuYkH78ou1+FOEjRWf+yQEePkVxgtz7aNVDUXa+6iTsYS729AxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0XBHQ+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DFB0C3277B;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713925228;
	bh=vLIB5C4tWPU51TYKuCk+H3kWhh202vALyQr5QAIowgc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c0XBHQ+HEso/NxGC4jZm+y8/FqfjjYzEAir8OnnickQD8Y+ZN3CX0HcMrs/Z58LMj
	 IicUxTq9vmd+lLstSoyyT11vDE+kFZzZVPjEnaQMZv3znEgBJac6JNb4bVSgHZFMv/
	 5r2xlQF5CKLeNQQZu0efZ+XyvkNO1QTOlOgpo3OppSXtON4i0PBUszMHu4ta3tCrWc
	 K52vdfxMCN6gCcIAXn8VJgx7WW5j7S6GUik+ajoElMNL19wLN0nZXOhC0dOLmRUwa3
	 9mQ63jXsv78tQoPaNZBvPvILI43DKLgrNm9h5Cj8waWnWBpet/zMPvVs3F2MgSXfVZ
	 Qdf9Z2060mvmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 031A4C433E9;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: check for NULL idev in ip_route_use_hint()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171392522800.21916.7536631776593162133.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 02:20:28 +0000
References: <20240421184326.1704930-1-edumazet@google.com>
In-Reply-To: <20240421184326.1704930-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 21 Apr 2024 18:43:26 +0000 you wrote:
> syzbot was able to trigger a NULL deref in fib_validate_source()
> in an old tree [1].
> 
> It appears the bug exists in latest trees.
> 
> All calls to __in_dev_get_rcu() must be checked for a NULL result.
> 
> [...]

Here is the summary with links:
  - [net] ipv4: check for NULL idev in ip_route_use_hint()
    https://git.kernel.org/netdev/net/c/58a4c9b1e5a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



