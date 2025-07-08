Return-Path: <netdev+bounces-204934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E374AFC929
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E253A5D8F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C95227054B;
	Tue,  8 Jul 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj/r2Xat"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49F219A6B
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972985; cv=none; b=Z2P8JufGeUVbJ5mkgExZsAowEODik4RHmLr7VTMYlge55T+ZUOnZeZqxd3l0Gjvu2igSvubgMw1o4lyAHhbil/ZrFvfs6/bqLaRyuyMc27EovTGeFh0e61gNo+AqiO58Z4IKUDjqLy7pPMo2iYd3d4XlEwdNxF75ySFOsaRf2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972985; c=relaxed/simple;
	bh=iwOtIEFtWTv9wg/i+3iTPMP5g9S+qPETLjnqGn2FRyQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KSf93Cr//2zclEE5rZwnER4UK2LNPSyHSiq0iuE7qTLh/6z+3bnUGUrrA01asHBI0OTAULWQFlp8+85qQqdQrwQEPD9hm97LdijYzpQNgLriHaF5jp517cUDAwIQMbqxee70hJ0rpHBm6EwJnIFn0AZY3pGXGh6g8HRL5bULqiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj/r2Xat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF9DC4CEED;
	Tue,  8 Jul 2025 11:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751972983;
	bh=iwOtIEFtWTv9wg/i+3iTPMP5g9S+qPETLjnqGn2FRyQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dj/r2XatJIwlXcg5Fop2mXIuNncFXFxdZt6Y8ByD0jhkxFEBRkyyCyThGwHK+ZbQs
	 Di9AsXR3V6sT5JMHv03nr9eWP80CNa3VME9MFt7hECYTM5ayJ7DcSHTgaaKb5y+8Hc
	 8+Jwoz469HM7Q5VKuFB3yhAp+BJfrT0opzIV3z2d6MxrptJGjBe3U940ah6mJyRvCX
	 3UO+/5JjnFq6Y3y/YuRW95VEKoCle8R9dKaEci6nloQB4j/lexGtBVPpygnEqY8091
	 5pBZfa/kNhfiXJEzLMEPPNAP6EE6SaQ3R5bLc1/jSgy2XtdGY3lcMSgENsb3vN9/Rb
	 zGyUTqeaLhKXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D36380DBEE;
	Tue,  8 Jul 2025 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net/sched: acp_api: no longer acquire RTNL in
 tc_action_net_exit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175197300609.4027359.2113690493089022665.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 11:10:06 +0000
References: <20250702071230.1892674-1-edumazet@google.com>
In-Reply-To: <20250702071230.1892674-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 vladbu@nvidia.com, marcelo.leitner@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  2 Jul 2025 07:12:30 +0000 you wrote:
> tc_action_net_exit() got an rtnl exclusion in commit
> a159d3c4b829 ("net_sched: acquire RTNL in tc_action_net_exit()")
> 
> Since then, commit 16af6067392c ("net: sched: implement reference
> counted action release") made this RTNL exclusion obsolete for
> most cases.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net/sched: acp_api: no longer acquire RTNL in tc_action_net_exit()
    https://git.kernel.org/netdev/net-next/c/84a7d6797e6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



