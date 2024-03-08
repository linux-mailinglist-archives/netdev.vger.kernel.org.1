Return-Path: <netdev+bounces-78592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED95875D60
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 06:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF45B21D53
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96932E84A;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it4GNfm5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF62E620
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874037; cv=none; b=gfTU0rcznkJrvgEUJmBO2RFHAaXGsXth4D+R8TjvQSUe1U8a2kNJrxi+fjxCbkv/WXzbjPfki68pqfFa4hxpgwSZQc4cIFpdS9+U6dsWLJFrZpBRhFvNlhgCgdSWnywBxSyRC3QZ8LpnOxdEPJgxCuprViR3Ozc/gluMc2ue+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874037; c=relaxed/simple;
	bh=uXq/NgQzwEeGRkDGXKRm5gd75hVf6jsft69U4uAKTBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FNpfWlbD+LptA1A1LdBCiwva/4RkNZd/Kb0n4SM5BnClbWSQPNcvtXfyfvSC6bjx+nn08m07gIgC0REpafs88en8704SKbCZzw6hE53ZRarTfNbXsWgH9RxkZcda0gJq4x5Kf7ZjERe7tNJtKyrObUhAKlIRPE6LQi9yaBzwWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it4GNfm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ED8AC43394;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874037;
	bh=uXq/NgQzwEeGRkDGXKRm5gd75hVf6jsft69U4uAKTBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=it4GNfm5b5kNlVJm9RYpetgcTv5+/ZoVvgb6wEhh32oAD6MS6GpID1RQAceV6MbCh
	 K7vcDK0QJdW6dhd98EgawB438R3K7wO/R/JABcgEc2W5rahvIYwpt4hbhLsFoaqxsy
	 kFNkTNjEC4vQe2DVrLeovcFX+IgdU+di9i1DQer3hsWeowVOpxL75kRCcat+kezhVk
	 3S+MDExL47lnNJBC5oAse8lrO6hiF+fqR8aB2N3Q/PjHb9mO6sGeq2jdOs/B0cHbfR
	 cCvYFjUtpV54vteJww5B6L76wo7yrlO8ZfS+jgPGEFUWgb71+Mhyt9iWCB/mYuIyYs
	 nNrPk5ZtGdHHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E20CD84BD9;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: marvell: add comment about
 m88e1111_config_init_1000basex()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987403724.8362.12061050499541104983.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:00:37 +0000
References: <E1rhos4-003yuQ-5p@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rhos4-003yuQ-5p@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 06 Mar 2024 10:51:36 +0000 you wrote:
> The comment in m88e1111_config_init_1000basex() is wrong - it claims
> that Autoneg will be enabled, but this doesn't actually happen.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/marvell.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: phy: marvell: add comment about m88e1111_config_init_1000basex()
    https://git.kernel.org/netdev/net-next/c/8fc80c9d8c0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



