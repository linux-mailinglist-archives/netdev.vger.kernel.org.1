Return-Path: <netdev+bounces-94009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E528BDEC6
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73D71C22978
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9DF15350E;
	Tue,  7 May 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oedb7Fnv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926D14E2DA
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074842; cv=none; b=fqnRwIATz3OON8BW9XMzHJhkrxKIUKOBZd9iKrVt5p0WPjtl8u9k10Jc/pYjwGA8oGCOwaeSlxdlLoqfy1yV0tlunEOGO4pvEXmnmaQW2xZ41Hh7W62HORLBF9kDYXHPn6Lol6EYD8jw5XS/TmFsVIxWt+5Bt2cQDjfsVrM73jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074842; c=relaxed/simple;
	bh=My6PzD7lp7WpGlcSquAFqoh0eASe6/Q/g2eMw2R99Mc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DYlRgt4QVWppFO0SkeOa+coRFtiumQV01q8YAFzXBIVSMkQ3kMB/i0BnL1bq04nG8FTiakJ8+p43Yt0OR/cvoxb54csZAxlttwfl/xSSSY3cuJhYBaG+asNwiQXCqy2gSBMXpPPpq7yD8bs5OKhfDghTUgYhAMzb9oR/LrQU2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oedb7Fnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9430C4AF66;
	Tue,  7 May 2024 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715074841;
	bh=My6PzD7lp7WpGlcSquAFqoh0eASe6/Q/g2eMw2R99Mc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oedb7FnvVvlY1rP1Sj8CDFdSLWoOMJz/LCTyHSp318FryKDsHCuZa25VritEIqh/9
	 h/ni0SeFchYq0AovInXMAQsd2j/7fIwenxfMvVBVTahgsanRNFUPXTih8Hi7WmFi0y
	 YNx1cczyMRrfSkIumEpGmRmFww6kbr91RVINDWaY9iGwOdv8t9eYDZUYCGQYlPT5/s
	 uljYRTtd74pKtrNlHhZmcptimab/4CySr8sTIXoUmFAlCFn+eBvCnEVIHzoUnKtE/7
	 SFKcD8Np/S0QdIeq4cAAmn2WEN+NzNkJoXFcRzRK8gOxXqNfOrKYLy516+CGIHtOPv
	 kZhmwMyCb7DkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0A6EC43331;
	Tue,  7 May 2024 09:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] rtnetlink: more rcu conversions for
 rtnl_fill_ifinfo()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171507484172.24942.8367903904443484222.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 09:40:41 +0000
References: <20240503192059.3884225-1-edumazet@google.com>
In-Reply-To: <20240503192059.3884225-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 May 2024 19:20:51 +0000 you wrote:
> We want to no longer rely on RTNL for "ip link show" command.
> 
> This is a long road, this series takes care of some parts.
> 
> Eric Dumazet (8):
>   rtnetlink: do not depend on RTNL for IFLA_QDISC output
>   rtnetlink: do not depend on RTNL for IFLA_IFNAME output
>   rtnetlink: do not depend on RTNL for IFLA_TXQLEN output
>   net: write once on dev->allmulti and dev->promiscuity
>   rtnetlink: do not depend on RTNL for many attributes
>   rtnetlink: do not depend on RTNL in rtnl_fill_proto_down()
>   rtnetlink: do not depend on RTNL in rtnl_xdp_prog_skb()
>   rtnetlink: allow rtnl_fill_link_netnsid() to run under RCU protection
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] rtnetlink: do not depend on RTNL for IFLA_QDISC output
    https://git.kernel.org/netdev/net-next/c/698419ffb6fc
  - [net-next,2/8] rtnetlink: do not depend on RTNL for IFLA_IFNAME output
    https://git.kernel.org/netdev/net-next/c/8a5826813362
  - [net-next,3/8] rtnetlink: do not depend on RTNL for IFLA_TXQLEN output
    https://git.kernel.org/netdev/net-next/c/ad13b5b0d1f9
  - [net-next,4/8] net: write once on dev->allmulti and dev->promiscuity
    https://git.kernel.org/netdev/net-next/c/55a2c86c8db3
  - [net-next,5/8] rtnetlink: do not depend on RTNL for many attributes
    https://git.kernel.org/netdev/net-next/c/6747a5d4990b
  - [net-next,6/8] rtnetlink: do not depend on RTNL in rtnl_fill_proto_down()
    https://git.kernel.org/netdev/net-next/c/6890ab31d1a3
  - [net-next,7/8] rtnetlink: do not depend on RTNL in rtnl_xdp_prog_skb()
    https://git.kernel.org/netdev/net-next/c/979aad40da92
  - [net-next,8/8] rtnetlink: allow rtnl_fill_link_netnsid() to run under RCU protection
    https://git.kernel.org/netdev/net-next/c/9cf621bd5fcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



