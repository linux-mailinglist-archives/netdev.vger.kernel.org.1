Return-Path: <netdev+bounces-35691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F4D7AAA42
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 63AF11F2222D
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275E718AF9;
	Fri, 22 Sep 2023 07:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4615AC7
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 07:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DC6BC433C9;
	Fri, 22 Sep 2023 07:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695367825;
	bh=aa4BxjPwXSMGcRd3j+W0FsFIluA0XqusP+L+BgKB/Bc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vezckz3Zw31YpZIVkDUbeI5QiS2RnP1LOWHckJVPVp/BZVJLMFytgu252T6NW5MBA
	 /vnIPxbv/ZsaTeaywfSr6pB42eb/M22KZedQIRSDQEw+5tqbAk9d0wB7SkUzj2Y3Ah
	 jlrJZIJUtsXai8xfJArciP96Dc48NTWQiwfmHdV0YjnaI9om8InAO/gDOxG/7MZUJF
	 q09ls9lvK4wGSpCVHzyw7fcGDIaxIuGC4BfrylffNd0OKMpLRf52tvJPk99HMGGeZK
	 Il9JPOfTpYsxupSK3IB278MXAnHKdwyaifG/D+8Q4jQaSJhslzvO7og2Lex4C+c5Ah
	 UVZ3oXE8y1RZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64FFDE11F5C;
	Fri, 22 Sep 2023 07:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] mlxsw: Improve blocks selection for IPv6
 multicast forwarding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169536782540.11432.12690951867009056734.git-patchwork-notify@kernel.org>
Date: Fri, 22 Sep 2023 07:30:25 +0000
References: <cover.1695137616.git.petrm@nvidia.com>
In-Reply-To: <cover.1695137616.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Sep 2023 17:42:53 +0200 you wrote:
> Amit Cohen writes:
> 
> The driver configures two ACL regions during initialization, these regions
> are used for IPv4 and IPv6 multicast forwarding. Entries residing in these
> two regions match on the {SIP, DIP, VRID} key elements.
> 
> Currently for IPv6 region, 9 key blocks are used. This can be improved by
> reducing the amount key blocks needed for the IPv6 region to 8. It is
> possible to use key blocks that mix subsets of the VRID element with
> subsets of the DIP element.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] mlxsw: Add 'ipv4_5' flex key
    https://git.kernel.org/netdev/net-next/c/c2f3e10ac4eb
  - [net-next,v2,2/3] mlxsw: spectrum_acl_flex_keys: Add 'ipv4_5b' flex key
    https://git.kernel.org/netdev/net-next/c/c6caabdf3e0c
  - [net-next,v2,3/3] mlxsw: Edit IPv6 key blocks to use one less block for multicast forwarding
    https://git.kernel.org/netdev/net-next/c/92953e7aab01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



