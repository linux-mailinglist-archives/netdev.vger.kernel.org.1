Return-Path: <netdev+bounces-229006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD292BD6ECB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 03:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E3884F70CF
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE350296BA2;
	Tue, 14 Oct 2025 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r69p8+qG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3CD293C42
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404253; cv=none; b=ekCXWOzzvFkbLU5s4e1Zb9Q8k2taBVnhJPZuJGakhZc2C0+JhURCi5XeuI2H8ODVTvvJjpk8iYRaPXkMm4WlSUTBqd4HjYe7kzet4B3IbtDhfTF9j2kEmiRJRCoJC6bWDZy/AUgjGk0RhpzcrWKchx9F9zKzkesYJGqKsg79mWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404253; c=relaxed/simple;
	bh=LdBOAX73ymLmJzTg7k+d6HcgAlyvfkVHgfHylMpBR7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I1jb3u9TEoxnhmLxnwH/GRC8o4TufxHNLrdo/ZIaPhx5mQVim6QuhRoAe7HgpXXWQSZLcvpMHPO2QJAHaN2yOGZXO/Q72kGSH1CTaTcdWJq1Y3Mf5GJ1eJHGYuL7j/pJrAXVJ0Xb43mBip9vHggz0L+qn6Knuhfus891gyu+dXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r69p8+qG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B43CC4AF09;
	Tue, 14 Oct 2025 01:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760404253;
	bh=LdBOAX73ymLmJzTg7k+d6HcgAlyvfkVHgfHylMpBR7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r69p8+qGmHwV7JUGdEGtqTOe+uiPlsWXBRnj1+DHYI+O95xJgSBeCYvI1g2EJT9L2
	 hixX0H/xirfh4FEB29J7lPWPc5WOZrI/FeQPZ/5MwiLYgPRPGF3BXeLsD3LiPy9G8h
	 hl0KS907fum7nZzUnkKKEQ2+E8PJMIunrJEmkjCYKvaLaWbUh1LZw5ouPCKcwdwYBQ
	 0xJGwxCoG/HqKPGGNvLc5ZHLZ9+Ki1gZBvhTzW6xA1rCblMEl6eKmCpXwfGJFS0sb8
	 cB0ZMCBUTbXGsEesnb6up9YtJNzUqhQ246qxF2O2nGnoRM+u7DMjN6ss+P/IP/TdOu
	 Takw1pgkEzvEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB04C380A962;
	Tue, 14 Oct 2025 01:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] net: phy: bcm54811: Fix GMII/MII/MII-Lite
 selection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176040423849.3390136.16300785234730924112.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 01:10:38 +0000
References: <20251009130656.1308237-1-kamilh@axis.com>
In-Reply-To: <20251009130656.1308237-1-kamilh@axis.com>
To: =?utf-8?q?Kamil_Hor=C3=A1k_-_2N_=3Ckamilh=40axis=2Ecom=3E?=@codeaurora.org
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Oct 2025 15:06:55 +0200 you wrote:
> Software RGMII - GMII/MII/MII-Lite selection.
> 
> The bcm54811 PHY needs this bit to be configured in addition to hardware
> strapping of the PHY chip to desired mode.
> 
> This configuration step got lost during the refining of previous patch.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] net: phy: bcm54811: Fix GMII/MII/MII-Lite selection
    https://git.kernel.org/netdev/net/c/e4d0c909bf83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



