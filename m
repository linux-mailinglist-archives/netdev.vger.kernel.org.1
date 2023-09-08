Return-Path: <netdev+bounces-32534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B15D798316
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 09:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEB4281874
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566161869;
	Fri,  8 Sep 2023 07:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BD31867
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 07:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 269C9C433CA;
	Fri,  8 Sep 2023 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694157023;
	bh=KqR0SfhcCdqC9RvqA2UzD/ZqzMk3ec2MDaruKP55Ae0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fwiGikthw32Z95s39hP8HnO/odMNjTLw7VtAOPZyR3I7KEO8Hv9c2DimBqJFC1cyd
	 yriFHMUEZcyZ073gnp+EBvH1k8KtO6GgIiXZtep5364iBMTNDoD+DlREFhJuR+Hgro
	 5BNy3j47mrrH7JPC4JL83YvNvHxJ94TeDLMQ75QAfwJ89yH4YFckRsIS2xt3hysX5k
	 Ts/BUKsC1XLqjBRickl57PG8Jqy7pQfwTZZ75qngB/wpYjDR/ol1MMOlVrwD+l6A0f
	 2Le6BDioiI0nBEX9L619niKbgRkNtgbh0n1uUli/5xmZSEct+zv75BPVUf4cWz25K3
	 R08yNzSHtzvPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09DEAE29F36;
	Fri,  8 Sep 2023 07:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ipv4: fix one memleak in __inet_del_ifa()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169415702303.20332.14588021051879972271.git-patchwork-notify@kernel.org>
Date: Fri, 08 Sep 2023 07:10:23 +0000
References: <20230907025709.3409515-1-liujian56@huawei.com>
In-Reply-To: <20230907025709.3409515-1-liujian56@huawei.com>
To: liujian (CE) <liujian56@huawei.com>
Cc: ja@ssi.bg, davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hadi@cyberus.ca, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 7 Sep 2023 10:57:09 +0800 you wrote:
> I got the below warning when do fuzzing test:
> unregister_netdevice: waiting for bond0 to become free. Usage count = 2
> 
> It can be repoduced via:
> 
> ip link add bond0 type bond
> sysctl -w net.ipv4.conf.bond0.promote_secondaries=1
> ip addr add 4.117.174.103/0 scope 0x40 dev bond0
> ip addr add 192.168.100.111/255.255.255.254 scope 0 dev bond0
> ip addr add 0.0.0.4/0 scope 0x40 secondary dev bond0
> ip addr del 4.117.174.103/0 scope 0x40 dev bond0
> ip link delete bond0 type bond
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ipv4: fix one memleak in __inet_del_ifa()
    https://git.kernel.org/netdev/net/c/ac28b1ec6135

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



