Return-Path: <netdev+bounces-159596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0C6A15FDD
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76795165C33
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2932B191499;
	Sun, 19 Jan 2025 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7MACLrq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6619047F
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737251420; cv=none; b=Md7871vgHhVqGUvwcoeVB5sCtDQcFvdRS1vw65Pt/I9p5adQ9wcmFrNBG6Jw2oKxXVm4ZYCs2UYS4VcL3zc0IYfRECXf7rEF2Z7qBRGqPENRfUk/XmPM9oozXO3RSBGn37alhP9a2zR03G+xswQ0YqRGX0saj81dgRTvmgqdnWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737251420; c=relaxed/simple;
	bh=o9kSTwci2ALx1tj0wtkqeAYMMVxW+8yLxWzMxhKEe6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aczkkFgXmphIj7TkDFikTa9FhqjWv9bC0vk5crXCy3ZivZYN/Mt5j0KAMxyhwhvSJj0Y5qSJKMJ5jTxj+b+DsPKI7oqEYkuCG9nZd+tR40qLFlzfsUOWoaGzAnA6sVoitt7GpKkj9/IfwQsapDjzI82ENKq8ircWXMZhsGTrzqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7MACLrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4954C4CED1;
	Sun, 19 Jan 2025 01:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737251419;
	bh=o9kSTwci2ALx1tj0wtkqeAYMMVxW+8yLxWzMxhKEe6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f7MACLrqHnHTiIop5ZeVCl7IqWwyJRIyYEiEy7WfINXOET1GihAtPnKzNuTWHFdeO
	 v1YZtvukTprfPeF3LeLoosacRkEppoU/e94lvN60Kh0FOSYdW5djwJBwm2KSWW5ZND
	 OKenW3nJXB6wGtEmNnMtSD8Uz1FxO7+3H6IhmEgysR4Ss33DbenDDw/1TTwSIZ6BGw
	 iZuCpd2KC+Z6wLAuhSrC29uu1RYunKAL96X94lLs5g2+O9AuXaC8Wx0H80kY1r21UZ
	 ubefamHjSUIXjowJHSMfeYXPa1EEcZSHxR1Sc/Jh5FAuDhhOmXhl/vkV/B2ILVueaH
	 cBjsyHmPUOWUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF22380AA62;
	Sun, 19 Jan 2025 01:50:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: remove leftovers from switch to linkmode
 bitmaps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725144328.2533015.3564362952152672217.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 01:50:43 +0000
References: <5493b96e-88bb-4230-a911-322659ec5167@gmail.com>
In-Reply-To: <5493b96e-88bb-4230-a911-322659ec5167@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, andrew@lunn.ch, linux@armlinux.org.uk,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 22:38:40 +0100 you wrote:
> We have some leftovers from the switch to linkmode bitmaps which
> - have never been used
> - are not used any longer
> - have no user outside phy_device.c
> So remove them.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: remove leftovers from switch to linkmode bitmaps
    https://git.kernel.org/netdev/net-next/c/12d5151be010

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



