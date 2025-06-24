Return-Path: <netdev+bounces-200458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5757AE5880
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4831B64B36
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C6149DF0;
	Tue, 24 Jun 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFYY50x4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618F78F37
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750724392; cv=none; b=Q9ktIpfUzt4SDih0vo1yIisCzkSmCZ7GE6oFrdsEXd3JuMwUF39tEJTRuZyk83glKFhco9YRAWFhTXmf0UWFdkG7r6SBke1A4JFsyb3bZZzIcHNa3N5wbL93YXqcD5ytUfBmAbVGZM8xhLeC5fK9fKFFm8/Ah8yrHgPx8A0+UCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750724392; c=relaxed/simple;
	bh=UrRx5RDfs3/nGOPLJf1Ak2BsTin4Q5Jj0C/rEaUBPc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HaNb1wFfmNDkGvUrlXTjI5PxJ74ZE25LsbwQEjFy46kY/L4/hzQOmGf7QXFhkGjQ7DXJ7fPW4Eu9IY2+6PhWGYBBpbknI4LBPiEyPswCtKwmarmo8LxpBcSxAtQWklLjxNEFOKCBFnpa6+KdvfE504g6KnuWfxu3Wz45JjCGh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFYY50x4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF99C4CEEA;
	Tue, 24 Jun 2025 00:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750724391;
	bh=UrRx5RDfs3/nGOPLJf1Ak2BsTin4Q5Jj0C/rEaUBPc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tFYY50x4i3R6lOlx4o7TULgxzbthYDblIQ2rMRJi2kAeL5w6AJRGi4cNTgW9h1H8C
	 S4Z3E6zJ2mfNVeBLP0srHQgve6Z1cv02swftCup/SlnX5+wDXUZYGgA7v28TwW6df6
	 wXEN46ql5I5eDJ+jx4vxqYJ6DWisNcPieNjSJwmjfpVK/f7fKTT5+hCwa3Yugb825D
	 hJe0bE3eIQa9hwP3pM3Lihy1h1kKkuOtEPjHB/5FWGrc1I58k/N3VJ2AllDO1riNYQ
	 5aCmz2/y4aE8nrdLWcIzPq+LKjQP64MJikZzwvJKowl0+8R47M7/FhH24BCOwa5Apq
	 9934OigAHL5MQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8939FEB7D;
	Tue, 24 Jun 2025 00:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: lockless sk_sndtimeo and sk_rcvtimeo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175072441824.3341634.13352696919814371810.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:20:18 +0000
References: <20250620155536.335520-1-edumazet@google.com>
In-Reply-To: <20250620155536.335520-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Jun 2025 15:55:34 +0000 you wrote:
> This series completes the task of making sk->sk_sndtimeo and
> sk->sk_rcvtimeo lockless.
> 
> Eric Dumazet (2):
>   net: make sk->sk_sndtimeo lockless
>   net: make sk->sk_rcvtimeo lockless
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: make sk->sk_sndtimeo lockless
    https://git.kernel.org/netdev/net-next/c/3169e36ae148
  - [net-next,2/2] net: make sk->sk_rcvtimeo lockless
    https://git.kernel.org/netdev/net-next/c/935b67675a9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



