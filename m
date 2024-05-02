Return-Path: <netdev+bounces-92978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 658118B97BC
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 11:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D21F2865FD
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C431854BE7;
	Thu,  2 May 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjAl3R4g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF44535BF
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642231; cv=none; b=R8ytw7/KgOVzygaXBKV5n5RiIoHYrPKn7jSReGqofkaXybTzsWGMm2eXPtq6rSAN5bOXzv4CcTBoSNJVQVqvc5US13F4eWe4t83V7wQuSaQljsKdEC+Y3bU5cyYiYgJ8oS8b4AMXLGolTmuUZlU+qO4fw5oVIZvlSu/O7df5+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642231; c=relaxed/simple;
	bh=t+cDwiYqGwgVOiQ3fKnDeFE5qysjcZTOhbf/nUQkKMg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N8xp6au30KyFW+QNEZ6sI9XBH/5zE7tO9K1cBcxB98jKsLhBJNWcku94Z1g1GtnVemnj8+Lrd4ZuMFaMXRNxPySjdeh161mJBV+W8WJOAr2s4lNUlIIHZz+kqOqihM8My+baJ6VWyeIAle1eSjQnHcGMDZo3UXRgRDmfryotW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjAl3R4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 460A0C113CC;
	Thu,  2 May 2024 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642230;
	bh=t+cDwiYqGwgVOiQ3fKnDeFE5qysjcZTOhbf/nUQkKMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DjAl3R4gGeK0zqkb0clBhfRuIz1MnarHybOHN9pqJjDWQboLQgO1qUOGe6ebkvEum
	 kx+39cK8lqn/KbSNa57Fjyp8otoDC+RB8ba29jCwOrpYN2rQ5TK4XogpXxggpZR7XM
	 WVrJDCW/VzMbE9nGQbr6Oo8Ic9hCyfeOGg26hcFeHDxJyR51vohGWpEpOdA4RwjD9M
	 LSLYmIVNRGn2dhmauE3JQAgd+A8/0r3anF3aFppt3gpDvTsHMh6TVGdXf7M234RDQO
	 O2id+Yi9riiYichChfSOqjSfX9/shwjDPQBmdnpxFRVceXBJiKKHUUk895Gd9QJPhG
	 BbBL9CHCPHxEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D207C43336;
	Thu,  2 May 2024 09:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: remove Ariel Elior
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171464223024.21469.3232063811581653788.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 09:30:30 +0000
References: <20240430233305.1356105-1-kuba@kernel.org>
In-Reply-To: <20240430233305.1356105-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, mkalderon@marvell.com, manishc@marvell.com,
 skalluru@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Apr 2024 16:33:05 -0700 you wrote:
> aelior@marvell.com bounces, we haven't seen Ariel on lore
> since March 2022.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  MAINTAINERS | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net] MAINTAINERS: remove Ariel Elior
    https://git.kernel.org/netdev/net/c/c9ccbcd9f199

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



