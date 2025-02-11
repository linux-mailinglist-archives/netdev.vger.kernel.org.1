Return-Path: <netdev+bounces-165035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F3CA30226
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 04:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE63718838A5
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883B11CB51B;
	Tue, 11 Feb 2025 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUNMdRGV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A813C695
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739244612; cv=none; b=Hp7YBDKJJt/5x0LlMbUxczTRHuAVOjg5uXOPbhwIhcao6LsWKJZDha1Yc/9hM+Oc9OJYeFMyYJttnX/irLfNyRBWy6eIWauboU+FuCZ/3EX58iFvoMSDtov6pjt34BBXUzIjnJRCxvaxEwrXCjGd8D+H5gS2qzyqWKdDOg3XP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739244612; c=relaxed/simple;
	bh=ior5/BYtAnV/u0eVZCyQMDknrSntdDgbxOqId9y8BNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GiO1SlLL8iG493spE5Rv6zm64Evu5Bsi1RKdYRfzyJpvlig28BwVquTgHzoa4Wlv3Zi754VGI0M5oerkR+GaKXqjHYV8H/Qh+tjZZwH+lLEFC7V4pjNmfmEPQ+9Cai8ejlQxOV21Cjy0UDgFaVotAc6jTm+6tMhZvpB6KD+RV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUNMdRGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2CEC4CED1;
	Tue, 11 Feb 2025 03:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739244611;
	bh=ior5/BYtAnV/u0eVZCyQMDknrSntdDgbxOqId9y8BNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uUNMdRGVUfPfZGeu9L4096Jr/wPx3OmsoyGfMT4WDQc23Q+4TpzkH1sM/A9CYmEly
	 s6S/yU9upCKusOrjBPBgXyLjcZKIdcLDcanzC0AHywDZwm7JHBW0vnGHpRzG3dl1xV
	 +sYDJBFkWXkq5MLAF7VpvkJ6imBZhKQr6LoLC9X6wf/17mU90tc7rGdNlKTzZDauOR
	 RZN3THrOiZwAP65ZpcskllKXa5RZ7Kf1vGRwFOjFCDX+c93PdpI5ZaFzKmr85TEOX7
	 Tj31eq1jzemhOuoojOlhDDs7yz5ZWkuooOBibKhuWJwiWWPWX0aMC0Og7PA0KIbRHw
	 NLbKVeowarqDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE639380AA7A;
	Tue, 11 Feb 2025 03:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/8] fib: rules: Convert RTM_NEWRULE and
 RTM_DELRULE to per-netns RTNL.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173924464024.3948401.6072585471419171429.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 03:30:40 +0000
References: <20250207072502.87775-1-kuniyu@amazon.com>
In-Reply-To: <20250207072502.87775-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, idosch@idosch.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 7 Feb 2025 16:24:54 +0900 you wrote:
> Patch 1 ~ 2 are small cleanup, and patch 3 ~ 8 make fib_nl_newrule()
> and fib_nl_delrule() hold per-netns RTNL.
> 
> 
> Changes:
>   v2:
>     * Add patch 4 & 5
>     * Don't use !!extack to check if RTNL is held
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/8] net: fib_rules: Don't check net in rule_exists() and rule_find().
    https://git.kernel.org/netdev/net-next/c/7b7df666a233
  - [v2,net-next,2/8] net: fib_rules: Pass net to fib_nl2rule() instead of skb.
    https://git.kernel.org/netdev/net-next/c/a9ffd24b5528
  - [v2,net-next,3/8] net: fib_rules: Split fib_nl2rule().
    https://git.kernel.org/netdev/net-next/c/8b498773c861
  - [v2,net-next,4/8] ip: fib_rules: Fetch net from fib_rule in fib[46]_rule_configure().
    https://git.kernel.org/netdev/net-next/c/5a1ccffd30a0
  - [v2,net-next,5/8] net: fib_rules: Factorise fib_newrule() and fib_delrule().
    https://git.kernel.org/netdev/net-next/c/a0596c2c63fc
  - [v2,net-next,6/8] net: fib_rules: Convert RTM_NEWRULE to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/98d3a6f681ca
  - [v2,net-next,7/8] net: fib_rules: Add error_free label in fib_delrule().
    https://git.kernel.org/netdev/net-next/c/1cf770da0112
  - [v2,net-next,8/8] net: fib_rules: Convert RTM_DELRULE to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/88b9cfca8d77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



