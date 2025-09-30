Return-Path: <netdev+bounces-227247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922D3BAADDC
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E043C19233E5
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1E31EA7D2;
	Tue, 30 Sep 2025 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDKyGOGo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB92036FE;
	Tue, 30 Sep 2025 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195260; cv=none; b=m7uJ9FAy/hozou2MHfC6bCY4EoMij+frd+iRR09mMj+Jq+wYjt3r/abWKrlfC/B0HIqwObYbgTRnU7rjHJTpWYP1s59J+gWJEBfR1SY40SD7N/hkM1rN0MZVJJHhJBCisgaKil9bR6BjBVvXudB+XP6qJPYoXznyts5By7+GNo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195260; c=relaxed/simple;
	bh=KPLNckw1SeZ45f8MIwocglRI5dFqf0Oyuz66t431vgE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aADZvk5ktJ+SgHwqOn1zDqn7t5a7ouhRvKO9QQODr9VEK1bBDGh/T7XVuNY1nRqRE64Mk5rydAuT8sIxPYh7KmXP6F0pwqV3L4/d9w2kQP5wjzQXGl4z/4vRs1buLbqwaFmqCbFgK29DdiW1/l4Mg1n9wFfZ1YSLGpltUxb0gYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDKyGOGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86086C4CEF4;
	Tue, 30 Sep 2025 01:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195260;
	bh=KPLNckw1SeZ45f8MIwocglRI5dFqf0Oyuz66t431vgE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qDKyGOGo9V+/t1WmwBgV35V9r5OUyoE+vdNXfYwf/W4WB/Cs6sUxGtb0K3JkoGGmH
	 wPCOQyBel+QTPc6MV07HujsuWg/YXoRFo0tpDPNpPnxVjSEoCIvRDplGmmzfbSZ4lf
	 HHAdbu91pGfGEgsBlwvJjs++ZQsYvHuTdq/XoQdnYr59kZ4NbynihjirN2znDAv1oI
	 s7UWAzkAnZDcdqf7ulKyt7ysjFjZZk0jwYNa+mcmBpDqAdtJXtwpApAwyk7sK170XR
	 J+YEpkPgi5xJM522/uSygipm7hE/MwYtj5JyJ4+t9403ZYI7TItDkle9C/EMTIqCav
	 g5qaGcaj3UK0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FCD39D0C1A;
	Tue, 30 Sep 2025 01:20:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs: networking: phy: clarify abbreviation "PAL"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919525374.1775912.11439123001074228976.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:20:53 +0000
References: <20250926131520.222346-1-m.heidelberg@cab.de>
In-Reply-To: <20250926131520.222346-1-m.heidelberg@cab.de>
To: Markus Heidelberg <m.heidelberg@cab.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Sep 2025 15:15:20 +0200 you wrote:
> It is suddenly used in the text without introduction, so the meaning
> might have been unclear to readers.
> 
> Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
> ---
>  Documentation/networking/phy.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - docs: networking: phy: clarify abbreviation "PAL"
    https://git.kernel.org/netdev/net-next/c/29be241d1174

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



