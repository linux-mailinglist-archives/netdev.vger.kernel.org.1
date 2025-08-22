Return-Path: <netdev+bounces-216169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1FCB3254A
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 01:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 977B07BB053
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 23:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE522C029C;
	Fri, 22 Aug 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr+4JENu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D0A29BDA0;
	Fri, 22 Aug 2025 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755904207; cv=none; b=FUrFsJdub04483g8FGfKJoxknSnJ734M0g3nhTJwZt7SldG9qpjLnplrHPN0rdTWL9EADK/oXpkcNvaJxDDftOtVplmKHO3crE094DmoibgKA3K1CFB3mWOVuxkeYsZzXvZoFAxURMZLWWEGm7j8oR26UlP2uhvh3TI7HZ9J9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755904207; c=relaxed/simple;
	bh=cpPpPrWhiUoz4OB+6NAAj9jz+AVvkNNZl/+qUBy9cK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UzcUN+7Gc3O+3PHzFywJ1PG3pcHARgYMMXRM5Jj9F/ZL84/kqTDe++e09mcXuVmG3/SCDoczAeK1ZiHzJhnEdIomiY7QfTyy6a0Xkorf1RHD6xPH2o4bXPXDOYi9vj9tK/QzgnF+CukXHPZTbqCq3YF0E4NMET/2bNcsdWtEjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr+4JENu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6CEC4CEED;
	Fri, 22 Aug 2025 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755904207;
	bh=cpPpPrWhiUoz4OB+6NAAj9jz+AVvkNNZl/+qUBy9cK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qr+4JENu1k1hooIztN+yes+lvQMkDjdxEenkbCrPOJLkXefI0GUKJLatHZPJ15QCe
	 rbi5wZWyQxnBJRd5k7N759qZMr+t4RvI681nKk1kl+2zgaP2T5G0TMKSfc5BQ+pFkR
	 avih5sWBYt01PIYzjBNPHsF48QPtw4bzqMnv21hHp/nCFxVSxFKxAqR0KOTtUuYxHL
	 x+iSyI0fJR70F6SV+AXuefazh2CLVUAf70ssoOq/R421iPAMOpjNTZwjabV6ImHUCM
	 gA/ohNRh3keCcbHrcxTApFiPSMueVwMRUT6xqPEiWO1S3xz+h0y4fQc+W+ZIGzgi3J
	 dsLsUNIH6/c3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C40383BF69;
	Fri, 22 Aug 2025 23:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PatchV5] Octeontx2-vf: Fix max packet length errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175590421600.2026950.3047454569312164251.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 23:10:16 +0000
References: <20250821062528.1697992-1-hkelam@marvell.com>
In-Reply-To: <20250821062528.1697992-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 tduszynski@marvell.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Aug 2025 11:55:28 +0530 you wrote:
> Once driver submits the packets to the hardware, each packet
> traverse through multiple transmit levels in the following
> order:
> 	SMQ -> TL4 -> TL3 -> TL2 -> TL1
> 
> The SMQ supports configurable minimum and maximum packet sizes.
> It enters to a hang state, if driver submits packets with
> out of bound lengths.
> 
> [...]

Here is the summary with links:
  - [net,PatchV5] Octeontx2-vf: Fix max packet length errors
    https://git.kernel.org/netdev/net/c/a64494aafc56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



