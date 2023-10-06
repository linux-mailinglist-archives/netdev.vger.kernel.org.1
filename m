Return-Path: <netdev+bounces-38702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 466C47BC2B9
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A000E281D6F
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BF945F6E;
	Fri,  6 Oct 2023 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAW6pH5V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78745F64;
	Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B764FC43397;
	Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696633225;
	bh=DWOqHoTdvRiOVK1Inct3f6wJqwRA89lb9uBtVVNrdW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DAW6pH5VNEyblPYq35HyL0Jb3PQCwZfvmeRygE8QNnLZJwZAHOizTRunjEx1i/sFt
	 kP7jDzjYHxHqiGUVwBadWPbT7hjzJXlQ9CwQjvq2Nw1psWv2dYBbDNP5U55AiHEBKl
	 qf509DD9x+6O0W9TTyOlATjBl57JKT8t4LhguXu4HYVWx0bXxmtnq9LwvXQwgZ146F
	 4WmAEfhPvNONx+ua1cAXOTt+rN6BwXsiZHrYD2Fr1kkjKdBpG9kCZKr0jarFpwFXBi
	 MOTGhKABXwe4KxigEp65K+u0pMQQY893wsIs0YknOmkdCQoPo+3zU4Gz3KZVai0rX4
	 KxE8YA1NQOhAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1625E22AE3;
	Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: atheros: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169663322565.31337.8644310026514977480.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 23:00:25 +0000
References: <20231005-strncpy-drivers-net-ethernet-atheros-atlx-atl2-c-v1-1-493f113ebfc7@google.com>
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-atheros-atlx-atl2-c-v1-1-493f113ebfc7@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: chris.snook@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Oct 2023 01:29:45 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect netdev->name to be NUL-terminated based on its use with format
> strings and dev_info():
> |     dev_info(&adapter->pdev->dev,
> |             "%s link is up %d Mbps %s\n",
> |             netdev->name, adapter->link_speed,
> |             adapter->link_duplex == FULL_DUPLEX ?
> |             "full duplex" : "half duplex");
> 
> [...]

Here is the summary with links:
  - net: atheros: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/9814ec70fccb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



