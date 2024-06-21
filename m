Return-Path: <netdev+bounces-105679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ED99123B2
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B355528BBBD
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F70173357;
	Fri, 21 Jun 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL4A/A4J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F2173354;
	Fri, 21 Jun 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969431; cv=none; b=AG8BxwgWtL6pyxljXwAMVMvVtiTBDKjTX3jO5aTtMlo7lHQKzDET/qp4pArv6cPK9XYHqAsmmixxJEKw/+OqvYNmKIrZDDzAFRMe/lssPftKzZabSC0dGiloj0cqDIadrTc4l8UxWNHDQlTy3T688dakc4mChz06voB9CJaSifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969431; c=relaxed/simple;
	bh=vV9wCK9hoYqqOcklrFgBuYYByRX11AIgQ1XylLrlNsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u5Dt4Q0Fw3gz0PKbSOSaVtOzTDNWOTTjC1rcNAt4KWznQGIYBDvOXpgSYO/ppzAEed6QX3lb1OvGibpGp1s4513KVTJXEkmXdkPS8XAFICj0mdW4Z+LvnD2pYfFoCHeXnT3sxczD946loFQIBRyD9j71ZAey6/Ch9I/BWMOvP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL4A/A4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 882A4C4AF08;
	Fri, 21 Jun 2024 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718969430;
	bh=vV9wCK9hoYqqOcklrFgBuYYByRX11AIgQ1XylLrlNsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eL4A/A4JE8aRIwjStROYhp1X9S5BXkdOnIY0vkeqKrDCJXd7rpdp4HEWZkkEjSsFo
	 TezOKuZVovDIp/njWUE7t1b2KcRavJSAzHZXMEN0jyVC+SACzKwObnZfr9fyHuCFoJ
	 qKQ4RPCGjCTwjNcxeojSHikAcP3Ihs1yraE97B0No8LjeePhKrS8EYWtoXnLZk3KYi
	 aX1kD1Dr5dy6g2kYvJmzU7ErgminHHBlmEfTocoUluq3SAQlWjKUwIM/PXBiyaRi4F
	 EhvIoNCY9EDhUZzQfy/rxtlz/YBhSU3n+05OXfJOkyc0I6FXhaDLp3X9WX/tX8LIF8
	 xdsKSl1Lh+yIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71EB5CF3B9B;
	Fri, 21 Jun 2024 11:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: dsa: qca8k: cleanup and port isolation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896943046.2605.7186195507093229147.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 11:30:30 +0000
References: <cover.1718899575.git.mschiffer@universe-factory.net>
In-Reply-To: <cover.1718899575.git.mschiffer@universe-factory.net>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 19:25:47 +0200 you wrote:
> A small cleanup patch, and basically the same changes that were just
> accepted for mt7530 to implement port isolation.
> 
> Matthias Schiffer (3):
>   net: dsa: qca8k: do not write port mask twice in bridge join/leave
>   net: dsa: qca8k: factor out bridge join/leave logic
>   net: dsa: qca8k: add support for bridge port isolation
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: dsa: qca8k: do not write port mask twice in bridge join/leave
    https://git.kernel.org/netdev/net-next/c/e85d3e6fea05
  - [net-next,2/3] net: dsa: qca8k: factor out bridge join/leave logic
    https://git.kernel.org/netdev/net-next/c/412e1775f413
  - [net-next,3/3] net: dsa: qca8k: add support for bridge port isolation
    https://git.kernel.org/netdev/net-next/c/422b64025ec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



