Return-Path: <netdev+bounces-165019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA77A30164
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2143A32E9
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16A126BDAE;
	Tue, 11 Feb 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB0ANQiT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65626BD92
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739240406; cv=none; b=F7dLiLk3HBnOsqSwDnYIA1HezNNvTvOlAffTm4kcqXoEMt+k1Q7+nq9rJLf0A8JYzhY+j5jyQ38PF3i58XFI5hwiv9dW8C52cL3j5j5ovo2b+l5rr1o7QOUqsWTlF1NaEYWXONQTQ/GSdBaDHQqiAAm0VMzeBd1vHEEwxQ045k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739240406; c=relaxed/simple;
	bh=Udl6tAWiWvjs8bz2XMX2HX45zAXK/jzTJp/So4sYzUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sVQFoA5Ei4z+R+kTKm6FTa/cTXeDkbJqXopxLmWxCM31+Xd3SUiBRa9LjnB0xkQVHdw/OxHdCM7ZC6xzuXZ+bTbISRJ3go3oJ6H1lsczeOSfTU4Jhq5wJEkJlyuzy3ysO+vfMUbN0u3KXE/gScU2xbgtLJJB+RL9Hzu6gjfyaCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB0ANQiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2403CC4CED1;
	Tue, 11 Feb 2025 02:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739240406;
	bh=Udl6tAWiWvjs8bz2XMX2HX45zAXK/jzTJp/So4sYzUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CB0ANQiTWCkLI12rpBpsyEsPapz+eH2WdwpG9dy4yU9BuqA+iFRBR1Q7EDrf4fIGc
	 rhISgAVJJKz7tRuF+9sbiBVOiF2AxBIyNnddZa96D2ZjknKQJt7wqkthoV9AhxSlz4
	 bKOmGuFaxZgtNwM+osLR6gTdE02wJH+06DIS0ACLEzeqVmcIk1ZBLIuCEUwSBsmvqv
	 S+449euqfD+O7lHmpld57nURYTtGvBAqCXQBjnzGdvOZ1PpRbAjib+u1jwhDT8Z4+1
	 gmRS3PtvYa+X/Y2HyHutR2DBeRjadN7H0LDSzC0KxhtH2lw8InEm+ekIFu2q4xMkSa
	 edr//NBlk4tOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4AB380AA7A;
	Tue, 11 Feb 2025 02:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8] net: second round to use dev_net_rcu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173924043476.3915440.8394495190939470240.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 02:20:34 +0000
References: <20250207135841.1948589-1-edumazet@google.com>
In-Reply-To: <20250207135841.1948589-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 horms@kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Feb 2025 13:58:32 +0000 you wrote:
> dev_net(dev) should either be protected by RTNL or RCU.
> 
> There is no LOCKDEP support yet for this helper.
> 
> Adding it would trigger too many splats.
> 
> This second series fixes some of them.
> 
> [...]

Here is the summary with links:
  - [net,1/8] ndisc: ndisc_send_redirect() must use dev_get_by_index_rcu()
    https://git.kernel.org/netdev/net/c/48145a57d4bb
  - [net,2/8] ndisc: use RCU protection in ndisc_alloc_skb()
    https://git.kernel.org/netdev/net/c/628e6d18930b
  - [net,3/8] neighbour: use RCU protection in __neigh_notify()
    https://git.kernel.org/netdev/net/c/becbd5850c03
  - [net,4/8] arp: use RCU protection in arp_xmit()
    https://git.kernel.org/netdev/net/c/a42b69f69216
  - [net,5/8] openvswitch: use RCU protection in ovs_vport_cmd_fill_info()
    https://git.kernel.org/netdev/net/c/90b2f49a502f
  - [net,6/8] vrf: use RCU protection in l3mdev_l3_out()
    https://git.kernel.org/netdev/net/c/6d0ce46a9313
  - [net,7/8] ndisc: extend RCU protection in ndisc_send_skb()
    https://git.kernel.org/netdev/net/c/ed6ae1f325d3
  - [net,8/8] ipv6: mcast: extend RCU protection in igmp6_send()
    https://git.kernel.org/netdev/net/c/087c1faa594f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



