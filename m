Return-Path: <netdev+bounces-41190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1297CA30C
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D2928156C
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5A51A59D;
	Mon, 16 Oct 2023 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYebKGr1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36A1A58C
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B7C0C433CC;
	Mon, 16 Oct 2023 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697446825;
	bh=NW9DlooEk/8D5F8mBI9PtB9cSzq23dm5wLvyptIwSks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gYebKGr1jBoJa6pNw0PHBvY6lh+NfkAjJH/uQlBtFHxNIZgTzpf2sv9AEJxVEdpIZ
	 ILu2nP7ScRlbrwaEHzJEwl34EMpelvxX0+VJDP7SLYxzUSibIQ6x0TXJYOeMS4DC7T
	 siXR7HBxu4Ipdw1ozRSxo0QBpsg8FpLIX1upWSrxUMb4JVG3O2mOdCM/nM38INZzkO
	 p98Xdcrq3yyMl8sxGuI0NS+/0QgpsqIDjTVzboG75u39bga9jamq2acRu42vTPRKV1
	 gaW2dWSysVQ6nx6wV8qOb+tTcCp8WqmeTzRdz0Juc2DkrxCzHc2SFMypYyrm0qKB8a
	 Ml1UfMM7FKnXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1636EC41671;
	Mon, 16 Oct 2023 09:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] net: consolidate IPv4 route lookup for UDP
 tunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169744682508.7474.11859818002132979363.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 09:00:25 +0000
References: <20231016071526.2958108-1-b.galvani@gmail.com>
In-Reply-To: <20231016071526.2958108-1-b.galvani@gmail.com>
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, gnault@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 16 Oct 2023 09:15:19 +0200 you wrote:
> At the moment different UDP tunnels rely on different functions for
> IPv4 route lookup, and those functions all implement the same
> logic. Only bareudp uses the generic ip_route_output_tunnel(), while
> geneve and vxlan basically duplicate it slightly differently.
> 
> This series first extends the generic lookup function so that it is
> suitable for all UDP tunnel implementations. Then, bareudp, geneve and
> vxlan are adapted to use them.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] ipv4: rename and move ip_route_output_tunnel()
    https://git.kernel.org/netdev/net-next/c/bf3fcbf7e7a0
  - [net-next,v2,2/7] ipv4: remove "proto" argument from udp_tunnel_dst_lookup()
    https://git.kernel.org/netdev/net-next/c/78f3655adcb5
  - [net-next,v2,3/7] ipv4: add new arguments to udp_tunnel_dst_lookup()
    https://git.kernel.org/netdev/net-next/c/72fc68c6356b
  - [net-next,v2,4/7] ipv4: use tunnel flow flags for tunnel route lookups
    https://git.kernel.org/netdev/net-next/c/3ae983a603a4
  - [net-next,v2,5/7] geneve: add dsfield helper function
    https://git.kernel.org/netdev/net-next/c/60a77d11cd5d
  - [net-next,v2,6/7] geneve: use generic function for tunnel IPv4 route lookup
    https://git.kernel.org/netdev/net-next/c/daa2ba7ed1d1
  - [net-next,v2,7/7] vxlan: use generic function for tunnel IPv4 route lookup
    https://git.kernel.org/netdev/net-next/c/6f19b2c136d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



