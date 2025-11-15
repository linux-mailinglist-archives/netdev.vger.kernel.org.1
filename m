Return-Path: <netdev+bounces-238823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF18C5FDDF
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9DB44E3784
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED381E3787;
	Sat, 15 Nov 2025 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOF+na/0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF01E22E9;
	Sat, 15 Nov 2025 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172638; cv=none; b=UyZH8rvo/VKyx9Pu1Vypox6/Dzs8ELxv+1yklvfjFSJBBh8KZAdXsKf8Sk/I7KHwDObMdqYSSVwOhcUSSAunsJVH41mP6ukmkN2l9Cz6l2foh3fmqQNX1TmzlyMTbux92xxL5umaRFkhPok36Y/kMHtigPjOjgq8wBerTQ+HlX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172638; c=relaxed/simple;
	bh=WMZ1sJR1nqblwIccOUCfg1v1lQ9NagTd/Knsl0Wc1qA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XGdPbjj4sBv+Cd+t5gdSssoV3/gV+Rj1iQlRIoYSAoLcHqq4T4bu/5cYj505x05RIhBVwykXUQglPOMx3dCyeHHOFluf9OPOXLb+DHflGZAl0wb4vwA7p/fOBRHe68tmY+qpPblCIgI1VtTjRk1ryMVJ+zAJ1uKnOO2aes7oyaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOF+na/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDBAC19422;
	Sat, 15 Nov 2025 02:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763172637;
	bh=WMZ1sJR1nqblwIccOUCfg1v1lQ9NagTd/Knsl0Wc1qA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sOF+na/0UyayaPSD92VV3GJQoxGULIY+z/N89jcop1WktSxEmM0d9fOJ/JvLiKhoP
	 R/vMjKVmlfblhNdpImkuuZURKDl/8C2mpymcU642WyYJ+Pjgxzhc8lHr0DwtBIrDOT
	 Xq28FyiI5+U/DdZ95GqeQxwv8Iom5g8mmoDXzWKJ4qPUyMgSEaNB1+UPoLGjlKlkyd
	 StBraGFMjKDQv7AdJIEODYUr4UBpMacWSdJNKLfLxej5eDWBHfZxaBn5a4acDQV5RD
	 pPgkSvWUPrR/BCU+ItUld542wrGIlf5pYF9BKRCT7o7QIxlu1NXGsqifiS/Hje+784
	 FsZwcEBrZj9Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E9B3A78A62;
	Sat, 15 Nov 2025 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mlxsw: linecards: fix missing error check in
 mlxsw_linecard_devlink_info_get()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317260601.1909671.10048441480703728767.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:10:06 +0000
References: <20251113161922.813828-1-Pavel.Zhigulin@kaspersky.com>
In-Reply-To: <20251113161922.813828-1-Pavel.Zhigulin@kaspersky.com>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 19:19:21 +0300 you wrote:
> The call to devlink_info_version_fixed_put() in
> mlxsw_linecard_devlink_info_get() did not check for errors,
> although it is checked everywhere in the code.
> 
> Add missed 'err' check to the mlxsw_linecard_devlink_info_get()
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Here is the summary with links:
  - [net] net: mlxsw: linecards: fix missing error check in mlxsw_linecard_devlink_info_get()
    https://git.kernel.org/netdev/net/c/b0c959fec18f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



