Return-Path: <netdev+bounces-162785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 576B7A27E3C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600613A4920
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED02206BA;
	Tue,  4 Feb 2025 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R07H+Nia"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDCE2206B6
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707627; cv=none; b=BfYEQWJ5l7rMYw5trBUgW31dSb1ug67yDedLOnjyB+4E4DTsHCZokhjN4lP+ipxchwdUyNs0k4Jrhnf87inGBCsPFG4hfw5qChGAuAKyibs0HmM39qq8+7rpVHy0Fw2ezrFWUCy16pIrBy3Cgt2k+R2M/h7P1JOQICvKspBBrE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707627; c=relaxed/simple;
	bh=waf7lDOcTxsGEFyzVn1vxUxdULvH3B9fEFAP2xgvkW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nW+DYVToGXmamUEFIjGGTS9DXrxLIpLkn17O1Pr9ps6sbpjoRg5ocaA31cS83BuOjyG0AUUaQx91mZy8YwT6/utPc6X3xz+gpntGZgxywDg8piVQAt4Y758EgEFkoBFJ7UoMMZfcaU7AKuuXZnRgQmQEN3lAS8YTMhjWjHr851M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R07H+Nia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF19C4CEDF;
	Tue,  4 Feb 2025 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738707626;
	bh=waf7lDOcTxsGEFyzVn1vxUxdULvH3B9fEFAP2xgvkW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R07H+NiaeD+eevrQlRR/E7nBCbs9ZgYIsvCwa/DpIxmusd6LBunmUbzyOqJ6rU3/N
	 i4qc7T1Rv4WusHpPcX19akuvSdaUkSaL+V71/H3helrQc4xL0cE8uC+4U8HWGCAiBM
	 qnWj2jWbwFb0pT7BhZbovaCVTu2oSlknS3saYczypsUm6jgY7A2p4nAxpkLT3DkcuT
	 ZqpBon4rhV5qmB8cIsIizwjwDaJyjy42nEzVjlL5IHBf7lfm+F33CxgVZJEl+yjA2S
	 cvuIQv4dcFND1BI+zJCd/GhytJCRZdrYdHRC87BmWMh9qJ+MhMclvY/uNBqETGliJx
	 lWRsObuEtXo4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAA380AA7E;
	Tue,  4 Feb 2025 22:20:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bonding: delete always true device check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173870765400.165851.14668133975555174224.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:20:54 +0000
References: <0b2f8f5f09701bb43bbd83b94bfe5cb506b57adc.1738587150.git.leon@kernel.org>
In-Reply-To: <0b2f8f5f09701bb43bbd83b94bfe5cb506b57adc.1738587150.git.leon@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: jv@jvosburgh.net, leonro@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, liuhangbin@gmail.com,
 kuba@kernel.org, netdev@vger.kernel.org, razor@blackwall.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 14:59:23 +0200 you wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> XFRM API makes sure that xs->xso.dev is valid in all XFRM offload
> callbacks. There is no need to check it again.
> 
> Fixes: 1ddec5d0eec4 ("bonding: add common function to check ipsec device")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] bonding: delete always true device check
    https://git.kernel.org/netdev/net-next/c/546d98393abc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



