Return-Path: <netdev+bounces-48264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACA17EDD9C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0791C2084B
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE7A28DA4;
	Thu, 16 Nov 2023 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3ROC4rN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCF41371
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 09:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98E83C433C8;
	Thu, 16 Nov 2023 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700127022;
	bh=17JsJ32Hy365OXvGZ7b96zxUA0m8qXl3kFpnEYgbNBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f3ROC4rNsoJaMlvcoNIv6VRoByxP05+94Tw64AA7At6GmF6ZHBl6nyqsJYBXrGzp1
	 U20OBWsLjn8iBC4reZmroUvf7T3x6YWZHX33xcDiVOgdv1SxMXLfjwVUM31XmiF02w
	 3Ooc6Y5RDBc0n2FJdolUnxfgi0JvtsfeW1tNL0Ck3mNylAV+ygPsMdP5ItYdwjR3Tg
	 a8nYkbFmhq7xh0Z4vbWbdEEEDIGcZ6JDmuZmi6A6S36IG0Wub4Z+5l9CSovo8orCm6
	 vv44T2hDvOOnTQMl+03rq+uFLd8k5jQPk/dNxw4x1iLGYqWZN/8lsoomJiuWmltD7b
	 HcebzeIljhAeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F9DEE1F66A;
	Thu, 16 Nov 2023 09:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sched: do not offload flows with a helper in act_ct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170012702251.16472.12210926887637759770.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 09:30:22 +0000
References: <f8685ec7702c4a448a1371a8b34b43217b583b9d.1699898008.git.lucien.xin@gmail.com>
In-Reply-To: <f8685ec7702c4a448a1371a8b34b43217b583b9d.1699898008.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, vladyslavt@nvidia.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 marcelo.leitner@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Nov 2023 12:53:28 -0500 you wrote:
> There is no hardware supporting ct helper offload. However, prior to this
> patch, a flower filter with a helper in the ct action can be successfully
> set into the HW, for example (eth1 is a bnxt NIC):
> 
>   # tc qdisc add dev eth1 ingress_block 22 ingress
>   # tc filter add block 22 proto ip flower skip_sw ip_proto tcp \
>     dst_port 21 ct_state -trk action ct helper ipv4-tcp-ftp
>   # tc filter show dev eth1 ingress
> 
> [...]

Here is the summary with links:
  - [net] net: sched: do not offload flows with a helper in act_ct
    https://git.kernel.org/netdev/net/c/7cd5af0e937a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



