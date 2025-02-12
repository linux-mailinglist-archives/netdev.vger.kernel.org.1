Return-Path: <netdev+bounces-165351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB92A31BAD
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03097A2AB7
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213861917F4;
	Wed, 12 Feb 2025 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="almsx24A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC552158DD8
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325608; cv=none; b=FBU+y91oiMx/iTDykXMQXbLY48BNQTEDKcqvhFtVOR5TTpDkiE76Ru0UFhlPPMmRigcrtIk5PsE93zHSD3+kw3rv6ZQtijt37lXG/ntyZ/pwjAyEEqAN0c+pcN73SD/UmEL+jWTyEVJqGkkys0TGr+MxrrFolS44zRyq8XcbNH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325608; c=relaxed/simple;
	bh=yuYzEry3kx+PQwh24BswJIcajpLk/lGA9MLZ0KCyxqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hw3ykkM3MbwmU1LXV7bZ70FDYf5XpEDWox9CboTFDG/mf+gzdCc3B+242AJlRVaVTjiV+mqcwmR0/CDqI29mgtFLwouYCVuYfa+P28vRjnfxOUymUltz4gVnVrrrNcz1NawJNuQyCFyzP9C2Zcq32aoCn3ohHrHsZT6IpQtbQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=almsx24A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64410C4CEE5;
	Wed, 12 Feb 2025 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739325607;
	bh=yuYzEry3kx+PQwh24BswJIcajpLk/lGA9MLZ0KCyxqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=almsx24AMa/qMNCwy3VbnJAq//kOfbTb6ievR1dmMJdnNugc/GNY9spOO9+3fmTWw
	 uPb27uLydTWwXsMnmeo8khDDfG3+VOYfaG73ReYZVkutWNkN3AeLwnRw8B8n57ngNq
	 3lAFGlODQADyRyMhdOU79t6RBxe0EJts6yMAxh6L+g3lZwltm15xm255juMJN6dt6y
	 l6RfonpZnOJWNogenejKNY0yHsgp8OndZL5IX8CclqqS54Od1mjYPrDdKHb43Zllax
	 e2B1RsZQY7COa6aHzje4CyskXB2uklxRaVIBJ2r7c2S7KHk6zLR1WVYky6wwXPypJL
	 b3Mii4Opm2xIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71827380AAFF;
	Wed, 12 Feb 2025 02:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] sfc: support devlink flash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173932563625.69529.11607680533707323945.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 02:00:36 +0000
References: <cover.1739186252.git.ecree.xilinx@gmail.com>
In-Reply-To: <cover.1739186252.git.ecree.xilinx@gmail.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
 jiri@resnulli.us, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 11:25:41 +0000 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Allow upgrading device firmware on Solarflare NICs through standard tools.
> 
> Edward Cree (4):
>   sfc: parse headers of devlink flash images
>   sfc: extend NVRAM MCDI handlers
>   sfc: deploy devlink flash images to NIC over MCDI
>   sfc: document devlink flash support
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] sfc: parse headers of devlink flash images
    https://git.kernel.org/netdev/net-next/c/fd118a77ede7
  - [v2,net-next,2/4] sfc: extend NVRAM MCDI handlers
    https://git.kernel.org/netdev/net-next/c/d41987e906e7
  - [v2,net-next,3/4] sfc: deploy devlink flash images to NIC over MCDI
    https://git.kernel.org/netdev/net-next/c/3ed63980ae79
  - [v2,net-next,4/4] sfc: document devlink flash support
    https://git.kernel.org/netdev/net-next/c/5ea73bf3c40d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



