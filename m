Return-Path: <netdev+bounces-16245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C667174C1DA
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B111C208C3
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1F83FF4;
	Sun,  9 Jul 2023 10:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3DF2574
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 10:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27090C433C9;
	Sun,  9 Jul 2023 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688898020;
	bh=J8x95jp9FxyVxxTEkgEjgE5LoqKwFxlmgN+EMIKZtaQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AwOw3KZKXsr2zUYUiiQWp6J1KCZC8iQ5xHEVjK8DPbhja7B5r1LIWJt89KYGsgTwR
	 Qzc/84TIkdneMSF1irzcVOqQCr/x2JT04x9pb/RTL5rfaU0ezpXUORP1To+emjwBTg
	 ZFUZy0L/hBJwj6Tw6wLZweRc0OB9edeLRj7AtqQvQ276nyKOgRXGpura6xg0lV9LCA
	 i8sNSP648CGthGn9HhTfbWZwn2JPXbarAaqCSJ/zM3R37WdB2eJfBBIJTdmW1DiE4+
	 iZLyWBjglIIyFiV8A4dkU6wggmdH5EH+jtwXrU3MG4/WnEWrItoEs20DsYFtYkRmCv
	 VTdp6o8a+KDoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A153C395D8;
	Sun,  9 Jul 2023 10:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6/addrconf: fix a potential refcount underflow for
 idev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168889802003.24969.8684110706310843516.git-patchwork-notify@kernel.org>
Date: Sun, 09 Jul 2023 10:20:20 +0000
References: <20230708065910.3565820-1-william.xuanziyang@huawei.com>
In-Reply-To: <20230708065910.3565820-1-william.xuanziyang@huawei.com>
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 hannes@stressinduktion.org, fbl@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 8 Jul 2023 14:59:10 +0800 you wrote:
> Now in addrconf_mod_rs_timer(), reference idev depends on whether
> rs_timer is not pending. Then modify rs_timer timeout.
> 
> There is a time gap in [1], during which if the pending rs_timer
> becomes not pending. It will miss to hold idev, but the rs_timer
> is activated. Thus rs_timer callback function addrconf_rs_timer()
> will be executed and put idev later without holding idev. A refcount
> underflow issue for idev can be caused by this.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6/addrconf: fix a potential refcount underflow for idev
    https://git.kernel.org/netdev/net/c/06a0716949c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



