Return-Path: <netdev+bounces-107460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8125491B191
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38677282033
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B024D8B1;
	Thu, 27 Jun 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGU+pKUY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244EA28DA5
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523833; cv=none; b=jlb09JE60nltJd/+7h2IwGKjLyPLzDap5sYzoQ/rADe4VKFZw2jDlgai1AO3UTXt6wXprAaIK56n17tz5iqVXpSwZoJx8HqyUJTyQadrSzV3t4DX/RT7hWOIorgLOeq3wqB8BOuuxOg25fSbc4tyShpnmLjRblE0RcniqZIrElw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523833; c=relaxed/simple;
	bh=REh8jSTzDSoKJhXxW9WDYWb6ZErXb5LX8kVwbLiQDeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JyTDtmLs77OOE4SYz2qUe13ta80lOu1lkC0Lb5OBUU/s9U0buxFKU/GffenLt4ouHnYCUR6RxNOiy492r8g4ZrG3QOw2jX1N6FX79mgeAlY2TTakoM/0Wz3oZvqMjUIYT/pidGkIkPU43uyEjaekCQPA3PG6gYgeIXVzWOPOQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGU+pKUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FD51C4AF09;
	Thu, 27 Jun 2024 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719523831;
	bh=REh8jSTzDSoKJhXxW9WDYWb6ZErXb5LX8kVwbLiQDeA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jGU+pKUYg4owpyeP5sVPo3E0044Q+GxhFVwaqXcCzuwOOv3TRs0/MUY+GNE22Q7pr
	 EbJUbTn0OjBVLkbwu7G54q7vDV0WUoHWGdCkMCo/N5Ku7kbP8NYs9C+lXvji81L9wb
	 s+W3LZDgzQKmrqQmAqYnh/JwiTD7j6UWILqdsm1lZtXEWevkoBVPrJKzTQhSQE7qNL
	 n8I8iiKCLjM7MwW9iuhClw4+5uRfPsUW9g5eUpG7/c/VH6L8El9LL5OPKw9/IZlJKJ
	 qyS284z2mOxdihHXrOUCU69g9INAKOA5kW6MMCTBxF76/kajkGyrxfdqPc5USkx/+p
	 XUphXDOv3a5Vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F846C43335;
	Thu, 27 Jun 2024 21:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: use display hints for formatting of
 scalar attrs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171952383151.15956.14747816708178722117.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 21:30:31 +0000
References: <20240626201234.2572964-1-kuba@kernel.org>
In-Reply-To: <20240626201234.2572964-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jun 2024 13:12:34 -0700 you wrote:
> Use display hints for formatting scalar attrs. This is specifically
> useful for formatting IPv4 addresses carried typically as u32.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jiri@resnulli.us
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: use display hints for formatting of scalar attrs
    https://git.kernel.org/netdev/net-next/c/2a901623f005

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



