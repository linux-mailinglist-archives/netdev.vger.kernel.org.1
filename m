Return-Path: <netdev+bounces-110993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3D92F35F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 03:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798481F227D0
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835F1804;
	Fri, 12 Jul 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrt18ueY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05320E6
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747231; cv=none; b=jJbX7nsQgeQ2tigwYXasGXw5y6PFRCNhdBQSncOKqWM+/c1idCYgxPm6S4r83yvD7+p/ZNmbt3kdENGNIS6lEY681DHFsyL4juu6nKjrM7MZPnZ4PiF5RmjMChe0n9ZyfJHooimJncrVw0GdDv6f7y50QArOGFmmXA5TlY2URf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747231; c=relaxed/simple;
	bh=epWV6PuS59x3B8Kh7yc5md6ZHd8ztszJjAjPGW449K0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DfGrpN0E/W5o6vpSh+S2rQwMxj1kyBN08d8oZxpGAy+vFVYbT71doK+VmNK9tbd2LmG/Gbo4xRAD8O/3mpysJ+r3zZ7HvV5zs9R9R+BYIwvowP/ifY0s0DJD2LC2OBK9VeG1n00g5yrTJLpWKMSg9FKK2Pt6QICYmOLVFwW/LnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrt18ueY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE5EBC4AF09;
	Fri, 12 Jul 2024 01:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720747230;
	bh=epWV6PuS59x3B8Kh7yc5md6ZHd8ztszJjAjPGW449K0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mrt18ueY7G2kRNpgN07aTo5zsy3IuQBH3chDc9NjP3mk8YA4alQ8J6q+9Agcz9xWY
	 tKegh3Mpq1/UIYYsMtVHbHOfVLkp0b27qmlZBgYhK62EXH4OniNje0yHsZmM2KknDP
	 /ENc2cyLVFDnAi4IOLE8TCM4JniN2rsPWOdyfQw8Dnib0yV5/X+YdJXcT3KLQsvefL
	 A/alWxK71rlA8WM/yz9xVNtnlsgD6E3OIkDPUYifwe9dcutan4s/GYEQFJkShR78kV
	 WkkR11p7ym8+Wlu/6HEgPmmYwybc5VsSZ/x5K/HR8APr57NgEmI+KIDaCSK2QWJhaz
	 A+3XfsWSALhZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABD32C433E9;
	Fri, 12 Jul 2024 01:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] i40e: fix: remove needless retries of NVM update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172074723069.25041.4644193905850393042.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 01:20:30 +0000
References: <20240710224455.188502-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240710224455.188502-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, aleksandr.loktionov@intel.com,
 horms@kernel.org, leon@kernel.org, kelvin.kang@intel.com,
 arkadiusz.kubalewski@intel.com, przemyslaw.kitszel@intel.com,
 tony.brelinski@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jul 2024 15:44:54 -0700 you wrote:
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> Remove wrong EIO to EGAIN conversion and pass all errors as is.
> 
> After commit 230f3d53a547 ("i40e: remove i40e_status"), which should only
> replace F/W specific error codes with Linux kernel generic, all EIO errors
> suddenly started to be converted into EAGAIN which leads nvmupdate to retry
> until it timeouts and sometimes fails after more than 20 minutes in the
> middle of NVM update, so NVM becomes corrupted.
> 
> [...]

Here is the summary with links:
  - [net] i40e: fix: remove needless retries of NVM update
    https://git.kernel.org/netdev/net/c/8b9b59e27aa8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



