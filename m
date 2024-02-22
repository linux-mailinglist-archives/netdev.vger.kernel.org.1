Return-Path: <netdev+bounces-73862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2259D85EE94
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 02:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6B81F226B7
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618F012B7D;
	Thu, 22 Feb 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAT5B9bi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F611C83
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564829; cv=none; b=U2okHBvY+huweffukFFdXRIdygi9fLik/KEGy+0a+K9ju/KgqAassSxqN+1xA/qzLxxueLxzVZ1Cdg7j4tZNZVHVjkwGuttyFKD42hJeqF8hYMRBXARZ6+1gHQjjGC/MXcZsPgn/RbCs8rFo/wg9d4CAjhkmh6bsEGL7HpQvC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564829; c=relaxed/simple;
	bh=w4oKTyGAD4qlpXbEng8TkvemgAlZ/oWmFZtf0hsG/CE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PZVBdICkIoHoUEeyWvW3KgJrnfvIbjkLKMJWSlZ5Uk2K1ZCesz4BgpeGBckFD3SI+GH6t6wTgXDPgDdf5nZ+UBWIM032sRUWsDuMVft9YvZIvi5sKhnGMtZ9Kc2lzOBp+ZWYOB7TafnlAdsJOXZottDITIwe+DS7iBRIQSXXFaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAT5B9bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9AC5C43330;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708564828;
	bh=w4oKTyGAD4qlpXbEng8TkvemgAlZ/oWmFZtf0hsG/CE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kAT5B9biaBFBnu8IryDpSy0PQEhn4fZ3QThYMlJFkzpAyqzSGKKGrkOrwNTEE1zEl
	 aHiih/QSgUlObD7/RfGsGbugSCA3xdcoOO+XZmPMk4rGqhCh9bd2OgmlDNUZ0RRgWN
	 lL/0fs8L9uMoseA1Y56Gs97MCFuIGQAp4zApvdvM9wrXlYjlSLYQOxZyTXbgULRE4R
	 1HuRCrUa2VvPvT9wMlA1XqNUXNed7g9BiWctwzW83B/LJnb95RwiG5wr0X049meve6
	 RTwnI7r2MKk1QjviW/UVbEVUgsb68YJufsZKFS3tiFNEeZa+voV58kfW4aj+hnkwN2
	 wWatGbI/ktpgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B96F0D84BD6;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net] devlink: fix port dump cmd type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170856482875.21333.8910722581195169668.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 01:20:28 +0000
References: <20240220075245.75416-1-jiri@resnulli.us>
In-Reply-To: <20240220075245.75416-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Feb 2024 08:52:45 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Unlike other commands, due to a c&p error, port dump fills-up cmd with
> wrong value, different from port-get request cmd, port-get doit reply
> and port notification.
> 
> Fix it by filling cmd with value DEVLINK_CMD_PORT_NEW.
> 
> [...]

Here is the summary with links:
  - [net] devlink: fix port dump cmd type
    https://git.kernel.org/netdev/net/c/61c43780e944

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



