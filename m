Return-Path: <netdev+bounces-153810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1608E9F9BF0
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE80F188CCFD
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE48E1A3BC8;
	Fri, 20 Dec 2024 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po+DEG0M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F0225A37;
	Fri, 20 Dec 2024 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730215; cv=none; b=ChsAmf+lODf8HX/Sbg5TE5KAaXtSzJImJdF+Qlwyq9dr891HZ51tW4JbBXlVn2ZdLBTUtfHNaB7rVUvo6Im/yjHl3w909lydPoxTRhfyVTdD98LOVnVEDWURCjbMCUytM6gY7eGqSzsR9Bzzv7xJclfq8Qbqs1365sQHtLaJuDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730215; c=relaxed/simple;
	bh=ERaXlJ2GMZweOfBrG+AtS6IoLfxVzT3Gkn6ZKWVuNcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RpvBwrM29zCwD4vE+Bv/3ynR/9jDwp+ItYXb7ijU72jGaF7pyB/pF4A1URRfooSpI9cSBU04uhhyLhkEM6kvO8B6ZlpQutxBUyF8FLcBkyKv1P2Gh8hnvqbkBzY9tZ4ob692lNxWx+7oUB7LxRtRm51d/OWEWwtRIxJRJLhKQ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=po+DEG0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCCEC4CECD;
	Fri, 20 Dec 2024 21:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734730215;
	bh=ERaXlJ2GMZweOfBrG+AtS6IoLfxVzT3Gkn6ZKWVuNcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=po+DEG0MPY3wp6ZvtbKWurCpunxlGTgrfUuXK8MHOFLRfmZDXF8fA/9sBdLlrKTxA
	 hFz6ro+jNaKP4h95S9iAC7aZ1N8T58LqVhf/4k6GKTa5Djg48Pjmrwtnd+iO+dxf8i
	 C/A1lh1X5VZC37YGobiaCqiOISgg+dTgCNTeAbXLLiuqv2CMGLZxysJxeiRZX0VPfX
	 8WWWHDz+n4airRCdAJvCC3FLwMrAWN1eAw6gGnDEZ1vikmiMfpQgYxdPOA3AzBHMk5
	 p12nQcR6+eONrgzeDcRb0p5drZVKt1qHGpgihwhQfPAxx7ZKlf2nzLU1gQ81eAeLI/
	 KeBYNQ/sU/3Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C6E3806656;
	Fri, 20 Dec 2024 21:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] bridge: Handle changes in
 VLAN_FLAG_BRIDGE_BINDING
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173473023300.3026071.14622762592907631382.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 21:30:33 +0000
References: <cover.1734540770.git.petrm@nvidia.com>
In-Reply-To: <cover.1734540770.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 idosch@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Dec 2024 18:15:55 +0100 you wrote:
> When bridge binding is enabled on a VLAN netdevice, its link state should
> track bridge ports that are members of the corresponding VLAN. This works
> for a newly-added netdevices. However toggling the option does not have the
> effect of enabling or disabling the behavior as appropriate.
> 
> In this patchset, have bridge react to bridge_binding toggles on VLAN
> uppers.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: bridge: Extract a helper to handle bridge_binding toggles
    https://git.kernel.org/netdev/net-next/c/f284424dc17b
  - [net-next,2/4] net: bridge: Handle changes in VLAN_FLAG_BRIDGE_BINDING
    https://git.kernel.org/netdev/net-next/c/3abd45122c72
  - [net-next,3/4] selftests: net: lib: Add a couple autodefer helpers
    https://git.kernel.org/netdev/net-next/c/976d248bd333
  - [net-next,4/4] selftests: net: Add a VLAN bridge binding selftest
    https://git.kernel.org/netdev/net-next/c/dca12e9ab760

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



