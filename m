Return-Path: <netdev+bounces-241740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F830C87E48
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3600D4E5DAB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202052765ED;
	Wed, 26 Nov 2025 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYuNKviX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0EA1E376C;
	Wed, 26 Nov 2025 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126058; cv=none; b=DNBj/W/lR/OV6prvAgnks7W8xQYHU9pCbHXQxdstL+esK2Er2scYiUljoJ8xYdbNvuHpMudgm9fh8umtN7TW5VxlVqWcWRvkmlz2j5V0EUFfe2nor4eaJ5GlsPQOjsG1EvCUOxjcdlm1ysBixFjXUapzmw4pGHUti93Rg8yeSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126058; c=relaxed/simple;
	bh=gg2eZdPs3r8wv3IyR90NU3lweiSB7bIf4kZDirlpt1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TY0qmQ7tLWoOI9dbIs845QL88ej6j2+fogG7REnEsvIulzlFEMzlj/8VVQdDjn24P39bjYcvaLPTV5o0HpW/i09rmNmMp8zvpYrJI+nwEblRKHSSRU60aDJbEwpK8sxmFSJwJ6C8gTDFF4RizsAiHxyVlNKNsIDEs2+xO/KuYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYuNKviX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90D6C4CEF1;
	Wed, 26 Nov 2025 03:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764126057;
	bh=gg2eZdPs3r8wv3IyR90NU3lweiSB7bIf4kZDirlpt1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CYuNKviXW3+0lQMtaZOLPgMBvzMGiolLpHxIfr158lQh9czxMHiY8e2iO4y1/u2gZ
	 9HAVNlfpBG14nDcFjw0FSCmKIMjJleFQYbhI3Fy1roNM3+CSfbtgnSfyx3Y6bq6hjC
	 sd3AkxfwmIIxcOAnQPyZzMmdmJ4uiF4pJM4tasCsPLdXi9oLy8w+kRIR0kZPWNqiz7
	 V0y2fWun2Haek45dRgVtnSscnj9aBpDpUEzZBSBwhmTCYNnheM/yXyxz3JuYjNYExA
	 hPU8ImNJRuuEqYmCfZIQrC1abhgUNfSY0gZ4jbiVUmQzl3m5IBy1J8n7lwS5Mrcq2f
	 +x3UnO1BNEleQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FC6380AAE9;
	Wed, 26 Nov 2025 03:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/1] net: mdio: remove redundant fwnode cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412601974.975105.812091000338404041.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:00:19 +0000
References: 
 <00847693daa8f7c8ff5dfa19dd35fc712fa4e2b5.1763995734.git.buday.csaba@prolan.hu>
In-Reply-To: 
 <00847693daa8f7c8ff5dfa19dd35fc712fa4e2b5.1763995734.git.buday.csaba@prolan.hu>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 15:50:44 +0100 you wrote:
> Remove redundant fwnode cleanup in of_mdiobus_register_device()
> and xpcs_plat_init_dev().
> 
> mdio_device_free() eventually calls mdio_device_release(),
> which already performs fwnode_handle_put(), making the manual
> cleanup unnecessary.
> 
> [...]

Here is the summary with links:
  - [net-next,1/1] net: mdio: remove redundant fwnode cleanup
    https://git.kernel.org/netdev/net-next/c/ce28e333d628

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



