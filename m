Return-Path: <netdev+bounces-78676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440AC8761DA
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759DC1C21DD8
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 10:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7AB54661;
	Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKTtGtuJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954B53E06
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893231; cv=none; b=GRvKxX3KvRh5538Zni3uD4siRwuK5N5QTyvYrdJYrRJDD0w7UcQDDgPqChrISDcKyPOHt1uGoiwyTAJ+uPOBWHA2EqW3yGI3/ahCzLDVcskHZWj6fNZssQe11RwrFo12vQJJZrHU6l513nRlPJPiOw7MAUOvZqQXng5ihphsaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893231; c=relaxed/simple;
	bh=MTUw0UQXC+QXB90Ymz9uX7gvoM/OTXgQGSnJEL2th8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DeU0kKvwySnTpczaZAkfWBnioQ5VfNzuump4Xw5VZii8mbsp+vnsQWUarVgQkMGbPteqwbxKaDwTWulQ0skcoKEpCH4542QqsvGBmWNYkLYoOGpAMC5qtnLx/cneFmehRoSmRl5NUcodSBZlc2Uq3xA+2MGXUPohmBGJw6FWZsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKTtGtuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20FE4C433F1;
	Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893231;
	bh=MTUw0UQXC+QXB90Ymz9uX7gvoM/OTXgQGSnJEL2th8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lKTtGtuJ42gTWuXo79bB4pIhwsdyUyE8Vmr6+8fns5SoIPDAVHizNVmyo4lBl/Xsm
	 9/9ksvXtFq8Lc2doDm3fIA7VS5n9YRUxQBmlM7vOF3mV3qN1pUaW/bjccq6sqGpMbT
	 bJT6nrnCSzjv3o14WjyxPj8KErHBEdAtdpKDdX023Ia2JSs+s/mm8Y8m9GyKpOL2LK
	 d5q1AYLdd5wxATLtdoCWMSxC7KnQfAq31YYNt1hw6Ex0DZfwydJvD/IM+9lFeuvVcw
	 K44Oelbb3NtBSdj9F0h2OzjV2pXHtH54RpBpIwpwU6WI2kruLbSY6ykKSlCOGXGV0X
	 l2aelV6U0R4Kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05CE7C59A4C;
	Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ip_tunnel: make sure to pull inner header in
 ip_tunnel_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989323101.6327.17930625965752277936.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 10:20:31 +0000
References: <20240307100716.1901381-1-edumazet@google.com>
In-Reply-To: <20240307100716.1901381-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  7 Mar 2024 10:07:16 +0000 you wrote:
> Apply the same fix than ones found in :
> 
> 8d975c15c0cd ("ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()")
> 1ca1ba465e55 ("geneve: make sure to pull inner header in geneve_rx()")
> 
> We have to save skb->network_header in a temporary variable
> in order to be able to recompute the network_header pointer
> after a pskb_inet_may_pull() call.
> 
> [...]

Here is the summary with links:
  - [net] net: ip_tunnel: make sure to pull inner header in ip_tunnel_rcv()
    https://git.kernel.org/netdev/net/c/b0ec2abf9826

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



