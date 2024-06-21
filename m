Return-Path: <netdev+bounces-105656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E5791229A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139CA28AF5D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8BC172BB1;
	Fri, 21 Jun 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaGSwkhu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E92172BA8
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966431; cv=none; b=iLmCD/ZfM7wM9W+H1iY7FK9o0B8Jvv1o+rEaZ2tJtG57Npr4i3SzMciN+Xbk0qyzFCzk8F2QLe0z0HOA8YUtMExl5qjL9skb+q4MqKz1A4QvoVk4yZJ1ti1rV6T4NlaDQEqDCXSNqpQs5gOffh1yoDdP1K2jhwVo3i2/lIs0yew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966431; c=relaxed/simple;
	bh=ULrK5IwiemxgKa9/8yIbHUC8i5ShWjHw8g4bZxVv1ug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ltjinM/CrjefYPHchsvzGMdzN/rWp0sjzQaHjH4Rq0+XLnEs597OWgmAynJ7Uz/+0sEhfULrrlYDK1horXAAGfMU7MTlBf9H5vcnu2Kurp+wllyGN2bZv2BCns/nJo70pXdEIFMBfDXoYzEoARz4XTr39vBwaqgRT5Ip2B18Dg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaGSwkhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9493DC4AF0B;
	Fri, 21 Jun 2024 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718966430;
	bh=ULrK5IwiemxgKa9/8yIbHUC8i5ShWjHw8g4bZxVv1ug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gaGSwkhu4M80UFzPLh6Qx9HeJptzOltz2PJhXcb7t3HU3IGEPeq3vMKABWz2L3AIo
	 8SSD0dNnuiOQ4LdNCiDevZH8Dci8fYV1m49sRJi1KYhOIxjFYt8fjYkhK5xdEDMU/v
	 VNC0e3XqngSIgx1dNZi8K1okygy7NGo2wFx2SRUzTJlou4nmBMev1/GF2PRt1t+Wgd
	 cU2PXp6GGH+FLclw7zVugNb8+/lALhtcw8uY2tY1nR3uaZfLhayOgyeiiLHxYWNarf
	 aWiTBPmBfZTkHzPQBEOipmFm1/FGklFH927+EQO8+Smemf+TCoR6sNu6I8w7FsY8sT
	 kNnbidT4G+8MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87AC6CF3B97;
	Fri, 21 Jun 2024 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] l2tp: don't use the tunnel socket's sk_user_data
 in datapath
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896643054.6147.11315994974660731029.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 10:40:30 +0000
References: <cover.1718877398.git.jchapman@katalix.com>
In-Reply-To: <cover.1718877398.git.jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, gnault@redhat.com, samuel.thibault@ens-lyon.org,
 ridge.kennedy@alliedtelesis.co.nz

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 12:22:36 +0100 you wrote:
> This series refactors l2tp to not use the tunnel socket's sk_user_data
> in the datapath. The main reasons for doing this are
> 
>  * to allow for simplifying internal socket cleanup code (to be done
>    in a later series)
>  * to support multiple L2TPv3 UDP tunnels using the same 5-tuple
>    address
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] l2tp: remove unused list_head member in l2tp_tunnel
    https://git.kernel.org/netdev/net-next/c/a744e2d03a91
  - [net-next,2/8] l2tp: store l2tpv3 sessions in per-net IDR
    https://git.kernel.org/netdev/net-next/c/aa5e17e1f5ec
  - [net-next,3/8] l2tp: store l2tpv2 sessions in per-net IDR
    https://git.kernel.org/netdev/net-next/c/2a3339f6c963
  - [net-next,4/8] l2tp: refactor udp recv to lookup to not use sk_user_data
    https://git.kernel.org/netdev/net-next/c/ff6a2ac23cb0
  - [net-next,5/8] l2tp: don't use sk_user_data in l2tp_udp_encap_err_recv
    https://git.kernel.org/netdev/net-next/c/c37e0138ca5f
  - [net-next,6/8] l2tp: use IDR for all session lookups
    https://git.kernel.org/netdev/net-next/c/5f77c18ea556
  - [net-next,7/8] l2tp: drop the now unused l2tp_tunnel_get_session
    https://git.kernel.org/netdev/net-next/c/8c6245af4fc5
  - [net-next,8/8] l2tp: replace hlist with simple list for per-tunnel session list
    https://git.kernel.org/netdev/net-next/c/d18d3f0a24fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



