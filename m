Return-Path: <netdev+bounces-242471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E0C909AA
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54DBF349AE7
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B963126FDBB;
	Fri, 28 Nov 2025 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdiEgG/q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D4261B91
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295988; cv=none; b=DefzaeZFaum3/VPAoVFSiTIittS4ZdEA0+Pt2lR5NHuROBg9Uau7zEjk6pbQmWOWNF/o6BiZCyMEJSU0NT9e4XlIaXwg6b8vZVZ0jWcGMUPqi67Gp/ptZfbxQjfFwHYBaS5z7pZeutAfI8ftihuAzCG7yZ+l0OR7RJv16oaFUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295988; c=relaxed/simple;
	bh=Q7JApqxTJVL1BaaWKIfbMA5bZ3fq/gTlJ+2/V0kLusQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rHR2JSxd/p1suqugvOrpGuzZLKPLAhdTjb3dF3OoCJ2EujInThaImDwKjD6CUZhSixMUuIu1+IGlpmbfPYhICTRTPWuMNRaMKHE5SXlYoyA+fuJN1NXFJyQ32PjwpTqbezcFfQXoY8WGRp+jT5DGf3/mvzQvRdsACVdaPNYhtRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdiEgG/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EEFC116B1;
	Fri, 28 Nov 2025 02:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764295986;
	bh=Q7JApqxTJVL1BaaWKIfbMA5bZ3fq/gTlJ+2/V0kLusQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RdiEgG/qtFYeGKlSOP54iQUukn7hWtfKTvF4jUcrZpei2YjaTupnMU0QL0EubIg+2
	 PZj6M8nfLMyEOaRO1dw9pnzkjeTvcFzD0UOXL61Pv7sJb3T4B7E8IfF2bqCxBVFD5y
	 6YyBDYIcJoVMjrZCwY23vqqFz3Nzb3695JQUie1s577bjY1trOOxuaW9a6UnRJaXjm
	 h41ULx/YVYFchpzxKkuZcvEC/Vy+tEy9EHOGbzEI5xGEVZjcLeQHuhZ6Bt4DyDGM4E
	 w+L8z19XMComVCeG/ZtYLunzlQwC49vME5hppVPlYVyluWkOwlMxwA5r0C126F0saR
	 pW+hjNBaZMDRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 787543808204;
	Fri, 28 Nov 2025 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: vxlan: prevent NULL deref in vxlan_xmit_one
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429580804.112305.1787461907893353166.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:10:08 +0000
References: <20251126102627.74223-1-atenart@kernel.org>
In-Reply-To: <20251126102627.74223-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 liali@redhat.com, b.galvani@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 11:26:25 +0100 you wrote:
> Neither sock4 nor sock6 pointers are guaranteed to be non-NULL in
> vxlan_xmit_one, e.g. if the iface is brought down. This can lead to the
> following NULL dereference:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   RIP: 0010:vxlan_xmit_one+0xbb3/0x1580
>   Call Trace:
>    vxlan_xmit+0x429/0x610
>    dev_hard_start_xmit+0x55/0xa0
>    __dev_queue_xmit+0x6d0/0x7f0
>    ip_finish_output2+0x24b/0x590
>    ip_output+0x63/0x110
> 
> [...]

Here is the summary with links:
  - [net,v2] net: vxlan: prevent NULL deref in vxlan_xmit_one
    https://git.kernel.org/netdev/net/c/1f73a56f9860

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



