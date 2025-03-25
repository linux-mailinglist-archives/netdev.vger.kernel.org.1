Return-Path: <netdev+bounces-177488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631F8A7050E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284A118839AB
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB6D18DF86;
	Tue, 25 Mar 2025 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWBp3Ypx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2C2E3382;
	Tue, 25 Mar 2025 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916602; cv=none; b=LGwvhlICC8J6DR8HS8rwcA8ZzW6Um54Q+bfH91abT3bmBLCCAaYjeyZA72V+8l85nNH0QFqq9+/QvjZzlJpy4BpYYAZZ1hXd8M0M3nSuzXrvoZgNrc1OqUMu8FJ1fUT8evPNhckeL0oe+MQiRqmC/2rC7CvyOfQwXM7nGVn6Q6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916602; c=relaxed/simple;
	bh=rZQHfWmksMwHawhsGIweB/zezJOd7MftOi3iZ8m1Wpg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A41DYbk/15EbeVD5FJzL3dhANqB7XXBpeuipWV4kJbqJIybQzgs7+UAOV0OEQMu2xvEZDYM90J56oqDGCSrUWcLrYngBnd4mFQf4GidgErkK0tD4JkssCLp8iQIUbuXLZ3RPAGtJeAdvAH0y24Z6JQ2VwHN74Wfv2kvlggu+aAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWBp3Ypx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801C5C4CEE4;
	Tue, 25 Mar 2025 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742916601;
	bh=rZQHfWmksMwHawhsGIweB/zezJOd7MftOi3iZ8m1Wpg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eWBp3YpxEPLM6ryebQjoA4PJCxBI4E82P3LF8Alu0zAip65522kwa0Pka0g7Fbsev
	 iduP3nA0NNKGyudzvLrgYdOH+SKX2wRPlrAbvNsujgLVCtAiTdLFh/3EsLWrZKiG9r
	 ae3zfk50ybDKt1tTbA7rdD2KGvwOOVyXyW8BtKwh5TiZUqDmfLUxyZOap//DnW45Ka
	 E8cKxQR/mgv/toGCGplM4YKDt6NtmLIOAF8vf2eFH3SIqxOXbOhRW92v/rYTt/H6qb
	 SOlRFgslerd3nbuKhI7gIvLyp+fwWHAdOmhScDb1vFbq+mjpNhtBpz482+GyjcB9k/
	 yx809GcG3tsSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE7B380CFE7;
	Tue, 25 Mar 2025 15:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: fix NULL pointer dereference in l3mdev_l3_rcv
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291663751.618403.8982725389393074966.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:30:37 +0000
References: <20250321090353.1170545-1-wangliang74@huawei.com>
In-Reply-To: <20250321090353.1170545-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 gnault@redhat.com, daniel@iogearbox.net, fw@strlen.de, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Mar 2025 17:03:53 +0800 you wrote:
> When delete l3s ipvlan:
> 
>     ip link del link eth0 ipvlan1 type ipvlan mode l3s
> 
> This may cause a null pointer dereference:
> 
>     Call trace:
>      ip_rcv_finish+0x48/0xd0
>      ip_rcv+0x5c/0x100
>      __netif_receive_skb_one_core+0x64/0xb0
>      __netif_receive_skb+0x20/0x80
>      process_backlog+0xb4/0x204
>      napi_poll+0xe8/0x294
>      net_rx_action+0xd8/0x22c
>      __do_softirq+0x12c/0x354
> 
> [...]

Here is the summary with links:
  - [net,v2] net: fix NULL pointer dereference in l3mdev_l3_rcv
    https://git.kernel.org/netdev/net/c/0032c99e83b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



