Return-Path: <netdev+bounces-185117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2DA98939
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146503B8E70
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495A020F09B;
	Wed, 23 Apr 2025 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzfrqKkB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F52046A6;
	Wed, 23 Apr 2025 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410194; cv=none; b=Mnqe5ZutrpYNZRKnYa1vIznM+honeyFTG05YV8kXxqZKwsSIfDzddE628ypJLx+XnOHl1ybwCcae6EpKcA7nuZtaO6c5Lhb0J8qxNz9fNK0hWzhIASpkZ3VYBES9tpNHDLSYIBXqGGSpqi3GPf/uZCk6m3wEJk43QcdzE9sxX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410194; c=relaxed/simple;
	bh=vLcN7g+Ja3SMZ8nPqxXia6WWcptQ6SSpe51JHAKGj3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hodAdpGJpR1uvV/7ncYw5lQkmYa5zLuqh7/OktagoG51jhvKwXLjfR7sVQJlNS39w0sO1qvJJun6fuqMxeDBTDCZMM5pc+xds3+FQ56nkoom4ePFq20msif++39ohm0YpDL9oflGa9TiMTzo4Ubf0L8xGZB+1Aw2OHfLM2girww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzfrqKkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D106C4CEE2;
	Wed, 23 Apr 2025 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410193;
	bh=vLcN7g+Ja3SMZ8nPqxXia6WWcptQ6SSpe51JHAKGj3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QzfrqKkBtfNxajJRAcZknTpFhojVGQXG36rEu6hhtJxQ5fPTjvtMMU41RYai1F8Rh
	 0ZoSZRpzaUA5+9UI3jj+gemszNK/wNMWK6XVjIz8A27I9BNWO9DJXFVFVNgpPlGBhB
	 6A+37fR8BhD3AWira9Goi+fHGl0O0fk0Y2GmhWvFMM8W7f7EYCfmYTKIdx8BXUNhiw
	 k0VBaRZBkJPtbfuA9wc7zMyerXiPN+DNpuWKsv3FPU4NTFuQYjP6xrSVMQSK3WDndS
	 x5WkZl9SR2a2UDv6v2nFZWP46FJ3K3uH0u2RdoPc6POkvb5KgWgAwnZT6T7Anwh+X3
	 k2oDIp6PzlkNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE58380CED9;
	Wed, 23 Apr 2025 12:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] bridge: multicast: per vlan query improvement
 when port or vlan state changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174541023175.2604292.4001892845158453419.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 12:10:31 +0000
References: <cover.1744896433.git.petrm@nvidia.com>
In-Reply-To: <cover.1744896433.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 razor@blackwall.org, idosch@nvidia.com, bridge@lists.linux.dev,
 yongwang@nvidia.com, aroulin@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 17 Apr 2025 15:43:11 +0200 you wrote:
> From: Yong Wang <yongwang@nvidia.com>
> 
> The current implementation of br_multicast_enable_port() only operates on
> port's multicast context, which doesn't take into account in case of vlan
> snooping, one downside is the port's igmp query timer will NOT resume when
> port state gets changed from BR_STATE_BLOCKING to BR_STATE_FORWARDING etc.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions
    https://git.kernel.org/netdev/net-next/c/4b30ae9adb04
  - [net-next,2/3] net: bridge: mcast: update multicast contex when vlan state is changed
    https://git.kernel.org/netdev/net-next/c/6c131043eaf1
  - [net-next,3/3] selftests: net/bridge : add tests for per vlan snooping with stp state changes
    https://git.kernel.org/netdev/net-next/c/aea45363e29d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



