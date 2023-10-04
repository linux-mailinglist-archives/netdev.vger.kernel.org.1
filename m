Return-Path: <netdev+bounces-38039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 960867B8B44
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 3D1F61F22CF6
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E43D1F61F;
	Wed,  4 Oct 2023 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSPreQFq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B01B27F
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 18:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9682CC433C9;
	Wed,  4 Oct 2023 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696445425;
	bh=rhH3BM3l5U/8ZimBx6sUN349z/3o89boKoRJJhgmjRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QSPreQFq7IsrWZOLfAxefSThxr0tGvRqdC+jfcIUIHXrAL8bi0UdeWzv0d8ZNYfx4
	 uyLAWn6GCJPBoTX5rb8DogE/vkBcIiw3eDV0sgytYOba6vc1ZyiF4rkTXvmuTKZRCC
	 I05uWT5A0J49VKoyfo6nyjFSCX3tPSs4EMy0LJaNQr9HdZhkrE70G1PA4saHPfMbBP
	 dANsdXIOVdfGdvWFROzjw3kPlZn/h0W/VCN6iD10LfHhln+4T6CTwuVTGFkR+fO6cS
	 LIfZMutt0t5K7vSvJgKyyQ74JFyMsF+CHM6kA9dBI9Ov1ZV8u6eHjSe5i6wUQrqynt
	 neXkNuX52nGyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BC04C395EC;
	Wed,  4 Oct 2023 18:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: Set offload_failed flag in fibmatch results
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169644542550.13943.9248162999887305594.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 18:50:25 +0000
References: <20230926182730.231208-1-bpoirier@nvidia.com>
In-Reply-To: <20230926182730.231208-1-bpoirier@nvidia.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, amcohen@nvidia.com,
 idosch@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Sep 2023 14:27:30 -0400 you wrote:
> Due to a small omission, the offload_failed flag is missing from ipv4
> fibmatch results. Make sure it is set correctly.
> 
> The issue can be witnessed using the following commands:
> echo "1 1" > /sys/bus/netdevsim/new_device
> ip link add dummy1 up type dummy
> ip route add 192.0.2.0/24 dev dummy1
> echo 1 > /sys/kernel/debug/netdevsim/netdevsim1/fib/fail_route_offload
> ip route add 198.51.100.0/24 dev dummy1
> ip route
> 	# 192.168.15.0/24 has rt_trap
> 	# 198.51.100.0/24 has rt_offload_failed
> ip route get 192.168.15.1 fibmatch
> 	# Result has rt_trap
> ip route get 198.51.100.1 fibmatch
> 	# Result differs from the route shown by `ip route`, it is missing
> 	# rt_offload_failed
> ip link del dev dummy1
> echo 1 > /sys/bus/netdevsim/del_device
> 
> [...]

Here is the summary with links:
  - [net] ipv4: Set offload_failed flag in fibmatch results
    https://git.kernel.org/netdev/net/c/0add5c597f32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



