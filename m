Return-Path: <netdev+bounces-26074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C747C776B9D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009971C21365
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91B1DDCD;
	Wed,  9 Aug 2023 22:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E11DA5E
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 22:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB74BC433C9;
	Wed,  9 Aug 2023 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691618424;
	bh=f20RnMof5hcae+1ceIXNf9PDzncyKiW/dYQx5WtdEPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q3LORKUnBgO04v0W0sCn9yKifmNybeI9W+cChuUu5Kz+gaklxZRYN99QMcXhL/EDK
	 c8AXQwchaNqoKLUbxD+4aDuqXOi04AVWEbJwzJic3n/yazkZoHv+9eT0KIRXc20XTP
	 x1AsiY8QlqbB8rWKBmWwzej+LvsWG++U+U+nNQ41W7T5oH0fDqyql0utbpjWRzWEeU
	 iXnI0+LT41Lpdgy7rmvSTGie+FuR7D4A/yekhvSdfpYuXtlT6z4+d4/RVF30j2bhr2
	 8+PEcQ8OgZBdy0rBOmq+QHvde4n4ZJoCjz2nByRrNqD0aOX+jaI2r9wPdG3ucUwBfB
	 kHvYEAIiyieKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C879E505D5;
	Wed,  9 Aug 2023 22:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 00/17] selftests: forwarding: Various fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161842456.3160.10181033953459464661.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 22:00:24 +0000
References: <20230808141503.4060661-1-idosch@nvidia.com>
In-Reply-To: <20230808141503.4060661-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com,
 razor@blackwall.org, mirsad.todorovac@alu.unizg.hr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Aug 2023 17:14:46 +0300 you wrote:
> Fix various problems with forwarding selftests. See individual patches
> for problem description and solution.
> 
> v2:
> * Patch #10: Probe for MAC Merge support.
> 
> Ido Schimmel (17):
>   selftests: forwarding: Skip test when no interfaces are specified
>   selftests: forwarding: Switch off timeout
>   selftests: forwarding: bridge_mdb: Check iproute2 version
>   selftests: forwarding: bridge_mdb_max: Check iproute2 version
>   selftests: forwarding: Set default IPv6 traceroute utility
>   selftests: forwarding: Add a helper to skip test when using veth pairs
>   selftests: forwarding: ethtool: Skip when using veth pairs
>   selftests: forwarding: ethtool_extended_state: Skip when using veth
>     pairs
>   selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
>   selftests: forwarding: ethtool_mm: Skip when MAC Merge is not
>     supported
>   selftests: forwarding: tc_actions: Use ncat instead of nc
>   selftests: forwarding: tc_flower: Relax success criterion
>   selftests: forwarding: tc_tunnel_key: Make filters more specific
>   selftests: forwarding: tc_flower_l2_miss: Fix failing test with old
>     libnet
>   selftests: forwarding: bridge_mdb: Fix failing test with old libnet
>   selftests: forwarding: bridge_mdb_max: Fix failing test with old
>     libnet
>   selftests: forwarding: bridge_mdb: Make test more robust
> 
> [...]

Here is the summary with links:
  - [net,v2,01/17] selftests: forwarding: Skip test when no interfaces are specified
    https://git.kernel.org/netdev/net/c/d72c83b1e4b4
  - [net,v2,02/17] selftests: forwarding: Switch off timeout
    https://git.kernel.org/netdev/net/c/0529883ad102
  - [net,v2,03/17] selftests: forwarding: bridge_mdb: Check iproute2 version
    https://git.kernel.org/netdev/net/c/ab2eda04e2c2
  - [net,v2,04/17] selftests: forwarding: bridge_mdb_max: Check iproute2 version
    https://git.kernel.org/netdev/net/c/6bdf3d9765f4
  - [net,v2,05/17] selftests: forwarding: Set default IPv6 traceroute utility
    https://git.kernel.org/netdev/net/c/38f7c44d6e76
  - [net,v2,06/17] selftests: forwarding: Add a helper to skip test when using veth pairs
    https://git.kernel.org/netdev/net/c/66e131861ab7
  - [net,v2,07/17] selftests: forwarding: ethtool: Skip when using veth pairs
    https://git.kernel.org/netdev/net/c/60a36e21915c
  - [net,v2,08/17] selftests: forwarding: ethtool_extended_state: Skip when using veth pairs
    https://git.kernel.org/netdev/net/c/b3d9305e60d1
  - [net,v2,09/17] selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
    https://git.kernel.org/netdev/net/c/9a711cde07c2
  - [net,v2,10/17] selftests: forwarding: ethtool_mm: Skip when MAC Merge is not supported
    https://git.kernel.org/netdev/net/c/23fb886a1ced
  - [net,v2,11/17] selftests: forwarding: tc_actions: Use ncat instead of nc
    https://git.kernel.org/netdev/net/c/5e8670610b93
  - [net,v2,12/17] selftests: forwarding: tc_flower: Relax success criterion
    https://git.kernel.org/netdev/net/c/9ee37e53e768
  - [net,v2,13/17] selftests: forwarding: tc_tunnel_key: Make filters more specific
    https://git.kernel.org/netdev/net/c/11604178fdc3
  - [net,v2,14/17] selftests: forwarding: tc_flower_l2_miss: Fix failing test with old libnet
    https://git.kernel.org/netdev/net/c/21a72166abb9
  - [net,v2,15/17] selftests: forwarding: bridge_mdb: Fix failing test with old libnet
    https://git.kernel.org/netdev/net/c/e98e195d90cc
  - [net,v2,16/17] selftests: forwarding: bridge_mdb_max: Fix failing test with old libnet
    https://git.kernel.org/netdev/net/c/cb034948ac29
  - [net,v2,17/17] selftests: forwarding: bridge_mdb: Make test more robust
    https://git.kernel.org/netdev/net/c/8b5ff3709777

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



