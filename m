Return-Path: <netdev+bounces-46742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7867E6269
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 03:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2224B20CCD
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 02:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12685255;
	Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="He8tIYFB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409046B9
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B204C433CC;
	Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699498231;
	bh=fpaXqAinJuc6MKEaCNjARtuTtSAoR6nv3bQ2kZ8LxhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=He8tIYFB9yRgElKGK783Bnim2W8ReSv4H1V+5OSlRn8ZHm7StEJjMye1RZhjmOjDJ
	 n9aEattlBsdBpRkgkbK5r6axbO5LaJflVdYlzsuoT7EASTt5gWzU6iOyJ+R7QtUs1Q
	 az2Y3no8tEbO+Te4u15TziHoGlV38U6a+PM2SnbpF5rBefcAWswFtUZ/DaL/IfF1GM
	 sURISMQMoA2Nb1M13s8rBp8dxmb9B2GQuI6kXV0ldVwSq3W8Bjx6LzmOfaOq+WUAme
	 QOBieWkOvhOugkBLrDOXWSYXFdvERBN/xlv935Oj3ocUSpCMFHtLjH04/ps2Si/GZs
	 iUHJ+nt2F8BlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38244C3274C;
	Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates
 2023-11-06 (i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169949823122.3016.13007722711516370248.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 02:50:31 +0000
References: <20231107003600.653796-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231107003600.653796-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, ivecera@redhat.com,
 jiri@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  6 Nov 2023 16:35:57 -0800 you wrote:
> This series contains updates to i40e driver only.
> 
> Ivan Vecera resolves a couple issues with devlink; removing a call to
> devlink_port_type_clear() and ensuring devlink port is unregistered
> after the net device.
> 
> The following are changes since commit c1ed833e0b3b7b9edc82b97b73b2a8a10ceab241:
>   Merge branch 'smc-fixes'
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE
> 
> [...]

Here is the summary with links:
  - [net,1/2] i40e: Do not call devlink_port_type_clear()
    https://git.kernel.org/netdev/net/c/e96fe283c6f4
  - [net,2/2] i40e: Fix devlink port unregistering
    https://git.kernel.org/netdev/net/c/aa54d846f361

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



