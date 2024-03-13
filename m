Return-Path: <netdev+bounces-79619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E37387A42B
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 09:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B191F21F42
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DEC18E12;
	Wed, 13 Mar 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBYE3DKF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CC1B943
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710319230; cv=none; b=k+PP4P+aIdDOPLWCKzy9WbgMCtvAgNksbPAPqekJegn3iiK3hST7y32H3smbB2FNEyj4a81fau1JDkMJttJV+Vjlo1DKjvXgeGJFBEysXT4ucH5blP69Marf3OySdMA4y1wWVmQubTX/J6BtqPLHZ3TRY166zwkkTbKlsVKdyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710319230; c=relaxed/simple;
	bh=s/Vz3C9TJIavbFhIhAiD+vwFuRFpT/9IAv4MLuF3FW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tKnH4BVNBlMJrvQlVuzj0F6BbaJrtt+z4ycsPIEKY6OCCVYlbQFIBHJI8lk8eJUnVBDGJ/Fqzke7EVepchfY+oREAUzLiAHQwM4nah+tAqINIeqa18iQp17I1uejkNw2E1SF4dirR33OZp4SNGEBAVUkKPDxTNZZWUhNX+n6MPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBYE3DKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80A8EC43390;
	Wed, 13 Mar 2024 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710319229;
	bh=s/Vz3C9TJIavbFhIhAiD+vwFuRFpT/9IAv4MLuF3FW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OBYE3DKF8CLj4IbKqUAuU5Eva95Z8f//GSvr+SLpD9PSI/C8wjKkVOv/zjj7bQU9t
	 5RBVEkdElr4P9ZsBnIGYBKyNJckVH6rOug/UMIfp/3DSDB6cT9xY62piVQpkymPOVN
	 /J6eV92XyL6WrIzsJHlHYl9WrH4bfSZe0yPDxl6q9UfzTFLtl/h7aGmmgztYpAokw7
	 fayRg+Msvx2EevWUa51ZSfoaibU7yLJqB2+Gx7hvc/WHGRBEpYa5u8N4569quHwuI1
	 EG420OynZzj6XIj+KoK5t3qXMrl3YQtAu+rRDwdDpntudCnu31m4l3gj3No0xxUjqB
	 tCeujFNvE+9Tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67F18D95060;
	Wed, 13 Mar 2024 08:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] devlink: Fix devlink parallel commands processing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171031922942.8351.16226368528415050004.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 08:40:29 +0000
References: <20240312105238.296278-1-shayd@nvidia.com>
In-Reply-To: <20240312105238.296278-1-shayd@nvidia.com>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, jiri@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 12 Mar 2024 12:52:38 +0200 you wrote:
> Commit 870c7ad4a52b ("devlink: protect devlink->dev by the instance
> lock") added devlink instance locking inside a loop that iterates over
> all the registered devlink instances on the machine in the pre-doit
> phase. This can lead to serialization of devlink commands over
> different devlink instances.
> 
> For example: While the first devlink instance is executing firmware
> flash, all commands to other devlink instances on the machine are
> forced to wait until the first devlink finishes.
> 
> [...]

Here is the summary with links:
  - [net,v2] devlink: Fix devlink parallel commands processing
    https://git.kernel.org/netdev/net/c/d7d75124965a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



