Return-Path: <netdev+bounces-143857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28F89C48FF
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 23:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A544B1F22AD8
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 22:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34311BC9FF;
	Mon, 11 Nov 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6c9o9Kz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE861BC085;
	Mon, 11 Nov 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363627; cv=none; b=SwqZUHXwG5yfQUEvp/a0CJwBAB0d/9TyFCWmiJoVRpDVrQ0wx9nUW+YIW2wA8faqQsYrw3LFNmoVyVm4aEjc5UwsjhjgOLI1oJJMbB3X1u5MC1ghN7Lc52L0uqdoZNuM9Hs3JT3frEjcfDeVmS8pFuoyHVN8bSNftKm/aBzPE8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363627; c=relaxed/simple;
	bh=yYcYFR5odzQQFMMS9ZBFI+glA7cNBWrgRkqOTfSQLVs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PbOUudU0lqGQHEYFqa6h+nxXsym6wpX0RUTkWdrw6oqOSJZhRnoj7pPzIwjZONjA4iRQL/WEG7+Q5IYDTLUowdvOOq7PkvKTGcJT0lvcDNpr2FskuIinlMphoYQd93thls5AMbY1GCSh5vlsHhvLn7AX5gx9++F57Qlzw3CaWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6c9o9Kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FC2C4CECF;
	Mon, 11 Nov 2024 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731363627;
	bh=yYcYFR5odzQQFMMS9ZBFI+glA7cNBWrgRkqOTfSQLVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P6c9o9KzvS2ieo5GYGN1T2QBG/jiNK260IVGshm7UyCwZfB2OFkxdRrrEtvdhKHYW
	 kaE8bG+SCiV2Oh6zVW0MOxBPnoP8+09K6TWCJ+ul+DDAUuBgnkbfw3CdCz7P2jVURg
	 m2zj/aeKpJifrs+jhiwRUkMCri3CuGG3HEbG2gleaaQT681VnEdSkwoUd9+GobElDx
	 XuDsH+IWBwOBl9vB3sYzjpZrBdvU+pNPjC5VCR6+v9tUytgwH/Lp+mEqjuorJgI8dq
	 iqg5rHWEJDv5A2mQm2gd2Dl4wBphd7a5yve7F4C+0+TeQ55wuR8g7l7UfYAwbZ0i1t
	 3YrFPpYkLBYoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7129F3809A80;
	Mon, 11 Nov 2024 22:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 0/3] Knobs for NPC default rule counters 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173136363724.4189866.12190832539503399018.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 22:20:37 +0000
References: <20241105125620.2114301-1-lcherian@marvell.com>
In-Reply-To: <20241105125620.2114301-1-lcherian@marvell.com>
To: Linu Cherian <lcherian@marvell.com>
Cc: davem@davemloft.net, sgoutham@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gakula@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, jerinj@marvell.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 5 Nov 2024 18:26:17 +0530 you wrote:
> Changelog from v4:
> - Minor code refactoring to make the code more readable
> - Make documentation more clear about the counter usage, behaviour when
>   counter resources are not available, definition for default rules.
> 
> Changelog from v3:
> Add documentation for the new devlink param as well as the existing
> ones.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,1/3] octeontx2-af: Refactor few NPC mcam APIs
    https://git.kernel.org/netdev/net-next/c/ca122473ebca
  - [v5,net-next,2/3] octeontx2-af: Knobs for NPC default rule counters
    https://git.kernel.org/netdev/net-next/c/70a7434bdb13
  - [v5,net-next,3/3] devlink: Add documentation for OcteonTx2 AF
    https://git.kernel.org/netdev/net-next/c/46799a41d292

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



