Return-Path: <netdev+bounces-215874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6223DB30AE4
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA5D603743
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 01:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAE019004A;
	Fri, 22 Aug 2025 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko97MS/b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363A13C3CD;
	Fri, 22 Aug 2025 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826798; cv=none; b=ALnY7tYB8HFJAxRL3WJrn6jktJLFdmpXLGuJFnq+KiMTlM+bgfrqf9iVbnq/NfSdv5zFiOLBM/5+ualTV7+Xly80zWGCZhVjl6B/OyPEUohC9OH6RE6z3WoKBANCoYfaXE5rMWJeVQ58JNXg7//QrMjFcIr3LYViACGpi/rVpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826798; c=relaxed/simple;
	bh=R+BHVqEnxiMmDPHAswPzWQZsOsUJ9CnDeaoxQZLgph8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aiqbMecV79YPazjHrwHDrGpykCk9HOo2irfUdccSEAz/kqieMe0jMtQFDUqD2LAgB9TnENibILMbNmwu7Rx1MtOargzExaUr5eGF1DkiCtNqSvEN3l1T3TFQhqs/qEpVdeXIfD20VRFtmR61YSR/hufTyqFTe2pV/1cVDb+Y5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko97MS/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580C5C4CEEB;
	Fri, 22 Aug 2025 01:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755826798;
	bh=R+BHVqEnxiMmDPHAswPzWQZsOsUJ9CnDeaoxQZLgph8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ko97MS/b0HcDVXn7IBaMTy692/dgJlNZ8LDXkwF7vWvNHYkaPFtaSqqWwR1kBQ2jn
	 x+JN5qZQNnXrZxQ18TkmG6s+iuePKZS+A+9qJ50oogCiSkMzNcCrUBFYBGG/cvBY3B
	 aLkiVaaIJM2m8PkFSmSpFsEBUcpO3QwNcAuLn4rgmTzGOat84Et9Q5t6llBZs6QURe
	 DenToQ97SeRCt0TnjkHNZU3xuuJWTKuOsRPpSDCGWwPve0DGScn2lmcpo4TmJ2rLa0
	 0GDBhOg162RqUfSmfgf4+iFTozdiBroQ8wbWqNVRxfskf7MNnGUm+r/cD1Arfhm5xj
	 Dhc2RktRjHKMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE694383BF68;
	Fri, 22 Aug 2025 01:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next Patch] Octeontx2-af: Broadcast XON on all channels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175582680750.1267692.8437808790654557210.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 01:40:07 +0000
References: <20250820064625.1464361-1-hkelam@marvell.com>
In-Reply-To: <20250820064625.1464361-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 Aug 2025 12:16:25 +0530 you wrote:
> The NIX block receives traffic from multiple channels, including:
> 
> MAC block (RPM)
> Loopback module (LBK)
> CPT block
> 
>                      RPM
>                       |
> 
> [...]

Here is the summary with links:
  - [net-next] Octeontx2-af: Broadcast XON on all channels
    https://git.kernel.org/netdev/net-next/c/a7bd72158063

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



