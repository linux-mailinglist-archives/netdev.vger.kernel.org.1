Return-Path: <netdev+bounces-81360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31971887652
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 02:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA931F23365
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922751113;
	Sat, 23 Mar 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur7mio/5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1AEEC2
	for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711156229; cv=none; b=ATZ5SwAE678BeHho9p/B6tmZB7u9VonBrV7O92wBtiwrcTec5nb3K1YKEWtinKNoXZvf1pbfnNo/Q1QAlD4sEP2Byv9OJiDVRaXf2C1v8f2x8raepQqDe6JP0bS4Q2/TrIUX5LDeFJlb+ZUZT4jLpv/VCY56bo5PhekHIjCYLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711156229; c=relaxed/simple;
	bh=76zZX1yhYwHO2/fPt+t03Gl/RM5sq4kC7aFx99qr+9c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FD4QXu1TB9R81aXjzGVomSNwCnzE25ZFsqTqD5VouDQKzIqy5HQC4JBsjNyFPmKqF8GmyvkKHuVi86ZE7AiI3+COgrSogyXBN53gMSdheQP0PJ6koAWsDcNT8+Qf3BEA2Zty/PQmlWE1mNweBCqf2Th1mQMHi6LFqSWtwgPPrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur7mio/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECDA0C433F1;
	Sat, 23 Mar 2024 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711156229;
	bh=76zZX1yhYwHO2/fPt+t03Gl/RM5sq4kC7aFx99qr+9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ur7mio/5qrH5mtWQkCezhaeCOh7vUYbJw8pEtzoELUSSBDzJoxBHhKSmZo/+t+2Tr
	 TRM9d29IelLv84IBXQ50530Fj5JypK0kSps/GmOTJvKONEtXzIOnMDodSP3GeXsbTw
	 j4hfCoj4a0h64Atn5ipus+PNSrwhA1OzFxxmGNNVOi3sNFDvlNvUo8IEs2rBPrLhkQ
	 b748JwXgDncQHvCIHjjG2zsBw+xd9QCyVxJeCo7uxrWjUyvNV3UYKQakY5SOG/u1Qy
	 iHNM5k3ITb0E73sgUfnSsdcif7BY4tfHxVL9mr01KG22yKu2Woh7+peSo9yIOmwnjK
	 RBm/XN3kSwz0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D271FD8BCE5;
	Sat, 23 Mar 2024 01:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: Fix address dump when IPv6 is disabled on an
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171115622885.16003.10350542958984410696.git-patchwork-notify@kernel.org>
Date: Sat, 23 Mar 2024 01:10:28 +0000
References: <20240321173042.2151756-1-idosch@nvidia.com>
In-Reply-To: <20240321173042.2151756-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, gal@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Mar 2024 19:30:42 +0200 you wrote:
> Cited commit started returning an error when user space requests to dump
> the interface's IPv6 addresses and IPv6 is disabled on the interface.
> Restore the previous behavior and do not return an error.
> 
> Before cited commit:
> 
>  # ip address show dev dummy1
>  2: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
>      link/ether 1a:52:02:5a:c2:6e brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::1852:2ff:fe5a:c26e/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>  # ip link set dev dummy1 mtu 1000
>  # ip address show dev dummy1
>  2: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1000 qdisc noqueue state UNKNOWN group default qlen 1000
>      link/ether 1a:52:02:5a:c2:6e brd ff:ff:ff:ff:ff:ff
> 
> [...]

Here is the summary with links:
  - [net] ipv6: Fix address dump when IPv6 is disabled on an interface
    https://git.kernel.org/netdev/net/c/c04f7dfe6ec2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



