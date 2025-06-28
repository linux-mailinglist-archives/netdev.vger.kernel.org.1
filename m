Return-Path: <netdev+bounces-202106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4B0AEC3A3
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 02:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0830017992F
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F35013B58A;
	Sat, 28 Jun 2025 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4e40/HA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BCE12FF69;
	Sat, 28 Jun 2025 00:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751071789; cv=none; b=TqUEUVkkutcjkz8Hk3df4FATCMuVbzM8b3kjfhfYfCxhdVS7MDTwpn3uRRHpO1MhLaj8u3uH3xFMcCFlDL5/DOKsnEMbMT0DLaEEiPG11L9i+nm/YPHoArLwUUEatt7ez6yykgw6TS/zatL//ZwDxCXNd0ZlEalL/+hMos+uStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751071789; c=relaxed/simple;
	bh=sKVQDxPUVDqKRWk+/07tX7T6mTDs3vsnsy9Cqk07Rkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wbe51OjqDw13fjgLDVExn+NNc/0lnWxZiS/HqQDmUpxx/uULvzBU9rPI15AUYepXxq61vkcsY2eJDOzwGd6n8t/sVO6ybnasPiYONBkI7SOHPo3ppbhe45gcItLY6lP6n+WqkdWVoxzuyHHZH7PpPMIrI84c8FgXnjgLncnDQJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4e40/HA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8075AC4CEE3;
	Sat, 28 Jun 2025 00:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751071788;
	bh=sKVQDxPUVDqKRWk+/07tX7T6mTDs3vsnsy9Cqk07Rkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c4e40/HApu5DLQO5BsfLbXGzYp8j0b0frpHx2jDj0AIwNQLx5JtZylbWU6XMlEOU7
	 s7NIMOdbb3eMvb2foUcyQEgBUXlKUDN3lEU10B2H4EGlNcxFPA6yaE4YuBECfMu2qX
	 nZk2ML5bNQOo/b6qq6uD/bBPSJn8oKTOpx7p+GqmU+GeYSF0HzaK/NPFxV6yIYmW5I
	 vCeCej2qG06F2zPQGq2EQ3jS2YtcyWzoa5THWH2GL4AnAeWdY2jPrBgKXn/XnBEV7C
	 QXfMledC8ieUCHGmPgw70VcsrrnDWrfYD3KgYDHLEwYPbcPN3sd4O1BDkQu+F9S78P
	 yDcijjyA7OtuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB838111CE;
	Sat, 28 Jun 2025 00:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next 0/3] Octeontx2-pf: extend link modes support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175107181424.2100647.2766113809321238145.git-patchwork-notify@kernel.org>
Date: Sat, 28 Jun 2025 00:50:14 +0000
References: <20250625092107.9746-1-hkelam@marvell.com>
In-Reply-To: <20250625092107.9746-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
 naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, bbhushan2@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Jun 2025 14:51:04 +0530 you wrote:
> This series of patches adds multi advertise mode support along with
> other improvements in link mode management code flow.
> 
> Patch1: Currently all SGMII modes 10/100/1000baseT are mapped with
>         single firmware mode. This patch updates these link modes
>         with corresponding firmware modes.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] Octeontx-pf: Update SGMII mode mapping
    https://git.kernel.org/netdev/net-next/c/1df77da01b63
  - [net-next,2/3] Octeontx2-af: Introduce mode group index
    https://git.kernel.org/netdev/net-next/c/ad97e72f1c30
  - [net-next,3/3] Octeontx2-pf: ethtool: support multi advertise mode
    https://git.kernel.org/netdev/net-next/c/5f21226b79fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



