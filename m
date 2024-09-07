Return-Path: <netdev+bounces-126131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF1996FEE1
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB50B1F235AC
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B28517740;
	Sat,  7 Sep 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQio7Tgq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7376517547;
	Sat,  7 Sep 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725671432; cv=none; b=u0vY1Nh33QGDVr+YjYZ1IiCBvX1vHvOpZ6C0sNes1a+4AO2OQXfTe60vrnTYCH6TGYgDuI3l5Wi/K3ed5Wrjl1bVdRbA/J74XfXBKunX/LAHAKHJ+LcDl6zVutxUaiWugHax7rumHYMyjyzKPgg/IcZMZt2bf2zbsESer7fE1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725671432; c=relaxed/simple;
	bh=Pudxc51AuNjZ2r2qtU60GR3UhwVUaZfPyUtQ4VQFf1M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S2ZP9GRXbnrgSPkwQvt58MapGbaew6tWlBFnaAyPCDdA9jlmW9+ZWm6AMerA+lBa9/DUJdpx3x4lI7aecWX0lvidjIJDTvGnoymTKnqYMFMjun9SS8p/84FWBT4R2STK8SvfEEeEcZrRVxOtKatkFhsWBqxgZ4y1mB4b76AXGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQio7Tgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507A6C4CEC8;
	Sat,  7 Sep 2024 01:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725671432;
	bh=Pudxc51AuNjZ2r2qtU60GR3UhwVUaZfPyUtQ4VQFf1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qQio7TgqGyA/1nX05lKqc/KnFKCrGc+dxFOJBWdmo6YHr6ZW2aujwoHZVVySLEVUA
	 fTGr8pAF+KdRy8FduyOidAeA1IiN1JnO+ZZAYoTtNAxJgPmN0K2ggV1uuJR07+7LY9
	 XlOz8LoR6kHNR3WadJRT2lq/Lviu41Y+Ywh+yjk+QqRd0yOALE20Ei1ccmiFDBno9w
	 +HunV3ECBVqhYNpeWyJ7b1NoK9OZRh/11UIBq6krYrK8sSbr7SsI0jAwhWem8/mt0a
	 mwenF6kF/z6N5uw3nDZM7p/OYbBWeNWzFj/vGFebiIgTLFnknASb8dzlNwj5KAXnDm
	 kXmEZJV/8LSpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C723805D82;
	Sat,  7 Sep 2024 01:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: atlantic: convert comma to semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172567143300.2573151.7934604646137684001.git-patchwork-notify@kernel.org>
Date: Sat, 07 Sep 2024 01:10:33 +0000
References: <20240904080845.1353144-1-nichen@iscas.ac.cn>
In-Reply-To: <20240904080845.1353144-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: irusskikh@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 16:08:45 +0800 you wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - [net-next] net: atlantic: convert comma to semicolon
    https://git.kernel.org/netdev/net-next/c/aac0484423b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



