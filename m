Return-Path: <netdev+bounces-76470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E01786DD88
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E291F29C88
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 08:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF22B6A35E;
	Fri,  1 Mar 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ4+Kclo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF96A35C
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283031; cv=none; b=tMY1wZ+Ec4FsbhatdGE5bgOdDzJOtiH+43lt/QDAcJiWqCL6FJfVY4jHDE5F5nWczx2vNv1eOe6py5tqgc5kJKm2s9FS8giqXnKTg/g+7d1S687gmUpJMg6VoQlnvC1kJXbo0WfmAp9gbQ/wg+coWuWKe5nyDJNRnfYOaQbQ2kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283031; c=relaxed/simple;
	bh=6kdleEbu/FfX/l8wPSZlZrq4htSDg4ppTvBGKr0WZEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z91+BihmzfsAMF3/E6PJ8/0T1LnHdTz4qzF8rrOuS3tsk0MuiSTopM61v+5qRrG3POzPEOb1qwOgRIygP1k/nNqMMxuEKXXh1Eh3FhTnrIqtqYdUpjSsHhhFOZI99rZCUyS7qTL0oMM6ibj92PhwT7buAx7iLH8nkT725Gc3SGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ4+Kclo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2D97C433C7;
	Fri,  1 Mar 2024 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709283031;
	bh=6kdleEbu/FfX/l8wPSZlZrq4htSDg4ppTvBGKr0WZEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uQ4+KclouoofojKlSb33Ivaij59OXVdJcI209CMpXFIoCuwTOUNUxn8A+71J8wEle
	 t3s0CCEs6PZUa6M7KSiTlGFqw5SUC1qWNaeIrEHhng/qlufyl6il0a8bw9oHZDEzsg
	 mNe9z/P0OOfDNTFunfHiTqkrEJDKDBGEUcIzjpxgaLdKaVlviI9rkqWMnGvKJnwzmX
	 JpTzzh9+8eEdrNHu/RyhAxF4Y/a68vOwWPaHjUD9TGi6J3doMbc64fh9Bo/ZttBdB0
	 wHsowwAabdItHhswA3XOopW0whcczvpKfqn5CXlFzCJ+ptr35Ww4TKQFgdF1fPGdA8
	 jrcRKTEwg5/xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0C58D84BBA;
	Fri,  1 Mar 2024 08:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 00/15] ipv6: lockless accesses to devconf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170928303091.20263.4019289775877112070.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 08:50:30 +0000
References: <20240228135439.863861-1-edumazet@google.com>
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, jiri@nvidia.com, dsahern@kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 28 Feb 2024 13:54:24 +0000 you wrote:
> - First patch puts in a cacheline_group the fields used in fast paths.
> 
> - Annotate all data races around idev->cnf fields.
> 
> - Last patch in this series removes RTNL use for RTM_GETNETCONF dumps.
> 
> v3: addressed Jakub Kicinski feedback in addrconf_disable_ipv6()
>     Added tags from Jiri and Florian.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,01/15] ipv6: add ipv6_devconf_read_txrx cacheline_group
    https://git.kernel.org/netdev/net-next/c/096361b15577
  - [v3,net-next,02/15] ipv6: annotate data-races around cnf.disable_ipv6
    https://git.kernel.org/netdev/net-next/c/d289ab65b89c
  - [v3,net-next,03/15] ipv6: addrconf_disable_ipv6() optimization
    https://git.kernel.org/netdev/net-next/c/553ced03b227
  - [v3,net-next,04/15] ipv6: annotate data-races around cnf.mtu6
    https://git.kernel.org/netdev/net-next/c/e7135f484994
  - [v3,net-next,05/15] ipv6: annotate data-races around cnf.hop_limit
    https://git.kernel.org/netdev/net-next/c/e0bb2675fea2
  - [v3,net-next,06/15] ipv6: annotate data-races around cnf.forwarding
    https://git.kernel.org/netdev/net-next/c/32f754176e88
  - [v3,net-next,07/15] ipv6: annotate data-races in ndisc_router_discovery()
    https://git.kernel.org/netdev/net-next/c/ddea75d344dd
  - [v3,net-next,08/15] ipv6: annotate data-races around idev->cnf.ignore_routes_with_linkdown
    https://git.kernel.org/netdev/net-next/c/fca34cc07599
  - [v3,net-next,09/15] ipv6: annotate data-races in rt6_probe()
    https://git.kernel.org/netdev/net-next/c/e248948a4471
  - [v3,net-next,10/15] ipv6: annotate data-races around devconf->proxy_ndp
    https://git.kernel.org/netdev/net-next/c/a8fbd4d90720
  - [v3,net-next,11/15] ipv6: annotate data-races around devconf->disable_policy
    https://git.kernel.org/netdev/net-next/c/624d5aec487c
  - [v3,net-next,12/15] ipv6: addrconf_disable_policy() optimization
    https://git.kernel.org/netdev/net-next/c/45b90ec9a214
  - [v3,net-next,13/15] ipv6/addrconf: annotate data-races around devconf fields (I)
    https://git.kernel.org/netdev/net-next/c/2aba913f99de
  - [v3,net-next,14/15] ipv6/addrconf: annotate data-races around devconf fields (II)
    https://git.kernel.org/netdev/net-next/c/2f0ff05a4430
  - [v3,net-next,15/15] ipv6: use xa_array iterator to implement inet6_netconf_dump_devconf()
    https://git.kernel.org/netdev/net-next/c/2a02f8379bde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



