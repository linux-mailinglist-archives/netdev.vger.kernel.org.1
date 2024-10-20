Return-Path: <netdev+bounces-137303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1231D9A54FD
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95356B2289E
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F4119645D;
	Sun, 20 Oct 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrpwAjno"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB891946B4
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440635; cv=none; b=qVsiMAqI/cAjK5xJrqqItnmG08b7ulxEDAg18JrP55Xp9fMl7pKIGlg07zLb4ijD0sszGgEntypUrfv93iXv03z/qQDT5x+zHaocZo8YwAkXzo92Cw/O9aqJ04SVjhPGSdFqDlEA5D6itInb5vIR69jK3GwIxSnFaqC76a52f2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440635; c=relaxed/simple;
	bh=3hPw9yoZ0sqsoCqCh2AenGu7zm0oewLWI9GqN4BCVaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hvM2Ghiggpx2h2dbYzW76GCTNC500xZ8c8g9sjTwFdp2xrwi6WJJpAe6A3PPkI72SSDQhYT6PME5/K0uZcLF2bWrtZQOgrHHooOLne/no31PVVE7FH6T6MTQEKQ/gcSIUpkz8a0gSSFvQ2CeHTMG7rC81NgdIk5pMG66GAjbhyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrpwAjno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D91C4CEC6;
	Sun, 20 Oct 2024 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729440635;
	bh=3hPw9yoZ0sqsoCqCh2AenGu7zm0oewLWI9GqN4BCVaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nrpwAjnoAg0TS+90KNoqNovDGdivV3BWNWqsP9vuaIAQc9Se9P59iY6XQz3vrSGP4
	 vp14dLyr+0TZ5u3l5Tex4TzY6uVad9/o8vyDsnm/rwVlsRBHcorl4eRonFw9F98APT
	 URqHFkcfPzBX8cpqY2dmSX43MZhQbXgtYiLfrDgGcQgTZAG1q9dVtWi5OlEsrevmai
	 JBjnDgIfYfb7M8El5AkIOQufkCttyOG4vMDDw/NNH7u9IKT0jelvNaloWrGl15YgWj
	 E9CIkfEGG3jsdfK46Ho+/4c1yEWykN/AyKs/vpByvOTH74vfU+gWej5nHVuVjrUecE
	 o2cNE3dr0y4eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C453805CC0;
	Sun, 20 Oct 2024 16:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: add RTL8125D-internal PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172944064075.3604255.14573313785464628862.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 16:10:40 +0000
References: <7d2924de-053b-44d2-a479-870dc3878170@gmail.com>
In-Reply-To: <7d2924de-053b-44d2-a479-870dc3878170@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Thu, 17 Oct 2024 18:01:13 +0200 you wrote:
> The first boards show up with Realtek's RTL8125D. This MAC/PHY chip
> comes with an integrated 2.5Gbps PHY with ID 0x001cc841. It's not
> clear yet whether there's an external version of this PHY and how
> Realtek calls it, therefore use the numeric id for now.
> 
> Link: https://lore.kernel.org/netdev/2ada65e1-5dfa-456c-9334-2bc51272e9da@gmail.com/T/
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: add RTL8125D-internal PHY
    https://git.kernel.org/netdev/net-next/c/8989bad54113

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



