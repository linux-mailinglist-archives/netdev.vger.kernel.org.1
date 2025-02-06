Return-Path: <netdev+bounces-163318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974C7A29EAC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BF03A7965
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2541113BADF;
	Thu,  6 Feb 2025 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/y+Gm19"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139A13B2B8
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808407; cv=none; b=eRNavq0PBc39CifF/0yvvkLTPRPPaSqUKHm1WUeMM2uQIY5nrW9ssjFRycyvZJ2x3SGFaNT87eRagaxMY1AQr2C2ISiv1s2eIh9x4OYlm/Nt/Y+pVnZzzYeWOVrX/Uka4gUYTR8xLQWv0BnIrFHAahepcyr4/SFjU65HwL6FrWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808407; c=relaxed/simple;
	bh=/SUYUq0ixsQe5U0+TeIpuY1kP9tT/er0o0uXPIm9bww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gXsTZRaS+VP/AR5cOt0SoN5tNlpsOYaW+T1b3s5AM6zZPDKkey3vnQZ4OqEQDaUIn4FJHmKmIiMz2gXTMxSrjqGu52O5ZzScgDzNEeOWTmA32HwKSUXu0hxDJz0KeSffVTdViBmrhKJy1e+PHiAPJSK0Qp3T5lPs0/R9f+6dZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/y+Gm19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C01CC4CEE5;
	Thu,  6 Feb 2025 02:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738808406;
	bh=/SUYUq0ixsQe5U0+TeIpuY1kP9tT/er0o0uXPIm9bww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R/y+Gm1966iapeNpiDmx5Ytm6Vlna1+FLzH9zbQfp1icrZqombxWtwsFXV8xmKFmP
	 ZYOe6Tsxfwl5cZqUN9xCQmb3lH5CpqP7tnjBOl6LNJs1Xh9EXOsj9eCms2n+zlbQI7
	 fs5YYsSa3h9HZf5d7VWJk4mZ3Il+N0DzNrxMznsjutxqWkifx0GG4q+1KpIhZGq7Gd
	 Ff5Zp7/Xb48ZxwFHdUw3HLDn1/Bq+oaW6vBts2Tmfe1ABjaCDp2Q43Nso2UYnaE1Lu
	 Dsv3g/y2ablvf/FWVvtaaNKX5RTAT1PyDZIfn6WRG+lvNwqW+CrNuV9+HnT2QEs/1j
	 K3nyOOPv8JNpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D56380AAD0;
	Thu,  6 Feb 2025 02:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net v3 0/4] net_sched: two security bug fixes and test cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173880843375.974883.4547524655772131156.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 02:20:33 +0000
References: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 pctammela@mojatatu.com, mincho@theori.io, quanglex97@gmail.com,
 cong.wang@bytedance.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 16:58:37 -0800 you wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> This patchset contains two bug fixes reported in security mailing list,
> and test cases for both of them.
> 
> ---
> v3: added Fixes tag for patch 1/4
>     removed a redudant ip link add/del in patch 2/4 (thanks to Pedro Tammela)
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] pfifo_tail_enqueue: Drop new packet when sch->limit == 0
    https://git.kernel.org/netdev/net/c/647cef20e649
  - [net,v3,2/4] selftests/tc-testing: Add a test case for pfifo_head_drop qdisc when limit==0
    https://git.kernel.org/netdev/net/c/3fe5648d1df1
  - [net,v3,3/4] netem: Update sch->q.qlen before qdisc_tree_reduce_backlog()
    https://git.kernel.org/netdev/net/c/638ba5089324
  - [net,v3,4/4] selftests/tc-testing: Add a test case for qdisc_tree_reduce_backlog()
    https://git.kernel.org/netdev/net/c/91aadc16ee73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



