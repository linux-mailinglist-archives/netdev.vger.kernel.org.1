Return-Path: <netdev+bounces-217106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD29CB37624
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9052E7C50D6
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD196196C7C;
	Wed, 27 Aug 2025 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUMVylDn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CAE13AD3F;
	Wed, 27 Aug 2025 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756255207; cv=none; b=sFiqxTzrp3G4cxvnSdMDjNaCm2THvPbUD06QOiYGkHvoumj7O1JUqThWSSXHGreADbqTe5125KfOUBoRpNGbYqRfX0Qv6/H923qiJmQTLvbn7OsqtKS2Wu9ula0lkk44Mtv4AuN7CxcTE+nb61k08PQ/ma86qb+Djvyh6fRkg6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756255207; c=relaxed/simple;
	bh=9WDRBs9n5VYIz6RH6M4wgnsTs3yVOwevT+fGZyxRKco=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MlAD4Ue7cdnYRnrJB6T5Qk3Po7sSbR2r0cFS0/DXASxXOsBOQPI1uwgphvEeX4oZeNuJg32f1QFLbig7S2x5qBJhccQ+OTOgLST8/TVGoySRKa11GDOOCbp+sM1hr1TVLtGzn6/nsELlXN3jkcVHchzHau1fam7dPaeHciHwti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUMVylDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27982C4CEF1;
	Wed, 27 Aug 2025 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756255207;
	bh=9WDRBs9n5VYIz6RH6M4wgnsTs3yVOwevT+fGZyxRKco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jUMVylDnMh2nroT1KeVXKFVownx4SCIwDCc9Bi8nn05Ydp6GNEKKBIl65lj5mkles
	 ZbQ+d7cg4KyxtreMy2zC/hvrHr7NSrRbDZ09vMUiMqh6ntiw5t0ZoK8AZjKKA98rYK
	 74NJS1pV2tx2CBsM2IFd16da36KxCly86sAKoO5gmEwUgpCHnjDt1wpZHnRUNO6zXL
	 VH0uddkrNAGd7KjBoraJp5RhO6SBWr2ZPzY1suE68VoujLIiDiVIxe3R3EM7GgA/Lj
	 5uBUQHyt3pjKjifnCpuOIZmb4rTkM6MBt6CZibM9SSXMEGYz/+Q3N9AFzC7Z1h08ne
	 Fv9H7rh/+V0NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3A383BF70;
	Wed, 27 Aug 2025 00:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V4 0/5] Expose burst period for devlink health
 reporter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625521452.151180.8535021510500656720.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 00:40:14 +0000
References: <20250824084354.533182-1-mbloch@nvidia.com>
In-Reply-To: <20250824084354.533182-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, tariqt@nvidia.com,
 leon@kernel.org, saeedm@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 24 Aug 2025 11:43:49 +0300 you wrote:
> Hi,
> 
> This series by Shahar implements burst period in devlink health
> reporter, and use it in mlx5e driver.
> 
> This is V4. Find previous versions here:
> v3: https://lore.kernel.org/all/1755111349-416632-1-git-send-email-tariqt@nvidia.com/
> v2: https://lore.kernel.org/all/1753390134-345154-1-git-send-email-tariqt@nvidia.com/
> v1: https://lore.kernel.org/all/1752768442-264413-1-git-send-email-tariqt@nvidia.com/
> 
> [...]

Here is the summary with links:
  - [net-next,V4,1/5] devlink: Move graceful period parameter to reporter ops
    https://git.kernel.org/netdev/net-next/c/d2b007374551
  - [net-next,V4,2/5] devlink: Move health reporter recovery abort logic to a separate function
    https://git.kernel.org/netdev/net-next/c/20597fb9436e
  - [net-next,V4,3/5] devlink: Introduce burst period for health reporter
    https://git.kernel.org/netdev/net-next/c/6a06d8c40510
  - [net-next,V4,4/5] devlink: Make health reporter burst period configurable
    https://git.kernel.org/netdev/net-next/c/da0e2197645c
  - [net-next,V4,5/5] net/mlx5e: Set default burst period for TX and RX reporters
    https://git.kernel.org/netdev/net-next/c/2d5ccb93bbb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



