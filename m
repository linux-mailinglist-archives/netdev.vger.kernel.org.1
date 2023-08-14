Return-Path: <netdev+bounces-27243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5958A77B23C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC721C209D2
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3F79FA;
	Mon, 14 Aug 2023 07:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03F8838
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E9F5C433C8;
	Mon, 14 Aug 2023 07:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691997622;
	bh=Uz+WeVRfg4rzHTeivMQGhJjhj0XJjfH0fRwDnlldlKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pwwkPp2D9XG7RiJ1kQ0Mcb0aEOBuRMljvXwq8chlP+HvnwbEEwZMZSX0op9POU04Q
	 k1GTMldG9dQ4xu9GipjGIeyshGUOsMukX+9vrsJMMBj1sGQa4mUcNt0ungOiiyenCt
	 o60AiPz10nDrBzfOPNJQBJAB0GKjtg3oyc0Vd6D0vLkFlhSRYy+zp36lhU543VdrRR
	 A+7TgbLl5pivbRixAaqFfjo+fco9+XObMkY9uvUXJuWw2tKRdxm3XvCQRJJGHiV6w3
	 qKUf8BRwRpWS2CRh3Si5XJn2U4VvyRK4STEb8JtihdGGGZ5GiX3TLbacL5naHQnTl+
	 4g0gZ9cPmqa0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B4D9E93B34;
	Mon, 14 Aug 2023 07:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mlxsw: Support traffic redirection from a locked
 bridge port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169199762217.17065.15892726153785120863.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 07:20:22 +0000
References: <cover.1691764353.git.petrm@nvidia.com>
In-Reply-To: <cover.1691764353.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 17:13:54 +0200 you wrote:
> Ido Schimmel writes:
> 
> It is possible to add a filter that redirects traffic from the ingress
> of a bridge port that is locked (i.e., performs security / SMAC lookup)
> and has learning enabled. For example:
> 
>  # ip link add name br0 type bridge
>  # ip link set dev swp1 master br0
>  # bridge link set dev swp1 learning on locked on mab on
>  # tc qdisc add dev swp1 clsact
>  # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw src_ip 192.0.2.1 action mirred egress redirect dev swp2
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] mlxsw: core_acl_flex_actions: Add IGNORE_ACTION
    https://git.kernel.org/netdev/net-next/c/d0d449c74764
  - [net-next,2/4] mlxsw: spectrum_flower: Disable learning and security lookup when redirecting
    https://git.kernel.org/netdev/net-next/c/0433670e136a
  - [net-next,3/4] mlxsw: spectrum: Stop ignoring learning notifications from redirected traffic
    https://git.kernel.org/netdev/net-next/c/9793a5a9c493
  - [net-next,4/4] selftests: forwarding: Add test case for traffic redirection from a locked port
    https://git.kernel.org/netdev/net-next/c/38c43a1ce758

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



