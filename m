Return-Path: <netdev+bounces-92458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311528B7758
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 15:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0CB1F219CF
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C614D171640;
	Tue, 30 Apr 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi7io/92"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A785956
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484434; cv=none; b=XgkaO9qZx2hYcwhFx/kzcGOVO4PkKBxsDAMtF/9Py9NnJsOD3YAX54P2VtfgVGmTERObksG/312fdx6gN0E1dS8FsYDtpkfxfuvRtHou8o9Bkb4dw2ae/EpEtuMtwmYYOF2z3zXkCHUrv+o55hzC9mmXHswRUTFDc97BkQBbNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484434; c=relaxed/simple;
	bh=PkaaMUSzHkQlVVSzjRC9SaTkUSeCNsJP/b8Uju28AZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tGKR7NQNNweq/Ih2ClY/ZqX0ffYc5TxIBNGsivgB3HiRl19x6EFhSM4Rw0PbrprQaKMKo+NjvWNlYyzUOTl0/9GZ2DNIg8wm/U9OsQ1n69j/TGHHeSYJPbcl0SOq62ulkxsyMuzs3LhzdhzGAKjSvL8bfB2BOOFduJ53m3IFaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi7io/92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DD70C4AF19;
	Tue, 30 Apr 2024 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714484434;
	bh=PkaaMUSzHkQlVVSzjRC9SaTkUSeCNsJP/b8Uju28AZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pi7io/92Lfr0vOQezCZ6LJdhFv/BApGh1sHbANh4bCXdYZkaPEu7f6CHsvwW2e+5W
	 2GCzDczsLFgBQR9a+fAVa4ciV6KkDOy2sbhPVTL7UP5PxhrbGlvalwLWlYYjkJOlUi
	 Z26W0hu8gqQnRwYpbQXrOoN4mxzBsQUIvRwFLj7+urO7EdoFwEkaoMsbXTt6eOJOQb
	 v5PCGR0h/6qZfRSCL4ARmtOGfORFw8GZZyykJPkHw/5aH3T8g5xpfvOmarlLxsqBg0
	 h+bVWqDidpVbEz7C2X+8S6BdKe/gWdFMckW/Y2o7Usxi32/gganysDqoAu2hMCs+Be
	 08Daqej6dKwbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73D64C43617;
	Tue, 30 Apr 2024 13:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp-bus: constify link_modes to
 sfp_select_interface()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171448443447.21603.1533307979454648924.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 13:40:34 +0000
References: <E1s15s0-00AHyq-8E@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1s15s0-00AHyq-8E@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 28 Apr 2024 15:51:12 +0100 you wrote:
> sfp_select_interface() does not modify its link_modes argument, so
> make this a const pointer.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/sfp-bus.c | 2 +-
>  include/linux/sfp.h       | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net: sfp-bus: constify link_modes to sfp_select_interface()
    https://git.kernel.org/netdev/net-next/c/5cd9fac3a369

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



