Return-Path: <netdev+bounces-96204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F68C4A4C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F051C22DBA
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80E222F1E;
	Tue, 14 May 2024 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9ESw2R8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38822230C
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644846; cv=none; b=qCuRxs7xmuqZcuMOlLDP9ZCJuG4ePku1hvFjz5s48a44cIivbBPxLXuATjjjqnsar6n45OhxkpukqUifj7Q4weFIAPqmIHkpjQsJB2ylBwBvv0kiMQ3yy5nMQakck07EcwuDgqF8NZt0TKQwtt4hdHnVo8XOqMJ99FerfrTBMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644846; c=relaxed/simple;
	bh=MPH3X3bDzUpTP7QP6dUZ3L8epCULvZeLUiX3ZakF8cs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UTVessTzoGzyeobaV/fkNC86jqJhHQ2NnvSYdGyblBhUIXW6Fq6hFeIKpNFlmAdxAzzg+V1aB4LNIjv1Lyc88yF21fiDWZNEclEQLbUCsWDBbwSJ92ALly0bNeuZCgq8UXLbb/7UhSkBLSobjmP3DtW7wJeDqryB6PiE5i/JqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9ESw2R8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41FBBC32786;
	Tue, 14 May 2024 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715644846;
	bh=MPH3X3bDzUpTP7QP6dUZ3L8epCULvZeLUiX3ZakF8cs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L9ESw2R8/8WJB7LJUhXKtHhztXJBrO/k3ehc1V5sOZHKCaWL6Dzq6MMx48410RCO0
	 44z2SqE/xK6Esy1tahWHNmS+G7qr2B8L0/THzTou9QILV1BgofUYKlZcCqK4bdPYWA
	 y3pzyuaDo+ttVfog1xw6kP5U1BSq/ndUEH8QOKu7WC57QKtTVZPBoAuFLNt4cg7f7F
	 P0+u/uk9+wG+FrIOKmqQmt9n7NUXDSgEUoINat8lgy3yniZ5WTPpR9vEVQnboXaOb2
	 JL1zgYZNV+/O0OZf6jGXi9fBOXyDX3ymgI5z0lPxS4SvZP9cjpDDuFhSA8QBhn+wjx
	 HDrplDEw8Z5lA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C357C43443;
	Tue, 14 May 2024 00:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] mlx5 misc patches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564484617.4532.15357793763573599908.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 00:00:46 +0000
References: <20240512124306.740898-1-tariqt@nvidia.com>
In-Reply-To: <20240512124306.740898-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 May 2024 15:43:02 +0300 you wrote:
> Hi,
> 
> This series includes patches for the mlx5 driver.
> 
> Patch 1 by Shay enables LAG with HCAs of 8 ports.
> 
> Patch 2 by Carolina optimizes the safe switch channels operation for the
> TX-only changes.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net/mlx5: Enable 8 ports LAG
    https://git.kernel.org/netdev/net-next/c/e0e6adfe8c20
  - [net-next,2/3] net/mlx5e: Modifying channels number and updating TX queues
    https://git.kernel.org/netdev/net-next/c/bcee093751f8
  - [net-next,3/3] net/mlx5: Remove unused msix related exported APIs
    https://git.kernel.org/netdev/net-next/c/db5944e16cd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



