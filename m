Return-Path: <netdev+bounces-131849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF65198FB6A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562081F236E3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D99A1870;
	Fri,  4 Oct 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5v4guce"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831F1849;
	Fri,  4 Oct 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000629; cv=none; b=u5N2dxP/81Mgxiy9w3xsAJrZiZgOy9aoaS1IM6o/TEHDTQ9FKG26Xc3m9MhtkRPvlr46P278+yF2+u8LJNlU6at9vpMPJ7gz7PA3QX3RS79MqLBMTNjDtEq2Lyw/nYurukikQPr8H0T57RXHX+2kyg3ctA+dwrqKkblnAbTAFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000629; c=relaxed/simple;
	bh=7l1gmmc/IGZjYE9QCDSMMar+bgB/Tz/DmU2vvKW4gjU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zl6JUgmEKDAZIgCnEsDZElzqe9Gd9nCBrAMc9SqOxK1Jc7hZDvzQnXIE/+CSsRwpIeOGPLFjecNwwpY5yi+MpYDLuk5WuIPxoE1vztrqAmWLrvXm/ffrFjmvpnyFZv95rNkDcAp67OKq0z8FGES5QEa3BGB8SPG1kxkkoBy1txg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5v4guce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9110EC4CEC5;
	Fri,  4 Oct 2024 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728000628;
	bh=7l1gmmc/IGZjYE9QCDSMMar+bgB/Tz/DmU2vvKW4gjU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G5v4gucemcwOyZ1Se+C18+t1KIjN4jmEA2aPyjXXsZksl2SgoCc3yNVXaPt3S80T1
	 RApXELc2ecMfRnmx+qO/pfobu3tNh6VK23a3ncHPOaScPF7RuQjvGdVB5NPGg74ddG
	 koN/C8hRSg2ToYpSno6EJxhL7uGfI3b3+FB/zLtXi2KvsbhpmwCMGCX0uIqPt1kiKH
	 0OORAvxKlttinnEO0/pX9GQ7EEsF7IO6YTJnDsY39TKZTf0ebWfciXX0/O2GZiQcMh
	 qgJ1gIaCll4/GyuLTuDyFX0BylzkDMyNS9ZG+LJU3MUMn2gV7NJVXi/lkSfvxlRtAa
	 qnQ48VYdm3Gbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34D2C3803263;
	Fri,  4 Oct 2024 00:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2 0/2] gve: Link IRQs, queues, and NAPI instances
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172800063204.2038698.8514793410721572832.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 00:10:32 +0000
References: <20240930210731.1629-1-jdamato@fastly.com>
In-Reply-To: <20240930210731.1629-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pkaligineedi@google.com, horms@kernel.org,
 davem@davemloft.net, edumazet@google.com, hramamurthy@google.com,
 kuba@kernel.org, jeroendb@google.com, pabeni@redhat.com, shailend@google.com,
 willemb@google.com, ziweixiao@google.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Sep 2024 21:07:06 +0000 you wrote:
> Greetings:
> 
> Welcome to v2. The previous revision was an RFC [1].
> 
> This series uses the netdev-genl API to link IRQs and queues to NAPI IDs
> so that this information is queryable by user apps. This is particularly
> useful for epoll-based busy polling apps which rely on having access to
> the NAPI ID.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] gve: Map IRQs to NAPI instances
    https://git.kernel.org/netdev/net-next/c/3017238b60d3
  - [net-next,v2,2/2] gve: Map NAPI instances to queues
    https://git.kernel.org/netdev/net-next/c/021f9e671e4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



