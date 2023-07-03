Return-Path: <netdev+bounces-15057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E2745737
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA94A1C208E3
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1509D3D68;
	Mon,  3 Jul 2023 08:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5E20EF
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7E17C43215;
	Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688372422;
	bh=GAdkZrdoKWD7YyzDP8ANymefO04wUe7jKXHOYI0JvAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JOvpxdIGeaV0pdDRSr0O5u0avi/sD+ggbLk1bJO5icXqWRlhcCGWiUmErpMum5SN2
	 UmenbWL94IdusSUdkoxIcOmb8uFVJVDSvRrFWDFyvfuKGj4+UkEdb4O3cBOZ67sFOs
	 X4k0VsnwUdlE7L4UN+C8F0yolhb5FkqbVPq8VmNtHUDZ/4LiOlYT0BbrXwvjut4iM/
	 4b8kECPQ41MhyrEat0zPWUnaBjOG4pdlfO5HN36CjEZqu2SFZVWKbS0mZOLsJjF1u+
	 N3qbafx/sjDRzdgsXrMPXwWN+uhFVVLMVKjGBV08nyDdUK55oh2E/ECNlxWn8+0PaN
	 V2s7G2bqmU4OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D0ACC691F1;
	Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bridge: keep ports without IFF_UNICAST_FLT in
 BR_PROMISC mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168837242257.9798.3078714826638477204.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jul 2023 08:20:22 +0000
References: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, roopa@nvidia.com, razor@blackwall.org,
 idosch@nvidia.com, mst@redhat.com, vyasevic@redhat.com,
 bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 30 Jun 2023 19:41:18 +0300 you wrote:
> According to the synchronization rules for .ndo_get_stats() as seen in
> Documentation/networking/netdevices.rst, acquiring a plain spin_lock()
> should not be illegal, but the bridge driver implementation makes it so.
> 
> After running these commands, I am being faced with the following
> lockdep splat:
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
    https://git.kernel.org/netdev/net/c/6ca3c005d060

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



