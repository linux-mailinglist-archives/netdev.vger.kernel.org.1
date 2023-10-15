Return-Path: <netdev+bounces-41076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92617C991E
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E038B20B40
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B9B6FAC;
	Sun, 15 Oct 2023 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLQnma+C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00696FA8
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 13:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D247C433C7;
	Sun, 15 Oct 2023 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697376623;
	bh=kAlALDK5Cpes+9AQcnKLDKHXwYwrGNNZRW6SA06zZuM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DLQnma+CViGXGFHleYlzFzue/ra6mC8QWajaGH30V5/d3C8bvZ7APD4P6b+oPOj1v
	 kCo5TqT6bq3ENHuyaiaL0TDdUvXsLnw5IhTtpQeYc5amOHc7EtDXMyov3s40LiQ8CU
	 aGfWkh10N+O0PxHK1dJpO0jsmFySVGD5vkYhvzXn+TXIr8kTjzjf2X6pWQFMM0S7QY
	 TSZvADQI0Hjfc02eNwbYeHHDoo3RVzzl7+y2eQGSHvvDd3TSoHW/XHQ2xV116DDIKb
	 RmByox+M6ibDLJqEv6NTAEbz5LS9Sz+i9eE1336+cRtO64JAN4kbO4EixaF9HVuP4k
	 cBU2aoK1zwJjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30D88E1F666;
	Sun, 15 Oct 2023 13:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] qed: fix LL2 RX buffer allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169737662319.24568.4521440160238409297.git-patchwork-notify@kernel.org>
Date: Sun, 15 Oct 2023 13:30:23 +0000
References: <20231013131812.873331-1-manishc@marvell.com>
In-Reply-To: <20231013131812.873331-1-manishc@marvell.com>
To: Manish Chopra <manishc@marvell.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, aelior@marvell.com,
 palok@marvell.com, njavali@marvell.com, skashyap@marvell.com,
 jmeneghi@redhat.com, pabeni@redhat.com, cleech@redhat.com,
 edumazet@google.com, horms@kernel.org, Yuval.Mintz@caviumnetworks.com,
 Ram.Amrani@caviumnetworks.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 13 Oct 2023 18:48:12 +0530 you wrote:
> Driver allocates the LL2 rx buffers from kmalloc()
> area to construct the skb using slab_build_skb()
> 
> The required size allocation seems to have overlooked
> for accounting both skb_shared_info size and device
> placement padding bytes which results into the below
> panic when doing skb_put() for a standard MTU sized frame.
> 
> [...]

Here is the summary with links:
  - [net] qed: fix LL2 RX buffer allocation
    https://git.kernel.org/netdev/net/c/2f3389c73832

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



