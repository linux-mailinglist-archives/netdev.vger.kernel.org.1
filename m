Return-Path: <netdev+bounces-239784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 254ACC6C6A7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B8197298DA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FD028CF6F;
	Wed, 19 Nov 2025 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fThbW5BB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399028C849;
	Wed, 19 Nov 2025 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520050; cv=none; b=l+kaKy9nE7i4ZdAVtz1NqvyF4URKWQNr7iWt+7KO4hkaPx8SjBNn91pIO7kTmyFxHBWj1ZVN7tGqOwKHDY4jx3g61Mhxp+La8Jc9FkWGKY1pmNmkfFipndqxiMtao6WKEJ0Y9np05PToyOeMGEpW1FSV3rKqMcpdQFOxf0W8Ca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520050; c=relaxed/simple;
	bh=NJzftSJ4IAfntIxXVRCXK+8oIUyeusTWj4d10b2dQsE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iKOXLVR19+3GyhfQLWboA1oIxeXXmkkgAcZSpnuGNreuvbwkpTYsaS6SS/Vvz51dZpAwiNkdglyzQ3JT23KrDdteZ1NojQGuVpGxAsgYat+C+bK+bTmc+2K/zmKp2kwdJrVVq0I2l2s7CSOE2xaQtrsDg48PkRYVL8qDT2o4LSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fThbW5BB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29809C19421;
	Wed, 19 Nov 2025 02:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763520049;
	bh=NJzftSJ4IAfntIxXVRCXK+8oIUyeusTWj4d10b2dQsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fThbW5BB3/ovMbIkq76lm7LkX+fKncGdkyiamEQsEJexxL5BsxHJjk1+O1YgyBZMR
	 jVAU+le7+BL6gOEVE6vRHXJt98C0VLEibjtL0aFGd9EQRoa7hW+gOKSFsT8JJXjV75
	 ckGIzs4jwi9GPJn+PeQe1b7fZ0+A1l00HoyOxNXxGEcaN1LtLLWspE2zkL+zNwnfm4
	 3WY4x9b3O0L4Q1YuyUrbz5z6kS63ff7te+K2yCyRAM6DKnDdW8NNxy1XwZnkqREHSr
	 Kx9PTVq+8OaGJ6lWqg47vnoXcy+asyCucGAE0ZnNy7esdHhti0iOLYTcMxdEo60UyQ
	 kXAJJrxaO9LNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9F380A94B;
	Wed, 19 Nov 2025 02:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] kcm: Fix typo and add hyphen in Kconfig help
 text
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176352001424.191414.4973339545971977996.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 02:40:14 +0000
References: <20251116135616.106079-2-thorsten.blum@linux.dev>
In-Reply-To: <20251116135616.106079-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Nov 2025 14:56:14 +0100 you wrote:
> s/connectons/connections/ and s/message based/message-based/
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/kcm/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] kcm: Fix typo and add hyphen in Kconfig help text
    https://git.kernel.org/netdev/net-next/c/efb238160e88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



