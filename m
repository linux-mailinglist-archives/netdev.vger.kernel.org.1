Return-Path: <netdev+bounces-30890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49737789B86
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 08:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDF61C20860
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 06:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28D9801;
	Sun, 27 Aug 2023 06:02:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5CC7EE
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 06:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13DA9C433C9;
	Sun, 27 Aug 2023 06:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693116147;
	bh=/AXE11cfMUOPxJ8229ag5JhTUk5MA8EkCaal0JODIF0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kznXOKm7+LvxQVtzHrRFpJshTCp2HhyzzeJTw6/B6TuXAeybPid3fAXgst1UUNp7Y
	 og3kH8GKswtKjChn548kQUrP7X8PKtUClwlQjO1A+0KHXVlcnkaT76himsSuZ+77+3
	 H1jTFeqNYe6nKip3rPnvc7qKREXNMzeOpNgqyRI8LrN4y6FgtQKOM5Ns4ukVXmGuZ0
	 y6JPY2R978P7kra59hfnc3tnoYnrxfqQ8Q8jgQfOmcGXVgdq2n+D7+SUAe0T7Kz/SS
	 3L1IysONxAM3TFz8msupSRVn1nv9LFVZi7au5JkzKzXsPuuHR9DuaVqpLq2iG9s7NN
	 jTD904sVhpUQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB5CFC595D7;
	Sun, 27 Aug 2023 06:02:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] sfc: introduce eth,
 ipv4 and ipv6 pedit offloads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169311614695.23659.11317146439281618197.git-patchwork-notify@kernel.org>
Date: Sun, 27 Aug 2023 06:02:26 +0000
References: <20230824112842.47883-1-pieter.jansen-van-vuuren@amd.com>
In-Reply-To: <20230824112842.47883-1-pieter.jansen-van-vuuren@amd.com>
To: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Aug 2023 12:28:36 +0100 you wrote:
> This set introduces mac source and destination pedit set action offloads.
> It also adds offload for ipv4 ttl and ipv6 hop limit pedit set action as
> well pedit add actions that would result in the same semantics as
> decrementing the ttl and hop limit.
> 
> v2:
> - fix 'efx_tc_mangle' kdoc which was orphaned when adding 'efx_tc_pedit_add'.
> - add description of 'match' in 'efx_tc_mangle' kdoc.
> - correct some inconsistent kdoc indentation.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] sfc: introduce ethernet pedit set action infrastructure
    https://git.kernel.org/netdev/net-next/c/439c4be98318
  - [net-next,v2,2/6] sfc: add mac source and destination pedit action offload
    https://git.kernel.org/netdev/net-next/c/0c676503bd4f
  - [net-next,v2,3/6] sfc: add decrement ttl by offloading set ipv4 ttl actions
    https://git.kernel.org/netdev/net-next/c/66f728872636
  - [net-next,v2,4/6] sfc: add decrement ipv6 hop limit by offloading set hop limit actions
    https://git.kernel.org/netdev/net-next/c/9dbc8d2b9a02
  - [net-next,v2,5/6] sfc: introduce pedit add actions on the ipv4 ttl field
    https://git.kernel.org/netdev/net-next/c/64848f062e33
  - [net-next,v2,6/6] sfc: extend pedit add action to handle decrement ipv6 hop limit
    https://git.kernel.org/netdev/net-next/c/e8e0bd60e483

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



