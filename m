Return-Path: <netdev+bounces-78443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B37875212
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F601C24742
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193CE1E53F;
	Thu,  7 Mar 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhfu0pLq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48A81C68F;
	Thu,  7 Mar 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822430; cv=none; b=CDaidSnxish/xWRxzoHWX35zsXH2Zwwxgw+YTS9gW8CrWGuxaHWNhwsrG59nEghT0aF71nGoZpb52VEEd3R3rPZRa5zEkgtn12H7gVt8bERs4NNIbmecKJVqSa2oW7NvqgAYJkLvhXjLpkv4BPUrCz2B2hhskWvlI79L8OOTJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822430; c=relaxed/simple;
	bh=7dxvCDxAGYQd595toSU98MFIATvFSxHwmTUQJkXbY1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PwBLQSkm04JWPyXchsZk/0G35PrGMzrbzg20LpO7e5a3YisPYXVSmRTU9Qd1gID6zARQpuG9kFXkpq/P0QcJlEG+LlS4HIZ9vRwyzYphLHUERYXIk++4jf2BQRxhFz+YCpxOwPFjjtWjHFpX/QjD8SzNv3TFpouLP40qHmHL17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhfu0pLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5869DC43390;
	Thu,  7 Mar 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709822429;
	bh=7dxvCDxAGYQd595toSU98MFIATvFSxHwmTUQJkXbY1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hhfu0pLqmYL8+kXdelDYkAU/yLhG5fqBoPhRcQDveC8AkZJDgOQpn4V85DSktFYg1
	 E5DRn1iU8KHUwzYROxyRa2IzIr2KBBKmlxEDHRnu5dVNzvrPr+kYNWFhgMuzUsffFI
	 hMwr+sMoFwlBZ45meWI4nSBZtacJN89hiO+Bcs0bBTW10YsqmXc0tv2wW6Xwy8R0VN
	 glv6Ex621FRM27GxCW616CGaTCeK/AjMgFRKo+mr11dd9qF8bcQZkK9ymGn5P/jp8f
	 dk9J/zLSJPEBfE4MtljY6dg1c1Vh63GjQ+oEVSU7MFUu1/d8herE719lsUu7yMehH+
	 bVlBco4OWjOzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40AD4D84BB7;
	Thu,  7 Mar 2024 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] tcp: add two missing addresses when using
 trace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170982242926.6102.7676342202788241551.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 14:40:29 +0000
References: <20240304092934.76698-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240304092934.76698-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 rostedt@goodmis.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  4 Mar 2024 17:29:32 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When I reviewed other people's patch [1], I noticed that similar things
> also happen in tcp_event_skb class and tcp_event_sk_skb class. They
> don't print those two addrs of skb/sk which already exist.
> 
> In this patch, I just do as other trace functions do, like
> trace_net_dev_start_xmit(), to know the exact flow or skb we would like
> to know in case some systems doesn't support BPF programs well or we
> have to use /sys/kernel/debug/tracing only for some reasons.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] tcp: add tracing of skb/skaddr in tcp_event_sk_skb class
    https://git.kernel.org/netdev/net-next/c/4e441bb8aca1
  - [net-next,v2,2/2] tcp: add tracing of skbaddr in tcp_event_skb class
    https://git.kernel.org/netdev/net-next/c/0ab544b6f055

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



