Return-Path: <netdev+bounces-82684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 279BD88F203
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 23:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48981F23806
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 22:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2AF152DE5;
	Wed, 27 Mar 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQCZNEfe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4B14E2ED;
	Wed, 27 Mar 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579833; cv=none; b=pPqONqQgwBWV7fY4Oi5OitlUoqAGHG4KPJCwgmGFKdJ6gTCgQL2P8zoDyQHbNPhXYmBSxvl0P7ziu61MqHD/HgYlo70f/Ez9u8ORzprHf5ahIexHV6srVOJT2B1ee5m+TdhKLOACR5w9xFYUKBVyW2BwGCPYNUm0e7uOvxbvDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579833; c=relaxed/simple;
	bh=TqSNRJ9Lbchin2d61PeD0aaqc5dcbK6X70r6uKnVbj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FXpdODw+I7SLUE4mjL6nTLKp/cq5sHSCi4q5Tu8YLr4d+wa24wuIE1hE0APeSZ3V99k7ok5y3ScGifAbLwNRhNfgcVKL1CgEc5UKakN7hg/K+IA/RDTyU4rVsiC+z0dgKZHYka7rRIRN+kwArr2jekrJI6rYgPg3ZiuAEQVAApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQCZNEfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03440C433F1;
	Wed, 27 Mar 2024 22:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711579833;
	bh=TqSNRJ9Lbchin2d61PeD0aaqc5dcbK6X70r6uKnVbj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sQCZNEfevZM7OgYQCSMcg0pp/4qrJhccLxh7le2xolCuVdmsrqzNXd7wiH4aPZ9GG
	 aFMArGURWpRxXgPoA1ETTsUsIQ6P1vf4zCncFs86gqPPYRqSb1M9cVZsk2NOpOjYVe
	 dPm1uftz1dHm5DXsMoBQf3yCuaRQdQcHh7a16tPPq2aXsLxA2CNVyq05dPLWMDYrBZ
	 DAj5DjA/AbsWRt4wrUy9DwJoXBGtdUXmJRa3ugIiHeDXoRpJYu+9a7cVYtGQy1cRg4
	 nWhzh03ma2ad22s6tvE8/ZT4daS1V9wOlvelqcHPt8JpNCHQgm0PRVy7wuJ74q1Gym
	 AC8X0Ic8DFBjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF205D9505F;
	Wed, 27 Mar 2024 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-03-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171157983290.28770.13378293085545393250.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 22:50:32 +0000
References: <20240327191346.1A1EAC433C7@smtp.kernel.org>
In-Reply-To: <20240327191346.1A1EAC433C7@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Mar 2024 19:13:45 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-03-27
    https://git.kernel.org/netdev/net/c/56d2f48ed8f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



