Return-Path: <netdev+bounces-154108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4B49FB493
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 20:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9FA1884F1F
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275011B6D18;
	Mon, 23 Dec 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4j1/dU5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBFEAC5
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734981013; cv=none; b=NhgOYdIuqxXvolBMemhUQCcXuDe65VuMLMygKaPS3ptZLFBdg8wwX/e4rBIrO22k8aPYBbEaqrqjUgMt54IKYuNmE3jBRL2GQN2M4rZaL1iN7S1dxZPukFGvkpoowSpJ0mC970fas6Lxj6wHqNntaWbaOkLtcOY5qfeFj6kju3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734981013; c=relaxed/simple;
	bh=E6FuIA8L2LFiKS88oqIIrHLs+hViDIyA3QdHwlIb+QA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hVEzJjv+dptu2CDbNNULzvbKg6EdmmV6WTVHpG1W5hql+kamT1nijMHBc586MxJL5S/pR++Vz2YhsuZ/q+ov6oFcFw1u0+2qaktySLZvGTB1UWc3uV/oU1Kv6/Bg8M0a4G0CrIADxwuhbh50En7xv1NW7ABr4yWqELsVxS2hiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4j1/dU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82522C4CED3;
	Mon, 23 Dec 2024 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734981012;
	bh=E6FuIA8L2LFiKS88oqIIrHLs+hViDIyA3QdHwlIb+QA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B4j1/dU5+ivw3U9i4kJ2JO8RcAHhTzDX6SAAcsVsOOEJettEHHADw2B/2cx/R1PTo
	 WMq6D1IK05fwlumkrrklhmHcsCYoR+XplvUyJeymszN9ZAYKABbFskjM0ahDYZLcYd
	 gQspCJqM1mXBUKqW400ihk5BfVBNkAkY4yf4cpCGhCwvDcL94XexzqZTeBjumrEdJA
	 XbyaY047N0ow4PAu8w+z0lxCrtaXy9h94t6ER3sRbQ+wJ3+gWdaPD3JcuazpkKoyv6
	 ySFrjYaPnQmjSy6uRuVxfA/FPnpHnVjfQIDnkNaOJg0YV3F1HgZhHbSu5nK9wUhsue
	 Uuw/VGxiCcjUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB43805DB2;
	Mon, 23 Dec 2024 19:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mlx5 misc fixes 2024-12-20
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173498103101.3934211.6341324347104492303.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 19:10:31 +0000
References: <20241220081505.1286093-1-tariqt@nvidia.com>
In-Reply-To: <20241220081505.1286093-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, mbloch@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Dec 2024 10:15:01 +0200 you wrote:
> Hi,
> 
> This small patchset provides misc bug fixes from the team to the mlx5
> core and Eth drivers.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/4] net/mlx5: DR, select MSIX vector 0 for completion queue creation
    https://git.kernel.org/netdev/net/c/050a4c011b0d
  - [net,2/4] net/mlx5e: macsec: Maintain TX SA from encoding_sa
    https://git.kernel.org/netdev/net/c/8c6254479b3d
  - [net,3/4] net/mlx5e: Skip restore TC rules for vport rep without loaded flag
    https://git.kernel.org/netdev/net/c/5a03b368562a
  - [net,4/4] net/mlx5e: Keep netdev when leave switchdev for devlink set legacy only
    https://git.kernel.org/netdev/net/c/2a4f56fbcc47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



