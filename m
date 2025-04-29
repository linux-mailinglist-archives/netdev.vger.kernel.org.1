Return-Path: <netdev+bounces-186762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB10AA0F38
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9C9164196
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403071EEE0;
	Tue, 29 Apr 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba5YYwhK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD0D40C03
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937594; cv=none; b=f6bNGk641y30OOtBEEd08Eai6g8MjVdJs31IGs11rea/xogDiCcN/ZjdutRKvdojk9avXNV9BpETDG4HNLY/QopRE/lp/VyYZe4REETDqSuLYzQ9WDkVcablDHZYmdD8j2UFIK5JXbAYLwt5HDR0thWxAUGIwuQKhH6knZAKeHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937594; c=relaxed/simple;
	bh=2O38WcTlY/n+t9Z6v4t6J9y8D4eab1t3Ig5RzqPi6xw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HggKTgKZyr7P5IKFLHHvOCpOD3PWSa6TTtkx69+pXSxPQJod3KBqfldEucnTlz1+WX/2oHa1M0LELYy8/jRVfTQtRe1QChg6WecH4WbeHiI5KmN4kRCM3IClBhacosu8KxJLmjPQe9IhXUfUYQCHCE94wXHEzaLwkTGXPlocK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba5YYwhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D92C4CEE3;
	Tue, 29 Apr 2025 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745937593;
	bh=2O38WcTlY/n+t9Z6v4t6J9y8D4eab1t3Ig5RzqPi6xw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ba5YYwhKC+xcbYquGnUAaHrEFi/do2XOuLI2YzQydNU+b9gzAKezxy9hPmkDm+aSP
	 2H4xQgDqlbutOGXcF5sA6bgmahoTLJjc8XbJvEXUCrzQUQnZtxcgwKN3+tiHuZtrKJ
	 PyF7eMdsJ0OOc9trtUpgIK9fesQB4cfLkgT7RSaSbw++3hx8j6ixO+ueog4A/5oCJS
	 iLQRJGpgRF7Gfubb5zznJmd1Wv3OlGv8LEDxwRyyVkveDSJal8kPme4X1iXEne6Kil
	 xqEfnuNgK2VetF453V5U4Pf/QEfdqayQtwBxU8Vr1khNtFtnmgTqKcegHMe6RzmQSO
	 eooGbhKYJGJ8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF163806641;
	Tue, 29 Apr 2025 14:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] ip: improve tcp sock multipath routing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174593763250.1639843.9487329717879125406.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 14:40:32 +0000
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 idosch@nvidia.com, kuniyu@amazon.com, willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 24 Apr 2025 10:35:17 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Improve layer 4 multipath hash policy for local tcp connections:
> 
> patch 1: Select a source address that matches the nexthop device.
>          Due to tcp_v4_connect making separate route lookups for saddr
>          and route, the two can currently be inconsistent.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] ipv4: prefer multipath nexthop that matches source address
    https://git.kernel.org/netdev/net-next/c/32607a332cfe
  - [net-next,v2,2/3] ip: load balance tcp connections to single dst addr and port
    https://git.kernel.org/netdev/net-next/c/65e9024643c7
  - [net-next,v2,3/3] selftests/net: test tcp connection load balancing
    https://git.kernel.org/netdev/net-next/c/4d0dac499bf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



