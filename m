Return-Path: <netdev+bounces-238544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0901C5ADDC
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09B35342D96
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55182561AB;
	Fri, 14 Nov 2025 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDuDqnaA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457012561A2;
	Fri, 14 Nov 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763082038; cv=none; b=I3v06FyVCRiipodYSciQahNwLS/Anm7wrEDvjJvMnvt4jhyFPJkI+2jGeGNbbIRRKGt9bnRYOMqlCLFHVWKeQcAdSrnKXFFir9fsPTsL2XOsW1YT0gbxjnuGfz9Sqo6KF5FzT3b5FhtDhRwTrVjTgh4WI+TPCfMxSruxAyFFQ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763082038; c=relaxed/simple;
	bh=8/ErFUEyC8wp6OEGHuFxyQcxgP5VBA4JKxvq0P8q1M0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ADIrVfyDTkjONe7pCf8gg0zhEf2C+i5FKwEMBeoms4xNh5Ge4/2aQJHNl1S+ZM4DyF7zmdhcgLypX4y+JMH5vAr3ObAeRT26J2b3Ga2C0t//+Cl1st29uO0xso8ZPPTtIBR/P/9k9S+1LwR7Z5H074+rTgXyt8FPanyqkz0ifHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDuDqnaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890F6C116D0;
	Fri, 14 Nov 2025 01:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763082037;
	bh=8/ErFUEyC8wp6OEGHuFxyQcxgP5VBA4JKxvq0P8q1M0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cDuDqnaAOMK81ldxIzyRxOczUviebqMESET3gtoqpVXACplLzwsUIibAkXS4o8NHl
	 mUbMG7wq9nDYJg5yofP6STyZOHppU+qRU3LoO4N4+M02PDHxwsyoqZadh/0wTvRZel
	 NELPDSM3YY/MfmCIvx50BHEGRWc0KouclgLrsQyjd3/3VxBdHd2RUJFhC0P+QL/YGy
	 nxIBHE9oV/YFiosSmJoE7i1Xi5VyoW1kgkak8+HSytrbLPuXpTR1WyzhmDAJwpk+8O
	 EEhbFnMj1rQ4Rt/+c4vzOQ73My2uOV43nuNH+mKE0o/xMVkgaX/lupCxpuHWYM2455
	 vFtd6Iw91Jfbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE2E3A55F83;
	Fri, 14 Nov 2025 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Remove eth bridge website
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176308200652.1069791.7434847464546852384.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 01:00:06 +0000
References: 
 <0a32aaf7fa4473e7574f7327480e8fbc4fef2741.1762946223.git.baruch@tkos.co.il>
In-Reply-To: 
 <0a32aaf7fa4473e7574f7327480e8fbc4fef2741.1762946223.git.baruch@tkos.co.il>
To: Baruch Siach <baruch@tkos.co.il>
Cc: razor@blackwall.org, idosch@nvidia.com, bridge@lists.linux.dev,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 13:17:03 +0200 you wrote:
> Ethernet bridge website URL shows "This page isn’t available".
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - MAINTAINERS: Remove eth bridge website
    https://git.kernel.org/netdev/net/c/7410c86fc05b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



