Return-Path: <netdev+bounces-32741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B0C799F45
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 20:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D3B28112D
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40838498;
	Sun, 10 Sep 2023 18:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D784257F
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 18:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBAE2C433C9;
	Sun, 10 Sep 2023 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694368821;
	bh=aB2UE18ifINeruLLLa2U/ieX/8koQ+oI9z8xxKyuIvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MvVSVRjqFOB3eCa3WcubwQYCaCUPa8zQFD7ptrdEGSvNLrohKfmSPe/ZoqVIpfsza
	 JWpKaY2Y0z+Pj+aCXosA6wD2Jvq0w/hcp76ns+3cKuCwl8HMIFsy/t48QvymK0LV4j
	 RfIMhUPofSTMLj8+c0JhugcTC6NZsHF5HPclEAeoPLPV8/WCvmJq6cuT8ofOei38iX
	 Wogu5cxMObHF2bGyD31jaLAW/e7G8XUnJE3/xL6wIanepGr3H8Ndp9YywQAZd4Ekid
	 NuBFJPRx5MF0YtvlMfpkht8e6j54EwLmd0nOZd8QZsZhbfai1OZWiRlzVUS7B7tHhD
	 a8Els9WHw2rpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0E2EE505B7;
	Sun, 10 Sep 2023 18:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/net: Improve bind_bhash.sh to accommodate
 predictable network interface names
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169436882172.20878.148707165455399821.git-patchwork-notify@kernel.org>
Date: Sun, 10 Sep 2023 18:00:21 +0000
References: <VI1P193MB0752FDA6D89743CF57FB600599EFA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB0752FDA6D89743CF57FB600599EFA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  7 Sep 2023 00:26:03 +0800 you wrote:
> Starting with v197, systemd uses predictable interface network names,
> the traditional interface naming scheme (eth0) is deprecated, therefore
> it cannot be assumed that the eth0 interface exists on the host.
> 
> This modification makes the bind_bhash test program run in a separate
> network namespace and no longer needs to consider the name of the
> network interface on the host.
> 
> [...]

Here is the summary with links:
  - selftests/net: Improve bind_bhash.sh to accommodate predictable network interface names
    https://git.kernel.org/netdev/net/c/ced33ca07d8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



